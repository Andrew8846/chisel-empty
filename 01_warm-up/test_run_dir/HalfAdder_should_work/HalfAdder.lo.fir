circuit HalfAdder :
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
