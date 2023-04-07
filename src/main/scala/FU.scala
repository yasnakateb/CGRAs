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

object FU
{
    def STATE_0 = 0.U(2.W)    // 00
    def STATE_1 = 1.U(2.W)    // 01
    def STATE_2 = 2.U(2.W)    // 10
    def STATE_3 = 3.U(2.W)    // 11
}

import FU._

class FU 
    (
        DATA_WIDTH: Int, 
        OP_WIDTH: Int
    )
    extends Module {
    val io = IO(new Bundle {
        //  Inputs
        val din_1 = Input(UInt(DATA_WIDTH.W))
        val din_2 = Input(UInt(DATA_WIDTH.W))
        val din_v = Input(Bool())
        val dout_r = Input(Bool())

        //  Config ports
        val loop_source = Input(UInt(2.W))
        val iterations_reset = Input(UInt(16.W))
        val op_config = Input(UInt(OP_WIDTH.W))

        // Outputs
        val din_r = Output(Bool())
        val dout = Output(UInt(DATA_WIDTH.W))
        val dout_v = Output(Bool()) 
    })

    val alu_din_1 = Wire(UInt(DATA_WIDTH.W))
    val alu_din_2 = Wire(UInt(DATA_WIDTH.W))
    
    val alu_dout = Wire(UInt(DATA_WIDTH.W))
    val dout_reg = RegInit(0.U(DATA_WIDTH.W))
    // Fix
    // 2 ** 16 - 1
    val count = RegInit(0.U(16.W))

    val loaded = RegInit(0.U(1.W))
    val valid = RegInit(0.U(1.W))

    val ALU = Module (new ALU(DATA_WIDTH, OP_WIDTH))
    ALU.io.din_1 := alu_din_1
    ALU.io.din_2 := alu_din_2
    alu_dout := ALU.io.dout 
    ALU.io.op_config := io.op_config
    
    when (io.loop_source === STATE_0) {
        alu_din_1 := io.din_1
        alu_din_2 := io.din_2  
    }
    .elsewhen (io.loop_source === STATE_1) {
        when (loaded === 0.U) {
            alu_din_1 := io.din_1
            alu_din_2 := io.din_2
                                      
        }  
        .otherwise {
            alu_din_1 := dout_reg
            alu_din_2 := io.din_2                      
        }                               
    } 
    .elsewhen (io.loop_source === STATE_2) {
        when (loaded === 0.U) {
            alu_din_1 := io.din_1
            alu_din_2 := io.din_2                                
        }  
        .otherwise {
            alu_din_1 := io.din_1
            alu_din_2 := dout_reg                      
        }                               
    } 
    .otherwise { 
        alu_din_1 := (DATA_WIDTH - 1).U
        alu_din_2 := (DATA_WIDTH - 1).U
    }
    
    when (io.dout_r === 1.U) {
        valid := 0.U                            
    }  
    when (io.din_v === 1.U && io.dout_r === 1.U && 
            (io.loop_source === STATE_1 || io.loop_source === STATE_2)) 
        {
        loaded := 1.U
        count := count + 1.U                    
    }  
    // Fix io.iterations_reset (verilog vs vhdl)
    when (count === io.iterations_reset - 1.U && 
            (io.loop_source === STATE_1 || io.loop_source === STATE_2) && 
            io.dout_r === 1.U)
        {
        count := 0.U
        loaded := 0.U
        valid := 1.U
        dout_reg := alu_dout
    }    
    .elsewhen ((io.loop_source === STATE_1 || io.loop_source === STATE_2) && 
                io.din_v === 1.U && 
                io.dout_r === 1.U)
        {
        dout_reg := alu_dout
    } 

    io.din_r := io.dout_r

    when (io.loop_source === STATE_0){
        io.dout := alu_dout
        io.dout_v := io.din_v 
    }
    .otherwise{
        io.dout := dout_reg
        io.dout_v := valid    
    }   
}

// Generate the Verilog code
object FUMain extends App {
    println("Generating the hardware")
    (new chisel3.stage.ChiselStage).emitVerilog(new FU(32, 5), Array("--target-dir", "generated"))
}
