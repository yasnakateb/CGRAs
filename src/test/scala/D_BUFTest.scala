///////////////////////////////////////
//                                   //
//             D-BUF Test            //
//                                   //
///////////////////////////////////////

import chisel3._
import chiseltest._
import org.scalatest.flatspec.AnyFlatSpec

class D_BUFTest extends AnyFlatSpec with ChiselScalatestTester {
    "D_BUFTest test" should "pass" in {
        test(new D_BUF(8)) { dut =>
            var d_p = 10
            var a_n = false
            var v_p = false
            dut.io.d_p.poke(d_p.U)
            dut.io.a_n.poke(a_n.B)
            dut.io.v_p.poke(v_p.B)
            println("*************************************")
            println("*************************************")
            println("Dp: " + dut.io.d_p.peek().toString)
            println("*************************************")
            println("*************************************")
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
            // An: true, Vp: true
            a_n = true
            v_p = true 
            dut.io.a_n.poke(a_n.B)
            dut.io.v_p.poke(v_p.B)
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