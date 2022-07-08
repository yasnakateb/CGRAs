///////////////////////////////////////
//                                   //
//           Fork Receiver           //
//                                   //
///////////////////////////////////////

import chisel3._
import chisel3.util._

class FR (NUMBER_OF_VALIDS: Int, NUMBER_OF_READYS: Int) extends Module {
    val io = IO(new Bundle {
        // Inputs
        val valid_in = Input(UInt(NUMBER_OF_VALIDS.W))
        val ready_out = Input(UInt(NUMBER_OF_READYS.W))
        val valid_mux_sel = Input(UInt((log2Ceil(NUMBER_OF_VALIDS).W)))
        val fork_mask = Input(UInt(NUMBER_OF_READYS.W))
       
        // Outputs
        val valid_out = Output(Bool())  
    })

    var aux = Wire(Vec(NUMBER_OF_READYS + 1, Bool()))
    var temp = Wire(Vec(NUMBER_OF_READYS + 1, Bool()))
    var Vaux = Wire(UInt(1.W))

    for (i <- 0 until NUMBER_OF_READYS) {
        aux(i) := ((~io.fork_mask(i)) | io.ready_out(i)).asBool
    }
    val conf_mux  = Module (new ConfMux(NUMBER_OF_VALIDS, 1))
    conf_mux.io.selector <> io.valid_mux_sel
    conf_mux.io.mux_input <> io.valid_in
    conf_mux.io.mux_output <> Vaux

    aux(NUMBER_OF_READYS) := Vaux(0) 
    temp(0) := aux(0)

    for (i <- 1 until NUMBER_OF_READYS + 1) {
        temp(i) := temp(i-1) & aux(i)
    }
    io.valid_out := temp(NUMBER_OF_READYS)   
}

// Generate the Verilog code
object FRMain extends App {
    println("Generating the hardware")
    (new chisel3.stage.ChiselStage).emitVerilog(new FR(5, 5), Array("--target-dir", "generated"))
}