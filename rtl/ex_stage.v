// --------------------------------------------------------------------
// ex_stage.v : ALU execution + branch resolution.
// --------------------------------------------------------------------
module ex_stage (
    input  wire        clk,
    input  wire        reset,
    input  wire [31:0] id_pc_plus4,
    input  wire [31:0] rs_val,
    input  wire [31:0] rt_val,
    input  wire [31:0] imm_ext,
    input  wire [25:0] jump_index,
    input  wire [3:0]  alu_op,
    input  wire        alu_src_immediate,
    input  wire        reg_dst_rd,
    input  wire [4:0]  rs_addr,
    input  wire [4:0]  rt_addr,
    input  wire [4:0]  rd_addr,
    input  wire [1:0]  branch_type,
    output wire [31:0] alu_result,
    output wire [31:0] rt_forward_value,
    output wire [4:0]  dest_reg_out,
    output wire        branch_taken,
    output wire [31:0] branch_target
);
    wire [31:0] alu_operand_b = alu_src_immediate ? imm_ext : rt_val;

    alu u_alu (
        .op_a   (rs_val),
        .op_b   (alu_operand_b),
        .alu_op (alu_op),
        .result (alu_result),
        .zero   ()
    );

    wire [31:0] branch_offset = {imm_ext[29:0], 2'b00}; // imm << 2

    branch_unit u_branch_unit (
        .branch_type  (branch_type),
        .pc_plus4_ex  (id_pc_plus4),
        .rs_val       (rs_val),
        .rt_val       (rt_val),
        .branch_offset(branch_offset),
        .jump_index   (jump_index),
        .branch_taken (branch_taken),
        .branch_target(branch_target)
    );

    assign dest_reg_out = reg_dst_rd ? rd_addr : rt_addr;
    assign rt_forward_value = rt_val;
endmodule
