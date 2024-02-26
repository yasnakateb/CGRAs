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
            var din1 = 10.S
            var din2 = 5.S
            var din1Valid = false.B
            var din2Valid = false.B 
            var doutReady = false.B
            dut.io.din1.poke(din1)
            dut.io.din2.poke(din2)
            dut.io.din1Valid.poke(din1Valid)
            dut.io.din2Valid.poke(din2Valid)
            dut.io.doutReady.poke(doutReady)
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
            println("Din1: " + dut.io.dout1.peek().toString)
            println("Din2: " + dut.io.dout2.peek().toString)
            println("*************************************")
            println("*************************************")
            println("Vin1: " + dut.io.din1Valid.peek().toString)
            println("Vin2: " + dut.io.din2Valid.peek().toString)
            println("Aout: " + dut.io.doutReady.peek().toString)
            dut.clock.step(1)
            println("--------------------------------------")
            println("Ain1: " + dut.io.din1Ready.peek().toString)
            println("Ain2: " + dut.io.din2Ready.peek().toString)
            println("Dout1: " + dut.io.dout1.peek().toString)
            println("Dout2: " + dut.io.dout2.peek().toString)
            println("Vout: " + dut.io.doutValid.peek().toString)
            println("*************************************")
            println("*************************************")
            ////////////////////////////////////////////////////////////////
            // Test 2
            ////////////////////////////////////////////////////////////////
            println("*************************************")
            println("Test 1: Vin1: true, Vin2: false, Aout: false")
            println("*************************************")
            din1Valid = true.B
            din2Valid = false.B 
            doutReady = false.B
            dut.io.din1Valid.poke(din1Valid)
            println("Vin1: " + dut.io.din1Valid.peek().toString)
            println("Vin2: " + dut.io.din2Valid.peek().toString)
            println("Aout: " + dut.io.doutReady.peek().toString)
            dut.clock.step(1)
            println("--------------------------------------")
            println("Ain1: " + dut.io.din1Ready.peek().toString)
            println("Ain2: " + dut.io.din2Ready.peek().toString)
            println("Vout: " + dut.io.doutValid.peek().toString)
            println("*************************************")
            println("*************************************")
            ////////////////////////////////////////////////////////////////
            // Test 3 
            ////////////////////////////////////////////////////////////////
            println("*************************************")
            println("Test 3: Vin1: false, Vin2: true, Aout: false")
            println("*************************************")
            din1Valid = false.B
            din2Valid = true.B 
            doutReady = false.B
            dut.io.din1Valid.poke(din1Valid)
            dut.io.din2Valid.poke(din2Valid)
            println("Vin1: " + dut.io.din1Valid.peek().toString)
            println("Vin2: " + dut.io.din2Valid.peek().toString)
            println("Aout: " + dut.io.doutReady.peek().toString)
            dut.clock.step(1)
            println("--------------------------------------")
            println("Ain1: " + dut.io.din1Ready.peek().toString)
            println("Ain2: " + dut.io.din2Ready.peek().toString)
            println("Vout: " + dut.io.doutValid.peek().toString)
            println("*************************************")
            println("*************************************")
            ////////////////////////////////////////////////////////////////
            // Test 4 
            ////////////////////////////////////////////////////////////////
            println("*************************************")
            println("Test 4: Vin1: true, Vin2: true, Aout: false")
            println("*************************************")
            din1Valid = true.B
            din2Valid = true.B 
            doutReady = false.B
            dut.io.din1Valid.poke(din1Valid)
            dut.io.din2Valid.poke(din2Valid)
            dut.io.doutReady.poke(doutReady)
            println("Vin1: " + dut.io.din1Valid.peek().toString)
            println("Vin2: " + dut.io.din2Valid.peek().toString)
            println("Aout: " + dut.io.doutReady.peek().toString)
            dut.clock.step(1)
            println("--------------------------------------")
            println("Ain1: " + dut.io.din1Ready.peek().toString)
            println("Ain2: " + dut.io.din2Ready.peek().toString)
            println("Vout: " + dut.io.doutValid.peek().toString)
            println("*************************************")
            println("*************************************")
            ////////////////////////////////////////////////////////////////
            // Test 5 
            ////////////////////////////////////////////////////////////////
            println("*************************************")
            println("Test 5: Vin1: false, Vin2: false, Aout: true")
            println("*************************************")
            din1Valid = false.B
            din2Valid = false.B 
            doutReady = true.B
            dut.io.din1Valid.poke(din1Valid)
            dut.io.din2Valid.poke(din2Valid)
            dut.io.doutReady.poke(doutReady)
            println("Vin1: " + dut.io.din1Valid.peek().toString)
            println("Vin2: " + dut.io.din2Valid.peek().toString)
            println("Aout: " + dut.io.doutReady.peek().toString)
            dut.clock.step(1)
            println("--------------------------------------")
            println("Ain1: " + dut.io.din1Ready.peek().toString)
            println("Ain2: " + dut.io.din2Ready.peek().toString)
            println("Vout: " + dut.io.doutValid.peek().toString)
            println("*************************************")
            println("*************************************")
            ////////////////////////////////////////////////////////////////
            // Test 6 
            ////////////////////////////////////////////////////////////////
            println("*************************************")
            println("Test 6: Vin1: true, Vin2: false, Aout: true")
            println("*************************************")
            din1Valid = true.B
            din2Valid = false.B 
            doutReady = true.B
            dut.io.din1Valid.poke(din1Valid)
            dut.io.din2Valid.poke(din2Valid)
            dut.io.doutReady.poke(doutReady)
            println("Vin1: " + dut.io.din1Valid.peek().toString)
            println("Vin2: " + dut.io.din2Valid.peek().toString)
            println("Aout: " + dut.io.doutReady.peek().toString)
            dut.clock.step(1)
            println("--------------------------------------")
            println("Ain1: " + dut.io.din1Ready.peek().toString)
            println("Ain2: " + dut.io.din2Ready.peek().toString)
            println("Vout: " + dut.io.doutValid.peek().toString)
            println("*************************************")
            println("*************************************")
            ////////////////////////////////////////////////////////////////
            // Test 7
            ////////////////////////////////////////////////////////////////
            println("*************************************")
            println("Test 7: Vin1: false, Vin2: true, Aout: true")
            println("*************************************")
            din1Valid = false.B
            din2Valid = true.B 
            doutReady = true.B
            dut.io.din1Valid.poke(din1Valid)
            dut.io.din2Valid.poke(din2Valid)
            dut.io.doutReady.poke(doutReady)
            println("Vin1: " + dut.io.din1Valid.peek().toString)
            println("Vin2: " + dut.io.din2Valid.peek().toString)
            println("Aout: " + dut.io.doutReady.peek().toString)
            dut.clock.step(1)
            println("--------------------------------------")
            println("Ain1: " + dut.io.din1Ready.peek().toString)
            println("Ain2: " + dut.io.din2Ready.peek().toString)
            println("Vout: " + dut.io.doutValid.peek().toString)
            println("*************************************")
            println("*************************************")
            ////////////////////////////////////////////////////////////////
            // Test 8
            ////////////////////////////////////////////////////////////////
            println("*************************************")
            println("Test 8: Vin1: true, Vin2: true, Aout: true")
            println("*************************************")
            din1Valid = true.B
            din2Valid = true.B 
            doutReady = true.B
            dut.io.din1Valid.poke(din1Valid)
            dut.io.din2Valid.poke(din2Valid)
            dut.io.doutReady.poke(doutReady)
            println("Vin1: " + dut.io.din1Valid.peek().toString)
            println("Vin2: " + dut.io.din2Valid.peek().toString)
            println("Aout: " + dut.io.doutReady.peek().toString)
            dut.clock.step(1)
            println("--------------------------------------")
            println("Ain1: " + dut.io.din1Ready.peek().toString)
            println("Ain2: " + dut.io.din2Ready.peek().toString)
            println("Vout: " + dut.io.doutValid.peek().toString)
            println("*************************************")
            println("*************************************")
        }
    } 
}
