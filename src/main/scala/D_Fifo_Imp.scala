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
import chisel3.util.HasBlackBoxResource
import chisel3.experimental.{IntParam, BaseModule}

class D_Fifo_Imp
  (
    dataWidth: Int, 
    fifoDepth: Int
  ) 
  extends BlackBox(Map("dataWidth" -> dataWidth, "fifoDepth" -> fifoDepth)) with HasBlackBoxResource{ 
  val io = IO(new Bundle {
    val clock = Input(Clock())
    val reset = Input(Bool())
    val din = Input(SInt(dataWidth.W))  
    val dinValid = Input(Bool())
    val doutReady = Input(Bool())
    val dinReady = Output(Bool())
    val dout = Output(SInt(dataWidth.W))  
    val doutValid = Output(Bool()) 
  })

  addResource("vsrc/D_Fifo_Imp.v")
}