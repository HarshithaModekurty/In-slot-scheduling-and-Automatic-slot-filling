// --------------------------------------------------------------------
// alu.v : Simple arithmetic logic unit for the delayed-branch core.
// --------------------------------------------------------------------
module alu (
    input  wire [31:0] op_a,
    input  wire [31:0] op_b,
    input  wire [3:0]  alu_op,
    output reg  [31:0] result,
    output wire        zero
);
    localparam ALU_ADD  = 4'd0;
    localparam ALU_SUB  = 4'd1;
    localparam ALU_AND  = 4'd2;
    localparam ALU_OR   = 4'd3;
    localparam ALU_PASS = 4'd4;

    always @(*) begin
        case (alu_op)
            ALU_ADD:  result = op_a + op_b;
            ALU_SUB:  result = op_a - op_b;
            ALU_AND:  result = op_a & op_b;
            ALU_OR:   result = op_a | op_b;
            ALU_PASS: result = op_b;
            default:  result = 32'hDEAD_BEEF;
        endcase
    end

    assign zero = (result == 32'b0);
endmodule
