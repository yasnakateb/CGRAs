import chisel3._
import chiseltest._
import org.scalatest.flatspec.AnyFlatSpec

class ALUTest extends AnyFlatSpec with ChiselScalatestTester {
    "ALUTest test" should "pass" in {
        test(new ALU(8, 8)) { dut =>
            var din_1 = 10
            var d_in_2 = 5
            var op_config = 0
            dut.io.din_1.poke(din_1.U)
            dut.io.din_2.poke(d_in_2.U)
            println("*************************************")
            println("*************************************")
            println("Din1: " + dut.io.din_1.peek().toString)
            println("Din2: " + dut.io.din_2.peek().toString)
            // Summation  
            dut.io.op_config.poke(op_config.U)
            dut.clock.step(1)
            println("Summation: " + dut.io.dout.peek().toString)
            // Multiplication
            op_config = 1
            dut.io.op_config.poke(op_config.U)
            dut.clock.step(1)
            println("Multiplication: " + dut.io.dout.peek().toString)
            // Subtraction
            op_config = 2
            dut.io.op_config.poke(op_config.U)
            dut.clock.step(1)
            println("Subtraction: " + dut.io.dout.peek().toString)
            // Shift Left Logical
            op_config = 3
            dut.io.op_config.poke(op_config.U)
            dut.clock.step(1)
            println("Shift Left Logical: " + dut.io.dout.peek().toString)
            // Shift Right Logical
            op_config = 4
            dut.io.op_config.poke(op_config.U)
            dut.clock.step(1)
            println("Shift Right Logical: " + dut.io.dout.peek().toString)
            // And
            op_config = 5
            dut.io.op_config.poke(op_config.U)
            dut.clock.step(1)
            println("And: " + dut.io.dout.peek().toString)
            // Or
            op_config = 6
            dut.io.op_config.poke(op_config.U)
            dut.clock.step(1)
            println("Or: " + dut.io.dout.peek().toString)
            // Xor
            op_config = 7
            dut.io.op_config.poke(op_config.U)
            dut.clock.step(1)
            println("Xor: " + dut.io.dout.peek().toString)
            // Minimum
            op_config = 8
            dut.io.op_config.poke(op_config.U)
            dut.clock.step(1)
            println("Minimum: " + dut.io.dout.peek().toString)
            // Maximum
            op_config = 9
            dut.io.op_config.poke(op_config.U)
            dut.clock.step(1)
            println("Maximum: " + dut.io.dout.peek().toString)
            println("*************************************")
            println("*************************************")
        }
    } 
}
