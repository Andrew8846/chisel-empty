// ADS I Class Project
// Multi-Cycle RISC-V Core
//
// Chair of Electronic Design Automation, RPTU in Kaiserslautern
// File created on 05/10/2023 by Tobias Jauch (@tojauch)

/*
The goal of this task is to implement a 5-stage multi-cycle 32-bit RISC-V processor (without pipelining) supporting parts of the RV32I instruction set architecture. The RV32I core is relatively basic 
and does not include features like memory operations, exception handling, or branch instructions. It is designed for a simplified subset of the RISC-V ISA. It mainly 
focuses on ALU operations and basic instruction execution. 

    Instruction Memory:
        The CPU has an instruction memory (IMem) with 4096 words, each of 32 bits.
        The content of IMem is loaded from a binary file specified during the instantiation of the MultiCycleRV32Icore module.

    CPU Registers:
        The CPU has a program counter (PC) and a register file (regFile) with 32 registers, each holding a 32-bit value.
        Register x0 is hard-wired to zero.

    Microarchitectural Registers / Wires:
        Various signals are defined as either registers or wires depending on whether they need to be used in the same cycle or in a later cycle.

    Processor Stages:
        The FSM of the processor has five stages: fetch, decode, execute, memory, and writeback.
        The current stage is stored in a register named stage.

        Fetch Stage:
            The instruction is fetched from the instruction memory based on the current value of the program counter (PC).

        Decode Stage:
            Instruction fields such as opcode, rd, funct3, and rs1 are extracted.
            For R-type instructions, additional fields like funct7 and rs2 are extracted.
            Control signals (isADD, isSUB, etc.) are set based on the opcode and funct3 values.
            Operands (operandA and operandB) are determined based on the instruction type.

        Execute Stage:
            Arithmetic and logic operations are performed based on the control signals and operands.
            The result is stored in the aluResult register.

        Memory Stage:
            No memory operations are implemented in this basic CPU.

        Writeback Stage:
            The result of the operation (writeBackData) is written back to the destination register (rd) in the register file.
            The program counter (PC) is updated for the next instruction.

        Other:
            If the processor state is not in any of the defined stages, an assertion is triggered to indicate an error.

    Check Result:
        The final result (writeBackData) is output to the io.check_res signal.
        In the fetch stage, a default value of 0 is assigned to io.check_res.
*/

package core_tile

import chisel3._
import chisel3.util._
import chisel3.util.experimental.loadMemoryFromFile

class MultiCycleRV32Icore (BinaryFile: String) extends Module {
  val io = IO(new Bundle {
    val check_res = Output(UInt(32.W))
  })

  val fetch :: decode :: execute :: memory :: writeback :: Nil = Enum(5) // Enum datatype to define the stages of the processor FSM
  val stage = RegInit(fetch)
  io.check_res := 0.U(32.W)

  // -----------------------------------------
  // Instruction Memory
  // -----------------------------------------

  val IMem = Mem(4096, UInt(32.W))
  loadMemoryFromFile(IMem, BinaryFile)

  // -----------------------------------------
  // CPU Registers
  // -----------------------------------------

  val pc = RegInit(0.U(32.W))  // program counter

  val regFile = Mem(32, UInt(32.W))
  regFile(0) := 0.U // hard wiring register x0 to 0

  // -----------------------------------------
  // Microarchitectural Registers / Wires
  // -----------------------------------------

  // if signal is processed in the same cycle --> wire
  // is signal is used in a later cycle       --> register

  val instr = RegInit(0.U(32.W))
  val isADD = RegInit(false.B)
  val isSUB = RegInit(false.B)
  val isSLL = RegInit(false.B)
  val isSRL = RegInit(false.B)
  val isSRA = RegInit(false.B)
  val isXOR = RegInit(false.B)
  val isOR = RegInit(false.B)
  val isAND = RegInit(false.B)
  val isADDI = RegInit(false.B)
  val isSLT = RegInit(false.B)
  val isSLTU = RegInit(false.B)


  val opcode = Wire(UInt(7.W))
  opcode := 0.U(7.W)
  val rd     = RegInit(0.U(5.W))
  val funct3 = Wire(UInt(3.W))
  funct3 := 0.U(3.W)
  val rs1    = Wire(UInt(5.W))
  rs1 := 0.U(5.W)
  val rs2    = Wire(UInt(5.W))
  rs2 := 0.U(5.W)
  val funct7 = Wire(UInt(7.W))
  funct7 := 0.U(7.W)
  val imm = RegInit(0.U(12.W))
  val writeBackData = Wire(UInt(32.W))
  writeBackData := 0.U(32.W)

