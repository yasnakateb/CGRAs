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
import chisel3.stage.PrintFullStackTraceAnnotation

class D_Fifo
  (
    dataWidth: Int, 
    fifoDepth: Int
  ) 
  extends Module {
  val io = IO(new Bundle {
    val din = Input(SInt(dataWidth.W))  
    val dinValid = Input(Bool())
    val doutReady = Input(Bool())
    val dinReady = Output(Bool())
    val dout = Output(SInt(dataWidth.W))  
    val doutValid = Output(Bool()) 
  })

  val fifo = Module(new D_Fifo_Imp(dataWidth, fifoDepth))
  fifo.io.clock := clock
  fifo.io.reset := reset.asBool 
  fifo.io.din := io.din 
  fifo.io.dinValid := io.dinValid
  fifo.io.doutReady := io.doutReady
  io.dinReady := fifo.io.dinReady
  io.dout := fifo.io.dout 
  io.doutValid := fifo.io.doutValid 
}

// Generate the Verilog code
object D_Fifo_Main extends App {
  println("Generating the hardware")
  (new chisel3.stage.ChiselStage).emitVerilog(new D_Fifo(32, 32), Array("--target-dir", "generated"))
}