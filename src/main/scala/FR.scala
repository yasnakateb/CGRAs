///////////////////////////////////////
//                                   //
//           Fork Receiver           //
//                                   //
///////////////////////////////////////

import chisel3._
import chisel3.util._

class FR (CONF_MASK: Int, CONF_MASK_MUX: Int)extends Module {
    val io = IO(new Bundle {
        val afu_in_1 = Input(Bool())
        val afu_in_2 = Input(Bool())
        val ae_out = Input(Bool())
        val as_out = Input(Bool())
        val aw_out = Input(Bool())
        val vfu_out = Input(Bool())
        val ve_in = Input(Bool())
        val vs_in = Input(Bool())
        val vw_in = Input(Bool())
        val vn_out = Output(Bool())
    })

    val configuration_mask = Wire(UInt(5.W))
    val configuration_mask_mux = Wire(UInt(2.W))
    configuration_mask := CONF_MASK.U(5.W)
    configuration_mask_mux := CONF_MASK_MUX.U(2.W)

    val result_mux = MuxCase("b0".U(1.W), Array((configuration_mask_mux === 0.U(2.W)) ->  io.vw_in, 
                                                (configuration_mask_mux === 1.U(2.W)) ->  io.vs_in, 
                                                (configuration_mask_mux === 2.U(2.W)) ->  io.ve_in, 
                                                (configuration_mask_mux === 3.U(2.W)) ->  io.vfu_out))

    io.vn_out := (~ configuration_mask(4) | io.afu_in_1) & 
                  (~ configuration_mask(3) | io.afu_in_2) & 
                  (~ configuration_mask(2) | io.ae_out) & 
                  (~ configuration_mask(1) | io.as_out) & 
                  (~ configuration_mask(0) | io.aw_out) & 
                  result_mux
}

// Generate the Verilog code
object FRMain extends App {
    println("Generating the hardware")
    (new chisel3.stage.ChiselStage).emitVerilog(new FR(5, 2), Array("--target-dir", "generated"))
}