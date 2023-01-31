///////////////////////////////////////
//                                   //
//              FU Test              //
//                                   //
///////////////////////////////////////

import chisel3._
import chiseltest._
import org.scalatest.flatspec.AnyFlatSpec

class FUTest extends AnyFlatSpec with ChiselScalatestTester {
    "FUTest test" should "pass" in {
        test(new FU(32, 4)) { dut =>
            val din_1 = 10
            val din_2 = 5
            var din_v = true
            var dout_r = true
            var loop_source = 0
            var iterations_reset = 0
            var op_config = 0 

            dut.io.din_1.poke(din_1.U)
            dut.io.din_2.poke(din_2.U)
            dut.io.din_v.poke(din_v.B)
            dut.io.dout_r.poke(dout_r.B)
            dut.io.loop_source.poke(loop_source.U)
            dut.io.iterations_reset.poke(iterations_reset.U)
            println("*************************************")
            println("*************************************")
            println("Din1: " + dut.io.din_1.peek().toString)
            println("Din2: " + dut.io.din_2.peek().toString)
            println("VIn: " + dut.io.din_v.peek().toString)
            println("ROut: " + dut.io.dout_r.peek().toString)
            println("Loop Source: " + dut.io.loop_source.peek().toString)
            println("Iterarions Reset: " + dut.io.iterations_reset.peek().toString)
            println("Op Config: " + dut.io.op_config.peek().toString)
            // Summation  
            dut.io.op_config.poke(op_config.U)
            dut.clock.step(1)
            dut.clock.step(1)
            dut.clock.step(1)
            dut.clock.step(1)
            dut.clock.step(1)
            dut.clock.step(1)
            dut.clock.step(1)
            dut.clock.step(1)
            dut.clock.step(1)
            println("*************************************")
            println("*************************************")
            println("ROut: " + dut.io.dout_r.peek().toString)
            println("Loop Source: " + dut.io.loop_source.peek().toString)
            println("Rin: " + dut.io.din_r.peek().toString)
            println("Dout: " + dut.io.dout.peek().toString)
            println("Vout: " + dut.io.dout_v.peek().toString)
            println("************ Test operators")
            println("Summation: " + dut.io.dout.peek().toString)
            // Multiplication
            op_config = 1
            dut.io.op_config.poke(op_config.U)
            dut.clock.step(1)
            println("Multiplication: " + dut.io.dout.peek().toString)
            op_config = 2
            dut.io.op_config.poke(op_config.U)
            dut.clock.step(1)
            println("Subtraction: " + dut.io.dout.peek().toString)
            op_config = 3
            dut.io.op_config.poke(op_config.U)
            dut.clock.step(1)
            println("Shift Left Logical: " + dut.io.dout.peek().toString)
            op_config = 4
            dut.io.op_config.poke(op_config.U)
            dut.clock.step(1)
            println("Shift Right Arithmetic: " + dut.io.dout.peek().toString)
            op_config = 5
            dut.io.op_config.poke(op_config.U)
            dut.clock.step(1)
            println("Shift Right Logical: " + dut.io.dout.peek().toString)
            op_config = 6
            dut.io.op_config.poke(op_config.U)
            dut.clock.step(1)
            println("And: " + dut.io.dout.peek().toString)
            op_config = 7
            dut.io.op_config.poke(op_config.U)
            dut.clock.step(1)
            println("Or: " + dut.io.dout.peek().toString)
            op_config = 8
            dut.io.op_config.poke(op_config.U)
            dut.clock.step(1)
            println("Xor: " + dut.io.dout.peek().toString)
            op_config = 9
            dut.io.op_config.poke(op_config.U)
            dut.clock.step(1)
            println("Minimum: " + dut.io.dout.peek().toString)
            op_config = 10
            dut.io.op_config.poke(op_config.U)
            dut.clock.step(1)
            println("Maximum: " + dut.io.dout.peek().toString)
            /////////////////////////////////////////////////////////////////////
            op_config = 1
            loop_source = 0
            dout_r = false 
            dut.io.dout_r.poke(dout_r.B)
            dut.io.loop_source.poke(loop_source.U)
            dut.io.op_config.poke(op_config.U)
            dut.clock.step(1)
            println("*************************************")
            println("*************************************")
            println("Multiplication: " + dut.io.dout.peek().toString)
            println("ROut: " + dut.io.dout_r.peek().toString)
            println("Loop Source: " + dut.io.loop_source.peek().toString)
            println("Rin: " + dut.io.din_r.peek().toString)
            println("Dout: " + dut.io.dout.peek().toString)
            println("Vout: " + dut.io.dout_v.peek().toString)
            // Subtraction
            op_config = 2
            loop_source = 1
            dout_r = false 
            dut.io.dout_r.poke(dout_r.B)
            dut.io.loop_source.poke(loop_source.U)
            dut.io.op_config.poke(op_config.U)
            dut.clock.step(1)
            println("*************************************")
            println("*************************************")
            println("Subtraction: " + dut.io.dout.peek().toString)
            println("ROut: " + dut.io.dout_r.peek().toString)
            println("Loop Source: " + dut.io.loop_source.peek().toString)
            println("Rin: " + dut.io.din_r.peek().toString)
            println("Dout: " + dut.io.dout.peek().toString)
            println("Vout: " + dut.io.dout_v.peek().toString)
            // Shift Left Logical
            op_config = 3
            loop_source = 2
            dout_r = true
            dut.io.dout_r.poke(dout_r.B)
            dut.io.loop_source.poke(loop_source.U)
            dut.io.op_config.poke(op_config.U)
            dut.clock.step(1)
            println("*************************************")
            println("*************************************")
            println("Shift Left Logical: " + dut.io.dout.peek().toString)
            println("ROut: " + dut.io.dout_r.peek().toString)
            println("Loop Source: " + dut.io.loop_source.peek().toString)
            println("Rin: " + dut.io.din_r.peek().toString)
            println("Dout: " + dut.io.dout.peek().toString)
            println("Vout: " + dut.io.dout_v.peek().toString)
            // Shift Right Logical
            op_config = 5
            dut.io.op_config.poke(op_config.U)
            dut.clock.step(1)
            println("*************************************")
            println("*************************************")
            println("Shift Right Logical: " + dut.io.dout.peek().toString)
            // And
            op_config = 6
            dut.io.op_config.poke(op_config.U)
            dut.clock.step(1)
            println("And: " + dut.io.dout.peek().toString)
            // Or
            op_config = 7
            dut.io.op_config.poke(op_config.U)
            dut.clock.step(1)
            println("Or: " + dut.io.dout.peek().toString)
            // Xor
            op_config = 8
            dut.io.op_config.poke(op_config.U)
            dut.clock.step(1)
            println("Xor: " + dut.io.dout.peek().toString)
            // Minimum
            op_config = 9
            dut.io.op_config.poke(op_config.U)
            dut.clock.step(1)
            println("Minimum: " + dut.io.dout.peek().toString)
            // Maximum
            op_config = 10
            dut.io.op_config.poke(op_config.U)
            dut.clock.step(1)
            println("Maximum: " + dut.io.dout.peek().toString)
            println("*************************************")
            println("*************************************")
        }
    } 
}
