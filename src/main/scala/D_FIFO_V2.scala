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

class D_FIFO_V2 
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

    val mem_r_en = Wire(Bool())
    val mem_w_en = Wire(Bool())


    val cnt_w_en = Wire(Bool())
    val cnt_r_en = Wire(Bool())

    val dout_v = RegNext(0.U) 


    val full = Wire(Bool())


    val empty = Wire(Bool())

    val cnt_w = RegInit(0.U(FIFO_DEPTH.W)) 
    val cnt_r = RegInit(0.U(FIFO_DEPTH.W)) 
    val cnt_data = RegInit(0.U(FIFO_DEPTH.W)) 

    mem_w_en := io.din_v & (~full) 
    mem_r_en := io.dout_r & (~empty) 

    cnt_w_en := mem_r_en
    cnt_r_en := mem_w_en

    

    dout_v := mem_r_en


   
    

    // Reference io is not fully initialized. io.dout <= mux(_T_14, memory.io_dout_MPORT.data, VOID

    val mem_dout = RegInit(UInt(DATA_WIDTH.W), 0.U) 

    
    
    /// Counter Write 
    when (cnt_w_en === true.B)  {
        when (cnt_w === FIFO_DEPTH.U - 1.U)  {
            cnt_w := 0.U 
        }.otherwise {
            cnt_w := cnt_w + 1.U 
        }
    }

    /// Counter Read 
    when (cnt_r_en === true.B)  {
        when (cnt_r === FIFO_DEPTH.U - 1.U)  {
            cnt_r := 0.U 
        }.otherwise {
            cnt_r := cnt_r + 1.U 
        }
    }
       
    /// Counter Num Data 
    when (mem_w_en === true.B &  mem_r_en === false.B)  {
        cnt_data := cnt_data + 1.U  
    
    }

    when (mem_w_en === false.B &  mem_r_en === true.B)  {
        cnt_data := cnt_data - 1.U  
    
    }


    
    // Memory 
    when(mem_r_en === true.B){ 
        mem_dout := memory(cnt_r)

    }
    
    when(mem_w_en === true.B){ 
        memory(cnt_w) := io.din 
    }
    


    when (cnt_data === FIFO_DEPTH.U)  {
        full := true.B 
    }.otherwise {
        full := false.B 
    }           

    when (cnt_data === 0.U)  {
        empty := true.B 
    }.otherwise {
        empty := false.B
    }  

    // 2 
    io.dout_v := dout_v 

    // 3  
    io.dout := mem_dout 

    // 1 
    io.din_r := (~full) 

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
object D_FIFO_V2Main extends App {
    println("Generating the hardware")
    (new chisel3.stage.ChiselStage).emitVerilog(new D_FIFO_V2(32, 32), Array("--target-dir", "generated"))
}
