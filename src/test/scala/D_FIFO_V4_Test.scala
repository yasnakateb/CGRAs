/****************************************** 
 *      \`-._           __                *
 *       \\  `-..____,.'  `.              *
 *        :`.         /    \`.            *
 *        :  )       :      : \           *
 *         ;'        '   ;  |  :          *
 *         )..      .. .:.`.;  :          *
 *        /::...  .:::...   ` ;           *
 *        ; _ '    __        /:\          *
 *        `:o>   /\o_>      ;:. `.        *
 *       `-`.__ ;   __..--- /:.   \       *
 *       === \_/   ;=====_.':.     ;      *
 *        ,/'`--'...`--....        ;      *
 *             ;                    ;     *
 *           .'                      ;    *
 *         .'                        ;    *
 *       .'     ..     ,      .       ;   *
 *      :       ::..  /      ;::.     |   *
 *     /      `.;::.  |       ;:..    ;   *
 *    :         |:.   :       ;:.    ;    *
 *    :         ::     ;:..   |.    ;     *
 *     :       :;      :::....|     |     *
 *     /\     ,/ \      ;:::::;     ;     *
 *   .:. \:..|    :     ; '.--|     ;     *
 *  ::.  :''  `-.,,;     ;'   ;     ;     *
 * .-'. _.'\      / `;      \,__:      \  *
 * `---'    `----'   ;      /    \,.,,,/  *
 *                  `----`                *
 * ****************************************
 * Yasna Katebzadeh                       *
 * yasna.katebzadeh@gmail.com             *
 ******************************************/

import chisel3._
import chiseltest._
import org.scalatest.flatspec.AnyFlatSpec

