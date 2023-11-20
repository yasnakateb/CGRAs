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

class D_REG 
    (
        DATA_WIDTH: Int
    )
    extends Module {
    val io = IO(new Bundle {
        val din = Input(SInt(DATA_WIDTH.W))
        val din_v = Input(Bool())
        val dout_r = Input(Bool())
        val dout = Output(SInt(DATA_WIDTH.W))
        val dout_v = Output(Bool())
        val din_r = Output(Bool())  
    })

    
    val data = RegInit(0.S(DATA_WIDTH.W))
    val valid = RegInit(0.B)

    // Default value 
    data := 0.S  
    valid := false.B 
    
    when (io.dout_r === true.B) {
        data := io.din
        valid := io.din_v
    } 

    io.dout := data
    io.dout_v := valid
    io.din_r := io.dout_r
}

// Generate the Verilog code
object D_REGMain extends App {
    println("Generating the hardware")
    (new chisel3.stage.ChiselStage).emitVerilog(new D_REG(8), Array("--target-dir", "generated"))
}