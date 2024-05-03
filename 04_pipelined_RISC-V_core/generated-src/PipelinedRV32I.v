module IFBarrier(
  input         clock,
  input  [31:0] io_instrIn,
  output [31:0] io_instrOut
);
`ifdef RANDOMIZE_REG_INIT
  reg [31:0] _RAND_0;
`endif // RANDOMIZE_REG_INIT
  reg [31:0] instrReg; // @[core.scala 338:21]
  assign io_instrOut = instrReg; // @[core.scala 344:15]
  always @(posedge clock) begin
    instrReg <= io_instrIn; // @[core.scala 341:12]
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
  input  [31:0] io_operandA,
  input  [31:0] io_operandB,
  input  [11:0] io_immediate,
  input  [7:0]  io_uop,
  input  [4:0]  io_rd,
  output [31:0] io_operandAOut,
  output [31:0] io_operandBOut,
  output [11:0] io_immediateOut,
  output [7:0]  io_uopOut,
  output [4:0]  io_rdOut
);
`ifdef RANDOMIZE_REG_INIT
  reg [31:0] _RAND_0;
  reg [31:0] _RAND_1;
  reg [31:0] _RAND_2;
  reg [31:0] _RAND_3;
  reg [31:0] _RAND_4;
`endif // RANDOMIZE_REG_INIT
  reg [31:0] aReg; // @[core.scala 368:17]
  reg [31:0] bReg; // @[core.scala 369:17]
  reg [11:0] immReg; // @[core.scala 370:19]
  reg [7:0] opReg; // @[core.scala 371:18]
  reg [4:0] rdReg; // @[core.scala 372:18]
  assign io_operandAOut = aReg; // @[core.scala 380:18]
  assign io_operandBOut = bReg; // @[core.scala 381:18]
  assign io_immediateOut = immReg; // @[core.scala 382:19]
  assign io_uopOut = opReg; // @[core.scala 383:13]
  assign io_rdOut = rdReg; // @[core.scala 384:12]
  always @(posedge clock) begin
    aReg <= io_operandA; // @[core.scala 374:8]
    bReg <= io_operandB; // @[core.scala 375:8]
    immReg <= io_immediate; // @[core.scala 376:10]
    opReg <= io_uop; // @[core.scala 377:9]
    rdReg <= io_rd; // @[core.scala 378:9]
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
  aReg = _RAND_0[31:0];
  _RAND_1 = {1{`RANDOM}};
  bReg = _RAND_1[31:0];
  _RAND_2 = {1{`RANDOM}};
  immReg = _RAND_2[11:0];
  _RAND_3 = {1{`RANDOM}};
  opReg = _RAND_3[7:0];
  _RAND_4 = {1{`RANDOM}};
  rdReg = _RAND_4[4:0];
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
  reg [31:0] resultReg; // @[core.scala 402:22]
  reg [4:0] rdReg; // @[core.scala 403:18]
  assign io_resOut = resultReg; // @[core.scala 408:13]
  assign io_rdOut = rdReg; // @[core.scala 409:12]
  always @(posedge clock) begin
    resultReg <= io_result; // @[core.scala 405:13]
    rdReg <= io_rd; // @[core.scala 406:9]
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
module IF(
  input         clock,
  input  [31:0] io_pc,
  output [31:0] io_instr,
  output [31:0] io_pcNew
);
`ifdef RANDOMIZE_MEM_INIT
  reg [31:0] _RAND_0;
`endif // RANDOMIZE_MEM_INIT
  reg [31:0] IMem [0:4095]; // @[core.scala 170:17]
  wire  IMem_io_instr_MPORT_en; // @[core.scala 170:17]
  wire [11:0] IMem_io_instr_MPORT_addr; // @[core.scala 170:17]
  wire [31:0] IMem_io_instr_MPORT_data; // @[core.scala 170:17]
  wire [31:0] _io_instr_T = {{2'd0}, io_pc[31:2]}; // @[core.scala 173:25]
  assign IMem_io_instr_MPORT_en = 1'h1;
  assign IMem_io_instr_MPORT_addr = _io_instr_T[11:0];
  assign IMem_io_instr_MPORT_data = IMem[IMem_io_instr_MPORT_addr]; // @[core.scala 170:17]
  assign io_instr = IMem_io_instr_MPORT_data; // @[core.scala 173:12]
  assign io_pcNew = io_pc + 32'h4; // @[core.scala 175:21]
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
  wire [31:0] _io_result_T_1 = io_operandA + io_operandB; // @[core.scala 264:30]
  wire  _T_1 = io_uop == 8'h2; // @[core.scala 265:21]
  wire [31:0] _io_result_T_3 = io_operandA - io_operandB; // @[core.scala 266:30]
  wire [31:0] _io_result_T_4 = io_operandA & io_operandB; // @[core.scala 268:30]
  wire [31:0] _io_result_T_5 = io_operandA | io_operandB; // @[core.scala 270:30]
  wire [31:0] _io_result_T_6 = io_operandA ^ io_operandB; // @[core.scala 272:30]
  wire [62:0] _GEN_12 = {{31'd0}, io_operandA}; // @[core.scala 274:30]
  wire [62:0] _io_result_T_8 = _GEN_12 << io_operandB[4:0]; // @[core.scala 274:30]
  wire [31:0] _io_result_T_10 = io_operandA >> io_operandB[4:0]; // @[core.scala 276:30]
  wire [31:0] _io_result_T_11 = io_operandA; // @[core.scala 278:31]
  wire [31:0] _io_result_T_14 = $signed(io_operandA) >>> io_operandB[4:0]; // @[core.scala 278:60]
  wire [31:0] _io_result_T_18 = io_operandB; // @[core.scala 282:56]
  wire [31:0] _GEN_11 = {{20'd0}, io_immediate}; // @[core.scala 284:30]
  wire [31:0] _io_result_T_22 = io_operandA + _GEN_11; // @[core.scala 284:30]
  wire [31:0] _GEN_0 = io_uop == 8'h10 ? _io_result_T_22 : 32'hffffffff; // @[core.scala 283:33 284:15 286:15]
  wire [31:0] _GEN_1 = _T_1 ? {{31'd0}, $signed(_io_result_T_11) < $signed(_io_result_T_18)} : _GEN_0; // @[core.scala 281:32 282:15]
  wire [31:0] _GEN_2 = io_uop == 8'ha ? {{31'd0}, io_operandA < io_operandB} : _GEN_1; // @[core.scala 279:33 280:15]
  wire [31:0] _GEN_3 = io_uop == 8'h8 ? _io_result_T_14 : _GEN_2; // @[core.scala 277:32 278:15]
  wire [31:0] _GEN_4 = io_uop == 8'h7 ? _io_result_T_10 : _GEN_3; // @[core.scala 275:32 276:15]
  wire [62:0] _GEN_5 = io_uop == 8'h6 ? _io_result_T_8 : {{31'd0}, _GEN_4}; // @[core.scala 273:32 274:15]
  wire [62:0] _GEN_6 = io_uop == 8'h3 ? {{31'd0}, _io_result_T_6} : _GEN_5; // @[core.scala 271:32 272:15]
  wire [62:0] _GEN_7 = io_uop == 8'h4 ? {{31'd0}, _io_result_T_5} : _GEN_6; // @[core.scala 269:31 270:15]
  wire [62:0] _GEN_8 = io_uop == 8'h5 ? {{31'd0}, _io_result_T_4} : _GEN_7; // @[core.scala 267:32 268:15]
  wire [62:0] _GEN_9 = io_uop == 8'h2 ? {{31'd0}, _io_result_T_3} : _GEN_8; // @[core.scala 265:32 266:15]
  wire [62:0] _GEN_10 = io_uop == 8'h1 ? {{31'd0}, _io_result_T_1} : _GEN_9; // @[core.scala 263:27 264:15]
  assign io_result = _GEN_10[31:0];
