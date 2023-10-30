///////////////////////////////////////
//                                   //
//       Configuration Mux           //
//                                   //
///////////////////////////////////////

import chisel3._
import chisel3.util._

class ConfMux 
    (
        NUM_INPUTS: Int = 2, 
        DATA_WIDTH: Int = 1
    )
    extends Module {
    val io = IO(new Bundle {
        
        val selector = Input(UInt(log2Ceil(NUM_INPUTS).W))
        val mux_input = Input(SInt((NUM_INPUTS*DATA_WIDTH).W))
       
        // Output
        val mux_output = Output(SInt(DATA_WIDTH.W))
    })

    val inputs = Wire(Vec(NUM_INPUTS, SInt(DATA_WIDTH.W))) 
    for (i <- 0 until NUM_INPUTS) {
        inputs(i) := (io.mux_input((i+1)*DATA_WIDTH-1,i*DATA_WIDTH)).asSInt
    }
    io.mux_output := inputs(io.selector)
}

// Generate the Verilog code
object ConfMuxMain extends App {
    println("Generating the hardware")
    (new chisel3.stage.ChiselStage).emitVerilog(new ConfMux(2, 1), Array("--target-dir", "generated"))
}