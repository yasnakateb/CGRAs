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

class D_FIFO_V3 
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

    // Create a synchronous memory
    val mem = SyncReadMem(FIFO_DEPTH, UInt(DATA_WIDTH.W))

    // Pointers for read and write
    val readPtr = RegInit(0.U(log2Ceil(FIFO_DEPTH).W))
    val writePtr = RegInit(0.U(log2Ceil(FIFO_DEPTH).W))

    // Write data to the memory when valid is asserted
    when(io.din_v) {
        mem.write(writePtr, io.din)
        writePtr := Mux(writePtr === (FIFO_DEPTH - 1).U, 0.U, writePtr + 1.U)
    }

    // Read data from the memory when read request is asserted
    io.dout := mem.read(readPtr, io.dout_r)
    io.din_r := readPtr === writePtr && !io.din_v

    // Update read pointer
    when(io.dout_r && io.dout_v) {
        readPtr := Mux(readPtr === (FIFO_DEPTH - 1).U, 0.U, readPtr + 1.U)
    }

    // Output valid signal
    io.dout_v := io.dout_r





    //////////////////////////////////////////////////////////////////////////////////////////
    /*
    val write_pointer = RegInit(0.U(FIFO_DEPTH.W)) 
    val read_pointer = RegInit(0.U(FIFO_DEPTH.W)) 
    val num_data = RegInit(0.U(FIFO_DEPTH.W)) 

    val full = RegInit(0.U) 
    val empty = RegInit(0.U) 
    val rd_en = Wire(Bool())
    val wr_en = Wire(Bool())

    
    val dout = RegInit(0.U(DATA_WIDTH.W)) 

    empty := true.B
    full := false.B 
    dout := 0.U 
    dout_v := false.B 

    
    
    

    when (io.dout_r) {
        dout_v := false.B  
    }


    when(full === false.B  &  wr_en === true.B){ 
        num_data := num_data + 1.U

    }.elsewhen(empty === false.B  &  rd_en === true.B){ 
        num_data := num_data - 1.U 

    }.otherwise{
        num_data := num_data 
        
    }


    when(full === false.B  &  wr_en === true.B){ 
        memory(write_pointer) := io.din;
        // num_data := num_data + 1.U

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
        // num_data := num_data - 1.U 
        
        when (read_pointer === FIFO_DEPTH.U - 1.U)  {
            read_pointer := 0.U 
        }.otherwise {
            read_pointer := read_pointer + 1.U  
        }
    } 

    */
    
         
}

// Generate the Verilog code
object D_FIFO_V3Main extends App {
    println("Generating the hardware")
    (new chisel3.stage.ChiselStage).emitVerilog(new D_FIFO_V3(32, 32), Array("--target-dir", "generated"))
}
