#pragma once

#include <optional>
#include <set>
#include <string>
#include <vector>

namespace sched {

enum class OpCode {
    kAdd,
    kAddi,
    kSub,
    kMul,
    kDiv,
    kAnd,
    kOr,
    kXor,
    kSlt,
    kLw,
    kSw,
    kLi,
    kNop,
    kBeq,
    kBne,
    kJ,
    kLabelOnly
};

struct Instruction {
    OpCode opcode{OpCode::kNop};
    std::string original_text;          // Original line for diagnostics.
    std::string label;                  // Optional label bound to this instruction.
    std::string rd;
    std::string rs;
    std::string rt;
    int immediate{0};
    bool has_immediate{false};
    std::string target_label;           // Branch or jump target label.
    std::optional<size_t> target_index; // Resolved program index.
    bool manually_filled{false};        // Indicates user supplied delay-slot instruction.

    [[nodiscard]] bool isBranch() const;
    [[nodiscard]] bool isJump() const;
    [[nodiscard]] bool isControl() const;
    [[nodiscard]] bool isMemory() const;
    [[nodiscard]] bool isLoad() const;
    [[nodiscard]] bool isStore() const;
    [[nodiscard]] bool isArithmetic() const;
    [[nodiscard]] bool isNop() const;
    [[nodiscard]] bool mayCauseException() const;
    [[nodiscard]] bool definesRegister() const;
    [[nodiscard]] std::optional<std::string> definedRegister() const;
    [[nodiscard]] std::set<std::string> usedRegisters() const;
    [[nodiscard]] bool hasLabel() const { return !label.empty(); }
    [[nodiscard]] std::string toString() const;
};

struct Program {
    std::vector<Instruction> instructions;
    std::vector<std::string> diagnostics;
};

}  // namespace sched
