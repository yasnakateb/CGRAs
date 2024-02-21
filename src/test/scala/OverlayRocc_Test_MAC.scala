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

class OverlayRocc_Test_MAC extends AnyFlatSpec with ChiselScalatestTester {
    "OverlayRocc_Test_MAC test" should "pass" in {
        test(new OverlayRocc(32, 6, 6, 32)).withAnnotations(Seq(VerilatorBackendAnnotation, WriteVcdAnnotation)) { dut =>  
            ///////////////////////////////////////////
            // MAC
            ///////////////////////////////////////////

            var data_in_valid = "b000000".U 
            var data_out_ready = "b111111".U 
            dut.io.data_in_valid.poke(data_in_valid)
            dut.io.data_out_ready.poke(data_out_ready)
            dut.clock.step(1)


            var cell_config: UInt = 0.U 
            /*
            // Note: Original 
            val source = Source.fromFile("src/test/scala/Bitstreams/mac.txt")
            for (line <- source.getLines()){
                
                cell_config = ("b" + line).U  
                dut.io.cell_config.poke(cell_config)
                dut.clock.step(1)
                dut.clock.step(1)
                dut.clock.step(1)
            }
            source.close()
            */

            cell_config = "b100001100000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000001000000000100000000001000001000000000000000000000000001".U 
            dut.io.cell_config.poke(cell_config)
            dut.clock.step(1)
            dut.clock.step(1)
            dut.clock.step(1)

            cell_config = "b100010000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000010000000000000001000000000001001100000000".U 
            dut.io.cell_config.poke(cell_config)
            dut.clock.step(1)
            dut.clock.step(1)
            dut.clock.step(1)

            // Test 1
            //cell_config = "b100010100001000000000000010000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000001000000000001000000000000010000000000000000000000011000".U 

            // Test 2
            cell_config = "b100010100001000000000000010100000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000001000000000001000000000000010000000000000000000000011000".U 

            dut.io.cell_config.poke(cell_config)
            dut.clock.step(1)
            dut.clock.step(1)
            dut.clock.step(1)

            ///////////////////////////////////////////
            // Test 1: a = 2
            //         b = i
            //         x = Σc (n = 4) + 0
            ///////////////////////////////////////////
            /*
            for (i <- 1 to 101) {
                val c4 = i.toString()
                val c5 = i.toString()
                
                val din = BigInt("00000000"  + f"$i%08X" + "00000002"+ "00000000" + "00000000" + "00000000" ,16).S
                
                dut.io.data_in.poke(din)
                dut.io.data_in_valid.poke("b111000".U)
                dut.clock.step(1)
                dut.io.data_in_valid.poke("b000000".U)
                dut.clock.step(10)
            }
            */
            ///////////////////////////////////////////
            // Test 2: a = i
            //         b = i
            //         x = Σc (n = 5) + 3
            ///////////////////////////////////////////

            for (i <- 1 to 101) {
                // ------------------------------------------------------------------------------------------------
                // |                 |    C5     |    C4      |      C3   |     C2     |     C1     |      C0     |
                // ------------------------------------------------------------------------------------------------
                // ------------------------------------------------------------------------------------------------
                // |                 |    x      |    b       |      a    |     -      |     -      |      -      |
                // ------------------------------------------------------------------------------------------------
                val din = BigInt("00000003" + (i).formatted("%08X")  + (i).formatted("%08X") + "00000000" + "00000000" + "00000000" ,16).S
                dut.io.data_in.poke(din)
                dut.io.data_in_valid.poke("b111000".U)
                dut.clock.step(1)
                dut.io.data_in_valid.poke("b000000".U)
                dut.clock.step(10)
            }
            // Finish 
            for( i <- 0 to 10){
                dut.clock.step(1)
            } 
            println("End of the simulation")         
        }
    } 
}
