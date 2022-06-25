import chisel3._
import chisel3.util._
// a_p (Accept previous)
// d_p (Data previous)
// v_p (Valid previous)
// a_n (Accept next) 
// d_n (Data next)
// v_n (Valid next)
class D_REG (DATA_WIDTH: Int)extends Module {
    val io = IO(new Bundle {
        val d_p = Input(UInt(DATA_WIDTH.W))
        val v_p = Input(Bool())
        val a_n = Input(Bool())
        val d_n = Output(UInt(DATA_WIDTH.W))
        val v_n = Output(Bool())
        val a_p = Output(Bool())  
    })

    val reg_1  = Module (new RegEnable(DATA_WIDTH))
    val reg_2  = Module (new RegEnable(1))
    
    reg_1.io.in := io.d_p
    reg_2.io.in := io.v_p
    reg_1.io.en := io.a_n
    reg_2.io.en := io.a_n
    io.d_n := reg_1.io.out 
    io.v_n := reg_2.io.out 
    io.a_p := io.a_n     
}

// Generate the Verilog code
object D_REGMain extends App {
    println("Generating the hardware")
    (new chisel3.stage.ChiselStage).emitVerilog(new D_REG(8), Array("--target-dir", "generated"))
}
