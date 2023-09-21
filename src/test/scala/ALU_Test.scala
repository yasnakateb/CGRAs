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

            /*
            dut.io.din_1.poke(1.S)
            dut.io.din_2.poke(2.S)
            var op_config = 0.S
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
            dut.io.din_1.poke(3.S)
            dut.io.din_2.poke(4.S)
            dut.clock.step(1)
            dut.io.din_1.poke(5.S)
            dut.io.din_2.poke(6.S)
            dut.clock.step(1)
            println("Summation: " + dut.io.dout.peek().toString)
            // Multiplication
            dut.io.din_1.poke(2.S)
            dut.io.din_2.poke(1.S)
            op_config = 1.S
            dut.io.op_config.poke(op_config)
            dut.clock.step(1)
            dut.io.din_1.poke(4.S)
            dut.io.din_2.poke(3.S)
            dut.clock.step(1)
            dut.io.din_1.poke(6.S)
            dut.io.din_2.poke(5.S)
            dut.clock.step(1)
            println("Multiplication: " + dut.io.dout.peek().toString)
            // Subtraction
            op_config = 2.S
            dut.io.din_1.poke(2.S)
            dut.io.din_2.poke(0.S)
            dut.io.op_config.poke(op_config)
            dut.clock.step(1)
            dut.io.din_1.poke(4.S)
            dut.io.din_2.poke(1.S)
            dut.clock.step(1)
            dut.io.din_1.poke(6.S)
            dut.io.din_2.poke(4.S)
            dut.clock.step(1)
            println("Subtraction: " + dut.io.dout.peek().toString)
            // Shift Left Logical
            op_config = 3.S
            dut.io.din_1.poke(2.S)
            dut.io.din_2.poke(1.S)
            dut.io.op_config.poke(op_config)
            dut.clock.step(1)
            dut.io.din_1.poke(4.S)
            dut.io.din_2.poke(3.S)
            dut.clock.step(1)
            dut.io.din_1.poke(6.S)
            dut.io.din_2.poke(5.S)
            dut.clock.step(1)
            println("Shift Left Logical: " + dut.io.dout.peek().toString)
            // Shift Right Arithmetic
            op_config = 4.S
            dut.io.din_1.poke(20.S)
            dut.io.din_2.poke(1.S)
            dut.io.op_config.poke(op_config)
            dut.clock.step(1)
            dut.io.din_1.poke(14.S)
            dut.io.din_2.poke(1.S)
            dut.clock.step(1)
            dut.io.din_1.poke(16.S)
            dut.io.din_2.poke(2.S)
            dut.clock.step(1)
            println("Shift Right Arithmetic: " + dut.io.dout.peek().toString)
            // Shift Right Logical
            op_config = 5.S
            dut.io.din_1.poke(20.S)
            dut.io.din_2.poke(1.S)
            dut.io.op_config.poke(op_config)
            dut.clock.step(1)
            dut.io.din_1.poke(14.S)
            dut.io.din_2.poke(1.S)
            dut.clock.step(1)
            dut.io.din_1.poke(16.S)
            dut.io.din_2.poke(2.S)
            dut.clock.step(1)
            println("Shift Right Logical: " + dut.io.dout.peek().toString)
            // And
            op_config = 6.S
            dut.io.din_1.poke(20.S)
            dut.io.din_2.poke(16.S)
            dut.io.op_config.poke(op_config)
            dut.clock.step(1)
            dut.io.din_1.poke(14.S)
            dut.io.din_2.poke(13.S)
            dut.clock.step(1)
            dut.io.din_1.poke(17.S)
            dut.io.din_2.poke(15.S)
            dut.clock.step(1)
            println("And: " + dut.io.dout.peek().toString)
            // Or
            op_config = 7.S
            dut.io.din_1.poke(20.S)
            dut.io.din_2.poke(1.S)
            dut.io.op_config.poke(op_config)
            dut.clock.step(1)
            dut.io.din_1.poke(14.S)
            dut.io.din_2.poke(2.S)
            dut.clock.step(1)
            dut.io.din_1.poke(16.S)
            dut.io.din_2.poke(3.S)
            dut.clock.step(1)
            println("Or: " + dut.io.dout.peek().toString)
            // Xor
            op_config = 8.S
            dut.io.din_1.poke(20.S)
            dut.io.din_2.poke(1.S)
            dut.io.op_config.poke(op_config)
            dut.clock.step(1)
            dut.io.din_1.poke(14.S)
            dut.io.din_2.poke(2.S)
            dut.clock.step(1)
            dut.io.din_1.poke(16.S)
            dut.io.din_2.poke(3.S)
            dut.clock.step(1)
            println("Xor: " + dut.io.dout.peek().toString)
            // Minimum
            op_config = 10.S
            dut.io.din_1.poke(20.S)
            dut.io.din_2.poke(1.S)
            dut.io.op_config.poke(op_config)
            dut.clock.step(1)
            dut.io.din_1.poke(14.S)
            dut.io.din_2.poke(2.S)
            dut.clock.step(1)
            dut.io.din_1.poke(16.S)
            dut.io.din_2.poke(3.S)
            dut.clock.step(1)
            println("Minimum: " + dut.io.dout.peek().toString)
            // Maximum
            op_config = 11.S
            dut.io.din_1.poke(20.S)
            dut.io.din_2.poke(1.S)
            dut.io.op_config.poke(op_config)
            dut.clock.step(1)
            dut.io.din_1.poke(14.S)
            dut.io.din_2.poke(2.S)
            dut.clock.step(1)
            dut.io.din_1.poke(16.S)
            dut.io.din_2.poke(3.S)
            dut.clock.step(1)
            println("Maximum: " + dut.io.dout.peek().toString)
            ////////////////////////////////////////////////////////////////
            // Test 2
            ////////////////////////////////////////////////////////////////
            val din_1 = "b1000_0000_0000_0000_0000_0000_0000_1111".S
            dut.io.din_1.poke(din_1)
            println("*************************************")
            println("Test 2: Din1 => Negative number")
            println("*************************************")
            println("Din1: " + dut.io.din_1.peek().toString)
            println("Din2: " + dut.io.din_2.peek().toString)
            // Summation  
            op_config = 0.S
            dut.io.op_config.poke(op_config)
            dut.clock.step(1)
            println("Summation: " + dut.io.dout.peek().toString)
            // Multiplication
            op_config = 1.S
            dut.io.op_config.poke(op_config)
            dut.clock.step(1)
            println("Multiplication: " + dut.io.dout.peek().toString)
            // Subtraction
            op_config = 2.S
            dut.io.op_config.poke(op_config)
            dut.clock.step(1)
            println("Subtraction: " + dut.io.dout.peek().toString)
            // Shift Left Logical
            op_config = 3.S
            dut.io.op_config.poke(op_config)
            dut.clock.step(1)
            println("Left Logical: " + dut.io.dout.peek().toString)
            op_config = 4.S
            dut.io.op_config.poke(op_config)
            dut.clock.step(1)
            println("Shift Right Arithmetic: " + dut.io.dout.peek().toString)
            // Shift Right Logical
            op_config = 5.S
            dut.io.op_config.poke(op_config)
            dut.clock.step(1)
            println("Shift Right Logical: " + dut.io.dout.peek().toString) 
            // And
            op_config = 6.S
            dut.io.op_config.poke(op_config)
            dut.clock.step(1)
            println("And: " + dut.io.dout.peek().toString)
            // Or
            op_config = 7.S
            dut.io.op_config.poke(op_config)
            dut.clock.step(1)
            println("Or: " + dut.io.dout.peek().toString)
            // Xor
            op_config = 8.S
            dut.io.op_config.poke(op_config)
            dut.clock.step(1)
            println("Xor: " + dut.io.dout.peek().toString)
            // Minimum
            op_config = 10.S
            dut.io.op_config.poke(op_config)
            dut.clock.step(1)
            println("Minimum: " + dut.io.dout.peek().toString)
            // Maximum
            op_config = 11.S
            dut.io.op_config.poke(op_config)
            dut.clock.step(1)
            println("Maximum: " + dut.io.dout.peek().toString)
            */

            
            ////////////////////////////////////////////////////////////////
            // Test 3 
            ////////////////////////////////////////////////////////////////
            println("*************************************")
            println("Test 3: Random inputs and operations")
            println("*************************************")
            
            var op_config = 0.U
            // Summation  
            dut.io.din_1.poke(1.S)
            dut.io.din_2.poke(2.S)
            dut.io.op_config.poke(op_config)
            dut.clock.step(1)
            // Multiplication
            op_config = 1.U
            dut.io.din_1.poke(3.S)
            dut.io.din_2.poke(4.S)
            dut.io.op_config.poke(op_config)
            dut.clock.step(1)
            // Summation  
            op_config = 0.U
            dut.io.din_1.poke(5.S)
            dut.io.din_2.poke(6.S)
            dut.io.op_config.poke(op_config)
            dut.clock.step(1)
            // Subtraction
            op_config = 2.U
            dut.io.din_1.poke(8.S)
            dut.io.din_2.poke(7.S)
            dut.io.op_config.poke(op_config)
            dut.clock.step(1)
            // Multiplication
            op_config = 1.U
            dut.io.din_1.poke(7.S)
            dut.io.din_2.poke(8.S)
            dut.io.op_config.poke(op_config)
            dut.clock.step(1)
            // Shift Left Logical
            op_config = 3.U
            dut.io.din_1.poke(9.S)
            dut.io.din_2.poke(10.S)
            dut.io.op_config.poke(op_config)
            dut.clock.step(1)
            // Subtraction
            op_config = 2.U
            dut.io.din_1.poke(12.S)
            dut.io.din_2.poke(11.S)
            dut.io.op_config.poke(op_config)
            dut.clock.step(1)
            // Shift Right Arithmetic
            op_config = 4.U
            dut.io.din_1.poke(13.S)
            dut.io.din_2.poke(14.S)
            dut.io.op_config.poke(op_config)
            dut.clock.step(1)
            // Shift Left Logical
            op_config = 3.U
            dut.io.din_1.poke(15.S)
            dut.io.din_2.poke(16.S)
            dut.io.op_config.poke(op_config)
            dut.clock.step(1)
            // Shift Right Logical
            op_config = 5.U
            dut.io.din_1.poke(17.S)
            dut.io.din_2.poke(18.S)
            dut.io.op_config.poke(op_config)
            dut.clock.step(1)
            // Shift Right Arithmetic
            op_config = 4.U
            dut.io.din_1.poke(19.S)
            dut.io.din_2.poke(20.S)
            dut.io.op_config.poke(op_config)
            dut.clock.step(1)
            // And
            op_config = 6.U
            dut.io.din_1.poke(21.S)
            dut.io.din_2.poke(22.S)
            dut.io.op_config.poke(op_config)
            dut.clock.step(1)
            // Shift Right Logical
            op_config = 5.U
            dut.io.din_1.poke(23.S)
            dut.io.din_2.poke(24.S)
            dut.io.op_config.poke(op_config)
            dut.clock.step(1)
            // Or
            op_config = 7.U
            dut.io.din_1.poke(25.S)
            dut.io.din_2.poke(26.S)
            dut.io.op_config.poke(op_config)
            dut.clock.step(1)
            // And
            op_config = 6.U
            dut.io.din_1.poke(27.S)
            dut.io.din_2.poke(28.S)
            dut.io.op_config.poke(op_config)
            dut.clock.step(1)
            // Xor
            op_config = 8.U
            dut.io.din_1.poke(29.S)
            dut.io.din_2.poke(30.S)
            dut.io.op_config.poke(op_config)
            dut.clock.step(1)
            // Minimum
            op_config = 10.U
            dut.io.din_1.poke(31.S)
            dut.io.din_2.poke(32.S)
            dut.io.op_config.poke(op_config)
            dut.clock.step(1)
            // Xor
            op_config = 8.U
            dut.io.din_1.poke(33.S)
            dut.io.din_2.poke(34.S)
            dut.io.op_config.poke(op_config)
            dut.clock.step(1)
            // Maximum
            op_config = 11.U
            dut.io.din_1.poke(35.S)
            dut.io.din_2.poke(36.S)
            dut.io.op_config.poke(op_config)
            dut.clock.step(1)
            // Minimum
            op_config = 10.U
            dut.io.din_1.poke(37.S)
            dut.io.din_2.poke(38.S)
            dut.io.op_config.poke(op_config)
            dut.clock.step(1)
            
        }
    } 
}
