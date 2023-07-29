// FIFO with combinational circuit.

import chisel3._
import chisel3.util._

class FIFO(C_RST_POL: Boolean = true, C_DATA_WIDTH: Int = 32, C_FIFO_DEPTH: Int = 32) extends Module {
  val io = IO(new Bundle {
    // Data in
    val din = Input(UInt(C_DATA_WIDTH.W))
    val din_v = Input(Bool())
    val din_r = Output(Bool())

    // Data out
    val dout = Output(UInt(C_DATA_WIDTH.W))
    val dout_v = Output(Bool())
    val dout_r = Input(Bool())
  })

    val memory = Mem(C_FIFO_DEPTH, UInt(C_DATA_WIDTH.W))
    val write_pointer = RegInit(0.U(log2Ceil(C_FIFO_DEPTH).W))
    val read_pointer = RegInit(0.U(log2Ceil(C_FIFO_DEPTH).W))
    val num_data = RegInit(0.U((log2Ceil(C_FIFO_DEPTH + 1)).W))

    val empty = num_data === 0.U
    val full = num_data === C_FIFO_DEPTH.U

    io.din_r := !full
    io.dout := memory(read_pointer)
    io.dout_v := !empty

  
    num_data := 0.U
    write_pointer := 0.U
    read_pointer := 0.U
    io.dout_v := false.B


    when(io.dout_r) {
        io.dout_v := false.B
    }

    when(!full && io.din_v) {
        memory(write_pointer) := io.din
        num_data := num_data + 1.U
        write_pointer := Mux(write_pointer === (C_FIFO_DEPTH - 1).U, 0.U, write_pointer + 1.U)
    }

    when(io.dout_r && !empty) {
        num_data := num_data - 1.U
        read_pointer := Mux(read_pointer === (C_FIFO_DEPTH - 1).U, 0.U, read_pointer + 1.U)
    }
  
}


// Generate the Verilog code
object FIFOMain extends App {
    println("Generating the hardware")
    (new chisel3.stage.ChiselStage).emitVerilog(new FIFO(false, 32, 32), Array("--target-dir", "generated"))
}