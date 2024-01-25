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
import chisel3.util._
import org.scalatest.flatspec.AnyFlatSpec

class OverlayRocc_Test_SUM extends AnyFlatSpec with ChiselScalatestTester {
    "OverlayRocc_Test test" should "pass" in {
        test(new OverlayRocc(32, 6, 6, 32)) { dut =>
            

            ///////////////////////////////////////////
            // SUM
            ///////////////////////////////////////////

            var data_in_valid = "b000000".U 
            var data_out_ready = "b111111".U 
            dut.io.data_in_valid.poke(data_in_valid)
            dut.io.data_out_ready.poke(data_out_ready)
            dut.clock.step(1)

            
            var cell_config = "b10001000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000_0100_0000_0000_0000_0001_0000_0000".U 
            dut.io.cell_config.poke(cell_config)

            dut.clock.step(1)
            dut.clock.step(1)
            dut.clock.step(1)
            cell_config = "b100010100000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000001000000000010000000000000001000000000000000000000000011".U 
            dut.io.cell_config.poke(cell_config)
            dut.clock.step(1)
            var data_in = BigInt("510101014010101032030405260708091807060504030201",16).S 
            dut.io.data_in_valid.poke(data_in_valid)
            dut.io.data_in.poke(data_in)
            

            for (i <- 1 to 16) {
                val c4 = i.toString()
                val c5 = i.toString()
                val din = BigInt("00000000" + f"$i%08d" + "00000000000000000000000000000000",16).S
                dut.io.data_in.poke(din)
                dut.io.data_in_valid.poke("b110000".U)
                dut.clock.step(i)
                dut.io.data_in_valid.poke("b000000".U)
                dut.clock.step(10)
            }
            
            println("Overlay******************************")
            println("*************************************")
            for( i <- 0 to 100){
                dut.clock.step(1)
            }
           
        }
    } 
}
