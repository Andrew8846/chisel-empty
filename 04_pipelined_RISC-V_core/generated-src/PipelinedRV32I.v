module IFBarrier(
  input         clock,
  input  [31:0] io_instrIn,
  output [31:0] io_instrOut
);
`ifdef RANDOMIZE_REG_INIT
  reg [31:0] _RAND_0;
`endif // RANDOMIZE_REG_INIT
  reg [31:0] instrReg; // @[core.scala 332:21]
  assign io_instrOut = instrReg; // @[core.scala 338:15]
  always @(posedge clock) begin
    instrReg <= io_instrIn; // @[core.scala 335:12]
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
`ifdef RANDOMIZE_REG_INIT
  _RAND_0 = {1{`RANDOM}};
  instrReg = _RAND_0[31:0];
`endif // RANDOMIZE_REG_INIT
  `endif // RANDOMIZE
end // initial
`ifdef FIRRTL_AFTER_INITIAL
`FIRRTL_AFTER_INITIAL
`endif
`endif // SYNTHESIS
endmodule
module IDBarrier(
  input         clock,
  input  [11:0] io_immediate,
  input  [7:0]  io_uop,
  input  [4:0]  io_rd,
  input  [4:0]  io_rs1,
  input  [4:0]  io_rs2,
  output [11:0] io_immediateOut,
  output [7:0]  io_uopOut,
  output [4:0]  io_rdOut,
  output [4:0]  io_rs1out,
  output [4:0]  io_rs2out
);
`ifdef RANDOMIZE_REG_INIT
  reg [31:0] _RAND_0;
  reg [31:0] _RAND_1;
  reg [31:0] _RAND_2;
  reg [31:0] _RAND_3;
  reg [31:0] _RAND_4;
`endif // RANDOMIZE_REG_INIT
  reg [11:0] immReg; // @[core.scala 362:19]
  reg [7:0] opReg; // @[core.scala 363:18]
  reg [4:0] rdReg; // @[core.scala 364:18]
  reg [4:0] rs1Reg; // @[core.scala 365:19]
  reg [4:0] rs2Reg; // @[core.scala 366:19]
  assign io_immediateOut = immReg; // @[core.scala 374:19]
  assign io_uopOut = opReg; // @[core.scala 375:13]
  assign io_rdOut = rdReg; // @[core.scala 376:12]
  assign io_rs1out = rs1Reg; // @[core.scala 377:13]
  assign io_rs2out = rs2Reg; // @[core.scala 378:13]
  always @(posedge clock) begin
    immReg <= io_immediate; // @[core.scala 368:10]
    opReg <= io_uop; // @[core.scala 369:9]
    rdReg <= io_rd; // @[core.scala 370:9]
    rs1Reg <= io_rs1; // @[core.scala 371:10]
    rs2Reg <= io_rs2; // @[core.scala 372:10]
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
`ifdef RANDOMIZE_REG_INIT
  _RAND_0 = {1{`RANDOM}};
  immReg = _RAND_0[11:0];
  _RAND_1 = {1{`RANDOM}};
  opReg = _RAND_1[7:0];
  _RAND_2 = {1{`RANDOM}};
  rdReg = _RAND_2[4:0];
  _RAND_3 = {1{`RANDOM}};
  rs1Reg = _RAND_3[4:0];
  _RAND_4 = {1{`RANDOM}};
  rs2Reg = _RAND_4[4:0];
`endif // RANDOMIZE_REG_INIT
  `endif // RANDOMIZE
