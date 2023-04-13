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

class D_EB 
    (
        DATA_WIDTH: Int
    )
    extends Module {
    val io = IO(new Bundle {
        // Data in
        val din = Input(UInt(DATA_WIDTH.W))
        val din_v = Input(Bool())
        val din_r = Output(Bool())
        // Data out
        val dout = Output(UInt(DATA_WIDTH.W))
        val dout_v = Output(Bool())
        val dout_r = Input(Bool())  
    })

    // Registers
    val reg_din_1 = RegInit(0.U(DATA_WIDTH.W))
    val reg_din_2 = RegInit(0.U(DATA_WIDTH.W))
    val reg_din_v_1 = RegInit(0.B)
    val reg_din_v_2 = RegInit(0.B)
    val reg_areg = RegInit(0.B)

    when(reg_areg) {
        reg_din_1 := io.din
        reg_din_2 := reg_din_1
        
        reg_din_v_1 := io.din_v
        reg_din_v_2 := reg_din_v_1
    }

    reg_areg := ~io.dout_v | io.dout_r

    // Combinational assignments
    io.din_r := reg_areg

    when(reg_areg) {
        io.dout := reg_din_1
        io.dout_v := reg_din_v_1
    }.otherwise {
        io.dout := reg_din_2
        io.dout_v := reg_din_v_2
    }
}

// Generate the Verilog code
object D_EBMain extends App {
    println("Generating the hardware")
    (new chisel3.stage.ChiselStage).emitVerilog(new D_EB(32), Array("--target-dir", "generated"))
}
