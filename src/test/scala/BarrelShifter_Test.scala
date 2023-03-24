///////////////////////////////////////
//                                   //
//    Barrel Shifter Unit Test       //
//                                   //
///////////////////////////////////////

import chisel3._
import chiseltest._
import org.scalatest.flatspec.AnyFlatSpec


class BarrelShifter_Test extends AnyFlatSpec with ChiselScalatestTester {
    "BarrelShifter_Test test" should "pass" in {
            test(new BarrelShifter) { dut =>
            /*************************************
            var load = 1.B 
            *************************************/
            //?
            // var load = 1.B 
            var inbit = 0.U
            var in = 2048.U
            // Load ? 
            //dut.io.load.poke(load)
            dut.io.in.poke(in)
            dut.io.inbit.poke(inbit)
            dut.clock.step(1)
            println("Output: " + dut.io.out.peek().toString)

            // Right Shift 
            // ?
            //load = 0.B
            var shiftnum = 9.U
            var rshift = 1.B 
            dut.io.shiftnum.poke(shiftnum) 
            //?
            //dut.io.load.poke(load)
            dut.io.rshift.poke(rshift) 
            dut.clock.step(1)
            println("Output: " + dut.io.out.peek().toString)
            // ?
            //load = 1.B 
            in = 1.U
            // Load ===> Make sure that rshift = 0
            //?
            //dut.io.load.poke(load)
            dut.io.in.poke(in)
            rshift = 0.B 
            dut.io.rshift.poke(rshift)
            dut.clock.step(1)
            println("Output: " + dut.io.out.peek().toString)

            // Left Shift
            //? 
            //load = 0.B
            shiftnum = 9.U
            
            var lshift = 1.B 
            dut.io.shiftnum.poke(shiftnum) 
            //?
            //dut.io.load.poke(load)
            dut.io.lshift.poke(lshift) 
            
            dut.clock.step(1)
            dut.clock.step(1)
            dut.clock.step(1)
            println("Output: " + dut.io.out.peek().toString)

        }
    }    
}
