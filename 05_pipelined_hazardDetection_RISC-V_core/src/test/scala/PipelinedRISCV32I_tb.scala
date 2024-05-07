// ADS I Class Project
// Pipelined RISC-V Core
//
// Chair of Electronic Design Automation, RPTU in Kaiserslautern
// File created on 12/19/2023 by Tobias Jauch (@tojauch)

package PipelinedRV32I_Tester

import chisel3._
import chiseltest._
import PipelinedRV32I._
import org.scalatest.flatspec.AnyFlatSpec

class PipelinedRISCV32ITest extends AnyFlatSpec with ChiselScalatestTester {

"PipelinedRV32I_Tester" should "work" in {
    test(new PipelinedRV32I("src/test/programs/BinaryFile")).withAnnotations(Seq(WriteVcdAnnotation)) { dut =>

      dut.clock.setTimeout(0)
      dut.clock.step(4)
      dut.io.result.expect(4.U)     // ADDI x1, x0, 4
      dut.clock.step(1)
      dut.io.result.expect(5.U)     // ADDI x2, x0, 5
      dut.clock.step(1)
      dut.io.result.expect(0.U)     // ADDI x0, x0, 0
      dut.clock.step(1)
      dut.io.result.expect(9.U)     // ADD x3, x1, x2
      dut.clock.step(1)
      dut.io.result.expect(14.U)     // ADD x4, x3, x2
      dut.clock.step(1)
      dut.io.result.expect(16.U)     // ADDI x5, x0, 16
           
    }
  }
}


