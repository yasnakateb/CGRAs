///////////////////////////////////////
//                                   //
//               D-REG               //
//                                   //
///////////////////////////////////////

import chisel3._
import chisel3.util._

class D_REG 
    (
        DATA_WIDTH: Int
    )
    extends Module {
    val io = IO(new Bundle {
        val din = Input(UInt(DATA_WIDTH.W))
        val din_v = Input(Bool())
        val dout_r = Input(Bool())
        val dout = Output(UInt(DATA_WIDTH.W))
        val dout_v = Output(Bool())
        val din_r = Output(Bool())  
    })

    val reg_1  = Module (new RegEnable(DATA_WIDTH))
    val reg_2  = Module (new RegEnable(1))
    
    reg_1.io.in := io.din
    reg_2.io.in := io.din_v
    reg_1.io.en := io.dout_r
    reg_2.io.en := io.dout_r
    io.dout := reg_1.io.out 
    io.dout_v := reg_2.io.out 
    io.din_r := io.dout_r     
}

// Generate the Verilog code
object D_REGMain extends App {
    println("Generating the hardware")
    (new chisel3.stage.ChiselStage).emitVerilog(new D_REG(8), Array("--target-dir", "generated"))
}