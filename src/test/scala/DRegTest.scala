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

class DRegTest extends AnyFlatSpec with ChiselScalatestTester {
    "DRegTest test" should "pass" in {
        test(new DReg(8)) { dut =>
            var din = 10.S 
            var doutReady = false.B
            var dinValid = false.B 
            dut.io.din.poke(din)
            dut.io.doutReady.poke(doutReady)
            dut.io.dinValid.poke(dinValid)
            ////////////////////////////////////////////////////////////////
            // Test 1 
            ////////////////////////////////////////////////////////////////
            println("*************************************")
            println("Test 1: Vp: false, An: false")
            println("*************************************")
            println("Dp: " + dut.io.din.peek().toString)
            println("*************************************")
            println("*************************************")
            println("Vp: " + dut.io.dinValid.peek().toString)
            println("An: " + dut.io.doutReady.peek().toString)
            dut.clock.step(1)
            println("--------------------------------------")
            println("Dn: " + dut.io.dout.peek().toString)
            println("Vn: " + dut.io.doutValid.peek().toString)
            println("Ap: " + dut.io.dinReady.peek().toString)
            ////////////////////////////////////////////////////////////////
            // Test 2
            ////////////////////////////////////////////////////////////////
            println("*************************************")
            println("Test 2: Vp: true, An: true")
            println("*************************************")
            doutReady = true.B 
            dinValid = true.B  
            dut.io.doutReady.poke(doutReady)
            dut.io.dinValid.poke(dinValid)
            println("Vp: " + dut.io.dinValid.peek().toString)
            println("An: " + dut.io.doutReady.peek().toString)
            dut.clock.step(1)
            dut.clock.step(1)
            dut.clock.step(1)
            println("--------------------------------------")
            println("Dn: " + dut.io.dout.peek().toString)
            println("Vn: " + dut.io.doutValid.peek().toString)
            println("Ap: " + dut.io.dinReady.peek().toString)
            println("*************************************")
            println("*************************************")
        }
    } 
}
