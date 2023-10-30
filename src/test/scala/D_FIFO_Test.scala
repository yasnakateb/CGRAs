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

class D_FIFO_Test extends AnyFlatSpec with ChiselScalatestTester {
    "D_FIFO_Test test" should "pass" in {
        test(new D_FIFO(32, 32)) { dut =>
            
            var din_v = true.B 
            var dout_r = true.B 
            
            dut.io.dout_r.poke(dout_r)
            dut.clock.step(1)
            dut.io.din.poke(1.S)
            dut.io.din_v.poke(din_v)
            dut.clock.step(1)
            dut.io.din.poke(55.S)
            dut.clock.step(1)
            dut.io.din.poke(3.S)
            dut.clock.step(1)
            dut.io.din.poke(4.S)
            dut.clock.step(1)
            dut.io.din.poke(5.S)
            dut.clock.step(1)
            dut.io.din.poke(6.S)
            dut.clock.step(1)
            dut.io.din.poke(7.S)
            dut.clock.step(1)
            dut.io.din.poke(8.S)
            dut.clock.step(1)
            dut.io.din.poke(9.S)
            dut.clock.step(1)
            dut.io.din.poke(10.S)
            dut.clock.step(1)
            dut.io.din.poke(11.S)
            dut.clock.step(1)
            dut.io.din.poke(12.S)
            dut.clock.step(1)
            dut.io.din.poke(13.S)
            dut.clock.step(1)
            dut.io.din.poke(14.S)
            dut.clock.step(1)
            dut.io.din.poke(15.S)
            dut.clock.step(1)
            dut.io.din.poke(16.S)
            dut.clock.step(1)
            dut.io.din.poke(17.S)
            dut.clock.step(1)
            dut.io.din.poke(18.S)
            dut.clock.step(1)
            dut.io.din.poke(19.S)
            dut.clock.step(1)
            dut.io.din.poke(20.S)
            dut.clock.step(1)
            dut.io.din.poke(21.S)
            dut.clock.step(1)
            dut.io.din.poke(22.S)
            dut.clock.step(1)
            dut.io.din.poke(23.S)
            dut.clock.step(1)
            dut.io.din.poke(24.S)
            dut.clock.step(1)
            dut.io.din.poke(25.S)
            dut.clock.step(1)
            dut.io.din.poke(26.S)
            dut.clock.step(1)
            dut.io.din.poke(27.S)
            dut.clock.step(1)
            dut.io.din.poke(28.S)
            dut.clock.step(1)
            dut.io.din.poke(29.S)
            dut.clock.step(1)
            dut.io.din.poke(31.S)
            dut.clock.step(1)
            dut.io.din.poke(32.S)
            dut.clock.step(1)
            dut.io.din.poke(33.S)
            dut.clock.step(1)
            dut.io.din.poke(34.S)
            dut.clock.step(1)
            dut.io.din.poke(0.S)
            dut.io.din_v.poke(false.B)
            dut.clock.step(1)
            dut.clock.step(1)
        }
    } 
}
