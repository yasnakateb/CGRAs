import chisel3._
import chisel3.util._

object ALU
{
    def SUM = 0.U    // Summation  
    def MUL = 1.U    // Multiplication
    def SUB = 2.U    // Subtraction
    def SLL = 3.U    // Shift Left Logical
    def SRL = 4.U    // Shift Right Logical
    def AND = 5.U    // And 
    def OR  = 6.U    // Or
    def XOR = 7.U    // Xor 
    def MIN = 8.U    // Minimum
    def MAX = 9.U    // Maximum
}

import ALU._
 
class ALU (DATA_WIDTH: Int, OP_WIDTH: Int)extends Module {
    val io = IO(new Bundle {
        val d_in_1 = Input(UInt(DATA_WIDTH.W))
        val d_in_2 = Input(UInt(DATA_WIDTH.W))
        val op_config = Input(UInt(OP_WIDTH.W))
        val d_out = Output(UInt(DATA_WIDTH.W))
    })

    io.d_out := 0.U 
    when (io.op_config === SUM) {
      io.d_out := io.d_in_1 + io.d_in_2                            // SUM
    }
    .elsewhen (io.op_config === MUL) {
      io.d_out := io.d_in_1 * io.d_in_2                            // MUL
    } 
    .elsewhen (io.op_config === SUB) {
      io.d_out := io.d_in_1 - io.d_in_2                            // SUB
    }
    .elsewhen (io.op_config === SLL) {
      io.d_out := io.d_in_1 << io.d_in_2                           // SLL
    } 
    .elsewhen (io.op_config === SRL) {
      io.d_out := io.d_in_1 >> io.d_in_2                           // SRL
    }
    .elsewhen (io.op_config === AND) {
      io.d_out := io.d_in_1 & io.d_in_2                            // AND
    } 
    .elsewhen (io.op_config === OR) {
      io.d_out := io.d_in_1 | io.d_in_2                            // OR
    } 
    .elsewhen (io.op_config === XOR) {
      io.d_out := io.d_in_1 ^ io.d_in_2                            // XOR
    } 
    .elsewhen (io.op_config === MIN) {                             // MIN
      when (io.d_in_1 <= io.d_in_2) {
        io.d_out := io.d_in_1                                      // MIN = d_in_1 
      }  
      .elsewhen(io.d_in_1 > io.d_in_2) {
        io.d_out := io.d_in_2                                      // MIN = d_in_2
      }                             
    }
    .elsewhen (io.op_config === MAX) {                             // MAX
      when (io.d_in_1 >= io.d_in_2) {
        io.d_out := io.d_in_1                                      // MAX = d_in_1 
      }  
      .elsewhen(io.d_in_1 < io.d_in_2) {
        io.d_out := io.d_in_2                                      // MAX = d_in_2
      }     
    } 
    .otherwise { 
      io.d_out := 0.U                                              // Default 
    }
}

// Generate the Verilog code
object ALUMain extends App {
    println("Generating the hardware")
    (new chisel3.stage.ChiselStage).emitVerilog(new ALU(8, 8), Array("--target-dir", "generated"))
}
