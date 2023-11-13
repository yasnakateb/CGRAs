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

            var number_of_tests = 33 
            
            ////////////////////////////////////////////////////////////////
            // Test 1: SUM
            ////////////////////////////////////////////////////////////////
            dut.io.op_config.poke(0.U)

            for (i <- 1 until number_of_tests) {
                dut.io.din_1.poke(i.S)
                dut.io.din_2.poke((i+1).S)
                dut.clock.step(1)
            }
            ////////////////////////////////////////////////////////////////
            // Test 2: MUL 
            ////////////////////////////////////////////////////////////////
            dut.io.op_config.poke(1.U)

            //for (i <- 1 until number_of_tests) {
                dut.io.din_1.poke((65535).S)
                dut.io.din_2.poke((65535).S)
                dut.clock.step(1)
                dut.io.din_1.poke((65535).S)
                dut.io.din_2.poke((65536).S)
                dut.clock.step(1)
                dut.io.din_1.poke((65535).S)
                dut.io.din_2.poke((65537).S)
                dut.clock.step(1)
                dut.io.din_1.poke((65537).S)
                dut.io.din_2.poke((65547).S)
                dut.clock.step(1)
                dut.clock.step(1)
            //}
            ////////////////////////////////////////////////////////////////
            // Test 3: SUB 
            ////////////////////////////////////////////////////////////////
            dut.io.op_config.poke(2.U)

            for (i <- 1 until number_of_tests) {
                dut.io.din_1.poke((i+2).S)
                dut.io.din_2.poke((i).S)
                dut.clock.step(1)
            }
            ////////////////////////////////////////////////////////////////
            // Test 4: SLL 
            ////////////////////////////////////////////////////////////////
            dut.io.op_config.poke(3.U)

            dut.io.din_1.poke(1.S)
            for (i <- 1 until number_of_tests) {
                dut.io.din_2.poke(i.S)
                dut.clock.step(1)
            }
            ////////////////////////////////////////////////////////////////
            // Test 5: SRA
            ////////////////////////////////////////////////////////////////
            dut.io.op_config.poke(4.U)

            dut.io.din_2.poke(1.S)
            for (i <- 1 until number_of_tests) {
                dut.io.din_1.poke((-(i*2)).S)
                dut.clock.step(1)
            }
            ////////////////////////////////////////////////////////////////
            // Test 6: SRL 
            ////////////////////////////////////////////////////////////////
            dut.io.op_config.poke(5.U)

            
            for (i <- 1 until number_of_tests) {
                dut.io.din_1.poke((-(i*2)).S)
                dut.io.din_2.poke(i.S)
                dut.clock.step(1)
            }
            ////////////////////////////////////////////////////////////////
            // Test 7: AND 
            ////////////////////////////////////////////////////////////////
            dut.io.op_config.poke(6.U)

            for (i <- 1 until number_of_tests) {
                dut.io.din_1.poke(i.S)
                dut.io.din_2.poke((i+1).S)
                dut.clock.step(1)
            }
            ////////////////////////////////////////////////////////////////
            // Test 8: OR 
            ////////////////////////////////////////////////////////////////
            dut.io.op_config.poke(7.U)

            for (i <- 1 until number_of_tests) {
                dut.io.din_1.poke(i.S)
                dut.io.din_2.poke((i+1).S)
                dut.clock.step(1)
            }
            ////////////////////////////////////////////////////////////////
            // Test 9: XOR 
            ////////////////////////////////////////////////////////////////
            dut.io.op_config.poke(8.U)

            for (i <- 1 until number_of_tests) {
                dut.io.din_1.poke(i.S)
                dut.io.din_2.poke((i+1).S)
                dut.clock.step(1)
            } 
        }
    } 
}