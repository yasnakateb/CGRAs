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

class FU_Test extends AnyFlatSpec with ChiselScalatestTester {
    "FU_Test test" should "pass" in {
        test(new FU(32, 5)) { dut =>
            var din_1 = 8.S
            var din_2 = 3.S
            var op_config = 0.U 
            var din_v = true.B
            var dout_r = true.B
            var loop_source = 0.U 
            var iterations_reset = 0.U 
            ////////////////////////////////////////////////////////////////
            // Test 1 
            ////////////////////////////////////////////////////////////////
            println("*************************************")
            println("Test 1: Loop source: 0, Iterations Reset: 0")
            println("*************************************")
            dut.io.din_1.poke(din_1)
            dut.io.din_2.poke(din_2)
            dut.io.op_config.poke(op_config)
            dut.io.din_v.poke(din_v)
            dut.io.dout_r.poke(dout_r)
            dut.io.loop_source.poke(loop_source)
            dut.io.iterations_reset.poke(iterations_reset)
            println("*************************************")
            println("*************************************")
            println("Din1: " + dut.io.din_1.peek().toString)
            println("Din2: " + dut.io.din_2.peek().toString)
            println("VIn: " + dut.io.din_v.peek().toString)
            println("ROut: " + dut.io.dout_r.peek().toString)
            println("Loop Source: " + dut.io.loop_source.peek().toString)
            println("Iterarions Reset: " + dut.io.iterations_reset.peek().toString)
            println("Op Config: " + dut.io.op_config.peek().toString)
            // Summation  
            dut.clock.step(1)
            println("*************************************")
            println("Summation: " + dut.io.dout.peek().toString)
            op_config = 1.U
            dut.io.op_config.poke(op_config)
            dut.clock.step(1)
            println("Multiplication: " + dut.io.dout.peek().toString)
            op_config = 2.U
            dut.io.op_config.poke(op_config)
            dut.clock.step(1)
            println("Subtraction: " + dut.io.dout.peek().toString)
            op_config = 3.U
            dut.io.op_config.poke(op_config)
            dut.clock.step(1)
            println("Shift Left Logical: " + dut.io.dout.peek().toString)
            op_config = 4.U
            dut.io.op_config.poke(op_config)
            dut.clock.step(1)
            println("Shift Right Arithmetic: " + dut.io.dout.peek().toString)
            op_config = 5.U
            dut.io.op_config.poke(op_config)
            dut.clock.step(1)
            println("Shift Right Logical: " + dut.io.dout.peek().toString)
            op_config = 6.U
            dut.io.op_config.poke(op_config)
            dut.clock.step(1)
            println("And: " + dut.io.dout.peek().toString)
            op_config = 7.U
            dut.io.op_config.poke(op_config)
            dut.clock.step(1)
            println("Or: " + dut.io.dout.peek().toString)
            op_config = 8.U
            dut.io.op_config.poke(op_config)
            dut.clock.step(1)
            println("Xor: " + dut.io.dout.peek().toString)
            op_config = 10.U
            dut.io.op_config.poke(op_config)
            dut.clock.step(1)
            println("Minimum: " + dut.io.dout.peek().toString)
            op_config = 11.U
            dut.io.op_config.poke(op_config)
            dut.clock.step(1)
            println("Maximum: " + dut.io.dout.peek().toString)
            ////////////////////////////////////////////////////////////////
            // Test 2
            ////////////////////////////////////////////////////////////////
            println("*************************************")
            println("Test 2: Loop source: 1, Iterations Reset: 3")
            println("*************************************")
            // din_v: true
            // dout_r: true
            din_1 = 1.S
            din_2 = 2.S
            op_config = 0.U
            loop_source = 1.U
            iterations_reset = 3.U 
            dut.io.din_1.poke(din_1)
            dut.io.din_2.poke(din_2)
            dut.io.op_config.poke(op_config)
            dut.io.loop_source.poke(loop_source)
            dut.io.iterations_reset.poke(iterations_reset)
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
            println("Test 3: Loop source: 3, Iterations Reset: 3")
            println("*************************************")
            // din_v: true
            // dout_r: true
            din_1 = 2.S
            din_2 = 3.S
            op_config = 0.U
            loop_source = 3.U
            iterations_reset = 3.U
            dut.io.din_1.poke(din_1)
            dut.io.din_2.poke(din_2)
            dut.io.op_config.poke(op_config)
            dut.io.loop_source.poke(loop_source)
            dut.io.iterations_reset.poke(iterations_reset)
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
            // din_v: true
            // dout_r: true
            din_1 = 3.S
            din_2 = 4.S
            op_config = 0.U
            loop_source = 0.U 
            iterations_reset = 5.U 
            dut.io.din_1.poke(din_1)
            dut.io.din_2.poke(din_2)
            dut.io.op_config.poke(op_config)
            dut.io.loop_source.poke(loop_source)
            dut.io.iterations_reset.poke(iterations_reset)
            dut.clock.step(1)
            ////////////////////////////////////////////////////////////////
            // Test 5
            ////////////////////////////////////////////////////////////////
            println("*************************************")
            println("Test 5: din_v: 0, dout_r: 0")
            println("*************************************")
            // Loop source: 0
            // Iterations Reset: 0
            din_1 = 1.S
            din_2 = 2.S
            din_v = false.B
            dout_r = false.B
            op_config = 0.U 
            loop_source = 0.U 
            iterations_reset = 0.U  
            dut.io.din_1.poke(din_1)
            dut.io.din_2.poke(din_2)
            dut.io.din_v.poke(din_v)
            dut.io.dout_r.poke(dout_r)
            dut.io.op_config.poke(op_config)
            dut.io.loop_source.poke(loop_source)
            dut.io.iterations_reset.poke(iterations_reset)
            dut.clock.step(1)
            ////////////////////////////////////////////////////////////////
            // Test 6
            ////////////////////////////////////////////////////////////////
            println("*************************************")
            println("Test 5: din_v: 0, dout_r: 1")
            println("*************************************")
            // Loop source: 0
            // Iterations Reset: 0
            din_1 = 2.S
            din_2 = 3.S
            din_v = false.B
            dout_r = true.B
            op_config = 0.U 
            loop_source = 0.U 
            iterations_reset = 0.U 
            dut.io.din_1.poke(din_1)
            dut.io.din_2.poke(din_2)
            dut.io.din_v.poke(din_v)
            dut.io.dout_r.poke(dout_r)
            dut.io.op_config.poke(op_config)
            dut.io.loop_source.poke(loop_source)
            dut.io.iterations_reset.poke(iterations_reset)
            dut.clock.step(1)
            ////////////////////////////////////////////////////////////////
            // Test 7
            ////////////////////////////////////////////////////////////////
            println("*************************************")
            println("Test 5: din_v: 1, dout_r: 0")
            println("*************************************")
            // Loop source: 0
            // Iterations Reset: 0
            din_1 = 3.S
            din_2 = 4.S
            din_v = true.B
            dout_r = false.B
            op_config = 0.U 
            loop_source = 0.U 
            iterations_reset = 0.U 
            dut.io.din_1.poke(din_1)
            dut.io.din_2.poke(din_2)
            dut.io.din_v.poke(din_v)
            dut.io.dout_r.poke(dout_r)
            dut.io.op_config.poke(op_config)
            dut.io.loop_source.poke(loop_source)
            dut.io.iterations_reset.poke(iterations_reset)
            dut.clock.step(1)
            ////////////////////////////////////////////////////////////////
            // Test 8
            ////////////////////////////////////////////////////////////////
            println("*************************************")
            println("Multiple inputs (din_1 and din_2)")
            println("*************************************")
            // din_v: true
            // dout_r: true
            // Loop source: 0
            // Iterations Reset: 0
            din_1 = 1.S
            din_2 = 2.S
            din_v = true.B
            dout_r = true.B
            op_config = 0.U 
            loop_source = 0.U 
            iterations_reset = 0.U 
            dut.io.din_1.poke(din_1)
            dut.io.din_2.poke(din_2)
            dut.io.din_v.poke(din_v)
            dut.io.dout_r.poke(dout_r)
            dut.io.op_config.poke(op_config)
            dut.io.loop_source.poke(loop_source)
            dut.io.iterations_reset.poke(iterations_reset)
            println("Din1: " + dut.io.din_1.peek().toString)
            println("Din2: " + dut.io.din_2.peek().toString)
            dut.clock.step(1)
            println("*************************************")
            println("Summation: " + dut.io.dout.peek().toString)
            din_1 = 2.S
            din_2 = 3.S
            dut.io.din_1.poke(din_1)
            dut.io.din_2.poke(din_2)
            println("Din1: " + dut.io.din_1.peek().toString)
            println("Din2: " + dut.io.din_2.peek().toString)
            dut.clock.step(1)
            println("*************************************")
            println("Summation: " + dut.io.dout.peek().toString)
            din_1 = 3.S
            din_2 = 4.S
            dut.io.din_1.poke(din_1)
            dut.io.din_2.poke(din_2)
            println("Din1: " + dut.io.din_1.peek().toString)
            println("Din2: " + dut.io.din_2.peek().toString)
            dut.clock.step(1)
            println("*************************************")
            println("Summation: " + dut.io.dout.peek().toString)
            din_1 = 4.S
            din_2 = 5.S
            dut.io.din_1.poke(din_1)
            dut.io.din_2.poke(din_2)
            println("Din1: " + dut.io.din_1.peek().toString)
            println("Din2: " + dut.io.din_2.peek().toString)
            dut.clock.step(1)
            println("*************************************")
            println("Summation: " + dut.io.dout.peek().toString)
            din_1 = 5.S
            din_2 = 6.S
            dut.io.din_1.poke(din_1)
            dut.io.din_2.poke(din_2)
            println("Din1: " + dut.io.din_1.peek().toString)
            println("Din2: " + dut.io.din_2.peek().toString)
            dut.clock.step(1)
            println("*************************************")
            println("Summation: " + dut.io.dout.peek().toString)
            din_1 = 6.S
            din_2 = 7.S
            dut.io.din_1.poke(din_1)
            dut.io.din_2.poke(din_2)
            println("Din1: " + dut.io.din_1.peek().toString)
            println("Din2: " + dut.io.din_2.peek().toString)
            dut.clock.step(1)
            println("*************************************")
            println("Summation: " + dut.io.dout.peek().toString)
        }
    } 
}
