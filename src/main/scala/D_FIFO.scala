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
        val din = Input(SInt(DATA_WIDTH.W))  
        val din_v = Input(Bool())
        val dout_r = Input(Bool())

        // Outputs
        val din_r = Output(Bool())
        val dout = Output(SInt(DATA_WIDTH.W))  
        val dout_v = Output(Bool()) 
    })


    val fifo = Module(new D_FIFO_V(DATA_WIDTH, FIFO_DEPTH))

    fifo.io.clock := clock 
    fifo.io.reset := reset.asBool //|| rocc.io.clear

    fifo.io.din := io.din 
    fifo.io.din_v := io.din_v
    fifo.io.dout_r := io.dout_r

    // Outputs
    io.din_r := fifo.io.din_r
    io.dout  := fifo.io.dout 
    io.dout_v := fifo.io.dout_v 
}


// Generate the Verilog code
object D_FIFOMain extends App {
    println("Generating the hardware")
    (new chisel3.stage.ChiselStage).emitVerilog(new D_FIFO(32, 32), Array("--target-dir", "generated"))
}

/*
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
        val din = Input(SInt(DATA_WIDTH.W))  
        val din_v = Input(Bool())
        val dout_r = Input(Bool())

        // Outputs
        val din_r = Output(Bool())
        val dout = Output(SInt(DATA_WIDTH.W))  
        val dout_v = Output(Bool()) 
    })

    val cntWrite = RegInit(0.U(log2Ceil(FIFO_DEPTH).W))
    val cntRead = RegInit(0.U(log2Ceil(FIFO_DEPTH).W))
    val cntData = RegInit(0.U(log2Ceil(FIFO_DEPTH + 1).W))

    val mem = SyncReadMem(FIFO_DEPTH, SInt(DATA_WIDTH.W))

    val wen = Wire(Bool())
    val ren = Wire(Bool())
    //val empty = RegNext(0.B) 
    //val full = RegNext(0.B) 
    val empty = Wire(Bool())
    val full = Wire(Bool())
    
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
    when((wen & ~full) & ~(ren & ~empty)) {
        cntData := cntData + 1.U
        }.elsewhen(~(wen & ~full) & (ren & ~empty)) {
        cntData := cntData - 1.U
    }

    // Memory access
    when(wen & ~full) {
        mem.write(cntWrite, io.din)
        }
    io.dout := mem.read(cntRead)

    
    io.dout_v := ~empty 

    /*
    val dout_v = RegNext(0.U) 
    dout_v :=  ~empty
    io.dout_v := dout_v
    */
    
    
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

    io.din_r := ~full 
    wen := io.din_v & ~full
    ren := io.dout_r & ~empty

    //wen := io.din_v
    //ren := io.dout_r
}

// Generate the Verilog code
object D_FIFOMain extends App {
    println("Generating the hardware")
    (new chisel3.stage.ChiselStage).emitVerilog(new D_FIFO(32, 32), Array("--target-dir", "generated"))
}
*/
