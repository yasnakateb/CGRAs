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

class D_FIFO_Test extends AnyFlatSpec with ChiselScalatestTester {
    "D_FIFO_Test test" should "pass" in {
        test(new D_FIFO(32, 32)) { dut =>
            
            var din_v = true.B 
            var dout_r = true.B 
            
            dut.io.dout_r.poke(dout_r)
            dut.clock.step(1)
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
