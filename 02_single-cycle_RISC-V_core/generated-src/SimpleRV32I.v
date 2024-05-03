module RV32Icore(
  input         clock,
  input         reset,
  output [31:0] io_check_res
);
`ifdef RANDOMIZE_MEM_INIT
  reg [31:0] _RAND_0;
  reg [31:0] _RAND_1;
`endif // RANDOMIZE_MEM_INIT
`ifdef RANDOMIZE_REG_INIT
  reg [31:0] _RAND_2;
`endif // RANDOMIZE_REG_INIT
  reg [31:0] IMem [0:4095]; // @[core.scala 66:17]
  wire  IMem_instr_MPORT_en; // @[core.scala 66:17]
  wire [11:0] IMem_instr_MPORT_addr; // @[core.scala 66:17]
  wire [31:0] IMem_instr_MPORT_data; // @[core.scala 66:17]
  reg [31:0] regFile [0:31]; // @[core.scala 75:20]
  wire  regFile_operandA_en; // @[core.scala 75:20]
  wire [4:0] regFile_operandA_addr; // @[core.scala 75:20]
  wire [31:0] regFile_operandA_data; // @[core.scala 75:20]
  wire  regFile_operandB_en; // @[core.scala 75:20]
  wire [4:0] regFile_operandB_addr; // @[core.scala 75:20]
  wire [31:0] regFile_operandB_data; // @[core.scala 75:20]
  wire [31:0] regFile_MPORT_data; // @[core.scala 75:20]
  wire [4:0] regFile_MPORT_addr; // @[core.scala 75:20]
  wire  regFile_MPORT_mask; // @[core.scala 75:20]
  wire  regFile_MPORT_en; // @[core.scala 75:20]
  wire [31:0] regFile_MPORT_1_data; // @[core.scala 75:20]
  wire [4:0] regFile_MPORT_1_addr; // @[core.scala 75:20]
  wire  regFile_MPORT_1_mask; // @[core.scala 75:20]
  wire  regFile_MPORT_1_en; // @[core.scala 75:20]
  reg [31:0] pc; // @[core.scala 73:19]
  wire [31:0] _instr_T = {{2'd0}, pc[31:2]}; // @[core.scala 85:19]
  wire [31:0] instr = IMem_instr_MPORT_data; // @[core.scala 84:20 85:9]
  wire [6:0] opcode = instr[6:0]; // @[core.scala 91:21]
  wire [2:0] funct3 = instr[14:12]; // @[core.scala 93:21]
  wire [6:0] funct7 = instr[31:25]; // @[core.scala 96:21]
  wire [11:0] imm = instr[31:20]; // @[core.scala 97:18]
  wire  _isADD_T = opcode == 7'h33; // @[core.scala 100:24]
  wire  _isADD_T_1 = funct3 == 3'h0; // @[core.scala 100:51]
  wire  _isADD_T_2 = opcode == 7'h33 & funct3 == 3'h0; // @[core.scala 100:41]
  wire  _isADD_T_3 = funct7 == 7'h0; // @[core.scala 100:74]
  wire  isADD = opcode == 7'h33 & funct3 == 3'h0 & funct7 == 7'h0; // @[core.scala 100:64]
  wire  _isSUB_T_3 = funct7 == 7'h20; // @[core.scala 101:74]
  wire  isSUB = _isADD_T_2 & funct7 == 7'h20; // @[core.scala 101:64]
  wire  isSLL = _isADD_T & funct3 == 3'h1 & _isADD_T_3; // @[core.scala 102:64]
  wire  isSLT = _isADD_T & funct3 == 3'h2 & _isADD_T_3; // @[core.scala 103:64]
  wire  _isSRL_T_2 = _isADD_T & funct3 == 3'h5; // @[core.scala 104:41]
  wire  isSRL = _isADD_T & funct3 == 3'h5 & _isADD_T_3; // @[core.scala 104:64]
  wire  isSRA = _isSRL_T_2 & _isSUB_T_3; // @[core.scala 105:64]
  wire  isXOR = _isADD_T & funct3 == 3'h4 & _isADD_T_3; // @[core.scala 106:64]
  wire  isOR = _isADD_T & funct3 == 3'h6 & _isADD_T_3; // @[core.scala 107:64]
  wire  isAND = _isADD_T & funct3 == 3'h7 & _isADD_T_3; // @[core.scala 108:64]
  wire  isADDI = opcode == 7'h13 & _isADD_T_1; // @[core.scala 112:41]
  wire [31:0] _GEN_11 = {{20'd0}, imm}; // @[core.scala 127:27]
  wire [31:0] _aluResult_T_1 = regFile_operandA_data + _GEN_11; // @[core.scala 127:27]
  wire [31:0] _aluResult_T_3 = regFile_operandA_data + regFile_operandB_data; // @[core.scala 129:27]
  wire [31:0] _aluResult_T_5 = regFile_operandA_data - regFile_operandB_data; // @[core.scala 131:27]
  wire [31:0] _aluResult_T_6 = regFile_operandA_data & regFile_operandB_data; // @[core.scala 133:27]
  wire [31:0] _aluResult_T_7 = regFile_operandA_data | regFile_operandB_data; // @[core.scala 135:27]
  wire [31:0] _aluResult_T_8 = regFile_operandA_data ^ regFile_operandB_data; // @[core.scala 137:27]
  wire [62:0] _GEN_12 = {{31'd0}, regFile_operandA_data}; // @[core.scala 139:27]
  wire [62:0] _aluResult_T_10 = _GEN_12 << regFile_operandB_data[4:0]; // @[core.scala 139:27]
  wire [31:0] _aluResult_T_14 = regFile_operandA_data >> regFile_operandB_data[4:0]; // @[core.scala 143:27]
  wire [31:0] _GEN_0 = isSRA ? _aluResult_T_14 : 32'h29a; // @[core.scala 144:21 150:15 155:15]
  wire [31:0] _GEN_1 = isSRL ? _aluResult_T_14 : _GEN_0; // @[core.scala 142:21 143:15]
  wire [62:0] _GEN_2 = isSLT ? _aluResult_T_10 : {{31'd0}, _GEN_1}; // @[core.scala 140:21 141:15]
  wire [62:0] _GEN_3 = isSLL ? _aluResult_T_10 : _GEN_2; // @[core.scala 138:21 139:15]
  wire [62:0] _GEN_4 = isXOR ? {{31'd0}, _aluResult_T_8} : _GEN_3; // @[core.scala 136:20 137:15]
  wire [62:0] _GEN_5 = isOR ? {{31'd0}, _aluResult_T_7} : _GEN_4; // @[core.scala 134:20 135:15]
  wire [62:0] _GEN_6 = isAND ? {{31'd0}, _aluResult_T_6} : _GEN_5; // @[core.scala 132:21 133:15]
  wire [62:0] _GEN_7 = isSUB ? {{31'd0}, _aluResult_T_5} : _GEN_6; // @[core.scala 130:21 131:15]
  wire [62:0] _GEN_8 = isADD ? {{31'd0}, _aluResult_T_3} : _GEN_7; // @[core.scala 128:21 129:15]
  wire [62:0] _GEN_9 = isADDI ? {{31'd0}, _aluResult_T_1} : _GEN_8; // @[core.scala 126:16 127:15]
  wire [31:0] _pc_T_1 = pc + 32'h4; // @[core.scala 181:12]
  assign IMem_instr_MPORT_en = 1'h1;
  assign IMem_instr_MPORT_addr = _instr_T[11:0];
  assign IMem_instr_MPORT_data = IMem[IMem_instr_MPORT_addr]; // @[core.scala 66:17]
  assign regFile_operandA_en = 1'h1;
  assign regFile_operandA_addr = instr[19:15];
  assign regFile_operandA_data = regFile[regFile_operandA_addr]; // @[core.scala 75:20]
  assign regFile_operandB_en = 1'h1;
  assign regFile_operandB_addr = instr[24:20];
  assign regFile_operandB_data = regFile[regFile_operandB_addr]; // @[core.scala 75:20]
  assign regFile_MPORT_data = 32'h0;
  assign regFile_MPORT_addr = 5'h0;
  assign regFile_MPORT_mask = 1'h1;
  assign regFile_MPORT_en = 1'h1;
  assign regFile_MPORT_1_data = _GEN_9[31:0];
  assign regFile_MPORT_1_addr = instr[11:7];
  assign regFile_MPORT_1_mask = 1'h1;
  assign regFile_MPORT_1_en = 1'h1;
  assign io_check_res = _GEN_9[31:0]; // @[core.scala 124:23]
  always @(posedge clock) begin
    if (regFile_MPORT_en & regFile_MPORT_mask) begin
      regFile[regFile_MPORT_addr] <= regFile_MPORT_data; // @[core.scala 75:20]
    end
    if (regFile_MPORT_1_en & regFile_MPORT_1_mask) begin
      regFile[regFile_MPORT_1_addr] <= regFile_MPORT_1_data; // @[core.scala 75:20]
    end
    if (reset) begin // @[core.scala 73:19]
      pc <= 32'h0; // @[core.scala 73:19]
    end else begin
      pc <= _pc_T_1; // @[core.scala 181:6]
    end
  end
// Register and memory initialization
`ifdef RANDOMIZE_GARBAGE_ASSIGN
`define RANDOMIZE
`endif
`ifdef RANDOMIZE_INVALID_ASSIGN
`define RANDOMIZE
`endif
`ifdef RANDOMIZE_REG_INIT
`define RANDOMIZE
`endif
`ifdef RANDOMIZE_MEM_INIT
`define RANDOMIZE
`endif
`ifndef RANDOM
`define RANDOM $random
`endif
`ifdef RANDOMIZE_MEM_INIT
  integer initvar;
`endif
`ifndef SYNTHESIS
`ifdef FIRRTL_BEFORE_INITIAL
`FIRRTL_BEFORE_INITIAL
`endif
initial begin
  `ifdef RANDOMIZE
    `ifdef INIT_RANDOM
      `INIT_RANDOM
    `endif
    `ifndef VERILATOR
      `ifdef RANDOMIZE_DELAY
        #`RANDOMIZE_DELAY begin end
      `else
        #0.002 begin end
      `endif
    `endif
`ifdef RANDOMIZE_MEM_INIT
  _RAND_0 = {1{`RANDOM}};
  for (initvar = 0; initvar < 4096; initvar = initvar+1)
    IMem[initvar] = _RAND_0[31:0];
  _RAND_1 = {1{`RANDOM}};
  for (initvar = 0; initvar < 32; initvar = initvar+1)
    regFile[initvar] = _RAND_1[31:0];
`endif // RANDOMIZE_MEM_INIT
`ifdef RANDOMIZE_REG_INIT
  _RAND_2 = {1{`RANDOM}};
  pc = _RAND_2[31:0];
`endif // RANDOMIZE_REG_INIT
  `endif // RANDOMIZE
end // initial
`ifdef FIRRTL_AFTER_INITIAL
`FIRRTL_AFTER_INITIAL
`endif
`endif // SYNTHESIS
endmodule
module SimpleRV32I(
  input         clock,
  input         reset,
  output [31:0] io_result
);
  wire  core_clock; // @[SimpleRISCV32I.scala 20:20]
  wire  core_reset; // @[SimpleRISCV32I.scala 20:20]
  wire [31:0] core_io_check_res; // @[SimpleRISCV32I.scala 20:20]
  RV32Icore core ( // @[SimpleRISCV32I.scala 20:20]
    .clock(core_clock),
    .reset(core_reset),
    .io_check_res(core_io_check_res)
  );
  assign io_result = core_io_check_res; // @[SimpleRISCV32I.scala 22:19]
  assign core_clock = clock;
  assign core_reset = reset;
endmodule
