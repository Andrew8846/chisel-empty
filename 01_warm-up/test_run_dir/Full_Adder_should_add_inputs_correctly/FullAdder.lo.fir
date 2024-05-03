circuit FullAdder :
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
