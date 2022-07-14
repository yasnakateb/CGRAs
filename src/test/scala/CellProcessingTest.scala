///////////////////////////////////////
//                                   //
//       Cell Processing Test        //
//                                   //
///////////////////////////////////////

import chisel3._
import chiseltest._
import org.scalatest.flatspec.AnyFlatSpec

class CellProcessingTest extends AnyFlatSpec with ChiselScalatestTester {
    "CellProcessingTest test" should "pass" in {
        test(new CellProcessing(32)) { dut =>
            var north_din = 32.U 
            var north_din_v = false.B 
            var east_din = 32.U  
            var east_din_v = false.B 

            var south_din = 32.U  
            var south_din_v = false.B 
            var west_din = 32.U  
            var west_din_v = false.B 

            var north_dout_r = false.B 
            var east_dout_r = false.B 
            var south_dout_r = false.B 
            var west_dout_r = false.B 
            var config_bits = 32.U 
            
            dut.io.north_din.poke(north_din)
            dut.io.north_din_v.poke(north_din_v)

            dut.io.east_din.poke(east_din)
            dut.io.east_din_v.poke(east_din_v)

            dut.io.south_din.poke(south_din)
            dut.io.south_din_v.poke(south_din_v)

            dut.io.west_din.poke(west_din)
            dut.io.west_din_v.poke(west_din_v)
            
            dut.io.north_dout_r.poke(north_dout_r)
            dut.io.east_dout_r.poke(east_dout_r)

            dut.io.south_dout_r.poke(south_dout_r)
            dut.io.west_dout_r.poke(west_dout_r)

            dut.io.config_bits.poke(config_bits)

            println("*************************************")
            println("*************************************")
            dut.clock.step(1)
            dut.clock.step(1)
            dut.clock.step(1)
            dut.clock.step(1)
            // Outputs
            println("Outputs")
            println("FU_din_1_r: " + dut.io.FU_din_1_r.peek().toString)
            println("FU_din_2_r: " + dut.io.FU_din_2_r.peek().toString)
            println("dout: " + dut.io.dout.peek().toString)
            println("dout_v: " + dut.io.dout_v.peek().toString)
            println("*************************************")
            println("*************************************")
        }
    } 
}
