// --------------------------------------------------------------------
// instruction_memory.v : Simple asynchronous instruction ROM.
// --------------------------------------------------------------------
module instruction_memory #(
    parameter DEPTH = 256
) (
    input  wire [31:0] addr,
    output wire [31:0] data
);
    reg [31:0] mem[0:DEPTH-1];

    assign data = mem[addr[31:2]];

    // Synthesis-friendly memories do not require initialization, but testbenches
    // can seed program contents using the helper tasks below.
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
endmodule
