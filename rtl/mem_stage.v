// --------------------------------------------------------------------
// mem_stage.v : Data memory access stage.
// --------------------------------------------------------------------
module mem_stage (
    input  wire        mem_read,
    input  wire        mem_write,
    input  wire [31:0] alu_result,
    input  wire [31:0] rt_forward_value,
    output wire        dmem_we,
    output wire [31:0] dmem_addr,
    output wire [31:0] dmem_wdata,
    input  wire [31:0] dmem_rdata,
    output wire [31:0] mem_data_out
);
    assign dmem_we   = mem_write;
    assign dmem_addr = alu_result;
    assign dmem_wdata = rt_forward_value;
    assign mem_data_out = dmem_rdata;
endmodule
