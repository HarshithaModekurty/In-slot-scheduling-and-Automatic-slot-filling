#pragma once

#include <string>
#include <vector>

#include "instruction.h"

namespace sched {

struct PipelineOptions {
    bool verbose{true};
    size_t max_cycles{1000};
};

struct PipelineEvent {
    size_t cycle{};
    std::string description;
};

struct PipelineResult {
    std::vector<PipelineEvent> timeline;
    std::vector<std::string> diagnostics;
    std::vector<Instruction> executed_program;
};

PipelineResult runPipeline(const std::vector<Instruction>& program, const PipelineOptions& options = {});

}  // namespace sched
