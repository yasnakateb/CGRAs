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

class OverlayRocc_Test_CAP extends AnyFlatSpec with ChiselScalatestTester {
    "OverlayRocc_CAP test" should "pass" in {
        test(new OverlayRocc(32, 6, 6, 32)) { dut =>
            
            ///////////////////////////////////////////
            // CAP
            ///////////////////////////////////////////

            var data_in_valid = "b000000".U 
            var data_out_ready = "b111111".U 
            dut.io.data_in_valid.poke(data_in_valid)
            dut.io.data_out_ready.poke(data_out_ready)
            dut.clock.step(1)

            var cell_config = "b100000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000100000000000000000100000000".U  
            dut.io.cell_config.poke(cell_config)

            dut.clock.step(1)
            dut.clock.step(1)
            dut.clock.step(1)

            cell_config = "b100000100000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000010000000000000000000000000000001100000000".U 
            dut.io.cell_config.poke(cell_config)

            dut.clock.step(1)
            dut.clock.step(1)
            dut.clock.step(1)
            cell_config = "b101101000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000001000000000000000000000000000010000000001100000000000000010000000000000000000000100000".U 
            dut.io.cell_config.poke(cell_config)

            dut.clock.step(1)
            dut.clock.step(1)
            dut.clock.step(1)
            cell_config = "b101010000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000001000000000100000100000001001000000000000000100000000010".U 
            dut.io.cell_config.poke(cell_config)

            dut.clock.step(1)
            dut.clock.step(1)
            dut.clock.step(1)

            cell_config = "b100111000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000010000000000000000000000000000000100000010000000000000000010000000000000000000000100000".U 
            dut.io.cell_config.poke(cell_config)

            dut.clock.step(1)
            dut.clock.step(1)
            dut.clock.step(1)

            cell_config = "b100100000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000110000000000000000000000000000000100000000100000000001000000100000000000000000100100001".U 
            dut.io.cell_config.poke(cell_config)

            dut.clock.step(1)
            dut.clock.step(1)
            dut.clock.step(1)

            cell_config = "b100001000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000100001000000000000000000000011000000000000000000000000000111100000000".U 
            dut.io.cell_config.poke(cell_config)

            dut.clock.step(1)
            dut.clock.step(1)
            dut.clock.step(1)

            cell_config = "b101010100000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000010000000000100000000000000010001100000000".U 
            dut.io.cell_config.poke(cell_config)

            dut.clock.step(1)
            dut.clock.step(1)
            dut.clock.step(1)

            cell_config = "b100100100000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000010000000000000001000000000001001100000000".U 
            dut.io.cell_config.poke(cell_config)

            dut.clock.step(1)
            dut.clock.step(1)
            dut.clock.step(1)

            cell_config = "b100001100000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000001000000000000000000000000000110000000000".U 
            dut.io.cell_config.poke(cell_config)

            dut.clock.step(1)
            dut.clock.step(1)
            dut.clock.step(1)

            cell_config = "b101011000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000010000000000000001000000000001001100000000".U 
            dut.io.cell_config.poke(cell_config)

            dut.clock.step(1)
            dut.clock.step(1)
            dut.clock.step(1)

            cell_config = "b101000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000010000000000000010000000000".U 
            dut.io.cell_config.poke(cell_config)

            dut.clock.step(1)
            dut.clock.step(1)
            dut.clock.step(1)

            cell_config = "b100101000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000100001000000000000000000000011000000000000000000000000000111100000000".U 
            dut.io.cell_config.poke(cell_config)

            dut.clock.step(1)
            dut.clock.step(1)
            dut.clock.step(1)

            cell_config = "b101011100000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000001000000000110000000000000001000000000000000000000000011".U  
            dut.io.cell_config.poke(cell_config)

            dut.clock.step(1)
            dut.clock.step(1)
            dut.clock.step(1)

            cell_config = "b101000100000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000010000000000000000000000000000000100000010000000000000000010000000000000000000000100000".U  
            dut.io.cell_config.poke(cell_config)

            dut.clock.step(1)
            dut.clock.step(1)
            dut.clock.step(1)

            cell_config = "b100101100000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000011000000000000000000000000000010000000000110000000000000000010000000000000010000100011".U 
            dut.io.cell_config.poke(cell_config)

            dut.clock.step(1)
            dut.clock.step(1)
            dut.clock.step(1)

            cell_config = "b100010100000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000100000000100000100000000001000000000000000000000000010".U 
            dut.io.cell_config.poke(cell_config)

            dut.clock.step(1)
            dut.clock.step(1)
            dut.clock.step(1)



            var din = BigInt("00000001"  + "00000000000000000000000000000000" + "00000002"  ,16).S    
            dut.io.data_in.poke(din)
            dut.io.data_in_valid.poke("b100001".U)
            dut.clock.step(1)
            dut.io.data_in_valid.poke("b000000".U)
            dut.clock.step(10)

            din = BigInt("00000002"  + "00000000000000000000000000000000" + "00000004"  ,16).S    
            dut.io.data_in.poke(din)
            dut.io.data_in_valid.poke("b100001".U)
            dut.clock.step(1)
            dut.io.data_in_valid.poke("b000000".U)
            dut.clock.step(10)


            din = BigInt("00000003"  + "00000000000000000000000000000000" + "00000008"  ,16).S    
            dut.io.data_in.poke(din)
            dut.io.data_in_valid.poke("b100001".U)
            dut.clock.step(1)
            dut.io.data_in_valid.poke("b000000".U)
            dut.clock.step(10)


            din = BigInt("00000004"  + "00000000000000000000000000000000" + "00000010"  ,16).S    
            dut.io.data_in.poke(din)
            dut.io.data_in_valid.poke("b100001".U)
            dut.clock.step(1)
            dut.io.data_in_valid.poke("b000000".U)
            dut.clock.step(10)

            din = BigInt("00000005"  + "00000000000000000000000000000000" + "00000020"  ,16).S    
            dut.io.data_in.poke(din)
            dut.io.data_in_valid.poke("b100001".U)
            dut.clock.step(1)
            dut.io.data_in_valid.poke("b000000".U)
            dut.clock.step(10)


            for (i <- 1 to 16) {
                val c4 = i.toString()
                val c5 = i.toString()
                // ------------------------------------------------------------------------------------------------
                // |                 |    C5     |    C4      |      C3   |     C2     |     C1     |      C0     |
                // ------------------------------------------------------------------------------------------------
                din = BigInt(f"$i%08X"  + "00000000000000000000000000000000" + "00000020"  ,16).S   
                dut.io.data_in.poke(din)
                dut.io.data_in_valid.poke("b100001".U)
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
