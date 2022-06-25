import chisel3._
import chiseltest._
import org.scalatest.flatspec.AnyFlatSpec

class FUTest extends AnyFlatSpec with ChiselScalatestTester {
    "FUTest test" should "pass" in {
        test(new FU(8, 8, 0)) { dut =>
            val d_in_1 = 10
            val d_in_2 = 5
            var v_in = true
            var r_out = true
            var loop_source = 2
            var iterations_reset = 4
            var op_config = 0 

            dut.io.d_in_1.poke(d_in_1.U)
            dut.io.d_in_2.poke(d_in_2.U)
            dut.io.v_in.poke(v_in.B)
            dut.io.r_out.poke(r_out.B)
            dut.io.loop_source.poke(loop_source.U)
            dut.io.iterations_reset.poke(iterations_reset.U)
            println("*************************************")
            println("*************************************")
            println("Din1: " + dut.io.d_in_1.peek().toString)
            println("Din2: " + dut.io.d_in_2.peek().toString)
            println("VIn: " + dut.io.v_in.peek().toString)
            println("ROut: " + dut.io.r_out.peek().toString)
            println("Loop Source: " + dut.io.loop_source.peek().toString)
            println("Iterarions Reset: " + dut.io.iterations_reset.peek().toString)
            println("Op Config: " + dut.io.op_config.peek().toString)
            // Summation  
            dut.io.op_config.poke(op_config.U)
            dut.clock.step(1)
            println("*************************************")
            println("*************************************")
            println("Summation: " + dut.io.d_out.peek().toString)
            println("ROut: " + dut.io.r_out.peek().toString)
            println("Loop Source: " + dut.io.loop_source.peek().toString)
            println("Rin: " + dut.io.r_in.peek().toString)
            println("Dout: " + dut.io.d_out.peek().toString)
            println("Vout: " + dut.io.v_out.peek().toString)
            // Multiplication
            op_config = 1
            loop_source = 0
            r_out = false 
            dut.io.r_out.poke(r_out.B)
            dut.io.loop_source.poke(loop_source.U)
            dut.io.op_config.poke(op_config.U)
            dut.clock.step(1)
            println("*************************************")
            println("*************************************")
            println("Multiplication: " + dut.io.d_out.peek().toString)
            println("ROut: " + dut.io.r_out.peek().toString)
            println("Loop Source: " + dut.io.loop_source.peek().toString)
            println("Rin: " + dut.io.r_in.peek().toString)
            println("Dout: " + dut.io.d_out.peek().toString)
            println("Vout: " + dut.io.v_out.peek().toString)
            // Subtraction
            op_config = 2
            loop_source = 1
            r_out = false 
            dut.io.r_out.poke(r_out.B)
            dut.io.loop_source.poke(loop_source.U)
            dut.io.op_config.poke(op_config.U)
            dut.clock.step(1)
            println("*************************************")
            println("*************************************")
            println("Subtraction: " + dut.io.d_out.peek().toString)
            println("ROut: " + dut.io.r_out.peek().toString)
            println("Loop Source: " + dut.io.loop_source.peek().toString)
            println("Rin: " + dut.io.r_in.peek().toString)
            println("Dout: " + dut.io.d_out.peek().toString)
            println("Vout: " + dut.io.v_out.peek().toString)
            // Shift Left Logical
            op_config = 3
            loop_source = 2
            r_out = true
            dut.io.r_out.poke(r_out.B)
            dut.io.loop_source.poke(loop_source.U)
            dut.io.op_config.poke(op_config.U)
            dut.clock.step(1)
            println("*************************************")
            println("*************************************")
            println("Shift Left Logical: " + dut.io.d_out.peek().toString)
            println("ROut: " + dut.io.r_out.peek().toString)
            println("Loop Source: " + dut.io.loop_source.peek().toString)
            println("Rin: " + dut.io.r_in.peek().toString)
            println("Dout: " + dut.io.d_out.peek().toString)
            println("Vout: " + dut.io.v_out.peek().toString)
            // Shift Right Logical
            op_config = 4
            dut.io.op_config.poke(op_config.U)
            dut.clock.step(1)
            println("*************************************")
            println("*************************************")
            println("Shift Right Logical: " + dut.io.d_out.peek().toString)
            // And
            op_config = 5
            dut.io.op_config.poke(op_config.U)
            dut.clock.step(1)
            println("And: " + dut.io.d_out.peek().toString)
            // Or
            op_config = 6
            dut.io.op_config.poke(op_config.U)
            dut.clock.step(1)
            println("Or: " + dut.io.d_out.peek().toString)
            // Xor
            op_config = 7
            dut.io.op_config.poke(op_config.U)
            dut.clock.step(1)
            println("Xor: " + dut.io.d_out.peek().toString)
            // Minimum
            op_config = 8
            dut.io.op_config.poke(op_config.U)
            dut.clock.step(1)
            println("Minimum: " + dut.io.d_out.peek().toString)
            // Maximum
            op_config = 9
            dut.io.op_config.poke(op_config.U)
            dut.clock.step(1)
            println("Maximum: " + dut.io.d_out.peek().toString)
            println("*************************************")
            println("*************************************")
        }
    } 
}
