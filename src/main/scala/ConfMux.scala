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

/**
 * Multiplexer module that separates a series of input data based on the provided parameters.
 * numInput: The number of inputs to the multiplexer.
 * muxInput: The input data to be separated. Each input is assumed to be of equal size.
 * selector: The index to select the output from the separated input data.
 * muxOutput: The selected output based on the provided selector.
 * Example:
 * If `numInput` is 2 and each input data is 8 bits the multiplexer separates it 
 * into 2 separate data, each containing 4 bits. If `selector` is 0, it returns the first 4 bits.
 **/

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
