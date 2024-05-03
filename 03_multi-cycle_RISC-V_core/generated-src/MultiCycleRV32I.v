module MultiCycleRV32Icore(
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
  reg [31:0] _RAND_3;
  reg [31:0] _RAND_4;
  reg [31:0] _RAND_5;
  reg [31:0] _RAND_6;
  reg [31:0] _RAND_7;
  reg [31:0] _RAND_8;
  reg [31:0] _RAND_9;
  reg [31:0] _RAND_10;
  reg [31:0] _RAND_11;
  reg [31:0] _RAND_12;
  reg [31:0] _RAND_13;
  reg [31:0] _RAND_14;
  reg [31:0] _RAND_15;
  reg [31:0] _RAND_16;
  reg [31:0] _RAND_17;
  reg [31:0] _RAND_18;
`endif // RANDOMIZE_REG_INIT
  reg [31:0] IMem [0:4095]; // @[core.scala 74:17]
  wire  IMem_instr_MPORT_en; // @[core.scala 74:17]
  wire [11:0] IMem_instr_MPORT_addr; // @[core.scala 74:17]
  wire [31:0] IMem_instr_MPORT_data; // @[core.scala 74:17]
  reg [31:0] regFile [0:31]; // @[core.scala 83:20]
  wire  regFile_operandA_MPORT_en; // @[core.scala 83:20]
  wire [4:0] regFile_operandA_MPORT_addr; // @[core.scala 83:20]
  wire [31:0] regFile_operandA_MPORT_data; // @[core.scala 83:20]
  wire  regFile_operandB_MPORT_en; // @[core.scala 83:20]
  wire [4:0] regFile_operandB_MPORT_addr; // @[core.scala 83:20]
  wire [31:0] regFile_operandB_MPORT_data; // @[core.scala 83:20]
  wire [31:0] regFile_MPORT_data; // @[core.scala 83:20]
  wire [4:0] regFile_MPORT_addr; // @[core.scala 83:20]
  wire  regFile_MPORT_mask; // @[core.scala 83:20]
  wire  regFile_MPORT_en; // @[core.scala 83:20]
  wire [31:0] regFile_MPORT_1_data; // @[core.scala 83:20]
  wire [4:0] regFile_MPORT_1_addr; // @[core.scala 83:20]
  wire  regFile_MPORT_1_mask; // @[core.scala 83:20]
  wire  regFile_MPORT_1_en; // @[core.scala 83:20]
  reg [2:0] stage; // @[core.scala 67:22]
  reg [31:0] pc; // @[core.scala 81:19]
  reg [31:0] instr; // @[core.scala 93:22]
  reg  isADD; // @[core.scala 94:22]
  reg  isSUB; // @[core.scala 95:22]
  reg  isSLL; // @[core.scala 96:22]
  reg  isSRL; // @[core.scala 97:22]
  reg  isSRA; // @[core.scala 98:22]
  reg  isXOR; // @[core.scala 99:22]
  reg  isOR; // @[core.scala 100:21]
  reg  isAND; // @[core.scala 101:22]
  reg  isADDI; // @[core.scala 102:23]
  reg [4:0] rd; // @[core.scala 107:23]
  reg [11:0] imm; // @[core.scala 116:20]
  reg [31:0] operandA; // @[core.scala 120:25]
  reg [31:0] operandB; // @[core.scala 121:25]
  reg [31:0] aluResult; // @[core.scala 122:26]
  wire  _T = stage == 3'h0; // @[core.scala 133:15]
  wire [31:0] _instr_T = {{2'd0}, pc[31:2]}; // @[core.scala 136:21]
  wire  _T_1 = stage == 3'h1; // @[core.scala 140:22]
  wire [6:0] _GEN_36 = _T_1 ? instr[6:0] : 7'h0; // @[core.scala 106:10 141:3 142:12]
  wire [6:0] opcode = _T ? 7'h0 : _GEN_36; // @[core.scala 106:10 134:3]
  wire  _isADD_T = opcode == 7'h33; // @[core.scala 150:23]
  wire [2:0] _GEN_38 = _T_1 ? instr[14:12] : 3'h0; // @[core.scala 109:10 141:3 144:12]
  wire [2:0] funct3 = _T ? 3'h0 : _GEN_38; // @[core.scala 109:10 134:3]
  wire  _isADD_T_1 = funct3 == 3'h0; // @[core.scala 150:50]
  wire  _isADD_T_2 = opcode == 7'h33 & funct3 == 3'h0; // @[core.scala 150:40]
  wire [6:0] _GEN_41 = _T_1 ? instr[31:25] : 7'h0; // @[core.scala 115:10 141:3 147:12]
  wire [6:0] funct7 = _T ? 7'h0 : _GEN_41; // @[core.scala 115:10 134:3]
  wire  _isADD_T_3 = funct7 == 7'h0; // @[core.scala 150:73]
  wire  _isSUB_T_3 = funct7 == 7'h20; // @[core.scala 151:73]
  wire  _isSRL_T_2 = _isADD_T & funct3 == 3'h5; // @[core.scala 153:40]
  wire  _T_2 = stage == 3'h2; // @[core.scala 167:22]
  wire [31:0] _GEN_105 = {{20'd0}, imm}; // @[core.scala 171:29]
  wire [31:0] _aluResult_T_1 = operandA + _GEN_105; // @[core.scala 171:29]
  wire [31:0] _aluResult_T_3 = operandA + operandB; // @[core.scala 173:29]
  wire [31:0] _aluResult_T_5 = operandA - operandB; // @[core.scala 175:29]
  wire [31:0] _aluResult_T_6 = operandA & operandB; // @[core.scala 177:29]
  wire [31:0] _aluResult_T_7 = operandA | operandB; // @[core.scala 179:29]
  wire [31:0] _aluResult_T_8 = operandA ^ operandB; // @[core.scala 181:29]
  wire [62:0] _GEN_10 = {{31'd0}, operandA}; // @[core.scala 183:29]
  wire [62:0] _aluResult_T_10 = _GEN_10 << operandB[4:0]; // @[core.scala 183:29]
  wire [31:0] _aluResult_T_12 = operandA >> operandB[4:0]; // @[core.scala 185:29]
  wire [31:0] _aluResult_T_16 = $signed(operandA) >>> operandB[4:0]; // @[core.scala 187:56]
  wire [31:0] _GEN_0 = isSRA ? _aluResult_T_16 : 32'h29a; // @[core.scala 186:23 187:17 189:17]
  wire [31:0] _GEN_1 = isSRL ? _aluResult_T_12 : _GEN_0; // @[core.scala 184:23 185:17]
  wire [62:0] _GEN_2 = isSLL ? _aluResult_T_10 : {{31'd0}, _GEN_1}; // @[core.scala 182:23 183:17]
  wire [62:0] _GEN_3 = isXOR ? {{31'd0}, _aluResult_T_8} : _GEN_2; // @[core.scala 180:22 181:17]
  wire [62:0] _GEN_4 = isOR ? {{31'd0}, _aluResult_T_7} : _GEN_3; // @[core.scala 178:22 179:17]
  wire [62:0] _GEN_5 = isAND ? {{31'd0}, _aluResult_T_6} : _GEN_4; // @[core.scala 176:23 177:17]
  wire [62:0] _GEN_6 = isSUB ? {{31'd0}, _aluResult_T_5} : _GEN_5; // @[core.scala 174:23 175:17]
  wire [62:0] _GEN_7 = isADD ? {{31'd0}, _aluResult_T_3} : _GEN_6; // @[core.scala 172:23 173:17]
  wire [62:0] _GEN_8 = isADDI ? {{31'd0}, _aluResult_T_1} : _GEN_7; // @[core.scala 170:18 171:17]
  wire  _T_3 = stage == 3'h3; // @[core.scala 196:22]
  wire  _T_4 = stage == 3'h4; // @[core.scala 208:22]
  wire [31:0] _pc_T_1 = pc + 32'h4; // @[core.scala 220:14]
  wire [31:0] _GEN_9 = _T_4 ? aluResult : 32'h0; // @[core.scala 118:17 209:3 211:19]
  wire [31:0] _GEN_18 = _T_3 ? 32'h0 : _GEN_9; // @[core.scala 118:17 197:3]
  wire [31:0] _GEN_28 = _T_2 ? 32'h0 : _GEN_18; // @[core.scala 118:17 168:3]
  wire [31:0] _GEN_60 = _T_1 ? 32'h0 : _GEN_28; // @[core.scala 118:17 141:3]
  wire [31:0] writeBackData = _T ? 32'h0 : _GEN_60; // @[core.scala 118:17 134:3]
  wire [31:0] _GEN_15 = _T_4 ? writeBackData : 32'h0; // @[core.scala 209:3 216:18 68:16]
  wire [31:0] _GEN_16 = _T_4 ? _pc_T_1 : pc; // @[core.scala 209:3 220:8 81:19]
  wire [2:0] _GEN_17 = _T_3 ? 3'h4 : stage; // @[core.scala 197:3 205:11 67:22]
  wire  _GEN_21 = _T_3 ? 1'h0 : _T_4; // @[core.scala 197:3 83:20]
  wire [31:0] _GEN_24 = _T_3 ? 32'h0 : _GEN_15; // @[core.scala 197:3 68:16]
  wire [31:0] _GEN_25 = _T_3 ? pc : _GEN_16; // @[core.scala 197:3 81:19]
  wire [62:0] _GEN_26 = _T_2 ? _GEN_8 : {{31'd0}, aluResult}; // @[core.scala 122:26 168:3]
  wire  _GEN_31 = _T_2 ? 1'h0 : _GEN_21; // @[core.scala 168:3 83:20]
  wire [31:0] _GEN_34 = _T_2 ? 32'h0 : _GEN_24; // @[core.scala 168:3 68:16]
  wire [4:0] _GEN_39 = _T_1 ? instr[19:15] : 5'h0; // @[core.scala 141:3 145:12 111:7]
  wire [4:0] _GEN_40 = _T_1 ? instr[24:20] : 5'h0; // @[core.scala 141:3 146:12 113:7]
  wire [62:0] _GEN_59 = _T_1 ? {{31'd0}, aluResult} : _GEN_26; // @[core.scala 122:26 141:3]
  wire  _GEN_63 = _T_1 ? 1'h0 : _GEN_31; // @[core.scala 141:3 83:20]
  wire [31:0] _GEN_66 = _T_1 ? 32'h0 : _GEN_34; // @[core.scala 141:3 68:16]
  wire [62:0] _GEN_95 = _T ? {{31'd0}, aluResult} : _GEN_59; // @[core.scala 122:26 134:3]
  wire [62:0] _GEN_106 = reset ? 63'h0 : _GEN_95; // @[core.scala 122:{26,26}]
  assign IMem_instr_MPORT_en = stage == 3'h0;
  assign IMem_instr_MPORT_addr = _instr_T[11:0];
  assign IMem_instr_MPORT_data = IMem[IMem_instr_MPORT_addr]; // @[core.scala 74:17]
  assign regFile_operandA_MPORT_en = _T ? 1'h0 : _T_1;
  assign regFile_operandA_MPORT_addr = _T ? 5'h0 : _GEN_39;
  assign regFile_operandA_MPORT_data = regFile[regFile_operandA_MPORT_addr]; // @[core.scala 83:20]
  assign regFile_operandB_MPORT_en = _T ? 1'h0 : _T_1;
  assign regFile_operandB_MPORT_addr = _T ? 5'h0 : _GEN_40;
  assign regFile_operandB_MPORT_data = regFile[regFile_operandB_MPORT_addr]; // @[core.scala 83:20]
  assign regFile_MPORT_data = 32'h0;
  assign regFile_MPORT_addr = 5'h0;
  assign regFile_MPORT_mask = 1'h1;
  assign regFile_MPORT_en = 1'h1;
  assign regFile_MPORT_1_data = _T ? 32'h0 : _GEN_60;
  assign regFile_MPORT_1_addr = rd;
  assign regFile_MPORT_1_mask = 1'h1;
  assign regFile_MPORT_1_en = _T ? 1'h0 : _GEN_63;
  assign io_check_res = _T ? 32'h0 : _GEN_66; // @[core.scala 134:3 68:16]
  always @(posedge clock) begin
    if (regFile_MPORT_en & regFile_MPORT_mask) begin
      regFile[regFile_MPORT_addr] <= regFile_MPORT_data; // @[core.scala 83:20]
    end
    if (regFile_MPORT_1_en & regFile_MPORT_1_mask) begin
      regFile[regFile_MPORT_1_addr] <= regFile_MPORT_1_data; // @[core.scala 83:20]
    end
    if (reset) begin // @[core.scala 67:22]
      stage <= 3'h0; // @[core.scala 67:22]
    end else if (_T) begin // @[core.scala 134:3]
      stage <= 3'h1; // @[core.scala 137:11]
    end else if (_T_1) begin // @[core.scala 141:3]
      stage <= 3'h2; // @[core.scala 164:11]
    end else if (_T_2) begin // @[core.scala 168:3]
      stage <= 3'h3; // @[core.scala 193:11]
    end else begin
      stage <= _GEN_17;
    end
    if (reset) begin // @[core.scala 81:19]
      pc <= 32'h0; // @[core.scala 81:19]
    end else if (!(_T)) begin // @[core.scala 134:3]
      if (!(_T_1)) begin // @[core.scala 141:3]
        if (!(_T_2)) begin // @[core.scala 168:3]
          pc <= _GEN_25;
        end
      end
    end
    if (reset) begin // @[core.scala 93:22]
      instr <= 32'h0; // @[core.scala 93:22]
    end else if (_T) begin // @[core.scala 134:3]
      instr <= IMem_instr_MPORT_data; // @[core.scala 136:11]
    end
    if (reset) begin // @[core.scala 94:22]
      isADD <= 1'h0; // @[core.scala 94:22]
    end else if (!(_T)) begin // @[core.scala 134:3]
      if (_T_1) begin // @[core.scala 141:3]
        isADD <= opcode == 7'h33 & funct3 == 3'h0 & funct7 == 7'h0; // @[core.scala 150:12]
      end
    end
    if (reset) begin // @[core.scala 95:22]
      isSUB <= 1'h0; // @[core.scala 95:22]
    end else if (!(_T)) begin // @[core.scala 134:3]
      if (_T_1) begin // @[core.scala 141:3]
        isSUB <= _isADD_T_2 & funct7 == 7'h20; // @[core.scala 151:12]
      end
    end
    if (reset) begin // @[core.scala 96:22]
      isSLL <= 1'h0; // @[core.scala 96:22]
    end else if (!(_T)) begin // @[core.scala 134:3]
      if (_T_1) begin // @[core.scala 141:3]
        isSLL <= _isADD_T & funct3 == 3'h1 & _isADD_T_3; // @[core.scala 152:12]
      end
    end
    if (reset) begin // @[core.scala 97:22]
      isSRL <= 1'h0; // @[core.scala 97:22]
    end else if (!(_T)) begin // @[core.scala 134:3]
      if (_T_1) begin // @[core.scala 141:3]
        isSRL <= _isADD_T & funct3 == 3'h5 & _isADD_T_3; // @[core.scala 153:12]
      end
    end
    if (reset) begin // @[core.scala 98:22]
      isSRA <= 1'h0; // @[core.scala 98:22]
    end else if (!(_T)) begin // @[core.scala 134:3]
      if (_T_1) begin // @[core.scala 141:3]
        isSRA <= _isSRL_T_2 & _isSUB_T_3; // @[core.scala 154:12]
      end
    end
    if (reset) begin // @[core.scala 99:22]
      isXOR <= 1'h0; // @[core.scala 99:22]
    end else if (!(_T)) begin // @[core.scala 134:3]
      if (_T_1) begin // @[core.scala 141:3]
        isXOR <= _isADD_T & funct3 == 3'h4 & _isADD_T_3; // @[core.scala 155:12]
      end
    end
    if (reset) begin // @[core.scala 100:21]
      isOR <= 1'h0; // @[core.scala 100:21]
    end else if (!(_T)) begin // @[core.scala 134:3]
      if (_T_1) begin // @[core.scala 141:3]
        isOR <= _isADD_T & funct3 == 3'h6 & _isADD_T_3; // @[core.scala 156:12]
      end
    end
    if (reset) begin // @[core.scala 101:22]
      isAND <= 1'h0; // @[core.scala 101:22]
    end else if (!(_T)) begin // @[core.scala 134:3]
      if (_T_1) begin // @[core.scala 141:3]
        isAND <= _isADD_T & funct3 == 3'h7 & _isADD_T_3; // @[core.scala 157:12]
      end
    end
    if (reset) begin // @[core.scala 102:23]
      isADDI <= 1'h0; // @[core.scala 102:23]
    end else if (!(_T)) begin // @[core.scala 134:3]
      if (_T_1) begin // @[core.scala 141:3]
        isADDI <= opcode == 7'h13 & _isADD_T_1; // @[core.scala 159:12]
      end
    end
    if (reset) begin // @[core.scala 107:23]
      rd <= 5'h0; // @[core.scala 107:23]
    end else if (!(_T)) begin // @[core.scala 134:3]
      if (_T_1) begin // @[core.scala 141:3]
        rd <= instr[11:7]; // @[core.scala 143:12]
      end
    end
    if (reset) begin // @[core.scala 116:20]
      imm <= 12'h0; // @[core.scala 116:20]
    end else if (!(_T)) begin // @[core.scala 134:3]
      if (_T_1) begin // @[core.scala 141:3]
        imm <= instr[31:20]; // @[core.scala 148:9]
      end
    end
    if (reset) begin // @[core.scala 120:25]
      operandA <= 32'h0; // @[core.scala 120:25]
    end else if (!(_T)) begin // @[core.scala 134:3]
      if (_T_1) begin // @[core.scala 141:3]
        operandA <= regFile_operandA_MPORT_data; // @[core.scala 161:14]
      end
    end
    if (reset) begin // @[core.scala 121:25]
      operandB <= 32'h0; // @[core.scala 121:25]
    end else if (!(_T)) begin // @[core.scala 134:3]
      if (_T_1) begin // @[core.scala 141:3]
        operandB <= regFile_operandB_MPORT_data; // @[core.scala 162:14]
      end
    end
    aluResult <= _GEN_106[31:0]; // @[core.scala 122:{26,26}]
    `ifndef SYNTHESIS
    `ifdef STOP_COND
      if (`STOP_COND) begin
    `endif
        if (~1'h1 & (~_T & ~_T_1 & ~_T_2 & ~_T_3 & ~_T_4 & ~reset)) begin
          $fatal; // @[core.scala 228:12]
        end
    `ifdef STOP_COND
      end
    `endif
    `endif // SYNTHESIS
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
  stage = _RAND_2[2:0];
  _RAND_3 = {1{`RANDOM}};
  pc = _RAND_3[31:0];
  _RAND_4 = {1{`RANDOM}};
  instr = _RAND_4[31:0];
  _RAND_5 = {1{`RANDOM}};
  isADD = _RAND_5[0:0];
  _RAND_6 = {1{`RANDOM}};
  isSUB = _RAND_6[0:0];
  _RAND_7 = {1{`RANDOM}};
  isSLL = _RAND_7[0:0];
  _RAND_8 = {1{`RANDOM}};
  isSRL = _RAND_8[0:0];
  _RAND_9 = {1{`RANDOM}};
  isSRA = _RAND_9[0:0];
  _RAND_10 = {1{`RANDOM}};
  isXOR = _RAND_10[0:0];
  _RAND_11 = {1{`RANDOM}};
  isOR = _RAND_11[0:0];
  _RAND_12 = {1{`RANDOM}};
  isAND = _RAND_12[0:0];
  _RAND_13 = {1{`RANDOM}};
  isADDI = _RAND_13[0:0];
  _RAND_14 = {1{`RANDOM}};
  rd = _RAND_14[4:0];
  _RAND_15 = {1{`RANDOM}};
  imm = _RAND_15[11:0];
  _RAND_16 = {1{`RANDOM}};
  operandA = _RAND_16[31:0];
  _RAND_17 = {1{`RANDOM}};
  operandB = _RAND_17[31:0];
  _RAND_18 = {1{`RANDOM}};
  aluResult = _RAND_18[31:0];
`endif // RANDOMIZE_REG_INIT
  `endif // RANDOMIZE
end // initial
`ifdef FIRRTL_AFTER_INITIAL
`FIRRTL_AFTER_INITIAL
`endif
`endif // SYNTHESIS
endmodule
module MultiCycleRV32I(
  input         clock,
  input         reset,
  output [31:0] io_result
);
  wire  core_clock; // @[MultiCycleRISCV32I.scala 20:20]
  wire  core_reset; // @[MultiCycleRISCV32I.scala 20:20]
  wire [31:0] core_io_check_res; // @[MultiCycleRISCV32I.scala 20:20]
  MultiCycleRV32Icore core ( // @[MultiCycleRISCV32I.scala 20:20]
    .clock(core_clock),
    .reset(core_reset),
    .io_check_res(core_io_check_res)
  );
  assign io_result = core_io_check_res; // @[MultiCycleRISCV32I.scala 22:19]
  assign core_clock = clock;
  assign core_reset = reset;
endmodule
