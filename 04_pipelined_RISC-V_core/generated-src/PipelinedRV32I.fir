circuit PipelinedRV32I :
  module IFBarrier :
    input clock : Clock
    input reset : Reset
    output io : { flip pcIn : UInt<32>, flip instrIn : UInt<32>, pcOut : UInt<32>, instrOut : UInt<32>}

    reg pcReg : UInt<32>, clock with :
      reset => (UInt<1>("h0"), pcReg) @[core.scala 337:18]
    reg instrReg : UInt<32>, clock with :
      reset => (UInt<1>("h0"), instrReg) @[core.scala 338:21]
    pcReg <= io.pcIn @[core.scala 340:9]
    instrReg <= io.instrIn @[core.scala 341:12]
    io.pcOut <= pcReg @[core.scala 343:12]
    io.instrOut <= instrReg @[core.scala 344:15]

  module IDBarrier :
    input clock : Clock
    input reset : Reset
    output io : { flip operandA : UInt<32>, flip operandB : UInt<32>, flip immediate : UInt<12>, flip uop : UInt<8>, flip rd : UInt<5>, operandAOut : UInt<32>, operandBOut : UInt<32>, immediateOut : UInt<12>, uopOut : UInt<8>, rdOut : UInt<5>}

    reg aReg : UInt<32>, clock with :
      reset => (UInt<1>("h0"), aReg) @[core.scala 368:17]
    reg bReg : UInt<32>, clock with :
      reset => (UInt<1>("h0"), bReg) @[core.scala 369:17]
    reg immReg : UInt<12>, clock with :
      reset => (UInt<1>("h0"), immReg) @[core.scala 370:19]
    reg opReg : UInt<8>, clock with :
      reset => (UInt<1>("h0"), opReg) @[core.scala 371:18]
    reg rdReg : UInt<5>, clock with :
      reset => (UInt<1>("h0"), rdReg) @[core.scala 372:18]
    aReg <= io.operandA @[core.scala 374:8]
    bReg <= io.operandB @[core.scala 375:8]
    immReg <= io.immediate @[core.scala 376:10]
    opReg <= io.uop @[core.scala 377:9]
    rdReg <= io.rd @[core.scala 378:9]
    io.operandAOut <= aReg @[core.scala 380:18]
    io.operandBOut <= bReg @[core.scala 381:18]
    io.immediateOut <= immReg @[core.scala 382:19]
    io.uopOut <= opReg @[core.scala 383:13]
    io.rdOut <= rdReg @[core.scala 384:12]

  module EXBarrier :
    input clock : Clock
    input reset : Reset
    output io : { flip result : UInt<32>, flip rd : UInt<5>, resOut : UInt<32>, rdOut : UInt<5>}

    reg resultReg : UInt<32>, clock with :
      reset => (UInt<1>("h0"), resultReg) @[core.scala 402:22]
    reg rdReg : UInt<5>, clock with :
      reset => (UInt<1>("h0"), rdReg) @[core.scala 403:18]
    resultReg <= io.result @[core.scala 405:13]
    rdReg <= io.rd @[core.scala 406:9]
    io.resOut <= resultReg @[core.scala 408:13]
    io.rdOut <= rdReg @[core.scala 409:12]

  module IF :
    input clock : Clock
    input reset : Reset
    output io : { flip pc : UInt<32>, instr : UInt<32>, pcNew : UInt<32>}

    cmem IMem : UInt<32> [4096] @[core.scala 170:17]
    node _io_instr_T = dshr(io.pc, UInt<2>("h2")) @[core.scala 173:25]
    node _io_instr_T_1 = bits(_io_instr_T, 11, 0) @[core.scala 173:19]
    infer mport io_instr_MPORT = IMem[_io_instr_T_1], clock @[core.scala 173:19]
    io.instr <= io_instr_MPORT @[core.scala 173:12]
    node _io_pcNew_T = add(io.pc, UInt<3>("h4")) @[core.scala 175:21]
    node _io_pcNew_T_1 = tail(_io_pcNew_T, 1) @[core.scala 175:21]
    io.pcNew <= _io_pcNew_T_1 @[core.scala 175:12]

  module ID :
    input clock : Clock
    input reset : Reset
    output io : { flip instr : UInt<32>, immediate : UInt<12>, uop : UInt<8>, rs1 : UInt<5>, rs2 : UInt<5>, rd : UInt<5>}

    node opcode = bits(io.instr, 6, 0) @[core.scala 196:24]
    node rd = bits(io.instr, 11, 7) @[core.scala 197:24]
    node funct3 = bits(io.instr, 14, 12) @[core.scala 198:24]
    node rs1 = bits(io.instr, 19, 15) @[core.scala 199:24]
    node rs2 = bits(io.instr, 24, 20) @[core.scala 200:24]
    node funct7 = bits(io.instr, 31, 25) @[core.scala 201:24]
    node imm = bits(io.instr, 31, 20) @[core.scala 202:21]
    io.uop <= UInt<8>("hff") @[core.scala 204:10]
    node _T = eq(opcode, UInt<6>("h33")) @[core.scala 205:15]
    node _T_1 = eq(funct3, UInt<1>("h0")) @[core.scala 205:42]
    node _T_2 = and(_T, _T_1) @[core.scala 205:32]
    node _T_3 = eq(funct7, UInt<1>("h0")) @[core.scala 205:65]
    node _T_4 = and(_T_2, _T_3) @[core.scala 205:55]
    when _T_4 : @[core.scala 205:83]
      io.uop <= UInt<1>("h1") @[core.scala 206:12]
    else :
      node _T_5 = eq(opcode, UInt<6>("h33")) @[core.scala 207:21]
      node _T_6 = eq(funct3, UInt<1>("h0")) @[core.scala 207:48]
      node _T_7 = and(_T_5, _T_6) @[core.scala 207:38]
      node _T_8 = eq(funct7, UInt<6>("h20")) @[core.scala 207:71]
      node _T_9 = and(_T_7, _T_8) @[core.scala 207:61]
      when _T_9 : @[core.scala 207:89]
        io.uop <= UInt<2>("h2") @[core.scala 208:12]
      else :
        node _T_10 = eq(opcode, UInt<6>("h33")) @[core.scala 209:21]
        node _T_11 = eq(funct3, UInt<1>("h1")) @[core.scala 209:48]
        node _T_12 = and(_T_10, _T_11) @[core.scala 209:38]
        node _T_13 = eq(funct7, UInt<1>("h0")) @[core.scala 209:71]
        node _T_14 = and(_T_12, _T_13) @[core.scala 209:61]
        when _T_14 : @[core.scala 209:89]
          io.uop <= UInt<3>("h6") @[core.scala 210:12]
        else :
          node _T_15 = eq(opcode, UInt<6>("h33")) @[core.scala 211:21]
          node _T_16 = eq(funct3, UInt<3>("h5")) @[core.scala 211:48]
          node _T_17 = and(_T_15, _T_16) @[core.scala 211:38]
          node _T_18 = eq(funct7, UInt<1>("h0")) @[core.scala 211:71]
          node _T_19 = and(_T_17, _T_18) @[core.scala 211:61]
          when _T_19 : @[core.scala 211:89]
            io.uop <= UInt<3>("h7") @[core.scala 212:12]
          else :
            node _T_20 = eq(opcode, UInt<6>("h33")) @[core.scala 213:21]
            node _T_21 = eq(funct3, UInt<3>("h5")) @[core.scala 213:48]
            node _T_22 = and(_T_20, _T_21) @[core.scala 213:38]
            node _T_23 = eq(funct7, UInt<6>("h20")) @[core.scala 213:71]
            node _T_24 = and(_T_22, _T_23) @[core.scala 213:61]
            when _T_24 : @[core.scala 213:89]
              io.uop <= UInt<4>("h8") @[core.scala 214:12]
            else :
              node _T_25 = eq(opcode, UInt<6>("h33")) @[core.scala 215:21]
              node _T_26 = eq(funct3, UInt<3>("h4")) @[core.scala 215:48]
              node _T_27 = and(_T_25, _T_26) @[core.scala 215:38]
              node _T_28 = eq(funct7, UInt<1>("h0")) @[core.scala 215:71]
              node _T_29 = and(_T_27, _T_28) @[core.scala 215:61]
              when _T_29 : @[core.scala 215:89]
                io.uop <= UInt<2>("h3") @[core.scala 216:12]
              else :
                node _T_30 = eq(opcode, UInt<6>("h33")) @[core.scala 217:21]
                node _T_31 = eq(funct3, UInt<3>("h6")) @[core.scala 217:48]
                node _T_32 = and(_T_30, _T_31) @[core.scala 217:38]
                node _T_33 = eq(funct7, UInt<1>("h0")) @[core.scala 217:71]
                node _T_34 = and(_T_32, _T_33) @[core.scala 217:61]
                when _T_34 : @[core.scala 217:89]
                  io.uop <= UInt<3>("h4") @[core.scala 218:12]
                else :
                  node _T_35 = eq(opcode, UInt<6>("h33")) @[core.scala 219:21]
                  node _T_36 = eq(funct3, UInt<3>("h7")) @[core.scala 219:48]
                  node _T_37 = and(_T_35, _T_36) @[core.scala 219:38]
                  node _T_38 = eq(funct7, UInt<1>("h0")) @[core.scala 219:71]
                  node _T_39 = and(_T_37, _T_38) @[core.scala 219:61]
                  when _T_39 : @[core.scala 219:89]
                    io.uop <= UInt<1>("h1") @[core.scala 220:12]
                  else :
                    node _T_40 = eq(opcode, UInt<6>("h33")) @[core.scala 221:21]
                    node _T_41 = eq(funct3, UInt<2>("h2")) @[core.scala 221:48]
                    node _T_42 = and(_T_40, _T_41) @[core.scala 221:38]
                    node _T_43 = eq(funct7, UInt<1>("h0")) @[core.scala 221:71]
                    node _T_44 = and(_T_42, _T_43) @[core.scala 221:61]
                    when _T_44 : @[core.scala 221:89]
                      io.uop <= UInt<4>("h9") @[core.scala 222:12]
                    else :
                      node _T_45 = eq(opcode, UInt<6>("h33")) @[core.scala 223:21]
                      node _T_46 = eq(funct3, UInt<2>("h3")) @[core.scala 223:48]
                      node _T_47 = and(_T_45, _T_46) @[core.scala 223:38]
                      node _T_48 = eq(funct7, UInt<1>("h0")) @[core.scala 223:71]
                      node _T_49 = and(_T_47, _T_48) @[core.scala 223:61]
                      when _T_49 : @[core.scala 223:89]
                        io.uop <= UInt<4>("ha") @[core.scala 224:12]
                      else :
                        node _T_50 = eq(opcode, UInt<5>("h13")) @[core.scala 225:21]
                        node _T_51 = eq(funct3, UInt<1>("h0")) @[core.scala 225:48]
                        node _T_52 = and(_T_50, _T_51) @[core.scala 225:38]
                        when _T_52 : @[core.scala 225:62]
                          io.uop <= UInt<5>("h10") @[core.scala 226:12]
                        else :
                          io.uop <= UInt<8>("hff") @[core.scala 228:12]
    io.rs1 <= rs1 @[core.scala 243:10]
    io.rs2 <= rs2 @[core.scala 244:10]
    io.immediate <= imm @[core.scala 245:16]
    io.rd <= rd @[core.scala 246:9]

  module EX :
    input clock : Clock
    input reset : Reset
    output io : { flip uop : UInt<8>, flip operandA : UInt<32>, flip operandB : UInt<32>, flip immediate : UInt<12>, result : UInt<32>}

    node _T = eq(io.uop, UInt<1>("h1")) @[core.scala 263:16]
    when _T : @[core.scala 263:27]
      node _io_result_T = add(io.operandA, io.operandB) @[core.scala 264:30]
      node _io_result_T_1 = tail(_io_result_T, 1) @[core.scala 264:30]
      io.result <= _io_result_T_1 @[core.scala 264:15]
    else :
      node _T_1 = eq(io.uop, UInt<2>("h2")) @[core.scala 265:21]
      when _T_1 : @[core.scala 265:32]
        node _io_result_T_2 = sub(io.operandA, io.operandB) @[core.scala 266:30]
        node _io_result_T_3 = tail(_io_result_T_2, 1) @[core.scala 266:30]
        io.result <= _io_result_T_3 @[core.scala 266:15]
      else :
        node _T_2 = eq(io.uop, UInt<3>("h5")) @[core.scala 267:21]
        when _T_2 : @[core.scala 267:32]
          node _io_result_T_4 = and(io.operandA, io.operandB) @[core.scala 268:30]
          io.result <= _io_result_T_4 @[core.scala 268:15]
        else :
          node _T_3 = eq(io.uop, UInt<3>("h4")) @[core.scala 269:21]
          when _T_3 : @[core.scala 269:31]
            node _io_result_T_5 = or(io.operandA, io.operandB) @[core.scala 270:30]
            io.result <= _io_result_T_5 @[core.scala 270:15]
          else :
            node _T_4 = eq(io.uop, UInt<2>("h3")) @[core.scala 271:21]
            when _T_4 : @[core.scala 271:32]
              node _io_result_T_6 = xor(io.operandA, io.operandB) @[core.scala 272:30]
              io.result <= _io_result_T_6 @[core.scala 272:15]
            else :
              node _T_5 = eq(io.uop, UInt<3>("h6")) @[core.scala 273:21]
              when _T_5 : @[core.scala 273:32]
                node _io_result_T_7 = bits(io.operandB, 4, 0) @[core.scala 274:44]
                node _io_result_T_8 = dshl(io.operandA, _io_result_T_7) @[core.scala 274:30]
                io.result <= _io_result_T_8 @[core.scala 274:15]
              else :
                node _T_6 = eq(io.uop, UInt<3>("h7")) @[core.scala 275:21]
                when _T_6 : @[core.scala 275:32]
                  node _io_result_T_9 = bits(io.operandB, 4, 0) @[core.scala 276:44]
                  node _io_result_T_10 = dshr(io.operandA, _io_result_T_9) @[core.scala 276:30]
                  io.result <= _io_result_T_10 @[core.scala 276:15]
                else :
                  node _T_7 = eq(io.uop, UInt<4>("h8")) @[core.scala 277:21]
                  when _T_7 : @[core.scala 277:32]
                    node _io_result_T_11 = asSInt(io.operandA) @[core.scala 278:31]
                    node _io_result_T_12 = bits(io.operandB, 4, 0) @[core.scala 278:52]
                    node _io_result_T_13 = dshr(_io_result_T_11, _io_result_T_12) @[core.scala 278:38]
                    node _io_result_T_14 = asUInt(_io_result_T_13) @[core.scala 278:60]
                    io.result <= _io_result_T_14 @[core.scala 278:15]
                  else :
                    node _T_8 = eq(io.uop, UInt<4>("ha")) @[core.scala 279:21]
                    when _T_8 : @[core.scala 279:33]
                      node _io_result_T_15 = lt(io.operandA, io.operandB) @[core.scala 280:35]
                      node _io_result_T_16 = mux(_io_result_T_15, UInt<1>("h1"), UInt<1>("h0")) @[core.scala 280:22]
                      io.result <= _io_result_T_16 @[core.scala 280:15]
                    else :
                      node _T_9 = eq(io.uop, UInt<2>("h2")) @[core.scala 281:21]
                      when _T_9 : @[core.scala 281:32]
                        node _io_result_T_17 = asSInt(io.operandA) @[core.scala 282:35]
                        node _io_result_T_18 = asSInt(io.operandB) @[core.scala 282:56]
                        node _io_result_T_19 = lt(_io_result_T_17, _io_result_T_18) @[core.scala 282:42]
                        node _io_result_T_20 = mux(_io_result_T_19, UInt<1>("h1"), UInt<1>("h0")) @[core.scala 282:22]
                        io.result <= _io_result_T_20 @[core.scala 282:15]
                      else :
                        node _T_10 = eq(io.uop, UInt<5>("h10")) @[core.scala 283:21]
                        when _T_10 : @[core.scala 283:33]
                          node _io_result_T_21 = add(io.operandA, io.immediate) @[core.scala 284:30]
                          node _io_result_T_22 = tail(_io_result_T_21, 1) @[core.scala 284:30]
                          io.result <= _io_result_T_22 @[core.scala 284:15]
                        else :
                          io.result <= UInt<32>("hffffffff") @[core.scala 286:15]

  module MEM :
    input clock : Clock
    input reset : Reset
    output io : { }

    skip

  module WB :
    input clock : Clock
    input reset : Reset
    output io : { flip rd : UInt<5>, flip result : UInt<32>, wbToRegFile : { writeEn : UInt<1>, rd : UInt<5>, data : UInt<32>}, check_res : UInt<32>}

    io.wbToRegFile.writeEn <= UInt<1>("h1") @[core.scala 317:26]
    io.wbToRegFile.rd <= io.rd @[core.scala 318:21]
    io.wbToRegFile.data <= io.result @[core.scala 319:23]
    io.check_res <= io.result @[core.scala 320:16]

  module regFile :
    input clock : Clock
    input reset : Reset
    output io : { flip req1 : { rs : UInt<5>}, flip req2 : { rs : UInt<5>}, resp1 : { data : UInt<32>}, resp2 : { data : UInt<32>}, flip write : { writeEn : UInt<1>, rd : UInt<5>, data : UInt<32>}}

    cmem regFile : UInt<32> [32] @[core.scala 146:20]
    infer mport MPORT = regFile[UInt<1>("h0")], clock @[core.scala 147:10]
    MPORT <= UInt<1>("h0") @[core.scala 147:14]
    infer mport io_resp1_data_MPORT = regFile[io.req1.rs], clock @[core.scala 150:27]
    io.resp1.data <= io_resp1_data_MPORT @[core.scala 150:17]
    infer mport io_resp2_data_MPORT = regFile[io.req2.rs], clock @[core.scala 151:27]
    io.resp2.data <= io_resp2_data_MPORT @[core.scala 151:17]
    when io.write.writeEn : @[core.scala 153:26]
      infer mport MPORT_1 = regFile[io.write.rd], clock @[core.scala 154:12]
      MPORT_1 <= io.write.data @[core.scala 154:26]

  module PipelinedRV32Icore :
    input clock : Clock
    input reset : Reset
    output io : { check_res : UInt<32>}

    inst ifBarrier of IFBarrier @[core.scala 456:25]
    ifBarrier.clock <= clock
    ifBarrier.reset <= reset
    inst idBarrier of IDBarrier @[core.scala 457:25]
    idBarrier.clock <= clock
    idBarrier.reset <= reset
    inst exBarrier of EXBarrier @[core.scala 458:25]
    exBarrier.clock <= clock
    exBarrier.reset <= reset
    inst IF of IF @[core.scala 461:18]
    IF.clock <= clock
    IF.reset <= reset
    inst ID of ID @[core.scala 462:18]
    ID.clock <= clock
    ID.reset <= reset
    inst EX of EX @[core.scala 463:18]
    EX.clock <= clock
    EX.reset <= reset
    inst MEM of MEM @[core.scala 464:19]
    MEM.clock <= clock
    MEM.reset <= reset
    inst WB of WB @[core.scala 465:18]
    WB.clock <= clock
    WB.reset <= reset
    inst regFile of regFile @[core.scala 468:23]
    regFile.clock <= clock
    regFile.reset <= reset
    regFile.io.write.writeEn <= UInt<1>("h0") @[core.scala 469:28]
    io.check_res <= UInt<1>("h0") @[core.scala 471:16]
    reg pc : UInt<32>, clock with :
      reset => (reset, UInt<32>("h0")) @[core.scala 472:19]
    IF.io.pc <= pc @[core.scala 475:12]
    pc <= IF.io.pcNew @[core.scala 476:6]
    ifBarrier.io.pcIn <= IF.io.pcNew @[core.scala 477:21]
    ifBarrier.io.instrIn <= IF.io.instr @[core.scala 478:24]
    ID.io.instr <= ifBarrier.io.instrOut @[core.scala 481:15]
    regFile.io.req1.rs <= ID.io.rs1 @[core.scala 484:22]
    regFile.io.req2.rs <= ID.io.rs2 @[core.scala 485:22]
    idBarrier.io.operandA <= regFile.io.resp1.data @[core.scala 486:25]
    idBarrier.io.operandB <= regFile.io.resp2.data @[core.scala 487:25]
    idBarrier.io.immediate <= ID.io.immediate @[core.scala 488:26]
    idBarrier.io.rd <= ID.io.rd @[core.scala 489:19]
    idBarrier.io.uop <= ID.io.uop @[core.scala 490:20]
    EX.io.uop <= idBarrier.io.uopOut @[core.scala 493:13]
    EX.io.operandA <= idBarrier.io.operandAOut @[core.scala 494:18]
    EX.io.operandB <= idBarrier.io.operandBOut @[core.scala 495:18]
    EX.io.immediate <= idBarrier.io.immediateOut @[core.scala 496:19]
    exBarrier.io.rd <= idBarrier.io.rdOut @[core.scala 497:19]
    exBarrier.io.result <= EX.io.result @[core.scala 498:23]
    WB.io.result <= exBarrier.io.resOut @[core.scala 502:16]
    WB.io.rd <= exBarrier.io.rdOut @[core.scala 503:12]
    io.check_res <= WB.io.check_res @[core.scala 504:16]
    regFile.io.write.data <= WB.io.wbToRegFile.data @[core.scala 505:20]
    regFile.io.write.rd <= WB.io.wbToRegFile.rd @[core.scala 505:20]
    regFile.io.write.writeEn <= WB.io.wbToRegFile.writeEn @[core.scala 505:20]

  module PipelinedRV32I :
    input clock : Clock
    input reset : UInt<1>
    output io : { result : UInt<32>}

    inst core of PipelinedRV32Icore @[PipelinedRISCV32I.scala 20:20]
    core.clock <= clock
    core.reset <= reset
    io.result <= core.io.check_res @[PipelinedRISCV32I.scala 22:19]

