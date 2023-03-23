///////////////////////////////////////
//                                   //
//      Arithmetic Logic Unit        //
//                                   //
///////////////////////////////////////

import chisel3._
import chisel3.util._

object ALU
{
    def SUM = 0.U    // Summation  
    def MUL = 1.U    // Multiplication
    def SUB = 2.U    // Subtraction
    def SLL = 3.U    // Shift Left Logical
    def SRA = 4.U    // Shift Right Arithmetic
    def SRL = 5.U    // Shift Right Logical
    def AND = 6.U    // And 
    def OR  = 7.U    // Or
    def XOR = 8.U    // Xor 
    def DIV = 9.U    // Div (NOT IMPLEMENTED)
    def MIN = 10.U   // Minimum
    def MAX = 11.U   // Maximum
}

import ALU._
 
class ALU 
    (
      DATA_WIDTH: Int, 
      OP_WIDTH: Int
    )
    extends Module {
    val io = IO(new Bundle {
        val din_1 = Input(UInt(DATA_WIDTH.W))
        val din_2 = Input(UInt(DATA_WIDTH.W))
        val op_config = Input(UInt(OP_WIDTH.W))
        val dout = Output(UInt(DATA_WIDTH.W))
    })

    // Converting din_1 to signed integer for shift right arithmetic
    val din_1_signed = RegInit(0.S(DATA_WIDTH.W))

    // Store din_1 in reg_out for barrel shifter 
    val reg_out = RegInit(0.U(32.W))
    reg_out := io.din_1 
    val reg_inbit = RegInit(0.U(1.W))
    reg_inbit := io.din_1(31)
    
    // Default output 
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

    //////////////////////////////////////////////////////////////////////
    // A shift left logical of one position moves each bit to the left 
    // by one. The low-order bit (the right-most bit) is replaced by 
    // a zero bit and the high-order bit (the left-most bit) is discarded.
    ///////////////////////////////////////////////////////////////////////

    .elsewhen (io.op_config === SLL) {                          // SLL
      switch(io.din_2) {
        is(0.U) {
          io.dout := reg_out
        }
        is(1.U) {
          io.dout := Cat(reg_out(30, 0), reg_inbit)
        }
        is(2.U) {
          io.dout := Cat(reg_out(29, 0), Fill(2, reg_inbit))
        }
        is(3.U) {
          io.dout := Cat(reg_out(28, 0), Fill(3, reg_inbit))
        }
        is(4.U) {
          io.dout := Cat(reg_out(27, 0), Fill(4, reg_inbit))
        }
        is(5.U) {
          io.dout := Cat(reg_out(26, 0), Fill(5, reg_inbit))
        }
        is(6.U) {
          io.dout := Cat(reg_out(25, 0), Fill(6, reg_inbit))
        }
        is(7.U) {
          io.dout := Cat(reg_out(24, 0), Fill(7, reg_inbit))
        }
        is(8.U) {
          io.dout := Cat(reg_out(23, 0), Fill(8, reg_inbit))
        }
        is(9.U) {
          io.dout := Cat(reg_out(22, 0), Fill(9, reg_inbit))
        }
        is(10.U) {
          io.dout := Cat(reg_out(21, 0), Fill(10, reg_inbit))
        }
        is(11.U) {
          io.dout := Cat(reg_out(20, 0), Fill(11, reg_inbit))
        }
        is(12.U) {
          io.dout := Cat(reg_out(19, 0), Fill(12, reg_inbit))
        }
        is(13.U) {
          io.dout := Cat(reg_out(18, 0), Fill(13, reg_inbit))
        }
        is(14.U) {
          io.dout := Cat(reg_out(17, 0), Fill(14, reg_inbit))
        }
        is(15.U) {
          io.dout := Cat(reg_out(16, 0), Fill(15, reg_inbit))
        }
        is(16.U) {
          io.dout := Cat(reg_out(15, 0), Fill(16, reg_inbit))
        }
        is(17.U) {
          io.dout := Cat(reg_out(14, 0), Fill(17, reg_inbit))
        }
        is(18.U) {
          io.dout := Cat(reg_out(13, 0), Fill(18, reg_inbit))
        }
        is(19.U) {
          io.dout := Cat(reg_out(12, 0), Fill(19, reg_inbit))
        }
        is(20.U) {
          io.dout := Cat(reg_out(11, 0), Fill(20, reg_inbit))
        }
        is(21.U) {
          io.dout := Cat(reg_out(10, 0), Fill(21, reg_inbit))
        }
        is(22.U) {
          io.dout := Cat(reg_out(9, 0), Fill(22, reg_inbit))
        }
        is(23.U) {
          io.dout := Cat(reg_out(8, 0), Fill(23, reg_inbit))
        }
        is(24.U) {
          io.dout := Cat(reg_out(7, 0), Fill(24, reg_inbit))
        }
        is(25.U) {
          io.dout := Cat(reg_out(6, 0), Fill(25, reg_inbit))
        }
        is(26.U) {
          io.dout := Cat(reg_out(5, 0), Fill(26, reg_inbit))
        }
        is(27.U) {
          reg_out := Cat(reg_out(4, 0), Fill(27, reg_inbit))
        }
        is(28.U) {
          io.dout := Cat(reg_out(3, 0), Fill(28, reg_inbit))
        }
        is(29.U) {
          io.dout := Cat(reg_out(2, 0), Fill(29, reg_inbit))
        }
        is(30.U) {
          io.dout := Cat(reg_out(1, 0), Fill(30, reg_inbit))
        }
        is(31.U) {
          io.dout := Cat(reg_out(0), Fill(31, reg_inbit))
        }
      }      
    } 

    ///////////////////////////////////////////////////////////////////////
    // An arithmetic right shift fills bits vacated by the right shift with 
    // the value of the most significant bit, which indicates the sign of 
    // the number in twos complement notation.
    ///////////////////////////////////////////////////////////////////////
    
    .elsewhen (io.op_config === SRA) {
      din_1_signed := io.din_1.asSInt
      io.dout := (din_1_signed >> io.din_2).asUInt              // SRA
    } 

    ///////////////////////////////////////////////////////////////////////
    // When shifting right with a logical right shift, the 
    // least-significant bit is lost and a 0 is inserted on the other end.
    ///////////////////////////////////////////////////////////////////////

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
    .elsewhen (io.op_config === MIN) {                          // MIN
      when (io.din_1 <= io.din_2) {
        io.dout := io.din_1                                     // If din_1 <= din_2 then MIN = din_1 
      }  
      .elsewhen(io.din_1 > io.din_2) {
        io.dout := io.din_2                                     // If din_1 > din_2 then MIN = din_2
      }                             
    }
    .elsewhen (io.op_config === MAX) {                          // MAX
      when (io.din_1 >= io.din_2) {
        io.dout := io.din_1                                     // If din_1 >= din_2 then MAX = din_1 
      }  
      .elsewhen(io.din_1 < io.din_2) {
        io.dout := io.din_2                                     // If din_1 < din_2 then MAX = din_2
      }     
    } 
    .otherwise { 
      io.dout := 0.U                                            // Default 
    }
}

// Generate the Verilog code
object ALUMain extends App {
    println("Generating the hardware")
    (new chisel3.stage.ChiselStage).emitVerilog(new ALU(32, 5), Array("--target-dir", "generated"))
}