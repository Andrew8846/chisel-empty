// ADS I Class Project
// Chisel Introduction
//
// Chair of Electronic Design Automation, RPTU in Kaiserslautern
// File created on 18/10/2022 by Tobias Jauch (@tojauch)

package src.main.scala

import chisel3._
import chisel3.util._


/** 
  * Half Adder Class 
  * 
  * Your task is to implement a basic half adder as presented in the lecture.
  * Each signal should only be one bit wide (inputs and outputs).
  * There should be no delay between input and output signals, we want to have
  * a combinational behaviour of the component.
  */
class HalfAdder extends Module{
  
  val io = IO(new Bundle {
    val a  = Input(UInt(1.W))
    val b  = Input(UInt(1.W))
    val s = Output(UInt(1.W))
    val co = Output(UInt(1.W))
    })

    io.co := io.a & io.b
    io.s := io.a ^ io.b

}

/** 
  * Full Adder Class 
  * 
  * Your task is to implement a basic full adder. The component's behaviour should 
  * match the characteristics presented in the lecture. In addition, you are only allowed 
  * to use two half adders (use the class that you already implemented) and basic logic 
  * operators (AND, OR, ...).
  * Each signal should only be one bit wide (inputs and outputs).
  * There should be no delay between input and output signals, we want to have
  * a combinational behaviour of the component.
  */
class FullAdder extends Module{

  val io = IO(new Bundle {
    val a  = Input(UInt(1.W))
    val b  = Input(UInt(1.W))
    val ci = Input(UInt(1.W))
    val s = Output(UInt(1.W))
    val co = Output(UInt(1.W))
    })


  val half1 = Module(new HalfAdder)
  val half2 = Module(new HalfAdder)

    half1.io.a := io.a
    half1.io.b := io.b
    half2.io.a := half1.io.s
    half2.io.b := io.ci

    io.s := half2.io.s
    io.co := half2.io.co | half1.io.co

}

/** 
  * 4-bit Adder class 
  * 
  * Your task is to implement a 4-bit ripple-carry-adder. The component's behaviour should 
  * match the characteristics presented in the lecture.  Remember: An n - bit adder can be 
  * build using one half adder and n - 1 full adders.
  * The inputs and the result should all be 4-bit wide, the carry-out only needs one bit.
  * There should be no delay between input and output signals, we want to have
  * a combinational behaviour of the component.
  */
class FourBitAdder extends Module{

  val io = IO(new Bundle {
    val a = Input(UInt(4.W))
    val b = Input(UInt(4.W))
    val sum = Output(UInt(4.W))
    val carryOut = Output(UInt(1.W))
    })

  val half1 = Module(new HalfAdder)
  val full1 = Module(new FullAdder)
  val full2 = Module(new FullAdder)
  val full3 = Module(new FullAdder)

  half1.io.a := io.a(0)
  half1.io.b := io.b(0)

  full1.io.a := io.a(1)
  full1.io.b := io.b(1)
  full1.io.ci := half1.io.co

  full2.io.a := io.a(2)
  full2.io.b := io.b(2)
  full2.io.ci := full1.io.co

  full3.io.a := io.a(3)
  full3.io.b := io.b(3)
  full3.io.ci := full2.io.co



  val sumResult = Cat(full3.io.s, full2.io.s, full1.io.s, half1.io.s)

  io.sum := sumResult
  io.carryOut := full3.io.co

}
