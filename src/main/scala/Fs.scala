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
 * The Fork Sender's responsibility is to verify the readiness of all potential destinations 
 * for the input data. The AND gate in this block ensures that the valid signal is asserted only 
 * when the Fork Sender confirms that all receivers are available.
 **/

import chisel3._
import chisel3.util._

class Fs 
  (
    numberOfReadys: Int
  )
  extends Module {
  val io = IO(new Bundle {
    val readyOut = Input(UInt(numberOfReadys.W))
    val forkMask = Input(UInt(numberOfReadys.W))
    val readyIn = Output(Bool())  
  })
  
  val aux = Wire(Vec(numberOfReadys, Bool()))
  val temp = Wire(Vec(numberOfReadys, Bool()))

  for (i <- 0 until numberOfReadys) {
    aux(i) := ((~io.forkMask(i)) | io.readyOut(i)).asBool
  }

  temp(0) := aux(0) 

  for (i <- 1 until numberOfReadys) {
    temp(i) := temp(i-1) & aux(i)
  }
  io.readyIn := temp(numberOfReadys - 1).asBool   
}

// Generate the Verilog code
object FsMain extends App {
    println("Generating the hardware")
    (new chisel3.stage.ChiselStage).emitVerilog(new Fs(5), Array("--target-dir", "generated"))
} 