end // initial
`ifdef FIRRTL_AFTER_INITIAL
`FIRRTL_AFTER_INITIAL
`endif
`endif // SYNTHESIS
endmodule
module EXBarrier(
  input         clock,
  input  [31:0] io_result,
  input  [4:0]  io_rd,
  output [31:0] io_resOut,
  output [4:0]  io_rdOut
);
`ifdef RANDOMIZE_REG_INIT
  reg [31:0] _RAND_0;
  reg [31:0] _RAND_1;
`endif // RANDOMIZE_REG_INIT
  reg [31:0] resultReg; // @[core.scala 396:22]
  reg [4:0] rdReg; // @[core.scala 397:18]
  assign io_resOut = resultReg; // @[core.scala 402:13]
  assign io_rdOut = rdReg; // @[core.scala 403:12]
  always @(posedge clock) begin
    resultReg <= io_result; // @[core.scala 399:13]
    rdReg <= io_rd; // @[core.scala 400:9]
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
`ifdef RANDOMIZE_REG_INIT
  _RAND_0 = {1{`RANDOM}};
  resultReg = _RAND_0[31:0];
  _RAND_1 = {1{`RANDOM}};
  rdReg = _RAND_1[4:0];
`endif // RANDOMIZE_REG_INIT
  `endif // RANDOMIZE
end // initial
`ifdef FIRRTL_AFTER_INITIAL
`FIRRTL_AFTER_INITIAL
`endif
`endif // SYNTHESIS
endmodule
module MEMBarrier(
  input         clock,
  input  [4:0]  io_rdIn,
  input  [31:0] io_resultIn,
  output [4:0]  io_rdOut,
  output [31:0] io_resultOut
);
`ifdef RANDOMIZE_REG_INIT
  reg [31:0] _RAND_0;
  reg [31:0] _RAND_1;
`endif // RANDOMIZE_REG_INIT
  reg [4:0] rdreg; // @[core.scala 421:18]
  reg [31:0] resReg; // @[core.scala 422:19]
  assign io_rdOut = rdreg; // @[core.scala 427:12]
  assign io_resultOut = resReg; // @[core.scala 428:16]
  always @(posedge clock) begin
    rdreg <= io_rdIn; // @[core.scala 424:9]
    resReg <= io_resultIn; // @[core.scala 425:10]
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
`ifdef RANDOMIZE_REG_INIT
  _RAND_0 = {1{`RANDOM}};
  rdreg = _RAND_0[4:0];
  _RAND_1 = {1{`RANDOM}};
  resReg = _RAND_1[31:0];
`endif // RANDOMIZE_REG_INIT
  `endif // RANDOMIZE
end // initial
`ifdef FIRRTL_AFTER_INITIAL
`FIRRTL_AFTER_INITIAL
`endif
`endif // SYNTHESIS
endmodule
module IF(
  input         clock,
  input  [31:0] io_pc,
  output [31:0] io_instr,
  output [31:0] io_pcNew
);
`ifdef RANDOMIZE_MEM_INIT
  reg [31:0] _RAND_0;
`endif // RANDOMIZE_MEM_INIT
  reg [31:0] IMem [0:4095]; // @[core.scala 173:17]
  wire  IMem_io_instr_MPORT_en; // @[core.scala 173:17]
  wire [11:0] IMem_io_instr_MPORT_addr; // @[core.scala 173:17]
  wire [31:0] IMem_io_instr_MPORT_data; // @[core.scala 173:17]
  wire [31:0] _io_instr_T = {{2'd0}, io_pc[31:2]}; // @[core.scala 176:25]
  assign IMem_io_instr_MPORT_en = 1'h1;
  assign IMem_io_instr_MPORT_addr = _io_instr_T[11:0];
  assign IMem_io_instr_MPORT_data = IMem[IMem_io_instr_MPORT_addr]; // @[core.scala 173:17]
  assign io_instr = IMem_io_instr_MPORT_data; // @[core.scala 176:12]
  assign io_pcNew = io_pc + 32'h4; // @[core.scala 178:21]
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
`endif // RANDOMIZE_MEM_INIT
  `endif // RANDOMIZE
end // initial
`ifdef FIRRTL_AFTER_INITIAL
`FIRRTL_AFTER_INITIAL
`endif
`endif // SYNTHESIS
endmodule
module ID(
  input  [31:0] io_instr,
  output [11:0] io_immediate,
  output [7:0]  io_uop,
  output [4:0]  io_rs1,
  output [4:0]  io_rs2,
  output [4:0]  io_rd
);
  wire [6:0] opcode = io_instr[6:0]; // @[core.scala 196:24]
  wire [2:0] funct3 = io_instr[14:12]; // @[core.scala 198:24]
  wire [6:0] funct7 = io_instr[31:25]; // @[core.scala 201:24]
  wire  _T = opcode == 7'h33; // @[core.scala 205:15]
  wire  _T_1 = funct3 == 3'h0; // @[core.scala 205:42]
  wire  _T_2 = opcode == 7'h33 & funct3 == 3'h0; // @[core.scala 205:32]
  wire  _T_3 = funct7 == 7'h0; // @[core.scala 205:65]
  wire  _T_8 = funct7 == 7'h20; // @[core.scala 207:71]
  wire  _T_17 = _T & funct3 == 3'h5; // @[core.scala 211:38]
  wire [7:0] _GEN_0 = opcode == 7'h13 & _T_1 ? 8'h10 : 8'hff; // @[core.scala 225:62 226:12 228:12]
  wire [7:0] _GEN_1 = _T & funct3 == 3'h3 & _T_3 ? 8'ha : _GEN_0; // @[core.scala 223:89 224:12]
  wire [7:0] _GEN_2 = _T & funct3 == 3'h2 & _T_3 ? 8'h9 : _GEN_1; // @[core.scala 221:89 222:12]
  wire [7:0] _GEN_3 = _T & funct3 == 3'h7 & _T_3 ? 8'h1 : _GEN_2; // @[core.scala 219:89 220:12]
  wire [7:0] _GEN_4 = _T & funct3 == 3'h6 & _T_3 ? 8'h4 : _GEN_3; // @[core.scala 217:89 218:12]
  wire [7:0] _GEN_5 = _T & funct3 == 3'h4 & _T_3 ? 8'h3 : _GEN_4; // @[core.scala 215:89 216:12]
  wire [7:0] _GEN_6 = _T_17 & _T_8 ? 8'h8 : _GEN_5; // @[core.scala 213:89 214:12]
  wire [7:0] _GEN_7 = _T & funct3 == 3'h5 & _T_3 ? 8'h7 : _GEN_6; // @[core.scala 211:89 212:12]
  wire [7:0] _GEN_8 = _T & funct3 == 3'h1 & _T_3 ? 8'h6 : _GEN_7; // @[core.scala 209:89 210:12]
  wire [7:0] _GEN_9 = _T_2 & funct7 == 7'h20 ? 8'h2 : _GEN_8; // @[core.scala 207:89 208:12]
  assign io_immediate = io_instr[31:20]; // @[core.scala 202:21]
  assign io_uop = opcode == 7'h33 & funct3 == 3'h0 & funct7 == 7'h0 ? 8'h1 : _GEN_9; // @[core.scala 205:83 206:12]
  assign io_rs1 = io_instr[19:15]; // @[core.scala 199:24]
  assign io_rs2 = io_instr[24:20]; // @[core.scala 200:24]
  assign io_rd = io_instr[11:7]; // @[core.scala 197:24]
endmodule
module EX(
  input  [7:0]  io_uop,
  input  [31:0] io_operandA,
  input  [31:0] io_operandB,
  input  [11:0] io_immediate,
  output [31:0] io_result
);
  wire [31:0] _io_result_T_1 = io_operandA + io_operandB; // @[core.scala 254:30]
  wire  _T_1 = io_uop == 8'h2; // @[core.scala 255:21]
  wire [31:0] _io_result_T_3 = io_operandA - io_operandB; // @[core.scala 256:30]
  wire [31:0] _io_result_T_4 = io_operandA & io_operandB; // @[core.scala 258:30]
  wire [31:0] _io_result_T_5 = io_operandA | io_operandB; // @[core.scala 260:30]
  wire [31:0] _io_result_T_6 = io_operandA ^ io_operandB; // @[core.scala 262:30]
  wire [62:0] _GEN_12 = {{31'd0}, io_operandA}; // @[core.scala 264:30]
  wire [62:0] _io_result_T_8 = _GEN_12 << io_operandB[4:0]; // @[core.scala 264:30]
  wire [31:0] _io_result_T_10 = io_operandA >> io_operandB[4:0]; // @[core.scala 266:30]
  wire [31:0] _io_result_T_11 = io_operandA; // @[core.scala 268:31]
  wire [31:0] _io_result_T_14 = $signed(io_operandA) >>> io_operandB[4:0]; // @[core.scala 268:60]
  wire [31:0] _io_result_T_18 = io_operandB; // @[core.scala 272:56]
  wire [31:0] _GEN_11 = {{20'd0}, io_immediate}; // @[core.scala 274:30]
  wire [31:0] _io_result_T_22 = io_operandA + _GEN_11; // @[core.scala 274:30]
  wire [31:0] _GEN_0 = io_uop == 8'h10 ? _io_result_T_22 : 32'hffffffff; // @[core.scala 273:33 274:15 276:15]
  wire [31:0] _GEN_1 = _T_1 ? {{31'd0}, $signed(_io_result_T_11) < $signed(_io_result_T_18)} : _GEN_0; // @[core.scala 271:32 272:15]
  wire [31:0] _GEN_2 = io_uop == 8'ha ? {{31'd0}, io_operandA < io_operandB} : _GEN_1; // @[core.scala 269:33 270:15]
  wire [31:0] _GEN_3 = io_uop == 8'h8 ? _io_result_T_14 : _GEN_2; // @[core.scala 267:32 268:15]
  wire [31:0] _GEN_4 = io_uop == 8'h7 ? _io_result_T_10 : _GEN_3; // @[core.scala 265:32 266:15]
  wire [62:0] _GEN_5 = io_uop == 8'h6 ? _io_result_T_8 : {{31'd0}, _GEN_4}; // @[core.scala 263:32 264:15]
  wire [62:0] _GEN_6 = io_uop == 8'h3 ? {{31'd0}, _io_result_T_6} : _GEN_5; // @[core.scala 261:32 262:15]
  wire [62:0] _GEN_7 = io_uop == 8'h4 ? {{31'd0}, _io_result_T_5} : _GEN_6; // @[core.scala 259:31 260:15]
  wire [62:0] _GEN_8 = io_uop == 8'h5 ? {{31'd0}, _io_result_T_4} : _GEN_7; // @[core.scala 257:32 258:15]
  wire [62:0] _GEN_9 = io_uop == 8'h2 ? {{31'd0}, _io_result_T_3} : _GEN_8; // @[core.scala 255:32 256:15]
  wire [62:0] _GEN_10 = io_uop == 8'h1 ? {{31'd0}, _io_result_T_1} : _GEN_9; // @[core.scala 253:27 254:15]
  assign io_result = _GEN_10[31:0];
