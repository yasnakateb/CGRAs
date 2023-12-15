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

class FS 
    (
        NUMBER_OF_READYS: Int
    )
    extends Module {
    val io = IO(new Bundle {
        // Inputs
        val ready_out = Input(UInt(NUMBER_OF_READYS.W))
        val fork_mask = Input(UInt(NUMBER_OF_READYS.W))
       
        // Outputs
        val ready_in = Output(Bool())  
    })
    // All wires
    val aux = Wire(Vec(NUMBER_OF_READYS, Bool()))
    val temp = Wire(Vec(NUMBER_OF_READYS, Bool()))

    for (i <- 0 until NUMBER_OF_READYS) {
        aux(i) := ((~io.fork_mask(i)) | io.ready_out(i)).asBool
    }

    temp(0) := aux(0) 

    for (i <- 1 until NUMBER_OF_READYS) {
        temp(i) := temp(i-1) & aux(i)
    }

    io.ready_in := temp(NUMBER_OF_READYS - 1).asBool   
}

// Generate the Verilog code
object FSMain extends App {
    println("Generating the hardware")
    (new chisel3.stage.ChiselStage).emitVerilog(new FS(5), Array("--target-dir", "generated"))
} 