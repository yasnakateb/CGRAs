import chisel3._
import chisel3.util._

class D_BUF (DATA_WIDTH: Int)extends Module {
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
    reg := io.a_n
    areg := reg.asBool
   
    reg_1.io.in := io.d_p
    reg_3.io.in := io.v_p
    io.a_p := areg

    reg_1.io.en := areg 
    reg_2.io.en := io.a_n 
    reg_3.io.en := areg
    reg_4.io.en := io.a_n   

    val mux1_out = Mux(areg, reg_1.io.out, io.d_p)
    io.d_n := mux1_out
    reg_2.io.in := mux1_out

    val mux2_out = Mux(areg, reg_3.io.out, io.v_p)
    reg_4.io.in := mux2_out
    io.v_n := reg_4.io.out 
}

// Generate the Verilog code
object D_BUFMain extends App {
    println("Generating the hardware")
    (new chisel3.stage.ChiselStage).emitVerilog(new D_BUF(8), Array("--target-dir", "generated"))
}
