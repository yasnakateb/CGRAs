import chisel3._
import chiseltest._
import org.scalatest.flatspec.AnyFlatSpec

class D_SEBTest extends AnyFlatSpec with ChiselScalatestTester {
    "D_SEBTest test" should "pass" in {
        test(new D_SEB(32)) { dut =>
            var din = 10.U 
            var din_r = false.B 
            var din_v = false.B 
            dut.io.din.poke(din)
            dut.io.din_v.poke(din_v)
            dut.io.din_r.poke(din_r)
            println("*************************************")
            println("*************************************")
            println("Dp: " + dut.io.din.peek().toString)
            // Vp: false, An: false
            println("Vp: " + dut.io.din_v.peek().toString)
            println("An: " + dut.io.din_r.peek().toString)
            dut.clock.step(1)
            println("--------------------------------------")
            println("Dn: " + dut.io.dout.peek().toString)
            println("Vn: " + dut.io.dout_v.peek().toString)
            println("Ap: " + dut.io.dout_r.peek().toString)
            println("*************************************")
            println("*************************************")
            // An: true
            din_r = true.B  
            dut.io.din_r.poke(din_r)
            println("Vp: " + dut.io.din_v.peek().toString)
            println("An: " + dut.io.din_r.peek().toString)
            dut.clock.step(1)
            dut.clock.step(1)
            dut.clock.step(1)
            println("--------------------------------------")
            println("Dn: " + dut.io.dout.peek().toString)
            println("Vn: " + dut.io.dout_v.peek().toString)
            println("Ap: " + dut.io.dout_r.peek().toString)
            println("*************************************")
            println("*************************************")
            // Vp: true, An: true
            din_v = true.B  
            din_r = true.B  
            dut.io.din_v.poke(din_v)
            dut.io.din_r.poke(din_r)
            println("Vp: " + dut.io.din_v.peek().toString)
            println("An: " + dut.io.din_r.peek().toString)
            dut.clock.step(1)
            dut.clock.step(1)
            dut.clock.step(1)
            println("--------------------------------------")
            println("Dn: " + dut.io.dout.peek().toString)
            println("Vn: " + dut.io.dout_v.peek().toString)
            println("Ap: " + dut.io.dout_r.peek().toString)
            println("*************************************")
            println("*************************************")
            // Vp: true, An: true
            din_v = true.B  
            din_r = false.B  
            dut.io.din_v.poke(din_v)
            dut.io.din_r.poke(din_r)
            println("Vp: " + dut.io.din_v.peek().toString)
            println("An: " + dut.io.din_r.peek().toString)
            dut.clock.step(1)
            dut.clock.step(1)
            dut.clock.step(1)
            println("--------------------------------------")
            println("Dn: " + dut.io.dout.peek().toString)
            println("Vn: " + dut.io.dout_v.peek().toString)
            println("Ap: " + dut.io.dout_r.peek().toString)
            println("*************************************")
            println("*************************************")
        }
    } 
}
