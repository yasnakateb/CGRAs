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

class D_Eb 
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
object D_Eb_Main extends App {
  println("Generating the hardware")
  (new chisel3.stage.ChiselStage).emitVerilog(new D_Eb(32), Array("--target-dir", "generated"))
}