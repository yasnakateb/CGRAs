///////////////////////////////////////
//                                   //
//               D-EB                //
//                                   //
///////////////////////////////////////

import chisel3._
import chisel3.util._

class D_EB_Paper_Version 
    (
        DATA_WIDTH: Int
    )
    extends Module {
    val io = IO(new Bundle {
        val din = Input(UInt(DATA_WIDTH.W))
        val din_v = Input(Bool())
        val din_r = Output(Bool())
        val dout = Output(UInt(DATA_WIDTH.W))
        val dout_v = Output(Bool())
        val dout_r = Input(Bool())  
    })

    val main  = Module (new RegEnable(DATA_WIDTH))
    val aux  = Module (new RegEnable(DATA_WIDTH))

    val reg = RegInit(0.U(1.W))
    val areg = Wire(Bool())
    
    val data_0 = Wire(Bool())
    val data_1 = Wire(Bool())

    data_0 := false.B 
    data_1 := false.B 

    when (areg) {
        data_0 := io.din_v
        data_1 := data_0
    }

    val mux2_out = Mux(reg.asBool, data_0, data_1)
    reg := io.dout_r.asUInt | (~mux2_out)
    areg := reg.asBool 
    io.dout_v := mux2_out.asBool

    io.din_r := areg 
   
    main.io.in := io.din
    aux.io.in := main.io.out 
    
    main.io.en := areg 
    aux.io.en := areg 

    io.dout := Mux(areg , main.io.out, aux.io.out)

    ////////////////////////////////////////////////////////////////////////
    // D_EB version with register with enable and multiplexer and
    // without Combinational loop (the valid signal does not work properly). 
    ///////////////////////////////////////////////////////////////////////

    /*
    val main  = Module (new RegEnable(DATA_WIDTH))
    val aux  = Module (new RegEnable(DATA_WIDTH))
    val reg_1  = Module (new RegEnable(1))
    val reg_2  = Module (new RegEnable(1))

    val reg = RegInit(0.U(1.W))
    val areg = Wire(Bool())
    
     
    val mux2_out = Mux(reg.asBool, reg_1.io.out, reg_2.io.out)
    reg := io.dout_r.asUInt | (~mux2_out)
    areg := reg.asBool
    io.dout_v := mux2_out.asBool

    io.din_r := areg 
   
    main.io.in := io.din
    aux.io.in := main.io.out 
    reg_1.io.in := io.din_v
    reg_2.io.in := reg_1.io.out  

    main.io.en := areg 
    aux.io.en := areg 
    reg_1.io.en := areg 
    reg_2.io.en := areg 

    io.dout := Mux(areg , main.io.out, aux.io.out)
    */
}

// Generate the Verilog code
object D_EB_Paper_VersionMain extends App {
    println("Generating the hardware")
    (new chisel3.stage.ChiselStage).emitVerilog(new D_EB_Paper_Version(32), Array("--target-dir", "generated"))
}
