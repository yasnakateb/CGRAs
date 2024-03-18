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

class FsTest extends AnyFlatSpec with ChiselScalatestTester {
    "FsTest test" should "pass" in {
        test(new Fs(5)) { dut =>
            
            dut.io.readyOut.poke("b00000".U)
            dut.io.forkMask.poke("b00000".U)

            dut.clock.step(5)
        
            dut.io.readyOut.poke("b11111".U)
            dut.io.forkMask.poke("b11000".U)

            dut.clock.step(1)
            println("*************************************")
            println("*************************************")
            println("Ready Out: " + dut.io.readyOut.peek().toString)
            println("Fork Mask: " + dut.io.forkMask.peek().toString)
            dut.clock.step(1)
            println("--------------------------------------")
            println("Ready In: " + dut.io.readyIn.peek().toString)
            println("*************************************")
            println("*************************************")
        }
    } 
}
