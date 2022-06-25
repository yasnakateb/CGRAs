import chisel3._
import chiseltest._
import org.scalatest.flatspec.AnyFlatSpec

class ALUTest extends AnyFlatSpec with ChiselScalatestTester {
    "ALUTest test" should "pass" in {
        test(new ALU(8, 8)) { dut =>
            var d_in_1 = 10
            var d_in_2 = 5
            var op_config = 0
            dut.io.d_in_1.poke(d_in_1.U)
            dut.io.d_in_2.poke(d_in_2.U)
            println("*************************************")
            println("*************************************")
            println("Din1: " + dut.io.d_in_1.peek().toString)
            println("Din2: " + dut.io.d_in_2.peek().toString)
            // Summation  
            dut.io.op_config.poke(op_config.U)
            dut.clock.step(1)
            println("Summation: " + dut.io.d_out.peek().toString)
            // Multiplication
            op_config = 1
            dut.io.op_config.poke(op_config.U)
            dut.clock.step(1)
            println("Multiplication: " + dut.io.d_out.peek().toString)
            // Subtraction
            op_config = 2
            dut.io.op_config.poke(op_config.U)
            dut.clock.step(1)
            println("Subtraction: " + dut.io.d_out.peek().toString)
            // Shift Left Logical
            op_config = 3
            dut.io.op_config.poke(op_config.U)
            dut.clock.step(1)
            println("Shift Left Logical: " + dut.io.d_out.peek().toString)
            // Shift Right Logical
            op_config = 4
            dut.io.op_config.poke(op_config.U)
            dut.clock.step(1)
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
