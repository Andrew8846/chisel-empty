circuit PipelinedRV32I :
  module IFBarrier :
    input clock : Clock
    input reset : Reset
    output io : { flip pcIn : UInt<32>, flip instrIn : UInt<32>, pcOut : UInt<32>, instrOut : UInt<32>}

    reg pcReg : UInt<32>, clock with :
      reset => (UInt<1>("h0"), pcReg) @[core.scala 331:18]
    reg instrReg : UInt<32>, clock with :
      reset => (UInt<1>("h0"), instrReg) @[core.scala 332:21]
    pcReg <= io.pcIn @[core.scala 334:9]
    instrReg <= io.instrIn @[core.scala 335:12]
    io.pcOut <= pcReg @[core.scala 337:12]
    io.instrOut <= instrReg @[core.scala 338:15]

  module IDBarrier :
    input clock : Clock
    input reset : Reset
    output io : { flip immediate : UInt<12>, flip uop : UInt<8>, flip rd : UInt<5>, flip rs1 : UInt<5>, flip rs2 : UInt<5>, immediateOut : UInt<12>, uopOut : UInt<8>, rdOut : UInt<5>, rs1out : UInt<5>, rs2out : UInt<5>}

    reg immReg : UInt<12>, clock with :
      reset => (UInt<1>("h0"), immReg) @[core.scala 362:19]
    reg opReg : UInt<8>, clock with :
      reset => (UInt<1>("h0"), opReg) @[core.scala 363:18]
    reg rdReg : UInt<5>, clock with :
      reset => (UInt<1>("h0"), rdReg) @[core.scala 364:18]
    reg rs1Reg : UInt<5>, clock with :
      reset => (UInt<1>("h0"), rs1Reg) @[core.scala 365:19]
    reg rs2Reg : UInt<5>, clock with :
      reset => (UInt<1>("h0"), rs2Reg) @[core.scala 366:19]
    immReg <= io.immediate @[core.scala 368:10]
    opReg <= io.uop @[core.scala 369:9]
    rdReg <= io.rd @[core.scala 370:9]
    rs1Reg <= io.rs1 @[core.scala 371:10]
    rs2Reg <= io.rs2 @[core.scala 372:10]
    io.immediateOut <= immReg @[core.scala 374:19]
    io.uopOut <= opReg @[core.scala 375:13]
    io.rdOut <= rdReg @[core.scala 376:12]
    io.rs1out <= rs1Reg @[core.scala 377:13]
    io.rs2out <= rs2Reg @[core.scala 378:13]

  module EXBarrier :
    input clock : Clock
    input reset : Reset
    output io : { flip result : UInt<32>, flip rd : UInt<5>, resOut : UInt<32>, rdOut : UInt<5>}

    reg resultReg : UInt<32>, clock with :
      reset => (UInt<1>("h0"), resultReg) @[core.scala 396:22]
    reg rdReg : UInt<5>, clock with :
      reset => (UInt<1>("h0"), rdReg) @[core.scala 397:18]
    resultReg <= io.result @[core.scala 399:13]
    rdReg <= io.rd @[core.scala 400:9]
    io.resOut <= resultReg @[core.scala 402:13]
    io.rdOut <= rdReg @[core.scala 403:12]

  module MEMBarrier :
    input clock : Clock
    input reset : Reset
    output io : { flip rdIn : UInt<5>, flip resultIn : UInt<32>, rdOut : UInt<5>, resultOut : UInt<32>}

    reg rdreg : UInt<5>, clock with :
      reset => (UInt<1>("h0"), rdreg) @[core.scala 421:18]
    reg resReg : UInt<32>, clock with :
      reset => (UInt<1>("h0"), resReg) @[core.scala 422:19]
    rdreg <= io.rdIn @[core.scala 424:9]
    resReg <= io.resultIn @[core.scala 425:10]
    io.rdOut <= rdreg @[core.scala 427:12]
    io.resultOut <= resReg @[core.scala 428:16]

  module IF :
    input clock : Clock
    input reset : Reset
    output io : { flip pc : UInt<32>, instr : UInt<32>, pcNew : UInt<32>}

    cmem IMem : UInt<32> [4096] @[core.scala 173:17]
    node _io_instr_T = dshr(io.pc, UInt<2>("h2")) @[core.scala 176:25]
    node _io_instr_T_1 = bits(_io_instr_T, 11, 0) @[core.scala 176:19]
    infer mport io_instr_MPORT = IMem[_io_instr_T_1], clock @[core.scala 176:19]
    io.instr <= io_instr_MPORT @[core.scala 176:12]
    node _io_pcNew_T = add(io.pc, UInt<3>("h4")) @[core.scala 178:21]
    node _io_pcNew_T_1 = tail(_io_pcNew_T, 1) @[core.scala 178:21]
    io.pcNew <= _io_pcNew_T_1 @[core.scala 178:12]

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
    io.rs1 <= rs1 @[core.scala 233:10]
    io.rs2 <= rs2 @[core.scala 234:10]
    io.immediate <= imm @[core.scala 235:16]
    io.rd <= rd @[core.scala 236:9]

  module EX :
    input clock : Clock
    input reset : Reset
    output io : { flip uop : UInt<8>, flip operandA : UInt<32>, flip operandB : UInt<32>, flip immediate : UInt<12>, result : UInt<32>}

    node _T = eq(io.uop, UInt<1>("h1")) @[core.scala 253:16]
    when _T : @[core.scala 253:27]
      node _io_result_T = add(io.operandA, io.operandB) @[core.scala 254:30]
      node _io_result_T_1 = tail(_io_result_T, 1) @[core.scala 254:30]
      io.result <= _io_result_T_1 @[core.scala 254:15]
    else :
      node _T_1 = eq(io.uop, UInt<2>("h2")) @[core.scala 255:21]
      when _T_1 : @[core.scala 255:32]
        node _io_result_T_2 = sub(io.operandA, io.operandB) @[core.scala 256:30]
        node _io_result_T_3 = tail(_io_result_T_2, 1) @[core.scala 256:30]
        io.result <= _io_result_T_3 @[core.scala 256:15]
      else :
        node _T_2 = eq(io.uop, UInt<3>("h5")) @[core.scala 257:21]
        when _T_2 : @[core.scala 257:32]
          node _io_result_T_4 = and(io.operandA, io.operandB) @[core.scala 258:30]
          io.result <= _io_result_T_4 @[core.scala 258:15]
        else :
          node _T_3 = eq(io.uop, UInt<3>("h4")) @[core.scala 259:21]
          when _T_3 : @[core.scala 259:31]
            node _io_result_T_5 = or(io.operandA, io.operandB) @[core.scala 260:30]
            io.result <= _io_result_T_5 @[core.scala 260:15]
          else :
            node _T_4 = eq(io.uop, UInt<2>("h3")) @[core.scala 261:21]
            when _T_4 : @[core.scala 261:32]
              node _io_result_T_6 = xor(io.operandA, io.operandB) @[core.scala 262:30]
              io.result <= _io_result_T_6 @[core.scala 262:15]
            else :
              node _T_5 = eq(io.uop, UInt<3>("h6")) @[core.scala 263:21]
              when _T_5 : @[core.scala 263:32]
                node _io_result_T_7 = bits(io.operandB, 4, 0) @[core.scala 264:44]
                node _io_result_T_8 = dshl(io.operandA, _io_result_T_7) @[core.scala 264:30]
                io.result <= _io_result_T_8 @[core.scala 264:15]
              else :
                node _T_6 = eq(io.uop, UInt<3>("h7")) @[core.scala 265:21]
                when _T_6 : @[core.scala 265:32]
                  node _io_result_T_9 = bits(io.operandB, 4, 0) @[core.scala 266:44]
                  node _io_result_T_10 = dshr(io.operandA, _io_result_T_9) @[core.scala 266:30]
                  io.result <= _io_result_T_10 @[core.scala 266:15]
                else :
                  node _T_7 = eq(io.uop, UInt<4>("h8")) @[core.scala 267:21]
                  when _T_7 : @[core.scala 267:32]
                    node _io_result_T_11 = asSInt(io.operandA) @[core.scala 268:31]
                    node _io_result_T_12 = bits(io.operandB, 4, 0) @[core.scala 268:52]
                    node _io_result_T_13 = dshr(_io_result_T_11, _io_result_T_12) @[core.scala 268:38]
                    node _io_result_T_14 = asUInt(_io_result_T_13) @[core.scala 268:60]
                    io.result <= _io_result_T_14 @[core.scala 268:15]
                  else :
                    node _T_8 = eq(io.uop, UInt<4>("ha")) @[core.scala 269:21]
                    when _T_8 : @[core.scala 269:33]
                      node _io_result_T_15 = lt(io.operandA, io.operandB) @[core.scala 270:35]
                      node _io_result_T_16 = mux(_io_result_T_15, UInt<1>("h1"), UInt<1>("h0")) @[core.scala 270:22]
                      io.result <= _io_result_T_16 @[core.scala 270:15]
                    else :
                      node _T_9 = eq(io.uop, UInt<2>("h2")) @[core.scala 271:21]
                      when _T_9 : @[core.scala 271:32]
                        node _io_result_T_17 = asSInt(io.operandA) @[core.scala 272:35]
                        node _io_result_T_18 = asSInt(io.operandB) @[core.scala 272:56]
                        node _io_result_T_19 = lt(_io_result_T_17, _io_result_T_18) @[core.scala 272:42]
                        node _io_result_T_20 = mux(_io_result_T_19, UInt<1>("h1"), UInt<1>("h0")) @[core.scala 272:22]
                        io.result <= _io_result_T_20 @[core.scala 272:15]
                      else :
                        node _T_10 = eq(io.uop, UInt<5>("h10")) @[core.scala 273:21]
                        when _T_10 : @[core.scala 273:33]
                          node _io_result_T_21 = add(io.operandA, io.immediate) @[core.scala 274:30]
                          node _io_result_T_22 = tail(_io_result_T_21, 1) @[core.scala 274:30]
                          io.result <= _io_result_T_22 @[core.scala 274:15]
                        else :
                          io.result <= UInt<32>("hffffffff") @[core.scala 276:15]

  module MEM :
    input clock : Clock
    input reset : Reset
    output io : { flip rd : UInt<5>, flip result : UInt<32>, rdO : UInt<5>, resultO : UInt<32>}

    io.rdO <= io.rd @[core.scala 293:10]
    io.resultO <= io.result @[core.scala 294:14]

  module WB :
    input clock : Clock
    input reset : Reset
    output io : { flip rd : UInt<5>, flip result : UInt<32>, wbToRegFile : { writeEn : UInt<1>, rd : UInt<5>, data : UInt<32>}, check_res : UInt<32>}

    io.wbToRegFile.writeEn <= UInt<1>("h1") @[core.scala 311:26]
    io.wbToRegFile.rd <= io.rd @[core.scala 312:21]
    io.wbToRegFile.data <= io.result @[core.scala 313:23]
    io.check_res <= io.result @[core.scala 314:16]

  module ForwardingUnit :
    input clock : Clock
    input reset : Reset
    output io : { flip idRs1 : UInt<5>, flip idRs2 : UInt<5>, flip exRd : UInt<5>, flip wbRd : UInt<5>, flip wbWriteEn : UInt<1>, forward : UInt<1>}

    node _hazard_T = neq(io.exRd, UInt<1>("h0")) @[core.scala 155:26]
    node _hazard_T_1 = eq(io.exRd, io.idRs1) @[core.scala 155:47]
    node _hazard_T_2 = eq(io.exRd, io.idRs2) @[core.scala 155:71]
    node _hazard_T_3 = or(_hazard_T_1, _hazard_T_2) @[core.scala 155:60]
    node _hazard_T_4 = and(_hazard_T, _hazard_T_3) @[core.scala 155:35]
    node _hazard_T_5 = neq(io.wbRd, UInt<1>("h0")) @[core.scala 156:31]
    node _hazard_T_6 = and(io.wbWriteEn, _hazard_T_5) @[core.scala 156:19]
    node _hazard_T_7 = eq(io.wbRd, io.idRs1) @[core.scala 156:52]
    node _hazard_T_8 = eq(io.wbRd, io.idRs2) @[core.scala 156:76]
    node _hazard_T_9 = or(_hazard_T_7, _hazard_T_8) @[core.scala 156:65]
    node _hazard_T_10 = and(_hazard_T_6, _hazard_T_9) @[core.scala 156:40]
    node hazard = or(_hazard_T_4, _hazard_T_10) @[core.scala 155:86]
    io.forward <= hazard @[core.scala 158:14]

  module regFile :
    input clock : Clock
    input reset : Reset
    output io : { flip req1 : { rs : UInt<5>}, flip req2 : { rs : UInt<5>}, resp1 : { data : UInt<32>}, resp2 : { data : UInt<32>}, flip write : { writeEn : UInt<1>, rd : UInt<5>, data : UInt<32>}}

    cmem regFile : UInt<32> [32] @[core.scala 127:20]
    infer mport MPORT = regFile[UInt<1>("h0")], clock @[core.scala 128:10]
    MPORT <= UInt<1>("h0") @[core.scala 128:14]
    infer mport io_resp1_data_MPORT = regFile[io.req1.rs], clock @[core.scala 129:27]
    io.resp1.data <= io_resp1_data_MPORT @[core.scala 129:17]
    infer mport io_resp2_data_MPORT = regFile[io.req2.rs], clock @[core.scala 130:27]
    io.resp2.data <= io_resp2_data_MPORT @[core.scala 130:17]
    when io.write.writeEn : @[core.scala 132:26]
      infer mport MPORT_1 = regFile[io.write.rd], clock @[core.scala 133:12]
      MPORT_1 <= io.write.data @[core.scala 133:26]

  module PipelinedRV32Icore :
    input clock : Clock
    input reset : Reset
    output io : { check_res : UInt<32>}

    inst ifBarrier of IFBarrier @[core.scala 464:25]
    ifBarrier.clock <= clock
    ifBarrier.reset <= reset
    inst idBarrier of IDBarrier @[core.scala 465:25]
    idBarrier.clock <= clock
    idBarrier.reset <= reset
    inst exBarrier of EXBarrier @[core.scala 466:25]
    exBarrier.clock <= clock
    exBarrier.reset <= reset
    inst memBarrier of MEMBarrier @[core.scala 467:26]
    memBarrier.clock <= clock
    memBarrier.reset <= reset
    inst IF of IF @[core.scala 471:18]
    IF.clock <= clock
    IF.reset <= reset
    inst ID of ID @[core.scala 472:18]
    ID.clock <= clock
    ID.reset <= reset
    inst EX of EX @[core.scala 473:18]
    EX.clock <= clock
    EX.reset <= reset
    inst MEM of MEM @[core.scala 474:19]
    MEM.clock <= clock
    MEM.reset <= reset
    inst WB of WB @[core.scala 475:18]
    WB.clock <= clock
    WB.reset <= reset
    inst fwUnit of ForwardingUnit @[core.scala 477:22]
    fwUnit.clock <= clock
    fwUnit.reset <= reset
    inst regFile of regFile @[core.scala 480:23]
    regFile.clock <= clock
    regFile.reset <= reset
    regFile.io.write.writeEn <= UInt<1>("h0") @[core.scala 481:28]
    io.check_res <= UInt<1>("h0") @[core.scala 483:16]
    reg pc : UInt<32>, clock with :
      reset => (reset, UInt<32>("h0")) @[core.scala 484:19]
    IF.io.pc <= pc @[core.scala 487:12]
    pc <= IF.io.pcNew @[core.scala 488:6]
    ifBarrier.io.pcIn <= IF.io.pcNew @[core.scala 489:21]
    ifBarrier.io.instrIn <= IF.io.instr @[core.scala 490:24]
    ID.io.instr <= ifBarrier.io.instrOut @[core.scala 493:15]
    idBarrier.io.rs1 <= ID.io.rs1 @[core.scala 496:20]
    idBarrier.io.rs2 <= ID.io.rs2 @[core.scala 497:20]
    idBarrier.io.immediate <= ID.io.immediate @[core.scala 499:26]
    idBarrier.io.rd <= ID.io.rd @[core.scala 500:19]
    idBarrier.io.uop <= ID.io.uop @[core.scala 501:20]
    regFile.io.req1.rs <= idBarrier.io.rs1out @[core.scala 504:22]
    regFile.io.req2.rs <= idBarrier.io.rs2out @[core.scala 505:22]
    fwUnit.io.idRs1 <= idBarrier.io.rs1out @[core.scala 507:23]
    fwUnit.io.idRs2 <= idBarrier.io.rs2out @[core.scala 508:23]
    fwUnit.io.exRd <= exBarrier.io.rdOut @[core.scala 509:23]
    fwUnit.io.wbRd <= WB.io.rd @[core.scala 510:23]
    fwUnit.io.wbWriteEn <= WB.io.wbToRegFile.writeEn @[core.scala 511:23]
    node forwardA = mux(fwUnit.io.forward, exBarrier.io.resOut, regFile.io.resp1.data) @[core.scala 514:21]
    node forwardB = mux(fwUnit.io.forward, exBarrier.io.resOut, regFile.io.resp2.data) @[core.scala 515:21]
    EX.io.uop <= idBarrier.io.uopOut @[core.scala 517:13]
    EX.io.operandA <= forwardA @[core.scala 518:18]
    EX.io.operandB <= forwardB @[core.scala 519:18]
    EX.io.immediate <= idBarrier.io.immediateOut @[core.scala 520:19]
    exBarrier.io.rd <= idBarrier.io.rdOut @[core.scala 521:19]
    exBarrier.io.result <= EX.io.result @[core.scala 522:23]
    MEM.io.rd <= exBarrier.io.rdOut @[core.scala 525:13]
    MEM.io.result <= exBarrier.io.resOut @[core.scala 526:17]
    memBarrier.io.resultIn <= MEM.io.resultO @[core.scala 527:26]
    memBarrier.io.rdIn <= MEM.io.rdO @[core.scala 528:22]
    WB.io.result <= memBarrier.io.resultOut @[core.scala 532:16]
    WB.io.rd <= memBarrier.io.rdOut @[core.scala 533:12]
    regFile.io.write.data <= WB.io.wbToRegFile.data @[core.scala 535:20]
    regFile.io.write.rd <= WB.io.wbToRegFile.rd @[core.scala 535:20]
    regFile.io.write.writeEn <= WB.io.wbToRegFile.writeEn @[core.scala 535:20]
    io.check_res <= WB.io.check_res @[core.scala 536:16]

  module PipelinedRV32I :
    input clock : Clock
    input reset : UInt<1>
    output io : { result : UInt<32>}

    inst core of PipelinedRV32Icore @[PipelinedRISCV32I.scala 20:20]
    core.clock <= clock
    core.reset <= reset
    io.result <= core.io.check_res @[PipelinedRISCV32I.scala 22:19]

