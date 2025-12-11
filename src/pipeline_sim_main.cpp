#include <iostream>

#include "parser.h"
#include "pipeline_sim.h"

int main(int argc, char** argv) {
    if (argc < 2) {
        std::cerr << "Usage: " << argv[0] << " <assembly file> [max_instructions]\n";
        return 1;
    }

    const std::string path = argv[1];
    sched::Program program = sched::parseAssemblyFile(path);
    for (const auto& diag : program.diagnostics) {
        std::cerr << "[parser] " << diag << "\n";
    }

    sched::PipelineOptions options;
    if (argc >= 3) {
        options.max_cycles = static_cast<size_t>(std::stoul(argv[2]));
    }

    auto result = sched::runPipeline(program.instructions, options);
    for (const auto& diag : result.diagnostics) {
        std::cerr << "[sim] " << diag << "\n";
    }

    for (const auto& event : result.timeline) {
        std::cout << event.description << "\n";
    }

    return 0;
}
