///////////////////////////////////////
//                                   //
//    Processing Element Test        //
//                                   //
///////////////////////////////////////

import chisel3._
import chiseltest._
import org.scalatest.flatspec.AnyFlatSpec

class ProcessingElementTest extends AnyFlatSpec with ChiselScalatestTester {
    "ProcessingElementTest test" should "pass" in {
        test(new ProcessingElement(32, 4)) { dut =>
            
            var north_din = 0.U 
            var north_din_v = false.B 

            var east_din = 0.U  
            var east_din_v = false.B 

            var south_din = 0.U  
            var south_din_v = false.B 

            var west_din = 0.U  
            var west_din_v = false.B 

            var config_bits = "b01000000000111101100000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000001000000000010000000000000001000000000000000000000000011".U 

            val north_dout_r = true.B 
            val east_dout_r = true.B 
            val south_dout_r = true.B 
            val west_dout_r = true.B 
            val catch_config = false.B 

            
            dut.io.north_din.poke(north_din)
            dut.io.north_din_v.poke(north_din_v)
            dut.io.north_dout_r.poke(north_dout_r)

            dut.io.east_din.poke(east_din)
            dut.io.east_din_v.poke(east_din_v)
            dut.io.east_dout_r.poke(east_dout_r)

            dut.io.south_din.poke(south_din)
            dut.io.south_din_v.poke(south_din_v)
            dut.io.south_dout_r.poke(south_dout_r)

            dut.io.west_din.poke(west_din)
            dut.io.west_din_v.poke(west_din_v)
            dut.io.west_dout_r.poke(west_dout_r)

            dut.io.north_dout_r.poke(north_dout_r)
            dut.io.east_dout_r.poke(east_dout_r)

            dut.io.south_dout_r.poke(south_dout_r)
            dut.io.west_dout_r.poke(west_dout_r)
            dut.io.catch_config.poke(catch_config)
            
            dut.io.catch_config.poke(true.B)
            dut.io.config_bits.poke(config_bits)
            dut.clock.step(1)
            dut.io.catch_config.poke(false.B)

            dut.io.north_din.poke(12.U)
            dut.io.north_din_v.poke(true.B)
            dut.io.north_dout_r.poke(true.B)
            dut.io.west_din.poke(13.U)
            dut.io.west_din_v.poke(true.B)
            dut.io.west_dout_r.poke(true.B)
            dut.clock.step(1)
            dut.io.north_din.poke(14.U)
            dut.io.north_din_v.poke(true.B)
            dut.io.north_dout_r.poke(true.B)
            dut.io.west_din.poke(15.U)
            dut.io.west_din_v.poke(true.B)
            dut.io.west_dout_r.poke(true.B)
            dut.clock.step(1)
            dut.clock.step(1)
            dut.clock.step(1)
            dut.clock.step(1)
            dut.io.north_din_v.poke(false.B)
            dut.io.west_din_v.poke(false.B)
            println("*************************************")
            println("*************************************")
            dut.clock.step(1)
            dut.clock.step(1)
            dut.clock.step(1)
            dut.clock.step(1)
            dut.clock.step(1)
            dut.clock.step(1)
            dut.clock.step(1)
            dut.clock.step(1)
            dut.clock.step(1)
            dut.clock.step(1)
            dut.clock.step(1)
            dut.clock.step(1)
            dut.clock.step(1)
            // Outputs
            println("Outputs")
            println("north_din_r: " + dut.io.north_din_r.peek().toString)
            println("east_din_r: " + dut.io.east_din_r.peek().toString)
            println("south_din_r: " + dut.io.south_din_r.peek().toString)
            println("west_din_r: " + dut.io.west_din_r.peek().toString)
            println("north_dout: " + dut.io.north_dout.peek().toString)
            println("north_dout_v: " + dut.io.north_dout_v.peek().toString)
            println("east_dout: " + dut.io.east_dout.peek().toString)
            println("east_dout_v: " + dut.io.east_dout_v.peek().toString)
            println("south_dout: " + dut.io.south_dout.peek().toString)
            println("south_dout_v: " + dut.io.south_dout_v.peek().toString)
            println("west_dout: " + dut.io.west_dout.peek().toString)
            println("west_dout_v: " + dut.io.west_dout_v.peek().toString)
            println("*************************************")
            println("*************************************")
        }
    } 
}