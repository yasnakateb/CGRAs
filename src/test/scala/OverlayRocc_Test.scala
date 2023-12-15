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

class OverlayRocc_Test extends AnyFlatSpec with ChiselScalatestTester {
    "OverlayRocc_Test test" should "pass" in {
        test(new OverlayRocc(32, 6, 6, 32)) { dut =>
            // Data
            // var data_in = "h060504030201".U 
            var data_in_valid = "b000000".U 
            var data_out_ready = "b111111".U 
            dut.io.data_in_valid.poke(data_in_valid)
            dut.io.data_out_ready.poke(data_out_ready)
            dut.clock.step(1)

            
            data_in_valid = "b110000".U 
            data_out_ready = "b111111".U 
            dut.clock.step(1)
            // Config 
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
            /*dut.clock.step(3)

            dut.io.data_in_valid.poke("b000000".U)
            dut.clock.step(10)
            dut.io.data_in_valid.poke("b110000".U)
            dut.clock.step(1)
            dut.io.data_in_valid.poke("b000000".U)
            dut.clock.step(10)*/

            for (i <- 1 to 16) {
                val c4 = i.toString()
                val c5 = i.toString()
                //val din = BigInt(f"$i%08d" + f"$i%08d" + "00000000000000000000000000000000",16).S 
                //val din = BigInt(f"$i%08d" + "00000000" + "00000000000000000000000000000000",16).S
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



            /*

            // Inputs
            println("Inputs")
            println("data_in: " + dut.io.data_in.peek().toString)
            println("data_in_valid: " + dut.io.data_in_valid.peek().toString)
            println("data_out_ready: " + dut.io.data_out_ready.peek().toString)
            println("cell_config: " + dut.io.cell_config.peek().toString)
            // Outputs
            println("Outputs")
            println("data_in_ready: " + dut.io.data_in_ready.peek().toString)
            println("data_out: " + dut.io.data_out.peek().toString)
            println("data_out_valid: " + dut.io.data_out_valid.peek().toString)
            println("*************************************")
            println("*************************************")

            // data_in = "h090807060504".U   
            data_in = 222.S 
            data_in_valid = "b111111".U 
            data_out_ready = "b111111".U 
            // Config 
            cell_config = "b100010000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000100000000000000000100000000".U 

            dut.io.data_in.poke(data_in.asSInt)
            dut.io.data_in_valid.poke(data_in_valid)
            dut.io.data_out_ready.poke(data_out_ready)
            dut.io.cell_config.poke(cell_config)

            for( i <- 0 to 50){
                dut.clock.step(1)
            }
            println("Inputs")
            println("data_in: " + dut.io.data_in.peek().toString)
            println("data_in_valid: " + dut.io.data_in_valid.peek().toString)
            println("data_out_ready: " + dut.io.data_out_ready.peek().toString)
            println("cell_config: " + dut.io.cell_config.peek().toString)
            // Outputs
            println("Outputs")
            println("data_in_ready: " + dut.io.data_in_ready.peek().toString)
            println("data_out: " + dut.io.data_out.peek().toString)
            println("data_out_valid: " + dut.io.data_out_valid.peek().toString)
            println("*************************************")
            println("*************************************")

            //data_in = "h060504030201".U    
            data_in = -150.S   
            data_in_valid = "b111111".U 
            data_out_ready = "b111111".U 
            // Config 
            cell_config = "b100010000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000100000000000000000100000000".U 

            dut.io.data_in.poke(data_in.asSInt)
            dut.io.data_in_valid.poke(data_in_valid)
            dut.io.data_out_ready.poke(data_out_ready)
            dut.io.cell_config.poke(cell_config)

            for( i <- 0 to 50){
                dut.clock.step(1)
            }
            println("Inputs")
            println("data_in: " + dut.io.data_in.peek().toString)
            println("data_in_valid: " + dut.io.data_in_valid.peek().toString)
            println("data_out_ready: " + dut.io.data_out_ready.peek().toString)
            println("cell_config: " + dut.io.cell_config.peek().toString)
            // Outputs
            println("Outputs")
            println("data_in_ready: " + dut.io.data_in_ready.peek().toString)
            println("data_out: " + dut.io.data_out.peek().toString)
            println("data_out_valid: " + dut.io.data_out_valid.peek().toString)
            println("*************************************")
            println("*************************************")

            */

        }
    } 
}
