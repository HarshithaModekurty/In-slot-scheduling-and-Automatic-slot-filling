// --------------------------------------------------------------------
// hazard_unit.v : Stalls IF/ID on load-use hazards and handles flushes.
// --------------------------------------------------------------------
module hazard_unit (
    input  wire        ex_mem_read,
    input  wire [4:0]  ex_rt,
    input  wire [4:0]  id_rs,
    input  wire [4:0]  id_rt,
    output wire        stall_if,
    output wire        stall_id,
    output wire        flush_if_id,
    output wire        flush_id_ex
);
    wire load_use_hazard = ex_mem_read &&
                           ((ex_rt == id_rs && id_rs != 5'b0) ||
                            (ex_rt == id_rt && id_rt != 5'b0));

    assign stall_if = load_use_hazard;
    assign stall_id = load_use_hazard;
    assign flush_if_id = 1'b0;
    assign flush_id_ex = 1'b0;
endmodule