  val operandA = RegInit(0.U(32.W))
  val operandB = RegInit(0.U(32.W))
  val aluResult = RegInit(0.U(32.W))

  /*
   * TODO: Implement default case for IOs
   */


  // -----------------------------------------
  // Processor Stages
  // -----------------------------------------

  when (stage === fetch)
  {

    instr := IMem(pc>>2.U)
    stage := decode

  } 
    .elsewhen (stage === decode)
  {
    opcode := instr(6, 0)
    rd     := instr(11, 7)
    funct3 := instr(14, 12)
    rs1    := instr(19, 15)
    rs2    := instr(24, 20)
    funct7 := instr(31, 25)
    imm := instr(31, 20)

    isADD  := (opcode === "b0110011".U && funct3 === "b000".U && funct7 === "b0000000".U) // add
    isSUB  := (opcode === "b0110011".U && funct3 === "b000".U && funct7 === "b0100000".U) // sub
    isSLL  := (opcode === "b0110011".U && funct3 === "b001".U && funct7 === "b0000000".U) // Shift Left Logical
    isSRL  := (opcode === "b0110011".U && funct3 === "b101".U && funct7 === "b0000000".U) // Shift Right Logical
    isSRA  := (opcode === "b0110011".U && funct3 === "b101".U && funct7 === "b0100000".U) // Shift Right Arithmetic
    isXOR  := (opcode === "b0110011".U && funct3 === "b100".U && funct7 === "b0000000".U) // XOR
    isOR   := (opcode === "b0110011".U && funct3 === "b110".U && funct7 === "b0000000".U) // OR
    isAND  := (opcode === "b0110011".U && funct3 === "b111".U && funct7 === "b0000000".U) // AND
    isSLT  := (opcode === "b0110011".U && funct3 === "b010".U && funct7 === "b0000000".U)
    isSLTU  := (opcode === "b0110011".U && funct3 === "b011".U && funct7 === "b0000000".U)

    isADDI := (opcode === "b0010011".U && funct3 === "b000".U)

    operandA := regFile(rs1)
    operandB := regFile(rs2)

    stage := execute

  } 
    .elsewhen (stage === execute)
  {

    when(isADDI) {
      aluResult := operandA + imm
    }.elsewhen(isADD) {
      aluResult := operandA + operandB
    }.elsewhen(isSUB) {
      aluResult := operandA - operandB
    }.elsewhen(isAND) {
      aluResult := operandA & operandB
    }.elsewhen(isOR) {
      aluResult := operandA | operandB
    }.elsewhen(isXOR){
      aluResult := operandA ^ operandB
    }.elsewhen(isSLL) {
      aluResult := operandA << operandB(4, 0) // restrict operandB
    }.elsewhen(isSRL) {
      aluResult := operandA >> operandB(4, 0) // restrict operandA
    }.elsewhen(isSRA) {
      aluResult := (operandA.asSInt >> operandB(4, 0)).asUInt // restrict operandA
    }.elsewhen(isSLTU){
      aluResult := Mux(operandA < operandB, 1.U, 0.U)
    }.elsewhen(isSLT){
      aluResult := Mux(operandA.asSInt < operandB.asSInt, 1.U, 0.U)
    }.otherwise {
      aluResult := "hFFFFFFFF".U // maybe put here nop (how to implement)
      // reise write some high number
    }

    stage := memory

  }
    .elsewhen (stage === memory)
  {

    // No memory operations implemented in this basic CPU

    // TODO: There might still something be missing here

    // nop? or i can even delete this when statement

    stage := writeback

  } 
    .elsewhen (stage === writeback)
  {

    writeBackData := aluResult

    regFile(rd) := writeBackData

    // Check Result
    io.check_res := writeBackData

    // Update PC
    // no jumps or branches, next PC always reads next address from IMEM
    pc := pc + 4.U
    stage := fetch // should i be doing this?

  }
    .otherwise 
  {

     // default case (needed for RTL-generation but should never be reached     

     assert(true.B, "Pipeline FSM must never be left")

  }

}

