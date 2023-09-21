/****************************************** 
 *      \`-._           __                *
 *       \\  `-..____,.'  `.              *
 *        :`.         /    \`.            *
 *        :  )       :      : \           *
 *         ;'        '   ;  |  :          *
 *         )..      .. .:.`.;  :          *
 *        /::...  .:::...   ` ;           *
 *        ; _ '    __        /:\          *
 *        `:o>   /\o_>      ;:. `.        *
 *       `-`.__ ;   __..--- /:.   \       *
 *       === \_/   ;=====_.':.     ;      *
 *        ,/'`--'...`--....        ;      *
 *             ;                    ;     *
 *           .'                      ;    *
 *         .'                        ;    *
 *       .'     ..     ,      .       ;   *
 *      :       ::..  /      ;::.     |   *
 *     /      `.;::.  |       ;:..    ;   *
 *    :         |:.   :       ;:.    ;    *
 *    :         ::     ;:..   |.    ;     *
 *     :       :;      :::....|     |     *
 *     /\     ,/ \      ;:::::;     ;     *
 *   .:. \:..|    :     ; '.--|     ;     *
 *  ::.  :''  `-.,,;     ;'   ;     ;     *
 * .-'. _.'\      / `;      \,__:      \  *
 * `---'    `----'   ;      /    \,.,,,/  *
 *                  `----`                *
 * ****************************************
 * Yasna Katebzadeh                       *
 * yasna.katebzadeh@gmail.com             *
 ******************************************/

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
        val din_1 = Input(SInt(DATA_WIDTH.W))
        val din_2 = Input(SInt(DATA_WIDTH.W))
        val op_config = Input(UInt(OP_WIDTH.W))
        val dout = Output(SInt(DATA_WIDTH.W))
    })
    // Converte din_1 to signed integer for shift right arithmetic (SRA)
    // val din_1_signed = RegInit(0.S(DATA_WIDTH.W))

    val reg_inbit = RegInit(0.U(1.W))
    reg_inbit := 0.U
  

    // Result     
    val out_aux = RegInit(0.S((2*DATA_WIDTH).W))
    
    // Default output 
    io.dout := 0.S 

    when (io.op_config === SUM) {                               // SUM
      out_aux := io.din_1 + io.din_2                            
    }
    .elsewhen (io.op_config === MUL) {                          // MUL
      out_aux := io.din_1 * io.din_2                            
    } 
    .elsewhen (io.op_config === SUB) {                          // SUB
      out_aux := io.din_1 - io.din_2                            
    }
    .elsewhen (io.op_config === SLL) {                          // SLL
      switch(io.din_2.asUInt) {
        is(0.U) {
          out_aux := io.din_1
        }
        is(1.U) {
          out_aux := (Cat(io.din_1(30, 0), reg_inbit)).asSInt
        }
        is(2.U) {
          out_aux := (Cat(io.din_1(29, 0), Fill(2, reg_inbit))).asSInt
        }
        is(3.U) {
          out_aux := (Cat(io.din_1(28, 0), Fill(3, reg_inbit))).asSInt
        }
        is(4.U) {
          out_aux := (Cat(io.din_1(27, 0), Fill(4, reg_inbit))).asSInt
        }
        is(5.U) {
          out_aux := (Cat(io.din_1(26, 0), Fill(5, reg_inbit))).asSInt
        }
        is(6.U) {
          out_aux := (Cat(io.din_1(25, 0), Fill(6, reg_inbit))).asSInt
        }
        is(7.U) {
          out_aux := (Cat(io.din_1(24, 0), Fill(7, reg_inbit))).asSInt
        }
        is(8.U) {
          out_aux := (Cat(io.din_1(23, 0), Fill(8, reg_inbit))).asSInt
        }
        is(9.U) {
          out_aux := (Cat(io.din_1(22, 0), Fill(9, reg_inbit))).asSInt
        }
        is(10.U) {
          out_aux := (Cat(io.din_1(21, 0), Fill(10, reg_inbit))).asSInt
        }
        is(11.U) {
          out_aux := (Cat(io.din_1(20, 0), Fill(11, reg_inbit))).asSInt
        }
        is(12.U) {
          out_aux := (Cat(io.din_1(19, 0), Fill(12, reg_inbit))).asSInt
        }
        is(13.U) {
          out_aux := (Cat(io.din_1(18, 0), Fill(13, reg_inbit))).asSInt
        }
        is(14.U) {
          out_aux := (Cat(io.din_1(17, 0), Fill(14, reg_inbit))).asSInt
        }
        is(15.U) {
          out_aux := (Cat(io.din_1(16, 0), Fill(15, reg_inbit))).asSInt
        }
        is(16.U) {
          out_aux := (Cat(io.din_1(15, 0), Fill(16, reg_inbit))).asSInt
        }
        is(17.U) {
          out_aux := (Cat(io.din_1(14, 0), Fill(17, reg_inbit))).asSInt
        }
        is(18.U) {
          out_aux := (Cat(io.din_1(13, 0), Fill(18, reg_inbit))).asSInt
        }
        is(19.U) {
          out_aux := (Cat(io.din_1(12, 0), Fill(19, reg_inbit))).asSInt
        }
        is(20.U) {
          out_aux := (Cat(io.din_1(11, 0), Fill(20, reg_inbit))).asSInt
        }
        is(21.U) {
          out_aux := (Cat(io.din_1(10, 0), Fill(21, reg_inbit))).asSInt
        }
        is(22.U) {
          out_aux := (Cat(io.din_1(9, 0), Fill(22, reg_inbit))).asSInt
        }
        is(23.U) {
          out_aux := (Cat(io.din_1(8, 0), Fill(23, reg_inbit))).asSInt
        }
        is(24.U) {
          out_aux := (Cat(io.din_1(7, 0), Fill(24, reg_inbit))).asSInt
        }
        is(25.U) {
          out_aux := (Cat(io.din_1(6, 0), Fill(25, reg_inbit))).asSInt
        }
        is(26.U) {
          out_aux := (Cat(io.din_1(5, 0), Fill(26, reg_inbit))).asSInt
        }
        is(27.U) {
          out_aux := (Cat(io.din_1(4, 0), Fill(27, reg_inbit))).asSInt
        }
        is(28.U) {
          out_aux := (Cat(io.din_1(3, 0), Fill(28, reg_inbit))).asSInt
        }
        is(29.U) {
          out_aux := (Cat(io.din_1(2, 0), Fill(29, reg_inbit))).asSInt
        }
        is(30.U) {
          out_aux := (Cat(io.din_1(1, 0), Fill(30, reg_inbit))).asSInt
        }
        is(31.U) {
          out_aux := (Cat(io.din_1(0), Fill(31, reg_inbit))).asSInt
        }
      }      
    } 
    .elsewhen (io.op_config === SRA) {                          // SRA
      //din_1_signed := io.din_1
      out_aux := (io.din_1 >> io.din_2.asUInt)   
    } 
    .elsewhen (io.op_config === SRL) {                          // SRL
      out_aux := io.din_1 >> io.din_2.asUInt                           
    }
    .elsewhen (io.op_config === AND) {                          // AND
      out_aux := io.din_1 & io.din_2                            
    } 
    .elsewhen (io.op_config === OR) {                           // OR
      out_aux := io.din_1 | io.din_2                            
    } 
    .elsewhen (io.op_config === XOR) {                          // XOR
      out_aux := io.din_1 ^ io.din_2                            
    } 
    .elsewhen (io.op_config === MIN) {                          // MIN
      when (io.din_1 <= io.din_2) {
        out_aux := io.din_1                                     
      }  
      .elsewhen(io.din_1 > io.din_2) {
        out_aux := io.din_2                                     
      }                             
    }
    .elsewhen (io.op_config === MAX) {                          // MAX
      when (io.din_1 >= io.din_2) {
        out_aux := io.din_1                                    
      }  
      .elsewhen(io.din_1 < io.din_2) {
        out_aux := io.din_2                                    
      }     
    } 
    .otherwise { 
      out_aux := 0.S                                            // Default 
    }
  io.dout := out_aux
}

// Generate the Verilog code
object ALUMain extends App {
    println("Generating the hardware")
    (new chisel3.stage.ChiselStage).emitVerilog(new ALU(32, 5), Array("--target-dir", "generated"))
}
