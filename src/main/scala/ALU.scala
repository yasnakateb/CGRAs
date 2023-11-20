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
    def MIN = 10.U   // Minimum (NOT IMPLEMENTED)
    def MAX = 11.U   // Maximum (NOT IMPLEMENTED)
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

    // Result 
    val out_aux = Wire(SInt((DATA_WIDTH).W))
    
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

      out_aux := io.din_1 << (io.din_2(18, 0)).asUInt
    } 
    .elsewhen (io.op_config === SRA) {                          // SRA
      out_aux := io.din_1 >> io.din_2.asUInt
    } 
    .elsewhen (io.op_config === SRL) {                          // SRL
      out_aux := (io.din_1.asUInt >> io.din_2.asUInt).asSInt                            
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