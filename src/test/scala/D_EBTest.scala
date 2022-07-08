import chisel3._
import chiseltest._
import org.scalatest.flatspec.AnyFlatSpec

class D_EBTest extends AnyFlatSpec with ChiselScalatestTester {
    "D_EBTest test" should "pass" in {
        test(new D_EB(32)) { dut =>
            var d_p = 10.U 
            var a_n = false.B 
            var v_p = false.B 
            dut.io.d_p.poke(d_p)
             dut.io.v_p.poke(v_p)
            dut.io.a_n.poke(a_n)
            println("*************************************")
            println("*************************************")
            println("Dp: " + dut.io.d_p.peek().toString)
            // Vp: false, An: false
            println("Vp: " + dut.io.v_p.peek().toString)
            println("An: " + dut.io.a_n.peek().toString)
            dut.clock.step(1)
            println("--------------------------------------")
            println("Dn: " + dut.io.d_n.peek().toString)
            println("Vn: " + dut.io.v_n.peek().toString)
            println("Ap: " + dut.io.a_p.peek().toString)
            println("*************************************")
            println("*************************************")
            // An: true
            a_n = true.B  
            dut.io.a_n.poke(a_n)
            println("Vp: " + dut.io.v_p.peek().toString)
            println("An: " + dut.io.a_n.peek().toString)
            dut.clock.step(1)
            dut.clock.step(1)
            dut.clock.step(1)
            println("--------------------------------------")
            println("Dn: " + dut.io.d_n.peek().toString)
            println("Vn: " + dut.io.v_n.peek().toString)
            println("Ap: " + dut.io.a_p.peek().toString)
            println("*************************************")
            println("*************************************")
            // Vp: true, An: true
            v_p = true.B  
            a_n = true.B  
            dut.io.v_p.poke(v_p)
            dut.io.a_n.poke(a_n)
            println("Vp: " + dut.io.v_p.peek().toString)
            println("An: " + dut.io.a_n.peek().toString)
            dut.clock.step(1)
            dut.clock.step(1)
            dut.clock.step(1)
            println("--------------------------------------")
            println("Dn: " + dut.io.d_n.peek().toString)
            println("Vn: " + dut.io.v_n.peek().toString)
            println("Ap: " + dut.io.a_p.peek().toString)
            println("*************************************")
            println("*************************************")
            // Vp: true, An: true
            v_p = true.B  
            a_n = false.B  
            dut.io.v_p.poke(v_p)
            dut.io.a_n.poke(a_n)
            println("Vp: " + dut.io.v_p.peek().toString)
            println("An: " + dut.io.a_n.peek().toString)
            dut.clock.step(1)
            dut.clock.step(1)
            dut.clock.step(1)
            println("--------------------------------------")
            println("Dn: " + dut.io.d_n.peek().toString)
            println("Vn: " + dut.io.v_n.peek().toString)
            println("Ap: " + dut.io.a_p.peek().toString)
            println("*************************************")
            println("*************************************")
        }
    } 
}