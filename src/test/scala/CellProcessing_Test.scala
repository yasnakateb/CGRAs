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

class CellProcessing_Test extends AnyFlatSpec with ChiselScalatestTester {
    "CellProcessing_Test test" should "pass" in {
        test(new CellProcessing(32)) { dut =>
            var north_din = 1.S 
            var north_din_v = true.B 
            var east_din = 0.S  
            var east_din_v = false.B 

            var south_din = 0.S 
            var south_din_v = false.B 
            var west_din = 2.S  
            var west_din_v = true.B 

            var north_dout_r = true.B 
            var east_dout_r = true.B 
            var south_dout_r = true.B 
            var west_dout_r = true.B 
            println("*************************************")
            println("Test 1: Summation")
            println("*************************************")
            var config_bits = "b00000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000001000000000010000000000000001000000000000000000000000011".U 
            
            dut.io.config_bits.poke(config_bits)
            dut.io.north_dout_r.poke(north_dout_r)
            dut.io.east_dout_r.poke(east_dout_r)

            dut.io.south_dout_r.poke(south_dout_r)
            dut.io.west_dout_r.poke(west_dout_r)
            dut.clock.step(1)
            dut.clock.step(1)

            
            

            dut.io.east_din.poke(east_din)
            dut.io.east_din_v.poke(east_din_v)

            dut.io.south_din.poke(south_din)
            dut.io.south_din_v.poke(south_din_v)

            
            
            
            println("*************************************")
            println("*************************************")
            dut.clock.step(1)
            dut.io.north_din.poke(north_din)
            dut.io.north_din_v.poke(north_din_v)
            dut.io.west_din.poke(west_din)
            dut.io.west_din_v.poke(west_din_v)
            dut.clock.step(1)

            dut.io.north_din.poke(3.S)
            dut.io.west_din.poke(4.S)

            dut.clock.step(1)

            dut.io.north_din.poke(5.S)
            dut.io.west_din.poke(6.S)

            dut.clock.step(1)

            dut.io.north_din.poke(7.S)
            dut.io.west_din.poke(8.S)

            dut.clock.step(1)
        
            dut.io.north_din.poke(0.S)
            dut.io.north_din_v.poke(false.B)

            dut.io.west_din.poke(0.S)
            dut.io.west_din_v.poke(false.B)

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

            // Outputs
            println("Outputs")
            println("FU_din_1_r: " + dut.io.FU_din_1_r.peek().toString)
            println("FU_din_2_r: " + dut.io.FU_din_2_r.peek().toString)
            println("dout: " + dut.io.dout.peek().toString)
            println("dout_v: " + dut.io.dout_v.peek().toString)
            println("*************************************")
            println("*************************************")

            ///////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
        }
    } 
}
