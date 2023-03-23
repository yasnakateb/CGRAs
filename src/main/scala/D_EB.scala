///////////////////////////////////////
//                                   //
//               D-EB                //
//                                   //
///////////////////////////////////////

import chisel3._
import chisel3.util._

class D_EB 
    (
        DATA_WIDTH: Int
    )
    extends Module {
    val io = IO(new Bundle {
        // Data in
        val din = Input(UInt(DATA_WIDTH.W))
        val din_v = Input(Bool())
        val din_r = Output(Bool())
        // Data out
        val dout = Output(UInt(DATA_WIDTH.W))
        val dout_v = Output(Bool())
        val dout_r = Input(Bool())  
    })

    // Registers
    val regDin1 = RegInit(0.U(DATA_WIDTH.W))
    val regDin2 = RegInit(0.U(DATA_WIDTH.W))
    val regDinV1 = RegInit(0.B)
    val regDinV2 = RegInit(0.B)
    val regAreg = RegInit(0.B)

    when(regAreg) {
        regDin1 := io.din
        regDin2 := regDin1

        regDinV1 := io.din_v
        regDinV2 := regDinV1
    }

    regAreg := ~io.dout_v | io.dout_r

    // Combinational assignments
    io.din_r := regAreg

    when(regAreg) {
        io.dout := regDin1
        io.dout_v := regDinV1
    }.otherwise {
        io.dout := regDin2
        io.dout_v := regDinV2
    }
}

// Generate the Verilog code
object D_EBMain extends App {
    println("Generating the hardware")
    (new chisel3.stage.ChiselStage).emitVerilog(new D_EB(32), Array("--target-dir", "generated"))
}
