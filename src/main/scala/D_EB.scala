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
        val d_p = Input(UInt(DATA_WIDTH.W))
        val v_p = Input(Bool())
        val a_n = Input(Bool())
        val d_n = Output(UInt(DATA_WIDTH.W))
        val v_n = Output(Bool())
        val a_p = Output(Bool())  
    })

    val main  = Module (new RegEnable(DATA_WIDTH))
    val aux  = Module (new RegEnable(DATA_WIDTH))
    val reg_1  = Module (new RegEnable(1))
    val reg_2  = Module (new RegEnable(1))

    val reg = RegInit(0.U(1.W))
    val S_EA = Wire(Bool())
    val EM = Wire(Bool())
     
    val mux2_out = Mux(reg.asBool, reg_1.io.out, reg_2.io.out)
    reg := io.a_n.asUInt | (~mux2_out)
    S_EA := reg.asBool
    io.v_n := mux2_out.asBool

    io.a_p := S_EA | (~io.v_p)
    EM := io.a_p

    main.io.in := io.d_p
    aux.io.in := main.io.out 
    reg_1.io.in := io.v_p
    reg_2.io.in := reg_1.io.out  

    main.io.en := EM 
    aux.io.en := S_EA
    reg_1.io.en := EM 
    reg_2.io.en := S_EA

    io.d_n := Mux(S_EA, main.io.out, aux.io.out)
}

// Generate the Verilog code
object D_EBMain extends App {
    println("Generating the hardware")
    (new chisel3.stage.ChiselStage).emitVerilog(new D_EB(32), Array("--target-dir", "generated"))
}