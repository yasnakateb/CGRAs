///////////////////////////////////////
//                                   //
//           Fork Sender             //
//                                   //
///////////////////////////////////////

import chisel3._
import chisel3.util._

class FS (CONF_MASK: Int)extends Module {
    val io = IO(new Bundle {
        val afu_in_1 = Input(Bool())
        val afu_in_2 = Input(Bool())
        val ae_out = Input(Bool())
        val as_out = Input(Bool())
        val aw_out = Input(Bool())
        val an_in = Output(Bool())
    })

    val configuration_mask = Wire(UInt(5.W))
    configuration_mask := CONF_MASK.U(5.W)

    io.an_in := (~ configuration_mask(4) | io.afu_in_1) & 
                  (~ configuration_mask(3) | io.afu_in_2) & 
                  (~ configuration_mask(2) | io.ae_out) & 
                  (~ configuration_mask(1) | io.as_out) & 
                  (~ configuration_mask(0) | io.aw_out) 
}

// Generate the Verilog code
object FSMain extends App {
    println("Generating the hardware")
    (new chisel3.stage.ChiselStage).emitVerilog(new FS(5), Array("--target-dir", "generated"))
} 