// ADS I Class Project
// Pipelined RISC-V Core
//
// Chair of Electronic Design Automation, RPTU in Kaiserslautern
// File created on 01/15/2023 by Tobias Jauch (@tojauch)

/*
The goal of this task is to extend the 5-stage multi-cycle 32-bit RISC-V core from the previous task to a pipelined processor. 
All steps and stages have the same functionality as in the multi-cycle version from task 03, but are supposed to handle different instructions in each stage simultaneously.
This design implements a pipelined RISC-V 32-bit core with five stages: IF (Fetch), ID (Decode), EX (Execute), MEM (Memory), and WB (Writeback).

    Data Types:
        The uopc enumeration data type (enum) defines micro-operation codes representing ALU operations according to the RV32I subset used in the previous tasks.

    Register File (regFile):
        The regFile module represents the register file, which has read and write ports.
        It consists of a 32-entry register file (x0 is hard-wired to zero).
        Reading from and writing to the register file is controlled by the read request (regFileReadReq), read response (regFileReadResp), and write request (regFileWriteReq) interfaces.

    Fetch Stage (IF Module):
        The IF module represents the instruction fetch stage.
        It includes an instruction memory (IMem) of size 4096 words (32-bit each).
        Instructions are loaded from a binary file (provided to the testbench as a parameter) during initialization.
        The program counter (PC) is used as an address to access the instruction memory, and one instruction is fetched in each cycle.

    Decode Stage (ID Module):
        The ID module performs instruction decoding and generates control signals.
        It extracts opcode, operands, and immediate values from the instruction.
        It uses the uopc (micro-operation code) Enum to determine the micro-operation (uop) and sets control signals accordingly.
        The register file requests are generated based on the operands in the instruction.

    Execute Stage (EX Module):
        The EX module performs the arithmetic or logic operation based on the micro-operation code.
        It takes two operands and produces the result (aluResult).

    Memory Stage (MEM Module):
        The MEM module does not perform any memory operations in this basic CPU design.

    Writeback Stage (WB Module):
        The WB module writes the result back to the register file.

    IF, ID, EX, MEM, WB Barriers:
        IFBarrier, IDBarrier, EXBarrier, MEMBarrier, and WBBarrier modules serve as pipeline registers to separate the pipeline stages.
        They hold the intermediate results of each stage until the next clock cycle.

    PipelinedRV32Icore (PipelinedRV32Icore Module):
        The top-level module that connects all the pipeline stages, barriers and the register file.
        It interfaces with the external world through check_res, which is the result produced by the core.

Overall Execution Flow:

    1) Instructions are fetched from the instruction memory in the IF stage.
    2) The fetched instruction is decoded in the ID stage, and the corresponding micro-operation code is determined.
    3) The EX stage executes the operation using the operands.
    4) The MEM stage does not perform any memory operations in this design.
    5) The result is written back to the register file in the WB stage.

Note this design only represents a simplified RISC-V pipeline. The structure could be equipped with further instructions and extension to support a real RISC-V ISA.
*/

package core_tile

import chisel3._
import chisel3.experimental.ChiselEnum
import chisel3.util._
import chisel3.util.experimental.loadMemoryFromFile


// -----------------------------------------
// Global Definitions and Data Types
// -----------------------------------------

object uopc extends ChiselEnum {

  val isADD   = Value(0x01.U)
  val isSUB   = Value(0x02.U)
  val isXOR   = Value(0x03.U)
  val isOR    = Value(0x04.U)
  val isAND   = Value(0x05.U)
  val isSLL   = Value(0x06.U)
  val isSRL   = Value(0x07.U)
  val isSRA   = Value(0x08.U)
  val isSLT   = Value(0x09.U)
  val isSLTU  = Value(0x0A.U)

  val isADDI  = Value(0x10.U)

  val invalid = Value(0xFF.U)
}

import uopc._


// -----------------------------------------
// Register File
// -----------------------------------------

// Helper Bundles
class RegFileReq extends Bundle {
  val rs = UInt(5.W)
}

class RegFileResp extends Bundle {
  val data = UInt(32.W)
}

