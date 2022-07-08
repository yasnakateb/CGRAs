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
        val din_1 = Input(UInt(DATA_WIDTH.W))
        val din_2 = Input(UInt(DATA_WIDTH.W))
        val op_config = Input(UInt(OP_WIDTH.W))
        val dout = Output(UInt(DATA_WIDTH.W))
    })

    io.dout := 0.U 
    when (io.op_config === SUM) {
      io.dout := io.din_1 + io.din_2                            // SUM
    }
    .elsewhen (io.op_config === MUL) {
      io.dout := io.din_1 * io.din_2                            // MUL
    } 
    .elsewhen (io.op_config === SUB) {
      io.dout := io.din_1 - io.din_2                            // SUB
    }
    .elsewhen (io.op_config === SLL) {
      // io.dout := io.din_1 << io.din_2                           // SLL
      io.dout := 1.U
    } 
    .elsewhen (io.op_config === SRL) {
      io.dout := io.din_1 >> io.din_2                           // SRL
    }
    .elsewhen (io.op_config === AND) {
      io.dout := io.din_1 & io.din_2                            // AND
    } 
    .elsewhen (io.op_config === OR) {
      io.dout := io.din_1 | io.din_2                            // OR
    } 
    .elsewhen (io.op_config === XOR) {
      io.dout := io.din_1 ^ io.din_2                            // XOR
    } 
    .elsewhen (io.op_config === MIN) {                             // MIN
      when (io.din_1 <= io.din_2) {
        io.dout := io.din_1                                      // MIN = din_1 
      }  
      .elsewhen(io.din_1 > io.din_2) {
        io.dout := io.din_2                                      // MIN = din_2
      }                             
    }
    .elsewhen (io.op_config === MAX) {                             // MAX
      when (io.din_1 >= io.din_2) {
        io.dout := io.din_1                                      // MAX = din_1 
      }  
      .elsewhen(io.din_1 < io.din_2) {
        io.dout := io.din_2                                      // MAX = din_2
      }     
    } 
    .otherwise { 
      io.dout := 0.U                                              // Default 
    }
}

// Generate the Verilog code
object ALUMain extends App {
    println("Generating the hardware")
    (new chisel3.stage.ChiselStage).emitVerilog(new ALU(8, 8), Array("--target-dir", "generated"))
}