endmodule
module MEM(
  input  [4:0]  io_rd,
  input  [31:0] io_result,
  output [4:0]  io_rdO,
  output [31:0] io_resultO
);
  assign io_rdO = io_rd; // @[core.scala 293:10]
  assign io_resultO = io_result; // @[core.scala 294:14]
endmodule
module WB(
  input  [4:0]  io_rd,
  input  [31:0] io_result,
  output [4:0]  io_wbToRegFile_rd,
  output [31:0] io_wbToRegFile_data,
  output [31:0] io_check_res
);
  assign io_wbToRegFile_rd = io_rd; // @[core.scala 312:21]
  assign io_wbToRegFile_data = io_result; // @[core.scala 313:23]
  assign io_check_res = io_result; // @[core.scala 314:16]
endmodule
module ForwardingUnit(
  input  [4:0] io_idRs1,
  input  [4:0] io_idRs2,
  input  [4:0] io_exRd,
  input  [4:0] io_wbRd,
  output       io_forward
);
  wire  _hazard_T_10 = io_wbRd != 5'h0 & (io_wbRd == io_idRs1 | io_wbRd == io_idRs2); // @[core.scala 156:40]
  assign io_forward = io_exRd != 5'h0 & (io_exRd == io_idRs1 | io_exRd == io_idRs2) | _hazard_T_10; // @[core.scala 155:86]
