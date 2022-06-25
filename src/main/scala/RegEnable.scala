import chisel3._
import chisel3.util._
// Register with Enable 
class RegEnable (C_DATA_WIDTH: Int) extends Module {
    val io = IO(new Bundle {
        val in = Input(UInt(C_DATA_WIDTH.W))
        val en = Input(Bool())
        val out = Output(UInt(C_DATA_WIDTH.W))
    })

    val reg = RegInit(0.U)  
    when(io.en) {
        reg := io.in
    }
    io.out := reg
}

// Generate the Verilog code
object RegEnableMain extends App {
    println("Generating the hardware")
    (new chisel3.stage.ChiselStage).emitVerilog(new RegEnable(8), Array("--target-dir", "generated"))
}