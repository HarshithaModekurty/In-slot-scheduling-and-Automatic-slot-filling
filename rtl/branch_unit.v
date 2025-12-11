// --------------------------------------------------------------------
// branch_unit.v : Controls branch resolution and target generation.
// --------------------------------------------------------------------
module branch_unit (
    input  wire [1:0]  branch_type,     // 0=none,1=beq,2=bne,3=jump
    input  wire [31:0] pc_plus4_ex,
    input  wire [31:0] rs_val,
    input  wire [31:0] rt_val,
    input  wire [31:0] branch_offset,   // already shifted left 2
    input  wire [25:0] jump_index,
    output wire        branch_taken,
    output reg  [31:0] branch_target
);
    localparam BR_NONE = 2'd0;
    localparam BR_BEQ  = 2'd1;
    localparam BR_BNE  = 2'd2;
    localparam BR_J    = 2'd3;

    wire beq_taken = (branch_type == BR_BEQ) && (rs_val == rt_val);
    wire bne_taken = (branch_type == BR_BNE) && (rs_val != rt_val);
    wire j_taken   = (branch_type == BR_J);

    assign branch_taken = beq_taken || bne_taken || j_taken;

    always @(*) begin
        case (branch_type)
            BR_BEQ,
            BR_BNE: branch_target = pc_plus4_ex + branch_offset;
            BR_J:   branch_target = {pc_plus4_ex[31:28], jump_index, 2'b00};
            default: branch_target = pc_plus4_ex + 32'd4;
        endcase
    end
endmodule
