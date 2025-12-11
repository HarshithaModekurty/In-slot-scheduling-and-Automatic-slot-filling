`timescale 1ns/1ps

module tb_core_basic;
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
    $dumpfile("core_basic.vcd");
    $dumpvars(0, uut);    // DUMP EVERYTHING UNDER core_top
end



    // Clock generation
    always #5 clk = ~clk;

    task load_program_basic;
        begin
            uut.imem.write_word(32'd0, 32'h2001_0004); // addi r1, r0, 4
            uut.imem.write_word(32'd4, 32'h2002_0003); // addi r2, r0, 3
            uut.imem.write_word(32'd8, 32'h2003_0000); // addi r3, r0, 0
            uut.imem.write_word(32'd12,32'h0062_1820); // loop: add  r3, r3, r2
            uut.imem.write_word(32'd16,32'h2021_FFFF); // addi r1, r1, -1
            uut.imem.write_word(32'd20,32'h1420_FFFD); // bne  r1, r0, loop
            uut.imem.write_word(32'd24,32'h2084_0001); // addi r4, r4, 1 (delay slot)
            uut.imem.write_word(32'd28,32'h0060_3020); // add  r6, r3, r0
            uut.imem.write_word(32'd32,32'h0000_0000); // nop
        end
    endtask

    initial begin
        load_program_basic();
        repeat (5) @(posedge clk);
        reset <= 0;
        repeat (80) @(posedge clk);

        $display("[TB] Cycles=%0d Branches=%0d ManualSlots=%0d AutoSlots=%0d SlotNOPs=%0d",
                 stat_cycle_count, stat_branch_count,
                 stat_slot_manual_count, stat_slot_auto_count, stat_slot_nop_count);

        if (uut.u_cpu.u_reg_file.regs[3] !== 32'd12) begin
            $display("FAIL: r3 expected 12, got %0d", uut.u_cpu.u_reg_file.regs[3]);
            $fatal;
        end
        if (uut.u_cpu.u_reg_file.regs[4] !== 32'd4) begin
            $display("FAIL: r4 expected 4 delay-slot executions, got %0d", uut.u_cpu.u_reg_file.regs[4]);
            $fatal;
        end
        if (uut.u_cpu.u_reg_file.regs[6] !== 32'd12) begin
            $display("FAIL: r6 expected 12 copy, got %0d", uut.u_cpu.u_reg_file.regs[6]);
            $fatal;
        end

        $display("PASS: tb_core_basic finished with correct results.");
        $finish;
    end

    always @(posedge clk) begin
        if (!reset && branch_event_valid) begin
            $display("[BRANCH] pc=%h taken=%0d slot_is_nop=%0d slot_is_auto=%0d",
                     branch_event_pc, branch_event_taken,
                     slot_event_is_nop, slot_event_is_auto);
        end
    end
endmodule
