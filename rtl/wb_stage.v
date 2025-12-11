// --------------------------------------------------------------------
// wb_stage.v : Final stage writing back to the register file.
// --------------------------------------------------------------------
module wb_stage (
    input  wire        reg_write,
    input  wire        mem_to_reg,
    input  wire [4:0]  dest_reg,
    input  wire [31:0] alu_result,
    input  wire [31:0] mem_data,
    output wire        wb_we,
    output wire [4:0]  wb_addr,
    output wire [31:0] wb_data
);
    assign wb_we   = reg_write;
    assign wb_addr = dest_reg;
    assign wb_data = mem_to_reg ? mem_data : alu_result;
endmodule
