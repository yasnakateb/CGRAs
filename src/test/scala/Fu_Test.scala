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

class Fu_Test extends AnyFlatSpec with ChiselScalatestTester {
    "Fu_Test test" should "pass" in {
        test(new Fu(32, 5)) { dut =>
            var din1 = 8.S
            var din2 = 3.S
            var opConfig = 0.U 
            var dinValid = true.B
            var doutReady = true.B
            var loopSource = 0.U 
            var iterationsReset = 0.U 
            ////////////////////////////////////////////////////////////////
            // Test 1 
            ////////////////////////////////////////////////////////////////
            println("*************************************")
            println("Test 1: Loop source: 0, Iterations Reset: 0")
            println("*************************************")
            dut.io.din1.poke(din1)
            dut.io.din2.poke(din2)
            dut.io.opConfig.poke(opConfig)
            dut.io.dinValid.poke(dinValid)
            dut.io.doutReady.poke(doutReady)
            dut.io.loopSource.poke(loopSource)
            dut.io.iterationsReset.poke(iterationsReset)
            println("*************************************")
            println("*************************************")
            println("Din1: " + dut.io.din1.peek().toString)
            println("Din2: " + dut.io.din2.peek().toString)
            println("VIn: " + dut.io.dinValid.peek().toString)
            println("ROut: " + dut.io.doutReady.peek().toString)
            println("Loop Source: " + dut.io.loopSource.peek().toString)
            println("Iterarions Reset: " + dut.io.iterationsReset.peek().toString)
            println("Op Config: " + dut.io.opConfig.peek().toString)
            // Summation  
            dut.clock.step(1)
            println("*************************************")
            println("Summation: " + dut.io.dout.peek().toString)
            opConfig = 1.U 
            dut.io.opConfig.poke(opConfig)
            dut.clock.step(1)
            println("Multiplication: " + dut.io.dout.peek().toString)
            opConfig = 2.U 
            dut.io.opConfig.poke(opConfig)
            dut.clock.step(1)
            println("Subtraction: " + dut.io.dout.peek().toString)
            opConfig = 3.U 
            dut.io.opConfig.poke(opConfig)
            dut.clock.step(1)
            println("Shift Left Logical: " + dut.io.dout.peek().toString)
            opConfig = 4.U  
            dut.io.opConfig.poke(opConfig)
            dut.clock.step(1)
            println("Shift Right Arithmetic: " + dut.io.dout.peek().toString)
            opConfig = 5.U  
            dut.io.opConfig.poke(opConfig)
            dut.clock.step(1)
            println("Shift Right Logical: " + dut.io.dout.peek().toString)
            opConfig = 6.U  
            dut.io.opConfig.poke(opConfig)
            dut.clock.step(1)
            println("And: " + dut.io.dout.peek().toString)
            opConfig = 7.U 
            dut.io.opConfig.poke(opConfig)
            dut.clock.step(1)
            println("Or: " + dut.io.dout.peek().toString)
            opConfig = 8.U  
            dut.io.opConfig.poke(opConfig)
            dut.clock.step(1)
            println("Xor: " + dut.io.dout.peek().toString)
            opConfig = 10.U 
            dut.io.opConfig.poke(opConfig)
            dut.clock.step(1)
            dut.io.dinValid.poke(false.B)
            dut.clock.step(1)
            dut.clock.step(1)
            ////////////////////////////////////////////////////////////////
            // Test 2
            ////////////////////////////////////////////////////////////////
            println("*************************************")
            println("Test 2: Loop source: 1, Iterations Reset: 3")
            println("*************************************")
            // dinValid: true
            // doutReady: true
            din1 = 1.S
            din2 = 1.S
            opConfig = 0.U 
            loopSource = 1.U 
            iterationsReset = 3.U 
            dut.io.dinValid.poke(true.B)
            dut.io.din1.poke(din1)
            dut.io.din2.poke(din2)
            dut.io.opConfig.poke(0.U)
            dut.io.loopSource.poke(loopSource)
            dut.io.iterationsReset.poke(iterationsReset)
            dut.clock.step(1)
            println("*************************************")
            println("Summation: " + dut.io.dout.peek().toString)
            dut.clock.step(1)
            println("*************************************")
            println("Summation: " + dut.io.dout.peek().toString)
            dut.clock.step(1)
            println("*************************************")
            println("Summation: " + dut.io.dout.peek().toString)
            dut.clock.step(1)
            println("*************************************")
            println("Summation: " + dut.io.dout.peek().toString)
            dut.clock.step(1)
            println("*************************************")
            println("Summation: " + dut.io.dout.peek().toString)
            dut.clock.step(1)
            dut.clock.step(1)
            dut.clock.step(1)
            dut.clock.step(1)
            dut.clock.step(1)
            dut.clock.step(1)
            dut.clock.step(1)
            dut.clock.step(1)
            ////////////////////////////////////////////////////////////////
            // Test 3
            ////////////////////////////////////////////////////////////////
            println("*************************************")
            println("Test 3: Loop source: 1, Iterations Reset: 3")
            println("*************************************")
            // dinValid: true
            // doutReady: true
            din1 = 8.S
            din2 = 1.S
            loopSource = 1.U  
            iterationsReset = 3.U    
            dut.io.din1.poke(din1)
            dut.io.din2.poke(din2)
            dut.io.opConfig.poke(3.U)
            dut.io.loopSource.poke(loopSource)
            dut.io.iterationsReset.poke(iterationsReset)
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
            dut.clock.step(1)
            dut.clock.step(1)
            dut.clock.step(1)
            dut.clock.step(1)
            ////////////////////////////////////////////////////////////////
            // Test 4
            ////////////////////////////////////////////////////////////////
            println("*************************************")
            println("Test 4: Loop source: 0, Iterations Reset: 5")
            println("*************************************")
            // dinValid: true
            // doutReady: true
            din1 = 3.S
            din2 = 4.S
            opConfig = 0.U 
            loopSource = 0.U 
            iterationsReset = 5.U   
            dut.io.din1.poke(din1)
            dut.io.din2.poke(din2)
            dut.io.opConfig.poke(opConfig)
            dut.io.loopSource.poke(loopSource)
            dut.io.iterationsReset.poke(iterationsReset)
            dut.clock.step(1)
            ////////////////////////////////////////////////////////////////
            // Test 5
            ////////////////////////////////////////////////////////////////
            println("*************************************")
            println("Test 5: dinValid: 0, doutReady: 0")
            println("*************************************")
            // Loop source: 0
            // Iterations Reset: 0
            din1 = 1.S
            din2 = 2.S
            dinValid = false.B
            doutReady = false.B
            opConfig = 0.U 
            loopSource = 0.U 
            iterationsReset = 0.U   
            dut.io.din1.poke(din1)
            dut.io.din2.poke(din2)
            dut.io.dinValid.poke(dinValid)
            dut.io.doutReady.poke(doutReady)
            dut.io.opConfig.poke(opConfig)
            dut.io.loopSource.poke(loopSource)
            dut.io.iterationsReset.poke(iterationsReset)
            dut.clock.step(1)
            ////////////////////////////////////////////////////////////////
            // Test 6
            ////////////////////////////////////////////////////////////////
            println("*************************************")
            println("Test 5: dinValid: 0, doutReady: 1")
            println("*************************************")
            // Loop source: 0
            // Iterations Reset: 0
            din1 = 2.S
            din2 = 3.S
            dinValid = false.B
            doutReady = true.B
            opConfig = 0.U 
            loopSource = 0.U 
            iterationsReset = 0.U 
            dut.io.din1.poke(din1)
            dut.io.din2.poke(din2)
            dut.io.dinValid.poke(dinValid)
            dut.io.doutReady.poke(doutReady)
            dut.io.opConfig.poke(opConfig)
            dut.io.loopSource.poke(loopSource)
            dut.io.iterationsReset.poke(iterationsReset)
            dut.clock.step(1)
            ////////////////////////////////////////////////////////////////
            // Test 7
            ////////////////////////////////////////////////////////////////
            println("*************************************")
            println("Test 5: dinValid: 1, doutReady: 0")
            println("*************************************")
            // Loop source: 0
            // Iterations Reset: 0
            din1 = 3.S
            din2 = 4.S
            dinValid = true.B
            doutReady = false.B
            opConfig = 0.U 
            loopSource = 0.U 
            iterationsReset = 0.U 
            dut.io.din1.poke(din1)
            dut.io.din2.poke(din2)
            dut.io.dinValid.poke(dinValid)
            dut.io.doutReady.poke(doutReady)
            dut.io.opConfig.poke(opConfig)
            dut.io.loopSource.poke(loopSource)
            dut.io.iterationsReset.poke(iterationsReset)
            dut.clock.step(1)
            ////////////////////////////////////////////////////////////////
            // Test 8
            ////////////////////////////////////////////////////////////////
            println("*************************************")
            println("Multiple inputs (din1 and din2)")
            println("*************************************")
            // dinValid: true
            // doutReady: true
            // Loop source: 0
            // Iterations Reset: 0
            din1 = 1.S
            din2 = 2.S
            dinValid = true.B
            doutReady = true.B
            opConfig = 0.U 
            loopSource = 0.U 
            iterationsReset = 0.U 
            dut.io.din1.poke(din1)
            dut.io.din2.poke(din2)
            dut.io.dinValid.poke(dinValid)
            dut.io.doutReady.poke(doutReady)
            dut.io.opConfig.poke(opConfig)
            dut.io.loopSource.poke(loopSource)
            dut.io.iterationsReset.poke(iterationsReset)
            println("Din1: " + dut.io.din1.peek().toString)
            println("Din2: " + dut.io.din2.peek().toString)
            dut.clock.step(1)
            println("*************************************")
            println("Summation: " + dut.io.dout.peek().toString)
            din1 = 2.S
            din2 = 3.S
            dut.io.din1.poke(din1)
            dut.io.din2.poke(din2)
            println("Din1: " + dut.io.din1.peek().toString)
            println("Din2: " + dut.io.din2.peek().toString)
            dut.clock.step(1)
            println("*************************************")
            println("Summation: " + dut.io.dout.peek().toString)
            din1 = 3.S
            din2 = 4.S
            dut.io.din1.poke(din1)
            dut.io.din2.poke(din2)
            println("Din1: " + dut.io.din1.peek().toString)
            println("Din2: " + dut.io.din2.peek().toString)
            dut.clock.step(1)
            println("*************************************")
            println("Summation: " + dut.io.dout.peek().toString)
            din1 = 4.S
            din2 = 5.S
            dut.io.din1.poke(din1)
            dut.io.din2.poke(din2)
            println("Din1: " + dut.io.din1.peek().toString)
            println("Din2: " + dut.io.din2.peek().toString)
            dut.clock.step(1)
            println("*************************************")
            println("Summation: " + dut.io.dout.peek().toString)
            din1 = 5.S
            din2 = 6.S
            dut.io.din1.poke(din1)
            dut.io.din2.poke(din2)
            println("Din1: " + dut.io.din1.peek().toString)
            println("Din2: " + dut.io.din2.peek().toString)
            dut.clock.step(1)
            println("*************************************")
            println("Summation: " + dut.io.dout.peek().toString)
            din1 = 6.S
            din2 = 7.S
            dut.io.din1.poke(din1)
            dut.io.din2.poke(din2)
            println("Din1: " + dut.io.din1.peek().toString)
            println("Din2: " + dut.io.din2.peek().toString)
            dut.clock.step(1)
            println("*************************************")
            println("Summation: " + dut.io.dout.peek().toString)
        }
    } 
}
