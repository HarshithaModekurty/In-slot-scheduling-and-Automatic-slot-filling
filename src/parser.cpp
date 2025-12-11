#include "parser.h"

#include <algorithm>
#include <cctype>
#include <fstream>
#include <sstream>
#include <unordered_map>

namespace sched {
namespace {

std::string trim(const std::string& s) {
    auto begin = s.find_first_not_of(" \t\r\n");
    if (begin == std::string::npos) {
        return "";
    }
    auto end = s.find_last_not_of(" \t\r\n");
    return s.substr(begin, end - begin + 1);
}

std::vector<std::string> splitOperands(const std::string& input) {
    std::vector<std::string> tokens;
    std::string current;
    bool in_paren = false;
    for (char ch : input) {
        if (ch == '(') {
            in_paren = true;
            current.push_back(ch);
        } else if (ch == ')') {
            in_paren = false;
            current.push_back(ch);
        } else if (ch == ',' && !in_paren) {
            tokens.push_back(trim(current));
            current.clear();
        } else {
            current.push_back(ch);
        }
    }
    if (!current.empty()) {
        tokens.push_back(trim(current));
    }
    return tokens;
}

bool parseRegisterImmediate(const std::string& operand, std::string& reg, int& imm, Program& program) {
    auto left = operand.find('(');
    auto right = operand.find(')');
    if (left == std::string::npos || right == std::string::npos || right <= left) {
        program.diagnostics.push_back("Malformed memory operand: " + operand);
        return false;
    }
    std::string imm_str = trim(operand.substr(0, left));
    std::string reg_str = trim(operand.substr(left + 1, right - left - 1));
    try {
        imm = std::stoi(imm_str);
    } catch (const std::exception&) {
        program.diagnostics.push_back("Invalid immediate: " + imm_str);
        return false;
    }
    reg = reg_str;
    return true;
}

OpCode parseOpcode(const std::string& op, Program& program) {
    std::string lower = op;
    std::transform(lower.begin(), lower.end(), lower.begin(), [](unsigned char c) { return static_cast<char>(std::tolower(c)); });
    if (lower == "add") return OpCode::kAdd;
    if (lower == "addi") return OpCode::kAddi;
    if (lower == "sub") return OpCode::kSub;
    if (lower == "mul") return OpCode::kMul;
    if (lower == "div") return OpCode::kDiv;
    if (lower == "and") return OpCode::kAnd;
    if (lower == "or") return OpCode::kOr;
    if (lower == "xor") return OpCode::kXor;
    if (lower == "slt") return OpCode::kSlt;
    if (lower == "lw") return OpCode::kLw;
    if (lower == "sw") return OpCode::kSw;
    if (lower == "li") return OpCode::kLi;
    if (lower == "nop") return OpCode::kNop;
    if (lower == "beq") return OpCode::kBeq;
    if (lower == "bne") return OpCode::kBne;
    if (lower == "j") return OpCode::kJ;
    program.diagnostics.push_back("Unknown opcode: " + op);
    return OpCode::kNop;
}

void resolveTargets(Program& program, const std::unordered_map<std::string, size_t>& label_map) {
    for (auto& inst : program.instructions) {
        if (inst.isControl()) {
            auto it = label_map.find(inst.target_label);
            if (it == label_map.end()) {
                program.diagnostics.push_back("Unknown label target: " + inst.target_label);
            } else {
                inst.target_index = it->second;
            }
        }
    }
}

}  // namespace

Program parseAssemblyString(const std::string& source) {
    Program program;
    std::istringstream iss(source);
    std::string line;
    std::vector<std::string> pending_labels;

    while (std::getline(iss, line)) {
        auto comment_pos_hash = line.find('#');
        auto comment_pos_slash = line.find("//");
        size_t comment_pos = std::string::npos;
        if (comment_pos_hash != std::string::npos) {
            comment_pos = comment_pos_hash;
        }
        if (comment_pos_slash != std::string::npos) {
            comment_pos = std::min(comment_pos == std::string::npos ? comment_pos_slash : comment_pos, comment_pos_slash);
        }
        if (comment_pos != std::string::npos) {
            line = line.substr(0, comment_pos);
        }
        line = trim(line);
        if (line.empty()) {
            continue;
        }

        if (line.back() == ':') {
            pending_labels.push_back(trim(line.substr(0, line.size() - 1)));
            continue;
        }

        std::istringstream tokenizer(line);
        std::string opcode_token;
        tokenizer >> opcode_token;
        std::string operand_str;
        std::getline(tokenizer, operand_str);
        operand_str = trim(operand_str);
        Instruction inst;
        inst.opcode = parseOpcode(opcode_token, program);
        inst.original_text = line;

        if (!pending_labels.empty()) {
            inst.label = pending_labels.front();
            pending_labels.erase(pending_labels.begin());
            while (!pending_labels.empty()) {
                Instruction label_inst;
                label_inst.opcode = OpCode::kNop;
                label_inst.label = pending_labels.front();
                label_inst.original_text = pending_labels.front() + ":";
                program.instructions.push_back(label_inst);
                pending_labels.erase(pending_labels.begin());
            }
        }

        auto operands = splitOperands(operand_str);
        switch (inst.opcode) {
            case OpCode::kAdd:
            case OpCode::kSub:
            case OpCode::kMul:
            case OpCode::kDiv:
            case OpCode::kAnd:
            case OpCode::kOr:
            case OpCode::kXor:
            case OpCode::kSlt:
                if (operands.size() != 3) {
                    program.diagnostics.push_back("Expected three operands for " + opcode_token);
                } else {
                    inst.rd = operands[0];
                    inst.rs = operands[1];
                    inst.rt = operands[2];
                }
                break;
            case OpCode::kAddi:
                if (operands.size() != 3) {
                    program.diagnostics.push_back("Expected three operands for addi");
                } else {
                    inst.rt = operands[0];
                    inst.rs = operands[1];
                    try {
                        inst.immediate = std::stoi(operands[2]);
                        inst.has_immediate = true;
                    } catch (const std::exception&) {
                        program.diagnostics.push_back("Invalid immediate: " + operands[2]);
                    }
                }
                break;
            case OpCode::kLw:
            case OpCode::kSw:
                if (operands.size() != 2) {
                    program.diagnostics.push_back("Expected two operands for load/store");
                } else {
                    inst.rt = operands[0];
                    if (!parseRegisterImmediate(operands[1], inst.rs, inst.immediate, program)) {
                        inst.rs.clear();
                    } else {
                        inst.has_immediate = true;
                    }
                }
                break;
            case OpCode::kLi:
                if (operands.size() != 2) {
                    program.diagnostics.push_back("Expected two operands for li");
                } else {
                    inst.rt = operands[0];
                    try {
                        inst.immediate = std::stoi(operands[1]);
                        inst.has_immediate = true;
                    } catch (const std::exception&) {
                        program.diagnostics.push_back("Invalid immediate: " + operands[1]);
                    }
                }
                break;
            case OpCode::kBeq:
            case OpCode::kBne:
                if (operands.size() != 3) {
                    program.diagnostics.push_back("Expected three operands for branch");
                } else {
                    inst.rs = operands[0];
                    inst.rt = operands[1];
                    inst.target_label = operands[2];
                }
                break;
            case OpCode::kJ:
                if (operands.size() != 1) {
                    program.diagnostics.push_back("Expected target label for jump");
                } else {
                    inst.target_label = operands[0];
                }
                break;
            case OpCode::kNop:
            case OpCode::kLabelOnly:
                break;
        }
        program.instructions.push_back(inst);
    }

    if (!pending_labels.empty()) {
        for (const auto& label : pending_labels) {
            Instruction label_inst;
            label_inst.opcode = OpCode::kNop;
            label_inst.label = label;
            label_inst.original_text = label + ":";
            program.instructions.push_back(label_inst);
        }
    }

    std::unordered_map<std::string, size_t> label_map;
    for (size_t i = 0; i < program.instructions.size(); ++i) {
        const auto& inst = program.instructions[i];
        if (inst.hasLabel()) {
            label_map[inst.label] = i;
        }
    }
    resolveTargets(program, label_map);
    return program;
}

Program parseAssemblyFile(const std::string& path) {
    std::ifstream file(path);
    if (!file) {
        Program program;
        program.diagnostics.push_back("Unable to open file: " + path);
        return program;
    }
    std::ostringstream buffer;
    buffer << file.rdbuf();
    return parseAssemblyString(buffer.str());
}

}  // namespace sched
