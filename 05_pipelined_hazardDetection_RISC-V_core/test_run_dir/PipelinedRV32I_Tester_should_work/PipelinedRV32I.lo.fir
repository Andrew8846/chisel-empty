circuit PipelinedRV32I :
  module IFBarrier :
    input clock : Clock
    input reset : UInt<1>
    input io_pcIn : UInt<32>
    input io_instrIn : UInt<32>
    output io_pcOut : UInt<32>
    output io_instrOut : UInt<32>

    reg pcReg : UInt<32>, clock with :
      reset => (UInt<1>("h0"), pcReg) @[core.scala 351:18]
    reg instrReg : UInt<32>, clock with :
      reset => (UInt<1>("h0"), instrReg) @[core.scala 352:21]
    io_pcOut <= pcReg @[core.scala 357:12]
    io_instrOut <= instrReg @[core.scala 358:15]
    pcReg <= io_pcIn @[core.scala 354:9]
    instrReg <= io_instrIn @[core.scala 355:12]

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
      reset => (UInt<1>("h0"), immReg) @[core.scala 382:19]
    reg opReg : UInt<8>, clock with :
      reset => (UInt<1>("h0"), opReg) @[core.scala 383:18]
    reg rdReg : UInt<5>, clock with :
      reset => (UInt<1>("h0"), rdReg) @[core.scala 384:18]
    reg rs1Reg : UInt<5>, clock with :
      reset => (UInt<1>("h0"), rs1Reg) @[core.scala 385:19]
    reg rs2Reg : UInt<5>, clock with :
      reset => (UInt<1>("h0"), rs2Reg) @[core.scala 386:19]
    io_immediateOut <= immReg @[core.scala 394:19]
    io_uopOut <= opReg @[core.scala 395:13]
    io_rdOut <= rdReg @[core.scala 396:12]
    io_rs1out <= rs1Reg @[core.scala 397:13]
    io_rs2out <= rs2Reg @[core.scala 398:13]
    immReg <= io_immediate @[core.scala 388:10]
    opReg <= io_uop @[core.scala 389:9]
    rdReg <= io_rd @[core.scala 390:9]
    rs1Reg <= io_rs1 @[core.scala 391:10]
    rs2Reg <= io_rs2 @[core.scala 392:10]

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

    mem IMem : @[core.scala 193:17]
      data-type => UInt<32>
      depth => 4096
      read-latency => 0
      write-latency => 1
      reader => io_instr_MPORT
      read-under-write => undefined
    node _io_instr_T = dshr(io_pc, UInt<2>("h2")) @[core.scala 196:25]
    node _io_instr_T_1 = bits(_io_instr_T, 11, 0) @[core.scala 196:19]
    node _io_pcNew_T = add(io_pc, UInt<3>("h4")) @[core.scala 198:21]
    node _io_pcNew_T_1 = tail(_io_pcNew_T, 1) @[core.scala 198:21]
    io_instr <= IMem.io_instr_MPORT.data @[core.scala 196:12]
    io_pcNew <= _io_pcNew_T_1 @[core.scala 198:12]
    IMem.io_instr_MPORT.addr <= _io_instr_T_1 @[core.scala 196:19]
    IMem.io_instr_MPORT.en <= UInt<1>("h1") @[core.scala 196:19]
    IMem.io_instr_MPORT.clk <= clock @[core.scala 196:19]

  module ID :
    input clock : Clock
    input reset : UInt<1>
    input io_instr : UInt<32>
    output io_immediate : UInt<12>
    output io_uop : UInt<8>
    output io_rs1 : UInt<5>
    output io_rs2 : UInt<5>
    output io_rd : UInt<5>

    node opcode = bits(io_instr, 6, 0) @[core.scala 216:24]
    node rd = bits(io_instr, 11, 7) @[core.scala 217:24]
    node funct3 = bits(io_instr, 14, 12) @[core.scala 218:24]
    node rs1 = bits(io_instr, 19, 15) @[core.scala 219:24]
    node rs2 = bits(io_instr, 24, 20) @[core.scala 220:24]
    node funct7 = bits(io_instr, 31, 25) @[core.scala 221:24]
    node imm = bits(io_instr, 31, 20) @[core.scala 222:21]
    node _T = eq(opcode, UInt<6>("h33")) @[core.scala 225:15]
    node _T_1 = eq(funct3, UInt<1>("h0")) @[core.scala 225:42]
    node _T_2 = and(_T, _T_1) @[core.scala 225:32]
    node _T_3 = eq(funct7, UInt<1>("h0")) @[core.scala 225:65]
    node _T_4 = and(_T_2, _T_3) @[core.scala 225:55]
    node _T_5 = eq(opcode, UInt<6>("h33")) @[core.scala 227:21]
    node _T_6 = eq(funct3, UInt<1>("h0")) @[core.scala 227:48]
    node _T_7 = and(_T_5, _T_6) @[core.scala 227:38]
    node _T_8 = eq(funct7, UInt<6>("h20")) @[core.scala 227:71]
    node _T_9 = and(_T_7, _T_8) @[core.scala 227:61]
    node _T_10 = eq(opcode, UInt<6>("h33")) @[core.scala 229:21]
    node _T_11 = eq(funct3, UInt<1>("h1")) @[core.scala 229:48]
    node _T_12 = and(_T_10, _T_11) @[core.scala 229:38]
    node _T_13 = eq(funct7, UInt<1>("h0")) @[core.scala 229:71]
    node _T_14 = and(_T_12, _T_13) @[core.scala 229:61]
    node _T_15 = eq(opcode, UInt<6>("h33")) @[core.scala 231:21]
    node _T_16 = eq(funct3, UInt<3>("h5")) @[core.scala 231:48]
    node _T_17 = and(_T_15, _T_16) @[core.scala 231:38]
    node _T_18 = eq(funct7, UInt<1>("h0")) @[core.scala 231:71]
    node _T_19 = and(_T_17, _T_18) @[core.scala 231:61]
    node _T_20 = eq(opcode, UInt<6>("h33")) @[core.scala 233:21]
    node _T_21 = eq(funct3, UInt<3>("h5")) @[core.scala 233:48]
    node _T_22 = and(_T_20, _T_21) @[core.scala 233:38]
    node _T_23 = eq(funct7, UInt<6>("h20")) @[core.scala 233:71]
    node _T_24 = and(_T_22, _T_23) @[core.scala 233:61]
    node _T_25 = eq(opcode, UInt<6>("h33")) @[core.scala 235:21]
    node _T_26 = eq(funct3, UInt<3>("h4")) @[core.scala 235:48]
    node _T_27 = and(_T_25, _T_26) @[core.scala 235:38]
    node _T_28 = eq(funct7, UInt<1>("h0")) @[core.scala 235:71]
    node _T_29 = and(_T_27, _T_28) @[core.scala 235:61]
    node _T_30 = eq(opcode, UInt<6>("h33")) @[core.scala 237:21]
    node _T_31 = eq(funct3, UInt<3>("h6")) @[core.scala 237:48]
    node _T_32 = and(_T_30, _T_31) @[core.scala 237:38]
    node _T_33 = eq(funct7, UInt<1>("h0")) @[core.scala 237:71]
    node _T_34 = and(_T_32, _T_33) @[core.scala 237:61]
    node _T_35 = eq(opcode, UInt<6>("h33")) @[core.scala 239:21]
    node _T_36 = eq(funct3, UInt<3>("h7")) @[core.scala 239:48]
    node _T_37 = and(_T_35, _T_36) @[core.scala 239:38]
    node _T_38 = eq(funct7, UInt<1>("h0")) @[core.scala 239:71]
    node _T_39 = and(_T_37, _T_38) @[core.scala 239:61]
    node _T_40 = eq(opcode, UInt<6>("h33")) @[core.scala 241:21]
    node _T_41 = eq(funct3, UInt<2>("h2")) @[core.scala 241:48]
    node _T_42 = and(_T_40, _T_41) @[core.scala 241:38]
    node _T_43 = eq(funct7, UInt<1>("h0")) @[core.scala 241:71]
    node _T_44 = and(_T_42, _T_43) @[core.scala 241:61]
    node _T_45 = eq(opcode, UInt<6>("h33")) @[core.scala 243:21]
    node _T_46 = eq(funct3, UInt<2>("h3")) @[core.scala 243:48]
    node _T_47 = and(_T_45, _T_46) @[core.scala 243:38]
    node _T_48 = eq(funct7, UInt<1>("h0")) @[core.scala 243:71]
    node _T_49 = and(_T_47, _T_48) @[core.scala 243:61]
    node _T_50 = eq(opcode, UInt<5>("h13")) @[core.scala 245:21]
    node _T_51 = eq(funct3, UInt<1>("h0")) @[core.scala 245:48]
    node _T_52 = and(_T_50, _T_51) @[core.scala 245:38]
    node _GEN_0 = mux(_T_52, UInt<5>("h10"), UInt<8>("hff")) @[core.scala 245:62 246:12 248:12]
    node _GEN_1 = mux(_T_49, UInt<4>("ha"), _GEN_0) @[core.scala 243:89 244:12]
    node _GEN_2 = mux(_T_44, UInt<4>("h9"), _GEN_1) @[core.scala 241:89 242:12]
    node _GEN_3 = mux(_T_39, UInt<1>("h1"), _GEN_2) @[core.scala 239:89 240:12]
    node _GEN_4 = mux(_T_34, UInt<3>("h4"), _GEN_3) @[core.scala 237:89 238:12]
    node _GEN_5 = mux(_T_29, UInt<2>("h3"), _GEN_4) @[core.scala 235:89 236:12]
    node _GEN_6 = mux(_T_24, UInt<4>("h8"), _GEN_5) @[core.scala 233:89 234:12]
    node _GEN_7 = mux(_T_19, UInt<3>("h7"), _GEN_6) @[core.scala 231:89 232:12]
    node _GEN_8 = mux(_T_14, UInt<3>("h6"), _GEN_7) @[core.scala 229:89 230:12]
    node _GEN_9 = mux(_T_9, UInt<2>("h2"), _GEN_8) @[core.scala 227:89 228:12]
    node _GEN_10 = mux(_T_4, UInt<1>("h1"), _GEN_9) @[core.scala 225:83 226:12]
    io_immediate <= imm @[core.scala 255:16]
    io_uop <= _GEN_10
    io_rs1 <= rs1 @[core.scala 253:10]
    io_rs2 <= rs2 @[core.scala 254:10]
    io_rd <= rd @[core.scala 256:9]

  module EX :
    input clock : Clock
    input reset : UInt<1>
    input io_uop : UInt<8>
    input io_operandA : UInt<32>
    input io_operandB : UInt<32>
    input io_immediate : UInt<12>
    output io_result : UInt<32>

    node _T = eq(io_uop, UInt<1>("h1")) @[core.scala 273:16]
    node _io_result_T = add(io_operandA, io_operandB) @[core.scala 274:30]
    node _io_result_T_1 = tail(_io_result_T, 1) @[core.scala 274:30]
    node _T_1 = eq(io_uop, UInt<2>("h2")) @[core.scala 275:21]
    node _io_result_T_2 = sub(io_operandA, io_operandB) @[core.scala 276:30]
    node _io_result_T_3 = tail(_io_result_T_2, 1) @[core.scala 276:30]
    node _T_2 = eq(io_uop, UInt<3>("h5")) @[core.scala 277:21]
    node _io_result_T_4 = and(io_operandA, io_operandB) @[core.scala 278:30]
    node _T_3 = eq(io_uop, UInt<3>("h4")) @[core.scala 279:21]
    node _io_result_T_5 = or(io_operandA, io_operandB) @[core.scala 280:30]
    node _T_4 = eq(io_uop, UInt<2>("h3")) @[core.scala 281:21]
    node _io_result_T_6 = xor(io_operandA, io_operandB) @[core.scala 282:30]
    node _T_5 = eq(io_uop, UInt<3>("h6")) @[core.scala 283:21]
    node _io_result_T_7 = bits(io_operandB, 4, 0) @[core.scala 284:44]
    node _io_result_T_8 = dshl(io_operandA, _io_result_T_7) @[core.scala 284:30]
    node _T_6 = eq(io_uop, UInt<3>("h7")) @[core.scala 285:21]
    node _io_result_T_9 = bits(io_operandB, 4, 0) @[core.scala 286:44]
    node _io_result_T_10 = dshr(io_operandA, _io_result_T_9) @[core.scala 286:30]
    node _T_7 = eq(io_uop, UInt<4>("h8")) @[core.scala 287:21]
    node _io_result_T_11 = asSInt(io_operandA) @[core.scala 288:31]
    node _io_result_T_12 = bits(io_operandB, 4, 0) @[core.scala 288:52]
    node _io_result_T_13 = dshr(_io_result_T_11, _io_result_T_12) @[core.scala 288:38]
    node _io_result_T_14 = asUInt(_io_result_T_13) @[core.scala 288:60]
    node _T_8 = eq(io_uop, UInt<4>("ha")) @[core.scala 289:21]
    node _io_result_T_15 = lt(io_operandA, io_operandB) @[core.scala 290:35]
    node _io_result_T_16 = mux(_io_result_T_15, UInt<1>("h1"), UInt<1>("h0")) @[core.scala 290:22]
    node _T_9 = eq(io_uop, UInt<2>("h2")) @[core.scala 291:21]
    node _io_result_T_17 = asSInt(io_operandA) @[core.scala 292:35]
    node _io_result_T_18 = asSInt(io_operandB) @[core.scala 292:56]
    node _io_result_T_19 = lt(_io_result_T_17, _io_result_T_18) @[core.scala 292:42]
    node _io_result_T_20 = mux(_io_result_T_19, UInt<1>("h1"), UInt<1>("h0")) @[core.scala 292:22]
    node _T_10 = eq(io_uop, UInt<5>("h10")) @[core.scala 293:21]
    node _io_result_T_21 = add(io_operandA, io_immediate) @[core.scala 294:30]
    node _io_result_T_22 = tail(_io_result_T_21, 1) @[core.scala 294:30]
    node _GEN_0 = mux(_T_10, _io_result_T_22, UInt<32>("hffffffff")) @[core.scala 293:33 294:15 296:15]
    node _GEN_1 = mux(_T_9, _io_result_T_20, _GEN_0) @[core.scala 291:32 292:15]
    node _GEN_2 = mux(_T_8, _io_result_T_16, _GEN_1) @[core.scala 289:33 290:15]
    node _GEN_3 = mux(_T_7, _io_result_T_14, _GEN_2) @[core.scala 287:32 288:15]
    node _GEN_4 = mux(_T_6, _io_result_T_10, _GEN_3) @[core.scala 285:32 286:15]
    node _GEN_5 = mux(_T_5, _io_result_T_8, _GEN_4) @[core.scala 283:32 284:15]
    node _GEN_6 = mux(_T_4, _io_result_T_6, _GEN_5) @[core.scala 281:32 282:15]
    node _GEN_7 = mux(_T_3, _io_result_T_5, _GEN_6) @[core.scala 279:31 280:15]
    node _GEN_8 = mux(_T_2, _io_result_T_4, _GEN_7) @[core.scala 277:32 278:15]
    node _GEN_9 = mux(_T_1, _io_result_T_3, _GEN_8) @[core.scala 275:32 276:15]
    node _GEN_10 = mux(_T, _io_result_T_1, _GEN_9) @[core.scala 273:27 274:15]
    io_result <= bits(_GEN_10, 31, 0)

  module MEM :
    input clock : Clock
    input reset : UInt<1>
    input io_rd : UInt<5>
    input io_result : UInt<32>
    output io_rdO : UInt<5>
    output io_resultO : UInt<32>

    io_rdO <= io_rd @[core.scala 313:10]
    io_resultO <= io_result @[core.scala 314:14]

  module WB :
    input clock : Clock
    input reset : UInt<1>
    input io_rd : UInt<5>
    input io_result : UInt<32>
    output io_wbToRegFile_writeEn : UInt<1>
    output io_wbToRegFile_rd : UInt<5>
    output io_wbToRegFile_data : UInt<32>
    output io_check_res : UInt<32>

    io_wbToRegFile_writeEn <= UInt<1>("h1") @[core.scala 331:26]
    io_wbToRegFile_rd <= io_rd @[core.scala 332:21]
    io_wbToRegFile_data <= io_result @[core.scala 333:23]
    io_check_res <= io_result @[core.scala 334:16]

  module ForwardingUnit :
    input clock : Clock
    input reset : UInt<1>
    input io_idRs1 : UInt<5>
    input io_idRs2 : UInt<5>
    input io_exRd : UInt<5>
    input io_exmemRd : UInt<5>
    input io_wbRd : UInt<5>
    input io_wbWriteEn : UInt<1>
    output io_forwardA : UInt<2>
    output io_forwardB : UInt<2>

    node _exHazardA_T = neq(io_exRd, UInt<1>("h0")) @[core.scala 159:28]
    node _exHazardA_T_1 = eq(io_exRd, io_idRs1) @[core.scala 159:49]
    node exHazardA = and(_exHazardA_T, _exHazardA_T_1) @[core.scala 159:37]
    node _exHazardB_T = neq(io_exRd, UInt<1>("h0")) @[core.scala 160:28]
    node _exHazardB_T_1 = eq(io_exRd, io_idRs2) @[core.scala 160:49]
    node exHazardB = and(_exHazardB_T, _exHazardB_T_1) @[core.scala 160:37]
    node _wbHazardA_T = neq(io_wbRd, UInt<1>("h0")) @[core.scala 161:44]
    node _wbHazardA_T_1 = and(io_wbWriteEn, _wbHazardA_T) @[core.scala 161:32]
    node _wbHazardA_T_2 = eq(io_wbRd, io_idRs1) @[core.scala 161:65]
    node wbHazardA = and(_wbHazardA_T_1, _wbHazardA_T_2) @[core.scala 161:53]
    node _wbHazardB_T = neq(io_wbRd, UInt<1>("h0")) @[core.scala 162:44]
    node _wbHazardB_T_1 = and(io_wbWriteEn, _wbHazardB_T) @[core.scala 162:32]
    node _wbHazardB_T_2 = eq(io_wbRd, io_idRs2) @[core.scala 162:65]
    node wbHazardB = and(_wbHazardB_T_1, _wbHazardB_T_2) @[core.scala 162:53]
    node _exmemHazardA_T = neq(io_exmemRd, UInt<1>("h0")) @[core.scala 163:34]
    node _exmemHazardA_T_1 = eq(io_exmemRd, io_idRs1) @[core.scala 163:56]
    node exmemHazardA = and(_exmemHazardA_T, _exmemHazardA_T_1) @[core.scala 163:42]
    node _exmemHazardB_T = neq(io_exmemRd, UInt<1>("h0")) @[core.scala 164:34]
    node _exmemHazardB_T_1 = eq(io_exmemRd, io_idRs2) @[core.scala 164:56]
    node exmemHazardB = and(_exmemHazardB_T, _exmemHazardB_T_1) @[core.scala 164:42]
    node _io_forwardA_T = mux(exHazardA, UInt<1>("h1"), UInt<1>("h0")) @[Mux.scala 101:16]
    node _io_forwardA_T_1 = mux(exmemHazardA, UInt<2>("h2"), _io_forwardA_T) @[Mux.scala 101:16]
    node _io_forwardB_T = mux(exHazardB, UInt<1>("h1"), UInt<1>("h0")) @[Mux.scala 101:16]
    node _io_forwardB_T_1 = mux(exmemHazardB, UInt<2>("h2"), _io_forwardB_T) @[Mux.scala 101:16]
    io_forwardA <= _io_forwardA_T_1 @[core.scala 166:15]
    io_forwardB <= _io_forwardB_T_1 @[core.scala 171:15]

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

    mem regFile : @[core.scala 127:20]
      data-type => UInt<32>
      depth => 32
      read-latency => 0
      write-latency => 1
      reader => io_resp1_data_MPORT
      reader => io_resp2_data_MPORT
      writer => MPORT
      writer => MPORT_1
      read-under-write => undefined
    node _GEN_0 = validif(io_write_writeEn, io_write_rd) @[core.scala 132:26 133:12]
    node _GEN_1 = validif(io_write_writeEn, clock) @[core.scala 132:26 133:12]
    node _GEN_2 = mux(io_write_writeEn, UInt<1>("h1"), UInt<1>("h0")) @[core.scala 132:26 133:12 127:20]
    node _GEN_3 = validif(io_write_writeEn, UInt<1>("h1")) @[core.scala 132:26 133:26]
    node _GEN_4 = validif(io_write_writeEn, io_write_data) @[core.scala 132:26 133:26]
    io_resp1_data <= regFile.io_resp1_data_MPORT.data @[core.scala 129:17]
    io_resp2_data <= regFile.io_resp2_data_MPORT.data @[core.scala 130:17]
    regFile.io_resp1_data_MPORT.addr <= io_req1_rs @[core.scala 129:27]
    regFile.io_resp1_data_MPORT.en <= UInt<1>("h1") @[core.scala 129:27]
    regFile.io_resp1_data_MPORT.clk <= clock @[core.scala 129:27]
    regFile.io_resp2_data_MPORT.addr <= io_req2_rs @[core.scala 130:27]
    regFile.io_resp2_data_MPORT.en <= UInt<1>("h1") @[core.scala 130:27]
    regFile.io_resp2_data_MPORT.clk <= clock @[core.scala 130:27]
    regFile.MPORT.addr <= UInt<5>("h0") @[core.scala 128:10]
    regFile.MPORT.en <= UInt<1>("h1") @[core.scala 128:10]
    regFile.MPORT.clk <= clock @[core.scala 128:10]
    regFile.MPORT.data <= UInt<32>("h0") @[core.scala 128:14]
    regFile.MPORT.mask <= UInt<1>("h1") @[core.scala 128:14]
    regFile.MPORT_1.addr <= _GEN_0
    regFile.MPORT_1.en <= _GEN_2
    regFile.MPORT_1.clk <= _GEN_1
    regFile.MPORT_1.data <= _GEN_4
    regFile.MPORT_1.mask <= _GEN_3

  module PipelinedRV32Icore :
    input clock : Clock
    input reset : UInt<1>
    output io_check_res : UInt<32>

    inst ifBarrier of IFBarrier @[core.scala 484:25]
    inst idBarrier of IDBarrier @[core.scala 485:25]
    inst exBarrier of EXBarrier @[core.scala 486:25]
    inst memBarrier of MEMBarrier @[core.scala 487:26]
    inst IF of IF @[core.scala 491:18]
    inst ID of ID @[core.scala 492:18]
    inst EX of EX @[core.scala 493:18]
    inst MEM of MEM @[core.scala 494:19]
    inst WB of WB @[core.scala 495:18]
    inst fwUnit of ForwardingUnit @[core.scala 497:22]
    inst regFile of regFile @[core.scala 500:23]
    reg pc : UInt<32>, clock with :
      reset => (UInt<1>("h0"), pc) @[core.scala 504:19]
    node _forwardA_T = eq(UInt<1>("h0"), fwUnit.io_forwardA) @[Mux.scala 81:61]
    node _forwardA_T_1 = mux(_forwardA_T, regFile.io_resp1_data, regFile.io_resp1_data) @[Mux.scala 81:58]
    node _forwardA_T_2 = eq(UInt<1>("h1"), fwUnit.io_forwardA) @[Mux.scala 81:61]
    node _forwardA_T_3 = mux(_forwardA_T_2, exBarrier.io_resOut, _forwardA_T_1) @[Mux.scala 81:58]
    node _forwardA_T_4 = eq(UInt<2>("h2"), fwUnit.io_forwardA) @[Mux.scala 81:61]
    node forwardA = mux(_forwardA_T_4, memBarrier.io_resultOut, _forwardA_T_3) @[Mux.scala 81:58]
    node _forwardB_T = eq(UInt<1>("h0"), fwUnit.io_forwardB) @[Mux.scala 81:61]
    node _forwardB_T_1 = mux(_forwardB_T, regFile.io_resp2_data, regFile.io_resp2_data) @[Mux.scala 81:58]
    node _forwardB_T_2 = eq(UInt<1>("h1"), fwUnit.io_forwardB) @[Mux.scala 81:61]
    node _forwardB_T_3 = mux(_forwardB_T_2, exBarrier.io_resOut, _forwardB_T_1) @[Mux.scala 81:58]
    node _forwardB_T_4 = eq(UInt<2>("h2"), fwUnit.io_forwardB) @[Mux.scala 81:61]
    node forwardB = mux(_forwardB_T_4, memBarrier.io_resultOut, _forwardB_T_3) @[Mux.scala 81:58]
    io_check_res <= WB.io_check_res @[core.scala 570:16]
    ifBarrier.clock <= clock
    ifBarrier.reset <= reset
    ifBarrier.io_pcIn <= IF.io_pcNew @[core.scala 509:21]
    ifBarrier.io_instrIn <= IF.io_instr @[core.scala 510:24]
    idBarrier.clock <= clock
    idBarrier.reset <= reset
    idBarrier.io_immediate <= ID.io_immediate @[core.scala 519:26]
    idBarrier.io_uop <= ID.io_uop @[core.scala 521:20]
    idBarrier.io_rd <= ID.io_rd @[core.scala 520:19]
    idBarrier.io_rs1 <= ID.io_rs1 @[core.scala 516:20]
    idBarrier.io_rs2 <= ID.io_rs2 @[core.scala 517:20]
    exBarrier.clock <= clock
    exBarrier.reset <= reset
    exBarrier.io_result <= EX.io_result @[core.scala 556:23]
    exBarrier.io_rd <= idBarrier.io_rdOut @[core.scala 555:19]
    memBarrier.clock <= clock
    memBarrier.reset <= reset
    memBarrier.io_rdIn <= MEM.io_rdO @[core.scala 562:22]
    memBarrier.io_resultIn <= MEM.io_resultO @[core.scala 561:26]
    IF.clock <= clock
    IF.reset <= reset
    IF.io_pc <= pc @[core.scala 507:12]
    ID.clock <= clock
    ID.reset <= reset
    ID.io_instr <= ifBarrier.io_instrOut @[core.scala 513:15]
    EX.clock <= clock
    EX.reset <= reset
    EX.io_uop <= idBarrier.io_uopOut @[core.scala 551:13]
    EX.io_operandA <= forwardA @[core.scala 552:18]
    EX.io_operandB <= forwardB @[core.scala 553:18]
    EX.io_immediate <= idBarrier.io_immediateOut @[core.scala 554:19]
    MEM.clock <= clock
    MEM.reset <= reset
    MEM.io_rd <= exBarrier.io_rdOut @[core.scala 559:13]
    MEM.io_result <= exBarrier.io_resOut @[core.scala 560:17]
    WB.clock <= clock
    WB.reset <= reset
    WB.io_rd <= memBarrier.io_rdOut @[core.scala 567:12]
    WB.io_result <= memBarrier.io_resultOut @[core.scala 566:16]
    fwUnit.clock <= clock
    fwUnit.reset <= reset
    fwUnit.io_idRs1 <= idBarrier.io_rs1out @[core.scala 527:23]
    fwUnit.io_idRs2 <= idBarrier.io_rs2out @[core.scala 528:23]
    fwUnit.io_exRd <= exBarrier.io_rdOut @[core.scala 529:23]
    fwUnit.io_exmemRd <= memBarrier.io_rdOut @[core.scala 532:23]
    fwUnit.io_wbRd <= WB.io_rd @[core.scala 530:23]
    fwUnit.io_wbWriteEn <= WB.io_wbToRegFile_writeEn @[core.scala 531:23]
    regFile.clock <= clock
    regFile.reset <= reset
    regFile.io_req1_rs <= idBarrier.io_rs1out @[core.scala 524:22]
    regFile.io_req2_rs <= idBarrier.io_rs2out @[core.scala 525:22]
    regFile.io_write_writeEn <= WB.io_wbToRegFile_writeEn @[core.scala 569:20]
    regFile.io_write_rd <= WB.io_wbToRegFile_rd @[core.scala 569:20]
    regFile.io_write_data <= WB.io_wbToRegFile_data @[core.scala 569:20]
    pc <= mux(reset, UInt<32>("h0"), IF.io_pcNew) @[core.scala 504:{19,19} 508:6]

  module PipelinedRV32I :
    input clock : Clock
    input reset : UInt<1>
    output io_result : UInt<32>

    inst core of PipelinedRV32Icore @[PipelinedRISCV32I.scala 20:20]
    io_result <= core.io_check_res @[PipelinedRISCV32I.scala 22:19]
    core.clock <= clock
    core.reset <= reset
