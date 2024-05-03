// ADS I Class Project
// Chisel Introduction
//
// Chair of Electronic Design Automation, RPTU in Kaiserslautern
// File created on 18/10/2022 by Tobias Jauch (@tojauch)

package src.test.scala

import chisel3._
import chiseltest._
import org.scalatest.flatspec.AnyFlatSpec
import src.main.scala.ReadSerial


/** 
  *read serial tester
  */
class ReadSerialTester extends AnyFlatSpec with ChiselScalatestTester {

  "ReadSerial" should "work" in {
    test(new ReadSerial).withAnnotations(Seq(WriteVcdAnnotation)) { dut =>


      // Initial values
      dut.io.rdx.poke(1.U) // Start with the idle state
      dut.clock.step()

      // Wait for a rising edge of rdx (start of transmission)
      dut.io.rdx.poke(0.U)
      dut.clock.step()


      // Transmit 8 data bits (for example, 10101010)
      for (i <- 0 until 8) {
        dut.io.rdx.poke((i % 2).U) // Alternating 0 and 1 for data bits
        dut.clock.step()
      }

      dut.io.data.expect("b01010101".U)
      dut.io.valid.expect(1.U)

//       Stop transmitting (idle state)
      dut.io.rdx.poke(1.U)
      dut.clock.step()

      dut.io.valid.expect(0.U)

      // start new transmission
      dut.io.rdx.poke(0.U)
      dut.clock.step()

      // transmit new 8 data bits
      dut.io.rdx.poke(1.U)
      dut.clock.step()
      dut.io.rdx.poke(1.U)
      dut.clock.step()
      dut.io.rdx.poke(1.U)
      dut.clock.step()
      dut.io.rdx.poke(0.U)
      dut.clock.step()
      dut.io.rdx.poke(1.U)
      dut.clock.step()
      dut.io.rdx.poke(1.U)
      dut.clock.step()
      dut.io.rdx.poke(0.U)
      dut.clock.step()
      dut.io.rdx.poke(1.U)
      dut.clock.step()


      dut.io.data.expect("b11101101".U)
      dut.io.valid.expect(1.U)


        }
    } 
}

