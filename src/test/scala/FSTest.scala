import chisel3._
import chiseltest._
import org.scalatest.flatspec.AnyFlatSpec

class FSTest extends AnyFlatSpec with ChiselScalatestTester {
    "FSTest test" should "pass" in {
        test(new FS(5)) { dut =>
            
            var afu_in_1 = true 
            var afu_in_2 = true 
            var ae_out = true 
            var as_out = true 
            var aw_out = true 
            
            dut.io.afu_in_1.poke(afu_in_1.B)
            dut.io.afu_in_2.poke(afu_in_2.B)
            dut.io.ae_out.poke(ae_out.B)
            dut.io.as_out.poke(as_out.B)
            dut.io.aw_out.poke(aw_out.B)
            println("*************************************")
            println("*************************************")
            println("AFU_In_1: " + dut.io.afu_in_1.peek().toString)
            println("AFU_In_2: " + dut.io.afu_in_2.peek().toString)
            println("AE_Out: " + dut.io.ae_out.peek().toString)
            println("AS_Out: " + dut.io.as_out.peek().toString)
            println("AW_Out: " + dut.io.aw_out.peek().toString)
            println("*************************************")
            println("*************************************")
            dut.clock.step(1)
            println("--------------------------------------")
            println("AN_In: " + dut.io.an_in.peek().toString)
            println("*************************************")
            println("*************************************")
            ae_out = false 
            aw_out = false  
            dut.io.ae_out.poke(ae_out.B)
            dut.io.aw_out.poke(aw_out.B)
            println("AFU_In_1: " + dut.io.afu_in_1.peek().toString)
            println("AFU_In_2: " + dut.io.afu_in_2.peek().toString)
            println("AE_Out: " + dut.io.ae_out.peek().toString)
            println("AS_Out: " + dut.io.as_out.peek().toString)
            println("AW_Out: " + dut.io.aw_out.peek().toString)
            println("*************************************")
            println("*************************************")
            dut.clock.step(1)
            println("--------------------------------------")
            println("AN_In: " + dut.io.an_in.peek().toString)
            println("*************************************")
            println("*************************************")
            afu_in_1 = false 
            afu_in_2 = false  
            ae_out = true 
            as_out = false  
            aw_out = true 
            dut.io.afu_in_1.poke(afu_in_1.B)
            dut.io.afu_in_2.poke(afu_in_2.B)
            dut.io.ae_out.poke(ae_out.B)
            dut.io.as_out.poke(as_out.B)
            dut.io.aw_out.poke(aw_out.B)
            println("AFU_In_1: " + dut.io.afu_in_1.peek().toString)
            println("AFU_In_2: " + dut.io.afu_in_2.peek().toString)
            println("AE_Out: " + dut.io.ae_out.peek().toString)
            println("AS_Out: " + dut.io.as_out.peek().toString)
            println("AW_Out: " + dut.io.aw_out.peek().toString)
            println("*************************************")
            println("*************************************")
            dut.clock.step(1)
            println("--------------------------------------")
            println("AN_In: " + dut.io.an_in.peek().toString)
            println("*************************************")
            println("*************************************")
        }
    } 
}