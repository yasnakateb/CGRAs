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

class ConfMux 
  (
    numInputs: Int = 2, 
    dataWidth: Int = 1
  )
  extends Module {
  val io = IO(new Bundle { 
    val selector = Input(UInt(log2Ceil(numInputs).W))
    val muxInput = Input(SInt((numInputs*dataWidth).W))
    val muxOutput = Output(SInt(dataWidth.W))
  })
  
  val inputs = Wire(Vec(numInputs, SInt(dataWidth.W))) 

  for (i <- 0 until numInputs) {
    inputs(i) := (io.muxInput((i+1)*dataWidth-1,i*dataWidth)).asSInt
  }
  io.muxOutput := inputs(io.selector)
}

// Generate the Verilog code
object ConfMuxMain extends App {
  println("Generating the hardware")
  (new chisel3.stage.ChiselStage).emitVerilog(new ConfMux(2, 1), Array("--target-dir", "generated"))
}