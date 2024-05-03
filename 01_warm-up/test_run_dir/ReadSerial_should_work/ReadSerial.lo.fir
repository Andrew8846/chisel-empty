circuit ReadSerial :
  module Controller :
    input clock : Clock
    input reset : UInt<1>
    input io_rdx : UInt<1>
    input io_cnt_s : UInt<4>
    output io_cnt_en : UInt<1>
    output io_valid : UInt<1>

    reg stateReg : UInt<2>, clock with :
      reset => (UInt<1>("h0"), stateReg) @[ReadSerial.scala 25:25]
    reg cnt_en : UInt<1>, clock with :
      reset => (UInt<1>("h0"), cnt_en) @[ReadSerial.scala 26:23]
    reg valid : UInt<1>, clock with :
      reset => (UInt<1>("h0"), valid) @[ReadSerial.scala 27:22]
    node _T = eq(UInt<2>("h0"), stateReg) @[ReadSerial.scala 33:20]
    node _T_1 = eq(io_rdx, UInt<1>("h0")) @[ReadSerial.scala 36:19]
    node _GEN_0 = mux(_T_1, UInt<2>("h1"), stateReg) @[ReadSerial.scala 36:28 37:18 25:25]
    node _GEN_1 = mux(_T_1, UInt<1>("h1"), cnt_en) @[ReadSerial.scala 36:28 38:16 26:23]
    node _T_2 = eq(UInt<2>("h1"), stateReg) @[ReadSerial.scala 33:20]
    node _T_3 = neq(stateReg, UInt<2>("h1")) @[ReadSerial.scala 44:21]
    node _GEN_2 = mux(_T_3, UInt<1>("h1"), cnt_en) @[ReadSerial.scala 44:36 45:16 26:23]
    node _T_4 = eq(io_cnt_s, UInt<3>("h7")) @[ReadSerial.scala 47:21]
    node _GEN_3 = mux(_T_4, UInt<2>("h0"), stateReg) @[ReadSerial.scala 47:30 48:18 25:25]
    node _GEN_4 = mux(_T_4, UInt<1>("h1"), valid) @[ReadSerial.scala 47:30 49:15 27:22]
    node _GEN_5 = mux(_T_4, UInt<1>("h0"), _GEN_2) @[ReadSerial.scala 47:30 50:16]
    node _GEN_6 = mux(_T_2, _GEN_5, cnt_en) @[ReadSerial.scala 33:20 26:23]
    node _GEN_7 = mux(_T_2, _GEN_3, stateReg) @[ReadSerial.scala 33:20 25:25]
    node _GEN_8 = mux(_T_2, _GEN_4, valid) @[ReadSerial.scala 33:20 27:22]
    node _GEN_9 = mux(_T, UInt<1>("h0"), _GEN_8) @[ReadSerial.scala 33:20 35:13]
    node _GEN_10 = mux(_T, _GEN_0, _GEN_7) @[ReadSerial.scala 33:20]
    node _GEN_11 = mux(_T, _GEN_1, _GEN_6) @[ReadSerial.scala 33:20]
    io_cnt_en <= cnt_en @[ReadSerial.scala 65:13]
    io_valid <= valid @[ReadSerial.scala 66:12]
    stateReg <= mux(reset, UInt<2>("h0"), _GEN_10) @[ReadSerial.scala 25:{25,25}]
    cnt_en <= mux(reset, UInt<1>("h0"), _GEN_11) @[ReadSerial.scala 26:{23,23}]
    valid <= mux(reset, UInt<1>("h0"), _GEN_9) @[ReadSerial.scala 27:{22,22}]

  module Counter :
    input clock : Clock
    input reset : UInt<1>
    input io_cnt_n : UInt<1>
    output io_cnt_s : UInt<4>

    reg counterRegist : UInt<4>, clock with :
      reset => (UInt<1>("h0"), counterRegist) @[ReadSerial.scala 80:30]
    node _T = lt(counterRegist, UInt<4>("h8")) @[ReadSerial.scala 84:26]
    node _counterRegist_T = add(counterRegist, UInt<1>("h1")) @[ReadSerial.scala 85:40]
    node _counterRegist_T_1 = tail(_counterRegist_T, 1) @[ReadSerial.scala 85:40]
    node _GEN_0 = mux(_T, _counterRegist_T_1, UInt<1>("h0")) @[ReadSerial.scala 84:33 85:23 87:23]
    node _GEN_1 = mux(io_cnt_n, _GEN_0, counterRegist) @[ReadSerial.scala 83:20 80:30]
    io_cnt_s <= counterRegist @[ReadSerial.scala 91:12]
    counterRegist <= mux(reset, UInt<4>("h0"), _GEN_1) @[ReadSerial.scala 80:{30,30}]

  module ShiftRegister :
    input clock : Clock
    input reset : UInt<1>
    input io_rdx : UInt<1>
    output io_data : UInt<8>

    reg dataReg : UInt<8>, clock with :
      reset => (UInt<1>("h0"), dataReg) @[ReadSerial.scala 103:24]
    node _dataReg_T = bits(dataReg, 6, 0) @[ReadSerial.scala 106:28]
    node _dataReg_T_1 = cat(_dataReg_T, io_rdx) @[Cat.scala 31:58]
    io_data <= dataReg @[ReadSerial.scala 108:11]
    dataReg <= mux(reset, UInt<8>("h0"), _dataReg_T_1) @[ReadSerial.scala 103:{24,24} 106:13]

  module ReadSerial :
    input clock : Clock
    input reset : UInt<1>
    input io_rdx : UInt<1>
    output io_data : UInt<8>
    output io_valid : UInt<1>

    inst cntrl of Controller @[ReadSerial.scala 132:21]
    inst counter of Counter @[ReadSerial.scala 133:23]
    inst shiftReg of ShiftRegister @[ReadSerial.scala 134:24]
    io_data <= shiftReg.io_data @[ReadSerial.scala 143:11]
    io_valid <= cntrl.io_valid @[ReadSerial.scala 144:12]
    cntrl.clock <= clock
    cntrl.reset <= reset
    cntrl.io_rdx <= io_rdx @[ReadSerial.scala 137:16]
    cntrl.io_cnt_s <= counter.io_cnt_s @[ReadSerial.scala 138:18]
    counter.clock <= clock
    counter.reset <= reset
    counter.io_cnt_n <= cntrl.io_cnt_en @[ReadSerial.scala 139:20]
    shiftReg.clock <= clock
    shiftReg.reset <= reset
    shiftReg.io_rdx <= io_rdx @[ReadSerial.scala 140:19]