endmodule
module regFile(
  input         clock,
  input  [4:0]  io_req1_rs,
  input  [4:0]  io_req2_rs,
  output [31:0] io_resp1_data,
  output [31:0] io_resp2_data,
  input  [4:0]  io_write_rd,
  input  [31:0] io_write_data
);
`ifdef RANDOMIZE_MEM_INIT
  reg [31:0] _RAND_0;
`endif // RANDOMIZE_MEM_INIT
  reg [31:0] regFile [0:31]; // @[core.scala 127:20]
  wire  regFile_io_resp1_data_MPORT_en; // @[core.scala 127:20]
  wire [4:0] regFile_io_resp1_data_MPORT_addr; // @[core.scala 127:20]
  wire [31:0] regFile_io_resp1_data_MPORT_data; // @[core.scala 127:20]
  wire  regFile_io_resp2_data_MPORT_en; // @[core.scala 127:20]
  wire [4:0] regFile_io_resp2_data_MPORT_addr; // @[core.scala 127:20]
  wire [31:0] regFile_io_resp2_data_MPORT_data; // @[core.scala 127:20]
  wire [31:0] regFile_MPORT_data; // @[core.scala 127:20]
  wire [4:0] regFile_MPORT_addr; // @[core.scala 127:20]
  wire  regFile_MPORT_mask; // @[core.scala 127:20]
  wire  regFile_MPORT_en; // @[core.scala 127:20]
  wire [31:0] regFile_MPORT_1_data; // @[core.scala 127:20]
  wire [4:0] regFile_MPORT_1_addr; // @[core.scala 127:20]
  wire  regFile_MPORT_1_mask; // @[core.scala 127:20]
  wire  regFile_MPORT_1_en; // @[core.scala 127:20]
  assign regFile_io_resp1_data_MPORT_en = 1'h1;
  assign regFile_io_resp1_data_MPORT_addr = io_req1_rs;
  assign regFile_io_resp1_data_MPORT_data = regFile[regFile_io_resp1_data_MPORT_addr]; // @[core.scala 127:20]
  assign regFile_io_resp2_data_MPORT_en = 1'h1;
  assign regFile_io_resp2_data_MPORT_addr = io_req2_rs;
  assign regFile_io_resp2_data_MPORT_data = regFile[regFile_io_resp2_data_MPORT_addr]; // @[core.scala 127:20]
  assign regFile_MPORT_data = 32'h0;
  assign regFile_MPORT_addr = 5'h0;
  assign regFile_MPORT_mask = 1'h1;
  assign regFile_MPORT_en = 1'h1;
  assign regFile_MPORT_1_data = io_write_data;
  assign regFile_MPORT_1_addr = io_write_rd;
  assign regFile_MPORT_1_mask = 1'h1;
  assign regFile_MPORT_1_en = 1'h1;
  assign io_resp1_data = regFile_io_resp1_data_MPORT_data; // @[core.scala 129:17]
  assign io_resp2_data = regFile_io_resp2_data_MPORT_data; // @[core.scala 130:17]
  always @(posedge clock) begin
    if (regFile_MPORT_en & regFile_MPORT_mask) begin
      regFile[regFile_MPORT_addr] <= regFile_MPORT_data; // @[core.scala 127:20]
    end
    if (regFile_MPORT_1_en & regFile_MPORT_1_mask) begin
      regFile[regFile_MPORT_1_addr] <= regFile_MPORT_1_data; // @[core.scala 127:20]
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
  for (initvar = 0; initvar < 32; initvar = initvar+1)
    regFile[initvar] = _RAND_0[31:0];
