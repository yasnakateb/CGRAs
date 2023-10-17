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

class FIFO_Test extends AnyFlatSpec with ChiselScalatestTester {
    "FIFO_Test test" should "pass" in {
        test(new FIFO(32, 32)) { dut =>
            
            var wen = true.B 
            var ren = true.B 
            
            dut.io.ren.poke(ren)
            
            dut.clock.step(1)
            dut.io.din.poke(76.U)
            dut.io.wen.poke(wen)
            dut.clock.step(1)
            dut.io.din.poke(3.U)
            dut.clock.step(1)
            dut.io.din.poke(5.U)
            dut.clock.step(1)
            dut.io.din.poke(7.U)
            dut.clock.step(1)
            dut.io.din.poke(9.U)
            dut.clock.step(1)
            dut.io.din.poke(3.U)
            dut.clock.step(1)
            dut.io.din.poke(5.U)
            dut.clock.step(1)
            dut.io.din.poke(7.U)
            dut.clock.step(1)
            dut.io.din.poke(9.U)
            dut.clock.step(1)
            dut.io.din.poke(0.U)
            dut.clock.step(1)
            dut.io.din.poke(3.U)
            dut.clock.step(1)
            dut.io.din.poke(5.U)
            dut.clock.step(1)
            dut.io.din.poke(7.U)
            dut.clock.step(1)
            dut.io.din.poke(9.U)
            dut.clock.step(1)
            dut.io.din.poke(3.U)
            dut.clock.step(1)
            dut.io.din.poke(5.U)
            dut.clock.step(1)
            dut.io.din.poke(7.U)
            dut.clock.step(1)
            dut.io.din.poke(9.U)
            dut.clock.step(1)
            dut.io.din.poke(0.U)
            dut.clock.step(1)
            dut.io.din.poke(3.U)
            dut.clock.step(1)
            dut.io.din.poke(5.U)
            dut.clock.step(1)
            dut.io.din.poke(7.U)
            dut.clock.step(1)
            dut.io.din.poke(9.U)
            dut.clock.step(1)
            dut.io.din.poke(3.U)
            dut.clock.step(1)
            dut.io.din.poke(5.U)
            dut.clock.step(1)
            dut.io.din.poke(7.U)
            dut.clock.step(1)
            dut.io.din.poke(9.U)
            dut.clock.step(1)
            dut.io.din.poke(0.U)
            dut.clock.step(1)
            dut.io.din.poke(3.U)
            dut.clock.step(1)
            dut.io.din.poke(5.U)
            dut.clock.step(1)
            dut.io.din.poke(7.U)
            dut.clock.step(1)
            dut.io.din.poke(9.U)
            dut.clock.step(1)
            dut.io.din.poke(3.U)
            dut.clock.step(1)
            dut.io.din.poke(5.U)
            dut.clock.step(1)
            dut.io.din.poke(7.U)
            dut.clock.step(1)
            dut.io.din.poke(9.U)
            dut.clock.step(1)
            dut.io.din.poke(0.U)
            dut.io.wen.poke(false.B)
            
            dut.clock.step(1)
            dut.clock.step(1)
            dut.clock.step(1)
            dut.clock.step(1)
            dut.clock.step(1)
            dut.clock.step(1)
            dut.clock.step(1)
            dut.clock.step(1)
            dut.clock.step(1)
            dut.clock.step(1)
            dut.clock.step(1)
            dut.clock.step(1)
        }
    } 
}