class D_FIFO_V4_Test extends AnyFlatSpec with ChiselScalatestTester {
    "D_FIFO_V4_Test test" should "pass" in {
        test(new D_FIFO_V4(32, 32)) { dut =>
            
            var din_v = true.B 
            var dout_r = true.B 
            
            dut.io.dout_r.poke(dout_r)
            
            dut.clock.step(1)
            dut.io.din.poke(1.U)
            dut.io.din_v.poke(din_v)
            dut.clock.step(1)
            dut.io.din.poke(2.U)
            dut.clock.step(1)
            dut.io.din.poke(3.U)
            dut.clock.step(1)
            dut.io.din.poke(4.U)
            dut.clock.step(1)
            dut.io.din.poke(5.U)
            dut.clock.step(1)
            dut.io.din.poke(6.U)
            dut.clock.step(1)
            dut.io.din.poke(7.U)
            dut.clock.step(1)
            dut.io.din.poke(8.U)
            dut.clock.step(1)
            dut.io.din.poke(9.U)
            dut.clock.step(1)
            dut.io.din.poke(10.U)
            dut.clock.step(1)
            dut.io.din.poke(11.U)
            dut.clock.step(1)
            dut.io.din.poke(12.U)
            dut.clock.step(1)
            dut.io.din.poke(13.U)
            dut.clock.step(1)
            dut.io.din.poke(14.U)
            dut.clock.step(1)
            dut.io.din.poke(15.U)
            dut.clock.step(1)
            dut.io.din.poke(16.U)
            dut.clock.step(1)
            dut.io.din.poke(17.U)
            dut.clock.step(1)
            dut.io.din.poke(18.U)
            dut.clock.step(1)
            dut.io.din.poke(19.U)
            dut.clock.step(1)
            dut.io.din.poke(20.U)
            dut.clock.step(1)
            dut.io.din.poke(21.U)
            dut.clock.step(1)
            dut.io.din.poke(22.U)
            dut.clock.step(1)
            dut.io.din.poke(23.U)
            dut.clock.step(1)
            dut.io.din.poke(24.U)
            dut.clock.step(1)
            dut.io.din.poke(25.U)
            dut.clock.step(1)
            dut.io.din.poke(26.U)
            dut.clock.step(1)
            dut.io.din.poke(27.U)
            dut.clock.step(1)
            dut.io.din.poke(28.U)
            dut.clock.step(1)
            dut.io.din.poke(29.U)
            dut.clock.step(1)
            dut.io.din.poke(31.U)
            dut.clock.step(1)
            dut.io.din.poke(32.U)
            dut.clock.step(1)
            dut.io.din.poke(1.U)
            dut.clock.step(1)
            dut.io.din.poke(0.U)
            dut.io.din_v.poke(false.B)
            
            dut.clock.step(1)
            dut.clock.step(1)
            dut.clock.step(1)
            dut.clock.step(1)
            dut.clock.step(1)
            dut.clock.step(1)
            dut.clock.step(1)
            dut.clock.step(1)
            dut.clock.step(1)
            dut.clock.step(1)
            dut.clock.step(1)
            dut.clock.step(1)

            
            
            /*
            dut.io.din.poke(1.U)
            dut.io.din_v.poke(din_v)
            dut.clock.step(1)
            dut.io.din.poke(3.U)
            dut.clock.step(1)
            dut.io.din.poke(5.U)
            dut.clock.step(1)
            dut.io.din.poke(7.U)
            dut.clock.step(1)
            dut.io.din.poke(9.U)
            dut.clock.step(1)
            dut.io.din.poke(1.U)
            dut.clock.step(1)
            dut.io.din.poke(3.U)
            dut.clock.step(1)
            dut.io.din.poke(1.U)
            dut.clock.step(1)
            dut.io.din.poke(3.U)
            dut.io.din_v.poke(false.B)
            

            dut.clock.step(1)
            dut.clock.step(1)
            dut.clock.step(1)
            dut.clock.step(1)
            dut.clock.step(1)
            dut.clock.step(1)
            dut.clock.step(1)
            dut.clock.step(1)
            dut.clock.step(1)
            dut.clock.step(1)
            dut.clock.step(1)
            dut.clock.step(1)
            */
            /*
            dut.io.din.poke(din)
            dut.io.din_v.poke(din_v)
            dut.io.dout_r.poke(dout_r)
            println("*************************************")
            println("*************************************")
            // Inputs
            println("Inputs")
            println("Din: " + dut.io.din.peek().toString)
            println("Din V: " + dut.io.din_v.peek().toString)
            println("Dout R: " + dut.io.dout_r.peek().toString)
            dut.clock.step(1)
            dut.clock.step(1)
            dut.clock.step(1)
            println("--------------------------------------")
            // Outputs
            println("Outputs")
            println("Din R: " + dut.io.din_r.peek().toString)
            println("Dout: " + dut.io.dout.peek().toString)
            println("Dout V: " + dut.io.dout_v.peek().toString)
            println("*************************************")
            println("*************************************")
            // Inputs
            println("Inputs")
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
            // Outputs
            println("Outputs")
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
            // Outputs
            println("Outputs")
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
            // Inputs
            println("Inputs")
            println("Din: " + dut.io.din.peek().toString)
            println("Din V: " + dut.io.din_v.peek().toString)
            println("Dout R: " + dut.io.dout_r.peek().toString)
            dut.clock.step(1)
            dut.clock.step(1)
            dut.clock.step(1)
            println("--------------------------------------")
            // Outputs
            println("Outputs")
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
            // Outputs
            println("Outputs")
            println("Din R: " + dut.io.din_r.peek().toString)
            println("Dout: " + dut.io.dout.peek().toString)
            println("Dout V: " + dut.io.dout_v.peek().toString)
            println("*************************************")
            println("*************************************")


            /// ====
            dut.clock.step(1)
            dut.clock.step(1)
            dut.clock.step(1)
            din = "b101110".U 
            dout_r = true.B 
            dut.io.din.poke(din)
            dut.io.din_v.poke(din_v)
            dut.io.dout_r.poke(dout_r)
            dut.clock.step(1)
            din = 1.U 
            dut.io.din.poke(din)
            dut.clock.step(1)
            din = 2.U 
            dut.io.din.poke(din)
            dut.clock.step(1)
            din = 1.U 
            dut.io.din.poke(din)
            dut.clock.step(1)
            din = 1.U 
            dut.io.din.poke(din)
            dut.clock.step(1)
            din = 2.U 
            dut.io.din.poke(din)
            dut.clock.step(1)
            din = 1.U 
            dut.io.din.poke(din)
            dut.clock.step(1)
            din = 1.U 
            dut.io.din.poke(din)
            dut.clock.step(1)
            din = 2.U 
            dut.io.din.poke(din)
            dut.clock.step(1)
            din = 1.U 
            dut.io.din.poke(din)
            dut.clock.step(1)
            din = 1.U 
            dut.io.din.poke(din)
            dut.clock.step(1)
            din = 2.U 
            dut.io.din.poke(din)
            dut.clock.step(1)
            din = 1.U 
            dut.io.din.poke(din)
            dut.clock.step(1)
            din = 1.U 
            dut.io.din.poke(din)
            dut.clock.step(1)
            din = 2.U 
            dut.io.din.poke(din)
            dut.clock.step(1)
            din = 1.U 
            dut.io.din.poke(din)
            dut.clock.step(1)
            din = 1.U 
            dut.io.din.poke(din)
            dut.clock.step(1)
            din = 2.U 
            dut.io.din.poke(din)
            dut.clock.step(1)
            din = 1.U 
            dut.io.din.poke(din)
            dut.clock.step(1)
            din = 1.U 
            dut.io.din.poke(din)
            dut.clock.step(1)
            din = 2.U 
            dut.io.din.poke(din)
            dut.clock.step(1)
            din = 1.U 
            dut.io.din.poke(din)
            dut.clock.step(1)
            din = 1.U 
            dut.io.din.poke(din)
            dut.clock.step(1)
            din = 2.U 
            dut.io.din.poke(din)
            dut.clock.step(1)
            din = 1.U 
            dut.io.din.poke(din)
            dut.clock.step(1)
            din = 1.U 
            dut.io.din.poke(din)
            dut.clock.step(1)
            din = 2.U 
            dut.io.din.poke(din)
            dut.clock.step(1)
            din = 1.U 
            dut.io.din.poke(din)
            dut.clock.step(1)
            din = 1.U 
            dut.io.din.poke(din)
            dut.clock.step(1)
            din = 2.U 
            dut.io.din.poke(din)
            dut.clock.step(1)
            din = 1.U 
            dut.io.din.poke(din)
            dut.clock.step(1)
            din = 1.U 
            dut.io.din.poke(din)
            dut.clock.step(1)
            din = 2.U 
            dut.io.din.poke(din)
            dut.clock.step(1)
            din = 1.U 
            dut.io.din.poke(din)
            dut.clock.step(1)
            din = 1.U 
            dut.io.din.poke(din)
            dut.clock.step(1)
            din = 2.U 
            dut.io.din.poke(din)
            dut.clock.step(1)
            din = 1.U 
            dut.io.din.poke(din)
            dut.clock.step(1)
            din = 1.U 
            dut.io.din.poke(din)
            dut.clock.step(1)
            din = 2.U 
            dut.io.din.poke(din)
            dut.clock.step(1)
            din = 1.U 
            dut.io.din.poke(din)
            dut.clock.step(1)
            din = 1.U 
            dut.io.din.poke(din)
            dut.clock.step(1)
            din = 2.U 
            dut.io.din.poke(din)
            dut.clock.step(1)
            din = 1.U 
            dut.io.din.poke(din)
            dut.clock.step(1)
            din = 1.U 
            dut.io.din.poke(din)
            dut.clock.step(1)
            din = 2.U 
            dut.io.din.poke(din)
            dut.clock.step(1)
            din = 1.U 
            dut.io.din.poke(din)
            dut.clock.step(1)
            din = 1.U 
            dut.io.din.poke(din)
            dut.clock.step(1)
            din = 2.U 
            dut.io.din.poke(din)
            dut.clock.step(1)
            din = 1.U 
            dut.io.din.poke(din)
            dut.clock.step(1)
            din = 1.U 
            dut.io.din.poke(din)
            dut.clock.step(1)
            din = 2.U 
            dut.io.din.poke(din)
            dut.clock.step(1)
            din = 1.U 
            dut.io.din.poke(din)
            dut.clock.step(1)
            din = 1.U 
            dut.io.din.poke(din)
            dut.clock.step(1)
            din = 2.U 
            dut.io.din.poke(din)
            dut.clock.step(1)
            din = 1.U 
            dut.io.din.poke(din)
            dut.clock.step(1)
            din = 1.U 
            dut.io.din.poke(din)
            dut.clock.step(1)
            din = 2.U 
            dut.io.din.poke(din)
            dut.clock.step(1)
            din = 1.U 
            dut.io.din.poke(din)
            dut.clock.step(1)
            din = 1.U 
            dut.io.din.poke(din)
            dut.clock.step(1)
            din = 2.U 
            dut.io.din.poke(din)
            dut.clock.step(1)
            din = 1.U 
            dut.io.din.poke(din)
            dut.clock.step(1)
            din = 1.U 
            dut.io.din.poke(din)
            dut.clock.step(1)
            din = 2.U 
            dut.io.din.poke(din)
            dut.clock.step(1)
            din = 1.U 
            dut.io.din.poke(din)
            dut.clock.step(1)
            din = 1.U 
            dut.io.din.poke(din)
            dut.clock.step(1)
            din = 2.U 
            dut.io.din.poke(din)
            dut.clock.step(1)
            din = 1.U 
            dut.io.din.poke(din)
            dut.clock.step(1)
            din = 1.U 
            dut.io.din.poke(din)
            dut.clock.step(1)
            din = 2.U 
            dut.io.din.poke(din)
            dut.clock.step(1)
            din = 1.U 
            dut.io.din.poke(din)
            dut.clock.step(1)
            */
        }
    } 
}
