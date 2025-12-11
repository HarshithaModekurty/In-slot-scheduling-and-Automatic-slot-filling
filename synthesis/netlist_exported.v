// Copyright 1986-2022 Xilinx, Inc. All Rights Reserved.
// Copyright 2022-2023 Advanced Micro Devices, Inc. All Rights Reserved.
// --------------------------------------------------------------------------------
// Tool Version: Vivado v.2023.2 (win64) Build 4029153 Fri Oct 13 20:14:34 MDT 2023
// Date        : Thu Nov 20 22:06:34 2025
// Host        : DESKTOP-J3M0MBG running 64-bit major release  (build 9200)
// Command     : write_verilog D:/Delay_branch_project_new/synthesis/synthesis.v
// Design      : core_top
// Purpose     : This is a Verilog netlist of the current design or from a specific cell of the design. The output is an
//               IEEE 1364-2001 compliant Verilog HDL file that contains netlist information obtained from the input
//               design files.
// Device      : xc7z020clg400-1
// --------------------------------------------------------------------------------
`timescale 1 ps / 1 ps

(* STRUCTURAL_NETLIST = "yes" *)
module core_top
   (clk,
    reset,
    branch_event_valid,
    branch_event_pc,
    branch_event_taken,
    slot_event_is_nop,
    slot_event_is_auto,
    stat_cycle_count,
    stat_branch_count,
    stat_slot_manual_count,
    stat_slot_auto_count,
    stat_slot_nop_count);
  input clk;
  input reset;
  output branch_event_valid;
  output [31:0]branch_event_pc;
  output branch_event_taken;
  output slot_event_is_nop;
  output slot_event_is_auto;
  output [31:0]stat_cycle_count;
  output [31:0]stat_branch_count;
  output [31:0]stat_slot_manual_count;
  output [31:0]stat_slot_auto_count;
  output [31:0]stat_slot_nop_count;

  wire \<const0> ;
  wire [31:0]branch_event_pc;
  wire [31:2]branch_event_pc_OBUF;
  wire branch_event_taken;
  wire branch_event_valid;
  wire clk;
  wire clk_IBUF;
  wire clk_IBUF_BUFG;
  wire reset;
  wire reset_IBUF;
  wire slot_event_is_auto;
  wire slot_event_is_nop;
  wire [31:0]stat_branch_count;
  wire [31:0]stat_cycle_count;
  wire [31:0]stat_cycle_count_OBUF;
  wire [31:0]stat_slot_auto_count;
  wire [31:0]stat_slot_manual_count;
  wire [31:0]stat_slot_nop_count;

  GND GND
       (.G(\<const0> ));
  OBUF \branch_event_pc_OBUF[0]_inst 
       (.I(\<const0> ),
        .O(branch_event_pc[0]));
  OBUF \branch_event_pc_OBUF[10]_inst 
       (.I(branch_event_pc_OBUF[10]),
        .O(branch_event_pc[10]));
  OBUF \branch_event_pc_OBUF[11]_inst 
       (.I(branch_event_pc_OBUF[11]),
        .O(branch_event_pc[11]));
  OBUF \branch_event_pc_OBUF[12]_inst 
       (.I(branch_event_pc_OBUF[12]),
        .O(branch_event_pc[12]));
  OBUF \branch_event_pc_OBUF[13]_inst 
       (.I(branch_event_pc_OBUF[13]),
        .O(branch_event_pc[13]));
  OBUF \branch_event_pc_OBUF[14]_inst 
       (.I(branch_event_pc_OBUF[14]),
        .O(branch_event_pc[14]));
  OBUF \branch_event_pc_OBUF[15]_inst 
       (.I(branch_event_pc_OBUF[15]),
        .O(branch_event_pc[15]));
  OBUF \branch_event_pc_OBUF[16]_inst 
       (.I(branch_event_pc_OBUF[16]),
        .O(branch_event_pc[16]));
  OBUF \branch_event_pc_OBUF[17]_inst 
       (.I(branch_event_pc_OBUF[17]),
        .O(branch_event_pc[17]));
  OBUF \branch_event_pc_OBUF[18]_inst 
       (.I(branch_event_pc_OBUF[18]),
        .O(branch_event_pc[18]));
  OBUF \branch_event_pc_OBUF[19]_inst 
       (.I(branch_event_pc_OBUF[19]),
        .O(branch_event_pc[19]));
  OBUF \branch_event_pc_OBUF[1]_inst 
       (.I(\<const0> ),
        .O(branch_event_pc[1]));
  OBUF \branch_event_pc_OBUF[20]_inst 
       (.I(branch_event_pc_OBUF[20]),
        .O(branch_event_pc[20]));
  OBUF \branch_event_pc_OBUF[21]_inst 
       (.I(branch_event_pc_OBUF[21]),
        .O(branch_event_pc[21]));
  OBUF \branch_event_pc_OBUF[22]_inst 
       (.I(branch_event_pc_OBUF[22]),
        .O(branch_event_pc[22]));
  OBUF \branch_event_pc_OBUF[23]_inst 
       (.I(branch_event_pc_OBUF[23]),
        .O(branch_event_pc[23]));
  OBUF \branch_event_pc_OBUF[24]_inst 
       (.I(branch_event_pc_OBUF[24]),
        .O(branch_event_pc[24]));
  OBUF \branch_event_pc_OBUF[25]_inst 
       (.I(branch_event_pc_OBUF[25]),
        .O(branch_event_pc[25]));
  OBUF \branch_event_pc_OBUF[26]_inst 
       (.I(branch_event_pc_OBUF[26]),
        .O(branch_event_pc[26]));
  OBUF \branch_event_pc_OBUF[27]_inst 
       (.I(branch_event_pc_OBUF[27]),
        .O(branch_event_pc[27]));
  OBUF \branch_event_pc_OBUF[28]_inst 
       (.I(branch_event_pc_OBUF[28]),
        .O(branch_event_pc[28]));
  OBUF \branch_event_pc_OBUF[29]_inst 
       (.I(branch_event_pc_OBUF[29]),
        .O(branch_event_pc[29]));
  OBUF \branch_event_pc_OBUF[2]_inst 
       (.I(branch_event_pc_OBUF[2]),
        .O(branch_event_pc[2]));
  OBUF \branch_event_pc_OBUF[30]_inst 
       (.I(branch_event_pc_OBUF[30]),
        .O(branch_event_pc[30]));
  OBUF \branch_event_pc_OBUF[31]_inst 
       (.I(branch_event_pc_OBUF[31]),
        .O(branch_event_pc[31]));
  OBUF \branch_event_pc_OBUF[3]_inst 
       (.I(branch_event_pc_OBUF[3]),
        .O(branch_event_pc[3]));
  OBUF \branch_event_pc_OBUF[4]_inst 
       (.I(branch_event_pc_OBUF[4]),
        .O(branch_event_pc[4]));
  OBUF \branch_event_pc_OBUF[5]_inst 
       (.I(branch_event_pc_OBUF[5]),
        .O(branch_event_pc[5]));
  OBUF \branch_event_pc_OBUF[6]_inst 
       (.I(branch_event_pc_OBUF[6]),
        .O(branch_event_pc[6]));
  OBUF \branch_event_pc_OBUF[7]_inst 
       (.I(branch_event_pc_OBUF[7]),
        .O(branch_event_pc[7]));
  OBUF \branch_event_pc_OBUF[8]_inst 
       (.I(branch_event_pc_OBUF[8]),
        .O(branch_event_pc[8]));
  OBUF \branch_event_pc_OBUF[9]_inst 
       (.I(branch_event_pc_OBUF[9]),
        .O(branch_event_pc[9]));
  OBUF branch_event_taken_OBUF_inst
       (.I(\<const0> ),
        .O(branch_event_taken));
  OBUF branch_event_valid_OBUF_inst
       (.I(\<const0> ),
        .O(branch_event_valid));
  BUFG clk_IBUF_BUFG_inst
       (.I(clk_IBUF),
        .O(clk_IBUF_BUFG));
  IBUF clk_IBUF_inst
       (.I(clk),
        .O(clk_IBUF));
  IBUF reset_IBUF_inst
       (.I(reset),
        .O(reset_IBUF));
  OBUF slot_event_is_auto_OBUF_inst
       (.I(\<const0> ),
        .O(slot_event_is_auto));
  OBUF slot_event_is_nop_OBUF_inst
       (.I(\<const0> ),
        .O(slot_event_is_nop));
  OBUF \stat_branch_count_OBUF[0]_inst 
       (.I(\<const0> ),
        .O(stat_branch_count[0]));
  OBUF \stat_branch_count_OBUF[10]_inst 
       (.I(\<const0> ),
        .O(stat_branch_count[10]));
  OBUF \stat_branch_count_OBUF[11]_inst 
       (.I(\<const0> ),
        .O(stat_branch_count[11]));
  OBUF \stat_branch_count_OBUF[12]_inst 
       (.I(\<const0> ),
        .O(stat_branch_count[12]));
  OBUF \stat_branch_count_OBUF[13]_inst 
       (.I(\<const0> ),
        .O(stat_branch_count[13]));
  OBUF \stat_branch_count_OBUF[14]_inst 
       (.I(\<const0> ),
        .O(stat_branch_count[14]));
  OBUF \stat_branch_count_OBUF[15]_inst 
       (.I(\<const0> ),
        .O(stat_branch_count[15]));
  OBUF \stat_branch_count_OBUF[16]_inst 
       (.I(\<const0> ),
        .O(stat_branch_count[16]));
  OBUF \stat_branch_count_OBUF[17]_inst 
       (.I(\<const0> ),
        .O(stat_branch_count[17]));
  OBUF \stat_branch_count_OBUF[18]_inst 
       (.I(\<const0> ),
        .O(stat_branch_count[18]));
  OBUF \stat_branch_count_OBUF[19]_inst 
       (.I(\<const0> ),
        .O(stat_branch_count[19]));
  OBUF \stat_branch_count_OBUF[1]_inst 
       (.I(\<const0> ),
        .O(stat_branch_count[1]));
  OBUF \stat_branch_count_OBUF[20]_inst 
       (.I(\<const0> ),
        .O(stat_branch_count[20]));
  OBUF \stat_branch_count_OBUF[21]_inst 
       (.I(\<const0> ),
        .O(stat_branch_count[21]));
  OBUF \stat_branch_count_OBUF[22]_inst 
       (.I(\<const0> ),
        .O(stat_branch_count[22]));
  OBUF \stat_branch_count_OBUF[23]_inst 
       (.I(\<const0> ),
        .O(stat_branch_count[23]));
  OBUF \stat_branch_count_OBUF[24]_inst 
       (.I(\<const0> ),
        .O(stat_branch_count[24]));
  OBUF \stat_branch_count_OBUF[25]_inst 
       (.I(\<const0> ),
        .O(stat_branch_count[25]));
  OBUF \stat_branch_count_OBUF[26]_inst 
       (.I(\<const0> ),
        .O(stat_branch_count[26]));
  OBUF \stat_branch_count_OBUF[27]_inst 
       (.I(\<const0> ),
        .O(stat_branch_count[27]));
  OBUF \stat_branch_count_OBUF[28]_inst 
       (.I(\<const0> ),
        .O(stat_branch_count[28]));
  OBUF \stat_branch_count_OBUF[29]_inst 
       (.I(\<const0> ),
        .O(stat_branch_count[29]));
  OBUF \stat_branch_count_OBUF[2]_inst 
       (.I(\<const0> ),
        .O(stat_branch_count[2]));
  OBUF \stat_branch_count_OBUF[30]_inst 
       (.I(\<const0> ),
        .O(stat_branch_count[30]));
  OBUF \stat_branch_count_OBUF[31]_inst 
       (.I(\<const0> ),
        .O(stat_branch_count[31]));
  OBUF \stat_branch_count_OBUF[3]_inst 
       (.I(\<const0> ),
        .O(stat_branch_count[3]));
  OBUF \stat_branch_count_OBUF[4]_inst 
       (.I(\<const0> ),
        .O(stat_branch_count[4]));
  OBUF \stat_branch_count_OBUF[5]_inst 
       (.I(\<const0> ),
        .O(stat_branch_count[5]));
  OBUF \stat_branch_count_OBUF[6]_inst 
       (.I(\<const0> ),
        .O(stat_branch_count[6]));
  OBUF \stat_branch_count_OBUF[7]_inst 
       (.I(\<const0> ),
        .O(stat_branch_count[7]));
  OBUF \stat_branch_count_OBUF[8]_inst 
       (.I(\<const0> ),
        .O(stat_branch_count[8]));
  OBUF \stat_branch_count_OBUF[9]_inst 
       (.I(\<const0> ),
        .O(stat_branch_count[9]));
  OBUF \stat_cycle_count_OBUF[0]_inst 
       (.I(stat_cycle_count_OBUF[0]),
        .O(stat_cycle_count[0]));
  OBUF \stat_cycle_count_OBUF[10]_inst 
       (.I(stat_cycle_count_OBUF[10]),
        .O(stat_cycle_count[10]));
  OBUF \stat_cycle_count_OBUF[11]_inst 
       (.I(stat_cycle_count_OBUF[11]),
        .O(stat_cycle_count[11]));
  OBUF \stat_cycle_count_OBUF[12]_inst 
       (.I(stat_cycle_count_OBUF[12]),
        .O(stat_cycle_count[12]));
  OBUF \stat_cycle_count_OBUF[13]_inst 
       (.I(stat_cycle_count_OBUF[13]),
        .O(stat_cycle_count[13]));
  OBUF \stat_cycle_count_OBUF[14]_inst 
       (.I(stat_cycle_count_OBUF[14]),
        .O(stat_cycle_count[14]));
  OBUF \stat_cycle_count_OBUF[15]_inst 
       (.I(stat_cycle_count_OBUF[15]),
        .O(stat_cycle_count[15]));
  OBUF \stat_cycle_count_OBUF[16]_inst 
       (.I(stat_cycle_count_OBUF[16]),
        .O(stat_cycle_count[16]));
  OBUF \stat_cycle_count_OBUF[17]_inst 
       (.I(stat_cycle_count_OBUF[17]),
        .O(stat_cycle_count[17]));
  OBUF \stat_cycle_count_OBUF[18]_inst 
       (.I(stat_cycle_count_OBUF[18]),
        .O(stat_cycle_count[18]));
  OBUF \stat_cycle_count_OBUF[19]_inst 
       (.I(stat_cycle_count_OBUF[19]),
        .O(stat_cycle_count[19]));
  OBUF \stat_cycle_count_OBUF[1]_inst 
       (.I(stat_cycle_count_OBUF[1]),
        .O(stat_cycle_count[1]));
  OBUF \stat_cycle_count_OBUF[20]_inst 
       (.I(stat_cycle_count_OBUF[20]),
        .O(stat_cycle_count[20]));
  OBUF \stat_cycle_count_OBUF[21]_inst 
       (.I(stat_cycle_count_OBUF[21]),
        .O(stat_cycle_count[21]));
  OBUF \stat_cycle_count_OBUF[22]_inst 
       (.I(stat_cycle_count_OBUF[22]),
        .O(stat_cycle_count[22]));
  OBUF \stat_cycle_count_OBUF[23]_inst 
       (.I(stat_cycle_count_OBUF[23]),
        .O(stat_cycle_count[23]));
  OBUF \stat_cycle_count_OBUF[24]_inst 
       (.I(stat_cycle_count_OBUF[24]),
        .O(stat_cycle_count[24]));
  OBUF \stat_cycle_count_OBUF[25]_inst 
       (.I(stat_cycle_count_OBUF[25]),
        .O(stat_cycle_count[25]));
  OBUF \stat_cycle_count_OBUF[26]_inst 
       (.I(stat_cycle_count_OBUF[26]),
        .O(stat_cycle_count[26]));
  OBUF \stat_cycle_count_OBUF[27]_inst 
       (.I(stat_cycle_count_OBUF[27]),
        .O(stat_cycle_count[27]));
  OBUF \stat_cycle_count_OBUF[28]_inst 
       (.I(stat_cycle_count_OBUF[28]),
        .O(stat_cycle_count[28]));
  OBUF \stat_cycle_count_OBUF[29]_inst 
       (.I(stat_cycle_count_OBUF[29]),
        .O(stat_cycle_count[29]));
  OBUF \stat_cycle_count_OBUF[2]_inst 
       (.I(stat_cycle_count_OBUF[2]),
        .O(stat_cycle_count[2]));
  OBUF \stat_cycle_count_OBUF[30]_inst 
       (.I(stat_cycle_count_OBUF[30]),
        .O(stat_cycle_count[30]));
  OBUF \stat_cycle_count_OBUF[31]_inst 
       (.I(stat_cycle_count_OBUF[31]),
        .O(stat_cycle_count[31]));
  OBUF \stat_cycle_count_OBUF[3]_inst 
       (.I(stat_cycle_count_OBUF[3]),
        .O(stat_cycle_count[3]));
  OBUF \stat_cycle_count_OBUF[4]_inst 
       (.I(stat_cycle_count_OBUF[4]),
        .O(stat_cycle_count[4]));
  OBUF \stat_cycle_count_OBUF[5]_inst 
       (.I(stat_cycle_count_OBUF[5]),
        .O(stat_cycle_count[5]));
  OBUF \stat_cycle_count_OBUF[6]_inst 
       (.I(stat_cycle_count_OBUF[6]),
        .O(stat_cycle_count[6]));
  OBUF \stat_cycle_count_OBUF[7]_inst 
       (.I(stat_cycle_count_OBUF[7]),
        .O(stat_cycle_count[7]));
  OBUF \stat_cycle_count_OBUF[8]_inst 
       (.I(stat_cycle_count_OBUF[8]),
        .O(stat_cycle_count[8]));
  OBUF \stat_cycle_count_OBUF[9]_inst 
       (.I(stat_cycle_count_OBUF[9]),
        .O(stat_cycle_count[9]));
  OBUF \stat_slot_auto_count_OBUF[0]_inst 
       (.I(\<const0> ),
        .O(stat_slot_auto_count[0]));
  OBUF \stat_slot_auto_count_OBUF[10]_inst 
       (.I(\<const0> ),
        .O(stat_slot_auto_count[10]));
  OBUF \stat_slot_auto_count_OBUF[11]_inst 
       (.I(\<const0> ),
        .O(stat_slot_auto_count[11]));
  OBUF \stat_slot_auto_count_OBUF[12]_inst 
       (.I(\<const0> ),
        .O(stat_slot_auto_count[12]));
  OBUF \stat_slot_auto_count_OBUF[13]_inst 
       (.I(\<const0> ),
        .O(stat_slot_auto_count[13]));
  OBUF \stat_slot_auto_count_OBUF[14]_inst 
       (.I(\<const0> ),
        .O(stat_slot_auto_count[14]));
  OBUF \stat_slot_auto_count_OBUF[15]_inst 
       (.I(\<const0> ),
        .O(stat_slot_auto_count[15]));
  OBUF \stat_slot_auto_count_OBUF[16]_inst 
       (.I(\<const0> ),
        .O(stat_slot_auto_count[16]));
  OBUF \stat_slot_auto_count_OBUF[17]_inst 
       (.I(\<const0> ),
        .O(stat_slot_auto_count[17]));
  OBUF \stat_slot_auto_count_OBUF[18]_inst 
       (.I(\<const0> ),
        .O(stat_slot_auto_count[18]));
  OBUF \stat_slot_auto_count_OBUF[19]_inst 
       (.I(\<const0> ),
        .O(stat_slot_auto_count[19]));
  OBUF \stat_slot_auto_count_OBUF[1]_inst 
       (.I(\<const0> ),
        .O(stat_slot_auto_count[1]));
  OBUF \stat_slot_auto_count_OBUF[20]_inst 
       (.I(\<const0> ),
        .O(stat_slot_auto_count[20]));
  OBUF \stat_slot_auto_count_OBUF[21]_inst 
       (.I(\<const0> ),
        .O(stat_slot_auto_count[21]));
  OBUF \stat_slot_auto_count_OBUF[22]_inst 
       (.I(\<const0> ),
        .O(stat_slot_auto_count[22]));
  OBUF \stat_slot_auto_count_OBUF[23]_inst 
       (.I(\<const0> ),
        .O(stat_slot_auto_count[23]));
  OBUF \stat_slot_auto_count_OBUF[24]_inst 
       (.I(\<const0> ),
        .O(stat_slot_auto_count[24]));
  OBUF \stat_slot_auto_count_OBUF[25]_inst 
       (.I(\<const0> ),
        .O(stat_slot_auto_count[25]));
  OBUF \stat_slot_auto_count_OBUF[26]_inst 
       (.I(\<const0> ),
        .O(stat_slot_auto_count[26]));
  OBUF \stat_slot_auto_count_OBUF[27]_inst 
       (.I(\<const0> ),
        .O(stat_slot_auto_count[27]));
  OBUF \stat_slot_auto_count_OBUF[28]_inst 
       (.I(\<const0> ),
        .O(stat_slot_auto_count[28]));
  OBUF \stat_slot_auto_count_OBUF[29]_inst 
       (.I(\<const0> ),
        .O(stat_slot_auto_count[29]));
  OBUF \stat_slot_auto_count_OBUF[2]_inst 
       (.I(\<const0> ),
        .O(stat_slot_auto_count[2]));
  OBUF \stat_slot_auto_count_OBUF[30]_inst 
       (.I(\<const0> ),
        .O(stat_slot_auto_count[30]));
  OBUF \stat_slot_auto_count_OBUF[31]_inst 
       (.I(\<const0> ),
        .O(stat_slot_auto_count[31]));
  OBUF \stat_slot_auto_count_OBUF[3]_inst 
       (.I(\<const0> ),
        .O(stat_slot_auto_count[3]));
  OBUF \stat_slot_auto_count_OBUF[4]_inst 
       (.I(\<const0> ),
        .O(stat_slot_auto_count[4]));
  OBUF \stat_slot_auto_count_OBUF[5]_inst 
       (.I(\<const0> ),
        .O(stat_slot_auto_count[5]));
  OBUF \stat_slot_auto_count_OBUF[6]_inst 
       (.I(\<const0> ),
        .O(stat_slot_auto_count[6]));
  OBUF \stat_slot_auto_count_OBUF[7]_inst 
       (.I(\<const0> ),
        .O(stat_slot_auto_count[7]));
  OBUF \stat_slot_auto_count_OBUF[8]_inst 
       (.I(\<const0> ),
        .O(stat_slot_auto_count[8]));
  OBUF \stat_slot_auto_count_OBUF[9]_inst 
       (.I(\<const0> ),
        .O(stat_slot_auto_count[9]));
  OBUF \stat_slot_manual_count_OBUF[0]_inst 
       (.I(\<const0> ),
        .O(stat_slot_manual_count[0]));
  OBUF \stat_slot_manual_count_OBUF[10]_inst 
       (.I(\<const0> ),
        .O(stat_slot_manual_count[10]));
  OBUF \stat_slot_manual_count_OBUF[11]_inst 
       (.I(\<const0> ),
        .O(stat_slot_manual_count[11]));
  OBUF \stat_slot_manual_count_OBUF[12]_inst 
       (.I(\<const0> ),
        .O(stat_slot_manual_count[12]));
  OBUF \stat_slot_manual_count_OBUF[13]_inst 
       (.I(\<const0> ),
        .O(stat_slot_manual_count[13]));
  OBUF \stat_slot_manual_count_OBUF[14]_inst 
       (.I(\<const0> ),
        .O(stat_slot_manual_count[14]));
  OBUF \stat_slot_manual_count_OBUF[15]_inst 
       (.I(\<const0> ),
        .O(stat_slot_manual_count[15]));
  OBUF \stat_slot_manual_count_OBUF[16]_inst 
       (.I(\<const0> ),
        .O(stat_slot_manual_count[16]));
  OBUF \stat_slot_manual_count_OBUF[17]_inst 
       (.I(\<const0> ),
        .O(stat_slot_manual_count[17]));
  OBUF \stat_slot_manual_count_OBUF[18]_inst 
       (.I(\<const0> ),
        .O(stat_slot_manual_count[18]));
  OBUF \stat_slot_manual_count_OBUF[19]_inst 
       (.I(\<const0> ),
        .O(stat_slot_manual_count[19]));
  OBUF \stat_slot_manual_count_OBUF[1]_inst 
       (.I(\<const0> ),
        .O(stat_slot_manual_count[1]));
  OBUF \stat_slot_manual_count_OBUF[20]_inst 
       (.I(\<const0> ),
        .O(stat_slot_manual_count[20]));
  OBUF \stat_slot_manual_count_OBUF[21]_inst 
       (.I(\<const0> ),
        .O(stat_slot_manual_count[21]));
  OBUF \stat_slot_manual_count_OBUF[22]_inst 
       (.I(\<const0> ),
        .O(stat_slot_manual_count[22]));
  OBUF \stat_slot_manual_count_OBUF[23]_inst 
       (.I(\<const0> ),
        .O(stat_slot_manual_count[23]));
  OBUF \stat_slot_manual_count_OBUF[24]_inst 
       (.I(\<const0> ),
        .O(stat_slot_manual_count[24]));
  OBUF \stat_slot_manual_count_OBUF[25]_inst 
       (.I(\<const0> ),
        .O(stat_slot_manual_count[25]));
  OBUF \stat_slot_manual_count_OBUF[26]_inst 
       (.I(\<const0> ),
        .O(stat_slot_manual_count[26]));
  OBUF \stat_slot_manual_count_OBUF[27]_inst 
       (.I(\<const0> ),
        .O(stat_slot_manual_count[27]));
  OBUF \stat_slot_manual_count_OBUF[28]_inst 
       (.I(\<const0> ),
        .O(stat_slot_manual_count[28]));
  OBUF \stat_slot_manual_count_OBUF[29]_inst 
       (.I(\<const0> ),
        .O(stat_slot_manual_count[29]));
  OBUF \stat_slot_manual_count_OBUF[2]_inst 
       (.I(\<const0> ),
        .O(stat_slot_manual_count[2]));
  OBUF \stat_slot_manual_count_OBUF[30]_inst 
       (.I(\<const0> ),
        .O(stat_slot_manual_count[30]));
  OBUF \stat_slot_manual_count_OBUF[31]_inst 
       (.I(\<const0> ),
        .O(stat_slot_manual_count[31]));
  OBUF \stat_slot_manual_count_OBUF[3]_inst 
       (.I(\<const0> ),
        .O(stat_slot_manual_count[3]));
  OBUF \stat_slot_manual_count_OBUF[4]_inst 
       (.I(\<const0> ),
        .O(stat_slot_manual_count[4]));
  OBUF \stat_slot_manual_count_OBUF[5]_inst 
       (.I(\<const0> ),
        .O(stat_slot_manual_count[5]));
  OBUF \stat_slot_manual_count_OBUF[6]_inst 
       (.I(\<const0> ),
        .O(stat_slot_manual_count[6]));
  OBUF \stat_slot_manual_count_OBUF[7]_inst 
       (.I(\<const0> ),
        .O(stat_slot_manual_count[7]));
  OBUF \stat_slot_manual_count_OBUF[8]_inst 
       (.I(\<const0> ),
        .O(stat_slot_manual_count[8]));
  OBUF \stat_slot_manual_count_OBUF[9]_inst 
       (.I(\<const0> ),
        .O(stat_slot_manual_count[9]));
  OBUF \stat_slot_nop_count_OBUF[0]_inst 
       (.I(\<const0> ),
        .O(stat_slot_nop_count[0]));
  OBUF \stat_slot_nop_count_OBUF[10]_inst 
       (.I(\<const0> ),
        .O(stat_slot_nop_count[10]));
  OBUF \stat_slot_nop_count_OBUF[11]_inst 
       (.I(\<const0> ),
        .O(stat_slot_nop_count[11]));
  OBUF \stat_slot_nop_count_OBUF[12]_inst 
       (.I(\<const0> ),
        .O(stat_slot_nop_count[12]));
  OBUF \stat_slot_nop_count_OBUF[13]_inst 
       (.I(\<const0> ),
        .O(stat_slot_nop_count[13]));
  OBUF \stat_slot_nop_count_OBUF[14]_inst 
       (.I(\<const0> ),
        .O(stat_slot_nop_count[14]));
  OBUF \stat_slot_nop_count_OBUF[15]_inst 
       (.I(\<const0> ),
        .O(stat_slot_nop_count[15]));
  OBUF \stat_slot_nop_count_OBUF[16]_inst 
       (.I(\<const0> ),
        .O(stat_slot_nop_count[16]));
  OBUF \stat_slot_nop_count_OBUF[17]_inst 
       (.I(\<const0> ),
        .O(stat_slot_nop_count[17]));
  OBUF \stat_slot_nop_count_OBUF[18]_inst 
       (.I(\<const0> ),
        .O(stat_slot_nop_count[18]));
  OBUF \stat_slot_nop_count_OBUF[19]_inst 
       (.I(\<const0> ),
        .O(stat_slot_nop_count[19]));
  OBUF \stat_slot_nop_count_OBUF[1]_inst 
       (.I(\<const0> ),
        .O(stat_slot_nop_count[1]));
  OBUF \stat_slot_nop_count_OBUF[20]_inst 
       (.I(\<const0> ),
        .O(stat_slot_nop_count[20]));
  OBUF \stat_slot_nop_count_OBUF[21]_inst 
       (.I(\<const0> ),
        .O(stat_slot_nop_count[21]));
  OBUF \stat_slot_nop_count_OBUF[22]_inst 
       (.I(\<const0> ),
        .O(stat_slot_nop_count[22]));
  OBUF \stat_slot_nop_count_OBUF[23]_inst 
       (.I(\<const0> ),
        .O(stat_slot_nop_count[23]));
  OBUF \stat_slot_nop_count_OBUF[24]_inst 
       (.I(\<const0> ),
        .O(stat_slot_nop_count[24]));
  OBUF \stat_slot_nop_count_OBUF[25]_inst 
       (.I(\<const0> ),
        .O(stat_slot_nop_count[25]));
  OBUF \stat_slot_nop_count_OBUF[26]_inst 
       (.I(\<const0> ),
        .O(stat_slot_nop_count[26]));
  OBUF \stat_slot_nop_count_OBUF[27]_inst 
       (.I(\<const0> ),
        .O(stat_slot_nop_count[27]));
  OBUF \stat_slot_nop_count_OBUF[28]_inst 
       (.I(\<const0> ),
        .O(stat_slot_nop_count[28]));
  OBUF \stat_slot_nop_count_OBUF[29]_inst 
       (.I(\<const0> ),
        .O(stat_slot_nop_count[29]));
  OBUF \stat_slot_nop_count_OBUF[2]_inst 
       (.I(\<const0> ),
        .O(stat_slot_nop_count[2]));
  OBUF \stat_slot_nop_count_OBUF[30]_inst 
       (.I(\<const0> ),
        .O(stat_slot_nop_count[30]));
  OBUF \stat_slot_nop_count_OBUF[31]_inst 
       (.I(\<const0> ),
        .O(stat_slot_nop_count[31]));
  OBUF \stat_slot_nop_count_OBUF[3]_inst 
       (.I(\<const0> ),
        .O(stat_slot_nop_count[3]));
  OBUF \stat_slot_nop_count_OBUF[4]_inst 
       (.I(\<const0> ),
        .O(stat_slot_nop_count[4]));
  OBUF \stat_slot_nop_count_OBUF[5]_inst 
       (.I(\<const0> ),
        .O(stat_slot_nop_count[5]));
  OBUF \stat_slot_nop_count_OBUF[6]_inst 
       (.I(\<const0> ),
        .O(stat_slot_nop_count[6]));
  OBUF \stat_slot_nop_count_OBUF[7]_inst 
       (.I(\<const0> ),
        .O(stat_slot_nop_count[7]));
  OBUF \stat_slot_nop_count_OBUF[8]_inst 
       (.I(\<const0> ),
        .O(stat_slot_nop_count[8]));
  OBUF \stat_slot_nop_count_OBUF[9]_inst 
       (.I(\<const0> ),
        .O(stat_slot_nop_count[9]));
  cpu_pipeline u_cpu
       (.branch_event_pc_OBUF(branch_event_pc_OBUF),
        .clk_IBUF_BUFG(clk_IBUF_BUFG),
        .reset_IBUF(reset_IBUF),
        .stat_cycle_count(stat_cycle_count_OBUF));
endmodule

module cpu_pipeline
   (branch_event_pc_OBUF,
    stat_cycle_count,
    reset_IBUF,
    clk_IBUF_BUFG);
  output [29:0]branch_event_pc_OBUF;
  output [31:0]stat_cycle_count;
  input reset_IBUF;
  input clk_IBUF_BUFG;

  wire \<const0> ;
  wire \<const1> ;
  wire [29:0]branch_event_pc_OBUF;
  wire clk_IBUF_BUFG;
  wire [31:2]if_pc;
  wire reset_IBUF;
  wire [31:0]stat_cycle_count;
  wire \stat_cycle_count[0]_i_2_n_0 ;
  wire \stat_cycle_count_reg[0]_i_1_n_0 ;
  wire \stat_cycle_count_reg[0]_i_1_n_1 ;
  wire \stat_cycle_count_reg[0]_i_1_n_2 ;
  wire \stat_cycle_count_reg[0]_i_1_n_3 ;
  wire \stat_cycle_count_reg[0]_i_1_n_4 ;
  wire \stat_cycle_count_reg[0]_i_1_n_5 ;
  wire \stat_cycle_count_reg[0]_i_1_n_6 ;
  wire \stat_cycle_count_reg[0]_i_1_n_7 ;
  wire \stat_cycle_count_reg[12]_i_1_n_0 ;
  wire \stat_cycle_count_reg[12]_i_1_n_1 ;
  wire \stat_cycle_count_reg[12]_i_1_n_2 ;
  wire \stat_cycle_count_reg[12]_i_1_n_3 ;
  wire \stat_cycle_count_reg[12]_i_1_n_4 ;
  wire \stat_cycle_count_reg[12]_i_1_n_5 ;
  wire \stat_cycle_count_reg[12]_i_1_n_6 ;
  wire \stat_cycle_count_reg[12]_i_1_n_7 ;
  wire \stat_cycle_count_reg[16]_i_1_n_0 ;
  wire \stat_cycle_count_reg[16]_i_1_n_1 ;
  wire \stat_cycle_count_reg[16]_i_1_n_2 ;
  wire \stat_cycle_count_reg[16]_i_1_n_3 ;
  wire \stat_cycle_count_reg[16]_i_1_n_4 ;
  wire \stat_cycle_count_reg[16]_i_1_n_5 ;
  wire \stat_cycle_count_reg[16]_i_1_n_6 ;
  wire \stat_cycle_count_reg[16]_i_1_n_7 ;
  wire \stat_cycle_count_reg[20]_i_1_n_0 ;
  wire \stat_cycle_count_reg[20]_i_1_n_1 ;
  wire \stat_cycle_count_reg[20]_i_1_n_2 ;
  wire \stat_cycle_count_reg[20]_i_1_n_3 ;
  wire \stat_cycle_count_reg[20]_i_1_n_4 ;
  wire \stat_cycle_count_reg[20]_i_1_n_5 ;
  wire \stat_cycle_count_reg[20]_i_1_n_6 ;
  wire \stat_cycle_count_reg[20]_i_1_n_7 ;
  wire \stat_cycle_count_reg[24]_i_1_n_0 ;
  wire \stat_cycle_count_reg[24]_i_1_n_1 ;
  wire \stat_cycle_count_reg[24]_i_1_n_2 ;
  wire \stat_cycle_count_reg[24]_i_1_n_3 ;
  wire \stat_cycle_count_reg[24]_i_1_n_4 ;
  wire \stat_cycle_count_reg[24]_i_1_n_5 ;
  wire \stat_cycle_count_reg[24]_i_1_n_6 ;
  wire \stat_cycle_count_reg[24]_i_1_n_7 ;
  wire \stat_cycle_count_reg[28]_i_1_n_1 ;
  wire \stat_cycle_count_reg[28]_i_1_n_2 ;
  wire \stat_cycle_count_reg[28]_i_1_n_3 ;
  wire \stat_cycle_count_reg[28]_i_1_n_4 ;
  wire \stat_cycle_count_reg[28]_i_1_n_5 ;
  wire \stat_cycle_count_reg[28]_i_1_n_6 ;
  wire \stat_cycle_count_reg[28]_i_1_n_7 ;
  wire \stat_cycle_count_reg[4]_i_1_n_0 ;
  wire \stat_cycle_count_reg[4]_i_1_n_1 ;
  wire \stat_cycle_count_reg[4]_i_1_n_2 ;
  wire \stat_cycle_count_reg[4]_i_1_n_3 ;
  wire \stat_cycle_count_reg[4]_i_1_n_4 ;
  wire \stat_cycle_count_reg[4]_i_1_n_5 ;
  wire \stat_cycle_count_reg[4]_i_1_n_6 ;
  wire \stat_cycle_count_reg[4]_i_1_n_7 ;
  wire \stat_cycle_count_reg[8]_i_1_n_0 ;
  wire \stat_cycle_count_reg[8]_i_1_n_1 ;
  wire \stat_cycle_count_reg[8]_i_1_n_2 ;
  wire \stat_cycle_count_reg[8]_i_1_n_3 ;
  wire \stat_cycle_count_reg[8]_i_1_n_4 ;
  wire \stat_cycle_count_reg[8]_i_1_n_5 ;
  wire \stat_cycle_count_reg[8]_i_1_n_6 ;
  wire \stat_cycle_count_reg[8]_i_1_n_7 ;

  GND GND
       (.G(\<const0> ));
  VCC VCC
       (.P(\<const1> ));
  FDRE #(
    .INIT(1'b0)) 
    \id_ex_pc_reg[10] 
       (.C(clk_IBUF_BUFG),
        .CE(\<const1> ),
        .D(if_pc[10]),
        .Q(branch_event_pc_OBUF[8]),
        .R(reset_IBUF));
  FDRE #(
    .INIT(1'b0)) 
    \id_ex_pc_reg[11] 
       (.C(clk_IBUF_BUFG),
        .CE(\<const1> ),
        .D(if_pc[11]),
        .Q(branch_event_pc_OBUF[9]),
        .R(reset_IBUF));
  FDRE #(
    .INIT(1'b0)) 
    \id_ex_pc_reg[12] 
       (.C(clk_IBUF_BUFG),
        .CE(\<const1> ),
        .D(if_pc[12]),
        .Q(branch_event_pc_OBUF[10]),
        .R(reset_IBUF));
  FDRE #(
    .INIT(1'b0)) 
    \id_ex_pc_reg[13] 
       (.C(clk_IBUF_BUFG),
        .CE(\<const1> ),
        .D(if_pc[13]),
        .Q(branch_event_pc_OBUF[11]),
        .R(reset_IBUF));
  FDRE #(
    .INIT(1'b0)) 
    \id_ex_pc_reg[14] 
       (.C(clk_IBUF_BUFG),
        .CE(\<const1> ),
        .D(if_pc[14]),
        .Q(branch_event_pc_OBUF[12]),
        .R(reset_IBUF));
  FDRE #(
    .INIT(1'b0)) 
    \id_ex_pc_reg[15] 
       (.C(clk_IBUF_BUFG),
        .CE(\<const1> ),
        .D(if_pc[15]),
        .Q(branch_event_pc_OBUF[13]),
        .R(reset_IBUF));
  FDRE #(
    .INIT(1'b0)) 
    \id_ex_pc_reg[16] 
       (.C(clk_IBUF_BUFG),
        .CE(\<const1> ),
        .D(if_pc[16]),
        .Q(branch_event_pc_OBUF[14]),
        .R(reset_IBUF));
  FDRE #(
    .INIT(1'b0)) 
    \id_ex_pc_reg[17] 
       (.C(clk_IBUF_BUFG),
        .CE(\<const1> ),
        .D(if_pc[17]),
        .Q(branch_event_pc_OBUF[15]),
        .R(reset_IBUF));
  FDRE #(
    .INIT(1'b0)) 
    \id_ex_pc_reg[18] 
       (.C(clk_IBUF_BUFG),
        .CE(\<const1> ),
        .D(if_pc[18]),
        .Q(branch_event_pc_OBUF[16]),
        .R(reset_IBUF));
  FDRE #(
    .INIT(1'b0)) 
    \id_ex_pc_reg[19] 
       (.C(clk_IBUF_BUFG),
        .CE(\<const1> ),
        .D(if_pc[19]),
        .Q(branch_event_pc_OBUF[17]),
        .R(reset_IBUF));
  FDRE #(
    .INIT(1'b0)) 
    \id_ex_pc_reg[20] 
       (.C(clk_IBUF_BUFG),
        .CE(\<const1> ),
        .D(if_pc[20]),
        .Q(branch_event_pc_OBUF[18]),
        .R(reset_IBUF));
  FDRE #(
    .INIT(1'b0)) 
    \id_ex_pc_reg[21] 
       (.C(clk_IBUF_BUFG),
        .CE(\<const1> ),
        .D(if_pc[21]),
        .Q(branch_event_pc_OBUF[19]),
        .R(reset_IBUF));
  FDRE #(
    .INIT(1'b0)) 
    \id_ex_pc_reg[22] 
       (.C(clk_IBUF_BUFG),
        .CE(\<const1> ),
        .D(if_pc[22]),
        .Q(branch_event_pc_OBUF[20]),
        .R(reset_IBUF));
  FDRE #(
    .INIT(1'b0)) 
    \id_ex_pc_reg[23] 
       (.C(clk_IBUF_BUFG),
        .CE(\<const1> ),
        .D(if_pc[23]),
        .Q(branch_event_pc_OBUF[21]),
        .R(reset_IBUF));
  FDRE #(
    .INIT(1'b0)) 
    \id_ex_pc_reg[24] 
       (.C(clk_IBUF_BUFG),
        .CE(\<const1> ),
        .D(if_pc[24]),
        .Q(branch_event_pc_OBUF[22]),
        .R(reset_IBUF));
  FDRE #(
    .INIT(1'b0)) 
    \id_ex_pc_reg[25] 
       (.C(clk_IBUF_BUFG),
        .CE(\<const1> ),
        .D(if_pc[25]),
        .Q(branch_event_pc_OBUF[23]),
        .R(reset_IBUF));
  FDRE #(
    .INIT(1'b0)) 
    \id_ex_pc_reg[26] 
       (.C(clk_IBUF_BUFG),
        .CE(\<const1> ),
        .D(if_pc[26]),
        .Q(branch_event_pc_OBUF[24]),
        .R(reset_IBUF));
  FDRE #(
    .INIT(1'b0)) 
    \id_ex_pc_reg[27] 
       (.C(clk_IBUF_BUFG),
        .CE(\<const1> ),
        .D(if_pc[27]),
        .Q(branch_event_pc_OBUF[25]),
        .R(reset_IBUF));
  FDRE #(
    .INIT(1'b0)) 
    \id_ex_pc_reg[28] 
       (.C(clk_IBUF_BUFG),
        .CE(\<const1> ),
        .D(if_pc[28]),
        .Q(branch_event_pc_OBUF[26]),
        .R(reset_IBUF));
  FDRE #(
    .INIT(1'b0)) 
    \id_ex_pc_reg[29] 
       (.C(clk_IBUF_BUFG),
        .CE(\<const1> ),
        .D(if_pc[29]),
        .Q(branch_event_pc_OBUF[27]),
        .R(reset_IBUF));
  FDRE #(
    .INIT(1'b0)) 
    \id_ex_pc_reg[2] 
       (.C(clk_IBUF_BUFG),
        .CE(\<const1> ),
        .D(if_pc[2]),
        .Q(branch_event_pc_OBUF[0]),
        .R(reset_IBUF));
  FDRE #(
    .INIT(1'b0)) 
    \id_ex_pc_reg[30] 
       (.C(clk_IBUF_BUFG),
        .CE(\<const1> ),
        .D(if_pc[30]),
        .Q(branch_event_pc_OBUF[28]),
        .R(reset_IBUF));
  FDRE #(
    .INIT(1'b0)) 
    \id_ex_pc_reg[31] 
       (.C(clk_IBUF_BUFG),
        .CE(\<const1> ),
        .D(if_pc[31]),
        .Q(branch_event_pc_OBUF[29]),
        .R(reset_IBUF));
  FDRE #(
    .INIT(1'b0)) 
    \id_ex_pc_reg[3] 
       (.C(clk_IBUF_BUFG),
        .CE(\<const1> ),
        .D(if_pc[3]),
        .Q(branch_event_pc_OBUF[1]),
        .R(reset_IBUF));
  FDRE #(
    .INIT(1'b0)) 
    \id_ex_pc_reg[4] 
       (.C(clk_IBUF_BUFG),
        .CE(\<const1> ),
        .D(if_pc[4]),
        .Q(branch_event_pc_OBUF[2]),
        .R(reset_IBUF));
  FDRE #(
    .INIT(1'b0)) 
    \id_ex_pc_reg[5] 
       (.C(clk_IBUF_BUFG),
        .CE(\<const1> ),
        .D(if_pc[5]),
        .Q(branch_event_pc_OBUF[3]),
        .R(reset_IBUF));
  FDRE #(
    .INIT(1'b0)) 
    \id_ex_pc_reg[6] 
       (.C(clk_IBUF_BUFG),
        .CE(\<const1> ),
        .D(if_pc[6]),
        .Q(branch_event_pc_OBUF[4]),
        .R(reset_IBUF));
  FDRE #(
    .INIT(1'b0)) 
    \id_ex_pc_reg[7] 
       (.C(clk_IBUF_BUFG),
        .CE(\<const1> ),
        .D(if_pc[7]),
        .Q(branch_event_pc_OBUF[5]),
        .R(reset_IBUF));
  FDRE #(
    .INIT(1'b0)) 
    \id_ex_pc_reg[8] 
       (.C(clk_IBUF_BUFG),
        .CE(\<const1> ),
        .D(if_pc[8]),
        .Q(branch_event_pc_OBUF[6]),
        .R(reset_IBUF));
  FDRE #(
    .INIT(1'b0)) 
    \id_ex_pc_reg[9] 
       (.C(clk_IBUF_BUFG),
        .CE(\<const1> ),
        .D(if_pc[9]),
        .Q(branch_event_pc_OBUF[7]),
        .R(reset_IBUF));
  LUT1 #(
    .INIT(2'h1)) 
    \stat_cycle_count[0]_i_2 
       (.I0(stat_cycle_count[0]),
        .O(\stat_cycle_count[0]_i_2_n_0 ));
  FDRE #(
    .INIT(1'b0)) 
    \stat_cycle_count_reg[0] 
       (.C(clk_IBUF_BUFG),
        .CE(\<const1> ),
        .D(\stat_cycle_count_reg[0]_i_1_n_7 ),
        .Q(stat_cycle_count[0]),
        .R(reset_IBUF));
  (* ADDER_THRESHOLD = "11" *) 
  CARRY4 \stat_cycle_count_reg[0]_i_1 
       (.CI(\<const0> ),
        .CO({\stat_cycle_count_reg[0]_i_1_n_0 ,\stat_cycle_count_reg[0]_i_1_n_1 ,\stat_cycle_count_reg[0]_i_1_n_2 ,\stat_cycle_count_reg[0]_i_1_n_3 }),
        .CYINIT(\<const0> ),
        .DI({\<const0> ,\<const0> ,\<const0> ,\<const1> }),
        .O({\stat_cycle_count_reg[0]_i_1_n_4 ,\stat_cycle_count_reg[0]_i_1_n_5 ,\stat_cycle_count_reg[0]_i_1_n_6 ,\stat_cycle_count_reg[0]_i_1_n_7 }),
        .S({stat_cycle_count[3:1],\stat_cycle_count[0]_i_2_n_0 }));
  FDRE #(
    .INIT(1'b0)) 
    \stat_cycle_count_reg[10] 
       (.C(clk_IBUF_BUFG),
        .CE(\<const1> ),
        .D(\stat_cycle_count_reg[8]_i_1_n_5 ),
        .Q(stat_cycle_count[10]),
        .R(reset_IBUF));
  FDRE #(
    .INIT(1'b0)) 
    \stat_cycle_count_reg[11] 
       (.C(clk_IBUF_BUFG),
        .CE(\<const1> ),
        .D(\stat_cycle_count_reg[8]_i_1_n_4 ),
        .Q(stat_cycle_count[11]),
        .R(reset_IBUF));
  FDRE #(
    .INIT(1'b0)) 
    \stat_cycle_count_reg[12] 
       (.C(clk_IBUF_BUFG),
        .CE(\<const1> ),
        .D(\stat_cycle_count_reg[12]_i_1_n_7 ),
        .Q(stat_cycle_count[12]),
        .R(reset_IBUF));
  (* ADDER_THRESHOLD = "11" *) 
  CARRY4 \stat_cycle_count_reg[12]_i_1 
       (.CI(\stat_cycle_count_reg[8]_i_1_n_0 ),
        .CO({\stat_cycle_count_reg[12]_i_1_n_0 ,\stat_cycle_count_reg[12]_i_1_n_1 ,\stat_cycle_count_reg[12]_i_1_n_2 ,\stat_cycle_count_reg[12]_i_1_n_3 }),
        .CYINIT(\<const0> ),
        .DI({\<const0> ,\<const0> ,\<const0> ,\<const0> }),
        .O({\stat_cycle_count_reg[12]_i_1_n_4 ,\stat_cycle_count_reg[12]_i_1_n_5 ,\stat_cycle_count_reg[12]_i_1_n_6 ,\stat_cycle_count_reg[12]_i_1_n_7 }),
        .S(stat_cycle_count[15:12]));
  FDRE #(
    .INIT(1'b0)) 
    \stat_cycle_count_reg[13] 
       (.C(clk_IBUF_BUFG),
        .CE(\<const1> ),
        .D(\stat_cycle_count_reg[12]_i_1_n_6 ),
        .Q(stat_cycle_count[13]),
        .R(reset_IBUF));
  FDRE #(
    .INIT(1'b0)) 
    \stat_cycle_count_reg[14] 
       (.C(clk_IBUF_BUFG),
        .CE(\<const1> ),
        .D(\stat_cycle_count_reg[12]_i_1_n_5 ),
        .Q(stat_cycle_count[14]),
        .R(reset_IBUF));
  FDRE #(
    .INIT(1'b0)) 
    \stat_cycle_count_reg[15] 
       (.C(clk_IBUF_BUFG),
        .CE(\<const1> ),
        .D(\stat_cycle_count_reg[12]_i_1_n_4 ),
        .Q(stat_cycle_count[15]),
        .R(reset_IBUF));
  FDRE #(
    .INIT(1'b0)) 
    \stat_cycle_count_reg[16] 
       (.C(clk_IBUF_BUFG),
        .CE(\<const1> ),
        .D(\stat_cycle_count_reg[16]_i_1_n_7 ),
        .Q(stat_cycle_count[16]),
        .R(reset_IBUF));
  (* ADDER_THRESHOLD = "11" *) 
  CARRY4 \stat_cycle_count_reg[16]_i_1 
       (.CI(\stat_cycle_count_reg[12]_i_1_n_0 ),
        .CO({\stat_cycle_count_reg[16]_i_1_n_0 ,\stat_cycle_count_reg[16]_i_1_n_1 ,\stat_cycle_count_reg[16]_i_1_n_2 ,\stat_cycle_count_reg[16]_i_1_n_3 }),
        .CYINIT(\<const0> ),
        .DI({\<const0> ,\<const0> ,\<const0> ,\<const0> }),
        .O({\stat_cycle_count_reg[16]_i_1_n_4 ,\stat_cycle_count_reg[16]_i_1_n_5 ,\stat_cycle_count_reg[16]_i_1_n_6 ,\stat_cycle_count_reg[16]_i_1_n_7 }),
        .S(stat_cycle_count[19:16]));
  FDRE #(
    .INIT(1'b0)) 
    \stat_cycle_count_reg[17] 
       (.C(clk_IBUF_BUFG),
        .CE(\<const1> ),
        .D(\stat_cycle_count_reg[16]_i_1_n_6 ),
        .Q(stat_cycle_count[17]),
        .R(reset_IBUF));
  FDRE #(
    .INIT(1'b0)) 
    \stat_cycle_count_reg[18] 
       (.C(clk_IBUF_BUFG),
        .CE(\<const1> ),
        .D(\stat_cycle_count_reg[16]_i_1_n_5 ),
        .Q(stat_cycle_count[18]),
        .R(reset_IBUF));
  FDRE #(
    .INIT(1'b0)) 
    \stat_cycle_count_reg[19] 
       (.C(clk_IBUF_BUFG),
        .CE(\<const1> ),
        .D(\stat_cycle_count_reg[16]_i_1_n_4 ),
        .Q(stat_cycle_count[19]),
        .R(reset_IBUF));
  FDRE #(
    .INIT(1'b0)) 
    \stat_cycle_count_reg[1] 
       (.C(clk_IBUF_BUFG),
        .CE(\<const1> ),
        .D(\stat_cycle_count_reg[0]_i_1_n_6 ),
        .Q(stat_cycle_count[1]),
        .R(reset_IBUF));
  FDRE #(
    .INIT(1'b0)) 
    \stat_cycle_count_reg[20] 
       (.C(clk_IBUF_BUFG),
        .CE(\<const1> ),
        .D(\stat_cycle_count_reg[20]_i_1_n_7 ),
        .Q(stat_cycle_count[20]),
        .R(reset_IBUF));
  (* ADDER_THRESHOLD = "11" *) 
  CARRY4 \stat_cycle_count_reg[20]_i_1 
       (.CI(\stat_cycle_count_reg[16]_i_1_n_0 ),
        .CO({\stat_cycle_count_reg[20]_i_1_n_0 ,\stat_cycle_count_reg[20]_i_1_n_1 ,\stat_cycle_count_reg[20]_i_1_n_2 ,\stat_cycle_count_reg[20]_i_1_n_3 }),
        .CYINIT(\<const0> ),
        .DI({\<const0> ,\<const0> ,\<const0> ,\<const0> }),
        .O({\stat_cycle_count_reg[20]_i_1_n_4 ,\stat_cycle_count_reg[20]_i_1_n_5 ,\stat_cycle_count_reg[20]_i_1_n_6 ,\stat_cycle_count_reg[20]_i_1_n_7 }),
        .S(stat_cycle_count[23:20]));
  FDRE #(
    .INIT(1'b0)) 
    \stat_cycle_count_reg[21] 
       (.C(clk_IBUF_BUFG),
        .CE(\<const1> ),
        .D(\stat_cycle_count_reg[20]_i_1_n_6 ),
        .Q(stat_cycle_count[21]),
        .R(reset_IBUF));
  FDRE #(
    .INIT(1'b0)) 
    \stat_cycle_count_reg[22] 
       (.C(clk_IBUF_BUFG),
        .CE(\<const1> ),
        .D(\stat_cycle_count_reg[20]_i_1_n_5 ),
        .Q(stat_cycle_count[22]),
        .R(reset_IBUF));
  FDRE #(
    .INIT(1'b0)) 
    \stat_cycle_count_reg[23] 
       (.C(clk_IBUF_BUFG),
        .CE(\<const1> ),
        .D(\stat_cycle_count_reg[20]_i_1_n_4 ),
        .Q(stat_cycle_count[23]),
        .R(reset_IBUF));
  FDRE #(
    .INIT(1'b0)) 
    \stat_cycle_count_reg[24] 
       (.C(clk_IBUF_BUFG),
        .CE(\<const1> ),
        .D(\stat_cycle_count_reg[24]_i_1_n_7 ),
        .Q(stat_cycle_count[24]),
        .R(reset_IBUF));
  (* ADDER_THRESHOLD = "11" *) 
  CARRY4 \stat_cycle_count_reg[24]_i_1 
       (.CI(\stat_cycle_count_reg[20]_i_1_n_0 ),
        .CO({\stat_cycle_count_reg[24]_i_1_n_0 ,\stat_cycle_count_reg[24]_i_1_n_1 ,\stat_cycle_count_reg[24]_i_1_n_2 ,\stat_cycle_count_reg[24]_i_1_n_3 }),
        .CYINIT(\<const0> ),
        .DI({\<const0> ,\<const0> ,\<const0> ,\<const0> }),
        .O({\stat_cycle_count_reg[24]_i_1_n_4 ,\stat_cycle_count_reg[24]_i_1_n_5 ,\stat_cycle_count_reg[24]_i_1_n_6 ,\stat_cycle_count_reg[24]_i_1_n_7 }),
        .S(stat_cycle_count[27:24]));
  FDRE #(
    .INIT(1'b0)) 
    \stat_cycle_count_reg[25] 
       (.C(clk_IBUF_BUFG),
        .CE(\<const1> ),
        .D(\stat_cycle_count_reg[24]_i_1_n_6 ),
        .Q(stat_cycle_count[25]),
        .R(reset_IBUF));
  FDRE #(
    .INIT(1'b0)) 
    \stat_cycle_count_reg[26] 
       (.C(clk_IBUF_BUFG),
        .CE(\<const1> ),
        .D(\stat_cycle_count_reg[24]_i_1_n_5 ),
        .Q(stat_cycle_count[26]),
        .R(reset_IBUF));
  FDRE #(
    .INIT(1'b0)) 
    \stat_cycle_count_reg[27] 
       (.C(clk_IBUF_BUFG),
        .CE(\<const1> ),
        .D(\stat_cycle_count_reg[24]_i_1_n_4 ),
        .Q(stat_cycle_count[27]),
        .R(reset_IBUF));
  FDRE #(
    .INIT(1'b0)) 
    \stat_cycle_count_reg[28] 
       (.C(clk_IBUF_BUFG),
        .CE(\<const1> ),
        .D(\stat_cycle_count_reg[28]_i_1_n_7 ),
        .Q(stat_cycle_count[28]),
        .R(reset_IBUF));
  (* ADDER_THRESHOLD = "11" *) 
  CARRY4 \stat_cycle_count_reg[28]_i_1 
       (.CI(\stat_cycle_count_reg[24]_i_1_n_0 ),
        .CO({\stat_cycle_count_reg[28]_i_1_n_1 ,\stat_cycle_count_reg[28]_i_1_n_2 ,\stat_cycle_count_reg[28]_i_1_n_3 }),
        .CYINIT(\<const0> ),
        .DI({\<const0> ,\<const0> ,\<const0> ,\<const0> }),
        .O({\stat_cycle_count_reg[28]_i_1_n_4 ,\stat_cycle_count_reg[28]_i_1_n_5 ,\stat_cycle_count_reg[28]_i_1_n_6 ,\stat_cycle_count_reg[28]_i_1_n_7 }),
        .S(stat_cycle_count[31:28]));
  FDRE #(
    .INIT(1'b0)) 
    \stat_cycle_count_reg[29] 
       (.C(clk_IBUF_BUFG),
        .CE(\<const1> ),
        .D(\stat_cycle_count_reg[28]_i_1_n_6 ),
        .Q(stat_cycle_count[29]),
        .R(reset_IBUF));
  FDRE #(
    .INIT(1'b0)) 
    \stat_cycle_count_reg[2] 
       (.C(clk_IBUF_BUFG),
        .CE(\<const1> ),
        .D(\stat_cycle_count_reg[0]_i_1_n_5 ),
        .Q(stat_cycle_count[2]),
        .R(reset_IBUF));
  FDRE #(
    .INIT(1'b0)) 
    \stat_cycle_count_reg[30] 
       (.C(clk_IBUF_BUFG),
        .CE(\<const1> ),
        .D(\stat_cycle_count_reg[28]_i_1_n_5 ),
        .Q(stat_cycle_count[30]),
        .R(reset_IBUF));
  FDRE #(
    .INIT(1'b0)) 
    \stat_cycle_count_reg[31] 
       (.C(clk_IBUF_BUFG),
        .CE(\<const1> ),
        .D(\stat_cycle_count_reg[28]_i_1_n_4 ),
        .Q(stat_cycle_count[31]),
        .R(reset_IBUF));
  FDRE #(
    .INIT(1'b0)) 
    \stat_cycle_count_reg[3] 
       (.C(clk_IBUF_BUFG),
        .CE(\<const1> ),
        .D(\stat_cycle_count_reg[0]_i_1_n_4 ),
        .Q(stat_cycle_count[3]),
        .R(reset_IBUF));
  FDRE #(
    .INIT(1'b0)) 
    \stat_cycle_count_reg[4] 
       (.C(clk_IBUF_BUFG),
        .CE(\<const1> ),
        .D(\stat_cycle_count_reg[4]_i_1_n_7 ),
        .Q(stat_cycle_count[4]),
        .R(reset_IBUF));
  (* ADDER_THRESHOLD = "11" *) 
  CARRY4 \stat_cycle_count_reg[4]_i_1 
       (.CI(\stat_cycle_count_reg[0]_i_1_n_0 ),
        .CO({\stat_cycle_count_reg[4]_i_1_n_0 ,\stat_cycle_count_reg[4]_i_1_n_1 ,\stat_cycle_count_reg[4]_i_1_n_2 ,\stat_cycle_count_reg[4]_i_1_n_3 }),
        .CYINIT(\<const0> ),
        .DI({\<const0> ,\<const0> ,\<const0> ,\<const0> }),
        .O({\stat_cycle_count_reg[4]_i_1_n_4 ,\stat_cycle_count_reg[4]_i_1_n_5 ,\stat_cycle_count_reg[4]_i_1_n_6 ,\stat_cycle_count_reg[4]_i_1_n_7 }),
        .S(stat_cycle_count[7:4]));
  FDRE #(
    .INIT(1'b0)) 
    \stat_cycle_count_reg[5] 
       (.C(clk_IBUF_BUFG),
        .CE(\<const1> ),
        .D(\stat_cycle_count_reg[4]_i_1_n_6 ),
        .Q(stat_cycle_count[5]),
        .R(reset_IBUF));
  FDRE #(
    .INIT(1'b0)) 
    \stat_cycle_count_reg[6] 
       (.C(clk_IBUF_BUFG),
        .CE(\<const1> ),
        .D(\stat_cycle_count_reg[4]_i_1_n_5 ),
        .Q(stat_cycle_count[6]),
        .R(reset_IBUF));
  FDRE #(
    .INIT(1'b0)) 
    \stat_cycle_count_reg[7] 
       (.C(clk_IBUF_BUFG),
        .CE(\<const1> ),
        .D(\stat_cycle_count_reg[4]_i_1_n_4 ),
        .Q(stat_cycle_count[7]),
        .R(reset_IBUF));
  FDRE #(
    .INIT(1'b0)) 
    \stat_cycle_count_reg[8] 
       (.C(clk_IBUF_BUFG),
        .CE(\<const1> ),
        .D(\stat_cycle_count_reg[8]_i_1_n_7 ),
        .Q(stat_cycle_count[8]),
        .R(reset_IBUF));
  (* ADDER_THRESHOLD = "11" *) 
  CARRY4 \stat_cycle_count_reg[8]_i_1 
       (.CI(\stat_cycle_count_reg[4]_i_1_n_0 ),
        .CO({\stat_cycle_count_reg[8]_i_1_n_0 ,\stat_cycle_count_reg[8]_i_1_n_1 ,\stat_cycle_count_reg[8]_i_1_n_2 ,\stat_cycle_count_reg[8]_i_1_n_3 }),
        .CYINIT(\<const0> ),
        .DI({\<const0> ,\<const0> ,\<const0> ,\<const0> }),
        .O({\stat_cycle_count_reg[8]_i_1_n_4 ,\stat_cycle_count_reg[8]_i_1_n_5 ,\stat_cycle_count_reg[8]_i_1_n_6 ,\stat_cycle_count_reg[8]_i_1_n_7 }),
        .S(stat_cycle_count[11:8]));
  FDRE #(
    .INIT(1'b0)) 
    \stat_cycle_count_reg[9] 
       (.C(clk_IBUF_BUFG),
        .CE(\<const1> ),
        .D(\stat_cycle_count_reg[8]_i_1_n_6 ),
        .Q(stat_cycle_count[9]),
        .R(reset_IBUF));
  if_stage u_if_stage
       (.Q(if_pc),
        .clk_IBUF_BUFG(clk_IBUF_BUFG),
        .reset_IBUF(reset_IBUF));
endmodule

module if_stage
   (Q,
    reset_IBUF,
    clk_IBUF_BUFG);
  output [29:0]Q;
  input reset_IBUF;
  input clk_IBUF_BUFG;

  wire \<const0> ;
  wire \<const1> ;
  wire [29:0]Q;
  wire [31:2]cand0_pc;
  wire cand0_valid;
  wire clk_IBUF_BUFG;
  wire \fetch_pc[4]_i_2_n_0 ;
  wire [31:2]fetch_pc_n0;
  wire \fetch_pc_reg[12]_i_1_n_0 ;
  wire \fetch_pc_reg[12]_i_1_n_1 ;
  wire \fetch_pc_reg[12]_i_1_n_2 ;
  wire \fetch_pc_reg[12]_i_1_n_3 ;
  wire \fetch_pc_reg[16]_i_1_n_0 ;
  wire \fetch_pc_reg[16]_i_1_n_1 ;
  wire \fetch_pc_reg[16]_i_1_n_2 ;
  wire \fetch_pc_reg[16]_i_1_n_3 ;
  wire \fetch_pc_reg[20]_i_1_n_0 ;
  wire \fetch_pc_reg[20]_i_1_n_1 ;
  wire \fetch_pc_reg[20]_i_1_n_2 ;
  wire \fetch_pc_reg[20]_i_1_n_3 ;
  wire \fetch_pc_reg[24]_i_1_n_0 ;
  wire \fetch_pc_reg[24]_i_1_n_1 ;
  wire \fetch_pc_reg[24]_i_1_n_2 ;
  wire \fetch_pc_reg[24]_i_1_n_3 ;
  wire \fetch_pc_reg[28]_i_1_n_0 ;
  wire \fetch_pc_reg[28]_i_1_n_1 ;
  wire \fetch_pc_reg[28]_i_1_n_2 ;
  wire \fetch_pc_reg[28]_i_1_n_3 ;
  wire \fetch_pc_reg[31]_i_1_n_2 ;
  wire \fetch_pc_reg[31]_i_1_n_3 ;
  wire \fetch_pc_reg[4]_i_1_n_0 ;
  wire \fetch_pc_reg[4]_i_1_n_1 ;
  wire \fetch_pc_reg[4]_i_1_n_2 ;
  wire \fetch_pc_reg[4]_i_1_n_3 ;
  wire \fetch_pc_reg[8]_i_1_n_0 ;
  wire \fetch_pc_reg[8]_i_1_n_1 ;
  wire \fetch_pc_reg[8]_i_1_n_2 ;
  wire \fetch_pc_reg[8]_i_1_n_3 ;
  wire \if_pc[31]_i_1_n_0 ;
  wire [31:2]imem_addr;
  wire reset_IBUF;
  wire [3:0]\NLW_fetch_pc_reg[4]_i_1_O_UNCONNECTED ;

  GND GND
       (.G(\<const0> ));
  VCC VCC
       (.P(\<const1> ));
  LUT1 #(
    .INIT(2'h1)) 
    \fetch_pc[4]_i_2 
       (.I0(imem_addr[2]),
        .O(\fetch_pc[4]_i_2_n_0 ));
  FDRE #(
    .INIT(1'b0)) 
    \fetch_pc_reg[10] 
       (.C(clk_IBUF_BUFG),
        .CE(\<const1> ),
        .D(fetch_pc_n0[10]),
        .Q(imem_addr[10]),
        .R(reset_IBUF));
  FDRE #(
    .INIT(1'b0)) 
    \fetch_pc_reg[11] 
       (.C(clk_IBUF_BUFG),
        .CE(\<const1> ),
        .D(fetch_pc_n0[11]),
        .Q(imem_addr[11]),
        .R(reset_IBUF));
  FDRE #(
    .INIT(1'b0)) 
    \fetch_pc_reg[12] 
       (.C(clk_IBUF_BUFG),
        .CE(\<const1> ),
        .D(fetch_pc_n0[12]),
        .Q(imem_addr[12]),
        .R(reset_IBUF));
  (* ADDER_THRESHOLD = "35" *) 
  CARRY4 \fetch_pc_reg[12]_i_1 
       (.CI(\fetch_pc_reg[8]_i_1_n_0 ),
        .CO({\fetch_pc_reg[12]_i_1_n_0 ,\fetch_pc_reg[12]_i_1_n_1 ,\fetch_pc_reg[12]_i_1_n_2 ,\fetch_pc_reg[12]_i_1_n_3 }),
        .CYINIT(\<const0> ),
        .DI({\<const0> ,\<const0> ,\<const0> ,\<const0> }),
        .O(fetch_pc_n0[12:9]),
        .S(imem_addr[12:9]));
  FDRE #(
    .INIT(1'b0)) 
    \fetch_pc_reg[13] 
       (.C(clk_IBUF_BUFG),
        .CE(\<const1> ),
        .D(fetch_pc_n0[13]),
        .Q(imem_addr[13]),
        .R(reset_IBUF));
  FDRE #(
    .INIT(1'b0)) 
    \fetch_pc_reg[14] 
       (.C(clk_IBUF_BUFG),
        .CE(\<const1> ),
        .D(fetch_pc_n0[14]),
        .Q(imem_addr[14]),
        .R(reset_IBUF));
  FDRE #(
    .INIT(1'b0)) 
    \fetch_pc_reg[15] 
       (.C(clk_IBUF_BUFG),
        .CE(\<const1> ),
        .D(fetch_pc_n0[15]),
        .Q(imem_addr[15]),
        .R(reset_IBUF));
  FDRE #(
    .INIT(1'b0)) 
    \fetch_pc_reg[16] 
       (.C(clk_IBUF_BUFG),
        .CE(\<const1> ),
        .D(fetch_pc_n0[16]),
        .Q(imem_addr[16]),
        .R(reset_IBUF));
  (* ADDER_THRESHOLD = "35" *) 
  CARRY4 \fetch_pc_reg[16]_i_1 
       (.CI(\fetch_pc_reg[12]_i_1_n_0 ),
        .CO({\fetch_pc_reg[16]_i_1_n_0 ,\fetch_pc_reg[16]_i_1_n_1 ,\fetch_pc_reg[16]_i_1_n_2 ,\fetch_pc_reg[16]_i_1_n_3 }),
        .CYINIT(\<const0> ),
        .DI({\<const0> ,\<const0> ,\<const0> ,\<const0> }),
        .O(fetch_pc_n0[16:13]),
        .S(imem_addr[16:13]));
  FDRE #(
    .INIT(1'b0)) 
    \fetch_pc_reg[17] 
       (.C(clk_IBUF_BUFG),
        .CE(\<const1> ),
        .D(fetch_pc_n0[17]),
        .Q(imem_addr[17]),
        .R(reset_IBUF));
  FDRE #(
    .INIT(1'b0)) 
    \fetch_pc_reg[18] 
       (.C(clk_IBUF_BUFG),
        .CE(\<const1> ),
        .D(fetch_pc_n0[18]),
        .Q(imem_addr[18]),
        .R(reset_IBUF));
  FDRE #(
    .INIT(1'b0)) 
    \fetch_pc_reg[19] 
       (.C(clk_IBUF_BUFG),
        .CE(\<const1> ),
        .D(fetch_pc_n0[19]),
        .Q(imem_addr[19]),
        .R(reset_IBUF));
  FDRE #(
    .INIT(1'b0)) 
    \fetch_pc_reg[20] 
       (.C(clk_IBUF_BUFG),
        .CE(\<const1> ),
        .D(fetch_pc_n0[20]),
        .Q(imem_addr[20]),
        .R(reset_IBUF));
  (* ADDER_THRESHOLD = "35" *) 
  CARRY4 \fetch_pc_reg[20]_i_1 
       (.CI(\fetch_pc_reg[16]_i_1_n_0 ),
        .CO({\fetch_pc_reg[20]_i_1_n_0 ,\fetch_pc_reg[20]_i_1_n_1 ,\fetch_pc_reg[20]_i_1_n_2 ,\fetch_pc_reg[20]_i_1_n_3 }),
        .CYINIT(\<const0> ),
        .DI({\<const0> ,\<const0> ,\<const0> ,\<const0> }),
        .O(fetch_pc_n0[20:17]),
        .S(imem_addr[20:17]));
  FDRE #(
    .INIT(1'b0)) 
    \fetch_pc_reg[21] 
       (.C(clk_IBUF_BUFG),
        .CE(\<const1> ),
        .D(fetch_pc_n0[21]),
        .Q(imem_addr[21]),
        .R(reset_IBUF));
  FDRE #(
    .INIT(1'b0)) 
    \fetch_pc_reg[22] 
       (.C(clk_IBUF_BUFG),
        .CE(\<const1> ),
        .D(fetch_pc_n0[22]),
        .Q(imem_addr[22]),
        .R(reset_IBUF));
  FDRE #(
    .INIT(1'b0)) 
    \fetch_pc_reg[23] 
       (.C(clk_IBUF_BUFG),
        .CE(\<const1> ),
        .D(fetch_pc_n0[23]),
        .Q(imem_addr[23]),
        .R(reset_IBUF));
  FDRE #(
    .INIT(1'b0)) 
    \fetch_pc_reg[24] 
       (.C(clk_IBUF_BUFG),
        .CE(\<const1> ),
        .D(fetch_pc_n0[24]),
        .Q(imem_addr[24]),
        .R(reset_IBUF));
  (* ADDER_THRESHOLD = "35" *) 
  CARRY4 \fetch_pc_reg[24]_i_1 
       (.CI(\fetch_pc_reg[20]_i_1_n_0 ),
        .CO({\fetch_pc_reg[24]_i_1_n_0 ,\fetch_pc_reg[24]_i_1_n_1 ,\fetch_pc_reg[24]_i_1_n_2 ,\fetch_pc_reg[24]_i_1_n_3 }),
        .CYINIT(\<const0> ),
        .DI({\<const0> ,\<const0> ,\<const0> ,\<const0> }),
        .O(fetch_pc_n0[24:21]),
        .S(imem_addr[24:21]));
  FDRE #(
    .INIT(1'b0)) 
    \fetch_pc_reg[25] 
       (.C(clk_IBUF_BUFG),
        .CE(\<const1> ),
        .D(fetch_pc_n0[25]),
        .Q(imem_addr[25]),
        .R(reset_IBUF));
  FDRE #(
    .INIT(1'b0)) 
    \fetch_pc_reg[26] 
       (.C(clk_IBUF_BUFG),
        .CE(\<const1> ),
        .D(fetch_pc_n0[26]),
        .Q(imem_addr[26]),
        .R(reset_IBUF));
  FDRE #(
    .INIT(1'b0)) 
    \fetch_pc_reg[27] 
       (.C(clk_IBUF_BUFG),
        .CE(\<const1> ),
        .D(fetch_pc_n0[27]),
        .Q(imem_addr[27]),
        .R(reset_IBUF));
  FDRE #(
    .INIT(1'b0)) 
    \fetch_pc_reg[28] 
       (.C(clk_IBUF_BUFG),
        .CE(\<const1> ),
        .D(fetch_pc_n0[28]),
        .Q(imem_addr[28]),
        .R(reset_IBUF));
  (* ADDER_THRESHOLD = "35" *) 
  CARRY4 \fetch_pc_reg[28]_i_1 
       (.CI(\fetch_pc_reg[24]_i_1_n_0 ),
        .CO({\fetch_pc_reg[28]_i_1_n_0 ,\fetch_pc_reg[28]_i_1_n_1 ,\fetch_pc_reg[28]_i_1_n_2 ,\fetch_pc_reg[28]_i_1_n_3 }),
        .CYINIT(\<const0> ),
        .DI({\<const0> ,\<const0> ,\<const0> ,\<const0> }),
        .O(fetch_pc_n0[28:25]),
        .S(imem_addr[28:25]));
  FDRE #(
    .INIT(1'b0)) 
    \fetch_pc_reg[29] 
       (.C(clk_IBUF_BUFG),
        .CE(\<const1> ),
        .D(fetch_pc_n0[29]),
        .Q(imem_addr[29]),
        .R(reset_IBUF));
  FDRE #(
    .INIT(1'b0)) 
    \fetch_pc_reg[2] 
       (.C(clk_IBUF_BUFG),
        .CE(\<const1> ),
        .D(fetch_pc_n0[2]),
        .Q(imem_addr[2]),
        .R(reset_IBUF));
  FDRE #(
    .INIT(1'b0)) 
    \fetch_pc_reg[30] 
       (.C(clk_IBUF_BUFG),
        .CE(\<const1> ),
        .D(fetch_pc_n0[30]),
        .Q(imem_addr[30]),
        .R(reset_IBUF));
  FDRE #(
    .INIT(1'b0)) 
    \fetch_pc_reg[31] 
       (.C(clk_IBUF_BUFG),
        .CE(\<const1> ),
        .D(fetch_pc_n0[31]),
        .Q(imem_addr[31]),
        .R(reset_IBUF));
  (* ADDER_THRESHOLD = "35" *) 
  CARRY4 \fetch_pc_reg[31]_i_1 
       (.CI(\fetch_pc_reg[28]_i_1_n_0 ),
        .CO({\fetch_pc_reg[31]_i_1_n_2 ,\fetch_pc_reg[31]_i_1_n_3 }),
        .CYINIT(\<const0> ),
        .DI({\<const0> ,\<const0> ,\<const0> ,\<const0> }),
        .O(fetch_pc_n0[31:29]),
        .S({\<const0> ,imem_addr[31:29]}));
  FDRE #(
    .INIT(1'b0)) 
    \fetch_pc_reg[3] 
       (.C(clk_IBUF_BUFG),
        .CE(\<const1> ),
        .D(fetch_pc_n0[3]),
        .Q(imem_addr[3]),
        .R(reset_IBUF));
  FDRE #(
    .INIT(1'b0)) 
    \fetch_pc_reg[4] 
       (.C(clk_IBUF_BUFG),
        .CE(\<const1> ),
        .D(fetch_pc_n0[4]),
        .Q(imem_addr[4]),
        .R(reset_IBUF));
  (* ADDER_THRESHOLD = "35" *) 
  CARRY4 \fetch_pc_reg[4]_i_1 
       (.CI(\<const0> ),
        .CO({\fetch_pc_reg[4]_i_1_n_0 ,\fetch_pc_reg[4]_i_1_n_1 ,\fetch_pc_reg[4]_i_1_n_2 ,\fetch_pc_reg[4]_i_1_n_3 }),
        .CYINIT(\<const0> ),
        .DI({\<const0> ,\<const0> ,imem_addr[2],\<const0> }),
        .O({fetch_pc_n0[4:2],\NLW_fetch_pc_reg[4]_i_1_O_UNCONNECTED [0]}),
        .S({imem_addr[4:3],\fetch_pc[4]_i_2_n_0 ,\<const0> }));
  FDRE #(
    .INIT(1'b0)) 
    \fetch_pc_reg[5] 
       (.C(clk_IBUF_BUFG),
        .CE(\<const1> ),
        .D(fetch_pc_n0[5]),
        .Q(imem_addr[5]),
        .R(reset_IBUF));
  FDRE #(
    .INIT(1'b0)) 
    \fetch_pc_reg[6] 
       (.C(clk_IBUF_BUFG),
        .CE(\<const1> ),
        .D(fetch_pc_n0[6]),
        .Q(imem_addr[6]),
        .R(reset_IBUF));
  FDRE #(
    .INIT(1'b0)) 
    \fetch_pc_reg[7] 
       (.C(clk_IBUF_BUFG),
        .CE(\<const1> ),
        .D(fetch_pc_n0[7]),
        .Q(imem_addr[7]),
        .R(reset_IBUF));
  FDRE #(
    .INIT(1'b0)) 
    \fetch_pc_reg[8] 
       (.C(clk_IBUF_BUFG),
        .CE(\<const1> ),
        .D(fetch_pc_n0[8]),
        .Q(imem_addr[8]),
        .R(reset_IBUF));
  (* ADDER_THRESHOLD = "35" *) 
  CARRY4 \fetch_pc_reg[8]_i_1 
       (.CI(\fetch_pc_reg[4]_i_1_n_0 ),
        .CO({\fetch_pc_reg[8]_i_1_n_0 ,\fetch_pc_reg[8]_i_1_n_1 ,\fetch_pc_reg[8]_i_1_n_2 ,\fetch_pc_reg[8]_i_1_n_3 }),
        .CYINIT(\<const0> ),
        .DI({\<const0> ,\<const0> ,\<const0> ,\<const0> }),
        .O(fetch_pc_n0[8:5]),
        .S(imem_addr[8:5]));
  FDRE #(
    .INIT(1'b0)) 
    \fetch_pc_reg[9] 
       (.C(clk_IBUF_BUFG),
        .CE(\<const1> ),
        .D(fetch_pc_n0[9]),
        .Q(imem_addr[9]),
        .R(reset_IBUF));
  LUT2 #(
    .INIT(4'hB)) 
    \if_pc[31]_i_1 
       (.I0(reset_IBUF),
        .I1(cand0_valid),
        .O(\if_pc[31]_i_1_n_0 ));
  FDRE #(
    .INIT(1'b0)) 
    \if_pc_reg[10] 
       (.C(clk_IBUF_BUFG),
        .CE(cand0_valid),
        .D(cand0_pc[10]),
        .Q(Q[8]),
        .R(\if_pc[31]_i_1_n_0 ));
  FDRE #(
    .INIT(1'b0)) 
    \if_pc_reg[11] 
       (.C(clk_IBUF_BUFG),
        .CE(cand0_valid),
        .D(cand0_pc[11]),
        .Q(Q[9]),
        .R(\if_pc[31]_i_1_n_0 ));
  FDRE #(
    .INIT(1'b0)) 
    \if_pc_reg[12] 
       (.C(clk_IBUF_BUFG),
        .CE(cand0_valid),
        .D(cand0_pc[12]),
        .Q(Q[10]),
        .R(\if_pc[31]_i_1_n_0 ));
  FDRE #(
    .INIT(1'b0)) 
    \if_pc_reg[13] 
       (.C(clk_IBUF_BUFG),
        .CE(cand0_valid),
        .D(cand0_pc[13]),
        .Q(Q[11]),
        .R(\if_pc[31]_i_1_n_0 ));
  FDRE #(
    .INIT(1'b0)) 
    \if_pc_reg[14] 
       (.C(clk_IBUF_BUFG),
        .CE(cand0_valid),
        .D(cand0_pc[14]),
        .Q(Q[12]),
        .R(\if_pc[31]_i_1_n_0 ));
  FDRE #(
    .INIT(1'b0)) 
    \if_pc_reg[15] 
       (.C(clk_IBUF_BUFG),
        .CE(cand0_valid),
        .D(cand0_pc[15]),
        .Q(Q[13]),
        .R(\if_pc[31]_i_1_n_0 ));
  FDRE #(
    .INIT(1'b0)) 
    \if_pc_reg[16] 
       (.C(clk_IBUF_BUFG),
        .CE(cand0_valid),
        .D(cand0_pc[16]),
        .Q(Q[14]),
        .R(\if_pc[31]_i_1_n_0 ));
  FDRE #(
    .INIT(1'b0)) 
    \if_pc_reg[17] 
       (.C(clk_IBUF_BUFG),
        .CE(cand0_valid),
        .D(cand0_pc[17]),
        .Q(Q[15]),
        .R(\if_pc[31]_i_1_n_0 ));
  FDRE #(
    .INIT(1'b0)) 
    \if_pc_reg[18] 
       (.C(clk_IBUF_BUFG),
        .CE(cand0_valid),
        .D(cand0_pc[18]),
        .Q(Q[16]),
        .R(\if_pc[31]_i_1_n_0 ));
  FDRE #(
    .INIT(1'b0)) 
    \if_pc_reg[19] 
       (.C(clk_IBUF_BUFG),
        .CE(cand0_valid),
        .D(cand0_pc[19]),
        .Q(Q[17]),
        .R(\if_pc[31]_i_1_n_0 ));
  FDRE #(
    .INIT(1'b0)) 
    \if_pc_reg[20] 
       (.C(clk_IBUF_BUFG),
        .CE(cand0_valid),
        .D(cand0_pc[20]),
        .Q(Q[18]),
        .R(\if_pc[31]_i_1_n_0 ));
  FDRE #(
    .INIT(1'b0)) 
    \if_pc_reg[21] 
       (.C(clk_IBUF_BUFG),
        .CE(cand0_valid),
        .D(cand0_pc[21]),
        .Q(Q[19]),
        .R(\if_pc[31]_i_1_n_0 ));
  FDRE #(
    .INIT(1'b0)) 
    \if_pc_reg[22] 
       (.C(clk_IBUF_BUFG),
        .CE(cand0_valid),
        .D(cand0_pc[22]),
        .Q(Q[20]),
        .R(\if_pc[31]_i_1_n_0 ));
  FDRE #(
    .INIT(1'b0)) 
    \if_pc_reg[23] 
       (.C(clk_IBUF_BUFG),
        .CE(cand0_valid),
        .D(cand0_pc[23]),
        .Q(Q[21]),
        .R(\if_pc[31]_i_1_n_0 ));
  FDRE #(
    .INIT(1'b0)) 
    \if_pc_reg[24] 
       (.C(clk_IBUF_BUFG),
        .CE(cand0_valid),
        .D(cand0_pc[24]),
        .Q(Q[22]),
        .R(\if_pc[31]_i_1_n_0 ));
  FDRE #(
    .INIT(1'b0)) 
    \if_pc_reg[25] 
       (.C(clk_IBUF_BUFG),
        .CE(cand0_valid),
        .D(cand0_pc[25]),
        .Q(Q[23]),
        .R(\if_pc[31]_i_1_n_0 ));
  FDRE #(
    .INIT(1'b0)) 
    \if_pc_reg[26] 
       (.C(clk_IBUF_BUFG),
        .CE(cand0_valid),
        .D(cand0_pc[26]),
        .Q(Q[24]),
        .R(\if_pc[31]_i_1_n_0 ));
  FDRE #(
    .INIT(1'b0)) 
    \if_pc_reg[27] 
       (.C(clk_IBUF_BUFG),
        .CE(cand0_valid),
        .D(cand0_pc[27]),
        .Q(Q[25]),
        .R(\if_pc[31]_i_1_n_0 ));
  FDRE #(
    .INIT(1'b0)) 
    \if_pc_reg[28] 
       (.C(clk_IBUF_BUFG),
        .CE(cand0_valid),
        .D(cand0_pc[28]),
        .Q(Q[26]),
        .R(\if_pc[31]_i_1_n_0 ));
  FDRE #(
    .INIT(1'b0)) 
    \if_pc_reg[29] 
       (.C(clk_IBUF_BUFG),
        .CE(cand0_valid),
        .D(cand0_pc[29]),
        .Q(Q[27]),
        .R(\if_pc[31]_i_1_n_0 ));
  FDRE #(
    .INIT(1'b0)) 
    \if_pc_reg[2] 
       (.C(clk_IBUF_BUFG),
        .CE(cand0_valid),
        .D(cand0_pc[2]),
        .Q(Q[0]),
        .R(\if_pc[31]_i_1_n_0 ));
  FDRE #(
    .INIT(1'b0)) 
    \if_pc_reg[30] 
       (.C(clk_IBUF_BUFG),
        .CE(cand0_valid),
        .D(cand0_pc[30]),
        .Q(Q[28]),
        .R(\if_pc[31]_i_1_n_0 ));
  FDRE #(
    .INIT(1'b0)) 
    \if_pc_reg[31] 
       (.C(clk_IBUF_BUFG),
        .CE(cand0_valid),
        .D(cand0_pc[31]),
        .Q(Q[29]),
        .R(\if_pc[31]_i_1_n_0 ));
  FDRE #(
    .INIT(1'b0)) 
    \if_pc_reg[3] 
       (.C(clk_IBUF_BUFG),
        .CE(cand0_valid),
        .D(cand0_pc[3]),
        .Q(Q[1]),
        .R(\if_pc[31]_i_1_n_0 ));
  FDRE #(
    .INIT(1'b0)) 
    \if_pc_reg[4] 
       (.C(clk_IBUF_BUFG),
        .CE(cand0_valid),
        .D(cand0_pc[4]),
        .Q(Q[2]),
        .R(\if_pc[31]_i_1_n_0 ));
  FDRE #(
    .INIT(1'b0)) 
    \if_pc_reg[5] 
       (.C(clk_IBUF_BUFG),
        .CE(cand0_valid),
        .D(cand0_pc[5]),
        .Q(Q[3]),
        .R(\if_pc[31]_i_1_n_0 ));
  FDRE #(
    .INIT(1'b0)) 
    \if_pc_reg[6] 
       (.C(clk_IBUF_BUFG),
        .CE(cand0_valid),
        .D(cand0_pc[6]),
        .Q(Q[4]),
        .R(\if_pc[31]_i_1_n_0 ));
  FDRE #(
    .INIT(1'b0)) 
    \if_pc_reg[7] 
       (.C(clk_IBUF_BUFG),
        .CE(cand0_valid),
        .D(cand0_pc[7]),
        .Q(Q[5]),
        .R(\if_pc[31]_i_1_n_0 ));
  FDRE #(
    .INIT(1'b0)) 
    \if_pc_reg[8] 
       (.C(clk_IBUF_BUFG),
        .CE(cand0_valid),
        .D(cand0_pc[8]),
        .Q(Q[6]),
        .R(\if_pc[31]_i_1_n_0 ));
  FDRE #(
    .INIT(1'b0)) 
    \if_pc_reg[9] 
       (.C(clk_IBUF_BUFG),
        .CE(cand0_valid),
        .D(cand0_pc[9]),
        .Q(Q[7]),
        .R(\if_pc[31]_i_1_n_0 ));
  FDRE #(
    .INIT(1'b0)) 
    \slot0_pc_reg[10] 
       (.C(clk_IBUF_BUFG),
        .CE(\<const1> ),
        .D(imem_addr[10]),
        .Q(cand0_pc[10]),
        .R(reset_IBUF));
  FDRE #(
    .INIT(1'b0)) 
    \slot0_pc_reg[11] 
       (.C(clk_IBUF_BUFG),
        .CE(\<const1> ),
        .D(imem_addr[11]),
        .Q(cand0_pc[11]),
        .R(reset_IBUF));
  FDRE #(
    .INIT(1'b0)) 
    \slot0_pc_reg[12] 
       (.C(clk_IBUF_BUFG),
        .CE(\<const1> ),
        .D(imem_addr[12]),
        .Q(cand0_pc[12]),
        .R(reset_IBUF));
  FDRE #(
    .INIT(1'b0)) 
    \slot0_pc_reg[13] 
       (.C(clk_IBUF_BUFG),
        .CE(\<const1> ),
        .D(imem_addr[13]),
        .Q(cand0_pc[13]),
        .R(reset_IBUF));
  FDRE #(
    .INIT(1'b0)) 
    \slot0_pc_reg[14] 
       (.C(clk_IBUF_BUFG),
        .CE(\<const1> ),
        .D(imem_addr[14]),
        .Q(cand0_pc[14]),
        .R(reset_IBUF));
  FDRE #(
    .INIT(1'b0)) 
    \slot0_pc_reg[15] 
       (.C(clk_IBUF_BUFG),
        .CE(\<const1> ),
        .D(imem_addr[15]),
        .Q(cand0_pc[15]),
        .R(reset_IBUF));
  FDRE #(
    .INIT(1'b0)) 
    \slot0_pc_reg[16] 
       (.C(clk_IBUF_BUFG),
        .CE(\<const1> ),
        .D(imem_addr[16]),
        .Q(cand0_pc[16]),
        .R(reset_IBUF));
  FDRE #(
    .INIT(1'b0)) 
    \slot0_pc_reg[17] 
       (.C(clk_IBUF_BUFG),
        .CE(\<const1> ),
        .D(imem_addr[17]),
        .Q(cand0_pc[17]),
        .R(reset_IBUF));
  FDRE #(
    .INIT(1'b0)) 
    \slot0_pc_reg[18] 
       (.C(clk_IBUF_BUFG),
        .CE(\<const1> ),
        .D(imem_addr[18]),
        .Q(cand0_pc[18]),
        .R(reset_IBUF));
  FDRE #(
    .INIT(1'b0)) 
    \slot0_pc_reg[19] 
       (.C(clk_IBUF_BUFG),
        .CE(\<const1> ),
        .D(imem_addr[19]),
        .Q(cand0_pc[19]),
        .R(reset_IBUF));
  FDRE #(
    .INIT(1'b0)) 
    \slot0_pc_reg[20] 
       (.C(clk_IBUF_BUFG),
        .CE(\<const1> ),
        .D(imem_addr[20]),
        .Q(cand0_pc[20]),
        .R(reset_IBUF));
  FDRE #(
    .INIT(1'b0)) 
    \slot0_pc_reg[21] 
       (.C(clk_IBUF_BUFG),
        .CE(\<const1> ),
        .D(imem_addr[21]),
        .Q(cand0_pc[21]),
        .R(reset_IBUF));
  FDRE #(
    .INIT(1'b0)) 
    \slot0_pc_reg[22] 
       (.C(clk_IBUF_BUFG),
        .CE(\<const1> ),
        .D(imem_addr[22]),
        .Q(cand0_pc[22]),
        .R(reset_IBUF));
  FDRE #(
    .INIT(1'b0)) 
    \slot0_pc_reg[23] 
       (.C(clk_IBUF_BUFG),
        .CE(\<const1> ),
        .D(imem_addr[23]),
        .Q(cand0_pc[23]),
        .R(reset_IBUF));
  FDRE #(
    .INIT(1'b0)) 
    \slot0_pc_reg[24] 
       (.C(clk_IBUF_BUFG),
        .CE(\<const1> ),
        .D(imem_addr[24]),
        .Q(cand0_pc[24]),
        .R(reset_IBUF));
  FDRE #(
    .INIT(1'b0)) 
    \slot0_pc_reg[25] 
       (.C(clk_IBUF_BUFG),
        .CE(\<const1> ),
        .D(imem_addr[25]),
        .Q(cand0_pc[25]),
        .R(reset_IBUF));
  FDRE #(
    .INIT(1'b0)) 
    \slot0_pc_reg[26] 
       (.C(clk_IBUF_BUFG),
        .CE(\<const1> ),
        .D(imem_addr[26]),
        .Q(cand0_pc[26]),
        .R(reset_IBUF));
  FDRE #(
    .INIT(1'b0)) 
    \slot0_pc_reg[27] 
       (.C(clk_IBUF_BUFG),
        .CE(\<const1> ),
        .D(imem_addr[27]),
        .Q(cand0_pc[27]),
        .R(reset_IBUF));
  FDRE #(
    .INIT(1'b0)) 
    \slot0_pc_reg[28] 
       (.C(clk_IBUF_BUFG),
        .CE(\<const1> ),
        .D(imem_addr[28]),
        .Q(cand0_pc[28]),
        .R(reset_IBUF));
  FDRE #(
    .INIT(1'b0)) 
    \slot0_pc_reg[29] 
       (.C(clk_IBUF_BUFG),
        .CE(\<const1> ),
        .D(imem_addr[29]),
        .Q(cand0_pc[29]),
        .R(reset_IBUF));
  FDRE #(
    .INIT(1'b0)) 
    \slot0_pc_reg[2] 
       (.C(clk_IBUF_BUFG),
        .CE(\<const1> ),
        .D(imem_addr[2]),
        .Q(cand0_pc[2]),
        .R(reset_IBUF));
  FDRE #(
    .INIT(1'b0)) 
    \slot0_pc_reg[30] 
       (.C(clk_IBUF_BUFG),
        .CE(\<const1> ),
        .D(imem_addr[30]),
        .Q(cand0_pc[30]),
        .R(reset_IBUF));
  FDRE #(
    .INIT(1'b0)) 
    \slot0_pc_reg[31] 
       (.C(clk_IBUF_BUFG),
        .CE(\<const1> ),
        .D(imem_addr[31]),
        .Q(cand0_pc[31]),
        .R(reset_IBUF));
  FDRE #(
    .INIT(1'b0)) 
    \slot0_pc_reg[3] 
       (.C(clk_IBUF_BUFG),
        .CE(\<const1> ),
        .D(imem_addr[3]),
        .Q(cand0_pc[3]),
        .R(reset_IBUF));
  FDRE #(
    .INIT(1'b0)) 
    \slot0_pc_reg[4] 
       (.C(clk_IBUF_BUFG),
        .CE(\<const1> ),
        .D(imem_addr[4]),
        .Q(cand0_pc[4]),
        .R(reset_IBUF));
  FDRE #(
    .INIT(1'b0)) 
    \slot0_pc_reg[5] 
       (.C(clk_IBUF_BUFG),
        .CE(\<const1> ),
        .D(imem_addr[5]),
        .Q(cand0_pc[5]),
        .R(reset_IBUF));
  FDRE #(
    .INIT(1'b0)) 
    \slot0_pc_reg[6] 
       (.C(clk_IBUF_BUFG),
        .CE(\<const1> ),
        .D(imem_addr[6]),
        .Q(cand0_pc[6]),
        .R(reset_IBUF));
  FDRE #(
    .INIT(1'b0)) 
    \slot0_pc_reg[7] 
       (.C(clk_IBUF_BUFG),
        .CE(\<const1> ),
        .D(imem_addr[7]),
        .Q(cand0_pc[7]),
        .R(reset_IBUF));
  FDRE #(
    .INIT(1'b0)) 
    \slot0_pc_reg[8] 
       (.C(clk_IBUF_BUFG),
        .CE(\<const1> ),
        .D(imem_addr[8]),
        .Q(cand0_pc[8]),
        .R(reset_IBUF));
  FDRE #(
    .INIT(1'b0)) 
    \slot0_pc_reg[9] 
       (.C(clk_IBUF_BUFG),
        .CE(\<const1> ),
        .D(imem_addr[9]),
        .Q(cand0_pc[9]),
        .R(reset_IBUF));
  FDRE #(
    .INIT(1'b0)) 
    slot0_valid_reg
       (.C(clk_IBUF_BUFG),
        .CE(\<const1> ),
        .D(\<const1> ),
        .Q(cand0_valid),
        .R(reset_IBUF));
endmodule
