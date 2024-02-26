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

class D_Reg
  (
    dataWidth: Int
  )
  extends Module {
  val io = IO(new Bundle {
    val din = Input(SInt(dataWidth.W))
    val dinValid = Input(Bool())
    val doutReady = Input(Bool())
    val dout = Output(SInt(dataWidth.W))
    val doutValid = Output(Bool())
    val dinReady = Output(Bool())  
  })

  val data = RegInit(0.S(dataWidth.W))
  val valid = RegInit(0.B)

  data := 0.S  
  valid := false.B 
  
  when (io.doutReady === true.B) {
    data := io.din
    valid := io.dinValid
  } 
  io.dout := data
  io.doutValid := valid
  io.dinReady := io.doutReady
}

// Generate the Verilog code
object D_Reg_Main extends App {
  println("Generating the hardware")
  (new chisel3.stage.ChiselStage).emitVerilog(new D_Reg(8), Array("--target-dir", "generated"))
}