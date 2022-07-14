///////////////////////////////////////
//                                   //
//              FS Test              //
//                                   //
///////////////////////////////////////

import chisel3._
import chiseltest._
import org.scalatest.flatspec.AnyFlatSpec

class FSTest extends AnyFlatSpec with ChiselScalatestTester {
    "FSTest test" should "pass" in {
        test(new FS(6)) { dut =>
            
            var ready_out = "b1010".U 
            var fork_mask = "b1010".U 
        
            dut.io.ready_out.poke(ready_out)
            dut.io.fork_mask.poke(fork_mask)
            println("*************************************")
            println("*************************************")
            println("Ready Out: " + dut.io.ready_out.peek().toString)
            println("Fork Mask: " + dut.io.fork_mask.peek().toString)
            dut.clock.step(1)
            println("--------------------------------------")
            println("Ready In: " + dut.io.ready_in.peek().toString)
            println("*************************************")
            println("*************************************")
        }
    } 
}