import chisel3._
import chisel3.util._

class FIFO(width: Int = 32, depth: Int = 32) extends Module {
  val io = IO(new Bundle {
    val din = Input(UInt(width.W))
    val wen = Input(Bool())
    val full = Output(Bool())
    val dout = Output(UInt(width.W))
    val ren = Input(Bool())
    val empty = Output(Bool())
  })

  val cntWrite = RegInit(0.U(log2Ceil(depth).W))
  val cntRead = RegInit(0.U(log2Ceil(depth).W))
  val cntData = RegInit(0.U(log2Ceil(depth + 1).W))

  val mem = SyncReadMem(depth, UInt(width.W))

  // Write pointer
  when(io.wen & ~io.full) {
    when(cntWrite === depth.U - 1.U) {
      cntWrite := 0.U
    }.otherwise {
      cntWrite := cntWrite + 1.U
    }
  }

  // Read pointer
  when(io.ren & ~io.empty) {
    when(cntRead === depth.U - 1.U) {
      cntRead := 0.U
    }.otherwise {
      cntRead := cntRead + 1.U
    }
  }

  // Data counter
  when((io.wen & ~io.full) & ~(io.ren & ~io.empty)) {
    cntData := cntData + 1.U
  }.elsewhen(~(io.wen & ~io.full) & (io.ren & ~io.empty)) {
    cntData := cntData - 1.U
  }

  // Memory access
  when(io.wen & ~io.full) {
    mem.write(cntWrite, io.din)
  }
  io.dout := mem.read(cntRead)

  // Control signal generation
  when(cntData === depth.U) {
    io.full := true.B
  }.otherwise {
    io.full := false.B
  }
  when(cntData === 0.U) {
    io.empty := true.B
  }.otherwise {
    io.empty := false.B
  }
}

// Generate the Verilog code
object FIFOMain extends App {
    println("Generating the hardware")
    (new chisel3.stage.ChiselStage).emitVerilog(new FIFO(32, 32), Array("--target-dir", "generated"))
}

