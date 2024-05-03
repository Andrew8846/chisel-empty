circuit MultiCycleRV32I :
  module MultiCycleRV32Icore :
    input clock : Clock
    input reset : Reset
    output io : { check_res : UInt<32>}

    reg stage : UInt<3>, clock with :
      reset => (reset, UInt<3>("h0")) @[core.scala 67:22]
    io.check_res <= UInt<32>("h0") @[core.scala 68:16]
    cmem IMem : UInt<32> [4096] @[core.scala 74:17]
    reg pc : UInt<32>, clock with :
      reset => (reset, UInt<32>("h0")) @[core.scala 81:19]
    cmem regFile : UInt<32> [32] @[core.scala 83:20]
    infer mport MPORT = regFile[UInt<1>("h0")], clock @[core.scala 84:10]
    MPORT <= UInt<1>("h0") @[core.scala 84:14]
    reg instr : UInt<32>, clock with :
      reset => (reset, UInt<32>("h0")) @[core.scala 93:22]
    reg isADD : UInt<1>, clock with :
      reset => (reset, UInt<1>("h0")) @[core.scala 94:22]
    reg isSUB : UInt<1>, clock with :
      reset => (reset, UInt<1>("h0")) @[core.scala 95:22]
    reg isSLL : UInt<1>, clock with :
      reset => (reset, UInt<1>("h0")) @[core.scala 96:22]
    reg isSRL : UInt<1>, clock with :
      reset => (reset, UInt<1>("h0")) @[core.scala 97:22]
    reg isSRA : UInt<1>, clock with :
      reset => (reset, UInt<1>("h0")) @[core.scala 98:22]
    reg isXOR : UInt<1>, clock with :
      reset => (reset, UInt<1>("h0")) @[core.scala 99:22]
    reg isOR : UInt<1>, clock with :
      reset => (reset, UInt<1>("h0")) @[core.scala 100:21]
    reg isAND : UInt<1>, clock with :
      reset => (reset, UInt<1>("h0")) @[core.scala 101:22]
    reg isADDI : UInt<1>, clock with :
      reset => (reset, UInt<1>("h0")) @[core.scala 102:23]
    wire opcode : UInt<7> @[core.scala 105:20]
    opcode <= UInt<7>("h0") @[core.scala 106:10]
    reg rd : UInt<5>, clock with :
      reset => (reset, UInt<5>("h0")) @[core.scala 107:23]
    wire funct3 : UInt<3> @[core.scala 108:20]
    funct3 <= UInt<3>("h0") @[core.scala 109:10]
    wire rs1 : UInt<5> @[core.scala 110:20]
    rs1 <= UInt<5>("h0") @[core.scala 111:7]
    wire rs2 : UInt<5> @[core.scala 112:20]
    rs2 <= UInt<5>("h0") @[core.scala 113:7]
    wire funct7 : UInt<7> @[core.scala 114:20]
    funct7 <= UInt<7>("h0") @[core.scala 115:10]
    reg imm : UInt<12>, clock with :
      reset => (reset, UInt<12>("h0")) @[core.scala 116:20]
    wire writeBackData : UInt<32> @[core.scala 117:27]
    writeBackData <= UInt<32>("h0") @[core.scala 118:17]
    reg operandA : UInt<32>, clock with :
      reset => (reset, UInt<32>("h0")) @[core.scala 120:25]
    reg operandB : UInt<32>, clock with :
      reset => (reset, UInt<32>("h0")) @[core.scala 121:25]
    reg aluResult : UInt<32>, clock with :
      reset => (reset, UInt<32>("h0")) @[core.scala 122:26]
    node _T = eq(stage, UInt<3>("h0")) @[core.scala 133:15]
    when _T : @[core.scala 134:3]
      node _instr_T = dshr(pc, UInt<2>("h2")) @[core.scala 136:21]
      node _instr_T_1 = bits(_instr_T, 11, 0) @[core.scala 136:18]
      infer mport instr_MPORT = IMem[_instr_T_1], clock @[core.scala 136:18]
      instr <= instr_MPORT @[core.scala 136:11]
      stage <= UInt<3>("h1") @[core.scala 137:11]
    else :
      node _T_1 = eq(stage, UInt<3>("h1")) @[core.scala 140:22]
      when _T_1 : @[core.scala 141:3]
        node _opcode_T = bits(instr, 6, 0) @[core.scala 142:20]
        opcode <= _opcode_T @[core.scala 142:12]
        node _rd_T = bits(instr, 11, 7) @[core.scala 143:20]
        rd <= _rd_T @[core.scala 143:12]
        node _funct3_T = bits(instr, 14, 12) @[core.scala 144:20]
        funct3 <= _funct3_T @[core.scala 144:12]
        node _rs1_T = bits(instr, 19, 15) @[core.scala 145:20]
        rs1 <= _rs1_T @[core.scala 145:12]
        node _rs2_T = bits(instr, 24, 20) @[core.scala 146:20]
        rs2 <= _rs2_T @[core.scala 146:12]
        node _funct7_T = bits(instr, 31, 25) @[core.scala 147:20]
        funct7 <= _funct7_T @[core.scala 147:12]
        node _imm_T = bits(instr, 31, 20) @[core.scala 148:17]
        imm <= _imm_T @[core.scala 148:9]
        node _isADD_T = eq(opcode, UInt<6>("h33")) @[core.scala 150:23]
        node _isADD_T_1 = eq(funct3, UInt<1>("h0")) @[core.scala 150:50]
        node _isADD_T_2 = and(_isADD_T, _isADD_T_1) @[core.scala 150:40]
        node _isADD_T_3 = eq(funct7, UInt<1>("h0")) @[core.scala 150:73]
        node _isADD_T_4 = and(_isADD_T_2, _isADD_T_3) @[core.scala 150:63]
        isADD <= _isADD_T_4 @[core.scala 150:12]
        node _isSUB_T = eq(opcode, UInt<6>("h33")) @[core.scala 151:23]
        node _isSUB_T_1 = eq(funct3, UInt<1>("h0")) @[core.scala 151:50]
        node _isSUB_T_2 = and(_isSUB_T, _isSUB_T_1) @[core.scala 151:40]
        node _isSUB_T_3 = eq(funct7, UInt<6>("h20")) @[core.scala 151:73]
        node _isSUB_T_4 = and(_isSUB_T_2, _isSUB_T_3) @[core.scala 151:63]
        isSUB <= _isSUB_T_4 @[core.scala 151:12]
        node _isSLL_T = eq(opcode, UInt<6>("h33")) @[core.scala 152:23]
        node _isSLL_T_1 = eq(funct3, UInt<1>("h1")) @[core.scala 152:50]
        node _isSLL_T_2 = and(_isSLL_T, _isSLL_T_1) @[core.scala 152:40]
        node _isSLL_T_3 = eq(funct7, UInt<1>("h0")) @[core.scala 152:73]
        node _isSLL_T_4 = and(_isSLL_T_2, _isSLL_T_3) @[core.scala 152:63]
        isSLL <= _isSLL_T_4 @[core.scala 152:12]
        node _isSRL_T = eq(opcode, UInt<6>("h33")) @[core.scala 153:23]
        node _isSRL_T_1 = eq(funct3, UInt<3>("h5")) @[core.scala 153:50]
        node _isSRL_T_2 = and(_isSRL_T, _isSRL_T_1) @[core.scala 153:40]
        node _isSRL_T_3 = eq(funct7, UInt<1>("h0")) @[core.scala 153:73]
        node _isSRL_T_4 = and(_isSRL_T_2, _isSRL_T_3) @[core.scala 153:63]
        isSRL <= _isSRL_T_4 @[core.scala 153:12]
        node _isSRA_T = eq(opcode, UInt<6>("h33")) @[core.scala 154:23]
        node _isSRA_T_1 = eq(funct3, UInt<3>("h5")) @[core.scala 154:50]
        node _isSRA_T_2 = and(_isSRA_T, _isSRA_T_1) @[core.scala 154:40]
        node _isSRA_T_3 = eq(funct7, UInt<6>("h20")) @[core.scala 154:73]
        node _isSRA_T_4 = and(_isSRA_T_2, _isSRA_T_3) @[core.scala 154:63]
        isSRA <= _isSRA_T_4 @[core.scala 154:12]
        node _isXOR_T = eq(opcode, UInt<6>("h33")) @[core.scala 155:23]
        node _isXOR_T_1 = eq(funct3, UInt<3>("h4")) @[core.scala 155:50]
        node _isXOR_T_2 = and(_isXOR_T, _isXOR_T_1) @[core.scala 155:40]
        node _isXOR_T_3 = eq(funct7, UInt<1>("h0")) @[core.scala 155:73]
        node _isXOR_T_4 = and(_isXOR_T_2, _isXOR_T_3) @[core.scala 155:63]
        isXOR <= _isXOR_T_4 @[core.scala 155:12]
        node _isOR_T = eq(opcode, UInt<6>("h33")) @[core.scala 156:23]
        node _isOR_T_1 = eq(funct3, UInt<3>("h6")) @[core.scala 156:50]
        node _isOR_T_2 = and(_isOR_T, _isOR_T_1) @[core.scala 156:40]
        node _isOR_T_3 = eq(funct7, UInt<1>("h0")) @[core.scala 156:73]
        node _isOR_T_4 = and(_isOR_T_2, _isOR_T_3) @[core.scala 156:63]
        isOR <= _isOR_T_4 @[core.scala 156:12]
        node _isAND_T = eq(opcode, UInt<6>("h33")) @[core.scala 157:23]
        node _isAND_T_1 = eq(funct3, UInt<3>("h7")) @[core.scala 157:50]
        node _isAND_T_2 = and(_isAND_T, _isAND_T_1) @[core.scala 157:40]
        node _isAND_T_3 = eq(funct7, UInt<1>("h0")) @[core.scala 157:73]
        node _isAND_T_4 = and(_isAND_T_2, _isAND_T_3) @[core.scala 157:63]
        isAND <= _isAND_T_4 @[core.scala 157:12]
        node _isADDI_T = eq(opcode, UInt<5>("h13")) @[core.scala 159:23]
        node _isADDI_T_1 = eq(funct3, UInt<1>("h0")) @[core.scala 159:50]
        node _isADDI_T_2 = and(_isADDI_T, _isADDI_T_1) @[core.scala 159:40]
        isADDI <= _isADDI_T_2 @[core.scala 159:12]
        infer mport operandA_MPORT = regFile[rs1], clock @[core.scala 161:24]
        operandA <= operandA_MPORT @[core.scala 161:14]
        infer mport operandB_MPORT = regFile[rs2], clock @[core.scala 162:24]
        operandB <= operandB_MPORT @[core.scala 162:14]
        stage <= UInt<3>("h2") @[core.scala 164:11]
      else :
        node _T_2 = eq(stage, UInt<3>("h2")) @[core.scala 167:22]
        when _T_2 : @[core.scala 168:3]
          when isADDI : @[core.scala 170:18]
            node _aluResult_T = add(operandA, imm) @[core.scala 171:29]
            node _aluResult_T_1 = tail(_aluResult_T, 1) @[core.scala 171:29]
            aluResult <= _aluResult_T_1 @[core.scala 171:17]
          else :
            when isADD : @[core.scala 172:23]
              node _aluResult_T_2 = add(operandA, operandB) @[core.scala 173:29]
              node _aluResult_T_3 = tail(_aluResult_T_2, 1) @[core.scala 173:29]
              aluResult <= _aluResult_T_3 @[core.scala 173:17]
            else :
              when isSUB : @[core.scala 174:23]
                node _aluResult_T_4 = sub(operandA, operandB) @[core.scala 175:29]
                node _aluResult_T_5 = tail(_aluResult_T_4, 1) @[core.scala 175:29]
                aluResult <= _aluResult_T_5 @[core.scala 175:17]
              else :
                when isAND : @[core.scala 176:23]
                  node _aluResult_T_6 = and(operandA, operandB) @[core.scala 177:29]
                  aluResult <= _aluResult_T_6 @[core.scala 177:17]
                else :
                  when isOR : @[core.scala 178:22]
                    node _aluResult_T_7 = or(operandA, operandB) @[core.scala 179:29]
                    aluResult <= _aluResult_T_7 @[core.scala 179:17]
                  else :
                    when isXOR : @[core.scala 180:22]
                      node _aluResult_T_8 = xor(operandA, operandB) @[core.scala 181:29]
                      aluResult <= _aluResult_T_8 @[core.scala 181:17]
                    else :
                      when isSLL : @[core.scala 182:23]
                        node _aluResult_T_9 = bits(operandB, 4, 0) @[core.scala 183:40]
                        node _aluResult_T_10 = dshl(operandA, _aluResult_T_9) @[core.scala 183:29]
                        aluResult <= _aluResult_T_10 @[core.scala 183:17]
                      else :
                        when isSRL : @[core.scala 184:23]
                          node _aluResult_T_11 = bits(operandB, 4, 0) @[core.scala 185:40]
                          node _aluResult_T_12 = dshr(operandA, _aluResult_T_11) @[core.scala 185:29]
                          aluResult <= _aluResult_T_12 @[core.scala 185:17]
                        else :
                          when isSRA : @[core.scala 186:23]
                            node _aluResult_T_13 = asSInt(operandA) @[core.scala 187:30]
                            node _aluResult_T_14 = bits(operandB, 4, 0) @[core.scala 187:48]
                            node _aluResult_T_15 = dshr(_aluResult_T_13, _aluResult_T_14) @[core.scala 187:37]
                            node _aluResult_T_16 = asUInt(_aluResult_T_15) @[core.scala 187:56]
                            aluResult <= _aluResult_T_16 @[core.scala 187:17]
                          else :
                            aluResult <= UInt<10>("h29a") @[core.scala 189:17]
          stage <= UInt<3>("h3") @[core.scala 193:11]
        else :
          node _T_3 = eq(stage, UInt<3>("h3")) @[core.scala 196:22]
          when _T_3 : @[core.scala 197:3]
            stage <= UInt<3>("h4") @[core.scala 205:11]
          else :
            node _T_4 = eq(stage, UInt<3>("h4")) @[core.scala 208:22]
            when _T_4 : @[core.scala 209:3]
              writeBackData <= aluResult @[core.scala 211:19]
              infer mport MPORT_1 = regFile[rd], clock @[core.scala 213:12]
              MPORT_1 <= writeBackData @[core.scala 213:17]
              io.check_res <= writeBackData @[core.scala 216:18]
              node _pc_T = add(pc, UInt<3>("h4")) @[core.scala 220:14]
              node _pc_T_1 = tail(_pc_T, 1) @[core.scala 220:14]
              pc <= _pc_T_1 @[core.scala 220:8]
            else :
              node _T_5 = asUInt(reset) @[core.scala 228:12]
              node _T_6 = eq(_T_5, UInt<1>("h0")) @[core.scala 228:12]
              when _T_6 : @[core.scala 228:12]
                assert(clock, UInt<1>("h1"), UInt<1>("h1"), "") : assert @[core.scala 228:12]
                node _T_7 = eq(UInt<1>("h1"), UInt<1>("h0")) @[core.scala 228:12]
                when _T_7 : @[core.scala 228:12]
                  printf(clock, UInt<1>("h1"), "Assertion failed: Pipeline FSM must never be left\n    at core.scala:228 assert(true.B, \"Pipeline FSM must never be left\")\n") : printf @[core.scala 228:12]

  module MultiCycleRV32I :
    input clock : Clock
    input reset : UInt<1>
    output io : { result : UInt<32>}

    inst core of MultiCycleRV32Icore @[MultiCycleRISCV32I.scala 20:20]
    core.clock <= clock
    core.reset <= reset
    io.result <= core.io.check_res @[MultiCycleRISCV32I.scala 22:19]

