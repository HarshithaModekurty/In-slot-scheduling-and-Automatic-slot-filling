// --------------------------------------------------------------------
// if_stage.v : Program counter management with two-instruction lookahead.
// Maintains a 2-entry buffer so the delay-slot scheduler can inspect
// the next two sequential instructions. Candidates can be removed
// (when promoted into a delay slot) without re-fetching later.
// --------------------------------------------------------------------
`include "isa_defs.vh"

module if_stage (
    input  wire        clk,
    input  wire        reset,
    input  wire        stall,
    input  wire        flush,
    input  wire        branch_redirect,
    input  wire [31:0] branch_target,
    input  wire        kill_cand1,
    output reg  [31:0] imem_addr,
    input  wire [31:0] imem_data,
    output reg  [31:0] if_pc,
    output reg  [31:0] if_pc_plus4,
    output reg  [31:0] if_instr,
    output wire        cand0_valid,
    output wire [31:0] cand0_instr,
    output wire [31:0] cand0_pc,
    output wire        cand1_valid,
    output wire [31:0] cand1_instr,
    output wire [31:0] cand1_pc
);
    reg [31:0] fetch_pc;

    reg [31:0] slot0_instr, slot0_pc;
    reg        slot0_valid;
    reg [31:0] slot1_instr, slot1_pc;
    reg        slot1_valid;

    reg [31:0] slot0_instr_n, slot0_pc_n;
    reg        slot0_valid_n;
    reg [31:0] slot1_instr_n, slot1_pc_n;
    reg        slot1_valid_n;
    reg [31:0] fetch_pc_n;
    reg [31:0] if_pc_n, if_pc_plus4_n, if_instr_n;

    always @(*) begin
        slot0_instr_n  = slot0_instr;
        slot0_pc_n     = slot0_pc;
        slot0_valid_n  = slot0_valid;
        slot1_instr_n  = slot1_instr;
        slot1_pc_n     = slot1_pc;
        slot1_valid_n  = slot1_valid;
        fetch_pc_n     = fetch_pc;
        if_pc_n        = if_pc;
        if_pc_plus4_n  = if_pc_plus4;
        if_instr_n     = if_instr;

        if (branch_redirect) begin
            fetch_pc_n    = branch_target;
            slot0_valid_n = 1'b0;
            slot1_valid_n = 1'b0;
        end

        if (kill_cand1) begin
            slot1_valid_n = 1'b0;
        end

        if (flush) begin
            if_instr_n    = `INST_NOP;
            if_pc_n       = 32'b0;
            if_pc_plus4_n = 32'b0;
        end else if (!stall && slot0_valid) begin
            if_instr_n    = slot0_instr;
            if_pc_n       = slot0_pc;
            if_pc_plus4_n = slot0_pc + 32'd4;

            slot0_instr_n = slot1_instr_n;
            slot0_pc_n    = slot1_pc_n;
            slot0_valid_n = slot1_valid_n;
            slot1_valid_n = 1'b0;
        end else if (!stall) begin
            if_instr_n    = `INST_NOP;
            if_pc_n       = 32'b0;
            if_pc_plus4_n = 32'b0;
        end

        if (!branch_redirect) begin
            if (!slot0_valid_n) begin
                slot0_instr_n = imem_data;
                slot0_pc_n    = fetch_pc_n;
                slot0_valid_n = 1'b1;
                fetch_pc_n    = fetch_pc_n + 32'd4;
            end else if (!slot1_valid_n) begin
                slot1_instr_n = imem_data;
                slot1_pc_n    = fetch_pc_n;
                slot1_valid_n = 1'b1;
                fetch_pc_n    = fetch_pc_n + 32'd4;
            end
        end
    end

    always @(posedge clk) begin
        if (reset) begin
            fetch_pc     <= 32'b0;
            slot0_instr  <= `INST_NOP;
            slot0_pc     <= 32'b0;
            slot0_valid  <= 1'b0;
            slot1_instr  <= `INST_NOP;
            slot1_pc     <= 32'b0;
            slot1_valid  <= 1'b0;
            if_pc        <= 32'b0;
            if_pc_plus4  <= 32'b0;
            if_instr     <= `INST_NOP;
        end else begin
            fetch_pc     <= fetch_pc_n;
            slot0_instr  <= slot0_instr_n;
            slot0_pc     <= slot0_pc_n;
            slot0_valid  <= slot0_valid_n;
            slot1_instr  <= slot1_instr_n;
            slot1_pc     <= slot1_pc_n;
            slot1_valid  <= slot1_valid_n;
            if_pc        <= if_pc_n;
            if_pc_plus4  <= if_pc_plus4_n;
            if_instr     <= if_instr_n;
        end
    end

    always @(*) begin
        imem_addr = fetch_pc;
    end

    assign cand0_valid = slot0_valid;
    assign cand0_instr = slot0_instr;
    assign cand0_pc    = slot0_pc;
    assign cand1_valid = slot1_valid;
    assign cand1_instr = slot1_instr;
    assign cand1_pc    = slot1_pc;
endmodule
