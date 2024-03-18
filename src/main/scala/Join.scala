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

class Join 
  (
    dataWidth: Int
  )
  extends Module {
  val io = IO(new Bundle {
    val din1 = Input(SInt(dataWidth.W))
    val din2 = Input(SInt(dataWidth.W))
    val doutReady = Input(Bool())
    val din1Valid = Input(Bool())
    val din2Valid = Input(Bool())
    val doutValid = Output(Bool())
    val din1Ready = Output(Bool())
    val din2Ready = Output(Bool())
    val dout1 = Output(SInt(dataWidth.W))
    val dout2 = Output(SInt(dataWidth.W))
  })

  io.dout1 := io.din1
  io.dout2 := io.din2 
  io.doutValid := io.din1Valid & io.din2Valid
  io.din1Ready := io.doutReady & io.din2Valid 
  io.din2Ready := io.doutReady & io.din1Valid       
}

// Generate the Verilog code
object JoinMain extends App {
  println("Generating the hardware")
  (new chisel3.stage.ChiselStage).emitVerilog(new Join(32), Array("--target-dir", "generated"))
}