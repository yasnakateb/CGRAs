import chisel3._
import chisel3.util._

class D_SEB (DATA_WIDTH: Int)extends Module {
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
    val reg_1  = Module (new RegEnable(1))
    val reg_2  = Module (new RegEnable(1))

    val reg = RegInit(0.U(1.W))
    val S_EA_EM = Wire(Bool())
    
     
    val mux2_out = Mux(reg.asBool, reg_1.io.out, reg_2.io.out)
    reg := io.dout_r.asUInt | (~mux2_out)
    S_EA_EM := reg.asBool
    io.dout_v := mux2_out.asBool


    io.din_r := S_EA_EM 
   
    main.io.in := io.din
    aux.io.in := main.io.out 
    reg_1.io.in := io.din_v
    reg_2.io.in := reg_1.io.out  

    main.io.en := S_EA_EM 
    aux.io.en := S_EA_EM 
    reg_1.io.en := S_EA_EM 
    reg_2.io.en := S_EA_EM 

    io.dout := Mux(S_EA_EM , main.io.out, aux.io.out)
}

// Generate the Verilog code
object D_SEBMain extends App {
    println("Generating the hardware")
    (new chisel3.stage.ChiselStage).emitVerilog(new D_SEB(32), Array("--target-dir", "generated"))
}
