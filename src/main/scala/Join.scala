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
        DATA_WIDTH: Int
    )
    extends Module {
    val io = IO(new Bundle {
        //  Inputs
        val din_1 = Input(UInt(DATA_WIDTH.W))
        val din_2 = Input(UInt(DATA_WIDTH.W))
        val dout_r = Input(Bool())
        val din_1_v = Input(Bool())
        val din_2_v = Input(Bool())

        // Outputs
        val dout_v = Output(Bool())
        val din_1_r = Output(Bool())
        val din_2_r = Output(Bool())
        val dout_1 = Output(UInt(DATA_WIDTH.W))
        val dout_2 = Output(UInt(DATA_WIDTH.W))
    })

    io.dout_1 := io.din_1
    io.dout_2 := io.din_2 

    io.dout_v := io.din_1_v & io.din_2_v

    io.din_1_r := io.dout_r & io.din_2_v 
    io.din_2_r := io.dout_r & io.din_1_v       
}

// Generate the Verilog code
object JoinMain extends App {
    println("Generating the hardware")
    (new chisel3.stage.ChiselStage).emitVerilog(new Join(32), Array("--target-dir", "generated"))
}
