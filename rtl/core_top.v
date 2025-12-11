// --------------------------------------------------------------------
// core_top.v : Wrapper tying pipeline to instruction/data memories.
// --------------------------------------------------------------------
module core_top (
    input  wire        clk,
    input  wire        reset,
    output wire        branch_event_valid,
    output wire [31:0] branch_event_pc,
    output wire        branch_event_taken,
    output wire        slot_event_is_nop,
    output wire        slot_event_is_auto,
    output wire [31:0] stat_cycle_count,
    output wire [31:0] stat_branch_count,
    output wire [31:0] stat_slot_manual_count,
    output wire [31:0] stat_slot_auto_count,
    output wire [31:0] stat_slot_nop_count
);
    // Instruction memory wires
    wire [31:0] imem_addr;
    wire [31:0] imem_rdata;

    // Data memory wires
    wire        dmem_we;
    wire [31:0] dmem_addr;
    wire [31:0] dmem_wdata;
    wire [31:0] dmem_rdata;

    instruction_memory #(.DEPTH(256)) imem (
        .addr (imem_addr),
        .data (imem_rdata)
    );

    data_memory #(.DEPTH(256)) dmem (
        .clk   (clk),
        .reset (reset),
        .we    (dmem_we),
        .addr  (dmem_addr),
        .wdata (dmem_wdata),
        .rdata (dmem_rdata)
    );

    cpu_pipeline u_cpu (
        .clk                 (clk),
        .reset               (reset),
        .imem_addr           (imem_addr),
        .imem_rdata          (imem_rdata),
        .dmem_we             (dmem_we),
        .dmem_addr           (dmem_addr),
        .dmem_wdata          (dmem_wdata),
        .dmem_rdata          (dmem_rdata),
        .branch_event_valid  (branch_event_valid),
        .branch_event_pc     (branch_event_pc),
        .branch_event_taken  (branch_event_taken),
        .slot_event_is_nop   (slot_event_is_nop),
        .slot_event_is_auto  (slot_event_is_auto),
        .stat_cycle_count    (stat_cycle_count),
        .stat_branch_count   (stat_branch_count),
        .stat_slot_manual_count(stat_slot_manual_count),
        .stat_slot_auto_count(stat_slot_auto_count),
        .stat_slot_nop_count (stat_slot_nop_count)
    );
endmodule
