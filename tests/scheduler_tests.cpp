#include <iostream>
#include <limits>

#include "parser.h"
#include "scheduler.h"

using sched::Instruction;
using sched::OpCode;

bool testAutomaticFill() {
    const char* source = R"(start:
    add $s5, $s5, $s6
    add $s2, $s2, $s3
    beq $t0, $t1, target
    nop
    add $s0, $s1, $s2
 target:
    add $s4, $s4, $s0
)";

    auto program = sched::parseAssemblyString(source);
    auto result = sched::scheduleDelaySlots(program.instructions);

    if (result.instructions.size() < 5) {
        std::cerr << "Program shorter than expected after scheduling\n";
        return false;
    }

    // Find branch instruction index.
    size_t branch_index = 0;
    for (size_t i = 0; i < result.instructions.size(); ++i) {
        if (result.instructions[i].opcode == OpCode::kBeq) {
            branch_index = i;
            break;
        }
    }

    if (branch_index + 1 >= result.instructions.size()) {
        std::cerr << "Delay slot missing after scheduling\n";
        return false;
    }

    const auto& slot = result.instructions[branch_index + 1];
    if (slot.opcode != OpCode::kAdd) {
        std::cerr << "Expected add in delay slot, found: " << slot.toString() << "\n";
        return false;
    }

    return true;
}

bool testManualPreserved() {
    const char* source = R"(    li $t0, 0
    beq $t0, $t0, done
    add $s0, $s0, $s1
 done:
    nop
)";

    auto program = sched::parseAssemblyString(source);
    auto result = sched::scheduleDelaySlots(program.instructions);

    size_t branch_index = 0;
    for (size_t i = 0; i < result.instructions.size(); ++i) {
        if (result.instructions[i].opcode == OpCode::kBeq) {
            branch_index = i;
            break;
        }
    }

    if (branch_index + 1 >= result.instructions.size()) {
        std::cerr << "Delay slot missing in manual test\n";
        return false;
    }

    const auto& slot = result.instructions[branch_index + 1];
    if (slot.opcode != OpCode::kAdd) {
        std::cerr << "Manual slot should remain add, got " << slot.toString() << "\n";
        return false;
    }

    return true;
}

bool testDoesNotMoveFallThrough() {
    const char* source = R"(start:
    li $t0, 0
    li $t1, 10
    li $s0, 0
loop:
    addi $t0, $t0, 1
    beq $t0, $t1, exit
    nop
    add $s0, $s0, $t0
    j loop
    nop
exit:
    add $v0, $s0, $zero
)";

    auto program = sched::parseAssemblyString(source);
    auto result = sched::scheduleDelaySlots(program.instructions);

    size_t branch_index = std::numeric_limits<size_t>::max();
    for (size_t i = 0; i < result.instructions.size(); ++i) {
        if (result.instructions[i].opcode == OpCode::kBeq) {
            branch_index = i;
            break;
        }
    }

    if (branch_index == std::numeric_limits<size_t>::max()) {
        std::cerr << "Failed to find beq in fall-through test\n";
        return false;
    }

    if (branch_index + 1 >= result.instructions.size()) {
        std::cerr << "Delay slot missing in fall-through test\n";
        return false;
    }

    const auto& slot = result.instructions[branch_index + 1];
    if (!slot.isNop()) {
        std::cerr << "Expected nop delay slot when no safe instruction exists, found "
                  << slot.toString() << "\n";
        return false;
    }

    return true;
}

int main() {
    bool ok = true;
    ok &= testAutomaticFill();
    ok &= testManualPreserved();
    ok &= testDoesNotMoveFallThrough();
    if (!ok) {
        std::cerr << "Scheduler tests failed\n";
        return 1;
    }
    std::cout << "All scheduler tests passed\n";
    return 0;
}
