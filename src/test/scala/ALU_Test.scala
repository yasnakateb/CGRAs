///////////////////////////////////////
//                                   //
//    Arithmetic Logic Unit Test     //
//                                   //
///////////////////////////////////////

import chisel3._
import chiseltest._
import org.scalatest.flatspec.AnyFlatSpec

class ALU_Test extends AnyFlatSpec with ChiselScalatestTester {
    "ALU_Test test" should "pass" in {
        test(new ALU(32, 4)) { dut =>
            var din_1 = 26
            var din_2 = 3
            var op_config = 0
            dut.io.din_1.poke(din_1.U)
            dut.io.din_2.poke(din_2.U)
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
            println("Left Logical: " + dut.io.dout.peek().toString)
            // Positive Number => Shift Right Arithmetic
            op_config = 4
            dut.io.op_config.poke(op_config.U)
            dut.clock.step(1)
            println("Positive Number => Shift Right Arithmetic: " + dut.io.dout.peek().toString)
            // Positive Number => Shift Right Logical
            op_config = 5
            dut.io.op_config.poke(op_config.U)
            dut.clock.step(1)
            println("Positive Number => Shift Right Logical: " + dut.io.dout.peek().toString)
            // Negative number => Shift Right Arithmetic
            dut.io.din_1.poke("b1000_0000_0000_0000_0000_0000_0000_1111".U)
            println("*************************************")
            println("*************************************")
            println("Din1: " + dut.io.din_1.peek().toString)
            println("Din2: " + dut.io.din_2.peek().toString)
            op_config = 4
            dut.io.op_config.poke(op_config.U)
            dut.clock.step(1)
            println("Negative Number => Shift Right Arithmetic: " + dut.io.dout.peek().toString)
            // Negative number => Shift Right Logical
            op_config = 5
            dut.io.op_config.poke(op_config.U)
            dut.clock.step(1)
            println("Negative Number => Shift Right Logical: " + dut.io.dout.peek().toString)
            dut.clock.step(1)
            dut.io.din_1.poke(din_1.U)
            // And
            println("*************************************")
            println("*************************************")
            println("Din1: " + dut.io.din_1.peek().toString)
            println("Din2: " + dut.io.din_2.peek().toString)
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
