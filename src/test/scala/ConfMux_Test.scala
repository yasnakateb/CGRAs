///////////////////////////////////////
//                                   //
//       Configuration Mux Test      //
//                                   //
///////////////////////////////////////

import chisel3._
import chiseltest._
import org.scalatest.flatspec.AnyFlatSpec

class ConfMux_Test extends AnyFlatSpec with ChiselScalatestTester {
    "ConfMux_Test test" should "pass" in {
        test(new ConfMux(2,2)) { dut =>
            // mux_input: 1011, selector: 1 ==> Mux Output: 10
            val selector = 1
            val mux_input = 11
            dut.io.selector.poke(selector.U)
            dut.io.mux_input.poke(mux_input.U)
            dut.clock.step(1)
            println("*************************************")
            println("Mux Input: " + dut.io.mux_input.peek().toString)
            println("Mux Selector: " + dut.io.selector.peek().toString)
            println("Mux Output: " + dut.io.mux_output.peek().toString)
            println("*************************************")   
        }
        test(new ConfMux(3,2)) { dut =>
            // mux_input: 110101, selector: 2 ==> Mux Output: 11
            val selector = 2
            val mux_input = 53
            dut.io.selector.poke(selector.U)
            dut.io.mux_input.poke(mux_input.U)
            dut.clock.step(1)
            println("Mux Input: " + dut.io.mux_input.peek().toString)
            println("Mux Selector: " + dut.io.selector.peek().toString)
            println("Mux Output: " + dut.io.mux_output.peek().toString)
            println("*************************************")   
        }
    } 
}