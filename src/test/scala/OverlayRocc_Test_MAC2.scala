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

class OverlayRocc_Test_MAC2 extends AnyFlatSpec with ChiselScalatestTester {
    "OverlayRocc_Test_MAC2 test" should "pass" in {
        test(new OverlayRocc(32, 6, 6, 32)) { dut =>
            
            
            var data_in_valid = "b000000".U 
            var data_out_ready = "b111111".U 
            dut.io.data_in_valid.poke(data_in_valid)
            dut.io.data_out_ready.poke(data_out_ready)
            dut.clock.step(1)


            var cell_config: UInt = 0.U 
            /*
            // Note: Original 
            val source = Source.fromFile("src/test/scala/Bitstreams/mac2.txt")
            for (line <- source.getLines()){
                
                cell_config = ("b" + line).U  
                dut.io.cell_config.poke(cell_config)
                dut.clock.step(1)
                dut.clock.step(1)
                dut.clock.step(1)
            }
            source.close()
            */



            ///////////////////////////////////////////
            // MAC 2
            ///////////////////////////////////////////

            // Note: Changing the last cell_config => Removing the feedback loop ========> Did not work with feedback loop

            cell_config = "b100011000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000100000000000000000100000000".U
            dut.io.cell_config.poke(cell_config)
            dut.clock.step(1)
            dut.clock.step(1)
            dut.clock.step(1)
            cell_config = "b100000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000010000000000000010000000000".U
            dut.io.cell_config.poke(cell_config)
            dut.clock.step(1)
            dut.clock.step(1)
            dut.clock.step(1)
            cell_config = "b100110100000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000100000000000000000100000000".U
            dut.io.cell_config.poke(cell_config)
            dut.clock.step(1)
            dut.clock.step(1)
            dut.clock.step(1)
            cell_config = "b100011100000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000100001000000000000000000000011000000000000000000000000000111100000000".U
            dut.io.cell_config.poke(cell_config)
            dut.clock.step(1)
            dut.clock.step(1)
            dut.clock.step(1)
            cell_config = "b100000100000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000100000000000000000100000000".U
            dut.io.cell_config.poke(cell_config)
            dut.clock.step(1)
            dut.clock.step(1)
            dut.clock.step(1)
            cell_config = "b101101000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000100000000000000000100000000".U
            dut.io.cell_config.poke(cell_config)
            dut.clock.step(1)
            dut.clock.step(1)
            dut.clock.step(1)
            cell_config = "b101010000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000010000000000000010000000000".U
            dut.io.cell_config.poke(cell_config)
            dut.clock.step(1)
            dut.clock.step(1)
            dut.clock.step(1)
            cell_config = "b100111000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000001000000000000000000000000000001000000000010000000000000000010000000000000010000100011".U
            dut.io.cell_config.poke(cell_config)
            dut.clock.step(1)
            dut.clock.step(1)
            dut.clock.step(1)
            cell_config = "b100100000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000010000000000000010000000000100010000001000001010001000000000011100000001".U
            dut.io.cell_config.poke(cell_config)
            dut.clock.step(1)
            dut.clock.step(1)
            dut.clock.step(1)
            cell_config = "b100001000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000001000000000100001100000000001000000000000000110000000010".U
            dut.io.cell_config.poke(cell_config)
            dut.clock.step(1)
            dut.clock.step(1)
            dut.clock.step(1)
            cell_config = "b101101100000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000010000000000000000000000000000001100000000".U
            dut.io.cell_config.poke(cell_config)
            dut.clock.step(1)
            dut.clock.step(1)
            dut.clock.step(1)
            cell_config = "b100111100000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000100000000000000100000000000000000111000000".U
            dut.io.cell_config.poke(cell_config)
            dut.clock.step(1)
            dut.clock.step(1)
            dut.clock.step(1)
            cell_config = "b100100100000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000001000010000000000000000000011110000000000".U
            dut.io.cell_config.poke(cell_config)
            dut.clock.step(1)
            dut.clock.step(1)
            dut.clock.step(1)
            cell_config = "b100001100000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000001000000000110000000000000001000000000000000000000000011".U
            dut.io.cell_config.poke(cell_config)
            dut.clock.step(1)
            dut.clock.step(1)
            dut.clock.step(1)
            cell_config = "b101110000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000010000000000000000000000000000001100000000".U
            dut.io.cell_config.poke(cell_config)
            dut.clock.step(1)
            dut.clock.step(1)
            dut.clock.step(1)
            cell_config = "b101000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000010000000000000000000000000000001100000000".U
            dut.io.cell_config.poke(cell_config)
            dut.clock.step(1)
            dut.clock.step(1)
            dut.clock.step(1)
            cell_config = "b100101000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000100000000000000000100000000".U
            dut.io.cell_config.poke(cell_config)
            dut.clock.step(1)
            dut.clock.step(1)
            dut.clock.step(1)
            cell_config = "b100010000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000010000000000000010000000000000011100000000".U
            dut.io.cell_config.poke(cell_config)
            dut.clock.step(1)
            dut.clock.step(1)
            dut.clock.step(1)
            cell_config = "b101110100000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000100000000000000000000000000000000011000000".U
            dut.io.cell_config.poke(cell_config)
            dut.clock.step(1)
            dut.clock.step(1)
            dut.clock.step(1)
            cell_config = "b101011100000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000001000000000000000000000000000010000000".U
            dut.io.cell_config.poke(cell_config)
            dut.clock.step(1)
            dut.clock.step(1)
            dut.clock.step(1)
            cell_config = "b101000100000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000010000000000110000010000000000000000000000000000000010011".U
            dut.io.cell_config.poke(cell_config)
            dut.clock.step(1)
            dut.clock.step(1)
            dut.clock.step(1)
            // Changed 
            cell_config = "b100101100000000000000110010000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000001000000000010000010000000000000000000000000000000010011".U
            dut.io.cell_config.poke(cell_config)
            dut.clock.step(1)
            dut.clock.step(1)
            dut.clock.step(1)
            // Changed 
            cell_config = "b1100010100000000000000110010000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000001000000000010000000000000001000000000000000000000000011".U
            dut.io.cell_config.poke(cell_config)
            dut.clock.step(1)
            dut.clock.step(1)
            dut.clock.step(1)


            val din = BigInt("00000003" + "00000003" + "00000001"+ "00000001" + "00000001" + "00000001" ,16).S
                
                dut.io.data_in.poke(din)
                dut.io.data_in_valid.poke("b111111".U)
                dut.clock.step(1)
                dut.io.data_in_valid.poke("b000000".U)
                dut.clock.step(10)


            println("Overlay******************************")
            println("*************************************")
            for( i <- 0 to 100){
                dut.clock.step(1)
            }
            
        }
    } 
}
