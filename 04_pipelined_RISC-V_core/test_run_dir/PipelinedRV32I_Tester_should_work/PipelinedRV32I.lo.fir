circuit PipelinedRV32I :
  module IFBarrier :
    input clock : Clock
    input reset : UInt<1>
    input io_pcIn : UInt<32>
    input io_instrIn : UInt<32>
    output io_pcOut : UInt<32>
    output io_instrOut : UInt<32>

    reg pcReg : UInt<32>, clock with :
      reset => (UInt<1>("h0"), pcReg) @[core.scala 307:18]
    reg instrReg : UInt<32>, clock with :
      reset => (UInt<1>("h0"), instrReg) @[core.scala 308:21]
    io_pcOut <= pcReg @[core.scala 313:12]
    io_instrOut <= instrReg @[core.scala 314:15]
    pcReg <= io_pcIn @[core.scala 310:9]
    instrReg <= io_instrIn @[core.scala 311:12]

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
      reset => (UInt<1>("h0"), immReg) @[core.scala 338:19]
    reg opReg : UInt<8>, clock with :
      reset => (UInt<1>("h0"), opReg) @[core.scala 339:18]
    reg rdReg : UInt<5>, clock with :
      reset => (UInt<1>("h0"), rdReg) @[core.scala 340:18]
    reg rs1Reg : UInt<5>, clock with :
      reset => (UInt<1>("h0"), rs1Reg) @[core.scala 341:19]
    reg rs2Reg : UInt<5>, clock with :
      reset => (UInt<1>("h0"), rs2Reg) @[core.scala 342:19]
    io_immediateOut <= immReg @[core.scala 350:19]
    io_uopOut <= opReg @[core.scala 351:13]
    io_rdOut <= rdReg @[core.scala 352:12]
    io_rs1out <= rs1Reg @[core.scala 353:13]
    io_rs2out <= rs2Reg @[core.scala 354:13]
    immReg <= io_immediate @[core.scala 344:10]
    opReg <= io_uop @[core.scala 345:9]
    rdReg <= io_rd @[core.scala 346:9]
    rs1Reg <= io_rs1 @[core.scala 347:10]
    rs2Reg <= io_rs2 @[core.scala 348:10]

  module EXBarrier :
    input clock : Clock
    input reset : UInt<1>
    input io_result : UInt<32>
    input io_rd : UInt<5>
    output io_resOut : UInt<32>
    output io_rdOut : UInt<5>

    reg resultReg : UInt<32>, clock with :
      reset => (UInt<1>("h0"), resultReg) @[core.scala 372:22]
    reg rdReg : UInt<5>, clock with :
      reset => (UInt<1>("h0"), rdReg) @[core.scala 373:18]
    io_resOut <= resultReg @[core.scala 378:13]
    io_rdOut <= rdReg @[core.scala 379:12]
    resultReg <= io_result @[core.scala 375:13]
    rdReg <= io_rd @[core.scala 376:9]

  module MEMBarrier :
    input clock : Clock
    input reset : UInt<1>
    input io_rdIn : UInt<5>
    input io_resultIn : UInt<32>
    output io_rdOut : UInt<5>
    output io_resultOut : UInt<32>

    reg rdreg : UInt<5>, clock with :
      reset => (UInt<1>("h0"), rdreg) @[core.scala 397:18]
    reg resReg : UInt<32>, clock with :
      reset => (UInt<1>("h0"), resReg) @[core.scala 398:19]
    io_rdOut <= rdreg @[core.scala 403:12]
    io_resultOut <= resReg @[core.scala 404:16]
    rdreg <= io_rdIn @[core.scala 400:9]
    resReg <= io_resultIn @[core.scala 401:10]

  module IF :
    input clock : Clock
    input reset : UInt<1>
    input io_pc : UInt<32>
    output io_instr : UInt<32>
    output io_pcNew : UInt<32>

    mem IMem : @[core.scala 149:17]
      data-type => UInt<32>
      depth => 4096
      read-latency => 0
      write-latency => 1
      reader => io_instr_MPORT
      read-under-write => undefined
    node _io_instr_T = dshr(io_pc, UInt<2>("h2")) @[core.scala 152:25]
    node _io_instr_T_1 = bits(_io_instr_T, 11, 0) @[core.scala 152:19]
    node _io_pcNew_T = add(io_pc, UInt<3>("h4")) @[core.scala 154:21]
    node _io_pcNew_T_1 = tail(_io_pcNew_T, 1) @[core.scala 154:21]
    io_instr <= IMem.io_instr_MPORT.data @[core.scala 152:12]
    io_pcNew <= _io_pcNew_T_1 @[core.scala 154:12]
    IMem.io_instr_MPORT.addr <= _io_instr_T_1 @[core.scala 152:19]
    IMem.io_instr_MPORT.en <= UInt<1>("h1") @[core.scala 152:19]
    IMem.io_instr_MPORT.clk <= clock @[core.scala 152:19]

  module ID :
    input clock : Clock
    input reset : UInt<1>
    input io_instr : UInt<32>
    output io_immediate : UInt<12>
    output io_uop : UInt<8>
    output io_rs1 : UInt<5>
    output io_rs2 : UInt<5>
    output io_rd : UInt<5>

    node opcode = bits(io_instr, 6, 0) @[core.scala 172:24]
    node rd = bits(io_instr, 11, 7) @[core.scala 173:24]
    node funct3 = bits(io_instr, 14, 12) @[core.scala 174:24]
    node rs1 = bits(io_instr, 19, 15) @[core.scala 175:24]
    node rs2 = bits(io_instr, 24, 20) @[core.scala 176:24]
    node funct7 = bits(io_instr, 31, 25) @[core.scala 177:24]
    node imm = bits(io_instr, 31, 20) @[core.scala 178:21]
    node _T = eq(opcode, UInt<6>("h33")) @[core.scala 181:15]
    node _T_1 = eq(funct3, UInt<1>("h0")) @[core.scala 181:42]
    node _T_2 = and(_T, _T_1) @[core.scala 181:32]
    node _T_3 = eq(funct7, UInt<1>("h0")) @[core.scala 181:65]
    node _T_4 = and(_T_2, _T_3) @[core.scala 181:55]
    node _T_5 = eq(opcode, UInt<6>("h33")) @[core.scala 183:21]
    node _T_6 = eq(funct3, UInt<1>("h0")) @[core.scala 183:48]
    node _T_7 = and(_T_5, _T_6) @[core.scala 183:38]
    node _T_8 = eq(funct7, UInt<6>("h20")) @[core.scala 183:71]
    node _T_9 = and(_T_7, _T_8) @[core.scala 183:61]
    node _T_10 = eq(opcode, UInt<6>("h33")) @[core.scala 185:21]
    node _T_11 = eq(funct3, UInt<1>("h1")) @[core.scala 185:48]
    node _T_12 = and(_T_10, _T_11) @[core.scala 185:38]
    node _T_13 = eq(funct7, UInt<1>("h0")) @[core.scala 185:71]
    node _T_14 = and(_T_12, _T_13) @[core.scala 185:61]
    node _T_15 = eq(opcode, UInt<6>("h33")) @[core.scala 187:21]
    node _T_16 = eq(funct3, UInt<3>("h5")) @[core.scala 187:48]
    node _T_17 = and(_T_15, _T_16) @[core.scala 187:38]
    node _T_18 = eq(funct7, UInt<1>("h0")) @[core.scala 187:71]
    node _T_19 = and(_T_17, _T_18) @[core.scala 187:61]
    node _T_20 = eq(opcode, UInt<6>("h33")) @[core.scala 189:21]
    node _T_21 = eq(funct3, UInt<3>("h5")) @[core.scala 189:48]
    node _T_22 = and(_T_20, _T_21) @[core.scala 189:38]
    node _T_23 = eq(funct7, UInt<6>("h20")) @[core.scala 189:71]
    node _T_24 = and(_T_22, _T_23) @[core.scala 189:61]
    node _T_25 = eq(opcode, UInt<6>("h33")) @[core.scala 191:21]
    node _T_26 = eq(funct3, UInt<3>("h4")) @[core.scala 191:48]
    node _T_27 = and(_T_25, _T_26) @[core.scala 191:38]
    node _T_28 = eq(funct7, UInt<1>("h0")) @[core.scala 191:71]
    node _T_29 = and(_T_27, _T_28) @[core.scala 191:61]
    node _T_30 = eq(opcode, UInt<6>("h33")) @[core.scala 193:21]
    node _T_31 = eq(funct3, UInt<3>("h6")) @[core.scala 193:48]
    node _T_32 = and(_T_30, _T_31) @[core.scala 193:38]
    node _T_33 = eq(funct7, UInt<1>("h0")) @[core.scala 193:71]
    node _T_34 = and(_T_32, _T_33) @[core.scala 193:61]
    node _T_35 = eq(opcode, UInt<6>("h33")) @[core.scala 195:21]
    node _T_36 = eq(funct3, UInt<3>("h7")) @[core.scala 195:48]
    node _T_37 = and(_T_35, _T_36) @[core.scala 195:38]
    node _T_38 = eq(funct7, UInt<1>("h0")) @[core.scala 195:71]
    node _T_39 = and(_T_37, _T_38) @[core.scala 195:61]
    node _T_40 = eq(opcode, UInt<6>("h33")) @[core.scala 197:21]
    node _T_41 = eq(funct3, UInt<2>("h2")) @[core.scala 197:48]
    node _T_42 = and(_T_40, _T_41) @[core.scala 197:38]
    node _T_43 = eq(funct7, UInt<1>("h0")) @[core.scala 197:71]
    node _T_44 = and(_T_42, _T_43) @[core.scala 197:61]
    node _T_45 = eq(opcode, UInt<6>("h33")) @[core.scala 199:21]
    node _T_46 = eq(funct3, UInt<2>("h3")) @[core.scala 199:48]
    node _T_47 = and(_T_45, _T_46) @[core.scala 199:38]
    node _T_48 = eq(funct7, UInt<1>("h0")) @[core.scala 199:71]
    node _T_49 = and(_T_47, _T_48) @[core.scala 199:61]
    node _T_50 = eq(opcode, UInt<5>("h13")) @[core.scala 201:21]
    node _T_51 = eq(funct3, UInt<1>("h0")) @[core.scala 201:48]
    node _T_52 = and(_T_50, _T_51) @[core.scala 201:38]
    node _GEN_0 = mux(_T_52, UInt<5>("h10"), UInt<8>("hff")) @[core.scala 201:62 202:12 204:12]
    node _GEN_1 = mux(_T_49, UInt<4>("ha"), _GEN_0) @[core.scala 199:89 200:12]
    node _GEN_2 = mux(_T_44, UInt<4>("h9"), _GEN_1) @[core.scala 197:89 198:12]
    node _GEN_3 = mux(_T_39, UInt<1>("h1"), _GEN_2) @[core.scala 195:89 196:12]
    node _GEN_4 = mux(_T_34, UInt<3>("h4"), _GEN_3) @[core.scala 193:89 194:12]
    node _GEN_5 = mux(_T_29, UInt<2>("h3"), _GEN_4) @[core.scala 191:89 192:12]
    node _GEN_6 = mux(_T_24, UInt<4>("h8"), _GEN_5) @[core.scala 189:89 190:12]
    node _GEN_7 = mux(_T_19, UInt<3>("h7"), _GEN_6) @[core.scala 187:89 188:12]
    node _GEN_8 = mux(_T_14, UInt<3>("h6"), _GEN_7) @[core.scala 185:89 186:12]
    node _GEN_9 = mux(_T_9, UInt<2>("h2"), _GEN_8) @[core.scala 183:89 184:12]
    node _GEN_10 = mux(_T_4, UInt<1>("h1"), _GEN_9) @[core.scala 181:83 182:12]
    io_immediate <= imm @[core.scala 211:16]
    io_uop <= _GEN_10
    io_rs1 <= rs1 @[core.scala 209:10]
    io_rs2 <= rs2 @[core.scala 210:10]
    io_rd <= rd @[core.scala 212:9]

  module EX :
    input clock : Clock
    input reset : UInt<1>
    input io_uop : UInt<8>
    input io_operandA : UInt<32>
    input io_operandB : UInt<32>
    input io_immediate : UInt<12>
    output io_result : UInt<32>

    node _T = eq(io_uop, UInt<1>("h1")) @[core.scala 229:16]
    node _io_result_T = add(io_operandA, io_operandB) @[core.scala 230:30]
    node _io_result_T_1 = tail(_io_result_T, 1) @[core.scala 230:30]
    node _T_1 = eq(io_uop, UInt<2>("h2")) @[core.scala 231:21]
    node _io_result_T_2 = sub(io_operandA, io_operandB) @[core.scala 232:30]
    node _io_result_T_3 = tail(_io_result_T_2, 1) @[core.scala 232:30]
    node _T_2 = eq(io_uop, UInt<3>("h5")) @[core.scala 233:21]
    node _io_result_T_4 = and(io_operandA, io_operandB) @[core.scala 234:30]
    node _T_3 = eq(io_uop, UInt<3>("h4")) @[core.scala 235:21]
    node _io_result_T_5 = or(io_operandA, io_operandB) @[core.scala 236:30]
    node _T_4 = eq(io_uop, UInt<2>("h3")) @[core.scala 237:21]
    node _io_result_T_6 = xor(io_operandA, io_operandB) @[core.scala 238:30]
    node _T_5 = eq(io_uop, UInt<3>("h6")) @[core.scala 239:21]
    node _io_result_T_7 = bits(io_operandB, 4, 0) @[core.scala 240:44]
    node _io_result_T_8 = dshl(io_operandA, _io_result_T_7) @[core.scala 240:30]
    node _T_6 = eq(io_uop, UInt<3>("h7")) @[core.scala 241:21]
    node _io_result_T_9 = bits(io_operandB, 4, 0) @[core.scala 242:44]
    node _io_result_T_10 = dshr(io_operandA, _io_result_T_9) @[core.scala 242:30]
    node _T_7 = eq(io_uop, UInt<4>("h8")) @[core.scala 243:21]
    node _io_result_T_11 = asSInt(io_operandA) @[core.scala 244:31]
    node _io_result_T_12 = bits(io_operandB, 4, 0) @[core.scala 244:52]
    node _io_result_T_13 = dshr(_io_result_T_11, _io_result_T_12) @[core.scala 244:38]
    node _io_result_T_14 = asUInt(_io_result_T_13) @[core.scala 244:60]
    node _T_8 = eq(io_uop, UInt<4>("ha")) @[core.scala 245:21]
    node _io_result_T_15 = lt(io_operandA, io_operandB) @[core.scala 246:35]
    node _io_result_T_16 = mux(_io_result_T_15, UInt<1>("h1"), UInt<1>("h0")) @[core.scala 246:22]
    node _T_9 = eq(io_uop, UInt<2>("h2")) @[core.scala 247:21]
    node _io_result_T_17 = asSInt(io_operandA) @[core.scala 248:35]
    node _io_result_T_18 = asSInt(io_operandB) @[core.scala 248:56]
    node _io_result_T_19 = lt(_io_result_T_17, _io_result_T_18) @[core.scala 248:42]
    node _io_result_T_20 = mux(_io_result_T_19, UInt<1>("h1"), UInt<1>("h0")) @[core.scala 248:22]
    node _T_10 = eq(io_uop, UInt<5>("h10")) @[core.scala 249:21]
    node _io_result_T_21 = add(io_operandA, io_immediate) @[core.scala 250:30]
    node _io_result_T_22 = tail(_io_result_T_21, 1) @[core.scala 250:30]
    node _GEN_0 = mux(_T_10, _io_result_T_22, UInt<32>("hffffffff")) @[core.scala 249:33 250:15 252:15]
    node _GEN_1 = mux(_T_9, _io_result_T_20, _GEN_0) @[core.scala 247:32 248:15]
    node _GEN_2 = mux(_T_8, _io_result_T_16, _GEN_1) @[core.scala 245:33 246:15]
    node _GEN_3 = mux(_T_7, _io_result_T_14, _GEN_2) @[core.scala 243:32 244:15]
    node _GEN_4 = mux(_T_6, _io_result_T_10, _GEN_3) @[core.scala 241:32 242:15]
    node _GEN_5 = mux(_T_5, _io_result_T_8, _GEN_4) @[core.scala 239:32 240:15]
    node _GEN_6 = mux(_T_4, _io_result_T_6, _GEN_5) @[core.scala 237:32 238:15]
    node _GEN_7 = mux(_T_3, _io_result_T_5, _GEN_6) @[core.scala 235:31 236:15]
    node _GEN_8 = mux(_T_2, _io_result_T_4, _GEN_7) @[core.scala 233:32 234:15]
    node _GEN_9 = mux(_T_1, _io_result_T_3, _GEN_8) @[core.scala 231:32 232:15]
    node _GEN_10 = mux(_T, _io_result_T_1, _GEN_9) @[core.scala 229:27 230:15]
    io_result <= bits(_GEN_10, 31, 0)

  module MEM :
    input clock : Clock
    input reset : UInt<1>
    input io_rd : UInt<5>
    input io_result : UInt<32>
    output io_rdO : UInt<5>
    output io_resultO : UInt<32>

    io_rdO <= io_rd @[core.scala 269:10]
    io_resultO <= io_result @[core.scala 270:14]

  module WB :
    input clock : Clock
    input reset : UInt<1>
    input io_rd : UInt<5>
    input io_result : UInt<32>
    output io_wbToRegFile_writeEn : UInt<1>
    output io_wbToRegFile_rd : UInt<5>
    output io_wbToRegFile_data : UInt<32>
    output io_check_res : UInt<32>

    io_wbToRegFile_writeEn <= UInt<1>("h1") @[core.scala 287:26]
    io_wbToRegFile_rd <= io_rd @[core.scala 288:21]
    io_wbToRegFile_data <= io_result @[core.scala 289:23]
    io_check_res <= io_result @[core.scala 290:16]

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

    inst ifBarrier of IFBarrier @[core.scala 440:25]
    inst idBarrier of IDBarrier @[core.scala 441:25]
    inst exBarrier of EXBarrier @[core.scala 442:25]
    inst memBarrier of MEMBarrier @[core.scala 443:26]
    inst IF of IF @[core.scala 447:18]
    inst ID of ID @[core.scala 448:18]
    inst EX of EX @[core.scala 449:18]
    inst MEM of MEM @[core.scala 450:19]
    inst WB of WB @[core.scala 451:18]
    inst regFile of regFile @[core.scala 454:23]
    reg pc : UInt<32>, clock with :
      reset => (UInt<1>("h0"), pc) @[core.scala 458:19]
    io_check_res <= WB.io_check_res @[core.scala 499:16]
    ifBarrier.clock <= clock
    ifBarrier.reset <= reset
    ifBarrier.io_pcIn <= IF.io_pcNew @[core.scala 463:21]
    ifBarrier.io_instrIn <= IF.io_instr @[core.scala 464:24]
    idBarrier.clock <= clock
    idBarrier.reset <= reset
    idBarrier.io_immediate <= ID.io_immediate @[core.scala 473:26]
    idBarrier.io_uop <= ID.io_uop @[core.scala 475:20]
    idBarrier.io_rd <= ID.io_rd @[core.scala 474:19]
    idBarrier.io_rs1 <= ID.io_rs1 @[core.scala 470:20]
    idBarrier.io_rs2 <= ID.io_rs2 @[core.scala 471:20]
    exBarrier.clock <= clock
    exBarrier.reset <= reset
    exBarrier.io_result <= EX.io_result @[core.scala 485:23]
    exBarrier.io_rd <= idBarrier.io_rdOut @[core.scala 484:19]
    memBarrier.clock <= clock
    memBarrier.reset <= reset
    memBarrier.io_rdIn <= MEM.io_rdO @[core.scala 491:22]
    memBarrier.io_resultIn <= MEM.io_resultO @[core.scala 490:26]
    IF.clock <= clock
    IF.reset <= reset
    IF.io_pc <= pc @[core.scala 461:12]
    ID.clock <= clock
    ID.reset <= reset
    ID.io_instr <= ifBarrier.io_instrOut @[core.scala 467:15]
    EX.clock <= clock
    EX.reset <= reset
    EX.io_uop <= idBarrier.io_uopOut @[core.scala 480:13]
    EX.io_operandA <= regFile.io_resp1_data @[core.scala 481:18]
    EX.io_operandB <= regFile.io_resp2_data @[core.scala 482:18]
    EX.io_immediate <= idBarrier.io_immediateOut @[core.scala 483:19]
    MEM.clock <= clock
    MEM.reset <= reset
    MEM.io_rd <= exBarrier.io_rdOut @[core.scala 488:13]
    MEM.io_result <= exBarrier.io_resOut @[core.scala 489:17]
    WB.clock <= clock
    WB.reset <= reset
    WB.io_rd <= memBarrier.io_rdOut @[core.scala 496:12]
    WB.io_result <= memBarrier.io_resultOut @[core.scala 495:16]
    regFile.clock <= clock
    regFile.reset <= reset
    regFile.io_req1_rs <= idBarrier.io_rs1out @[core.scala 478:22]
    regFile.io_req2_rs <= idBarrier.io_rs2out @[core.scala 479:22]
    regFile.io_write_writeEn <= WB.io_wbToRegFile_writeEn @[core.scala 498:20]
    regFile.io_write_rd <= WB.io_wbToRegFile_rd @[core.scala 498:20]
    regFile.io_write_data <= WB.io_wbToRegFile_data @[core.scala 498:20]
    pc <= mux(reset, UInt<32>("h0"), IF.io_pcNew) @[core.scala 458:{19,19} 462:6]

  module PipelinedRV32I :
    input clock : Clock
    input reset : UInt<1>
    output io_result : UInt<32>

    inst core of PipelinedRV32Icore @[PipelinedRISCV32I.scala 20:20]
    io_result <= core.io_check_res @[PipelinedRISCV32I.scala 22:19]
    core.clock <= clock
    core.reset <= reset