class WriteReq extends Bundle {
  val writeEn = Bool()
  val rd = UInt(5.W)
  val data = UInt(32.W)
}

class regFile extends Module {

  val io = IO(new Bundle {
    val req1 = Input(new RegFileReq)
    val req2 = Input(new RegFileReq)

    // Read Responses
    val resp1 = Output(new RegFileResp)
    val resp2 = Output(new RegFileResp)

    // Write Request
    val write = Input(new WriteReq)
  })

  val regFile = Mem(32, UInt(32.W))
  regFile(0) := 0.U // hard wiring register x0 to 0
  io.resp1.data := regFile(io.req1.rs)
  io.resp2.data := regFile(io.req2.rs)

  when(io.write.writeEn) {
    regFile(io.write.rd) := io.write.data
  }
}


// -----------------------------------------
// Fetch Stage
// -----------------------------------------

class IF (BinaryFile: String) extends Module {
  val io = IO(new Bundle {
    val pc = Input(UInt(32.W))
    val instr = Output(UInt(32.W))
    val pcNew = Output(UInt(32.W))
  })

  val IMem = Mem(4096, UInt(32.W))
  loadMemoryFromFile(IMem, BinaryFile)

  io.instr := IMem(io.pc>>2.U)

  io.pcNew := io.pc + 4.U
}


// -----------------------------------------
// Decode Stage
// -----------------------------------------

class ID extends Module {
  val io = IO(new Bundle {
    val instr = Input(UInt(32.W))
    val immediate = Output(UInt(12.W))
    val uop = Output(uopc())
    val rs1 = Output(UInt(5.W))
    val rs2 = Output(UInt(5.W))
    val rd = Output(UInt(5.W))
  })

  val opcode = io.instr(6, 0)
  val rd     = io.instr(11, 7)
  val funct3 = io.instr(14, 12)
  val rs1    = io.instr(19, 15)
  val rs2    = io.instr(24, 20)
  val funct7 = io.instr(31, 25)
  val imm = io.instr(31, 20)

  io.uop := invalid
  when(opcode === "b0110011".U && funct3 === "b000".U && funct7 === "b0000000".U) {
    io.uop := isADD
  }.elsewhen(opcode === "b0110011".U && funct3 === "b000".U && funct7 === "b0100000".U) {
    io.uop := isSUB
  }.elsewhen(opcode === "b0110011".U && funct3 === "b001".U && funct7 === "b0000000".U) {
    io.uop := isSLL
  }.elsewhen(opcode === "b0110011".U && funct3 === "b101".U && funct7 === "b0000000".U) {
    io.uop := isSRL
  }.elsewhen(opcode === "b0110011".U && funct3 === "b101".U && funct7 === "b0100000".U) {
    io.uop := isSRA
  }.elsewhen(opcode === "b0110011".U && funct3 === "b100".U && funct7 === "b0000000".U) {
    io.uop := isXOR
  }.elsewhen(opcode === "b0110011".U && funct3 === "b110".U && funct7 === "b0000000".U) {
    io.uop := isOR
  }.elsewhen(opcode === "b0110011".U && funct3 === "b111".U && funct7 === "b0000000".U) {
    io.uop := isADD
  }.elsewhen(opcode === "b0110011".U && funct3 === "b010".U && funct7 === "b0000000".U) {
    io.uop := isSLT
  }.elsewhen(opcode === "b0110011".U && funct3 === "b011".U && funct7 === "b0000000".U) {
    io.uop := isSLTU
  }.elsewhen(opcode === "b0010011".U && funct3 === "b000".U) {
    io.uop := isADDI
  }.otherwise {
    io.uop := invalid
  }

  // most of them share same opcode

  io.rs1 := rs1
  io.rs2 := rs2
  io.immediate := imm
  io.rd := rd

}

// -----------------------------------------
// Execute Stage
// -----------------------------------------

class EX extends Module {
  val io = IO(new Bundle {
    val uop = Input(uopc())
    val operandA = Input(UInt(32.W))
    val operandB = Input(UInt(32.W))
    val immediate = Input(UInt(12.W))
    val result = Output(UInt(32.W))
  })

