circuit PipelinedRV32I :
  module IFBarrier :
    input clock : Clock
    input reset : UInt<1>
    input io_pcIn : UInt<32>
    input io_instrIn : UInt<32>
    output io_pcOut : UInt<32>
    output io_instrOut : UInt<32>

    reg pcReg : UInt<32>, clock with :
      reset => (UInt<1>("h0"), pcReg) @[core.scala 348:18]
    reg instrReg : UInt<32>, clock with :
      reset => (UInt<1>("h0"), instrReg) @[core.scala 349:21]
    io_pcOut <= pcReg @[core.scala 354:12]
    io_instrOut <= instrReg @[core.scala 355:15]
    pcReg <= io_pcIn @[core.scala 351:9]
    instrReg <= io_instrIn @[core.scala 352:12]

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
      reset => (UInt<1>("h0"), immReg) @[core.scala 379:19]
    reg opReg : UInt<8>, clock with :
      reset => (UInt<1>("h0"), opReg) @[core.scala 380:18]
    reg rdReg : UInt<5>, clock with :
      reset => (UInt<1>("h0"), rdReg) @[core.scala 381:18]
    reg rs1Reg : UInt<5>, clock with :
      reset => (UInt<1>("h0"), rs1Reg) @[core.scala 382:19]
    reg rs2Reg : UInt<5>, clock with :
      reset => (UInt<1>("h0"), rs2Reg) @[core.scala 383:19]
    io_immediateOut <= immReg @[core.scala 391:19]
    io_uopOut <= opReg @[core.scala 392:13]
    io_rdOut <= rdReg @[core.scala 393:12]
    io_rs1out <= rs1Reg @[core.scala 394:13]
    io_rs2out <= rs2Reg @[core.scala 395:13]
    immReg <= io_immediate @[core.scala 385:10]
    opReg <= io_uop @[core.scala 386:9]
    rdReg <= io_rd @[core.scala 387:9]
    rs1Reg <= io_rs1 @[core.scala 388:10]
    rs2Reg <= io_rs2 @[core.scala 389:10]

  module EXBarrier :
    input clock : Clock
    input reset : UInt<1>
    input io_result : UInt<32>
    input io_rd : UInt<5>
    output io_resOut : UInt<32>
    output io_rdOut : UInt<5>

    reg resultReg : UInt<32>, clock with :
      reset => (UInt<1>("h0"), resultReg) @[core.scala 413:22]
    reg rdReg : UInt<5>, clock with :
      reset => (UInt<1>("h0"), rdReg) @[core.scala 414:18]
    io_resOut <= resultReg @[core.scala 419:13]
    io_rdOut <= rdReg @[core.scala 420:12]
    resultReg <= io_result @[core.scala 416:13]
    rdReg <= io_rd @[core.scala 417:9]

  module MEMBarrier :
    input clock : Clock
    input reset : UInt<1>
    input io_rdIn : UInt<5>
    input io_resultIn : UInt<32>
    output io_rdOut : UInt<5>
    output io_resultOut : UInt<32>

    reg rdreg : UInt<5>, clock with :
      reset => (UInt<1>("h0"), rdreg) @[core.scala 438:18]
    reg resReg : UInt<32>, clock with :
      reset => (UInt<1>("h0"), resReg) @[core.scala 439:19]
    io_rdOut <= rdreg @[core.scala 444:12]
    io_resultOut <= resReg @[core.scala 445:16]
    rdreg <= io_rdIn @[core.scala 441:9]
    resReg <= io_resultIn @[core.scala 442:10]

  module IF :
    input clock : Clock
    input reset : UInt<1>
    input io_pc : UInt<32>
    output io_instr : UInt<32>
    output io_pcNew : UInt<32>

    mem IMem : @[core.scala 190:17]
      data-type => UInt<32>
      depth => 4096
      read-latency => 0
      write-latency => 1
      reader => io_instr_MPORT
      read-under-write => undefined
    node _io_instr_T = dshr(io_pc, UInt<2>("h2")) @[core.scala 193:25]
    node _io_instr_T_1 = bits(_io_instr_T, 11, 0) @[core.scala 193:19]
    node _io_pcNew_T = add(io_pc, UInt<3>("h4")) @[core.scala 195:21]
    node _io_pcNew_T_1 = tail(_io_pcNew_T, 1) @[core.scala 195:21]
    io_instr <= IMem.io_instr_MPORT.data @[core.scala 193:12]
    io_pcNew <= _io_pcNew_T_1 @[core.scala 195:12]
    IMem.io_instr_MPORT.addr <= _io_instr_T_1 @[core.scala 193:19]
    IMem.io_instr_MPORT.en <= UInt<1>("h1") @[core.scala 193:19]
    IMem.io_instr_MPORT.clk <= clock @[core.scala 193:19]

  module ID :
    input clock : Clock
    input reset : UInt<1>
    input io_instr : UInt<32>
    output io_immediate : UInt<12>
    output io_uop : UInt<8>
    output io_rs1 : UInt<5>
    output io_rs2 : UInt<5>
    output io_rd : UInt<5>

    node opcode = bits(io_instr, 6, 0) @[core.scala 213:24]
    node rd = bits(io_instr, 11, 7) @[core.scala 214:24]
    node funct3 = bits(io_instr, 14, 12) @[core.scala 215:24]
    node rs1 = bits(io_instr, 19, 15) @[core.scala 216:24]
    node rs2 = bits(io_instr, 24, 20) @[core.scala 217:24]
    node funct7 = bits(io_instr, 31, 25) @[core.scala 218:24]
    node imm = bits(io_instr, 31, 20) @[core.scala 219:21]
    node _T = eq(opcode, UInt<6>("h33")) @[core.scala 222:15]
    node _T_1 = eq(funct3, UInt<1>("h0")) @[core.scala 222:42]
    node _T_2 = and(_T, _T_1) @[core.scala 222:32]
    node _T_3 = eq(funct7, UInt<1>("h0")) @[core.scala 222:65]
    node _T_4 = and(_T_2, _T_3) @[core.scala 222:55]
    node _T_5 = eq(opcode, UInt<6>("h33")) @[core.scala 224:21]
    node _T_6 = eq(funct3, UInt<1>("h0")) @[core.scala 224:48]
    node _T_7 = and(_T_5, _T_6) @[core.scala 224:38]
    node _T_8 = eq(funct7, UInt<6>("h20")) @[core.scala 224:71]
    node _T_9 = and(_T_7, _T_8) @[core.scala 224:61]
    node _T_10 = eq(opcode, UInt<6>("h33")) @[core.scala 226:21]
    node _T_11 = eq(funct3, UInt<1>("h1")) @[core.scala 226:48]
    node _T_12 = and(_T_10, _T_11) @[core.scala 226:38]
    node _T_13 = eq(funct7, UInt<1>("h0")) @[core.scala 226:71]
    node _T_14 = and(_T_12, _T_13) @[core.scala 226:61]
    node _T_15 = eq(opcode, UInt<6>("h33")) @[core.scala 228:21]
    node _T_16 = eq(funct3, UInt<3>("h5")) @[core.scala 228:48]
    node _T_17 = and(_T_15, _T_16) @[core.scala 228:38]
    node _T_18 = eq(funct7, UInt<1>("h0")) @[core.scala 228:71]
    node _T_19 = and(_T_17, _T_18) @[core.scala 228:61]
    node _T_20 = eq(opcode, UInt<6>("h33")) @[core.scala 230:21]
    node _T_21 = eq(funct3, UInt<3>("h5")) @[core.scala 230:48]
    node _T_22 = and(_T_20, _T_21) @[core.scala 230:38]
    node _T_23 = eq(funct7, UInt<6>("h20")) @[core.scala 230:71]
    node _T_24 = and(_T_22, _T_23) @[core.scala 230:61]
    node _T_25 = eq(opcode, UInt<6>("h33")) @[core.scala 232:21]
    node _T_26 = eq(funct3, UInt<3>("h4")) @[core.scala 232:48]
    node _T_27 = and(_T_25, _T_26) @[core.scala 232:38]
    node _T_28 = eq(funct7, UInt<1>("h0")) @[core.scala 232:71]
    node _T_29 = and(_T_27, _T_28) @[core.scala 232:61]
    node _T_30 = eq(opcode, UInt<6>("h33")) @[core.scala 234:21]
    node _T_31 = eq(funct3, UInt<3>("h6")) @[core.scala 234:48]
    node _T_32 = and(_T_30, _T_31) @[core.scala 234:38]
    node _T_33 = eq(funct7, UInt<1>("h0")) @[core.scala 234:71]
    node _T_34 = and(_T_32, _T_33) @[core.scala 234:61]
    node _T_35 = eq(opcode, UInt<6>("h33")) @[core.scala 236:21]
    node _T_36 = eq(funct3, UInt<3>("h7")) @[core.scala 236:48]
    node _T_37 = and(_T_35, _T_36) @[core.scala 236:38]
    node _T_38 = eq(funct7, UInt<1>("h0")) @[core.scala 236:71]
    node _T_39 = and(_T_37, _T_38) @[core.scala 236:61]
    node _T_40 = eq(opcode, UInt<6>("h33")) @[core.scala 238:21]
    node _T_41 = eq(funct3, UInt<2>("h2")) @[core.scala 238:48]
    node _T_42 = and(_T_40, _T_41) @[core.scala 238:38]
    node _T_43 = eq(funct7, UInt<1>("h0")) @[core.scala 238:71]
    node _T_44 = and(_T_42, _T_43) @[core.scala 238:61]
    node _T_45 = eq(opcode, UInt<6>("h33")) @[core.scala 240:21]
    node _T_46 = eq(funct3, UInt<2>("h3")) @[core.scala 240:48]
    node _T_47 = and(_T_45, _T_46) @[core.scala 240:38]
    node _T_48 = eq(funct7, UInt<1>("h0")) @[core.scala 240:71]
    node _T_49 = and(_T_47, _T_48) @[core.scala 240:61]
    node _T_50 = eq(opcode, UInt<5>("h13")) @[core.scala 242:21]
    node _T_51 = eq(funct3, UInt<1>("h0")) @[core.scala 242:48]
    node _T_52 = and(_T_50, _T_51) @[core.scala 242:38]
    node _GEN_0 = mux(_T_52, UInt<5>("h10"), UInt<8>("hff")) @[core.scala 242:62 243:12 245:12]
    node _GEN_1 = mux(_T_49, UInt<4>("ha"), _GEN_0) @[core.scala 240:89 241:12]
    node _GEN_2 = mux(_T_44, UInt<4>("h9"), _GEN_1) @[core.scala 238:89 239:12]
    node _GEN_3 = mux(_T_39, UInt<1>("h1"), _GEN_2) @[core.scala 236:89 237:12]
    node _GEN_4 = mux(_T_34, UInt<3>("h4"), _GEN_3) @[core.scala 234:89 235:12]
    node _GEN_5 = mux(_T_29, UInt<2>("h3"), _GEN_4) @[core.scala 232:89 233:12]
    node _GEN_6 = mux(_T_24, UInt<4>("h8"), _GEN_5) @[core.scala 230:89 231:12]
    node _GEN_7 = mux(_T_19, UInt<3>("h7"), _GEN_6) @[core.scala 228:89 229:12]
    node _GEN_8 = mux(_T_14, UInt<3>("h6"), _GEN_7) @[core.scala 226:89 227:12]
    node _GEN_9 = mux(_T_9, UInt<2>("h2"), _GEN_8) @[core.scala 224:89 225:12]
    node _GEN_10 = mux(_T_4, UInt<1>("h1"), _GEN_9) @[core.scala 222:83 223:12]
    io_immediate <= imm @[core.scala 252:16]
    io_uop <= _GEN_10
    io_rs1 <= rs1 @[core.scala 250:10]
    io_rs2 <= rs2 @[core.scala 251:10]
    io_rd <= rd @[core.scala 253:9]

  module EX :
    input clock : Clock
    input reset : UInt<1>
    input io_uop : UInt<8>
    input io_operandA : UInt<32>
    input io_operandB : UInt<32>
    input io_immediate : UInt<12>
    output io_result : UInt<32>

    node _T = eq(io_uop, UInt<1>("h1")) @[core.scala 270:16]
    node _io_result_T = add(io_operandA, io_operandB) @[core.scala 271:30]
    node _io_result_T_1 = tail(_io_result_T, 1) @[core.scala 271:30]
    node _T_1 = eq(io_uop, UInt<2>("h2")) @[core.scala 272:21]
    node _io_result_T_2 = sub(io_operandA, io_operandB) @[core.scala 273:30]
    node _io_result_T_3 = tail(_io_result_T_2, 1) @[core.scala 273:30]
    node _T_2 = eq(io_uop, UInt<3>("h5")) @[core.scala 274:21]
    node _io_result_T_4 = and(io_operandA, io_operandB) @[core.scala 275:30]
    node _T_3 = eq(io_uop, UInt<3>("h4")) @[core.scala 276:21]
    node _io_result_T_5 = or(io_operandA, io_operandB) @[core.scala 277:30]
    node _T_4 = eq(io_uop, UInt<2>("h3")) @[core.scala 278:21]
    node _io_result_T_6 = xor(io_operandA, io_operandB) @[core.scala 279:30]
    node _T_5 = eq(io_uop, UInt<3>("h6")) @[core.scala 280:21]
    node _io_result_T_7 = bits(io_operandB, 4, 0) @[core.scala 281:44]
    node _io_result_T_8 = dshl(io_operandA, _io_result_T_7) @[core.scala 281:30]
    node _T_6 = eq(io_uop, UInt<3>("h7")) @[core.scala 282:21]
    node _io_result_T_9 = bits(io_operandB, 4, 0) @[core.scala 283:44]
    node _io_result_T_10 = dshr(io_operandA, _io_result_T_9) @[core.scala 283:30]
    node _T_7 = eq(io_uop, UInt<4>("h8")) @[core.scala 284:21]
    node _io_result_T_11 = asSInt(io_operandA) @[core.scala 285:31]
    node _io_result_T_12 = bits(io_operandB, 4, 0) @[core.scala 285:52]
    node _io_result_T_13 = dshr(_io_result_T_11, _io_result_T_12) @[core.scala 285:38]
    node _io_result_T_14 = asUInt(_io_result_T_13) @[core.scala 285:60]
    node _T_8 = eq(io_uop, UInt<4>("ha")) @[core.scala 286:21]
    node _io_result_T_15 = lt(io_operandA, io_operandB) @[core.scala 287:35]
    node _io_result_T_16 = mux(_io_result_T_15, UInt<1>("h1"), UInt<1>("h0")) @[core.scala 287:22]
    node _T_9 = eq(io_uop, UInt<2>("h2")) @[core.scala 288:21]
    node _io_result_T_17 = asSInt(io_operandA) @[core.scala 289:35]
    node _io_result_T_18 = asSInt(io_operandB) @[core.scala 289:56]
    node _io_result_T_19 = lt(_io_result_T_17, _io_result_T_18) @[core.scala 289:42]
    node _io_result_T_20 = mux(_io_result_T_19, UInt<1>("h1"), UInt<1>("h0")) @[core.scala 289:22]
    node _T_10 = eq(io_uop, UInt<5>("h10")) @[core.scala 290:21]
    node _io_result_T_21 = add(io_operandA, io_immediate) @[core.scala 291:30]
    node _io_result_T_22 = tail(_io_result_T_21, 1) @[core.scala 291:30]
    node _GEN_0 = mux(_T_10, _io_result_T_22, UInt<32>("hffffffff")) @[core.scala 290:33 291:15 293:15]
    node _GEN_1 = mux(_T_9, _io_result_T_20, _GEN_0) @[core.scala 288:32 289:15]
    node _GEN_2 = mux(_T_8, _io_result_T_16, _GEN_1) @[core.scala 286:33 287:15]
    node _GEN_3 = mux(_T_7, _io_result_T_14, _GEN_2) @[core.scala 284:32 285:15]
    node _GEN_4 = mux(_T_6, _io_result_T_10, _GEN_3) @[core.scala 282:32 283:15]
    node _GEN_5 = mux(_T_5, _io_result_T_8, _GEN_4) @[core.scala 280:32 281:15]
    node _GEN_6 = mux(_T_4, _io_result_T_6, _GEN_5) @[core.scala 278:32 279:15]
    node _GEN_7 = mux(_T_3, _io_result_T_5, _GEN_6) @[core.scala 276:31 277:15]
    node _GEN_8 = mux(_T_2, _io_result_T_4, _GEN_7) @[core.scala 274:32 275:15]
    node _GEN_9 = mux(_T_1, _io_result_T_3, _GEN_8) @[core.scala 272:32 273:15]
    node _GEN_10 = mux(_T, _io_result_T_1, _GEN_9) @[core.scala 270:27 271:15]
    io_result <= bits(_GEN_10, 31, 0)

  module MEM :
    input clock : Clock
    input reset : UInt<1>
    input io_rd : UInt<5>
    input io_result : UInt<32>
    output io_rdO : UInt<5>
    output io_resultO : UInt<32>

    io_rdO <= io_rd @[core.scala 310:10]
    io_resultO <= io_result @[core.scala 311:14]

  module WB :
    input clock : Clock
    input reset : UInt<1>
    input io_rd : UInt<5>
    input io_result : UInt<32>
    output io_wbToRegFile_writeEn : UInt<1>
    output io_wbToRegFile_rd : UInt<5>
    output io_wbToRegFile_data : UInt<32>
    output io_check_res : UInt<32>

    io_wbToRegFile_writeEn <= UInt<1>("h1") @[core.scala 328:26]
    io_wbToRegFile_rd <= io_rd @[core.scala 329:21]
    io_wbToRegFile_data <= io_result @[core.scala 330:23]
    io_check_res <= io_result @[core.scala 331:16]

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

    inst ifBarrier of IFBarrier @[core.scala 481:25]
    inst idBarrier of IDBarrier @[core.scala 482:25]
    inst exBarrier of EXBarrier @[core.scala 483:25]
    inst memBarrier of MEMBarrier @[core.scala 484:26]
    inst IF of IF @[core.scala 488:18]
    inst ID of ID @[core.scala 489:18]
    inst EX of EX @[core.scala 490:18]
    inst MEM of MEM @[core.scala 491:19]
    inst WB of WB @[core.scala 492:18]
    inst fwUnit of ForwardingUnit @[core.scala 494:22]
    inst regFile of regFile @[core.scala 497:23]
    reg pc : UInt<32>, clock with :
      reset => (UInt<1>("h0"), pc) @[core.scala 501:19]
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
    io_check_res <= WB.io_check_res @[core.scala 565:16]
    ifBarrier.clock <= clock
    ifBarrier.reset <= reset
    ifBarrier.io_pcIn <= IF.io_pcNew @[core.scala 506:21]
    ifBarrier.io_instrIn <= IF.io_instr @[core.scala 507:24]
    idBarrier.clock <= clock
    idBarrier.reset <= reset
    idBarrier.io_immediate <= ID.io_immediate @[core.scala 516:26]
    idBarrier.io_uop <= ID.io_uop @[core.scala 518:20]
    idBarrier.io_rd <= ID.io_rd @[core.scala 517:19]
    idBarrier.io_rs1 <= ID.io_rs1 @[core.scala 513:20]
    idBarrier.io_rs2 <= ID.io_rs2 @[core.scala 514:20]
    exBarrier.clock <= clock
    exBarrier.reset <= reset
    exBarrier.io_result <= EX.io_result @[core.scala 551:23]
    exBarrier.io_rd <= idBarrier.io_rdOut @[core.scala 550:19]
    memBarrier.clock <= clock
    memBarrier.reset <= reset
    memBarrier.io_rdIn <= MEM.io_rdO @[core.scala 557:22]
    memBarrier.io_resultIn <= MEM.io_resultO @[core.scala 556:26]
    IF.clock <= clock
    IF.reset <= reset
    IF.io_pc <= pc @[core.scala 504:12]
    ID.clock <= clock
    ID.reset <= reset
    ID.io_instr <= ifBarrier.io_instrOut @[core.scala 510:15]
    EX.clock <= clock
    EX.reset <= reset
    EX.io_uop <= idBarrier.io_uopOut @[core.scala 546:13]
    EX.io_operandA <= forwardA @[core.scala 547:18]
    EX.io_operandB <= forwardB @[core.scala 548:18]
    EX.io_immediate <= idBarrier.io_immediateOut @[core.scala 549:19]
    MEM.clock <= clock
    MEM.reset <= reset
    MEM.io_rd <= exBarrier.io_rdOut @[core.scala 554:13]
    MEM.io_result <= exBarrier.io_resOut @[core.scala 555:17]
    WB.clock <= clock
    WB.reset <= reset
    WB.io_rd <= memBarrier.io_rdOut @[core.scala 562:12]
    WB.io_result <= memBarrier.io_resultOut @[core.scala 561:16]
    fwUnit.clock <= clock
    fwUnit.reset <= reset
    fwUnit.io_idRs1 <= idBarrier.io_rs1out @[core.scala 524:23]
    fwUnit.io_idRs2 <= idBarrier.io_rs2out @[core.scala 525:23]
    fwUnit.io_exRd <= exBarrier.io_rdOut @[core.scala 526:23]
    fwUnit.io_exmemRd <= memBarrier.io_rdOut @[core.scala 529:23]
    fwUnit.io_wbRd <= WB.io_rd @[core.scala 527:23]
    fwUnit.io_wbWriteEn <= WB.io_wbToRegFile_writeEn @[core.scala 528:23]
    regFile.clock <= clock
    regFile.reset <= reset
    regFile.io_req1_rs <= idBarrier.io_rs1out @[core.scala 521:22]
    regFile.io_req2_rs <= idBarrier.io_rs2out @[core.scala 522:22]
    regFile.io_write_writeEn <= WB.io_wbToRegFile_writeEn @[core.scala 564:20]
    regFile.io_write_rd <= WB.io_wbToRegFile_rd @[core.scala 564:20]
    regFile.io_write_data <= WB.io_wbToRegFile_data @[core.scala 564:20]
    pc <= mux(reset, UInt<32>("h0"), IF.io_pcNew) @[core.scala 501:{19,19} 505:6]

  module PipelinedRV32I :
    input clock : Clock
    input reset : UInt<1>
    output io_result : UInt<32>

    inst core of PipelinedRV32Icore @[PipelinedRISCV32I.scala 20:20]
    io_result <= core.io_check_res @[PipelinedRISCV32I.scala 22:19]
    core.clock <= clock
    core.reset <= reset
