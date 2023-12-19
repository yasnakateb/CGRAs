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

class FS_Test extends AnyFlatSpec with ChiselScalatestTester {
    "FS_Test test" should "pass" in {
        test(new FS(5)) { dut =>
            
            dut.io.ready_out.poke("b00000".U)
            dut.io.fork_mask.poke("b00000".U)

            dut.clock.step(5)
        
            dut.io.ready_out.poke("b11111".U)
            dut.io.fork_mask.poke("b11000".U)


            dut.clock.step(1)
            println("*************************************")
            println("*************************************")
            println("Ready Out: " + dut.io.ready_out.peek().toString)
            println("Fork Mask: " + dut.io.fork_mask.peek().toString)
            dut.clock.step(1)
            println("--------------------------------------")
            println("Ready In: " + dut.io.ready_in.peek().toString)
            println("*************************************")
            println("*************************************")
        }
    } 
}
