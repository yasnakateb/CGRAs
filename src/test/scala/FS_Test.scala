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
        test(new FS(6)) { dut =>
            
            var ready_out = "b1010".U 
            var fork_mask = "b1010".U 
        
            dut.io.ready_out.poke(ready_out)
            dut.io.fork_mask.poke(fork_mask)
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
