// -------------------------------------------------------------
// ISA/Opcode definitions shared across the pipeline.
// -------------------------------------------------------------
`define OPCODE_RTYPE   6'b000000
`define OPCODE_ADDI    6'b001000
`define OPCODE_LW      6'b100011
`define OPCODE_SW      6'b101011
`define OPCODE_BEQ     6'b000100
`define OPCODE_BNE     6'b000101
`define OPCODE_J       6'b000010

// R-type funct codes
`define FUNCT_ADD      6'b100000
`define FUNCT_SUB      6'b100010
`define FUNCT_AND      6'b100100
`define FUNCT_OR       6'b100101

// Encodings for pseudo operations
`define INST_NOP       32'h0000_0000
