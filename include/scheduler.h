#pragma once

#include <string>
#include <vector>

#include "instruction.h"

namespace sched {

struct ScheduleDecision {
    size_t branch_index{};
    std::string message;
};

struct ScheduleResult {
    std::vector<Instruction> instructions;
    std::vector<ScheduleDecision> decisions;
    std::vector<std::string> diagnostics;
};

ScheduleResult scheduleDelaySlots(const std::vector<Instruction>& input);

}  // namespace sched
