circuit FourBitAdder :
  module HalfAdder :
    input clock : Clock
    input reset : UInt<1>
    input io_a : UInt<1>
    input io_b : UInt<1>
    output io_s : UInt<1>
    output io_co : UInt<1>

    node _io_co_T = and(io_a, io_b) @[Adder.scala 30:19]
    node _io_s_T = xor(io_a, io_b) @[Adder.scala 31:18]
    io_s <= _io_s_T @[Adder.scala 31:10]
    io_co <= _io_co_T @[Adder.scala 30:11]

  module FullAdder :
    input clock : Clock
    input reset : UInt<1>
    input io_a : UInt<1>
    input io_b : UInt<1>
    input io_ci : UInt<1>
    output io_s : UInt<1>
    output io_co : UInt<1>

    inst half1 of HalfAdder @[Adder.scala 57:21]
    inst half2 of HalfAdder @[Adder.scala 58:21]
    node _io_co_T = or(half2.io_co, half1.io_co) @[Adder.scala 66:26]
    io_s <= half2.io_s @[Adder.scala 65:10]
    io_co <= _io_co_T @[Adder.scala 66:11]
    half1.clock <= clock
    half1.reset <= reset
    half1.io_a <= io_a @[Adder.scala 60:16]
    half1.io_b <= io_b @[Adder.scala 61:16]
    half2.clock <= clock
    half2.reset <= reset
    half2.io_a <= half1.io_s @[Adder.scala 62:16]
    half2.io_b <= io_ci @[Adder.scala 63:16]

  module FourBitAdder :
    input clock : Clock
    input reset : UInt<1>
    input io_a : UInt<4>
    input io_b : UInt<4>
    output io_sum : UInt<4>
    output io_carryOut : UInt<1>

    inst half1 of HalfAdder @[Adder.scala 89:21]
    inst full1 of FullAdder @[Adder.scala 90:21]
    inst full2 of FullAdder @[Adder.scala 91:21]
    inst full3 of FullAdder @[Adder.scala 92:21]
    node _half1_io_a_T = bits(io_a, 0, 0) @[Adder.scala 94:21]
    node _half1_io_b_T = bits(io_b, 0, 0) @[Adder.scala 95:21]
    node _full1_io_a_T = bits(io_a, 1, 1) @[Adder.scala 97:21]
    node _full1_io_b_T = bits(io_b, 1, 1) @[Adder.scala 98:21]
    node _full2_io_a_T = bits(io_a, 2, 2) @[Adder.scala 101:21]
    node _full2_io_b_T = bits(io_b, 2, 2) @[Adder.scala 102:21]
    node _full3_io_a_T = bits(io_a, 3, 3) @[Adder.scala 105:21]
    node _full3_io_b_T = bits(io_b, 3, 3) @[Adder.scala 106:21]
    node sumResult_lo = cat(full1.io_s, half1.io_s) @[Cat.scala 31:58]
    node sumResult_hi = cat(full3.io_s, full2.io_s) @[Cat.scala 31:58]
    node sumResult = cat(sumResult_hi, sumResult_lo) @[Cat.scala 31:58]
    io_sum <= sumResult @[Adder.scala 113:10]
    io_carryOut <= full3.io_co @[Adder.scala 114:15]
    half1.clock <= clock
    half1.reset <= reset
    half1.io_a <= _half1_io_a_T @[Adder.scala 94:14]
    half1.io_b <= _half1_io_b_T @[Adder.scala 95:14]
    full1.clock <= clock
    full1.reset <= reset
    full1.io_a <= _full1_io_a_T @[Adder.scala 97:14]
    full1.io_b <= _full1_io_b_T @[Adder.scala 98:14]
    full1.io_ci <= half1.io_co @[Adder.scala 99:15]
    full2.clock <= clock
    full2.reset <= reset
    full2.io_a <= _full2_io_a_T @[Adder.scala 101:14]
    full2.io_b <= _full2_io_b_T @[Adder.scala 102:14]
    full2.io_ci <= full1.io_co @[Adder.scala 103:15]
    full3.clock <= clock
    full3.reset <= reset
    full3.io_a <= _full3_io_a_T @[Adder.scala 105:14]
    full3.io_b <= _full3_io_b_T @[Adder.scala 106:14]
    full3.io_ci <= full2.io_co @[Adder.scala 107:15]
