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

class Conf_Mux_Test extends AnyFlatSpec with ChiselScalatestTester {
  "Conf_Mux_Test test" should "pass" in {
    test(new Conf_Mux(2,2)) { dut =>
      // muxInput: 1011, selector: 1 ==> Mux Output: 10
      var selector = 1
      var muxInput = 11
      dut.io.selector.poke(selector.U)
      dut.io.muxInput.poke(muxInput.S)
      dut.clock.step(1)
      println("*************************************")
      println("Mux Input: " + dut.io.muxInput.peek().toString)
      println("Mux Selector: " + dut.io.selector.peek().toString)
      println("Mux Output: " + dut.io.muxOutput.peek().toString)
      println("*************************************")   
      dut.clock.step(1)
      selector = 2
      muxInput = 53
      dut.io.selector.poke(selector.U)
      dut.io.muxInput.poke(muxInput.S)
      dut.clock.step(1)
      println("Mux Input: " + dut.io.muxInput.peek().toString)
      println("Mux Selector: " + dut.io.selector.peek().toString)
      println("Mux Output: " + dut.io.muxOutput.peek().toString)
      println("*************************************")   
      dut.clock.step(1)
    }
  } 
}