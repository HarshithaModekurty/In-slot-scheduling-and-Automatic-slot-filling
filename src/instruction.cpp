#include "instruction.h"

#include <sstream>
#include <utility>

namespace sched {

namespace {
bool isArithmeticOp(OpCode opcode) {
    switch (opcode) {
        case OpCode::kAdd:
        case OpCode::kAddi:
        case OpCode::kSub:
        case OpCode::kMul:
        case OpCode::kDiv:
        case OpCode::kAnd:
        case OpCode::kOr:
        case OpCode::kXor:
        case OpCode::kSlt:
        case OpCode::kLi:
            return true;
        default:
            return false;
    }
}

std::string opcodeToString(OpCode opcode) {
    switch (opcode) {
        case OpCode::kAdd:
            return "add";
        case OpCode::kAddi:
            return "addi";
        case OpCode::kSub:
            return "sub";
        case OpCode::kMul:
            return "mul";
        case OpCode::kDiv:
            return "div";
        case OpCode::kAnd:
            return "and";
        case OpCode::kOr:
            return "or";
        case OpCode::kXor:
            return "xor";
        case OpCode::kSlt:
            return "slt";
        case OpCode::kLw:
            return "lw";
        case OpCode::kSw:
            return "sw";
        case OpCode::kLi:
            return "li";
        case OpCode::kNop:
            return "nop";
        case OpCode::kBeq:
            return "beq";
        case OpCode::kBne:
            return "bne";
        case OpCode::kJ:
            return "j";
        case OpCode::kLabelOnly:
            return "";
    }
    return "";
}
}  // namespace

bool Instruction::isBranch() const { return opcode == OpCode::kBeq || opcode == OpCode::kBne; }

bool Instruction::isJump() const { return opcode == OpCode::kJ; }

bool Instruction::isControl() const { return isBranch() || isJump(); }

bool Instruction::isMemory() const { return opcode == OpCode::kLw || opcode == OpCode::kSw; }

bool Instruction::isLoad() const { return opcode == OpCode::kLw; }

bool Instruction::isStore() const { return opcode == OpCode::kSw; }

bool Instruction::isArithmetic() const { return isArithmeticOp(opcode); }

bool Instruction::isNop() const { return opcode == OpCode::kNop || opcode == OpCode::kLabelOnly; }

bool Instruction::mayCauseException() const {
    if (isMemory()) {
        return true;  // Loads/stores may fault.
    }
    return false;
}

bool Instruction::definesRegister() const {
    if (opcode == OpCode::kSw || opcode == OpCode::kJ || opcode == OpCode::kBeq || opcode == OpCode::kBne || opcode == OpCode::kLabelOnly || opcode == OpCode::kNop) {
        return false;
    }
    return true;
}

std::optional<std::string> Instruction::definedRegister() const {
    if (!definesRegister()) {
        return std::nullopt;
    }
    if (opcode == OpCode::kLw) {
        return rt;
    }
    if (!rd.empty()) {
        return rd;
    }
    if (!rt.empty() && opcode == OpCode::kAddi) {
        return rt;
    }
    if (opcode == OpCode::kLi) {
        return rt;
    }
    return std::nullopt;
}

std::set<std::string> Instruction::usedRegisters() const {
    std::set<std::string> regs;
    switch (opcode) {
        case OpCode::kAdd:
        case OpCode::kSub:
        case OpCode::kMul:
        case OpCode::kDiv:
        case OpCode::kAnd:
        case OpCode::kOr:
        case OpCode::kXor:
        case OpCode::kSlt:
            if (!rs.empty()) regs.insert(rs);
            if (!rt.empty()) regs.insert(rt);
            break;
        case OpCode::kAddi:
            if (!rs.empty()) regs.insert(rs);
            break;
        case OpCode::kLw:
        case OpCode::kSw:
            if (!rs.empty()) regs.insert(rs);
            if (opcode == OpCode::kSw && !rt.empty()) regs.insert(rt);
            break;
        case OpCode::kLi:
            break;
        case OpCode::kBeq:
        case OpCode::kBne:
            if (!rs.empty()) regs.insert(rs);
            if (!rt.empty()) regs.insert(rt);
            break;
        case OpCode::kJ:
        case OpCode::kNop:
        case OpCode::kLabelOnly:
            break;
    }
    return regs;
}

std::string Instruction::toString() const {
    if (opcode == OpCode::kNop && !label.empty() && original_text == label + ":") {
        return label + ":";
    }
    if (opcode == OpCode::kLabelOnly) {
        return label + ":";
    }

    std::ostringstream oss;
    if (!label.empty()) {
        oss << label << ": ";
    }
    oss << opcodeToString(opcode);
    switch (opcode) {
        case OpCode::kAdd:
        case OpCode::kSub:
        case OpCode::kMul:
        case OpCode::kDiv:
        case OpCode::kAnd:
        case OpCode::kOr:
        case OpCode::kXor:
        case OpCode::kSlt:
            oss << " " << rd << ", " << rs << ", " << rt;
            break;
        case OpCode::kAddi:
            oss << " " << rt << ", " << rs << ", " << immediate;
            break;
        case OpCode::kLw:
        case OpCode::kSw:
            oss << " " << rt << ", " << immediate << "(" << rs << ")";
            break;
        case OpCode::kLi:
            oss << " " << rt << ", " << immediate;
            break;
        case OpCode::kBeq:
        case OpCode::kBne:
            oss << " " << rs << ", " << rt << ", " << target_label;
            break;
        case OpCode::kJ:
            oss << " " << target_label;
            break;
        case OpCode::kNop:
            break;
        case OpCode::kLabelOnly:
            break;
    }
    return oss.str();
}

}  // namespace sched
