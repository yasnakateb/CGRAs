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

class AluTest extends AnyFlatSpec with ChiselScalatestTester {
  "AluTest test" should "pass" in {
      test(new Alu(32, 4)) { dut =>

        var numOfTests = 10
        
        ////////////////////////////////////////////////////////////////
        // Test 1: SUM
        ////////////////////////////////////////////////////////////////
        dut.io.opConfig.poke(0.U)

        // Pos
        for (i <- 1 until numOfTests) {
          dut.io.din1.poke(i.S)
          dut.io.din2.poke((i+1).S)
          dut.clock.step(1)
        }
        // Neg 
        for (i <- 1 until numOfTests) {
          dut.io.din1.poke((-i).S)
          dut.io.din2.poke((-(i+1)).S)
          dut.clock.step(1)
        }
        ////////////////////////////////////////////////////////////////
        // Test 2: MUL 
        ////////////////////////////////////////////////////////////////
        dut.io.opConfig.poke(1.U)

        dut.io.din1.poke(5.S)
        dut.io.din2.poke(100.S)
        dut.clock.step(1)
        dut.io.din1.poke(-5.S)
        dut.io.din2.poke(100.S)
        dut.clock.step(1)
        dut.io.din1.poke(-5.S)
        dut.io.din2.poke(-100.S)
        dut.clock.step(1)
        dut.io.din1.poke(65535.S)
        dut.io.din2.poke(65535.S)
        dut.clock.step(1)
        dut.io.din1.poke(65535.S)
        dut.io.din2.poke(65536.S)
        dut.clock.step(1)
        dut.io.din1.poke(65535.S)
        dut.io.din2.poke(65537.S)
        dut.clock.step(1)
        dut.io.din1.poke(65537.S)
        dut.io.din2.poke(65547.S)
        dut.clock.step(1)
        ////////////////////////////////////////////////////////////////
        // Test 3: SUB 
        ////////////////////////////////////////////////////////////////
        dut.io.opConfig.poke(2.U)

        for (i <- 1 until numOfTests) {
          dut.io.din1.poke((i+2).S)
          dut.io.din2.poke((i).S)
          dut.clock.step(1)
        }

        for (i <- 1 until numOfTests) {
          dut.io.din1.poke((-i).S)
          dut.io.din2.poke((-(i+1)).S)
          dut.clock.step(1)
        }
        ////////////////////////////////////////////////////////////////
        // Test 4: SLL 
        ////////////////////////////////////////////////////////////////
        dut.io.opConfig.poke(3.U)

        dut.io.din1.poke(1.S)
        for (i <- 1 until numOfTests) {
          dut.io.din2.poke(i.S)
          dut.clock.step(1)
        }

        dut.io.din1.poke(-1.S)
        for (i <- 1 until numOfTests) {
          dut.io.din2.poke(i.S)
          dut.clock.step(1)
        }
        ////////////////////////////////////////////////////////////////
        // Test 5: SRA
        ////////////////////////////////////////////////////////////////
        dut.io.opConfig.poke(4.U)

        dut.io.din2.poke(1.S)
        for (i <- 1 until numOfTests) {
          dut.io.din1.poke(((i*2)).S)
          dut.clock.step(1)
        }
        dut.io.din2.poke(2.S)
        for (i <- 1 until numOfTests) {
          dut.io.din1.poke((-(i*2)).S)
          dut.clock.step(1)
        }
        ////////////////////////////////////////////////////////////////
        // Test 6: SRL 
        ////////////////////////////////////////////////////////////////
        dut.io.opConfig.poke(5.U)

        for (i <- 1 until numOfTests) {
          dut.io.din1.poke((i*2).S)
          dut.io.din2.poke(i.S)
          dut.clock.step(1)
        }

        for (i <- 1 until numOfTests) {
          dut.io.din1.poke((-(i*2)).S)
          dut.io.din2.poke(i.S)
          dut.clock.step(1)
        }
        ////////////////////////////////////////////////////////////////
        // Test 7: AND 
        ////////////////////////////////////////////////////////////////
        dut.io.opConfig.poke(6.U)

        for (i <- 1 until numOfTests) {
          dut.io.din1.poke(i.S)
          dut.io.din2.poke((i+1).S)
          dut.clock.step(1)
        }
        ////////////////////////////////////////////////////////////////
        // Test 8: OR 
        ////////////////////////////////////////////////////////////////
        dut.io.opConfig.poke(7.U)

        for (i <- 1 until numOfTests) {
          dut.io.din1.poke(i.S)
          dut.io.din2.poke((i+1).S)
          dut.clock.step(1)
        }
        ////////////////////////////////////////////////////////////////
        // Test 9: XOR 
        ////////////////////////////////////////////////////////////////
        dut.io.opConfig.poke(8.U)

        for (i <- 1 until numOfTests) {
          dut.io.din1.poke(i.S)
          dut.io.din2.poke((i+1).S)
          dut.clock.step(1)
        } 
    }
  } 
}