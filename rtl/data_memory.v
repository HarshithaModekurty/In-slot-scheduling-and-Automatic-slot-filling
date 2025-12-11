// --------------------------------------------------------------------
// data_memory.v : Simple synchronous data RAM.
// --------------------------------------------------------------------
module data_memory #(
    parameter DEPTH = 256
) (
    input  wire        clk,
    input  wire        reset,
    input  wire        we,
    input  wire [31:0] addr,
    input  wire [31:0] wdata,
    output reg  [31:0] rdata
);
    reg [31:0] mem[0:DEPTH-1];
    integer i;

    always @(posedge clk) begin
        if (reset) begin
            for (i = 0; i < DEPTH; i = i + 1) begin
                mem[i] <= 32'b0;
            end
            rdata <= 32'b0;
        end else begin
            if (we) begin
                mem[addr[31:2]] <= wdata;
            end
            rdata <= mem[addr[31:2]];
        end
    end

    task load_mem;
        input [1023:0] filename;
        begin
            $readmemh(filename, mem);
        end
    endtask

    task write_word;
        input [31:0] addr_in;
        input [31:0] value;
        begin
            mem[addr_in[31:2]] = value;
        end
    endtask

    function [31:0] read_word;
        input [31:0] addr_in;
        begin
            read_word = mem[addr_in[31:2]];
        end
    endfunction
endmodule
