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

class Fr_Test extends AnyFlatSpec with ChiselScalatestTester {
    "Fr_Test test" should "pass" in {
        test(new Fr(5,5)) { dut =>
            
            var validIn = "b11011".U 
            var readyOut = "b11011".U 
            var validMuxSel = "b10".U 
            var forkMask = "b11011".U 
        
            dut.io.validIn.poke(validIn)
            dut.io.readyOut.poke(readyOut)
            dut.io.validMuxSel.poke(validMuxSel)
            dut.io.forkMask.poke(forkMask)
            println("*************************************")
            println("*************************************")
            println("Valid In: " + dut.io.validIn.peek().toString)
            println("Ready Out: " + dut.io.readyOut.peek().toString)
            println("Valid Mux Sel: " + dut.io.validMuxSel.peek().toString)
            println("Fork Mask: " + dut.io.forkMask.peek().toString)
            dut.clock.step(1)
            println("--------------------------------------")
            println("Valid Out: " + dut.io.validOut.peek().toString)
            validMuxSel = "b1".U 
            dut.io.validMuxSel.poke(validMuxSel)
            println("*************************************")
            println("*************************************")
            println("Valid In: " + dut.io.validIn.peek().toString)
            println("Ready Out: " + dut.io.readyOut.peek().toString)
            println("Valid Mux Sel: " + dut.io.validMuxSel.peek().toString)
            println("Fork Mask: " + dut.io.forkMask.peek().toString)
            dut.clock.step(1)
            println("--------------------------------------")
            println("Valid Out: " + dut.io.validOut.peek().toString)
            println("*************************************")
            println("*************************************")
        }
    } 
}
