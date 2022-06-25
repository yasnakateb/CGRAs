import chisel3._
import chiseltest._
import org.scalatest.flatspec.AnyFlatSpec

class FRTest extends AnyFlatSpec with ChiselScalatestTester {
    "FRTest test" should "pass" in {
        test(new FR(5,2)) { dut =>
            
            var afu_in_1 = true 
            var afu_in_2 = true 
            var ae_out = true 
            var as_out = true 
            var aw_out = true 
            var vfu_out = true 
            var ve_in = true 
            var vs_in = true 
            var vw_in = true 
        
            dut.io.afu_in_1.poke(afu_in_1.B)
            dut.io.afu_in_2.poke(afu_in_2.B)
            dut.io.ae_out.poke(ae_out.B)
            dut.io.as_out.poke(as_out.B)
            dut.io.aw_out.poke(aw_out.B)
            dut.io.vfu_out.poke(vfu_out.B)
            dut.io.ve_in.poke(ve_in.B)
            dut.io.vs_in.poke(vs_in.B)
            dut.io.vw_in.poke(vw_in.B)
            println("*************************************")
            println("*************************************")
            println("AFU_In_1: " + dut.io.afu_in_1.peek().toString)
            println("AFU_In_2: " + dut.io.afu_in_2.peek().toString)
            println("AE_Out: " + dut.io.ae_out.peek().toString)
            println("AS_Out: " + dut.io.as_out.peek().toString)
            println("AW_Out: " + dut.io.aw_out.peek().toString)
            println("VFU_Out: " + dut.io.vfu_out.peek().toString)
            println("VE_Out: " + dut.io.ve_in.peek().toString)
            println("VS_Out: " + dut.io.vs_in.peek().toString)
            println("VW_Out: " + dut.io.vw_in.peek().toString)
            println("*************************************")
            println("*************************************")
            dut.clock.step(1)
            println("--------------------------------------")
            println("VN_Out: " + dut.io.vn_out.peek().toString)
            println("*************************************")
            println("*************************************")
            vfu_out = false  
            ve_in = false  
            vs_in = false  
            vw_in = false  
            dut.io.vfu_out.poke(vfu_out.B)
            dut.io.ve_in.poke(ve_in.B)
            dut.io.vs_in.poke(vs_in.B)
            dut.io.vw_in.poke(vw_in.B)
            println("AFU_In_1: " + dut.io.afu_in_1.peek().toString)
            println("AFU_In_2: " + dut.io.afu_in_2.peek().toString)
            println("AE_Out: " + dut.io.ae_out.peek().toString)
            println("AS_Out: " + dut.io.as_out.peek().toString)
            println("AW_Out: " + dut.io.aw_out.peek().toString)
            println("VFU_Out: " + dut.io.vfu_out.peek().toString)
            println("VE_Out: " + dut.io.ve_in.peek().toString)
            println("VS_Out: " + dut.io.vs_in.peek().toString)
            println("VW_Out: " + dut.io.vw_in.peek().toString)
            println("*************************************")
            println("*************************************")
            dut.clock.step(1)
            println("--------------------------------------")
            println("VN_Out: " + dut.io.vn_out.peek().toString)
            println("*************************************")
            println("*************************************")
        }
    } 
}