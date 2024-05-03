
// ADS I Class Project
// Single-Cycle RISC-V Core
//
// Chair of Electronic Design Automation, RPTU in Kaiserslautern
// File created on 05/10/2023 by Tobias Jauch (@tojauch)

package src.test.scala

import chisel3._
import chiseltest._
import org.scalatest.flatspec.AnyFlatSpec
import src.main.scala.SimpleRV32I

class SimpleRISCV32ITest extends AnyFlatSpec with ChiselScalatestTester {

"SimpleRV32I_Tester" should "work" in {
    test(new SimpleRV32I("src/test/programs/BinaryFile")).withAnnotations(Seq(WriteVcdAnnotation)) { dut =>

      dut.clock.setTimeout(0)

      dut.io.result.expect(0.U)     // ADDI x0, x0, 0
      dut.clock.step(1)
      dut.io.result.expect(4.U)     // ADDI x1, x0, 4
      dut.clock.step(1)
      dut.io.result.expect(5.U)     // ADDI x2, x0, 5
      dut.clock.step(1)
      dut.io.result.expect(9.U)     // ADD x3, x1, x2
      dut.clock.step(1)
      dut.io.result.expect(1.U)     // SUB x4, x2, x1
      dut.clock.step(1)
      dut.io.result.expect(4.U)     // AND x5, x1, x2
      dut.clock.step(1)
      dut.io.result.expect(5.U)    // OR  x6, x1, x2
      dut.clock.step(1)
      dut.io.result.expect(144.U)    // SLL x7, x3, x5 -> 9<<4
      dut.clock.step(1)
      dut.io.result.expect(4.U)    // SRL x7, x7, x2 -> 144>>5
      dut.clock.step(1)
      dut.io.result.expect(0.U)    // XOR x10, x6, x2 -> 5xor5
      dut.clock.step(1)
      dut.io.result.expect(9.U)    // XOR x10, x10, x3 -> 0xor9

      dut.clock.step(4)
      dut.io.result.expect("hF8000000".U)


      dut.clock.step(1)
      dut.io.result.expect(666.U)
           
    }
  }
}


