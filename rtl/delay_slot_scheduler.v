// --------------------------------------------------------------------
// delay_slot_scheduler.v : Hardware "compiler" for filling branch slots.
// --------------------------------------------------------------------
`include "isa_defs.vh"

module delay_slot_scheduler (
    input  wire        branch_valid,
    input  wire [31:0] branch_pc,
    input  wire [4:0]  branch_rs,
    input  wire [4:0]  branch_rt,
    input  wire        branch_is_backward,
    input  wire        cand0_valid,
    input  wire [31:0] cand0_instr,
    input  wire [31:0] cand0_pc,
    input  wire        cand1_valid,
    input  wire [31:0] cand1_instr,
    input  wire [31:0] cand1_pc,
    output reg         manual_slot_ok,
    output reg         manual_slot_is_nop,
    output reg         auto_slot_use,
    output reg         force_nop_slot,
    output reg         wait_for_more_candidates,
    output reg  [31:0] auto_slot_instr,
    output reg  [31:0] auto_slot_pc,
    output reg         kill_cand1
);
    function automatic [5:0] get_opcode;
        input [31:0] instr;
        begin
            get_opcode = instr[31:26];
        end
    endfunction

    function automatic [5:0] get_funct;
        input [31:0] instr;
        begin
            get_funct = instr[5:0];
        end
    endfunction

    function automatic [4:0] get_rs;
        input [31:0] instr;
        begin
            get_rs = instr[25:21];
        end
    endfunction

    function automatic [4:0] get_rt;
        input [31:0] instr;
        begin
            get_rt = instr[20:16];
        end
    endfunction

    function automatic [4:0] get_rd;
        input [31:0] instr;
        begin
            get_rd = instr[15:11];
        end
    endfunction

    function automatic bit is_control;
        input [31:0] instr;
        reg [5:0] opcode;
        begin
            opcode = get_opcode(instr);
            is_control = (opcode == `OPCODE_BEQ) ||
                         (opcode == `OPCODE_BNE) ||
                         (opcode == `OPCODE_J);
        end
    endfunction

    function automatic bit is_memory_op;
        input [31:0] instr;
        reg [5:0] opcode;
        begin
            opcode = get_opcode(instr);
            is_memory_op = (opcode == `OPCODE_LW) || (opcode == `OPCODE_SW);
        end
    endfunction

    function automatic [4:0] get_dest_reg;
        input [31:0] instr;
        reg [5:0] opcode;
        begin
            opcode = get_opcode(instr);
            if (opcode == `OPCODE_RTYPE)
                get_dest_reg = get_rd(instr);
            else if (opcode == `OPCODE_LW || opcode == `OPCODE_ADDI)
                get_dest_reg = get_rt(instr);
            else
                get_dest_reg = 5'b0;
        end
    endfunction

    function automatic bit writes_register;
        input [31:0] instr;
        reg [5:0] opcode;
        begin
            opcode = get_opcode(instr);
            if (opcode == `OPCODE_RTYPE) begin
                writes_register = (instr != `INST_NOP);
            end else if (opcode == `OPCODE_ADDI || opcode == `OPCODE_LW) begin
                writes_register = 1'b1;
            end else begin
                writes_register = 1'b0;
            end
        end
    endfunction

    function automatic bit safe_candidate;
        input [31:0] instr;
        input [4:0] branch_rs_l;
        input [4:0] branch_rt_l;
        reg [4:0] dest;
        begin
            safe_candidate = 1'b0;
            if (instr == `INST_NOP)
                safe_candidate = 1'b1;
            else if (is_control(instr))
                safe_candidate = 1'b0;
            else if (is_memory_op(instr))
                safe_candidate = 1'b0;
            else begin
                dest = get_dest_reg(instr);
                if (dest != 5'b0 && writes_register(instr)) begin
                    if ((dest == branch_rs_l) || (dest == branch_rt_l))
                        safe_candidate = 1'b0;
                    else
                        safe_candidate = 1'b1;
                end else begin
                    safe_candidate = 1'b1;
                end
            end
        end
    endfunction

    wire branch_window_ok = !branch_is_backward || (cand1_pc > branch_pc);

    always @(*) begin
        manual_slot_ok   = 1'b0;
        manual_slot_is_nop = 1'b0;
        auto_slot_use    = 1'b0;
        force_nop_slot   = 1'b0;
        wait_for_more_candidates = 1'b0;
        auto_slot_instr  = `INST_NOP;
        auto_slot_pc     = 32'b0;
        kill_cand1       = 1'b0;

        if (branch_valid) begin
            if (cand0_valid && safe_candidate(cand0_instr, branch_rs, branch_rt)) begin
                manual_slot_ok     = 1'b1;
                manual_slot_is_nop = (cand0_instr == `INST_NOP);
            end else if (cand1_valid && safe_candidate(cand1_instr, branch_rs, branch_rt) &&
                         branch_window_ok) begin
                auto_slot_use   = 1'b1;
                auto_slot_instr = cand1_instr;
                auto_slot_pc    = cand1_pc;
                kill_cand1      = 1'b1;
            end else if (!cand1_valid && branch_window_ok) begin
                wait_for_more_candidates = 1'b1;
            end else begin
                force_nop_slot = 1'b1;
            end
        end
    end
endmodule
