// ADS I Class Project
// Chisel Introduction
//
// Chair of Electronic Design Automation, RPTU in Kaiserslautern
// File created on 18/10/2022 by Tobias Jauch (@tojauch)

package src.test.scala

import chisel3._
import chiseltest._
import org.scalatest.flatspec.AnyFlatSpec
import src.main.scala.FullAdder


/** 
  * Full adder tester
  * Use the truth table from the exercise sheet to test all possible input combinations and the corresponding results exhaustively
  */
class FullAdderTester extends AnyFlatSpec with ChiselScalatestTester {
  behavior of "Full Adder"

  it should "add inputs correctly" in {
    test(new FullAdder).withAnnotations(Seq(WriteVcdAnnotation)) { dut =>


      testWithInputs(dut, 0.U, 0.U, 0.U, 0.U, 0.U)
      testWithInputs(dut, 0.U, 0.U, 1.U, 1.U, 0.U)
      testWithInputs(dut, 0.U, 1.U, 0.U, 1.U, 0.U)
      testWithInputs(dut, 0.U, 1.U, 1.U, 0.U, 1.U)
      testWithInputs(dut, 1.U, 0.U, 0.U, 1.U, 0.U)
      testWithInputs(dut, 1.U, 0.U, 1.U, 0.U, 1.U)
      testWithInputs(dut, 1.U, 1.U, 0.U, 0.U, 1.U)
      testWithInputs(dut, 1.U, 1.U, 1.U, 1.U, 1.U)
    }
  }

  def testWithInputs(dut:FullAdder, a: UInt, b: UInt, cin: UInt, s: UInt, cout: UInt): Unit = {

        dut.io.a.poke(a)
        dut.io.b.poke(b)
        dut.io.ci.poke(cin)
        dut.io.s.expect(s)
        dut.io.co.expect(cout)

  }

//  "FullAdder" should "work" in {
//    test(new FullAdder).withAnnotations(Seq(WriteVcdAnnotation)) { dut =>
//
//           dut.io.a.poke(0.U)
//           dut.io.b.poke(0.U)
//           dut.io.ci.poke(0.U)
//           dut.io.s.expect(0.U)
//           dut.io.co.expect(0.U)
//
//        }
//    }
}

