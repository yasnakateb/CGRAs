import chisel3._
import chiseltest._
import org.scalatest.flatspec.AnyFlatSpec

class JoinTest extends AnyFlatSpec with ChiselScalatestTester {
    "JoinTest test" should "pass" in {
        test(new Join(8)) { dut =>
            var d_in_1 = 10
            var d_in_2 = 5
            var v_in_1 = false 
            var v_in_2 = false
            var a_out = false
            dut.io.d_in_1.poke(d_in_1.U)
            dut.io.d_in_2.poke(d_in_2.U)
            dut.io.v_in_1.poke(v_in_1.B)
            dut.io.v_in_2.poke(v_in_2.B)
            dut.io.a_out.poke(a_out.B)
            println("*************************************")
            println("*************************************")
            println("Din1: " + dut.io.d_in_1.peek().toString)
            println("Din2: " + dut.io.d_in_2.peek().toString)
            println("*************************************")
            println("*************************************")
            // Vin1: false, Vin2: false, Aout: false
            println("Vin1: " + dut.io.v_in_1.peek().toString)
            println("Vin2: " + dut.io.v_in_2.peek().toString)
            println("Aout: " + dut.io.a_out.peek().toString)
            dut.clock.step(1)
            println("--------------------------------------")
            println("Ain1: " + dut.io.a_in_1.peek().toString)
            println("Ain2: " + dut.io.a_in_2.peek().toString)
            println("Dout1: " + dut.io.d_out_1.peek().toString)
            println("Dout2: " + dut.io.d_out_2.peek().toString)
            println("Vout: " + dut.io.v_out.peek().toString)
            println("*************************************")
            println("*************************************")
            // Vin1: true, Vin2: false, Aout: false
            v_in_1 = true 
            dut.io.v_in_1.poke(v_in_1.B)
            println("Vin1: " + dut.io.v_in_1.peek().toString)
            println("Vin2: " + dut.io.v_in_2.peek().toString)
            println("Aout: " + dut.io.a_out.peek().toString)
            dut.clock.step(1)
            println("--------------------------------------")
            println("Ain1: " + dut.io.a_in_1.peek().toString)
            println("Ain2: " + dut.io.a_in_2.peek().toString)
            println("Vout: " + dut.io.v_out.peek().toString)
            println("*************************************")
            println("*************************************")
            // Vin1: false, Vin2: true, Aout: false
            v_in_2 = true
            v_in_1 = false 
            dut.io.v_in_1.poke(v_in_1.B)
            dut.io.v_in_2.poke(v_in_2.B)
            println("Vin1: " + dut.io.v_in_1.peek().toString)
            println("Vin2: " + dut.io.v_in_2.peek().toString)
            println("Aout: " + dut.io.a_out.peek().toString)
            dut.clock.step(1)
            println("--------------------------------------")
            println("Ain1: " + dut.io.a_in_1.peek().toString)
            println("Ain2: " + dut.io.a_in_2.peek().toString)
            println("Vout: " + dut.io.v_out.peek().toString)
            println("*************************************")
            println("*************************************")
            // Vin1: false, Vin2: true, Aout: true
            v_in_2 = true
            v_in_1 = false 
            a_out = true  
            dut.io.v_in_1.poke(v_in_1.B)
            dut.io.v_in_2.poke(v_in_2.B)
            dut.io.a_out.poke(a_out.B)
            println("Vin1: " + dut.io.v_in_1.peek().toString)
            println("Vin2: " + dut.io.v_in_2.peek().toString)
            println("Aout: " + dut.io.a_out.peek().toString)
            dut.clock.step(1)
            println("--------------------------------------")
            println("Ain1: " + dut.io.a_in_1.peek().toString)
            println("Ain2: " + dut.io.a_in_2.peek().toString)
            println("Vout: " + dut.io.v_out.peek().toString)
            println("*************************************")
            println("*************************************")
            // Vin1: true, Vin2: true, Aout: true
            v_in_2 = true
            v_in_1 = true 
            a_out = true  
            dut.io.v_in_1.poke(v_in_1.B)
            dut.io.v_in_2.poke(v_in_2.B)
            dut.io.a_out.poke(a_out.B)
            println("Vin1: " + dut.io.v_in_1.peek().toString)
            println("Vin2: " + dut.io.v_in_2.peek().toString)
            println("Aout: " + dut.io.a_out.peek().toString)
            dut.clock.step(1)
            println("--------------------------------------")
            println("Ain1: " + dut.io.a_in_1.peek().toString)
            println("Ain2: " + dut.io.a_in_2.peek().toString)
            println("Vout: " + dut.io.v_out.peek().toString)
            println("*************************************")
            println("*************************************")
        }
    } 
}