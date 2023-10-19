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

class D_FIFO
    (
        DATA_WIDTH: Int, 
        FIFO_DEPTH: Int
    ) 
    extends Module {
    val io = IO(new Bundle {
        // Inputs 
        val din = Input(UInt(DATA_WIDTH.W))  
        val din_v = Input(Bool())
        val dout_r = Input(Bool())

        // Outputs
        val din_r = Output(Bool())
        val dout = Output(UInt(DATA_WIDTH.W))  
        val dout_v = Output(Bool()) 
    })

    val cntWrite = RegInit(0.U(log2Ceil(FIFO_DEPTH).W))
    val cntRead = RegInit(0.U(log2Ceil(FIFO_DEPTH).W))
    val cntData = RegInit(0.U(log2Ceil(FIFO_DEPTH + 1).W))

    val mem = SyncReadMem(FIFO_DEPTH, UInt(DATA_WIDTH.W))

    val wen = Wire(Bool())
    val ren = Wire(Bool())
    val empty = Wire(Bool())
    val full = Wire(Bool())
    val dout_v = RegNext(0.U) 

    io.din_r := ~full 
    wen := io.din_v & ~full
    ren := io.dout_r & ~empty

    dout_v := ren
    
    io.dout_v := dout_v 
    // Write pointer
    when(wen & ~full) {
        when(cntWrite === FIFO_DEPTH.U - 1.U) {
        cntWrite := 0.U
        }.otherwise {
        cntWrite := cntWrite + 1.U
        }
    }

    // Read pointer
    when(ren & ~empty) {
        when(cntRead === FIFO_DEPTH.U - 1.U) {
            cntRead := 0.U
        }.otherwise {
            cntRead := cntRead + 1.U
        }
        }

    // Data counter
    when((wen & ~ full) & ~(ren & ~empty)) {
        cntData := cntData + 1.U
        }.elsewhen(~(wen & ~full) & (ren & ~empty)) {
        cntData := cntData - 1.U
    }

    // Memory access
    when(wen & ~full) {
        mem.write(cntWrite, io.din)
        }
    io.dout := mem.read(cntRead)

    // Control signal generation
    when(cntData === FIFO_DEPTH.U) {
        full := true.B
        }.otherwise {
        full := false.B
    }
    when(cntData === 0.U) {
        empty := true.B
        }.otherwise {
        empty := false.B
    }

}

// Generate the Verilog code
object D_FIFOMain extends App {
    println("Generating the hardware")
    (new chisel3.stage.ChiselStage).emitVerilog(new D_FIFO(32, 32), Array("--target-dir", "generated"))
}
