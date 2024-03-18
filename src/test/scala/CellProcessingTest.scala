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

class CellProcessingTest extends AnyFlatSpec with ChiselScalatestTester {
  "CellProcessingTest test" should "pass" in {
    test(new CellProcessing(32)) { dut =>
      var northDin = 1.S 
      var northDinValid = true.B 
      var eastDin = 0.S  
      var eastDinValid = false.B 

      var southDin = 0.S 
      var southDinValid = false.B 
      var westDin = 2.S  
      var westDinValid = true.B 

      var northDoutReady = true.B 
      var eastDoutReady = true.B 
      var southDoutReady = true.B 
      var westDoutReady = true.B 
      
      println("*************************************")
      println("Test 1: Summation")
      println("*************************************")
      var configBits = "b00000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000001000000000010000000000000001000000000000000000000000011".U 
      
      dut.io.configBits.poke(configBits)
      dut.io.northDoutReady.poke(northDoutReady)
      dut.io.eastDoutReady.poke(eastDoutReady)

      dut.io.southDoutReady.poke(southDoutReady)
      dut.io.westDoutReady.poke(westDoutReady)
      dut.clock.step(1)
      dut.clock.step(1)

      dut.io.eastDin.poke(eastDin)
      dut.io.eastDinValid.poke(eastDinValid)

      dut.io.southDin.poke(southDin)
      dut.io.southDinValid.poke(southDinValid)

      println("*************************************")
      println("*************************************")
      dut.clock.step(1)
      dut.io.northDin.poke(northDin)
      dut.io.northDinValid.poke(northDinValid)
      dut.io.westDin.poke(westDin)
      dut.io.westDinValid.poke(westDinValid)
      dut.clock.step(1)

      dut.io.northDin.poke(3.S)
      dut.io.westDin.poke(4.S)

      dut.clock.step(1)

      dut.io.northDin.poke(5.S)
      dut.io.westDin.poke(6.S)

      dut.clock.step(1)

      dut.io.northDin.poke(7.S)
      dut.io.westDin.poke(8.S)

      dut.clock.step(1)
  
      dut.io.northDin.poke(0.S)
      dut.io.northDinValid.poke(false.B)

      dut.io.westDin.poke(0.S)
      dut.io.westDinValid.poke(false.B)

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
      dut.clock.step(1)
      dut.clock.step(1)
      dut.clock.step(1)

      // Outputs
      println("Outputs")
      println("fuDin1Ready: " + dut.io.fuDin1Ready.peek().toString)
      println("fuDin2Ready: " + dut.io.fuDin2Ready.peek().toString)
      println("dout: " + dut.io.dout.peek().toString)
      println("doutValid: " + dut.io.doutValid.peek().toString)
      println("*************************************")
      println("*************************************")
    }
  } 
}
