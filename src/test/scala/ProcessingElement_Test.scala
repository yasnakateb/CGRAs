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

object ProcessingElementParams
{
    def DATA_WIDTH = 32
    def FIFO_DEPTH = 32 
    def INSTRUCTION_CHANGE_DELAY = 5  
    
}

import ProcessingElementParams._

class ProcessingElement_Test extends AnyFlatSpec with ChiselScalatestTester {
    "ProcessingElement_Test test" should "pass" in {
        // Test code for summation with positive numbers

        test(new ProcessingElement(DATA_WIDTH, FIFO_DEPTH)) { dut =>
            
            var north_din = 0.U 
            var north_din_v = false.B
            val north_dout_r = true.B  

            var east_din = 0.U  
            var east_din_v = false.B 
            val east_dout_r = true.B 

            var south_din = 0.U  
            var south_din_v = false.B 
            val south_dout_r = true.B 

            var west_din = 0.U  
            var west_din_v = false.B 
            val west_dout_r = true.B 

            // Initialization
            dut.io.north_din.poke(north_din)
            dut.io.north_din_v.poke(north_din_v)
            dut.io.north_dout_r.poke(north_dout_r)
            
            dut.io.east_din.poke(east_din)
            dut.io.east_din_v.poke(east_din_v)
            dut.io.east_dout_r.poke(east_dout_r)

            dut.io.south_din.poke(south_din)
            dut.io.south_din_v.poke(south_din_v)
            dut.io.south_dout_r.poke(south_dout_r)

            dut.io.west_din.poke(west_din)
            dut.io.west_din_v.poke(west_din_v)
            dut.io.west_dout_r.poke(west_dout_r)


            // **** Test case for summation
            var config_bits = "b00000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000001000000000010000000000000001000000000000000000000000011".U 
            var catch_config = true.B 
            // Configuration 
            dut.io.catch_config.poke(catch_config)
            dut.io.catch_config.poke(true.B)
            dut.io.config_bits.poke(config_bits)
            dut.clock.step(1)
            dut.clock.step(1)
            dut.io.catch_config.poke(false.B)
            config_bits = 0.U
            dut.io.config_bits.poke(config_bits)
            
            // Inserting Data 
            dut.io.north_din_v.poke(true.B)
            dut.io.west_din_v.poke(true.B)
            // FIFO_DEPTH + 3 => The last output is FIFO[3], dout_v = false 
            for (i <- 1 until FIFO_DEPTH + 3) {
                dut.io.north_din.poke(i.U)
                dut.io.west_din.poke((i+1).U)
                dut.clock.step(1)
            }
            dut.io.north_din_v.poke(false.B)
            dut.io.west_din_v.poke(false.B)
            for (i <- 0 until INSTRUCTION_CHANGE_DELAY) {
                dut.clock.step(1)
            }

            // **** Test case: SUM
            config_bits = "b00000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000001000000000110000000000000001000000000000000000000000011".U 
            catch_config = true.B 
            // Configuration 
            dut.io.catch_config.poke(catch_config)
            dut.io.catch_config.poke(true.B)
            dut.io.config_bits.poke(config_bits)
            dut.clock.step(1)
            dut.clock.step(1)
            dut.io.catch_config.poke(false.B)
            config_bits = 0.U
            dut.io.config_bits.poke(config_bits)
            
            // Inserting Data 
            dut.io.north_din_v.poke(true.B)
            dut.io.west_din_v.poke(true.B)
            // FIFO_DEPTH + 3 => The last output is FIFO[3], dout_v = false 
            for (i <- 1 until FIFO_DEPTH + 3) {
                dut.io.north_din.poke(i.U)
                dut.io.west_din.poke((i+1).U)
                dut.clock.step(1)
            }
            dut.io.north_din_v.poke(false.B)
            dut.io.west_din_v.poke(false.B)
            for (i <- 0 until INSTRUCTION_CHANGE_DELAY) {
                dut.clock.step(1)
            }

            // **** Test case: Mul
            config_bits = "b00000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000001000000000110000000000000001000000000000000000000000011".U 
            catch_config = true.B 
            // Configuration 
            dut.io.catch_config.poke(catch_config)
            dut.io.catch_config.poke(true.B)
            dut.io.config_bits.poke(config_bits)
            dut.clock.step(1)
            dut.clock.step(1)
            dut.io.catch_config.poke(false.B)
            config_bits = 0.U
            dut.io.config_bits.poke(config_bits)
            
            // Inserting Data 
            dut.io.north_din_v.poke(true.B)
            dut.io.west_din_v.poke(true.B)
           
            for (i <- 1 until FIFO_DEPTH) {
                dut.io.north_din.poke(i.U)
                dut.io.west_din.poke((i+1).U)
                dut.clock.step(1)
            }
            dut.io.north_din_v.poke(false.B)
            dut.io.west_din_v.poke(false.B)
            for (i <- 0 until INSTRUCTION_CHANGE_DELAY) {
                dut.clock.step(1)
            }

            // **** Test case: Sub
            config_bits = "b00000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000001000000001010000000000000001000000000000000000000000011".U 
            catch_config = true.B 
            // Configuration 
            dut.io.catch_config.poke(catch_config)
            dut.io.catch_config.poke(true.B)
            dut.io.config_bits.poke(config_bits)
            dut.clock.step(1)
            dut.clock.step(1)
            dut.io.catch_config.poke(false.B)
            config_bits = 0.U
            dut.io.config_bits.poke(config_bits)
            
            // Inserting Data 
            dut.io.north_din_v.poke(true.B)
            dut.io.west_din_v.poke(true.B)
            
            // dut.io.west_din.poke((i+3).U) => Result of subtraction: 1 or 2 
            for (i <- 1 until FIFO_DEPTH + 3) {
                dut.io.north_din.poke(i.U)
                if (i % 2 == 0) {
                    dut.io.west_din.poke((i+1).U)
                } else {
                    dut.io.west_din.poke((i+2).U)
                }
                dut.clock.step(1)
            }
            dut.io.north_din_v.poke(false.B)
            dut.io.west_din_v.poke(false.B)
            for (i <- 0 until INSTRUCTION_CHANGE_DELAY) {
                dut.clock.step(1)
            }

            // **** Test case: Shift left (logic)
            //////////// North: din_2, West: din_1 
            config_bits = "b00000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000001000000001110000000000000001000000000000000000000000011".U 
            catch_config = true.B 
            // Configuration 
            dut.io.catch_config.poke(catch_config)
            dut.io.catch_config.poke(true.B)
            dut.io.config_bits.poke(config_bits)
            dut.clock.step(1)
            dut.clock.step(1)
            dut.io.catch_config.poke(false.B)
            config_bits = 0.U
            dut.io.config_bits.poke(config_bits)
            
            // Inserting Data 
            dut.io.north_din_v.poke(true.B)
            dut.io.west_din_v.poke(true.B)
            // FIFO_DEPTH + 3 => The last output is FIFO[3], dout_v = false
            dut.io.west_din.poke(1.U)
            for (i <- 1 until FIFO_DEPTH + 3) {
                dut.io.north_din.poke(i.U)
                dut.clock.step(1)
            }
            dut.io.north_din_v.poke(false.B)
            dut.io.west_din_v.poke(false.B)
            for (i <- 0 until INSTRUCTION_CHANGE_DELAY) {
                dut.clock.step(1)
            }

            // **** Test case: Shift left (arithmetic) ????? or Right ? 

            config_bits = "b00000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000001000000010010000000000000001000000000000000000000000011".U 
            catch_config = true.B 
            // Configuration 
            dut.io.catch_config.poke(catch_config)
            dut.io.catch_config.poke(true.B)
            dut.io.config_bits.poke(config_bits)
            dut.clock.step(1)
            dut.clock.step(1)
            dut.io.catch_config.poke(false.B)
            config_bits = 0.U
            dut.io.config_bits.poke(config_bits)
            
            // Inserting Data 
            dut.io.north_din_v.poke(true.B)
            dut.io.west_din_v.poke(true.B)
            
            dut.io.north_din.poke(1.U)
            for (i <- 1 until FIFO_DEPTH + 3) {
            
                dut.io.west_din.poke((i*2).U)
                dut.clock.step(1)
            }
            dut.io.north_din_v.poke(false.B)
            dut.io.west_din_v.poke(false.B)
            for (i <- 0 until INSTRUCTION_CHANGE_DELAY) {
                dut.clock.step(1)
            }

            // **** Test case: Shift right (logic)

            config_bits = "b00000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000001000000010110000000000000001000000000000000000000000011".U 
            catch_config = true.B 
            // Configuration 
            dut.io.catch_config.poke(catch_config)
            dut.io.catch_config.poke(true.B)
            dut.io.config_bits.poke(config_bits)
            dut.clock.step(1)
            dut.clock.step(1)
            dut.io.catch_config.poke(false.B)
            config_bits = 0.U
            dut.io.config_bits.poke(config_bits)
            
            // Inserting Data 
            dut.io.north_din_v.poke(true.B)
            dut.io.west_din_v.poke(true.B)
            
            dut.io.north_din.poke(1.U)
            for (i <- 1 until FIFO_DEPTH + 3) {
            
                dut.io.west_din.poke((i*2).U)
                dut.clock.step(1)
            }
            
            dut.io.north_din_v.poke(false.B)
            dut.io.west_din_v.poke(false.B)
            for (i <- 0 until INSTRUCTION_CHANGE_DELAY) {
                dut.clock.step(1)
            }

            // **** Test case: AND
            config_bits = "b00000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000001000000011010000000000000001000000000000000000000000011".U 
            catch_config = true.B 
            // Configuration 
            dut.io.catch_config.poke(catch_config)
            dut.io.catch_config.poke(true.B)
            dut.io.config_bits.poke(config_bits)
            dut.clock.step(1)
            dut.clock.step(1)
            dut.io.catch_config.poke(false.B)
            config_bits = 0.U
            dut.io.config_bits.poke(config_bits)
            
            // Inserting Data 
            dut.io.north_din_v.poke(true.B)
            dut.io.west_din_v.poke(true.B)
            
           
            for (i <- 1 until FIFO_DEPTH + 3) {
                dut.io.north_din.poke(i.U)
                if (i % 2 == 0) {
                    dut.io.west_din.poke((i+1).U)
                } else {
                    dut.io.west_din.poke((i+2).U)
                }
                dut.clock.step(1)
            }
            dut.io.north_din_v.poke(false.B)
            dut.io.west_din_v.poke(false.B)
            for (i <- 0 until INSTRUCTION_CHANGE_DELAY) {
                dut.clock.step(1)
            }


            // **** Test case: OR
            config_bits = "b00000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000001000000011110000000000000001000000000000000000000000011".U 
            catch_config = true.B 
            // Configuration 
            dut.io.catch_config.poke(catch_config)
            dut.io.catch_config.poke(true.B)
            dut.io.config_bits.poke(config_bits)
            dut.clock.step(1)
            dut.clock.step(1)
            dut.io.catch_config.poke(false.B)
            config_bits = 0.U
            dut.io.config_bits.poke(config_bits)
            
            // Inserting Data 
            dut.io.north_din_v.poke(true.B)
            dut.io.west_din_v.poke(true.B)
            
            
            for (i <- 1 until FIFO_DEPTH + 3) {
                dut.io.north_din.poke(i.U)
                if (i % 2 == 0) {
                    dut.io.west_din.poke((i+1).U)
                } else {
                    dut.io.west_din.poke((i+2).U)
                }
                dut.clock.step(1)
            }
            dut.io.north_din_v.poke(false.B)
            dut.io.west_din_v.poke(false.B)
            for (i <- 0 until INSTRUCTION_CHANGE_DELAY) {
                dut.clock.step(1)
            }


            // **** Test case: XOR
            config_bits = "b00000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000001000000100010000000000000001000000000000000000000000011".U 
            catch_config = true.B 
            // Configuration 
            dut.io.catch_config.poke(catch_config)
            dut.io.catch_config.poke(true.B)
            dut.io.config_bits.poke(config_bits)
            dut.clock.step(1)
            dut.clock.step(1)
            dut.io.catch_config.poke(false.B)
            config_bits = 0.U
            dut.io.config_bits.poke(config_bits)
            
            // Inserting Data 
            dut.io.north_din_v.poke(true.B)
            dut.io.west_din_v.poke(true.B)
            
            
            for (i <- 1 until FIFO_DEPTH + 3) {
                dut.io.north_din.poke(i.U)
                if (i % 2 == 0) {
                    dut.io.west_din.poke((i+1).U)
                } else {
                    dut.io.west_din.poke((i+2).U)
                }
                dut.clock.step(1)
            }
            dut.io.north_din_v.poke(false.B)
            dut.io.west_din_v.poke(false.B)
            for (i <- 0 until INSTRUCTION_CHANGE_DELAY) {
                dut.clock.step(1)
            }


        }
    } 
}
