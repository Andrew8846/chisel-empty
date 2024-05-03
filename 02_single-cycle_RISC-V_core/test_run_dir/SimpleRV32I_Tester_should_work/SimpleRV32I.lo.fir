circuit SimpleRV32I :
  module RV32Icore :
    input clock : Clock
    input reset : UInt<1>
    output io_check_res : UInt<32>

    mem IMem : @[core.scala 66:17]
      data-type => UInt<32>
      depth => 4096
      read-latency => 0
      write-latency => 1
      reader => instr_MPORT
      read-under-write => undefined
    mem regFile : @[core.scala 75:20]
      data-type => UInt<32>
      depth => 32
      read-latency => 0
      write-latency => 1
      reader => operandA
      reader => operandB
      writer => MPORT
      writer => MPORT_1
      read-under-write => undefined
    reg pc : UInt<32>, clock with :
      reset => (UInt<1>("h0"), pc) @[core.scala 73:19]
    node _instr_T = dshr(pc, UInt<2>("h2")) @[core.scala 85:19]
    node _instr_T_1 = bits(_instr_T, 11, 0) @[core.scala 85:16]
    node instr = IMem.instr_MPORT.data @[core.scala 84:20 85:9]
    node opcode = bits(instr, 6, 0) @[core.scala 91:21]
    node rd = bits(instr, 11, 7) @[core.scala 92:21]
    node funct3 = bits(instr, 14, 12) @[core.scala 93:21]
    node rs1 = bits(instr, 19, 15) @[core.scala 94:21]
    node rs2 = bits(instr, 24, 20) @[core.scala 95:21]
    node funct7 = bits(instr, 31, 25) @[core.scala 96:21]
    node imm = bits(instr, 31, 20) @[core.scala 97:18]
    node _isADD_T = eq(opcode, UInt<6>("h33")) @[core.scala 100:24]
    node _isADD_T_1 = eq(funct3, UInt<1>("h0")) @[core.scala 100:51]
    node _isADD_T_2 = and(_isADD_T, _isADD_T_1) @[core.scala 100:41]
    node _isADD_T_3 = eq(funct7, UInt<1>("h0")) @[core.scala 100:74]
    node isADD = and(_isADD_T_2, _isADD_T_3) @[core.scala 100:64]
    node _isSUB_T = eq(opcode, UInt<6>("h33")) @[core.scala 101:24]
    node _isSUB_T_1 = eq(funct3, UInt<1>("h0")) @[core.scala 101:51]
    node _isSUB_T_2 = and(_isSUB_T, _isSUB_T_1) @[core.scala 101:41]
    node _isSUB_T_3 = eq(funct7, UInt<6>("h20")) @[core.scala 101:74]
    node isSUB = and(_isSUB_T_2, _isSUB_T_3) @[core.scala 101:64]
    node _isSLL_T = eq(opcode, UInt<6>("h33")) @[core.scala 102:24]
    node _isSLL_T_1 = eq(funct3, UInt<1>("h1")) @[core.scala 102:51]
    node _isSLL_T_2 = and(_isSLL_T, _isSLL_T_1) @[core.scala 102:41]
    node _isSLL_T_3 = eq(funct7, UInt<1>("h0")) @[core.scala 102:74]
    node isSLL = and(_isSLL_T_2, _isSLL_T_3) @[core.scala 102:64]
    node _isSLT_T = eq(opcode, UInt<6>("h33")) @[core.scala 103:24]
    node _isSLT_T_1 = eq(funct3, UInt<2>("h2")) @[core.scala 103:51]
    node _isSLT_T_2 = and(_isSLT_T, _isSLT_T_1) @[core.scala 103:41]
    node _isSLT_T_3 = eq(funct7, UInt<1>("h0")) @[core.scala 103:74]
    node isSLT = and(_isSLT_T_2, _isSLT_T_3) @[core.scala 103:64]
    node _isSRL_T = eq(opcode, UInt<6>("h33")) @[core.scala 104:24]
    node _isSRL_T_1 = eq(funct3, UInt<3>("h5")) @[core.scala 104:51]
    node _isSRL_T_2 = and(_isSRL_T, _isSRL_T_1) @[core.scala 104:41]
    node _isSRL_T_3 = eq(funct7, UInt<1>("h0")) @[core.scala 104:74]
    node isSRL = and(_isSRL_T_2, _isSRL_T_3) @[core.scala 104:64]
    node _isSRA_T = eq(opcode, UInt<6>("h33")) @[core.scala 105:24]
    node _isSRA_T_1 = eq(funct3, UInt<3>("h5")) @[core.scala 105:51]
    node _isSRA_T_2 = and(_isSRA_T, _isSRA_T_1) @[core.scala 105:41]
    node _isSRA_T_3 = eq(funct7, UInt<6>("h20")) @[core.scala 105:74]
    node isSRA = and(_isSRA_T_2, _isSRA_T_3) @[core.scala 105:64]
    node _isXOR_T = eq(opcode, UInt<6>("h33")) @[core.scala 106:24]
    node _isXOR_T_1 = eq(funct3, UInt<3>("h4")) @[core.scala 106:51]
    node _isXOR_T_2 = and(_isXOR_T, _isXOR_T_1) @[core.scala 106:41]
    node _isXOR_T_3 = eq(funct7, UInt<1>("h0")) @[core.scala 106:74]
    node isXOR = and(_isXOR_T_2, _isXOR_T_3) @[core.scala 106:64]
    node _isOR_T = eq(opcode, UInt<6>("h33")) @[core.scala 107:24]
    node _isOR_T_1 = eq(funct3, UInt<3>("h6")) @[core.scala 107:51]
    node _isOR_T_2 = and(_isOR_T, _isOR_T_1) @[core.scala 107:41]
    node _isOR_T_3 = eq(funct7, UInt<1>("h0")) @[core.scala 107:74]
    node isOR = and(_isOR_T_2, _isOR_T_3) @[core.scala 107:64]
    node _isAND_T = eq(opcode, UInt<6>("h33")) @[core.scala 108:24]
    node _isAND_T_1 = eq(funct3, UInt<3>("h7")) @[core.scala 108:51]
    node _isAND_T_2 = and(_isAND_T, _isAND_T_1) @[core.scala 108:41]
    node _isAND_T_3 = eq(funct7, UInt<1>("h0")) @[core.scala 108:74]
    node isAND = and(_isAND_T_2, _isAND_T_3) @[core.scala 108:64]
    node _isADDI_T = eq(opcode, UInt<5>("h13")) @[core.scala 112:24]
    node _isADDI_T_1 = eq(funct3, UInt<1>("h0")) @[core.scala 112:51]
    node isADDI = and(_isADDI_T, _isADDI_T_1) @[core.scala 112:41]
    node _aluResult_T = add(regFile.operandA.data, imm) @[core.scala 127:27]
    node _aluResult_T_1 = tail(_aluResult_T, 1) @[core.scala 127:27]
    node _aluResult_T_2 = add(regFile.operandA.data, regFile.operandB.data) @[core.scala 129:27]
    node _aluResult_T_3 = tail(_aluResult_T_2, 1) @[core.scala 129:27]
    node _aluResult_T_4 = sub(regFile.operandA.data, regFile.operandB.data) @[core.scala 131:27]
    node _aluResult_T_5 = tail(_aluResult_T_4, 1) @[core.scala 131:27]
    node _aluResult_T_6 = and(regFile.operandA.data, regFile.operandB.data) @[core.scala 133:27]
    node _aluResult_T_7 = or(regFile.operandA.data, regFile.operandB.data) @[core.scala 135:27]
    node _aluResult_T_8 = xor(regFile.operandA.data, regFile.operandB.data) @[core.scala 137:27]
    node _aluResult_T_9 = bits(regFile.operandB.data, 4, 0) @[core.scala 139:38]
    node _aluResult_T_10 = dshl(regFile.operandA.data, _aluResult_T_9) @[core.scala 139:27]
    node _aluResult_T_11 = bits(regFile.operandB.data, 4, 0) @[core.scala 141:38]
    node _aluResult_T_12 = dshl(regFile.operandA.data, _aluResult_T_11) @[core.scala 141:27]
    node _aluResult_T_13 = bits(regFile.operandB.data, 4, 0) @[core.scala 143:38]
    node _aluResult_T_14 = dshr(regFile.operandA.data, _aluResult_T_13) @[core.scala 143:27]
    node _aluResult_T_15 = asSInt(regFile.operandA.data) @[core.scala 150:28]
    node _aluResult_T_16 = bits(regFile.operandB.data, 4, 0) @[core.scala 150:46]
    node _aluResult_T_17 = dshr(_aluResult_T_15, _aluResult_T_16) @[core.scala 150:35]
    node _aluResult_T_18 = asUInt(_aluResult_T_17) @[core.scala 150:54]
    node _GEN_0 = mux(isSRA, _aluResult_T_18, UInt<10>("h29a")) @[core.scala 144:21 150:15 155:15]
    node _GEN_1 = mux(isSRL, _aluResult_T_14, _GEN_0) @[core.scala 142:21 143:15]
    node _GEN_2 = mux(isSLT, _aluResult_T_12, _GEN_1) @[core.scala 140:21 141:15]
    node _GEN_3 = mux(isSLL, _aluResult_T_10, _GEN_2) @[core.scala 138:21 139:15]
    node _GEN_4 = mux(isXOR, _aluResult_T_8, _GEN_3) @[core.scala 136:20 137:15]
    node _GEN_5 = mux(isOR, _aluResult_T_7, _GEN_4) @[core.scala 134:20 135:15]
    node _GEN_6 = mux(isAND, _aluResult_T_6, _GEN_5) @[core.scala 132:21 133:15]
    node _GEN_7 = mux(isSUB, _aluResult_T_5, _GEN_6) @[core.scala 130:21 131:15]
    node _GEN_8 = mux(isADD, _aluResult_T_3, _GEN_7) @[core.scala 128:21 129:15]
    node _GEN_9 = mux(isADDI, _aluResult_T_1, _GEN_8) @[core.scala 126:16 127:15]
    node _pc_T = add(pc, UInt<3>("h4")) @[core.scala 181:12]
    node _pc_T_1 = tail(_pc_T, 1) @[core.scala 181:12]
    node aluResult = bits(_GEN_9, 31, 0) @[core.scala 124:23]
    node writeBackData = aluResult @[core.scala 171:27 172:17]
    io_check_res <= writeBackData @[core.scala 177:16]
    IMem.instr_MPORT.addr <= _instr_T_1 @[core.scala 85:16]
    IMem.instr_MPORT.en <= UInt<1>("h1") @[core.scala 85:16]
    IMem.instr_MPORT.clk <= clock @[core.scala 85:16]
    pc <= mux(reset, UInt<32>("h0"), _pc_T_1) @[core.scala 73:{19,19} 181:6]
    regFile.operandA.addr <= rs1 @[core.scala 117:25]
    regFile.operandA.en <= UInt<1>("h1") @[core.scala 117:25]
    regFile.operandA.clk <= clock @[core.scala 117:25]
    regFile.operandB.addr <= rs2 @[core.scala 118:25]
    regFile.operandB.en <= UInt<1>("h1") @[core.scala 118:25]
    regFile.operandB.clk <= clock @[core.scala 118:25]
    regFile.MPORT.addr <= UInt<5>("h0") @[core.scala 77:10]
    regFile.MPORT.en <= UInt<1>("h1") @[core.scala 77:10]
    regFile.MPORT.clk <= clock @[core.scala 77:10]
    regFile.MPORT.data <= UInt<32>("h0") @[core.scala 77:14]
    regFile.MPORT.mask <= UInt<1>("h1") @[core.scala 77:14]
    regFile.MPORT_1.addr <= rd @[core.scala 174:10]
    regFile.MPORT_1.en <= UInt<1>("h1") @[core.scala 174:10]
    regFile.MPORT_1.clk <= clock @[core.scala 174:10]
    regFile.MPORT_1.data <= writeBackData @[core.scala 174:15]
    regFile.MPORT_1.mask <= UInt<1>("h1") @[core.scala 174:15]

  module SimpleRV32I :
    input clock : Clock
    input reset : UInt<1>
    output io_result : UInt<32>

    inst core of RV32Icore @[SimpleRISCV32I.scala 20:20]
    io_result <= core.io_check_res @[SimpleRISCV32I.scala 22:19]
    core.clock <= clock
    core.reset <= reset
