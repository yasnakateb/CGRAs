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

class FU (DATA_WIDTH: Int, OP_WIDTH: Int, RST_POL: Int)extends Module {
    val io = IO(new Bundle {
        // Data ports
        val d_in_1 = Input(UInt(DATA_WIDTH.W))
        val d_in_2 = Input(UInt(DATA_WIDTH.W))
        val v_in = Input(Bool())
        val r_in = Output(Bool())
        val d_out = Output(UInt(DATA_WIDTH.W))
        val v_out = Output(Bool())
        val r_out = Input(Bool())
        // Config ports
        val loop_source = Input(UInt(2.W))
        val iterations_reset = Input(UInt(16.W))
        val op_config = Input(UInt(OP_WIDTH.W))        
    })
    //Clock, Reset
    // val clk = IO(Input(Clock()))
    // val reset = IO(Input(Reset())) 

    val alu_d_in_1 = RegInit(0.U(DATA_WIDTH.W))
    val alu_d_in_2 = RegInit(0.U(DATA_WIDTH.W))
    val alu_d_out = RegInit(0.U(DATA_WIDTH.W))
    val d_out_Reg = RegInit(0.U(DATA_WIDTH.W))
    // Fix
    // 2 ** 16 - 1
    val counter = 65535
    val count = RegInit(counter.U(16.W))
    val loaded = RegInit(0.U(1.W))
    val valid = RegInit(0.U(1.W))

    val ALU = Module (new ALU(DATA_WIDTH, OP_WIDTH))
    ALU.io.d_in_1 := alu_d_in_1
    ALU.io.d_in_2 := alu_d_in_2
    alu_d_out := ALU.io.d_out 
    ALU.io.op_config := io.op_config

    
    when (io.loop_source === STATE_0) {
        alu_d_in_1 := io.d_in_1;
        alu_d_in_2 := io.d_in_2;                  
    }
    .elsewhen (io.loop_source === STATE_1) {
        when (loaded === 0.U) {
            alu_d_in_1 := io.d_in_1;
            alu_d_in_2 := io.d_in_2;                                
        }  
        .otherwise {
            alu_d_in_1 := d_out_Reg;
            alu_d_in_2 := io.d_in_2;                      
        }                               
    } 
    .elsewhen (io.loop_source === STATE_2) {
        when (loaded === 0.U) {
            alu_d_in_1 := io.d_in_1;
            alu_d_in_2 := io.d_in_2;                                
        }  
        .otherwise {
            alu_d_in_1 := io.d_in_1
            alu_d_in_2 := d_out_Reg;                      
        }                               
    } 
    .otherwise { 
        alu_d_in_1 := (DATA_WIDTH - 1).U;
        alu_d_in_2 := (DATA_WIDTH - 1).U;
    }

    //when (io.reset === RST_POL) {
    withReset (reset.asBool) {
        loaded := 0.U;
        count := 0.U;
        d_out_Reg := 0.U;
        valid <= 0.U;  
    }           
    //}
    //.elsewhen (io.clk === 1.U) {
    
        when (io.r_out === 1.U) {
            valid := 0.U;                             
        }  
        when (io.v_in === 1.U && io.r_out === 1.U && 
             (io.loop_source === STATE_1 || io.loop_source === STATE_2)) 
            {
            loaded := 1.U;
            count  := count + 1.U;                            
        }  
        when (count === io.iterations_reset && 
             (io.loop_source === STATE_1 || io.loop_source === STATE_2) && 
              io.r_out === 1.U)
            {
            count    := 0.U;
            loaded   := 0.U;
            valid    := 1.U;
            d_out_Reg := alu_d_out;
        }    
        .elsewhen ((io.loop_source === STATE_1 || io.loop_source === STATE_2) && 
                   io.v_in === 1.U && 
                   io.r_out === 1.U)
            {
            d_out_Reg := alu_d_out;
        }                             
    //} 
    
    when (io.loop_source === STATE_0){
        io.v_out := io.v_in
    }
    .otherwise{
        io.v_out := valid;    
    } 

    io.r_in := io.r_out;

    when (io.loop_source === STATE_0){
        io.d_out := alu_d_out
    }
    .otherwise{
        io.d_out := d_out_Reg
    } 
}

// Generate the Verilog code
object FUMain extends App {
    println("Generating the hardware")
    (new chisel3.stage.ChiselStage).emitVerilog(new FU(8, 8, 0), Array("--target-dir", "generated"))
}
