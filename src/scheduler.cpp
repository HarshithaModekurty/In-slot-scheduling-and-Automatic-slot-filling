#include "scheduler.h"

#include <algorithm>
#include <sstream>
#include <unordered_map>

namespace sched {
namespace {

bool hasLabelBetween(const std::vector<Instruction>& insts, size_t start, size_t end) {
    for (size_t i = start; i < end; ++i) {
        if (insts[i].hasLabel()) {
            return true;
        }
    }
    return false;
}

std::unordered_map<std::string, size_t> buildLabelMap(const std::vector<Instruction>& insts) {
    std::unordered_map<std::string, size_t> label_map;
    for (size_t i = 0; i < insts.size(); ++i) {
        if (insts[i].hasLabel()) {
            label_map[insts[i].label] = i;
        }
    }
    return label_map;
}

void resolveTargets(std::vector<Instruction>& insts) {
    auto label_map = buildLabelMap(insts);
    for (auto& inst : insts) {
        if (inst.isControl()) {
            auto it = label_map.find(inst.target_label);
            if (it != label_map.end()) {
                inst.target_index = it->second;
            } else {
                inst.target_index.reset();
            }
        }
    }
}

bool dependenciesBlockMove(const Instruction& candidate,
                            const std::vector<Instruction>& insts,
                            size_t branch_index,
                            size_t candidate_index) {
    auto cand_defs = candidate.definedRegister();
    auto cand_uses = candidate.usedRegisters();

    std::set<std::string> defs_between;
    std::set<std::string> uses_between;
    bool memory_between = false;

    for (size_t i = branch_index + 1; i < candidate_index; ++i) {
        const auto& middle = insts[i];
        if (middle.isControl()) {
            return true;
        }
        if (middle.hasLabel()) {
            return true;
        }
        if (middle.isMemory()) {
            memory_between = true;
        }
        auto def = middle.definedRegister();
        if (def) {
            defs_between.insert(*def);
        }
        auto uses = middle.usedRegisters();
        uses_between.insert(uses.begin(), uses.end());
    }

    for (const auto& reg : cand_uses) {
        if (defs_between.count(reg)) {
            return true;
        }
    }

    if (cand_defs) {
        if (uses_between.count(*cand_defs) || defs_between.count(*cand_defs)) {
            return true;
        }
    }

    if (candidate.isMemory() && memory_between) {
        return true;
    }

    return false;
}

bool isAcceptableDelaySlotInstruction(const Instruction& inst) {
    if (inst.isControl()) {
        return false;
    }
    if (inst.isNop()) {
        return false;
    }
    if (inst.mayCauseException()) {
        return false;
    }
    return true;
}

}  // namespace

ScheduleResult scheduleDelaySlots(const std::vector<Instruction>& input) {
    ScheduleResult result;
    result.instructions = input;

    for (size_t i = 0; i < result.instructions.size(); ++i) {
        auto& inst = result.instructions[i];
        if (!inst.isControl()) {
            continue;
        }

        size_t slot_index = i + 1;
        if (slot_index < result.instructions.size()) {
            auto& next = result.instructions[slot_index];
            if (!next.isNop()) {
                next.manually_filled = true;
                std::ostringstream oss;
                oss << "branch at index " << i << " keeps manual delay slot: " << next.toString();
                result.decisions.push_back({i, oss.str()});
                continue;
            }
        } else {
            Instruction nop;
            nop.opcode = OpCode::kNop;
            result.instructions.push_back(nop);
        }

        if (slot_index >= result.instructions.size()) {
            Instruction nop;
            nop.opcode = OpCode::kNop;
            result.instructions.push_back(nop);
        }

        bool filled = false;
        for (size_t candidate_index = slot_index + 1; candidate_index < result.instructions.size(); ++candidate_index) {
            auto& candidate = result.instructions[candidate_index];
            if (candidate.hasLabel() && candidate_index != slot_index) {
                break;
            }
            if (!isAcceptableDelaySlotInstruction(candidate)) {
                continue;
            }
            if (dependenciesBlockMove(candidate, result.instructions, i, candidate_index)) {
                continue;
            }

            Instruction moved = candidate;
            result.instructions.erase(result.instructions.begin() + candidate_index);
            result.instructions.insert(result.instructions.begin() + slot_index, moved);
            std::ostringstream oss;
            oss << "branch at index " << i << " filled delay slot with instruction originally at index "
                << candidate_index << ": " << moved.toString();
            result.decisions.push_back({i, oss.str()});
            filled = true;
            break;
        }

        if (!filled) {
            std::ostringstream oss;
            oss << "branch at index " << i << " uses nop (no safe instruction found)";
            result.decisions.push_back({i, oss.str()});
            if (slot_index < result.instructions.size()) {
                result.instructions[slot_index].opcode = OpCode::kNop;
            } else {
                Instruction nop;
                nop.opcode = OpCode::kNop;
                result.instructions.push_back(nop);
            }
        }
    }

    resolveTargets(result.instructions);
    return result;
}

}  // namespace sched
