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

class D_FIFO_V
    (
        DATA_WIDTH: Int, 
        FIFO_DEPTH: Int
    ) 
    extends BlackBox(Map("DATA_WIDTH" -> DATA_WIDTH, "FIFO_DEPTH" -> FIFO_DEPTH)) with HasBlackBoxResource{ 
    val io = IO(new Bundle {
        // Inputs 
        val din = Input(SInt(DATA_WIDTH.W))  
        val din_v = Input(Bool())
        val dout_r = Input(Bool())

        // Outputs
        val din_r = Output(Bool())
        val dout = Output(SInt(DATA_WIDTH.W))  
        val dout_v = Output(Bool()) 
    })


    addResource("/vsrc/D_FIFO.v")

}


// Generate the Verilog code
object D_FIFOMain extends App {
    println("Generating the hardware")
    (new chisel3.stage.ChiselStage).emitVerilog(new D_FIFO(32, 32), Array("--target-dir", "generated"))
}

