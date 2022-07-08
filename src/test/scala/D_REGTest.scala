import chisel3._
import chiseltest._
import org.scalatest.flatspec.AnyFlatSpec

class D_REGTest extends AnyFlatSpec with ChiselScalatestTester {
    "D_REGTest test" should "pass" in {
        test(new D_REG(8)) { dut =>
            var din = 10
            var dout_r = false
            var din_v = false
            dut.io.din.poke(din.U)
            dut.io.dout_r.poke(dout_r.B)
            dut.io.din_v.poke(din_v.B)
            println("*************************************")
            println("*************************************")
            println("Dp: " + dut.io.din.peek().toString)
            println("*************************************")
            println("*************************************")
            // Vp: false, An: false
            println("Vp: " + dut.io.din_v.peek().toString)
            println("An: " + dut.io.dout_r.peek().toString)
            dut.clock.step(1)
            println("--------------------------------------")
            println("Dn: " + dut.io.dout.peek().toString)
            println("Vn: " + dut.io.dout_v.peek().toString)
            println("Ap: " + dut.io.din_r.peek().toString)
            println("*************************************")
            println("*************************************")
            // Vp: true, An: true
            dout_r = true 
            din_v = true 
            dut.io.dout_r.poke(dout_r.B)
            dut.io.din_v.poke(din_v.B)
            println("Vp: " + dut.io.din_v.peek().toString)
            println("An: " + dut.io.dout_r.peek().toString)
            dut.clock.step(1)
            dut.clock.step(1)
            dut.clock.step(1)
            println("--------------------------------------")
            println("Dn: " + dut.io.dout.peek().toString)
            println("Vn: " + dut.io.dout_v.peek().toString)
            println("Ap: " + dut.io.din_r.peek().toString)
            println("*************************************")
            println("*************************************")
        }
    } 
}
