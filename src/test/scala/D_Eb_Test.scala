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

class D_Eb_Test extends AnyFlatSpec with ChiselScalatestTester {
  "D_Eb_Test test" should "pass" in {
      test(new D_Eb(32)) { dut =>
          var din = 0.S  
          var doutReady = false.B 
          var dinValid = false.B 
          dut.io.din.poke(din)
          dut.io.dinValid.poke(dinValid)
          dut.io.doutReady.poke(doutReady)
          dut.clock.step(1)
          dut.clock.step(1)
          dut.clock.step(1)
          dut.io.din.poke(1.S)
          dut.io.dinValid.poke(true.B)
          dut.io.doutReady.poke(true.B)
          dut.clock.step(1)
          dut.io.din.poke(2.S)
          dut.clock.step(1)
          dut.io.din.poke(3.S)
          dut.clock.step(1)
          dut.io.din.poke(4.S)
          dut.clock.step(1)
          dut.io.din.poke(5.S)
          dut.clock.step(1)
          dut.io.din.poke(6.S)
          dut.clock.step(1)
          dut.io.din.poke(7.S)
          dut.clock.step(1)
          dut.io.din.poke(0.S)
          dut.io.dinValid.poke(false.B)
          
          dut.clock.step(1)
          dut.clock.step(1)
          dut.clock.step(1)
          

          /*
          ////////////////////////////////////////////////////////////////
          // Test 1 
          ////////////////////////////////////////////////////////////////
          println("*************************************")
          println("Test 1: Vp: false, An: false")
          println("*************************************")
          println("*************************************")
          println("*************************************")
          println("Dp: " + dut.io.din.peek().toString)
          println("Vp: " + dut.io.dinValid.peek().toString)
          println("An: " + dut.io.doutReady.peek().toString)
          dut.clock.step(1)
          println("--------------------------------------")
          println("Dn: " + dut.io.dout.peek().toString)
          println("Vn: " + dut.io.doutValid.peek().toString)
          println("Ap: " + dut.io.dinReady.peek().toString)
          println("*************************************")
          println("*************************************")
          ////////////////////////////////////////////////////////////////
          // Test 2 
          ////////////////////////////////////////////////////////////////
          println("*************************************")
          println("Test 2: Vp: false, An: true")
          println("*************************************")
          dinValid = false.B  
          doutReady = true.B  
          dut.io.dinValid.poke(dinValid)
          dut.io.doutReady.poke(doutReady)
          println("Vp: " + dut.io.dinValid.peek().toString)
          println("An: " + dut.io.doutReady.peek().toString)
          dut.clock.step(1)
          dut.clock.step(1)
          println("--------------------------------------")
          println("Dn: " + dut.io.dout.peek().toString)
          println("Vn: " + dut.io.doutValid.peek().toString)
          println("Ap: " + dut.io.dinReady.peek().toString)
          println("*************************************")
          println("*************************************")
          ////////////////////////////////////////////////////////////////
          // Test 3 
          ////////////////////////////////////////////////////////////////
          println("*************************************")
          println("Test 3: Vp: true, An: false")
          println("*************************************")
          dinValid = true.B  
          doutReady = false.B  
          dut.io.dinValid.poke(dinValid)
          dut.io.doutReady.poke(doutReady)
          println("Vp: " + dut.io.dinValid.peek().toString)
          println("An: " + dut.io.doutReady.peek().toString)
          dut.clock.step(1)
          dut.clock.step(1)
          dut.io.dinValid.poke(false.B)
          dut.clock.step(1)
          dut.clock.step(1)
          println("--------------------------------------")
          println("Dn: " + dut.io.dout.peek().toString)
          println("Vn: " + dut.io.doutValid.peek().toString)
          println("Ap: " + dut.io.dinReady.peek().toString)
          println("*************************************")
          println("*************************************") 
          ////////////////////////////////////////////////////////////////
          // Test 4 
          ////////////////////////////////////////////////////////////////
          println("*************************************")
          println("Test 4: Vp: true, An: true")
          println("*************************************")
          dinValid = true.B  
          doutReady = true.B  
          dut.io.dinValid.poke(dinValid)
          dut.io.doutReady.poke(doutReady)
          println("Vp: " + dut.io.dinValid.peek().toString)
          println("An: " + dut.io.doutReady.peek().toString)
          dut.clock.step(1)
          dut.clock.step(1)
          println("--------------------------------------")
          println("Dn: " + dut.io.dout.peek().toString)
          println("Vn: " + dut.io.doutValid.peek().toString)
          println("Ap: " + dut.io.dinReady.peek().toString)
          println("*************************************")
          println("*************************************") 
          */
      }
  } 
}