  when (io.uop === isADD) {
    io.result := io.operandA + io.operandB
  }.elsewhen(io.uop === isSUB) {
    io.result := io.operandA - io.operandB
  }.elsewhen(io.uop === isAND) {
    io.result := io.operandA & io.operandB
  }.elsewhen(io.uop === isOR) {
    io.result := io.operandA | io.operandB
  }.elsewhen(io.uop === isXOR) {
    io.result := io.operandA ^ io.operandB
  }.elsewhen(io.uop === isSLL) {
    io.result := io.operandA << io.operandB(4, 0)
  }.elsewhen(io.uop === isSRL) {
    io.result := io.operandA >> io.operandB(4, 0)
  }.elsewhen(io.uop === isSRA) {
    io.result := (io.operandA.asSInt >> io.operandB(4, 0)).asUInt
  }.elsewhen(io.uop === isSLTU) {
    io.result := Mux (io.operandA < io.operandB, 1.U, 0.U)
  }.elsewhen(io.uop === isSUB) {
    io.result := Mux (io.operandA.asSInt < io.operandB.asSInt, 1.U, 0.U)
  }.elsewhen(io.uop === isADDI) {
    io.result := io.operandA + io.immediate
  }.otherwise {
    io.result := "hFFFFFFFF".U
  }

}

// -----------------------------------------
// Memory Stage
// -----------------------------------------

class MEM extends Module {
  val io = IO(new Bundle {
    val rd = Input(UInt(5.W))
    val result = Input(UInt(32.W))
    val rdO = Output(UInt(5.W))
    val resultO = Output(UInt(32.W))
  })

  io.rdO := io.rd
  io.resultO := io.result

}


// -----------------------------------------
// Writeback Stage
// -----------------------------------------

class WB extends Module {
  val io = IO(new Bundle {
    val rd = Input(UInt(5.W))
    val result = Input(UInt(32.W))
    val wbToRegFile = Output(new WriteReq) // connect this to register file in main module
    val check_res = Output(UInt(32.W))
  })

  io.wbToRegFile.writeEn := true.B
  io.wbToRegFile.rd := io.rd
  io.wbToRegFile.data := io.result
  io.check_res := io.result

}


// -----------------------------------------
// IF-Barrier
// -----------------------------------------

class IFBarrier extends Module {
  val io = IO(new Bundle {
    val pcIn = Input(UInt(32.W))
    val instrIn = Input(UInt(32.W))
    val pcOut = Output(UInt(32.W))
    val instrOut = Output(UInt(32.W))
  })

  val pcReg = Reg(UInt(32.W))
  val instrReg = Reg(UInt(32.W))

  pcReg := io.pcIn
  instrReg := io.instrIn

  io.pcOut := pcReg
  io.instrOut := instrReg

}


// -----------------------------------------
// ID-Barrier
// -----------------------------------------

class IDBarrier extends Module {
  val io = IO(new Bundle {
    val immediate = Input(UInt(12.W))
    val uop = Input(uopc())
    val rd = Input(UInt(5.W))
    val rs1 = Input(UInt(5.W))
    val rs2 = Input(UInt(5.W))

    val immediateOut = Output(UInt(12.W))
    val uopOut = Output(uopc())
    val rdOut = Output(UInt(5.W))
    val rs1out = Output(UInt(5.W))
    val rs2out = Output(UInt(5.W))
  })

  val immReg = Reg(UInt(12.W))
  val opReg = Reg(uopc())
  val rdReg = Reg(UInt(5.W))
  val rs1Reg = Reg(UInt(5.W))
  val rs2Reg = Reg(UInt(5.W))

  immReg := io.immediate
  opReg := io.uop
  rdReg := io.rd
  rs1Reg := io.rs1
  rs2Reg := io.rs2

  io.immediateOut := immReg
  io.uopOut := opReg
  io.rdOut := rdReg
  io.rs1out := rs1Reg
  io.rs2out := rs2Reg

}


