`timescale 1ns/1ps

module tb_core_edgecases;
    reg clk   = 0;
    reg reset = 1;

    wire branch_event_valid;
    wire [31:0] branch_event_pc;
    wire branch_event_taken;
    wire slot_event_is_nop;
    wire slot_event_is_auto;
    wire [31:0] stat_cycle_count;
    wire [31:0] stat_branch_count;
    wire [31:0] stat_slot_manual_count;
    wire [31:0] stat_slot_auto_count;
    wire [31:0] stat_slot_nop_count;

    core_top uut (
        .clk                    (clk),
        .reset                  (reset),
        .branch_event_valid     (branch_event_valid),
        .branch_event_pc        (branch_event_pc),
        .branch_event_taken     (branch_event_taken),
        .slot_event_is_nop      (slot_event_is_nop),
        .slot_event_is_auto     (slot_event_is_auto),
        .stat_cycle_count       (stat_cycle_count),
        .stat_branch_count      (stat_branch_count),
        .stat_slot_manual_count (stat_slot_manual_count),
        .stat_slot_auto_count   (stat_slot_auto_count),
        .stat_slot_nop_count    (stat_slot_nop_count)
    );
    initial begin
    $dumpfile("core_edgecases.vcd");
    $dumpvars(0, uut);    // DUMP EVERYTHING UNDER core_top
end

    always #5 clk = ~clk;

    task load_program_edgecases;
        begin
            uut.imem.write_word(32'd0,  32'h2001_0000); // addi r1, r0, 0
            uut.imem.write_word(32'd4,  32'h2002_0001); // addi r2, r0, 1
            uut.imem.write_word(32'd8,  32'h2018_0000); // addi r24, r0, 0
            uut.imem.write_word(32'd12, 32'h1421_0002); // bne r1, r1, auto_after (not taken)
            uut.imem.write_word(32'd16, 32'h8C05_0000); // lw r5, 0(r0) -- unsafe cand0
            uut.imem.write_word(32'd20, 32'h2318_0009); // addi r24, r24, 9 (auto candidate)
            uut.imem.write_word(32'd24, 32'h2339_0001); // auto_after: addi r25, r25, 1

            uut.imem.write_word(32'd28, 32'h201A_0000); // addi r26, r0, 0
            uut.imem.write_word(32'd32, 32'h1042_0002); // beq r2,r2,force_after (taken)
            uut.imem.write_word(32'd36, 32'hAC18_0004); // sw r24,4(r0) (unsafe)
            uut.imem.write_word(32'd40, 32'h8C06_0008); // lw r6,8(r0) (unsafe)
            uut.imem.write_word(32'd44, 32'h235A_0003); // force_after: addi r26,r26,3

            uut.imem.write_word(32'd48, 32'h8C07_0000); // lw r7,0(r0)
            uut.imem.write_word(32'd52, 32'h10E0_0002); // beq r7,r0,hazard_after (taken)
            uut.imem.write_word(32'd56, 32'h237B_0001); // addi r27,r27,1 (manual slot)
            uut.imem.write_word(32'd60, 32'h237B_0002); // hazard_after: addi r27,r27,2
            uut.imem.write_word(32'd64, 32'h2000_0000); // nop padding
        end
    endtask



    initial begin
        load_program_edgecases();
        repeat (5) @(posedge clk);
        reset <= 0;
        repeat (120) @(posedge clk);

        $display("[EDGE] Cycles=%0d Branches=%0d Manual=%0d Auto=%0d Nop=%0d",
                 stat_cycle_count, stat_branch_count,
                 stat_slot_manual_count, stat_slot_auto_count, stat_slot_nop_count);

        if (uut.u_cpu.u_reg_file.regs[24] !== 32'd9) begin
            $display("FAIL: r24 expected 9 (auto slot add), got %0d", uut.u_cpu.u_reg_file.regs[24]);
            $fatal;
        end
        if (uut.u_cpu.u_reg_file.regs[26] !== 32'd3) begin
            $display("FAIL: r26 expected 3 (force NOP branch), got %0d", uut.u_cpu.u_reg_file.regs[26]);
            $fatal;
        end
        if (uut.u_cpu.u_reg_file.regs[27] !== 32'd3) begin
            $display("FAIL: r27 expected 3 (hazard branch), got %0d", uut.u_cpu.u_reg_file.regs[27]);
            $fatal;
        end
        if (stat_slot_auto_count !== 32'd1) begin
            $display("FAIL: expected exactly one auto-filled slot, got %0d", stat_slot_auto_count);
            $fatal;
        end
        if (stat_slot_nop_count !== 32'd1) begin
            $display("FAIL: expected exactly one forced nop slot, got %0d", stat_slot_nop_count);
            $fatal;
        end
        if (stat_slot_manual_count !== 32'd1) begin
            $display("FAIL: expected exactly one manual slot, got %0d", stat_slot_manual_count);
            $fatal;
        end

        $display("PASS: tb_core_edgecases completed.");
        $finish;
    end

    always @(posedge clk) begin
        if (!reset && branch_event_valid) begin
            $display("[EDGE BR] pc=%h taken=%0d slot_auto=%0d slot_nop=%0d",
                     branch_event_pc, branch_event_taken,
                     slot_event_is_auto, slot_event_is_nop);
        end
    end
endmodule
