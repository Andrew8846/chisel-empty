// ADS I Class Project
// Chisel Introduction
//
// Chair of Electronic Design Automation, RPTU in Kaiserslautern
// File created on 18/10/2022 by Tobias Jauch (@tojauch)

package src.main.scala

import chisel3._
import chisel3.util._


/** controller class */
class Controller extends Module{
  
  val io = IO(new Bundle {
    val rdx = Input(UInt(1.W))
    val cnt_s = Input(UInt(4.W))
    val cnt_en = Output(Bool())
    val valid = Output(UInt(1.W))
    })

  // internal variables
  val idle :: receiving :: done :: Nil = Enum(3)
  val stateReg = RegInit(idle)
  val cnt_en = RegInit(false.B)
  val valid = RegInit(0.U)
  // state machine
  // io.valid := 0.U  // problem



  switch(stateReg) {
    is(idle) {
      valid := 0.U
      when(io.rdx === 0.U) {
        stateReg := receiving
        cnt_en := true.B
      }

    }

    is(receiving) {
      when(stateReg =/= receiving) {  // Enable counter only on entry into 'receiving'
        cnt_en := true.B
      }
      when(io.cnt_s === 7.U) {
        stateReg := idle
        valid := 1.U
        cnt_en := false.B
      }
    }

//    is(done) {
//      when(io.rdx === 0.U) {
//        stateReg := receiving
//        cnt_en := true.B
//      }.elsewhen(io.rdx === 1.U) {
//        stateReg := done
//        cnt_en := false.B
//      }
//    }
  }

  io.cnt_en := cnt_en
  io.valid := valid

}


/** counter class */
class Counter extends Module{
  
  val io = IO(new Bundle {
    val cnt_n = Input(Bool())
    val cnt_s = Output(UInt(4.W))
    })

  // internal variables
  val counterRegist = RegInit(0.U(4.W))

  // state machine
    when(io.cnt_n) {
      when(counterRegist < 8.U) {
        counterRegist := counterRegist + 1.U
      }.otherwise {
        counterRegist := 0.U
      }
    }

  io.cnt_s := counterRegist
}

/** shift register class */
class ShiftRegister extends Module{
  
  val io = IO(new Bundle {
    val rdx = Input(UInt(1.W))
    val data = Output(UInt(8.W))
    })

  // internal variables
  val dataReg = RegInit(0.U(8.W))

  // functionality
    dataReg :=  Cat(dataReg(6, 0), io.rdx)

  io.data := dataReg
}

/** 
  * The last warm-up task deals with a more complex component. Your goal is to design a serial receiver.
  * It scans an input line (“serial bus”) named rxd for serial transmissions of data bytes. A transmission 
  * begins with a start bit ‘0’ followed by 8 data bits. The most significant bit (MSB) is transmitted first. 
  * There is no parity bit and no stop bit. After the last data bit has been transferred a new transmission 
  * (beginning with a start bit, ‘0’) may immediately follow. If there is no new transmission the bus line 
  * goes high (‘1’, this is considered the “idle” bus signal). In this case the receiver waits until the next 
  * transmission begins. The outputs of the design are an 8-bit parallel data signal and a valid signal. 
  * The valid signal goes high (‘1’) for one clock cycle after the last serial bit has been transmitted, 
  * indicating that a new data byte is ready.
  */
class ReadSerial extends Module{
  
  val io = IO(new Bundle {
    val rdx = Input(UInt(1.W))
    val data = Output(UInt(8.W))
    val valid = Output (UInt(1.W))
    })


  // instanciation of modules
  val cntrl = Module(new Controller)
  val counter = Module(new Counter)
  val shiftReg = Module(new ShiftRegister)

  // connections between modules
  cntrl.io.rdx := io.rdx
  cntrl.io.cnt_s := counter.io.cnt_s
  counter.io.cnt_n := cntrl.io.cnt_en
  shiftReg.io.rdx := io.rdx


  io.data := shiftReg.io.data
  io.valid := cntrl.io.valid

}
