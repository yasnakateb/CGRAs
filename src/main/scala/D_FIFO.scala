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

    val memory = Mem(FIFO_DEPTH, UInt(DATA_WIDTH.W))

    val write_pointer = RegInit(0.U(FIFO_DEPTH.W)) 
    val read_pointer = RegInit(0.U(FIFO_DEPTH.W)) 
    val num_data = RegInit(0.U(FIFO_DEPTH.W)) 

    val full = RegInit(0.U) 
    val empty = RegInit(0.U) 
    val rd_en = Wire(Bool())
    val wr_en = Wire(Bool())

    val dout_v = RegInit(0.U) 
    val dout = RegInit(0.U(DATA_WIDTH.W)) 

    empty := true.B
    full := false.B 
    dout := 0.U 
    dout_v := false.B 

    wr_en := io.din_v & (~full) 
    rd_en := io.dout_r & (~empty) 
    
    io.din_r := (~full) 
    

    when (io.dout_r) {
        dout_v := false.B  
    }

    when(full === false.B  &  wr_en === true.B){ 
        memory(write_pointer) := io.din;
        num_data := num_data + 1.U

        when (write_pointer === FIFO_DEPTH.U - 1.U)  {
            write_pointer := 0.U 
        }.otherwise {
            write_pointer := write_pointer + 1.U 
        }
    }            

    // FIX (Read and write at the same time)
    when(empty === false.B  &  rd_en === true.B){ 
        dout := memory(read_pointer)
        dout_v := true.B 
        num_data := num_data - 1.U 
        
        when (read_pointer === FIFO_DEPTH.U - 1.U)  {
            read_pointer := 0.U 
        }.otherwise {
            read_pointer := read_pointer + 1.U  
        }
    } 

    when (num_data === FIFO_DEPTH.U)  {
        full := true.B 
    }.otherwise {
        full := false.B 
    }           

    when (num_data === 0.U)  {
        empty := true.B 
    }.otherwise {
        empty := false.B
    }   

    io.dout_v := dout_v  
    io.dout := dout                    
}

// Generate the Verilog code
object D_FIFOMain extends App {
    println("Generating the hardware")
    (new chisel3.stage.ChiselStage).emitVerilog(new D_FIFO(32, 32), Array("--target-dir", "generated"))
}
