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

object operations
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
  
import operations._
 
class Alu 
  (
    dataWidth: Int, 
    opWidth: Int
  )
  extends Module {
  val io = IO(new Bundle {
    val din1 = Input(SInt(dataWidth.W))
    val din2 = Input(SInt(dataWidth.W))
    val dout = Output(SInt(dataWidth.W))
    val opConfig = Input(UInt(opWidth.W))
  })
  // Result 
  val outAux = Wire(SInt((dataWidth).W))

  when (io.opConfig === SUM) {                               // SUM
    outAux := io.din1 + io.din2                            
  }
  .elsewhen (io.opConfig === MUL) {                          // MUL
    outAux := io.din1 * io.din2                            
  } 
  .elsewhen (io.opConfig === SUB) {                          // SUB
    outAux := io.din1 - io.din2                            
  }
  .elsewhen (io.opConfig === SLL) {                          // SLL
    outAux := io.din1 << (io.din2(18, 0)).asUInt
  } 
  .elsewhen (io.opConfig === SRA) {                          // SRA
    outAux := io.din1 >> io.din2.asUInt
  } 
  .elsewhen (io.opConfig === SRL) {                          // SRL
    outAux := (io.din1.asUInt >> io.din2.asUInt).asSInt                            
  }
  .elsewhen (io.opConfig === AND) {                          // AND
    outAux := io.din1 & io.din2                            
  } 
  .elsewhen (io.opConfig === OR) {                           // OR
    outAux := io.din1 | io.din2                            
  } 
  .elsewhen (io.opConfig === XOR) {                          // XOR
    outAux := io.din1 ^ io.din2                            
  } 
  .otherwise { 
    outAux := 0.S                                            // Default 
  }
  
  io.dout := outAux
}

// Generate the Verilog code
object AluMain extends App {
  println("Generating the hardware")
  (new chisel3.stage.ChiselStage).emitVerilog(new Alu(32, 5), Array("--target-dir", "generated"))
}