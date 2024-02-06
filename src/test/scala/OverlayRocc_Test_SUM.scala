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
import scala.io.Source

class OverlayRocc_Test_SUM extends AnyFlatSpec with ChiselScalatestTester {
    "OverlayRocc_Test_SUM test" should "pass" in {
        test(new OverlayRocc(32, 6, 6, 32)) { dut =>
            

            ///////////////////////////////////////////
            // SUM
            ///////////////////////////////////////////

            var data_in_valid = "b000000".U 
            var data_out_ready = "b111111".U 
            
            dut.io.data_in_valid.poke(data_in_valid)
            dut.io.data_out_ready.poke(data_out_ready)
            dut.clock.step(1)

            var cell_config: UInt = 0.U 
            /*
            val source = Source.fromFile("src/test/scala/Bitstreams/sum.txt")
            for (line <- source.getLines()){
                
                cell_config = ("b" + line).U  
                dut.io.cell_config.poke(cell_config)
                dut.clock.step(1)
                dut.clock.step(1)
                dut.clock.step(1)
            }
            source.close()
            */
            
            
            cell_config = "b10001000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000_0100_0000_0000_0000_0001_0000_0000".U 
            dut.io.cell_config.poke(cell_config)

            dut.clock.step(1)
            dut.clock.step(1)
            
            dut.clock.step(1)
            cell_config = "b100010100000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000001000000000010000000000000001000000000000000000000000011".U 
            dut.io.cell_config.poke(cell_config)
            dut.clock.step(1)
            

            for (i <- 1 to 16) {
                val c4 = i.toString()
                val c5 = i.toString()
                // ------------------------------------------------------------------------------------------------
                // |                 |    C5     |    C4      |      C3   |     C2     |     C1     |      C0     |
                // ------------------------------------------------------------------------------------------------
                val din = BigInt( (i + 1).formatted("%08X") + f"$i%08X" + "00000000000000000000000000000000",16).S
                dut.io.data_in.poke(din)
                dut.io.data_in_valid.poke("b110000".U)
                dut.clock.step(i)
                dut.io.data_in_valid.poke("b000000".U)
                dut.clock.step(5)
            }
            
            for( i <- 0 to 100){
                dut.clock.step(1)
            }
           
        }
    } 
}
