circuit PipelinedRV32I :
  module IFBarrier :
    input clock : Clock
    input reset : UInt<1>
    input io_pcIn : UInt<32>
    input io_instrIn : UInt<32>
    output io_pcOut : UInt<32>
    output io_instrOut : UInt<32>

    reg pcReg : UInt<32>, clock with :
      reset => (UInt<1>("h0"), pcReg) @[core.scala 341:18]
    reg instrReg : UInt<32>, clock with :
      reset => (UInt<1>("h0"), instrReg) @[core.scala 342:21]
    io_pcOut <= pcReg @[core.scala 347:12]
    io_instrOut <= instrReg @[core.scala 348:15]
    pcReg <= io_pcIn @[core.scala 344:9]
    instrReg <= io_instrIn @[core.scala 345:12]

  module IDBarrier :
    input clock : Clock
    input reset : UInt<1>
    input io_immediate : UInt<12>
    input io_uop : UInt<8>
    input io_rd : UInt<5>
    input io_rs1 : UInt<5>
    input io_rs2 : UInt<5>
    output io_immediateOut : UInt<12>
    output io_uopOut : UInt<8>
    output io_rdOut : UInt<5>
    output io_rs1out : UInt<5>
    output io_rs2out : UInt<5>

    reg immReg : UInt<12>, clock with :
      reset => (UInt<1>("h0"), immReg) @[core.scala 378:19]
    reg opReg : UInt<8>, clock with :
      reset => (UInt<1>("h0"), opReg) @[core.scala 379:18]
    reg rdReg : UInt<5>, clock with :
      reset => (UInt<1>("h0"), rdReg) @[core.scala 380:18]
    reg rs1Reg : UInt<5>, clock with :
      reset => (UInt<1>("h0"), rs1Reg) @[core.scala 381:19]
    reg rs2Reg : UInt<5>, clock with :
      reset => (UInt<1>("h0"), rs2Reg) @[core.scala 382:19]
    io_immediateOut <= immReg @[core.scala 394:19]
    io_uopOut <= opReg @[core.scala 395:13]
    io_rdOut <= rdReg @[core.scala 396:12]
    io_rs1out <= rs1Reg @[core.scala 397:13]
    io_rs2out <= rs2Reg @[core.scala 398:13]
    immReg <= io_immediate @[core.scala 386:10]
    opReg <= io_uop @[core.scala 387:9]
    rdReg <= io_rd @[core.scala 388:9]
    rs1Reg <= io_rs1 @[core.scala 389:10]
    rs2Reg <= io_rs2 @[core.scala 390:10]

  module EXBarrier :
    input clock : Clock
    input reset : UInt<1>
    input io_result : UInt<32>
    input io_rd : UInt<5>
    output io_resOut : UInt<32>
    output io_rdOut : UInt<5>

    reg resultReg : UInt<32>, clock with :
      reset => (UInt<1>("h0"), resultReg) @[core.scala 416:22]
    reg rdReg : UInt<5>, clock with :
      reset => (UInt<1>("h0"), rdReg) @[core.scala 417:18]
    io_resOut <= resultReg @[core.scala 422:13]
    io_rdOut <= rdReg @[core.scala 423:12]
    resultReg <= io_result @[core.scala 419:13]
    rdReg <= io_rd @[core.scala 420:9]

  module MEMBarrier :
    input clock : Clock
    input reset : UInt<1>
    input io_rdIn : UInt<5>
    input io_resultIn : UInt<32>
    output io_rdOut : UInt<5>
    output io_resultOut : UInt<32>

    reg rdreg : UInt<5>, clock with :
      reset => (UInt<1>("h0"), rdreg) @[core.scala 441:18]
    reg resReg : UInt<32>, clock with :
      reset => (UInt<1>("h0"), resReg) @[core.scala 442:19]
    io_rdOut <= rdreg @[core.scala 447:12]
    io_resultOut <= resReg @[core.scala 448:16]
    rdreg <= io_rdIn @[core.scala 444:9]
    resReg <= io_resultIn @[core.scala 445:10]

  module IF :
    input clock : Clock
    input reset : UInt<1>
    input io_pc : UInt<32>
    output io_instr : UInt<32>
    output io_pcNew : UInt<32>

    mem IMem : @[core.scala 170:17]
      data-type => UInt<32>
      depth => 4096
      read-latency => 0
      write-latency => 1
      reader => io_instr_MPORT
      read-under-write => undefined
    node _io_instr_T = dshr(io_pc, UInt<2>("h2")) @[core.scala 173:25]
    node _io_instr_T_1 = bits(_io_instr_T, 11, 0) @[core.scala 173:19]
    node _io_pcNew_T = add(io_pc, UInt<3>("h4")) @[core.scala 175:21]
    node _io_pcNew_T_1 = tail(_io_pcNew_T, 1) @[core.scala 175:21]
    io_instr <= IMem.io_instr_MPORT.data @[core.scala 173:12]
    io_pcNew <= _io_pcNew_T_1 @[core.scala 175:12]
    IMem.io_instr_MPORT.addr <= _io_instr_T_1 @[core.scala 173:19]
    IMem.io_instr_MPORT.en <= UInt<1>("h1") @[core.scala 173:19]
    IMem.io_instr_MPORT.clk <= clock @[core.scala 173:19]

  module ID :
    input clock : Clock
    input reset : UInt<1>
    input io_instr : UInt<32>
    output io_immediate : UInt<12>
    output io_uop : UInt<8>
    output io_rs1 : UInt<5>
    output io_rs2 : UInt<5>
    output io_rd : UInt<5>

    node opcode = bits(io_instr, 6, 0) @[core.scala 196:24]
    node rd = bits(io_instr, 11, 7) @[core.scala 197:24]
    node funct3 = bits(io_instr, 14, 12) @[core.scala 198:24]
    node rs1 = bits(io_instr, 19, 15) @[core.scala 199:24]
    node rs2 = bits(io_instr, 24, 20) @[core.scala 200:24]
    node funct7 = bits(io_instr, 31, 25) @[core.scala 201:24]
    node imm = bits(io_instr, 31, 20) @[core.scala 202:21]
    node _T = eq(opcode, UInt<6>("h33")) @[core.scala 205:15]
    node _T_1 = eq(funct3, UInt<1>("h0")) @[core.scala 205:42]
    node _T_2 = and(_T, _T_1) @[core.scala 205:32]
    node _T_3 = eq(funct7, UInt<1>("h0")) @[core.scala 205:65]
    node _T_4 = and(_T_2, _T_3) @[core.scala 205:55]
    node _T_5 = eq(opcode, UInt<6>("h33")) @[core.scala 207:21]
    node _T_6 = eq(funct3, UInt<1>("h0")) @[core.scala 207:48]
    node _T_7 = and(_T_5, _T_6) @[core.scala 207:38]
    node _T_8 = eq(funct7, UInt<6>("h20")) @[core.scala 207:71]
    node _T_9 = and(_T_7, _T_8) @[core.scala 207:61]
    node _T_10 = eq(opcode, UInt<6>("h33")) @[core.scala 209:21]
    node _T_11 = eq(funct3, UInt<1>("h1")) @[core.scala 209:48]
    node _T_12 = and(_T_10, _T_11) @[core.scala 209:38]
    node _T_13 = eq(funct7, UInt<1>("h0")) @[core.scala 209:71]
    node _T_14 = and(_T_12, _T_13) @[core.scala 209:61]
    node _T_15 = eq(opcode, UInt<6>("h33")) @[core.scala 211:21]
    node _T_16 = eq(funct3, UInt<3>("h5")) @[core.scala 211:48]
    node _T_17 = and(_T_15, _T_16) @[core.scala 211:38]
    node _T_18 = eq(funct7, UInt<1>("h0")) @[core.scala 211:71]
    node _T_19 = and(_T_17, _T_18) @[core.scala 211:61]
    node _T_20 = eq(opcode, UInt<6>("h33")) @[core.scala 213:21]
    node _T_21 = eq(funct3, UInt<3>("h5")) @[core.scala 213:48]
    node _T_22 = and(_T_20, _T_21) @[core.scala 213:38]
    node _T_23 = eq(funct7, UInt<6>("h20")) @[core.scala 213:71]
    node _T_24 = and(_T_22, _T_23) @[core.scala 213:61]
    node _T_25 = eq(opcode, UInt<6>("h33")) @[core.scala 215:21]
    node _T_26 = eq(funct3, UInt<3>("h4")) @[core.scala 215:48]
    node _T_27 = and(_T_25, _T_26) @[core.scala 215:38]
    node _T_28 = eq(funct7, UInt<1>("h0")) @[core.scala 215:71]
    node _T_29 = and(_T_27, _T_28) @[core.scala 215:61]
    node _T_30 = eq(opcode, UInt<6>("h33")) @[core.scala 217:21]
    node _T_31 = eq(funct3, UInt<3>("h6")) @[core.scala 217:48]
    node _T_32 = and(_T_30, _T_31) @[core.scala 217:38]
    node _T_33 = eq(funct7, UInt<1>("h0")) @[core.scala 217:71]
    node _T_34 = and(_T_32, _T_33) @[core.scala 217:61]
    node _T_35 = eq(opcode, UInt<6>("h33")) @[core.scala 219:21]
    node _T_36 = eq(funct3, UInt<3>("h7")) @[core.scala 219:48]
    node _T_37 = and(_T_35, _T_36) @[core.scala 219:38]
    node _T_38 = eq(funct7, UInt<1>("h0")) @[core.scala 219:71]
    node _T_39 = and(_T_37, _T_38) @[core.scala 219:61]
    node _T_40 = eq(opcode, UInt<6>("h33")) @[core.scala 221:21]
    node _T_41 = eq(funct3, UInt<2>("h2")) @[core.scala 221:48]
    node _T_42 = and(_T_40, _T_41) @[core.scala 221:38]
    node _T_43 = eq(funct7, UInt<1>("h0")) @[core.scala 221:71]
    node _T_44 = and(_T_42, _T_43) @[core.scala 221:61]
    node _T_45 = eq(opcode, UInt<6>("h33")) @[core.scala 223:21]
    node _T_46 = eq(funct3, UInt<2>("h3")) @[core.scala 223:48]
    node _T_47 = and(_T_45, _T_46) @[core.scala 223:38]
    node _T_48 = eq(funct7, UInt<1>("h0")) @[core.scala 223:71]
    node _T_49 = and(_T_47, _T_48) @[core.scala 223:61]
    node _T_50 = eq(opcode, UInt<5>("h13")) @[core.scala 225:21]
    node _T_51 = eq(funct3, UInt<1>("h0")) @[core.scala 225:48]
    node _T_52 = and(_T_50, _T_51) @[core.scala 225:38]
    node _GEN_0 = mux(_T_52, UInt<5>("h10"), UInt<8>("hff")) @[core.scala 225:62 226:12 228:12]
    node _GEN_1 = mux(_T_49, UInt<4>("ha"), _GEN_0) @[core.scala 223:89 224:12]
    node _GEN_2 = mux(_T_44, UInt<4>("h9"), _GEN_1) @[core.scala 221:89 222:12]
    node _GEN_3 = mux(_T_39, UInt<1>("h1"), _GEN_2) @[core.scala 219:89 220:12]
    node _GEN_4 = mux(_T_34, UInt<3>("h4"), _GEN_3) @[core.scala 217:89 218:12]
    node _GEN_5 = mux(_T_29, UInt<2>("h3"), _GEN_4) @[core.scala 215:89 216:12]
    node _GEN_6 = mux(_T_24, UInt<4>("h8"), _GEN_5) @[core.scala 213:89 214:12]
    node _GEN_7 = mux(_T_19, UInt<3>("h7"), _GEN_6) @[core.scala 211:89 212:12]
    node _GEN_8 = mux(_T_14, UInt<3>("h6"), _GEN_7) @[core.scala 209:89 210:12]
    node _GEN_9 = mux(_T_9, UInt<2>("h2"), _GEN_8) @[core.scala 207:89 208:12]
    node _GEN_10 = mux(_T_4, UInt<1>("h1"), _GEN_9) @[core.scala 205:83 206:12]
    io_immediate <= imm @[core.scala 245:16]
    io_uop <= _GEN_10
    io_rs1 <= rs1 @[core.scala 243:10]
    io_rs2 <= rs2 @[core.scala 244:10]
    io_rd <= rd @[core.scala 246:9]

  module EX :
    input clock : Clock
    input reset : UInt<1>
    input io_uop : UInt<8>
    input io_operandA : UInt<32>
    input io_operandB : UInt<32>
    input io_immediate : UInt<12>
    output io_result : UInt<32>

    node _T = eq(io_uop, UInt<1>("h1")) @[core.scala 263:16]
    node _io_result_T = add(io_operandA, io_operandB) @[core.scala 264:30]
    node _io_result_T_1 = tail(_io_result_T, 1) @[core.scala 264:30]
    node _T_1 = eq(io_uop, UInt<2>("h2")) @[core.scala 265:21]
    node _io_result_T_2 = sub(io_operandA, io_operandB) @[core.scala 266:30]
    node _io_result_T_3 = tail(_io_result_T_2, 1) @[core.scala 266:30]
    node _T_2 = eq(io_uop, UInt<3>("h5")) @[core.scala 267:21]
    node _io_result_T_4 = and(io_operandA, io_operandB) @[core.scala 268:30]
    node _T_3 = eq(io_uop, UInt<3>("h4")) @[core.scala 269:21]
    node _io_result_T_5 = or(io_operandA, io_operandB) @[core.scala 270:30]
    node _T_4 = eq(io_uop, UInt<2>("h3")) @[core.scala 271:21]
    node _io_result_T_6 = xor(io_operandA, io_operandB) @[core.scala 272:30]
    node _T_5 = eq(io_uop, UInt<3>("h6")) @[core.scala 273:21]
    node _io_result_T_7 = bits(io_operandB, 4, 0) @[core.scala 274:44]
    node _io_result_T_8 = dshl(io_operandA, _io_result_T_7) @[core.scala 274:30]
    node _T_6 = eq(io_uop, UInt<3>("h7")) @[core.scala 275:21]
    node _io_result_T_9 = bits(io_operandB, 4, 0) @[core.scala 276:44]
    node _io_result_T_10 = dshr(io_operandA, _io_result_T_9) @[core.scala 276:30]
    node _T_7 = eq(io_uop, UInt<4>("h8")) @[core.scala 277:21]
    node _io_result_T_11 = asSInt(io_operandA) @[core.scala 278:31]
    node _io_result_T_12 = bits(io_operandB, 4, 0) @[core.scala 278:52]
    node _io_result_T_13 = dshr(_io_result_T_11, _io_result_T_12) @[core.scala 278:38]
    node _io_result_T_14 = asUInt(_io_result_T_13) @[core.scala 278:60]
    node _T_8 = eq(io_uop, UInt<4>("ha")) @[core.scala 279:21]
    node _io_result_T_15 = lt(io_operandA, io_operandB) @[core.scala 280:35]
    node _io_result_T_16 = mux(_io_result_T_15, UInt<1>("h1"), UInt<1>("h0")) @[core.scala 280:22]
    node _T_9 = eq(io_uop, UInt<2>("h2")) @[core.scala 281:21]
    node _io_result_T_17 = asSInt(io_operandA) @[core.scala 282:35]
    node _io_result_T_18 = asSInt(io_operandB) @[core.scala 282:56]
    node _io_result_T_19 = lt(_io_result_T_17, _io_result_T_18) @[core.scala 282:42]
    node _io_result_T_20 = mux(_io_result_T_19, UInt<1>("h1"), UInt<1>("h0")) @[core.scala 282:22]
    node _T_10 = eq(io_uop, UInt<5>("h10")) @[core.scala 283:21]
    node _io_result_T_21 = add(io_operandA, io_immediate) @[core.scala 284:30]
    node _io_result_T_22 = tail(_io_result_T_21, 1) @[core.scala 284:30]
    node _GEN_0 = mux(_T_10, _io_result_T_22, UInt<32>("hffffffff")) @[core.scala 283:33 284:15 286:15]
    node _GEN_1 = mux(_T_9, _io_result_T_20, _GEN_0) @[core.scala 281:32 282:15]
    node _GEN_2 = mux(_T_8, _io_result_T_16, _GEN_1) @[core.scala 279:33 280:15]
    node _GEN_3 = mux(_T_7, _io_result_T_14, _GEN_2) @[core.scala 277:32 278:15]
    node _GEN_4 = mux(_T_6, _io_result_T_10, _GEN_3) @[core.scala 275:32 276:15]
    node _GEN_5 = mux(_T_5, _io_result_T_8, _GEN_4) @[core.scala 273:32 274:15]
    node _GEN_6 = mux(_T_4, _io_result_T_6, _GEN_5) @[core.scala 271:32 272:15]
    node _GEN_7 = mux(_T_3, _io_result_T_5, _GEN_6) @[core.scala 269:31 270:15]
    node _GEN_8 = mux(_T_2, _io_result_T_4, _GEN_7) @[core.scala 267:32 268:15]
    node _GEN_9 = mux(_T_1, _io_result_T_3, _GEN_8) @[core.scala 265:32 266:15]
    node _GEN_10 = mux(_T, _io_result_T_1, _GEN_9) @[core.scala 263:27 264:15]
    io_result <= bits(_GEN_10, 31, 0)

  module MEM :
    input clock : Clock
    input reset : UInt<1>
    input io_rd : UInt<5>
    input io_result : UInt<32>
    output io_rdO : UInt<5>
    output io_resultO : UInt<32>

    io_rdO <= io_rd @[core.scala 303:10]
    io_resultO <= io_result @[core.scala 304:14]

  module WB :
    input clock : Clock
    input reset : UInt<1>
    input io_rd : UInt<5>
    input io_result : UInt<32>
    output io_wbToRegFile_writeEn : UInt<1>
    output io_wbToRegFile_rd : UInt<5>
    output io_wbToRegFile_data : UInt<32>
    output io_check_res : UInt<32>

    io_wbToRegFile_writeEn <= UInt<1>("h1") @[core.scala 321:26]
    io_wbToRegFile_rd <= io_rd @[core.scala 322:21]
    io_wbToRegFile_data <= io_result @[core.scala 323:23]
    io_check_res <= io_result @[core.scala 324:16]

  module regFile :
    input clock : Clock
    input reset : UInt<1>
    input io_req1_rs : UInt<5>
    input io_req2_rs : UInt<5>
    output io_resp1_data : UInt<32>
    output io_resp2_data : UInt<32>
    input io_write_writeEn : UInt<1>
    input io_write_rd : UInt<5>
    input io_write_data : UInt<32>

    mem regFile : @[core.scala 146:20]
      data-type => UInt<32>
      depth => 32
      read-latency => 0
      write-latency => 1
      reader => io_resp1_data_MPORT
      reader => io_resp2_data_MPORT
      writer => MPORT
      writer => MPORT_1
      read-under-write => undefined
    node _GEN_0 = validif(io_write_writeEn, io_write_rd) @[core.scala 153:26 154:12]
    node _GEN_1 = validif(io_write_writeEn, clock) @[core.scala 153:26 154:12]
    node _GEN_2 = mux(io_write_writeEn, UInt<1>("h1"), UInt<1>("h0")) @[core.scala 153:26 154:12 146:20]
    node _GEN_3 = validif(io_write_writeEn, UInt<1>("h1")) @[core.scala 153:26 154:26]
    node _GEN_4 = validif(io_write_writeEn, io_write_data) @[core.scala 153:26 154:26]
    io_resp1_data <= regFile.io_resp1_data_MPORT.data @[core.scala 150:17]
    io_resp2_data <= regFile.io_resp2_data_MPORT.data @[core.scala 151:17]
    regFile.io_resp1_data_MPORT.addr <= io_req1_rs @[core.scala 150:27]
    regFile.io_resp1_data_MPORT.en <= UInt<1>("h1") @[core.scala 150:27]
    regFile.io_resp1_data_MPORT.clk <= clock @[core.scala 150:27]
    regFile.io_resp2_data_MPORT.addr <= io_req2_rs @[core.scala 151:27]
    regFile.io_resp2_data_MPORT.en <= UInt<1>("h1") @[core.scala 151:27]
    regFile.io_resp2_data_MPORT.clk <= clock @[core.scala 151:27]
    regFile.MPORT.addr <= UInt<5>("h0") @[core.scala 147:10]
    regFile.MPORT.en <= UInt<1>("h1") @[core.scala 147:10]
    regFile.MPORT.clk <= clock @[core.scala 147:10]
    regFile.MPORT.data <= UInt<32>("h0") @[core.scala 147:14]
    regFile.MPORT.mask <= UInt<1>("h1") @[core.scala 147:14]
    regFile.MPORT_1.addr <= _GEN_0
    regFile.MPORT_1.en <= _GEN_2
    regFile.MPORT_1.clk <= _GEN_1
    regFile.MPORT_1.data <= _GEN_4
    regFile.MPORT_1.mask <= _GEN_3

  module PipelinedRV32Icore :
    input clock : Clock
    input reset : UInt<1>
    output io_check_res : UInt<32>

    inst ifBarrier of IFBarrier @[core.scala 486:25]
    inst idBarrier of IDBarrier @[core.scala 487:25]
    inst exBarrier of EXBarrier @[core.scala 488:25]
    inst memBarrier of MEMBarrier @[core.scala 489:26]
    inst IF of IF @[core.scala 493:18]
    inst ID of ID @[core.scala 494:18]
    inst EX of EX @[core.scala 495:18]
    inst MEM of MEM @[core.scala 496:19]
    inst WB of WB @[core.scala 497:18]
    inst regFile of regFile @[core.scala 500:23]
    reg pc : UInt<32>, clock with :
      reset => (UInt<1>("h0"), pc) @[core.scala 504:19]
    io_check_res <= WB.io_check_res @[core.scala 552:16]
    ifBarrier.clock <= clock
    ifBarrier.reset <= reset
    ifBarrier.io_pcIn <= IF.io_pcNew @[core.scala 509:21]
    ifBarrier.io_instrIn <= IF.io_instr @[core.scala 510:24]
    idBarrier.clock <= clock
    idBarrier.reset <= reset
    idBarrier.io_immediate <= ID.io_immediate @[core.scala 521:26]
    idBarrier.io_uop <= ID.io_uop @[core.scala 523:20]
    idBarrier.io_rd <= ID.io_rd @[core.scala 522:19]
    idBarrier.io_rs1 <= ID.io_rs1 @[core.scala 517:20]
    idBarrier.io_rs2 <= ID.io_rs2 @[core.scala 518:20]
    exBarrier.clock <= clock
    exBarrier.reset <= reset
    exBarrier.io_result <= EX.io_result @[core.scala 533:23]
    exBarrier.io_rd <= idBarrier.io_rdOut @[core.scala 532:19]
    memBarrier.clock <= clock
    memBarrier.reset <= reset
    memBarrier.io_rdIn <= MEM.io_rdO @[core.scala 539:22]
    memBarrier.io_resultIn <= MEM.io_resultO @[core.scala 538:26]
    IF.clock <= clock
    IF.reset <= reset
    IF.io_pc <= pc @[core.scala 507:12]
    ID.clock <= clock
    ID.reset <= reset
    ID.io_instr <= ifBarrier.io_instrOut @[core.scala 513:15]
    EX.clock <= clock
    EX.reset <= reset
    EX.io_uop <= idBarrier.io_uopOut @[core.scala 528:13]
    EX.io_operandA <= regFile.io_resp1_data @[core.scala 529:18]
    EX.io_operandB <= regFile.io_resp2_data @[core.scala 530:18]
    EX.io_immediate <= idBarrier.io_immediateOut @[core.scala 531:19]
    MEM.clock <= clock
    MEM.reset <= reset
    MEM.io_rd <= exBarrier.io_rdOut @[core.scala 536:13]
    MEM.io_result <= exBarrier.io_resOut @[core.scala 537:17]
    WB.clock <= clock
    WB.reset <= reset
    WB.io_rd <= memBarrier.io_rdOut @[core.scala 546:12]
    WB.io_result <= memBarrier.io_resultOut @[core.scala 545:16]
    regFile.clock <= clock
    regFile.reset <= reset
    regFile.io_req1_rs <= idBarrier.io_rs1out @[core.scala 526:22]
    regFile.io_req2_rs <= idBarrier.io_rs2out @[core.scala 527:22]
    regFile.io_write_writeEn <= WB.io_wbToRegFile_writeEn @[core.scala 550:20]
    regFile.io_write_rd <= WB.io_wbToRegFile_rd @[core.scala 550:20]
    regFile.io_write_data <= WB.io_wbToRegFile_data @[core.scala 550:20]
    pc <= mux(reset, UInt<32>("h0"), IF.io_pcNew) @[core.scala 504:{19,19} 508:6]

  module PipelinedRV32I :
    input clock : Clock
    input reset : UInt<1>
    output io_result : UInt<32>

    inst core of PipelinedRV32Icore @[PipelinedRISCV32I.scala 20:20]
    io_result <= core.io_check_res @[PipelinedRISCV32I.scala 22:19]
    core.clock <= clock
    core.reset <= reset
