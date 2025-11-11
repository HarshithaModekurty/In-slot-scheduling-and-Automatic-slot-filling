#include "pipeline_sim.h"

#include <iomanip>
#include <sstream>
#include <unordered_map>

namespace sched {
namespace {

struct StageInfo {
    size_t if_cycle{};
    size_t id_cycle{};
    size_t ex_cycle{};
    size_t mem_cycle{};
    size_t wb_cycle{};
    size_t stalls{};
    std::string text;
};

struct MachineState {
    std::unordered_map<std::string, int> registers;
    std::unordered_map<int, int> memory;
};

StageInfo scheduleInstruction(const Instruction& inst,
                              size_t& next_if_cycle,
                              std::unordered_map<std::string, size_t>& reg_ready,
                              size_t& memory_ready_cycle,
                              std::vector<std::string>& diagnostics) {
    size_t if_cycle = next_if_cycle + 1;
    size_t id_cycle = if_cycle + 1;
    size_t ex_cycle = id_cycle + 1;
    size_t mem_cycle = ex_cycle + 1;
    size_t wb_cycle = mem_cycle + 1;
    size_t stall_cycles = 0;

    const auto uses = inst.usedRegisters();
    for (const auto& reg : uses) {
        auto it = reg_ready.find(reg);
        if (it != reg_ready.end() && id_cycle < it->second) {
            size_t needed = it->second - id_cycle;
            stall_cycles = std::max(stall_cycles, needed);
        }
    }

    if (inst.isMemory() && mem_cycle < memory_ready_cycle) {
        size_t needed = memory_ready_cycle - mem_cycle;
        stall_cycles = std::max(stall_cycles, needed);
    }

    if (stall_cycles > 0) {
        if_cycle += stall_cycles;
        id_cycle += stall_cycles;
        ex_cycle += stall_cycles;
        mem_cycle += stall_cycles;
        wb_cycle += stall_cycles;
        std::ostringstream oss;
        oss << "Inserted " << stall_cycles << " stall cycle(s) before instruction '" << inst.toString() << "' due to hazards.";
        diagnostics.push_back(oss.str());
    }

    if (inst.isMemory()) {
        memory_ready_cycle = mem_cycle + 1;
    }

    if (auto def = inst.definedRegister()) {
        size_t ready_cycle = inst.isLoad() ? mem_cycle + 1 : ex_cycle + 1;
        reg_ready[*def] = ready_cycle;
    }

    next_if_cycle = if_cycle;
    StageInfo info{if_cycle, id_cycle, ex_cycle, mem_cycle, wb_cycle, stall_cycles, inst.toString()};
    return info;
}

int readRegister(const MachineState& state, const std::string& reg) {
    auto it = state.registers.find(reg);
    if (it == state.registers.end()) {
        return 0;
    }
    return it->second;
}

void writeRegister(MachineState& state, const std::string& reg, int value) {
    if (reg.empty()) {
        return;
    }
    state.registers[reg] = value;
}

int executeArithmetic(OpCode opcode, int lhs, int rhs) {
    switch (opcode) {
        case OpCode::kAdd:
            return lhs + rhs;
        case OpCode::kSub:
            return lhs - rhs;
        case OpCode::kMul:
            return lhs * rhs;
        case OpCode::kDiv:
            return rhs == 0 ? 0 : lhs / rhs;
        case OpCode::kAnd:
            return lhs & rhs;
        case OpCode::kOr:
            return lhs | rhs;
        case OpCode::kXor:
            return lhs ^ rhs;
        case OpCode::kSlt:
            return lhs < rhs ? 1 : 0;
        default:
            return 0;
    }
}

}  // namespace

PipelineResult runPipeline(const std::vector<Instruction>& program, const PipelineOptions& options) {
    PipelineResult result;
    if (program.empty()) {
        return result;
    }

    MachineState state;
    size_t next_if_cycle = 0;
    std::unordered_map<std::string, size_t> reg_ready_cycle;
    size_t memory_ready_cycle = 0;

    size_t pc = 0;
    bool branch_pending = false;
    size_t branch_target = 0;
    size_t branch_delay_slot = 0;

    size_t instructions_executed = 0;

    while (pc < program.size()) {
        if (instructions_executed >= options.max_cycles) {
            result.diagnostics.push_back("Maximum instruction budget reached during simulation.");
            break;
        }

        const Instruction& inst = program[pc];
        StageInfo stage = scheduleInstruction(inst, next_if_cycle, reg_ready_cycle, memory_ready_cycle, result.diagnostics);

        std::ostringstream timeline_entry;
        timeline_entry << "IF@" << stage.if_cycle << " ID@" << stage.id_cycle << " EX@" << stage.ex_cycle
                       << " MEM@" << stage.mem_cycle << " WB@" << stage.wb_cycle << " :: " << inst.toString();
        result.timeline.push_back({stage.if_cycle, timeline_entry.str()});
        result.executed_program.push_back(inst);

        bool branch_taken = false;
        if (inst.isArithmetic()) {
            int lhs = readRegister(state, inst.rs);
            int rhs = readRegister(state, inst.rt);
            if (inst.opcode == OpCode::kAddi) {
                rhs = inst.immediate;
                writeRegister(state, inst.rt, lhs + rhs);
            } else if (inst.opcode == OpCode::kLi) {
                writeRegister(state, inst.rt, inst.immediate);
            } else {
                int result_value = executeArithmetic(inst.opcode, lhs, rhs);
                writeRegister(state, inst.rd.empty() ? inst.rt : inst.rd, result_value);
            }
        } else if (inst.isLoad()) {
            int base = readRegister(state, inst.rs);
            int addr = base + inst.immediate;
            int value = 0;
            auto it = state.memory.find(addr);
            if (it != state.memory.end()) {
                value = it->second;
            }
            writeRegister(state, inst.rt, value);
        } else if (inst.isStore()) {
            int base = readRegister(state, inst.rs);
            int addr = base + inst.immediate;
            int value = readRegister(state, inst.rt);
            state.memory[addr] = value;
        } else if (inst.isBranch()) {
            int lhs = readRegister(state, inst.rs);
            int rhs = readRegister(state, inst.rt);
            if (inst.opcode == OpCode::kBeq) {
                branch_taken = lhs == rhs;
            } else if (inst.opcode == OpCode::kBne) {
                branch_taken = lhs != rhs;
            }
            if (!inst.target_index) {
                result.diagnostics.push_back("Branch with unresolved target: " + inst.toString());
            }
            branch_pending = true;
            branch_target = branch_taken ? inst.target_index.value_or(pc + 2) : pc + 2;
            branch_delay_slot = pc + 1;
            if (branch_delay_slot >= program.size()) {
                branch_pending = false;
                pc = branch_target;
                ++instructions_executed;
                continue;
            }
        } else if (inst.isJump()) {
            branch_pending = true;
            branch_taken = true;
            branch_target = inst.target_index.value_or(pc + 1);
            branch_delay_slot = pc + 1;
            if (branch_delay_slot >= program.size()) {
                branch_pending = false;
                pc = branch_target;
                ++instructions_executed;
                continue;
            }
        }

        if (branch_pending && pc == branch_delay_slot) {
            branch_pending = false;
            pc = branch_target;
        } else {
            ++pc;
        }
        ++instructions_executed;
    }

    if (branch_pending) {
        result.diagnostics.push_back("Simulation ended while branch target pending. Check program termination conditions.");
    }

    return result;
}

}  // namespace sched
