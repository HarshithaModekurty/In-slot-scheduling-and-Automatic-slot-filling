#include <iostream>

#include "parser.h"
#include "scheduler.h"

int main(int argc, char** argv) {
    if (argc < 2) {
        std::cerr << "Usage: " << argv[0] << " <assembly file>\n";
        return 1;
    }

    const std::string path = argv[1];
    sched::Program program = sched::parseAssemblyFile(path);
    for (const auto& diag : program.diagnostics) {
        std::cerr << "[parser] " << diag << "\n";
    }

    auto result = sched::scheduleDelaySlots(program.instructions);
    for (const auto& diag : result.diagnostics) {
        std::cerr << "[scheduler] " << diag << "\n";
    }
    for (const auto& decision : result.decisions) {
        std::cerr << "[decision] " << decision.message << "\n";
    }

    for (const auto& inst : result.instructions) {
        std::cout << inst.toString() << "\n";
    }

    return 0;
}
