// --------------------------------------------------------------------
// id_stage.v : Instruction decode and register operand selection.
// --------------------------------------------------------------------
`include "isa_defs.vh"

module id_stage (
    input  wire [31:0] if_instr,
    input  wire [31:0] if_pc_plus4,
    output wire [4:0]  rs_addr,
    output wire [4:0]  rt_addr,
    output wire [4:0]  rd_addr,
    output reg  [3:0]  alu_op,
    output reg         alu_src_immediate,
    output reg         reg_dst_rd,
    output reg         reg_write,
    output reg         mem_read,
    output reg         mem_write,
    output reg         mem_to_reg,
    output reg  [1:0]  branch_type,
    output reg  [31:0] imm_ext,
    output reg  [25:0] jump_index,
    output wire        id_is_branch_or_jump
);
    localparam BR_NONE = 2'd0;
    localparam BR_BEQ  = 2'd1;
    localparam BR_BNE  = 2'd2;
    localparam BR_J    = 2'd3;

    wire [5:0] opcode = if_instr[31:26];
    wire [5:0] funct  = if_instr[5:0];
    assign rs_addr = if_instr[25:21];
    assign rt_addr = if_instr[20:16];
    assign rd_addr = if_instr[15:11];

    wire [15:0] imm  = if_instr[15:0];
    wire [31:0] sign_ext = {{16{imm[15]}}, imm};
    wire [31:0] zero_ext = {16'b0, imm};

    assign id_is_branch_or_jump = (branch_type != BR_NONE);

    always @(*) begin
        alu_op            = 4'd0;
        alu_src_immediate = 1'b0;
        reg_dst_rd        = 1'b0;
        reg_write         = 1'b0;
        mem_read          = 1'b0;
        mem_write         = 1'b0;
        mem_to_reg        = 1'b0;
        branch_type       = BR_NONE;
        imm_ext           = sign_ext;
        jump_index        = if_instr[25:0];

        case (opcode)
            `OPCODE_RTYPE: begin
                reg_dst_rd  = 1'b1;
                reg_write   = (if_instr != `INST_NOP);
                case (funct)
                    `FUNCT_ADD: alu_op = 4'd0;
                    `FUNCT_SUB: alu_op = 4'd1;
                    `FUNCT_AND: alu_op = 4'd2;
                    `FUNCT_OR:  alu_op = 4'd3;
                    default: begin
                        alu_op    = 4'd0;
                        reg_write = 1'b0;
                    end
                endcase
            end
            `OPCODE_ADDI: begin
                alu_op            = 4'd0;
                alu_src_immediate = 1'b1;
                reg_write         = 1'b1;
                reg_dst_rd        = 1'b0;
            end
            `OPCODE_LW: begin
                alu_op            = 4'd0;
                alu_src_immediate = 1'b1;
                reg_write         = 1'b1;
                reg_dst_rd        = 1'b0;
                mem_read          = 1'b1;
                mem_to_reg        = 1'b1;
            end
            `OPCODE_SW: begin
                alu_op            = 4'd0;
                alu_src_immediate = 1'b1;
                mem_write         = 1'b1;
            end
            `OPCODE_BEQ: begin
                alu_op      = 4'd1;
                branch_type = BR_BEQ;
            end
            `OPCODE_BNE: begin
                alu_op      = 4'd1;
                branch_type = BR_BNE;
            end
            `OPCODE_J: begin
                branch_type = BR_J;
            end
            default: begin
                // treat as NOP
            end
        endcase
    end
endmodule