endmodule
module WB(
  input  [4:0]  io_rd,
  input  [31:0] io_result,
  output [4:0]  io_wbToRegFile_rd,
  output [31:0] io_wbToRegFile_data,
  output [31:0] io_check_res
);
  assign io_wbToRegFile_rd = io_rd; // @[core.scala 318:21]
  assign io_wbToRegFile_data = io_result; // @[core.scala 319:23]
  assign io_check_res = io_result; // @[core.scala 320:16]
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
  reg [31:0] regFile [0:31]; // @[core.scala 146:20]
  wire  regFile_io_resp1_data_MPORT_en; // @[core.scala 146:20]
  wire [4:0] regFile_io_resp1_data_MPORT_addr; // @[core.scala 146:20]
  wire [31:0] regFile_io_resp1_data_MPORT_data; // @[core.scala 146:20]
  wire  regFile_io_resp2_data_MPORT_en; // @[core.scala 146:20]
  wire [4:0] regFile_io_resp2_data_MPORT_addr; // @[core.scala 146:20]
  wire [31:0] regFile_io_resp2_data_MPORT_data; // @[core.scala 146:20]
  wire [31:0] regFile_MPORT_data; // @[core.scala 146:20]
  wire [4:0] regFile_MPORT_addr; // @[core.scala 146:20]
  wire  regFile_MPORT_mask; // @[core.scala 146:20]
  wire  regFile_MPORT_en; // @[core.scala 146:20]
  wire [31:0] regFile_MPORT_1_data; // @[core.scala 146:20]
  wire [4:0] regFile_MPORT_1_addr; // @[core.scala 146:20]
  wire  regFile_MPORT_1_mask; // @[core.scala 146:20]
  wire  regFile_MPORT_1_en; // @[core.scala 146:20]
  assign regFile_io_resp1_data_MPORT_en = 1'h1;
  assign regFile_io_resp1_data_MPORT_addr = io_req1_rs;
  assign regFile_io_resp1_data_MPORT_data = regFile[regFile_io_resp1_data_MPORT_addr]; // @[core.scala 146:20]
  assign regFile_io_resp2_data_MPORT_en = 1'h1;
  assign regFile_io_resp2_data_MPORT_addr = io_req2_rs;
  assign regFile_io_resp2_data_MPORT_data = regFile[regFile_io_resp2_data_MPORT_addr]; // @[core.scala 146:20]
  assign regFile_MPORT_data = 32'h0;
  assign regFile_MPORT_addr = 5'h0;
  assign regFile_MPORT_mask = 1'h1;
  assign regFile_MPORT_en = 1'h1;
  assign regFile_MPORT_1_data = io_write_data;
  assign regFile_MPORT_1_addr = io_write_rd;
  assign regFile_MPORT_1_mask = 1'h1;
  assign regFile_MPORT_1_en = 1'h1;
  assign io_resp1_data = regFile_io_resp1_data_MPORT_data; // @[core.scala 150:17]
  assign io_resp2_data = regFile_io_resp2_data_MPORT_data; // @[core.scala 151:17]
  always @(posedge clock) begin
    if (regFile_MPORT_en & regFile_MPORT_mask) begin
      regFile[regFile_MPORT_addr] <= regFile_MPORT_data; // @[core.scala 146:20]
    end
    if (regFile_MPORT_1_en & regFile_MPORT_1_mask) begin
      regFile[regFile_MPORT_1_addr] <= regFile_MPORT_1_data; // @[core.scala 146:20]
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
  wire  ifBarrier_clock; // @[core.scala 456:25]
  wire [31:0] ifBarrier_io_instrIn; // @[core.scala 456:25]
  wire [31:0] ifBarrier_io_instrOut; // @[core.scala 456:25]
  wire  idBarrier_clock; // @[core.scala 457:25]
  wire [31:0] idBarrier_io_operandA; // @[core.scala 457:25]
  wire [31:0] idBarrier_io_operandB; // @[core.scala 457:25]
  wire [11:0] idBarrier_io_immediate; // @[core.scala 457:25]
  wire [7:0] idBarrier_io_uop; // @[core.scala 457:25]
  wire [4:0] idBarrier_io_rd; // @[core.scala 457:25]
  wire [31:0] idBarrier_io_operandAOut; // @[core.scala 457:25]
  wire [31:0] idBarrier_io_operandBOut; // @[core.scala 457:25]
  wire [11:0] idBarrier_io_immediateOut; // @[core.scala 457:25]
  wire [7:0] idBarrier_io_uopOut; // @[core.scala 457:25]
  wire [4:0] idBarrier_io_rdOut; // @[core.scala 457:25]
  wire  exBarrier_clock; // @[core.scala 458:25]
  wire [31:0] exBarrier_io_result; // @[core.scala 458:25]
  wire [4:0] exBarrier_io_rd; // @[core.scala 458:25]
  wire [31:0] exBarrier_io_resOut; // @[core.scala 458:25]
  wire [4:0] exBarrier_io_rdOut; // @[core.scala 458:25]
  wire  IF_clock; // @[core.scala 461:18]
  wire [31:0] IF_io_pc; // @[core.scala 461:18]
  wire [31:0] IF_io_instr; // @[core.scala 461:18]
  wire [31:0] IF_io_pcNew; // @[core.scala 461:18]
  wire [31:0] ID_io_instr; // @[core.scala 462:18]
  wire [11:0] ID_io_immediate; // @[core.scala 462:18]
  wire [7:0] ID_io_uop; // @[core.scala 462:18]
  wire [4:0] ID_io_rs1; // @[core.scala 462:18]
  wire [4:0] ID_io_rs2; // @[core.scala 462:18]
  wire [4:0] ID_io_rd; // @[core.scala 462:18]
  wire [7:0] EX_io_uop; // @[core.scala 463:18]
  wire [31:0] EX_io_operandA; // @[core.scala 463:18]
  wire [31:0] EX_io_operandB; // @[core.scala 463:18]
  wire [11:0] EX_io_immediate; // @[core.scala 463:18]
  wire [31:0] EX_io_result; // @[core.scala 463:18]
  wire [4:0] WB_io_rd; // @[core.scala 465:18]
  wire [31:0] WB_io_result; // @[core.scala 465:18]
  wire [4:0] WB_io_wbToRegFile_rd; // @[core.scala 465:18]
  wire [31:0] WB_io_wbToRegFile_data; // @[core.scala 465:18]
  wire [31:0] WB_io_check_res; // @[core.scala 465:18]
  wire  regFile_clock; // @[core.scala 468:23]
  wire [4:0] regFile_io_req1_rs; // @[core.scala 468:23]
  wire [4:0] regFile_io_req2_rs; // @[core.scala 468:23]
  wire [31:0] regFile_io_resp1_data; // @[core.scala 468:23]
  wire [31:0] regFile_io_resp2_data; // @[core.scala 468:23]
  wire [4:0] regFile_io_write_rd; // @[core.scala 468:23]
  wire [31:0] regFile_io_write_data; // @[core.scala 468:23]
  reg [31:0] pc; // @[core.scala 472:19]
  IFBarrier ifBarrier ( // @[core.scala 456:25]
    .clock(ifBarrier_clock),
    .io_instrIn(ifBarrier_io_instrIn),
    .io_instrOut(ifBarrier_io_instrOut)
  );
  IDBarrier idBarrier ( // @[core.scala 457:25]
    .clock(idBarrier_clock),
    .io_operandA(idBarrier_io_operandA),
    .io_operandB(idBarrier_io_operandB),
    .io_immediate(idBarrier_io_immediate),
    .io_uop(idBarrier_io_uop),
    .io_rd(idBarrier_io_rd),
    .io_operandAOut(idBarrier_io_operandAOut),
    .io_operandBOut(idBarrier_io_operandBOut),
    .io_immediateOut(idBarrier_io_immediateOut),
    .io_uopOut(idBarrier_io_uopOut),
    .io_rdOut(idBarrier_io_rdOut)
  );
  EXBarrier exBarrier ( // @[core.scala 458:25]
    .clock(exBarrier_clock),
    .io_result(exBarrier_io_result),
    .io_rd(exBarrier_io_rd),
    .io_resOut(exBarrier_io_resOut),
    .io_rdOut(exBarrier_io_rdOut)
  );
  IF IF ( // @[core.scala 461:18]
    .clock(IF_clock),
    .io_pc(IF_io_pc),
    .io_instr(IF_io_instr),
    .io_pcNew(IF_io_pcNew)
  );
  ID ID ( // @[core.scala 462:18]
    .io_instr(ID_io_instr),
    .io_immediate(ID_io_immediate),
    .io_uop(ID_io_uop),
    .io_rs1(ID_io_rs1),
    .io_rs2(ID_io_rs2),
    .io_rd(ID_io_rd)
  );
  EX EX ( // @[core.scala 463:18]
    .io_uop(EX_io_uop),
    .io_operandA(EX_io_operandA),
    .io_operandB(EX_io_operandB),
    .io_immediate(EX_io_immediate),
    .io_result(EX_io_result)
  );
  WB WB ( // @[core.scala 465:18]
    .io_rd(WB_io_rd),
    .io_result(WB_io_result),
    .io_wbToRegFile_rd(WB_io_wbToRegFile_rd),
    .io_wbToRegFile_data(WB_io_wbToRegFile_data),
    .io_check_res(WB_io_check_res)
  );
  regFile regFile ( // @[core.scala 468:23]
    .clock(regFile_clock),
    .io_req1_rs(regFile_io_req1_rs),
    .io_req2_rs(regFile_io_req2_rs),
    .io_resp1_data(regFile_io_resp1_data),
    .io_resp2_data(regFile_io_resp2_data),
    .io_write_rd(regFile_io_write_rd),
    .io_write_data(regFile_io_write_data)
  );
  assign io_check_res = WB_io_check_res; // @[core.scala 504:16]
  assign ifBarrier_clock = clock;
  assign ifBarrier_io_instrIn = IF_io_instr; // @[core.scala 478:24]
  assign idBarrier_clock = clock;
  assign idBarrier_io_operandA = regFile_io_resp1_data; // @[core.scala 486:25]
  assign idBarrier_io_operandB = regFile_io_resp2_data; // @[core.scala 487:25]
  assign idBarrier_io_immediate = ID_io_immediate; // @[core.scala 488:26]
  assign idBarrier_io_uop = ID_io_uop; // @[core.scala 490:20]
  assign idBarrier_io_rd = ID_io_rd; // @[core.scala 489:19]
  assign exBarrier_clock = clock;
  assign exBarrier_io_result = EX_io_result; // @[core.scala 498:23]
  assign exBarrier_io_rd = idBarrier_io_rdOut; // @[core.scala 497:19]
  assign IF_clock = clock;
  assign IF_io_pc = pc; // @[core.scala 475:12]
  assign ID_io_instr = ifBarrier_io_instrOut; // @[core.scala 481:15]
  assign EX_io_uop = idBarrier_io_uopOut; // @[core.scala 493:13]
  assign EX_io_operandA = idBarrier_io_operandAOut; // @[core.scala 494:18]
  assign EX_io_operandB = idBarrier_io_operandBOut; // @[core.scala 495:18]
  assign EX_io_immediate = idBarrier_io_immediateOut; // @[core.scala 496:19]
  assign WB_io_rd = exBarrier_io_rdOut; // @[core.scala 503:12]
  assign WB_io_result = exBarrier_io_resOut; // @[core.scala 502:16]
  assign regFile_clock = clock;
  assign regFile_io_req1_rs = ID_io_rs1; // @[core.scala 484:22]
  assign regFile_io_req2_rs = ID_io_rs2; // @[core.scala 485:22]
  assign regFile_io_write_rd = WB_io_wbToRegFile_rd; // @[core.scala 505:20]
  assign regFile_io_write_data = WB_io_wbToRegFile_data; // @[core.scala 505:20]
  always @(posedge clock) begin
    if (reset) begin // @[core.scala 472:19]
      pc <= 32'h0; // @[core.scala 472:19]
    end else begin
      pc <= IF_io_pcNew; // @[core.scala 476:6]
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
