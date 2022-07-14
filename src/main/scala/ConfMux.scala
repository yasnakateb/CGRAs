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
        // Inputs
        // Note: log2Ceil() is a good function to find size of a word. 
        // But be aware that it's not "synthesizable" for UInt() Wire or Reg. 
        // log2Ceil() calculation is done once at synthesize time, it's not an hardware function. 
        // Then your output signal tl_out.a.bits.size will be a constant.

        val selector = Input(UInt(log2Ceil(NUM_INPUTS).W))
        val mux_input = Input(UInt((NUM_INPUTS*DATA_WIDTH).W))
       
        // Output
        val mux_output = Output(UInt(DATA_WIDTH.W))
    })

    val inputs = Wire(Vec(NUM_INPUTS, UInt(DATA_WIDTH.W))) 
    for (i <- 0 until NUM_INPUTS) {
        inputs(i) := io.mux_input((i+1)*DATA_WIDTH-1,i*DATA_WIDTH) 
    }
    io.mux_output := inputs(io.selector)
}

// Generate the Verilog code
object ConfMuxMain extends App {
    println("Generating the hardware")
    (new chisel3.stage.ChiselStage).emitVerilog(new ConfMux(2, 1), Array("--target-dir", "generated"))
}