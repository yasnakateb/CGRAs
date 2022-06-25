import chisel3._
import chisel3.util._
// a (Accept) 
// d (Data)
// v (Valid)
class Join (DATA_WIDTH: Int)extends Module {
    val io = IO(new Bundle {
        val d_in_1 = Input(UInt(DATA_WIDTH.W))
        val d_in_2 = Input(UInt(DATA_WIDTH.W))
        val a_in_1 = Output(Bool())
        val a_in_2 = Output(Bool())
        val d_out_1 = Output(UInt(DATA_WIDTH.W))
        val d_out_2 = Output(UInt(DATA_WIDTH.W))
        val v_in_1 = Input(Bool())
        val v_in_2 = Input(Bool())
        val v_out = Output(Bool())
        val a_out = Input(Bool())
    })

    io.d_out_1 := io.d_in_1
    io.d_out_2 := io.d_in_2 

    io.v_out := io.v_in_1 & io.v_in_2

    io.a_in_1 := io.v_in_2 & io.a_out
    io.a_in_2 := io.v_in_1 & io.a_out   
}

// Generate the Verilog code
object JoinMain extends App {
    println("Generating the hardware")
    (new chisel3.stage.ChiselStage).emitVerilog(new Join(8), Array("--target-dir", "generated"))
}