///////////////////////////////////////
//                                   //
//             Join Test             //
//                                   //
///////////////////////////////////////

import chisel3._
import chiseltest._
import org.scalatest.flatspec.AnyFlatSpec

class Join_Test extends AnyFlatSpec with ChiselScalatestTester {
    "Join_Test test" should "pass" in {
        test(new Join(32)) { dut =>
            var din_1 = 10
            var din_2 = 5
            var din_1_v = false 
            var din_2_v = false
            var dout_r = false
            dut.io.din_1.poke(din_1.U)
            dut.io.din_2.poke(din_2.U)
            dut.io.din_1_v.poke(din_1_v.B)
            dut.io.din_2_v.poke(din_2_v.B)
            dut.io.dout_r.poke(dout_r.B)
            dut.clock.step(1)
            dut.clock.step(1)
            dut.clock.step(1)
            dut.clock.step(1)
            println("*************************************")
            println("*************************************")
            println("Din1: " + dut.io.dout_1.peek().toString)
            println("Din2: " + dut.io.dout_2.peek().toString)
            println("*************************************")
            println("*************************************")
            // Vin1: false, Vin2: false, Aout: false
            println("Vin1: " + dut.io.din_1_v.peek().toString)
            println("Vin2: " + dut.io.din_2_v.peek().toString)
            println("Aout: " + dut.io.dout_r.peek().toString)
            dut.clock.step(1)
            println("--------------------------------------")
            println("Ain1: " + dut.io.din_1_r.peek().toString)
            println("Ain2: " + dut.io.din_2_r.peek().toString)
            println("Dout1: " + dut.io.dout_1.peek().toString)
            println("Dout2: " + dut.io.dout_2.peek().toString)
            println("Vout: " + dut.io.dout_v.peek().toString)
            println("*************************************")
            println("*************************************")
            // Vin1: true, Vin2: false, Aout: false
            din_1_v = true 
            dut.io.din_1_v.poke(din_1_v.B)
            println("Vin1: " + dut.io.din_1_v.peek().toString)
            println("Vin2: " + dut.io.din_2_v.peek().toString)
            println("Aout: " + dut.io.dout_r.peek().toString)
            dut.clock.step(1)
            println("--------------------------------------")
            println("Ain1: " + dut.io.din_1_r.peek().toString)
            println("Ain2: " + dut.io.din_2_r.peek().toString)
            println("Vout: " + dut.io.dout_v.peek().toString)
            println("*************************************")
            println("*************************************")
            // Vin1: false, Vin2: true, Aout: false
            din_2_v = true
            din_1_v = false 
            dut.io.din_1_v.poke(din_1_v.B)
            dut.io.din_2_v.poke(din_2_v.B)
            println("Vin1: " + dut.io.din_1_v.peek().toString)
            println("Vin2: " + dut.io.din_2_v.peek().toString)
            println("Aout: " + dut.io.dout_r.peek().toString)
            dut.clock.step(1)
            println("--------------------------------------")
            println("Ain1: " + dut.io.din_1_r.peek().toString)
            println("Ain2: " + dut.io.din_2_r.peek().toString)
            println("Vout: " + dut.io.dout_v.peek().toString)
            println("*************************************")
            println("*************************************")
            // Vin1: false, Vin2: true, Aout: true
            din_2_v = true
            din_1_v = false 
            dout_r = true  
            dut.io.din_1_v.poke(din_1_v.B)
            dut.io.din_2_v.poke(din_2_v.B)
            dut.io.dout_r.poke(dout_r.B)
            println("Vin1: " + dut.io.din_1_v.peek().toString)
            println("Vin2: " + dut.io.din_2_v.peek().toString)
            println("Aout: " + dut.io.dout_r.peek().toString)
            dut.clock.step(1)
            println("--------------------------------------")
            println("Ain1: " + dut.io.din_1_r.peek().toString)
            println("Ain2: " + dut.io.din_2_r.peek().toString)
            println("Vout: " + dut.io.dout_v.peek().toString)
            println("*************************************")
            println("*************************************")
            // Vin1: true, Vin2: true, Aout: true
            din_2_v = true
            din_1_v = true 
            dout_r = true  
            dut.io.din_1_v.poke(din_1_v.B)
            dut.io.din_2_v.poke(din_2_v.B)
            dut.io.dout_r.poke(dout_r.B)
            println("Vin1: " + dut.io.din_1_v.peek().toString)
            println("Vin2: " + dut.io.din_2_v.peek().toString)
            println("Aout: " + dut.io.dout_r.peek().toString)
            dut.clock.step(1)
            println("--------------------------------------")
            println("Ain1: " + dut.io.din_1_r.peek().toString)
            println("Ain2: " + dut.io.din_2_r.peek().toString)
            println("Vout: " + dut.io.dout_v.peek().toString)
            println("*************************************")
            println("*************************************")
        }
    } 
}
