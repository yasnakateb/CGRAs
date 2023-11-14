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

class Join_Test extends AnyFlatSpec with ChiselScalatestTester {
    "Join_Test test" should "pass" in {  
        test(new Join(32)) { dut =>
            var din_1 = 10.S
            var din_2 = 5.S
            var din_1_v = false.B
            var din_2_v = false.B 
            var dout_r = false.B
            dut.io.din_1.poke(din_1)
            dut.io.din_2.poke(din_2)
            dut.io.din_1_v.poke(din_1_v)
            dut.io.din_2_v.poke(din_2_v)
            dut.io.dout_r.poke(dout_r)
            dut.clock.step(1)
            dut.clock.step(1)
            dut.clock.step(1)
            dut.clock.step(1)
            ////////////////////////////////////////////////////////////////
            // Test 1 
            ////////////////////////////////////////////////////////////////
            println("*************************************")
            println("Test 1: Vin1: false, Vin2: false, Aout: false")
            println("*************************************")
            println("Din1: " + dut.io.dout_1.peek().toString)
            println("Din2: " + dut.io.dout_2.peek().toString)
            println("*************************************")
            println("*************************************")
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
            ////////////////////////////////////////////////////////////////
            // Test 2
            ////////////////////////////////////////////////////////////////
            println("*************************************")
            println("Test 1: Vin1: true, Vin2: false, Aout: false")
            println("*************************************")
            din_1_v = true.B
            din_2_v = false.B 
            dout_r = false.B
            dut.io.din_1_v.poke(din_1_v)
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
            ////////////////////////////////////////////////////////////////
            // Test 3 
            ////////////////////////////////////////////////////////////////
            println("*************************************")
            println("Test 3: Vin1: false, Vin2: true, Aout: false")
            println("*************************************")
            din_1_v = false.B
            din_2_v = true.B 
            dout_r = false.B
            dut.io.din_1_v.poke(din_1_v)
            dut.io.din_2_v.poke(din_2_v)
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
            ////////////////////////////////////////////////////////////////
            // Test 4 
            ////////////////////////////////////////////////////////////////
            println("*************************************")
            println("Test 4: Vin1: true, Vin2: true, Aout: false")
            println("*************************************")
            din_1_v = true.B
            din_2_v = true.B 
            dout_r = false.B
            dut.io.din_1_v.poke(din_1_v)
            dut.io.din_2_v.poke(din_2_v)
            dut.io.dout_r.poke(dout_r)
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
            ////////////////////////////////////////////////////////////////
            // Test 5 
            ////////////////////////////////////////////////////////////////
            println("*************************************")
            println("Test 5: Vin1: false, Vin2: false, Aout: true")
            println("*************************************")
            din_1_v = false.B
            din_2_v = false.B 
            dout_r = true.B
            dut.io.din_1_v.poke(din_1_v)
            dut.io.din_2_v.poke(din_2_v)
            dut.io.dout_r.poke(dout_r)
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
            ////////////////////////////////////////////////////////////////
            // Test 6 
            ////////////////////////////////////////////////////////////////
            println("*************************************")
            println("Test 6: Vin1: true, Vin2: false, Aout: true")
            println("*************************************")
            din_1_v = true.B
            din_2_v = false.B 
            dout_r = true.B
            dut.io.din_1_v.poke(din_1_v)
            dut.io.din_2_v.poke(din_2_v)
            dut.io.dout_r.poke(dout_r)
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
            ////////////////////////////////////////////////////////////////
            // Test 7
            ////////////////////////////////////////////////////////////////
            println("*************************************")
            println("Test 7: Vin1: false, Vin2: true, Aout: true")
            println("*************************************")
            din_1_v = false.B
            din_2_v = true.B 
            dout_r = true.B
            dut.io.din_1_v.poke(din_1_v)
            dut.io.din_2_v.poke(din_2_v)
            dut.io.dout_r.poke(dout_r)
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
            ////////////////////////////////////////////////////////////////
            // Test 8
            ////////////////////////////////////////////////////////////////
            println("*************************************")
            println("Test 8: Vin1: true, Vin2: true, Aout: true")
            println("*************************************")
            din_1_v = true.B
            din_2_v = true.B 
            dout_r = true.B
            dut.io.din_1_v.poke(din_1_v)
            dut.io.din_2_v.poke(din_2_v)
            dut.io.dout_r.poke(dout_r)
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
