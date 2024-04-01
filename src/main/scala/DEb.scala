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
 * The Elastic Buffer operates as a 2-slot FIFO, utilizing latches or flip-flops for implementation. 
 * When EBs are adjacent, they synchronize data transfer (D) through a set of control signals: 
 * a forward data-presence valid signal (V) indicating the presence of data or emptiness within the EB, 
 * and a back-propagating stall/accept (A) signal, indicating if the EB is stalled or ready to receive new data. 
 * A generalized EB extends this concept to an N-slot FIFO, typically realized through RAM implementation.
 **/

import chisel3._
import chisel3.util._

class DEb 
  (
    dataWidth: Int
  )
  extends Module {
  val io = IO(new Bundle {
    val din = Input(SInt(dataWidth.W))
    val dinValid = Input(Bool())
    val dinReady = Output(Bool())
    val dout = Output(SInt(dataWidth.W))
    val doutValid = Output(Bool())
    val doutReady = Input(Bool())  
  })

  val regDin1 = RegInit(0.S(dataWidth.W))
  val regDin2 = RegInit(0.S(dataWidth.W))
  val regDinValid1 = RegInit(0.B)
  val regDinValid2 = RegInit(0.B)
  val regAreg = RegInit(0.B)

  when(regAreg) {
    regDin1 := io.din
    regDin2 := regDin1
    
    regDinValid1 := io.dinValid
    regDinValid2 := regDinValid1
  }

  regAreg := ~io.doutValid | io.doutReady

  // Combinational assignments
  io.dinReady := regAreg

  when(regAreg) {
    io.dout := regDin1
    io.doutValid := regDinValid1
  }.otherwise {
    io.dout := regDin2
    io.doutValid := regDinValid2
  }
}
    
// Generate the Verilog code
object DEbMain extends App {
  println("Generating the hardware")
  (new chisel3.stage.ChiselStage).emitVerilog(new DEb(32), Array("--target-dir", "generated"))
}