`endif // RANDOMIZE_MEM_INIT
  `endif // RANDOMIZE
end // initial
`ifdef FIRRTL_AFTER_INITIAL
`FIRRTL_AFTER_INITIAL
`endif
`endif // SYNTHESIS
endmodule
module PipelinedRV32Icore(
  input         clock,
  input         reset,
  output [31:0] io_check_res
);
`ifdef RANDOMIZE_REG_INIT
  reg [31:0] _RAND_0;
`endif // RANDOMIZE_REG_INIT
  wire  ifBarrier_clock; // @[core.scala 464:25]
  wire [31:0] ifBarrier_io_instrIn; // @[core.scala 464:25]
  wire [31:0] ifBarrier_io_instrOut; // @[core.scala 464:25]
  wire  idBarrier_clock; // @[core.scala 465:25]
  wire [11:0] idBarrier_io_immediate; // @[core.scala 465:25]
  wire [7:0] idBarrier_io_uop; // @[core.scala 465:25]
  wire [4:0] idBarrier_io_rd; // @[core.scala 465:25]
  wire [4:0] idBarrier_io_rs1; // @[core.scala 465:25]
  wire [4:0] idBarrier_io_rs2; // @[core.scala 465:25]
  wire [11:0] idBarrier_io_immediateOut; // @[core.scala 465:25]
  wire [7:0] idBarrier_io_uopOut; // @[core.scala 465:25]
  wire [4:0] idBarrier_io_rdOut; // @[core.scala 465:25]
  wire [4:0] idBarrier_io_rs1out; // @[core.scala 465:25]
  wire [4:0] idBarrier_io_rs2out; // @[core.scala 465:25]
  wire  exBarrier_clock; // @[core.scala 466:25]
  wire [31:0] exBarrier_io_result; // @[core.scala 466:25]
  wire [4:0] exBarrier_io_rd; // @[core.scala 466:25]
  wire [31:0] exBarrier_io_resOut; // @[core.scala 466:25]
  wire [4:0] exBarrier_io_rdOut; // @[core.scala 466:25]
  wire  memBarrier_clock; // @[core.scala 467:26]
  wire [4:0] memBarrier_io_rdIn; // @[core.scala 467:26]
  wire [31:0] memBarrier_io_resultIn; // @[core.scala 467:26]
  wire [4:0] memBarrier_io_rdOut; // @[core.scala 467:26]
  wire [31:0] memBarrier_io_resultOut; // @[core.scala 467:26]
  wire  IF_clock; // @[core.scala 471:18]
  wire [31:0] IF_io_pc; // @[core.scala 471:18]
  wire [31:0] IF_io_instr; // @[core.scala 471:18]
  wire [31:0] IF_io_pcNew; // @[core.scala 471:18]
  wire [31:0] ID_io_instr; // @[core.scala 472:18]
  wire [11:0] ID_io_immediate; // @[core.scala 472:18]
  wire [7:0] ID_io_uop; // @[core.scala 472:18]
  wire [4:0] ID_io_rs1; // @[core.scala 472:18]
  wire [4:0] ID_io_rs2; // @[core.scala 472:18]
  wire [4:0] ID_io_rd; // @[core.scala 472:18]
  wire [7:0] EX_io_uop; // @[core.scala 473:18]
  wire [31:0] EX_io_operandA; // @[core.scala 473:18]
  wire [31:0] EX_io_operandB; // @[core.scala 473:18]
  wire [11:0] EX_io_immediate; // @[core.scala 473:18]
  wire [31:0] EX_io_result; // @[core.scala 473:18]
  wire [4:0] MEM_io_rd; // @[core.scala 474:19]
  wire [31:0] MEM_io_result; // @[core.scala 474:19]
  wire [4:0] MEM_io_rdO; // @[core.scala 474:19]
  wire [31:0] MEM_io_resultO; // @[core.scala 474:19]
  wire [4:0] WB_io_rd; // @[core.scala 475:18]
  wire [31:0] WB_io_result; // @[core.scala 475:18]
  wire [4:0] WB_io_wbToRegFile_rd; // @[core.scala 475:18]
  wire [31:0] WB_io_wbToRegFile_data; // @[core.scala 475:18]
  wire [31:0] WB_io_check_res; // @[core.scala 475:18]
  wire [4:0] fwUnit_io_idRs1; // @[core.scala 477:22]
  wire [4:0] fwUnit_io_idRs2; // @[core.scala 477:22]
  wire [4:0] fwUnit_io_exRd; // @[core.scala 477:22]
  wire [4:0] fwUnit_io_wbRd; // @[core.scala 477:22]
  wire  fwUnit_io_forward; // @[core.scala 477:22]
  wire  regFile_clock; // @[core.scala 480:23]
  wire [4:0] regFile_io_req1_rs; // @[core.scala 480:23]
  wire [4:0] regFile_io_req2_rs; // @[core.scala 480:23]
  wire [31:0] regFile_io_resp1_data; // @[core.scala 480:23]
  wire [31:0] regFile_io_resp2_data; // @[core.scala 480:23]
  wire [4:0] regFile_io_write_rd; // @[core.scala 480:23]
  wire [31:0] regFile_io_write_data; // @[core.scala 480:23]
  reg [31:0] pc; // @[core.scala 484:19]
  IFBarrier ifBarrier ( // @[core.scala 464:25]
    .clock(ifBarrier_clock),
    .io_instrIn(ifBarrier_io_instrIn),
    .io_instrOut(ifBarrier_io_instrOut)
  );
  IDBarrier idBarrier ( // @[core.scala 465:25]
    .clock(idBarrier_clock),
    .io_immediate(idBarrier_io_immediate),
    .io_uop(idBarrier_io_uop),
    .io_rd(idBarrier_io_rd),
    .io_rs1(idBarrier_io_rs1),
    .io_rs2(idBarrier_io_rs2),
    .io_immediateOut(idBarrier_io_immediateOut),
    .io_uopOut(idBarrier_io_uopOut),
    .io_rdOut(idBarrier_io_rdOut),
    .io_rs1out(idBarrier_io_rs1out),
    .io_rs2out(idBarrier_io_rs2out)
  );
  EXBarrier exBarrier ( // @[core.scala 466:25]
    .clock(exBarrier_clock),
    .io_result(exBarrier_io_result),
    .io_rd(exBarrier_io_rd),
    .io_resOut(exBarrier_io_resOut),
    .io_rdOut(exBarrier_io_rdOut)
  );
  MEMBarrier memBarrier ( // @[core.scala 467:26]
    .clock(memBarrier_clock),
    .io_rdIn(memBarrier_io_rdIn),
    .io_resultIn(memBarrier_io_resultIn),
    .io_rdOut(memBarrier_io_rdOut),
    .io_resultOut(memBarrier_io_resultOut)
  );
  IF IF ( // @[core.scala 471:18]
    .clock(IF_clock),
    .io_pc(IF_io_pc),
    .io_instr(IF_io_instr),
    .io_pcNew(IF_io_pcNew)
  );
  ID ID ( // @[core.scala 472:18]
    .io_instr(ID_io_instr),
    .io_immediate(ID_io_immediate),
    .io_uop(ID_io_uop),
    .io_rs1(ID_io_rs1),
    .io_rs2(ID_io_rs2),
    .io_rd(ID_io_rd)
  );
  EX EX ( // @[core.scala 473:18]
    .io_uop(EX_io_uop),
    .io_operandA(EX_io_operandA),
    .io_operandB(EX_io_operandB),
    .io_immediate(EX_io_immediate),
    .io_result(EX_io_result)
  );
  MEM MEM ( // @[core.scala 474:19]
    .io_rd(MEM_io_rd),
    .io_result(MEM_io_result),
    .io_rdO(MEM_io_rdO),
    .io_resultO(MEM_io_resultO)
  );
  WB WB ( // @[core.scala 475:18]
    .io_rd(WB_io_rd),
    .io_result(WB_io_result),
    .io_wbToRegFile_rd(WB_io_wbToRegFile_rd),
    .io_wbToRegFile_data(WB_io_wbToRegFile_data),
    .io_check_res(WB_io_check_res)
  );
  ForwardingUnit fwUnit ( // @[core.scala 477:22]
    .io_idRs1(fwUnit_io_idRs1),
    .io_idRs2(fwUnit_io_idRs2),
    .io_exRd(fwUnit_io_exRd),
    .io_wbRd(fwUnit_io_wbRd),
    .io_forward(fwUnit_io_forward)
  );
  regFile regFile ( // @[core.scala 480:23]
    .clock(regFile_clock),
    .io_req1_rs(regFile_io_req1_rs),
    .io_req2_rs(regFile_io_req2_rs),
    .io_resp1_data(regFile_io_resp1_data),
    .io_resp2_data(regFile_io_resp2_data),
    .io_write_rd(regFile_io_write_rd),
    .io_write_data(regFile_io_write_data)
  );
  assign io_check_res = WB_io_check_res; // @[core.scala 536:16]
  assign ifBarrier_clock = clock;
  assign ifBarrier_io_instrIn = IF_io_instr; // @[core.scala 490:24]
  assign idBarrier_clock = clock;
  assign idBarrier_io_immediate = ID_io_immediate; // @[core.scala 499:26]
  assign idBarrier_io_uop = ID_io_uop; // @[core.scala 501:20]
  assign idBarrier_io_rd = ID_io_rd; // @[core.scala 500:19]
  assign idBarrier_io_rs1 = ID_io_rs1; // @[core.scala 496:20]
  assign idBarrier_io_rs2 = ID_io_rs2; // @[core.scala 497:20]
  assign exBarrier_clock = clock;
  assign exBarrier_io_result = EX_io_result; // @[core.scala 522:23]
  assign exBarrier_io_rd = idBarrier_io_rdOut; // @[core.scala 521:19]
  assign memBarrier_clock = clock;
  assign memBarrier_io_rdIn = MEM_io_rdO; // @[core.scala 528:22]
  assign memBarrier_io_resultIn = MEM_io_resultO; // @[core.scala 527:26]
  assign IF_clock = clock;
  assign IF_io_pc = pc; // @[core.scala 487:12]
  assign ID_io_instr = ifBarrier_io_instrOut; // @[core.scala 493:15]
  assign EX_io_uop = idBarrier_io_uopOut; // @[core.scala 517:13]
  assign EX_io_operandA = fwUnit_io_forward ? exBarrier_io_resOut : regFile_io_resp1_data; // @[core.scala 514:21]
  assign EX_io_operandB = fwUnit_io_forward ? exBarrier_io_resOut : regFile_io_resp2_data; // @[core.scala 515:21]
  assign EX_io_immediate = idBarrier_io_immediateOut; // @[core.scala 520:19]
  assign MEM_io_rd = exBarrier_io_rdOut; // @[core.scala 525:13]
  assign MEM_io_result = exBarrier_io_resOut; // @[core.scala 526:17]
  assign WB_io_rd = memBarrier_io_rdOut; // @[core.scala 533:12]
  assign WB_io_result = memBarrier_io_resultOut; // @[core.scala 532:16]
  assign fwUnit_io_idRs1 = idBarrier_io_rs1out; // @[core.scala 507:23]
  assign fwUnit_io_idRs2 = idBarrier_io_rs2out; // @[core.scala 508:23]
  assign fwUnit_io_exRd = exBarrier_io_rdOut; // @[core.scala 509:23]
  assign fwUnit_io_wbRd = WB_io_rd; // @[core.scala 510:23]
  assign regFile_clock = clock;
  assign regFile_io_req1_rs = idBarrier_io_rs1out; // @[core.scala 504:22]
  assign regFile_io_req2_rs = idBarrier_io_rs2out; // @[core.scala 505:22]
  assign regFile_io_write_rd = WB_io_wbToRegFile_rd; // @[core.scala 535:20]
  assign regFile_io_write_data = WB_io_wbToRegFile_data; // @[core.scala 535:20]
  always @(posedge clock) begin
    if (reset) begin // @[core.scala 484:19]
      pc <= 32'h0; // @[core.scala 484:19]
    end else begin
      pc <= IF_io_pcNew; // @[core.scala 488:6]
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
`ifdef RANDOMIZE_REG_INIT
  _RAND_0 = {1{`RANDOM}};
  pc = _RAND_0[31:0];
`endif // RANDOMIZE_REG_INIT
  `endif // RANDOMIZE
end // initial
`ifdef FIRRTL_AFTER_INITIAL
`FIRRTL_AFTER_INITIAL
`endif
`endif // SYNTHESIS
endmodule
module PipelinedRV32I(
  input         clock,
  input         reset,
  output [31:0] io_result
);
  wire  core_clock; // @[PipelinedRISCV32I.scala 20:20]
  wire  core_reset; // @[PipelinedRISCV32I.scala 20:20]
  wire [31:0] core_io_check_res; // @[PipelinedRISCV32I.scala 20:20]
  PipelinedRV32Icore core ( // @[PipelinedRISCV32I.scala 20:20]
    .clock(core_clock),
    .reset(core_reset),
    .io_check_res(core_io_check_res)
  );
  assign io_result = core_io_check_res; // @[PipelinedRISCV32I.scala 22:19]
  assign core_clock = clock;
  assign core_reset = reset;
endmodule
