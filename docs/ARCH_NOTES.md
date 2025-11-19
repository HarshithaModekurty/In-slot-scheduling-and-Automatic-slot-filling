# Delayed Branch Core – Architecture Notes

These notes summarize the current state of the “Delayed Branch with In-Slot Scheduling and Automatic Slot Filling” project. They reflect the RTL as of the latest commit (forwarding enabled, scheduler wait logic, annotated statistics).

```
        ┌─────────┐   ┌─────────┐   ┌─────────┐   ┌─────────┐   ┌─────────┐
PC ---> | IF/BUF  |-->| ID/DEC  |-->| EX/ALU  |-->| MEM/L-S |-->| WB/REG  |
        | +2-slot |   | +sched  |   | +BR RES |   |         |   | WRITE   |
        └─────────┘   └─────────┘   └─────────┘   └─────────┘   └─────────┘
```

## 1. Pipeline Overview

- **Five stages**: instruction fetch (IF), decode (ID), execute (EX), memory (MEM), write-back (WB).
- **Register file**: 32 × 32-bit, `r0` hardwired to zero (`rtl/reg_file.v`).
- **Memories**: instruction ROM (`rtl/instruction_memory.v`, async read) and data RAM (`rtl/data_memory.v`, sync read/write), both single-cycle abstractions.
- **Hazards**:
  - Load-use hazards handled by `rtl/hazard_unit.v`, which stalls IF/ID when EX reads from memory and ID consumes the same register.
  - Forwarding now implemented in `cpu_pipeline.v`: EX selects between register file outputs, EX/MEM ALU result, or MEM/WB write-back data.
  - Scheduler-induced waits: if the scheduler needs `cand1` metadata, IF/ID stall for one cycle via `scheduler_wait`.

## 2. Delayed Branch Semantics

- Branches/jumps resolve in EX (`branch_unit`). The instruction following the branch in program order is the architectural delay slot and always executes.
- IF continuously fetches sequential PCs; branch redirect happens only after the delay-slot cycle is scheduled.
- The delay-slot scheduler may replace the architecturally sequential instruction with a safe candidate drawn from the look-ahead buffer, but the architectural effect is still “branch → delay-slot → target”.
- Branch penalty: 1 cycle when slot filled with useful work, otherwise 1 cycle for forced NOP (still cheaper than full flush).

## 3. Hardware In-Slot Scheduler Placement

```
          ┌───────────────────────────────┐
          │ delay_slot_scheduler (ID comb)│
          └───────────┬───────────────────┘
                      │ branch metadata
                      │ cand0/cand1 metadata
                ┌─────┴─────┐
                │ IF buffer │
                │ slot0/1   │
                └─────┬─────┘
                      │
               ┌──────┴──────┐
               │ IF pipeline │
               └─────────────┘
```

- IF stage maintains a two-entry buffer (`slot0`, `slot1`) exposing `cand0_*` and `cand1_*` signals.
- Scheduler runs combinationally in ID, receiving branch metadata (`branch_pc`, `branch_rs/rt`, direction hint) and candidate descriptors.
- Decisions:
  1. **Manual slot**: `cand0` is already safe → no extra control.
  2. **Auto slot**: `cand1` safe → scheduler waits until metadata valid (one-cycle stall), then issues `auto_slot_use` and `kill_cand1`.
  3. **Force NOP**: No safe candidate → pipeline injects `NOP`.
- Control signals from scheduler propagate through ID/EX registers (`id_ex_slot_mode`, `id_ex_slot_auto_instr`, etc.) so EX can inject the delay-slot instruction at the right time.

## 4. Safety & Constraint Model

1. **Control isolation**: scheduler rejects BEQ/BNE/J as slot fillers.
2. **Register hazards**: `safe_candidate` ensures candidate does not write `branch_rs` or `branch_rt`.
3. **Memory ordering**: loads/stores marked unsafe; scheduler never moves them.
4. **Basic-block boundary**: scheduler only promotes instructions within the same block (`branch_is_backward` + PC comparisons).
5. **Metadata wait**: if `cand1_valid` is low but could become safe, scheduler asserts `wait_for_more_candidates`, stalling IF/ID so the decision uses complete data.

## 5. Data Path Hooks & Signals

- **IF buffer** (`rtl/if_stage.v`):
  - Provides `if_instr` to pipeline and candidate metadata to scheduler.
  - Responds to `kill_cand1` by clearing slot1 valid bit so promoted instruction is removed.
- **Slot control** (`cpu_pipeline.v`):
  - `slot_mode_id` encodes MANUAL/AUTO/NOP.
  - `slot_cycle_pending` pulses when a branch resides in EX.
  - `slot_inject_active` asserts only for AUTO or forced NOP, freezing IF and replacing ID inputs with the selected instruction (`slot_inject_instr`) and PC.
  - Manual slots flow naturally; IF/ID continue without injection.
- **Statistics & Debug**:
  - Counters: `stat_cycle_count`, `stat_branch_count`, `stat_slot_manual_count`, `stat_slot_auto_count`, `stat_slot_nop_count`.
  - Branch trace outputs: `branch_event_valid`, `branch_event_pc`, `branch_event_taken`, `slot_event_is_auto`, `slot_event_is_nop`.

## 6. Verification Strategy

- **`tb/tb_core_basic.v`**:
  - Loads loop program with manual delay slot.
  - Observes branch log `[BRANCH] pc=... slot_is_auto=0 slot_is_nop=0` four times.
  - Checks registers (`r3=12`, `r4=4`, `r6=12`) and counters (ManualSlots=4).
- **`tb/tb_core_edgecases.v`**:
  - Exercises auto fill, forced NOP, and manual slot under load-use hazard.
  - Validates final registers (`r24=9`, `r26=3`, `r27=3`) and slot counters (Manual=1, Auto=1, Nop=1).
  - Logs branch outcomes to confirm scheduler decisions.
- **Waveforms**:
  - Add `$dumpfile("core.vcd"); $dumpvars(0, core_top);` to testbenches.
  - Inspect `if_pc`, `cand0_valid`, `slot_mode_ex`, `slot_inject_active`, `stat_slot_*` in GTKWave.
- **Regression scripts**:
  - `bash run_tests.sh` or `powershell -ExecutionPolicy Bypass -File run_tests.ps1`.

## 7. Ongoing Checklist

1. Maintain forwarding and scheduler wait logic whenever modifying EX/ID stages.
2. Keep `delay_slot_scheduler` safety rules aligned with ISA changes (e.g., if new instructions added).
3. Ensure new test programs update PASS criteria and slot counters accordingly.
4. Preserve documentation (this file + REPORT.md) whenever micro-architecture evolves.
