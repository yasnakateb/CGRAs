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

class OverlayRocc_Test_ACC extends AnyFlatSpec with ChiselScalatestTester {
    "OverlayRocc_Test_ACC test" should "pass" in {
        test(new OverlayRocc(32, 6, 6, 32)) { dut =>
            
            ///////////////////////////////////////////
            // Accumulate
            ///////////////////////////////////////////
            
            var data_in_valid = "b000000".U 
            var data_out_ready = "b111111".U 
            dut.io.data_in_valid.poke(data_in_valid)
            dut.io.data_out_ready.poke(data_out_ready)
            dut.clock.step(1)

            var cell_config = "b101111000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000010000100000000000000000101000000".U
            dut.io.cell_config.poke(cell_config)

            dut.clock.step(1)
            dut.clock.step(1)
            dut.clock.step(1)
            cell_config = "b101100000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000001000001000100000000000000100110000000".U
            dut.io.cell_config.poke(cell_config)

            dut.clock.step(1)
            dut.clock.step(1)
            dut.clock.step(1)
            cell_config = "b101001000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000001000001000100000000000000100110000000".U
            dut.io.cell_config.poke(cell_config)

            dut.clock.step(1)
            dut.clock.step(1)
            dut.clock.step(1)
            cell_config = "b100110000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000001000001000100000000000000100110000000".U
            dut.io.cell_config.poke(cell_config)

            dut.clock.step(1)
            dut.clock.step(1)
            dut.clock.step(1)
            cell_config = "b100011000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000001000001000100000000000000100110000000".U
            dut.io.cell_config.poke(cell_config)

            dut.clock.step(1)
            dut.clock.step(1)
            dut.clock.step(1)
            cell_config = "b100000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000001000000000000000010000001010000000000000000100000010000".U
            dut.io.cell_config.poke(cell_config)

            dut.clock.step(1)
            dut.clock.step(1)
            dut.clock.step(1)
            cell_config = "b101111100000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000100000000000100100000000000010000111000000".U
            dut.io.cell_config.poke(cell_config)

            dut.clock.step(1)
            dut.clock.step(1)
            dut.clock.step(1)
            cell_config = "b101100100000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000100000010001000100000000000011100111000000".U
            dut.io.cell_config.poke(cell_config)

            dut.clock.step(1)
            dut.clock.step(1)
            dut.clock.step(1)
            cell_config = "b101001100000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000100000010001000100000000000011100111000000".U
            dut.io.cell_config.poke(cell_config)

            dut.clock.step(1)
            dut.clock.step(1)
            dut.clock.step(1)
            cell_config = "b100110100000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000100000010001000100000000000011100111000000".U
            dut.io.cell_config.poke(cell_config)

            dut.clock.step(1)
            dut.clock.step(1)
            dut.clock.step(1)
            cell_config = "b100011100000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000100000010001000100000000000011100111000000".U
            dut.io.cell_config.poke(cell_config)

            dut.clock.step(1)
            dut.clock.step(1)
            dut.clock.step(1)
            cell_config = "b100000100000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000010000010001000000000000000011101100000000".U
            dut.io.cell_config.poke(cell_config)

            dut.clock.step(1)
            dut.clock.step(1)
            dut.clock.step(1)
            cell_config = "b110000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000100000000000100100000000000010000111000000".U
            dut.io.cell_config.poke(cell_config)

            dut.clock.step(1)
            dut.clock.step(1)
            dut.clock.step(1)
            cell_config = "b101101000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000100000010001000100000000000011100111000000".U
            dut.io.cell_config.poke(cell_config)

            dut.clock.step(1)
            dut.clock.step(1)
            dut.clock.step(1)
            cell_config = "b101010000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000100000010001000100000000000011100111000000".U
            dut.io.cell_config.poke(cell_config)

            dut.clock.step(1)
            dut.clock.step(1)
            dut.clock.step(1)
            cell_config = "b100111000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000100000010001000100000000000011100111000000".U
            dut.io.cell_config.poke(cell_config)

            dut.clock.step(1)
            dut.clock.step(1)
            dut.clock.step(1)
            cell_config = "b100100000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000100000010001000000000000000011100011000000".U
            dut.io.cell_config.poke(cell_config)

            dut.clock.step(1)
            dut.clock.step(1)
            dut.clock.step(1)
            cell_config = "b100001000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000001000000000101000000011000000000000000000011000000011001".U
            dut.io.cell_config.poke(cell_config)

            dut.clock.step(1)
            dut.clock.step(1)
            dut.clock.step(1)
            cell_config = "b110000100000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000100000000000100100000000000010000111000000".U
            dut.io.cell_config.poke(cell_config)

            dut.clock.step(1)
            dut.clock.step(1)
            dut.clock.step(1)
            cell_config = "b101101100000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000100000010001000100000000000011100111000000".U
            dut.io.cell_config.poke(cell_config)

            dut.clock.step(1)
            dut.clock.step(1)
            dut.clock.step(1)
            cell_config = "b101010100000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000100000010001000100000000000011100111000000".U
            dut.io.cell_config.poke(cell_config)

            dut.clock.step(1)
            dut.clock.step(1)
            dut.clock.step(1)
            cell_config = "b100111100000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000100000010001000100000000000011100111000000".U
            dut.io.cell_config.poke(cell_config)

            dut.clock.step(1)
            dut.clock.step(1)
            dut.clock.step(1)
            cell_config = "b100100100000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000010001000100000000000011100100000000".U
            dut.io.cell_config.poke(cell_config)

            dut.clock.step(1)
            dut.clock.step(1)
            dut.clock.step(1)
            cell_config = "b100001100001000000000110010000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000100000000000100000000001010000001000000001010000000001001100011001".U
            dut.io.cell_config.poke(cell_config)

            dut.clock.step(1)
            dut.clock.step(1)
            dut.clock.step(1)
            cell_config = "b110001000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000100000000000100100000000000010000111000000".U
            dut.io.cell_config.poke(cell_config)

            dut.clock.step(1)
            dut.clock.step(1)
            dut.clock.step(1)
            cell_config = "b101110000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000100000010001000100000000000011100111000000".U
            dut.io.cell_config.poke(cell_config)

            dut.clock.step(1)
            dut.clock.step(1)
            dut.clock.step(1)
            cell_config = "b101011000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000100000010001000100000000000011100111000000".U
            dut.io.cell_config.poke(cell_config)

            dut.clock.step(1)
            dut.clock.step(1)
            dut.clock.step(1)
            cell_config = "b101000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000100000010001000100000000000011100111000000".U
            dut.io.cell_config.poke(cell_config)

            dut.clock.step(1)
            dut.clock.step(1)
            dut.clock.step(1)
            cell_config = "b100101000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000010000000000000001000010000000100000000000011110100000000".U
            dut.io.cell_config.poke(cell_config)

            dut.clock.step(1)
            dut.clock.step(1)
            dut.clock.step(1)
            cell_config = "b100010000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000010000000001000001000000000001101100000000".U
            dut.io.cell_config.poke(cell_config)

            dut.clock.step(1)
            dut.clock.step(1)
            dut.clock.step(1)
            cell_config = "b110001100000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000100000000000000001000000000001000011000000".U
            dut.io.cell_config.poke(cell_config)

            dut.clock.step(1)
            dut.clock.step(1)
            dut.clock.step(1)
            cell_config = "b101110100000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000100000010000000010000000000011010011000000".U
            dut.io.cell_config.poke(cell_config)

            dut.clock.step(1)
            dut.clock.step(1)
            dut.clock.step(1)
            cell_config = "b101011100000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000100000010000000010000000000011010011000000".U
            dut.io.cell_config.poke(cell_config)

            dut.clock.step(1)
            dut.clock.step(1)
            dut.clock.step(1)
            cell_config = "b101000100000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000010000010010000010000000000011011101000000".U
            dut.io.cell_config.poke(cell_config)

            dut.clock.step(1)
            dut.clock.step(1)
            dut.clock.step(1)
            cell_config = "b100101100000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000100000000000100010000000000010010011000000".U
            dut.io.cell_config.poke(cell_config)

            dut.clock.step(1)
            dut.clock.step(1)
            dut.clock.step(1)
            cell_config = "b100010100000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000010000010000000010000000000011011100000000".U
            dut.io.cell_config.poke(cell_config)

            dut.clock.step(1)
            dut.clock.step(1)
            dut.clock.step(1)


            for (i <- 1 to 16) {
                val c4 = i.toString()
                val c5 = i.toString()
                val din = BigInt("00000001"  + "00000001" + "00000001"+ "00000000" + "00000000" + "00000001" ,16).S
                
                dut.io.data_in.poke(din)
                dut.io.data_in_valid.poke("b111000".U)
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
