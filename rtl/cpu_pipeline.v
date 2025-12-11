// --------------------------------------------------------------------
// cpu_pipeline.v : Five-stage pipeline with architectural delay slot.
// --------------------------------------------------------------------
`include "isa_defs.vh"

module cpu_pipeline (
    input  wire        clk,
    input  wire        reset,
    // Instruction memory interface
    output wire [31:0] imem_addr,
    input  wire [31:0] imem_rdata,
    // Data memory interface
    output wire        dmem_we,
    output wire [31:0] dmem_addr,
    output wire [31:0] dmem_wdata,
    input  wire [31:0] dmem_rdata,
    // Debug / statistics outputs
    output wire        branch_event_valid,
    output wire [31:0] branch_event_pc,
    output wire        branch_event_taken,
    output wire        slot_event_is_nop,
    output wire        slot_event_is_auto,
    output reg  [31:0] stat_cycle_count,
    output reg  [31:0] stat_branch_count,
    output reg  [31:0] stat_slot_manual_count,
    output reg  [31:0] stat_slot_auto_count,
    output reg  [31:0] stat_slot_nop_count
);
    localparam BR_NONE = 2'd0;

    // ------------------------------
    // IF stage
    // ------------------------------
    wire        if_stall;
    wire        if_flush;
    wire        branch_redirect;
    wire [31:0] branch_target;

    wire [31:0] if_pc;
    wire [31:0] if_pc_plus4;
    wire [31:0] if_instr;
    wire [31:0] id_instr_in;
    wire [31:0] id_pc_in;
    wire [31:0] id_pc_plus4_in;
    wire        cand0_valid;
    wire [31:0] cand0_instr;
    wire [31:0] cand0_pc;
    wire        cand1_valid;
    wire [31:0] cand1_instr;
    wire [31:0] cand1_pc;
    wire        kill_cand1_signal;

    if_stage u_if_stage (
        .clk             (clk),
        .reset           (reset),
        .stall           (if_stall),
        .flush           (if_flush),
        .branch_redirect (branch_redirect),
        .branch_target   (branch_target),
        .kill_cand1      (kill_cand1_signal),
        .imem_addr       (imem_addr),
        .imem_data       (imem_rdata),
        .if_pc           (if_pc),
        .if_pc_plus4     (if_pc_plus4),
        .if_instr        (if_instr),
        .cand0_valid     (cand0_valid),
        .cand0_instr     (cand0_instr),
        .cand0_pc        (cand0_pc),
        .cand1_valid     (cand1_valid),
        .cand1_instr     (cand1_instr),
        .cand1_pc        (cand1_pc)
    );

    // ------------------------------
    // ID stage
    // ------------------------------
    wire [4:0] id_rs_addr;
    wire [4:0] id_rt_addr;
    wire [4:0] id_rd_addr;
    wire [3:0] id_alu_op;
    wire       id_alu_src_immediate;
    wire       id_reg_dst_rd;
    wire       id_reg_write;
    wire       id_mem_read;
    wire       id_mem_write;
    wire       id_mem_to_reg;
    wire [1:0] id_branch_type;
    wire [31:0] id_imm_ext;
    wire [25:0] id_jump_index;

    id_stage u_id_stage (
        .if_instr          (id_instr_in),
        .if_pc_plus4       (id_pc_plus4_in),
        .rs_addr           (id_rs_addr),
        .rt_addr           (id_rt_addr),
        .rd_addr           (id_rd_addr),
        .alu_op            (id_alu_op),
        .alu_src_immediate (id_alu_src_immediate),
        .reg_dst_rd        (id_reg_dst_rd),
        .reg_write         (id_reg_write),
        .mem_read          (id_mem_read),
        .mem_write         (id_mem_write),
        .mem_to_reg        (id_mem_to_reg),
        .branch_type       (id_branch_type),
        .imm_ext           (id_imm_ext),
        .jump_index        (id_jump_index),
        .id_is_branch_or_jump ()
    );

    // Register file
    wire        wb_we;
    wire [4:0]  wb_addr;
    wire [31:0] wb_data;
    wire [31:0] rs_data;
    wire [31:0] rt_data;

    reg_file u_reg_file (
        .clk     (clk),
        .reset   (reset),
        .rs_addr (id_rs_addr),
        .rt_addr (id_rt_addr),
        .rs_data (rs_data),
        .rt_data (rt_data),
        .rd_we   (wb_we),
        .rd_addr (wb_addr),
        .rd_data (wb_data)
    );

    // ------------------------------
    // Scheduler wires
    localparam SLOT_MODE_MANUAL = 2'd0;
    localparam SLOT_MODE_AUTO   = 2'd1;
    localparam SLOT_MODE_NOP    = 2'd2;

    wire        branch_valid_id = (id_branch_type != BR_NONE);
    wire [31:0] branch_offset_id = {id_imm_ext[29:0], 2'b00};
    wire [31:0] predicted_branch_target = id_pc_plus4_in + branch_offset_id;
    wire        branch_is_backward_id = branch_valid_id &&
                                        (predicted_branch_target < id_pc_in);

    wire manual_slot_ok;
    wire manual_slot_is_nop;
    wire auto_slot_use;
    wire force_nop_slot;
    wire wait_for_candidates;
    wire [31:0] auto_slot_instr;
    wire [31:0] auto_slot_pc;
    wire [31:0] manual_slot_instr_id = cand0_valid ? cand0_instr : `INST_NOP;
    wire [31:0] manual_slot_pc_id    = cand0_valid ? cand0_pc : id_pc_plus4_in;

    wire scheduler_kill_cand1_raw;

    // delay_slot_scheduler peeks at the two look-ahead instructions that the IF
    // stage keeps ready. It classifies the slot as manual / auto / forced-nop
    // without mutating the instruction stream; the IF buffer is later instructed
    // to drop any candidate that gets promoted.
    delay_slot_scheduler u_slot_scheduler (
        .branch_valid      (branch_valid_id),
        .branch_pc         (id_pc_in),
        .branch_rs         (id_rs_addr),
        .branch_rt         (id_rt_addr),
        .branch_is_backward(branch_is_backward_id),
        .cand0_valid       (cand0_valid),
        .cand0_instr       (cand0_instr),
        .cand0_pc          (cand0_pc),
        .cand1_valid       (cand1_valid),
        .cand1_instr       (cand1_instr),
        .cand1_pc          (cand1_pc),
        .manual_slot_ok    (manual_slot_ok),
        .manual_slot_is_nop(manual_slot_is_nop),
        .auto_slot_use     (auto_slot_use),
        .force_nop_slot    (force_nop_slot),
        .wait_for_more_candidates(wait_for_candidates),
        .auto_slot_instr   (auto_slot_instr),
        .auto_slot_pc      (auto_slot_pc),
        .kill_cand1        (scheduler_kill_cand1_raw)
    );

    wire [1:0] slot_mode_id = (!branch_valid_id)                  ? SLOT_MODE_MANUAL :
                               manual_slot_ok                     ? SLOT_MODE_MANUAL :
                               auto_slot_use                      ? SLOT_MODE_AUTO :
                               force_nop_slot                     ? SLOT_MODE_NOP :
                                                                   SLOT_MODE_MANUAL;
    wire slot_manual_is_nop_id = manual_slot_ok && manual_slot_is_nop;

    wire scheduler_wait = branch_valid_id && wait_for_candidates;
    wire branch_id_fire = branch_valid_id && !hazard_stall_id && !hazard_flush_id_ex && !scheduler_wait;
    assign kill_cand1_signal = branch_id_fire && scheduler_kill_cand1_raw;

    // ID/EX pipeline register
    // ------------------------------
    reg [31:0] id_ex_pc;
    reg [31:0] id_ex_pc_plus4;
    reg [31:0] id_ex_rs_val;
    reg [31:0] id_ex_rt_val;
    reg [31:0] id_ex_imm_ext;
    reg [25:0] id_ex_jump_index;
    reg [3:0]  id_ex_alu_op;
    reg        id_ex_alu_src_immediate;
    reg        id_ex_reg_dst_rd;
    reg        id_ex_reg_write;
    reg        id_ex_mem_read;
    reg        id_ex_mem_write;
    reg        id_ex_mem_to_reg;
    reg [1:0]  id_ex_branch_type;
    reg [4:0]  id_ex_rs_addr;
    reg [4:0]  id_ex_rt_addr;
    reg [4:0]  id_ex_rd_addr;
    reg [1:0]  id_ex_slot_mode;
    reg [31:0] id_ex_slot_auto_instr;
    reg [31:0] id_ex_slot_auto_pc;
    reg        id_ex_slot_manual_is_nop;
    reg [31:0] id_ex_slot_manual_instr;
    reg [31:0] id_ex_slot_manual_pc;

    // EX/MEM pipeline register declarations (body defined later)
    reg [31:0] ex_mem_alu_result;
    reg [31:0] ex_mem_rt_forward_value;
    reg [4:0]  ex_mem_dest_reg;
    reg        ex_mem_reg_write;
    reg        ex_mem_mem_read;
    reg        ex_mem_mem_write;
    reg        ex_mem_mem_to_reg;

    // MEM/WB pipeline register declarations
    // ------------------------------
    // Hazard detection
    // ------------------------------
    wire hazard_stall_if;
    wire hazard_stall_id;
    wire hazard_flush_if_id;
    wire hazard_flush_id_ex;

    hazard_unit u_hazard_unit (
        .ex_mem_read      (id_ex_mem_read),
        .ex_rt            (id_ex_rt_addr),
        .id_rs            (id_rs_addr),
        .id_rt            (id_rt_addr),
        .stall_if         (hazard_stall_if),
        .stall_id         (hazard_stall_id),
        .flush_if_id      (hazard_flush_if_id),
        .flush_id_ex      (hazard_flush_id_ex)
    );

    assign if_stall = hazard_stall_if || slot_inject_active || scheduler_wait;

    // ID/EX pipeline register
    always @(posedge clk) begin
        if (reset || hazard_flush_id_ex) begin
            id_ex_pc              <= 32'b0;
            id_ex_pc_plus4        <= 32'b0;
            id_ex_rs_val          <= 32'b0;
            id_ex_rt_val          <= 32'b0;
            id_ex_imm_ext         <= 32'b0;
            id_ex_jump_index      <= 26'b0;
            id_ex_alu_op          <= 4'b0;
            id_ex_alu_src_immediate <= 1'b0;
            id_ex_reg_dst_rd      <= 1'b0;
            id_ex_reg_write       <= 1'b0;
            id_ex_mem_read        <= 1'b0;
            id_ex_mem_write       <= 1'b0;
            id_ex_mem_to_reg      <= 1'b0;
            id_ex_branch_type     <= BR_NONE;
            id_ex_rs_addr         <= 5'b0;
            id_ex_rt_addr         <= 5'b0;
            id_ex_rd_addr         <= 5'b0;
            id_ex_slot_mode       <= SLOT_MODE_MANUAL;
            id_ex_slot_auto_instr <= `INST_NOP;
            id_ex_slot_auto_pc    <= 32'b0;
            id_ex_slot_manual_is_nop <= 1'b0;
            id_ex_slot_manual_instr <= `INST_NOP;
            id_ex_slot_manual_pc    <= 32'b0;
        end else if (scheduler_wait) begin
            // Hold values until enough candidates are available.
            id_ex_pc              <= id_ex_pc;
            id_ex_pc_plus4        <= id_ex_pc_plus4;
            id_ex_rs_val          <= id_ex_rs_val;
            id_ex_rt_val          <= id_ex_rt_val;
            id_ex_imm_ext         <= id_ex_imm_ext;
            id_ex_jump_index      <= id_ex_jump_index;
            id_ex_alu_op          <= id_ex_alu_op;
            id_ex_alu_src_immediate <= id_ex_alu_src_immediate;
            id_ex_reg_dst_rd      <= id_ex_reg_dst_rd;
            id_ex_reg_write       <= id_ex_reg_write;
            id_ex_mem_read        <= id_ex_mem_read;
            id_ex_mem_write       <= id_ex_mem_write;
            id_ex_mem_to_reg      <= id_ex_mem_to_reg;
            id_ex_branch_type     <= id_ex_branch_type;
            id_ex_rs_addr         <= id_ex_rs_addr;
            id_ex_rt_addr         <= id_ex_rt_addr;
            id_ex_rd_addr         <= id_ex_rd_addr;
            id_ex_slot_mode       <= id_ex_slot_mode;
            id_ex_slot_auto_instr <= id_ex_slot_auto_instr;
            id_ex_slot_auto_pc    <= id_ex_slot_auto_pc;
            id_ex_slot_manual_is_nop <= id_ex_slot_manual_is_nop;
            id_ex_slot_manual_instr <= id_ex_slot_manual_instr;
            id_ex_slot_manual_pc    <= id_ex_slot_manual_pc;
        end else if (!hazard_stall_id) begin
            id_ex_pc              <= id_pc_in;
            id_ex_pc_plus4        <= id_pc_plus4_in;
            id_ex_rs_val          <= rs_data;
            id_ex_rt_val          <= rt_data;
            id_ex_imm_ext         <= id_imm_ext;
            id_ex_jump_index      <= id_jump_index;
            id_ex_alu_op          <= id_alu_op;
            id_ex_alu_src_immediate <= id_alu_src_immediate;
            id_ex_reg_dst_rd      <= id_reg_dst_rd;
            id_ex_reg_write       <= id_reg_write;
            id_ex_mem_read        <= id_mem_read;
            id_ex_mem_write       <= id_mem_write;
            id_ex_mem_to_reg      <= id_mem_to_reg;
            id_ex_branch_type     <= id_branch_type;
            id_ex_rs_addr         <= id_rs_addr;
            id_ex_rt_addr         <= id_rt_addr;
            id_ex_rd_addr         <= id_rd_addr;
            id_ex_slot_mode       <= slot_mode_id;
            id_ex_slot_auto_instr <= auto_slot_instr;
            id_ex_slot_auto_pc    <= auto_slot_pc;
            id_ex_slot_manual_is_nop <= slot_manual_is_nop_id;
            id_ex_slot_manual_instr <= manual_slot_instr_id;
            id_ex_slot_manual_pc    <= manual_slot_pc_id;
        end else begin
            // inject bubble
            id_ex_pc              <= 32'b0;
            id_ex_pc_plus4        <= 32'b0;
            id_ex_rs_val          <= 32'b0;
            id_ex_rt_val          <= 32'b0;
            id_ex_imm_ext         <= 32'b0;
            id_ex_jump_index      <= 26'b0;
            id_ex_alu_op          <= 4'b0;
            id_ex_alu_src_immediate <= 1'b0;
            id_ex_reg_dst_rd      <= 1'b0;
            id_ex_reg_write       <= 1'b0;
            id_ex_mem_read        <= 1'b0;
            id_ex_mem_write       <= 1'b0;
            id_ex_mem_to_reg      <= 1'b0;
            id_ex_branch_type     <= BR_NONE;
            id_ex_rs_addr         <= 5'b0;
            id_ex_rt_addr         <= 5'b0;
            id_ex_rd_addr         <= 5'b0;
            id_ex_slot_mode       <= SLOT_MODE_MANUAL;
            id_ex_slot_auto_instr <= `INST_NOP;
            id_ex_slot_auto_pc    <= 32'b0;
            id_ex_slot_manual_is_nop <= 1'b0;
            id_ex_slot_manual_instr <= `INST_NOP;
            id_ex_slot_manual_pc    <= 32'b0;
        end
    end

    // ------------------------------
    // EX stage
    // ------------------------------
    wire [31:0] ex_alu_result;
    wire [31:0] ex_rt_forward_value;
    wire [4:0]  ex_dest_reg;
    wire        ex_branch_taken;

    // Forwarding to resolve RAW hazards between consecutive ALU ops
    wire ex_mem_forward_rs = ex_mem_reg_write && !ex_mem_mem_read &&
                             (ex_mem_dest_reg != 5'b0) &&
                             (ex_mem_dest_reg == id_ex_rs_addr);
    wire mem_wb_forward_rs = mem_wb_reg_write &&
                             (mem_wb_dest_reg != 5'b0) &&
                             (mem_wb_dest_reg == id_ex_rs_addr);
    wire ex_mem_forward_rt = ex_mem_reg_write && !ex_mem_mem_read &&
                             (ex_mem_dest_reg != 5'b0) &&
                             (ex_mem_dest_reg == id_ex_rt_addr);
    wire mem_wb_forward_rt = mem_wb_reg_write &&
                             (mem_wb_dest_reg != 5'b0) &&
                             (mem_wb_dest_reg == id_ex_rt_addr);

    wire [31:0] ex_stage_rs_val = ex_mem_forward_rs ? ex_mem_alu_result :
                                  mem_wb_forward_rs ? wb_data :
                                  id_ex_rs_val;
    wire [31:0] ex_stage_rt_val = ex_mem_forward_rt ? ex_mem_alu_result :
                                  mem_wb_forward_rt ? wb_data :
                                  id_ex_rt_val;

    ex_stage u_ex_stage (
        .clk               (clk),
        .reset             (reset),
        .id_pc_plus4       (id_ex_pc_plus4),
        .rs_val            (ex_stage_rs_val),
        .rt_val            (ex_stage_rt_val),
        .imm_ext           (id_ex_imm_ext),
        .jump_index        (id_ex_jump_index),
        .alu_op            (id_ex_alu_op),
        .alu_src_immediate (id_ex_alu_src_immediate),
        .reg_dst_rd        (id_ex_reg_dst_rd),
        .rs_addr           (id_ex_rs_addr),
        .rt_addr           (id_ex_rt_addr),
        .rd_addr           (id_ex_rd_addr),
        .branch_type       (id_ex_branch_type),
        .alu_result        (ex_alu_result),
        .rt_forward_value  (ex_rt_forward_value),
        .dest_reg_out      (ex_dest_reg),
        .branch_taken      (ex_branch_taken),
        .branch_target     (branch_target)
    );

    assign branch_redirect = ex_branch_taken;

    // Branch monitoring
    assign branch_event_valid = (id_ex_branch_type != BR_NONE);
    assign branch_event_pc    = id_ex_pc;
    assign branch_event_taken = ex_branch_taken;

    // slot_mode_ex + slot_cycle_pending together control the â€œcompiler in hardwareâ€?
    // behaviour: when EX resolves a branch, the next cycle either injects the
    // selected candidate or issues a bubble, while the fetch buffer is held so
    // the original sequencing resumes immediately afterwards.
    reg slot_cycle_pending;
    reg [1:0] slot_mode_ex;
    reg [31:0] slot_auto_instr_ex;
    reg [31:0] slot_auto_pc_ex;
    reg [31:0] slot_nominal_pc_ex;
    reg [31:0] slot_manual_instr_ex;
    reg [31:0] slot_manual_pc_ex;
    reg        slot_manual_is_nop_ex;

    always @(posedge clk) begin
        if (reset) begin
            slot_cycle_pending <= 1'b0;
        end else begin
            slot_cycle_pending <= branch_event_valid;
        end
    end

    always @(posedge clk) begin
        if (reset) begin
            slot_mode_ex          <= SLOT_MODE_MANUAL;
            slot_auto_instr_ex    <= `INST_NOP;
            slot_auto_pc_ex       <= 32'b0;
            slot_nominal_pc_ex    <= 32'b0;
            slot_manual_instr_ex  <= `INST_NOP;
            slot_manual_pc_ex     <= 32'b0;
            slot_manual_is_nop_ex <= 1'b0;
        end else if (branch_event_valid) begin
            slot_mode_ex          <= id_ex_slot_mode;
            slot_auto_instr_ex    <= id_ex_slot_auto_instr;
            slot_auto_pc_ex       <= id_ex_slot_auto_pc;
            slot_nominal_pc_ex    <= id_ex_pc_plus4;
            slot_manual_instr_ex  <= id_ex_slot_manual_instr;
            slot_manual_pc_ex     <= id_ex_slot_manual_pc;
            slot_manual_is_nop_ex <= id_ex_slot_manual_is_nop;
        end
    end

    wire slot_inject_active = slot_cycle_pending && (slot_mode_ex != SLOT_MODE_MANUAL);
    wire [31:0] slot_inject_instr = (slot_mode_ex == SLOT_MODE_AUTO) ? slot_auto_instr_ex : `INST_NOP;
    wire [31:0] slot_inject_pc_value = (slot_mode_ex == SLOT_MODE_AUTO) ? slot_auto_pc_ex : slot_nominal_pc_ex;
    wire [31:0] slot_inject_pc_plus4_value = slot_inject_pc_value + 32'd4;
    wire slot_consumes_pc4 = slot_cycle_pending && (slot_mode_ex == SLOT_MODE_AUTO);
    assign if_flush = hazard_flush_if_id || slot_consumes_pc4;

    assign slot_event_is_nop = (slot_mode_ex == SLOT_MODE_NOP) ||
                               ((slot_mode_ex == SLOT_MODE_MANUAL) && slot_manual_is_nop_ex);
    assign slot_event_is_auto = (slot_mode_ex == SLOT_MODE_AUTO);

    assign id_instr_in    = slot_inject_active ? slot_inject_instr : if_instr;
    assign id_pc_in       = slot_inject_active ? slot_inject_pc_value : if_pc;
    assign id_pc_plus4_in = slot_inject_active ? slot_inject_pc_plus4_value : if_pc_plus4;

    always @(posedge clk) begin
        if (reset) begin
            ex_mem_alu_result      <= 32'b0;
            ex_mem_rt_forward_value<= 32'b0;
            ex_mem_dest_reg        <= 5'b0;
            ex_mem_reg_write       <= 1'b0;
            ex_mem_mem_read        <= 1'b0;
            ex_mem_mem_write       <= 1'b0;
            ex_mem_mem_to_reg      <= 1'b0;
        end else begin
            ex_mem_alu_result       <= ex_alu_result;
            ex_mem_rt_forward_value <= ex_rt_forward_value;
            ex_mem_dest_reg         <= ex_dest_reg;
            ex_mem_reg_write        <= id_ex_reg_write;
            ex_mem_mem_read         <= id_ex_mem_read;
            ex_mem_mem_write        <= id_ex_mem_write;
            ex_mem_mem_to_reg       <= id_ex_mem_to_reg;
        end
    end

    // ------------------------------
    // MEM stage
    // ------------------------------
    wire [31:0] mem_stage_data;
    mem_stage u_mem_stage (
        .mem_read          (ex_mem_mem_read),
        .mem_write         (ex_mem_mem_write),
        .alu_result        (ex_mem_alu_result),
        .rt_forward_value  (ex_mem_rt_forward_value),
        .dmem_we           (dmem_we),
        .dmem_addr         (dmem_addr),
        .dmem_wdata        (dmem_wdata),
        .dmem_rdata        (dmem_rdata),
        .mem_data_out      (mem_stage_data)
    );

    // ------------------------------
    // MEM/WB pipeline register
    // ------------------------------
    reg [31:0] mem_wb_alu_result;
    reg [31:0] mem_wb_data;
    reg [4:0]  mem_wb_dest_reg;
    reg        mem_wb_reg_write;
    reg        mem_wb_mem_to_reg;

    always @(posedge clk) begin
        if (reset) begin
            mem_wb_alu_result <= 32'b0;
            mem_wb_data       <= 32'b0;
            mem_wb_dest_reg   <= 5'b0;
            mem_wb_reg_write  <= 1'b0;
            mem_wb_mem_to_reg <= 1'b0;
        end else begin
            mem_wb_alu_result <= ex_mem_alu_result;
            mem_wb_data       <= mem_stage_data;
            mem_wb_dest_reg   <= ex_mem_dest_reg;
            mem_wb_reg_write  <= ex_mem_reg_write;
            mem_wb_mem_to_reg <= ex_mem_mem_to_reg;
        end
    end

    // ------------------------------
    // WB stage
    // ------------------------------
    wb_stage u_wb_stage (
        .reg_write (mem_wb_reg_write),
        .mem_to_reg(mem_wb_mem_to_reg),
        .dest_reg  (mem_wb_dest_reg),
        .alu_result(mem_wb_alu_result),
        .mem_data  (mem_wb_data),
        .wb_we     (wb_we),
        .wb_addr   (wb_addr),
        .wb_data   (wb_data)
    );

    // ------------------------------
    // Basic statistics counters
    // ------------------------------
    always @(posedge clk) begin
        if (reset) begin
            stat_cycle_count       <= 32'b0;
            stat_branch_count      <= 32'b0;
            stat_slot_manual_count <= 32'b0;
            stat_slot_auto_count   <= 32'b0;
            stat_slot_nop_count    <= 32'b0;
        end else begin
            stat_cycle_count <= stat_cycle_count + 1;
            if (branch_event_valid) begin
                stat_branch_count <= stat_branch_count + 1;
                case (id_ex_slot_mode)
                    SLOT_MODE_MANUAL: begin
                        if (id_ex_slot_manual_is_nop) begin
                            stat_slot_nop_count <= stat_slot_nop_count + 1;
                        end else begin
                            stat_slot_manual_count <= stat_slot_manual_count + 1;
                        end
                    end
                    SLOT_MODE_AUTO: begin
                        stat_slot_auto_count <= stat_slot_auto_count + 1;
                    end
                    default: begin
                        stat_slot_nop_count <= stat_slot_nop_count + 1;
                    end
                endcase
            end
        end
    end
endmodule
