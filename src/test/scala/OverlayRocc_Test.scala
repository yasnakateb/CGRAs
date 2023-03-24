///////////////////////////////////////
//                                   //
//          Overlay Cell Test        //
//                                   //
///////////////////////////////////////

import chisel3._
import chiseltest._
import org.scalatest.flatspec.AnyFlatSpec

class OverlayRocc_Test extends AnyFlatSpec with ChiselScalatestTester {
    "OverlayRocc_Test test" should "pass" in {
        test(new OverlayRocc(32, 6, 6, 32)) { dut =>
            // Data
            var data_in = "h060504030201".U 
            var data_in_valid = "b111111".U 
            var data_out_ready = "b111111".U 
            // Config 
            var cell_config = "b100010000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000100000000000000000100000000".U 

            dut.io.data_in.poke(data_in)
            dut.io.data_in_valid.poke(data_in_valid)
            dut.io.data_out_ready.poke(data_out_ready)
            dut.io.cell_config.poke(cell_config)
            
            println("*************************************")
            println("*************************************")
            for( i <- 0 to 50){
                dut.clock.step(1)
            }
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

            data_in = "h090807060504".U 
            data_in_valid = "b111111".U 
            data_out_ready = "b111111".U 
            // Config 
            cell_config = "b100010000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000100000000000000000100000000".U 

            dut.io.data_in.poke(data_in)
            dut.io.data_in_valid.poke(data_in_valid)
            dut.io.data_out_ready.poke(data_out_ready)
            dut.io.cell_config.poke(cell_config)

            for( i <- 0 to 50){
                dut.clock.step(1)
            }
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

            data_in = "h060504030201".U 
            data_in_valid = "b111111".U 
            data_out_ready = "b111111".U 
            // Config 
            cell_config = "b100010000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000100000000000000000100000000".U 

            dut.io.data_in.poke(data_in)
            dut.io.data_in_valid.poke(data_in_valid)
            dut.io.data_out_ready.poke(data_out_ready)
            dut.io.cell_config.poke(cell_config)

            for( i <- 0 to 50){
                dut.clock.step(1)
            }
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