// -----------------------------------------
// EX-Barrier
// -----------------------------------------

class EXBarrier extends Module {
  val io = IO(new Bundle {
    val result = Input(UInt(32.W))
    val rd = Input(UInt(5.W))

    val resOut = Output(UInt(32.W))
    val rdOut = Output(UInt(5.W))
  })

  val resultReg = Reg(UInt(32.W))
  val rdReg = Reg(UInt(5.W))

  resultReg := io.result
  rdReg := io.rd

  io.resOut := resultReg
  io.rdOut := rdReg

}


// -----------------------------------------
// MEM-Barrier
// -----------------------------------------

class MEMBarrier extends Module {
  val io = IO(new Bundle {
    val rdIn = Input(UInt(5.W))
    val resultIn = Input(UInt(32.W))

    val rdOut = Output(UInt(5.W))
    val resultOut = Output(UInt(32.W))
  })

  val rdreg = Reg(UInt(5.W))
  val resReg = Reg(UInt(32.W))

  rdreg := io.rdIn
  resReg := io.resultIn

  io.rdOut := rdreg
  io.resultOut := resReg

}


// -----------------------------------------
// WB-Barrier
// -----------------------------------------

class WBBarrier extends Module {
  val io = IO(new Bundle {
    val wbToRegFileIn = Input(new WriteReq)
    val checkIn = Input(UInt(32.W))
    val wbToRegFileOut = Output(new WriteReq)
    val checkOut = Output(UInt(32.W))
  })

  val wbREG = Reg(new WriteReq)
  val checkReg = Reg(UInt(32.W))

  wbREG := io.wbToRegFileIn
  checkReg := io.checkIn

  io.wbToRegFileOut := wbREG
  io.checkOut := checkReg

}



class PipelinedRV32Icore (BinaryFile: String) extends Module {
  val io = IO(new Bundle {
    val check_res = Output(UInt(32.W))
  })


  var ifBarrier = Module(new IFBarrier)
  var idBarrier = Module(new IDBarrier)
  var exBarrier = Module(new EXBarrier)
  var memBarrier = Module(new MEMBarrier)
  //var wbBarrier = Module(new WBBarrier)
  // we dont have hazards and hazard detection so i dont need wbBarrier

  var IF = Module(new IF(BinaryFile))
  var ID = Module(new ID)
  var EX = Module(new EX)
  var MEM = Module(new MEM)
  var WB = Module(new WB)


  var regFile = Module(new regFile)
  regFile.io.write.writeEn := false.B

  io.check_res := 0.U // necessary to make the empty design buildable
  val pc = RegInit(0.U(32.W))

  // fetch
  IF.io.pc := pc
  pc := IF.io.pcNew
  ifBarrier.io.pcIn := IF.io.pcNew
  ifBarrier.io.instrIn := IF.io.instr

  // decode
  ID.io.instr := ifBarrier.io.instrOut


  idBarrier.io.rs1 := ID.io.rs1
  idBarrier.io.rs2 := ID.io.rs2

  idBarrier.io.immediate := ID.io.immediate
  idBarrier.io.rd := ID.io.rd
  idBarrier.io.uop := ID.io.uop

  // execute
  regFile.io.req1.rs := idBarrier.io.rs1out
  regFile.io.req2.rs := idBarrier.io.rs2out
  EX.io.uop := idBarrier.io.uopOut
  EX.io.operandA := regFile.io.resp1.data
  EX.io.operandB := regFile.io.resp2.data
  EX.io.immediate := idBarrier.io.immediateOut
  exBarrier.io.rd := idBarrier.io.rdOut
  exBarrier.io.result := EX.io.result

  // mem access
  MEM.io.rd := exBarrier.io.rdOut
  MEM.io.result := exBarrier.io.resOut
  memBarrier.io.resultIn := MEM.io.resultO
  memBarrier.io.rdIn := MEM.io.rdO

  // write back

  WB.io.result := memBarrier.io.resultOut
  WB.io.rd := memBarrier.io.rdOut

  regFile.io.write := WB.io.wbToRegFile
  io.check_res := WB.io.check_res

}