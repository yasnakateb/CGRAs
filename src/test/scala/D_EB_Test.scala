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

class D_EB_Test extends AnyFlatSpec with ChiselScalatestTester {
    "D_EB_Test test" should "pass" in {
        test(new D_EB(32)) { dut =>
            var din = 10.S  
            var dout_r = false.B 
            var din_v = false.B 
            dut.io.din.poke(din)
            dut.io.din_v.poke(din_v)
            dut.io.dout_r.poke(dout_r)
            ////////////////////////////////////////////////////////////////
            // Test 1 
            ////////////////////////////////////////////////////////////////
            println("*************************************")
            println("Test 1: Vp: false, An: false")
            println("*************************************")
            println("*************************************")
            println("*************************************")
            println("Dp: " + dut.io.din.peek().toString)
            println("Vp: " + dut.io.din_v.peek().toString)
            println("An: " + dut.io.dout_r.peek().toString)
            dut.clock.step(1)
            println("--------------------------------------")
            println("Dn: " + dut.io.dout.peek().toString)
            println("Vn: " + dut.io.dout_v.peek().toString)
            println("Ap: " + dut.io.din_r.peek().toString)
            println("*************************************")
            println("*************************************")
            ////////////////////////////////////////////////////////////////
            // Test 2 
            ////////////////////////////////////////////////////////////////
            println("*************************************")
            println("Test 2: Vp: false, An: true")
            println("*************************************")
            din_v = false.B  
            dout_r = true.B  
            dut.io.din_v.poke(din_v)
            dut.io.dout_r.poke(dout_r)
            println("Vp: " + dut.io.din_v.peek().toString)
            println("An: " + dut.io.dout_r.peek().toString)
            dut.clock.step(1)
            dut.clock.step(1)
            println("--------------------------------------")
            println("Dn: " + dut.io.dout.peek().toString)
            println("Vn: " + dut.io.dout_v.peek().toString)
            println("Ap: " + dut.io.din_r.peek().toString)
            println("*************************************")
            println("*************************************")
            ////////////////////////////////////////////////////////////////
            // Test 3 
            ////////////////////////////////////////////////////////////////
            println("*************************************")
            println("Test 3: Vp: true, An: false")
            println("*************************************")
            din_v = true.B  
            dout_r = false.B  
            dut.io.din_v.poke(din_v)
            dut.io.dout_r.poke(dout_r)
            println("Vp: " + dut.io.din_v.peek().toString)
            println("An: " + dut.io.dout_r.peek().toString)
            dut.clock.step(1)
            dut.clock.step(1)
            println("--------------------------------------")
            println("Dn: " + dut.io.dout.peek().toString)
            println("Vn: " + dut.io.dout_v.peek().toString)
            println("Ap: " + dut.io.din_r.peek().toString)
            println("*************************************")
            println("*************************************") 
            ////////////////////////////////////////////////////////////////
            // Test 4 
            ////////////////////////////////////////////////////////////////
            println("*************************************")
            println("Test 4: Vp: true, An: true")
            println("*************************************")
            din_v = true.B  
            dout_r = true.B  
            dut.io.din_v.poke(din_v)
            dut.io.dout_r.poke(dout_r)
            println("Vp: " + dut.io.din_v.peek().toString)
            println("An: " + dut.io.dout_r.peek().toString)
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
