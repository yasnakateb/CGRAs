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

class Fr 
  (
      numberOfValids: Int, 
      numberOfReadys: Int
  ) 
  extends Module {
  val io = IO(new Bundle {
    val validIn = Input(UInt(numberOfValids.W))
    val readyOut = Input(UInt(numberOfReadys.W))
    val validMuxSel = Input(UInt((log2Ceil(numberOfValids).W)))
    val forkMask = Input(UInt(numberOfReadys.W))
    val validOut = Output(Bool())  
  })
  // All wires 
  val aux = Wire(Vec(numberOfReadys+1, Bool()))
  val temp = Wire(Vec(numberOfReadys+1, Bool()))
  val vaux = Wire(SInt(1.W))

  for (i <- 0 until numberOfReadys) {
    aux(i) := ((~io.forkMask(i)) | io.readyOut(i)).asBool
  }
  val confMux  = Module (new ConfMux(numberOfValids, 1))
  confMux.io.selector := io.validMuxSel
  confMux.io.muxInput := (io.validIn).asSInt 
  vaux := confMux.io.muxOutput

  aux(numberOfReadys) := vaux(0).asBool 
  temp(0) := aux(0)

  for (i <- 1 until numberOfReadys+1) {
    temp(i) := temp(i-1) & aux(i)
  }
  io.validOut := temp(numberOfReadys)   
}

// Generate the Verilog code
object FrMain extends App {
  println("Generating the hardware")
  (new chisel3.stage.ChiselStage).emitVerilog(new Fr(5, 5), Array("--target-dir", "generated"))
}