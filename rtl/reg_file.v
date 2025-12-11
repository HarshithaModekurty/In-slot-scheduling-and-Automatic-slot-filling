// --------------------------------------------------------------------
// reg_file.v : 32 x 32 register file. r0 is hardwired to zero.
// --------------------------------------------------------------------
module reg_file (
    input  wire        clk,
    input  wire        reset,
    input  wire [4:0]  rs_addr,
    input  wire [4:0]  rt_addr,
    output wire [31:0] rs_data,
    output wire [31:0] rt_data,
    input  wire        rd_we,
    input  wire [4:0]  rd_addr,
    input  wire [31:0] rd_data
);
    reg [31:0] regs[0:31];
    integer i;

    always @(posedge clk) begin
        if (reset) begin
            for (i = 0; i < 32; i = i + 1) begin
                regs[i] <= 32'b0;
            end
        end else if (rd_we && rd_addr != 5'b0) begin
            regs[rd_addr] <= rd_data;
        end
    end

    assign rs_data = (rs_addr == 5'b0) ? 32'b0 : regs[rs_addr];
    assign rt_data = (rt_addr == 5'b0) ? 32'b0 : regs[rt_addr];
endmodule
