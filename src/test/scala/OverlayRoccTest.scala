///////////////////////////////////////
//                                   //
//          Overlay Cell Test        //
//                                   //
///////////////////////////////////////

import chisel3._
import chiseltest._
import org.scalatest.flatspec.AnyFlatSpec

class OverlayRoccTest extends AnyFlatSpec with ChiselScalatestTester {
    "OverlayRoccTest test" should "pass" in {
        test(new OverlayRocc(32, 8, 8, 32)) { dut =>
            // Data
            var data_in = 32.U 
            var data_in_valid = 32.U 
            var data_out_ready = 32.U 
            // Config 
            var cell_config = 32.U 

            dut.io.data_in.poke(data_in)
            dut.io.data_in_valid.poke(data_in_valid)
            dut.io.data_out_ready.poke(data_out_ready)
            dut.io.cell_config.poke(cell_config)
            
            println("*************************************")
            println("*************************************")
            dut.clock.step(1)
            dut.clock.step(1)
            dut.clock.step(1)
            dut.clock.step(1)
            // Inputs
            println("Inputs")
            println("data_in: " + dut.io.data_in.peek().toString)
            println("data_in_valid: " + dut.io.data_in_valid.peek().toString)
            println("data_out_ready: " + dut.io.data_out_ready.peek().toString)
            println("cell_config: " + dut.io.cell_config.peek().toString)
            // Outputs
            println("Outputs")
            println("data_in_ready: " + dut.io.data_in_ready.peek().toString)
            println("data_out: " + dut.io.data_out.peek().toString)
            println("data_out_valid: " + dut.io.data_out_valid.peek().toString)
            println("*************************************")
            println("*************************************")
        }
    } 
}