import chisel3._
import chiseltest._
import org.scalatest.flatspec.AnyFlatSpec

class D_FIFOTest extends AnyFlatSpec with ChiselScalatestTester {
    "D_FIFOTest test" should "pass" in {
        test(new D_FIFO(32, 4)) { dut =>
            
            var din = "b101010".U 
            var din_v = true.B 
            var dout_r = true.B 

            dut.io.din.poke(din)
            dut.io.din_v.poke(din_v)
            dut.io.dout_r.poke(dout_r)
            println("*************************************")
            println("*************************************")
            println("Din: " + dut.io.din.peek().toString)
            println("Din V: " + dut.io.din_v.peek().toString)
            println("Dout R: " + dut.io.dout_r.peek().toString)
            dut.clock.step(1)
            dut.clock.step(1)
            dut.clock.step(1)
            println("--------------------------------------")
            println("Din R: " + dut.io.din_r.peek().toString)
            println("Dout: " + dut.io.dout.peek().toString)
            println("Dout V: " + dut.io.dout_v.peek().toString)
            println("*************************************")
            println("*************************************")
            println("Din: " + dut.io.din.peek().toString)
            println("Din V: " + dut.io.din_v.peek().toString)
            println("Dout R: " + dut.io.dout_r.peek().toString)
            din_v = true.B 
            dout_r = true.B 
            // dut.io.din.poke(din)
            dut.io.din_v.poke(din_v)
            dut.io.dout_r.poke(dout_r)
            dut.clock.step(1)
            dut.clock.step(1)
            dut.clock.step(1)
            println("--------------------------------------")
            println("Din R: " + dut.io.din_r.peek().toString)
            println("Dout: " + dut.io.dout.peek().toString)
            println("Dout V: " + dut.io.dout_v.peek().toString)
            println("*************************************")
            println("*************************************")
            din_v = true.B 
            din = "b101011".U 
            dout_r = false.B 
            dut.io.din.poke(din)
            dut.io.din_v.poke(din_v)
            dut.io.dout_r.poke(dout_r)
            println("Din: " + dut.io.din.peek().toString)
            println("Din V: " + dut.io.din_v.peek().toString)
            println("Dout R: " + dut.io.dout_r.peek().toString)
            dut.clock.step(1)
            dut.clock.step(1)
            dut.clock.step(1)
            println("--------------------------------------")
            println("Din R: " + dut.io.din_r.peek().toString)
            println("Dout: " + dut.io.dout.peek().toString)
            println("Dout V: " + dut.io.dout_v.peek().toString)
            println("*************************************")
            println("*************************************")
            din_v = true.B 
            din = "b101100".U 
            dout_r = true.B 
            dut.io.din.poke(din)
            dut.io.din_v.poke(din_v)
            dut.io.dout_r.poke(dout_r)
            println("Din: " + dut.io.din.peek().toString)
            println("Din V: " + dut.io.din_v.peek().toString)
            println("Dout R: " + dut.io.dout_r.peek().toString)
            dut.clock.step(1)
            dut.clock.step(1)
            dut.clock.step(1)
            println("--------------------------------------")
            println("Din R: " + dut.io.din_r.peek().toString)
            println("Dout: " + dut.io.dout.peek().toString)
            println("Dout V: " + dut.io.dout_v.peek().toString)
            println("*************************************")
            println("*************************************")
            din = "b101101".U 
            dout_r = true.B 
            dut.io.din.poke(din)
            dut.io.din_v.poke(din_v)
            dut.io.dout_r.poke(dout_r)
            println("Din: " + dut.io.din.peek().toString)
            println("Din V: " + dut.io.din_v.peek().toString)
            println("Dout R: " + dut.io.dout_r.peek().toString)
            dut.clock.step(1)
            dut.clock.step(1)
            dut.clock.step(1)
            println("--------------------------------------")
            println("Din R: " + dut.io.din_r.peek().toString)
            println("Dout: " + dut.io.dout.peek().toString)
            println("Dout V: " + dut.io.dout_v.peek().toString)
            println("*************************************")
            println("*************************************")
            din = "b101110".U 
            dout_r = false.B 
            dut.io.din.poke(din)
            dut.io.din_v.poke(din_v)
            dut.io.dout_r.poke(dout_r)
            println("Din: " + dut.io.din.peek().toString)
            println("Din V: " + dut.io.din_v.peek().toString)
            println("Dout R: " + dut.io.dout_r.peek().toString)
            dut.clock.step(1)
            dut.clock.step(1)
            dut.clock.step(1)
            println("--------------------------------------")
            println("Din R: " + dut.io.din_r.peek().toString)
            println("Dout: " + dut.io.dout.peek().toString)
            println("Dout V: " + dut.io.dout_v.peek().toString)
            println("*************************************")
            println("*************************************")
            dut.clock.step(1)
            dut.clock.step(1)
            dut.clock.step(1)

        }
    } 
}