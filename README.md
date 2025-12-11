# Delayed Branch Scheduling Project

This project provides a reference implementation of delayed branch slot handling with automatic instruction scheduling for a simple MIPS-like pipeline. The simulator and tools are written in C++ and focus on the core requirements from the course project specification:

* Analyse instruction sequences and automatically fill branch delay slots with independent instructions when safe.
* Allow manual scheduling annotations so that hand-written delay slots can be compared with the automated approach.
* Simulate a five-stage pipeline (IF, ID, EX, MEM, WB) including the behaviour of branch delay slots and hazard detection.
* Check hardware constraints and report hazards such as register dependencies, memory ordering issues, and potential exception-raising instructions moved into delay slots.
* Provide test benches that exercise both manually scheduled assembly and automatically scheduled output generated from a C program compiled with custom flags.

The repository contains:

* `include/` – C++ headers for the simulator, parser, and scheduler.
* `src/` – C++ sources implementing the pipeline simulator, instruction parser, scheduler, and command-line tools.
* `data/` – Example assembly snippets and a reference C program used for experimentation.
* `tests/` – Input/output pairs and regression tests for the tooling.

## Building

A minimal CMake configuration is supplied. To build the tools:

```bash
cmake -S . -B build
cmake --build build
```

This produces two executables:

* `build/schedule_tool` – Reads assembly, performs automatic delay-slot scheduling, and prints the transformed program.
* `build/pipeline_sim` – Simulates pipeline execution for a program (manual or scheduled) and reports hazard/exception diagnostics.

## Running the Examples

1. **Automatic scheduling**

   ```bash
   build/schedule_tool data/example_auto_input.asm
   ```

   The tool prints the scheduled assembly while documenting decisions made for each branch instruction.

2. **Manual vs automatic comparison**

   ```bash
   build/schedule_tool data/example_auto_input.asm > /tmp/scheduled.asm
   build/pipeline_sim data/example_manual.asm
   build/pipeline_sim /tmp/scheduled.asm
   ```

   Both executions output per-cycle pipeline traces together with warnings about hazards or constraint violations. Use these traces to verify that manual and automatic schedules produce identical architectural effects.

## Repository Tour

* `include/instruction.h` – Defines the instruction representation, opcodes, and helper utilities.
* `include/parser.h` – Interface for parsing assembly files into instruction streams.
* `include/scheduler.h` – Scheduling API that analyses dependency graphs and fills delay slots.
* `include/pipeline_sim.h` – Pipeline simulator API including hazard detection and exception modelling.
* `src/` – Corresponding implementations and the two CLI entry points.
* `tests/` – Contains unit-test style drivers (gtest-free) executed through CTest.

## Extending the Project

* Extend the ISA: add more instructions in `instruction.h` and update the parser and simulator accordingly.
* Improve scheduling heuristics by analysing across basic blocks or using data-flow analysis.
* Integrate with a real compiler by emitting the scheduled assembly back into standard formats.

## License

This educational reference is released into the public domain. Adapt it freely for coursework, experiments, or demonstrations.
