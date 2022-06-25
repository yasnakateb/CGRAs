import chisel3._
import chisel3.util._
// a_p (Accept previous)
// d_p (Data previous)
// v_p (Valid previous)
// a_n (Accept next) 
// d_n (Data next)
// v_n (Valid next)
class D_EB (DATA_WIDTH: Int)extends Module {
    val io = IO(new Bundle {
        val d_p = Input(UInt(DATA_WIDTH.W))
        val v_p = Input(Bool())
        val a_n = Input(Bool())
        val d_n = Output(UInt(DATA_WIDTH.W))
        val v_n = Output(Bool())
        val a_p = Output(Bool())  
    })

    val reg_1  = Module (new RegEnable(DATA_WIDTH))
    val reg_2  = Module (new RegEnable(DATA_WIDTH))
    val reg_3  = Module (new RegEnable(1))
    val reg_4  = Module (new RegEnable(1))

    val reg = RegInit(0.U(1.W))
    
    val areg = Wire(Bool())
     
    val mux2_out = Mux(reg.asBool, reg_4.io.out, reg_3.io.out)
    reg := io.a_n.asUInt & (~mux2_out)
    areg := reg.asBool
    io.v_n := mux2_out.asBool
    io.a_p := areg

    reg_1.io.in := io.d_p
    reg_2.io.in := reg_1.io.out 
    reg_3.io.in := io.v_p
    reg_4.io.in := reg_3.io.out  

    reg_1.io.en := areg
    reg_2.io.en := areg
    reg_3.io.en := areg
    reg_4.io.en := areg

    io.d_n := Mux(areg, reg_2.io.out, reg_1.io.out)
}

// Generate the Verilog code
object D_EBMain extends App {
    println("Generating the hardware")
    (new chisel3.stage.ChiselStage).emitVerilog(new D_EB(8), Array("--target-dir", "generated"))
}