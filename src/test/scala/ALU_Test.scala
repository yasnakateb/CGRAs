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

class ALU_Test extends AnyFlatSpec with ChiselScalatestTester {
    "ALU_Test test" should "pass" in {
        test(new ALU(32, 4)) { dut =>

            var op_config = 3.U
            dut.io.op_config.poke(op_config)

            dut.io.din_1.poke(1.U)
            for (i <- 1 until 32) {
                
                dut.io.din_2.poke(i.U)
                dut.clock.step(1)
            }

            /*
            dut.io.din_1.poke(1.U)
            dut.io.din_2.poke(2.U)
            var op_config = 0.U
            ////////////////////////////////////////////////////////////////
            // Test 1 
            ////////////////////////////////////////////////////////////////
            println("*************************************")
            println("Test 1: Positive numbers")
            println("*************************************")
            println("Din1: " + dut.io.din_1.peek().toString)
            println("Din2: " + dut.io.din_2.peek().toString)
            // Summation  
            dut.clock.step(1)
            dut.io.din_1.poke(3.U)
            dut.io.din_2.poke(4.U)
            dut.clock.step(1)
            dut.io.din_1.poke(5.U)
            dut.io.din_2.poke(6.U)
            dut.clock.step(1)
            println("Summation: " + dut.io.dout.peek().toString)
            // Multiplication
            dut.io.din_1.poke(2.U)
            dut.io.din_2.poke(1.U)
            op_config = 1.U
            dut.io.op_config.poke(op_config)
            dut.clock.step(1)
            dut.io.din_1.poke(4.U)
            dut.io.din_2.poke(3.U)
            dut.clock.step(1)
            dut.io.din_1.poke(6.U)
            dut.io.din_2.poke(5.U)
            dut.clock.step(1)
            println("Multiplication: " + dut.io.dout.peek().toString)
            // Subtraction
            op_config = 2.U
            dut.io.din_1.poke(2.U)
            dut.io.din_2.poke(0.U)
            dut.io.op_config.poke(op_config)
            dut.clock.step(1)
            dut.io.din_1.poke(4.U)
            dut.io.din_2.poke(1.U)
            dut.clock.step(1)
            dut.io.din_1.poke(6.U)
            dut.io.din_2.poke(4.U)
            dut.clock.step(1)
            println("Subtraction: " + dut.io.dout.peek().toString)
            // Shift Left Logical
            op_config = 3.U
            dut.io.din_1.poke(2.U)
            dut.io.din_2.poke(1.U)
            dut.io.op_config.poke(op_config)
            dut.clock.step(1)
            dut.io.din_1.poke(4.U)
            dut.io.din_2.poke(3.U)
            dut.clock.step(1)
            dut.io.din_1.poke(6.U)
            dut.io.din_2.poke(5.U)
            dut.clock.step(1)
            println("Shift Left Logical: " + dut.io.dout.peek().toString)
            // Shift Right Arithmetic
            op_config = 4.U
            dut.io.din_1.poke(20.U)
            dut.io.din_2.poke(1.U)
            dut.io.op_config.poke(op_config)
            dut.clock.step(1)
            dut.io.din_1.poke(14.U)
            dut.io.din_2.poke(1.U)
            dut.clock.step(1)
            dut.io.din_1.poke(16.U)
            dut.io.din_2.poke(2.U)
            dut.clock.step(1)
            println("Shift Right Arithmetic: " + dut.io.dout.peek().toString)
            // Shift Right Logical
            op_config = 5.U
            dut.io.din_1.poke(20.U)
            dut.io.din_2.poke(1.U)
            dut.io.op_config.poke(op_config)
            dut.clock.step(1)
            dut.io.din_1.poke(14.U)
            dut.io.din_2.poke(1.U)
            dut.clock.step(1)
            dut.io.din_1.poke(16.U)
            dut.io.din_2.poke(2.U)
            dut.clock.step(1)
            println("Shift Right Logical: " + dut.io.dout.peek().toString)
            // And
            op_config = 6.U
            dut.io.din_1.poke(20.U)
            dut.io.din_2.poke(16.U)
            dut.io.op_config.poke(op_config)
            dut.clock.step(1)
            dut.io.din_1.poke(14.U)
            dut.io.din_2.poke(13.U)
            dut.clock.step(1)
            dut.io.din_1.poke(17.U)
            dut.io.din_2.poke(15.U)
            dut.clock.step(1)
            println("And: " + dut.io.dout.peek().toString)
            // Or
            op_config = 7.U
            dut.io.din_1.poke(20.U)
            dut.io.din_2.poke(1.U)
            dut.io.op_config.poke(op_config)
            dut.clock.step(1)
            dut.io.din_1.poke(14.U)
            dut.io.din_2.poke(2.U)
            dut.clock.step(1)
            dut.io.din_1.poke(16.U)
            dut.io.din_2.poke(3.U)
            dut.clock.step(1)
            println("Or: " + dut.io.dout.peek().toString)
            // Xor
            op_config = 8.U
            dut.io.din_1.poke(20.U)
            dut.io.din_2.poke(1.U)
            dut.io.op_config.poke(op_config)
            dut.clock.step(1)
            dut.io.din_1.poke(14.U)
            dut.io.din_2.poke(2.U)
            dut.clock.step(1)
            dut.io.din_1.poke(16.U)
            dut.io.din_2.poke(3.U)
            dut.clock.step(1)
            println("Xor: " + dut.io.dout.peek().toString)
            // Minimum
            op_config = 10.U
            dut.io.din_1.poke(20.U)
            dut.io.din_2.poke(1.U)
            dut.io.op_config.poke(op_config)
            dut.clock.step(1)
            dut.io.din_1.poke(14.U)
            dut.io.din_2.poke(2.U)
            dut.clock.step(1)
            dut.io.din_1.poke(16.U)
            dut.io.din_2.poke(3.U)
            dut.clock.step(1)
            println("Minimum: " + dut.io.dout.peek().toString)
            // Maximum
            op_config = 11.U
            dut.io.din_1.poke(20.U)
            dut.io.din_2.poke(1.U)
            dut.io.op_config.poke(op_config)
            dut.clock.step(1)
            dut.io.din_1.poke(14.U)
            dut.io.din_2.poke(2.U)
            dut.clock.step(1)
            dut.io.din_1.poke(16.U)
            dut.io.din_2.poke(3.U)
            dut.clock.step(1)
            println("Maximum: " + dut.io.dout.peek().toString)
            ////////////////////////////////////////////////////////////////
            // Test 2
            ////////////////////////////////////////////////////////////////
            val din_1 = "b1000_0000_0000_0000_0000_0000_0000_1111".U
            dut.io.din_1.poke(din_1)
            println("*************************************")
            println("Test 2: Din1 => Negative number")
            println("*************************************")
            println("Din1: " + dut.io.din_1.peek().toString)
            println("Din2: " + dut.io.din_2.peek().toString)
            // Summation  
            op_config = 0.U
            dut.io.op_config.poke(op_config)
            dut.clock.step(1)
            println("Summation: " + dut.io.dout.peek().toString)
            // Multiplication
            op_config = 1.U
            dut.io.op_config.poke(op_config)
            dut.clock.step(1)
            println("Multiplication: " + dut.io.dout.peek().toString)
            // Subtraction
            op_config = 2.U
            dut.io.op_config.poke(op_config)
            dut.clock.step(1)
            println("Subtraction: " + dut.io.dout.peek().toString)
            // Shift Left Logical
            op_config = 3.U
            dut.io.op_config.poke(op_config)
            dut.clock.step(1)
            println("Left Logical: " + dut.io.dout.peek().toString)
            op_config = 4.U
            dut.io.op_config.poke(op_config)
            dut.clock.step(1)
            println("Shift Right Arithmetic: " + dut.io.dout.peek().toString)
            // Shift Right Logical
            op_config = 5.U
            dut.io.op_config.poke(op_config)
            dut.clock.step(1)
            println("Shift Right Logical: " + dut.io.dout.peek().toString) 
            // And
            op_config = 6.U
            dut.io.op_config.poke(op_config)
            dut.clock.step(1)
            println("And: " + dut.io.dout.peek().toString)
            // Or
            op_config = 7.U
            dut.io.op_config.poke(op_config)
            dut.clock.step(1)
            println("Or: " + dut.io.dout.peek().toString)
            // Xor
            op_config = 8.U
            dut.io.op_config.poke(op_config)
            dut.clock.step(1)
            println("Xor: " + dut.io.dout.peek().toString)
            // Minimum
            op_config = 10.U
            dut.io.op_config.poke(op_config)
            dut.clock.step(1)
            println("Minimum: " + dut.io.dout.peek().toString)
            // Maximum
            op_config = 11.U
            dut.io.op_config.poke(op_config)
            dut.clock.step(1)
            println("Maximum: " + dut.io.dout.peek().toString)
            

            
            ////////////////////////////////////////////////////////////////
            // Test 3 
            ////////////////////////////////////////////////////////////////
            println("*************************************")
            println("Test 3: Random inputs and operations")
            println("*************************************")
            var op_config = 0.U
            // Summation  
            dut.io.din_1.poke(1.U)
            dut.io.din_2.poke(2.U)
            dut.io.op_config.poke(op_config)
            dut.clock.step(1)
            // Multiplication
            op_config = 1.U
            dut.io.din_1.poke(3.U)
            dut.io.din_2.poke(4.U)
            dut.io.op_config.poke(op_config)
            dut.clock.step(1)
            // Summation  
            op_config = 0.U
            dut.io.din_1.poke(5.U)
            dut.io.din_2.poke(6.U)
            dut.io.op_config.poke(op_config)
            dut.clock.step(1)
            // Subtraction
            op_config = 2.U
            dut.io.din_1.poke(7.U)
            dut.io.din_2.poke(8.U)
            dut.io.op_config.poke(op_config)
            dut.clock.step(1)
            // Multiplication
            op_config = 1.U
            dut.io.din_1.poke(7.U)
            dut.io.din_2.poke(8.U)
            dut.io.op_config.poke(op_config)
            dut.clock.step(1)
            // Shift Left Logical
            op_config = 3.U
            dut.io.din_1.poke(9.U)
            dut.io.din_2.poke(10.U)
            dut.io.op_config.poke(op_config)
            dut.clock.step(1)
            // Subtraction
            op_config = 2.U
            dut.io.din_1.poke(11.U)
            dut.io.din_2.poke(12.U)
            dut.io.op_config.poke(op_config)
            dut.clock.step(1)
            // Shift Right Arithmetic
            op_config = 4.U
            dut.io.din_1.poke(13.U)
            dut.io.din_2.poke(14.U)
            dut.io.op_config.poke(op_config)
            dut.clock.step(1)
            // Shift Left Logical
            op_config = 3.U
            dut.io.din_1.poke(15.U)
            dut.io.din_2.poke(16.U)
            dut.io.op_config.poke(op_config)
            dut.clock.step(1)
            // Shift Right Logical
            op_config = 5.U
            dut.io.din_1.poke(17.U)
            dut.io.din_2.poke(18.U)
            dut.io.op_config.poke(op_config)
            dut.clock.step(1)
            // Shift Right Arithmetic
            op_config = 4.U
            dut.io.din_1.poke(19.U)
            dut.io.din_2.poke(20.U)
            dut.io.op_config.poke(op_config)
            dut.clock.step(1)
            // And
            op_config = 6.U
            dut.io.din_1.poke(21.U)
            dut.io.din_2.poke(22.U)
            dut.io.op_config.poke(op_config)
            dut.clock.step(1)
            // Shift Right Logical
            op_config = 5.U
            dut.io.din_1.poke(23.U)
            dut.io.din_2.poke(24.U)
            dut.io.op_config.poke(op_config)
            dut.clock.step(1)
            // Or
            op_config = 7.U
            dut.io.din_1.poke(25.U)
            dut.io.din_2.poke(26.U)
            dut.io.op_config.poke(op_config)
            dut.clock.step(1)
            // And
            op_config = 6.U
            dut.io.din_1.poke(27.U)
            dut.io.din_2.poke(28.U)
            dut.io.op_config.poke(op_config)
            dut.clock.step(1)
            // Xor
            op_config = 8.U
            dut.io.din_1.poke(29.U)
            dut.io.din_2.poke(30.U)
            dut.io.op_config.poke(op_config)
            dut.clock.step(1)
            // Minimum
            op_config = 10.U
            dut.io.din_1.poke(31.U)
            dut.io.din_2.poke(32.U)
            dut.io.op_config.poke(op_config)
            dut.clock.step(1)
            // Xor
            op_config = 8.U
            dut.io.din_1.poke(33.U)
            dut.io.din_2.poke(34.U)
            dut.io.op_config.poke(op_config)
            dut.clock.step(1)
            // Maximum
            op_config = 11.U
            dut.io.din_1.poke(35.U)
            dut.io.din_2.poke(36.U)
            dut.io.op_config.poke(op_config)
            dut.clock.step(1)
            // Minimum
            op_config = 10.U
            dut.io.din_1.poke(37.U)
            dut.io.din_2.poke(38.U)
            dut.io.op_config.poke(op_config)
            dut.clock.step(1)
            */
        }
    } 
}
