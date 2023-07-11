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

class FR_Test extends AnyFlatSpec with ChiselScalatestTester {
    "FR_Test test" should "pass" in {
        test(new FR(6,4)) { dut =>
            
            var valid_in = "b101010".U 
            var ready_out = "b1010".U 
            var valid_mux_sel = "b10".U 
            var fork_mask = "b1010".U 
        
            dut.io.valid_in.poke(valid_in)
            dut.io.ready_out.poke(ready_out)
            dut.io.valid_mux_sel.poke(valid_mux_sel)
            dut.io.fork_mask.poke(fork_mask)
            println("*************************************")
            println("*************************************")
            println("Valid In: " + dut.io.valid_in.peek().toString)
            println("Ready Out: " + dut.io.ready_out.peek().toString)
            println("Valid Mux Sel: " + dut.io.valid_mux_sel.peek().toString)
            println("Fork Mask: " + dut.io.fork_mask.peek().toString)
            dut.clock.step(1)
            println("--------------------------------------")
            println("Valid Out: " + dut.io.valid_out.peek().toString)
            valid_mux_sel = "b1".U 
            dut.io.valid_mux_sel.poke(valid_mux_sel)
            println("*************************************")
            println("*************************************")
            println("Valid In: " + dut.io.valid_in.peek().toString)
            println("Ready Out: " + dut.io.ready_out.peek().toString)
            println("Valid Mux Sel: " + dut.io.valid_mux_sel.peek().toString)
            println("Fork Mask: " + dut.io.fork_mask.peek().toString)
            dut.clock.step(1)
            println("--------------------------------------")
            println("Valid Out: " + dut.io.valid_out.peek().toString)
            println("*************************************")
            println("*************************************")
        }
    } 
}
