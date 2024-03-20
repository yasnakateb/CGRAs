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
import chisel3.util._
import org.scalatest.flatspec.AnyFlatSpec
import scala.io.Source

class OverlayRoccTestMAC2 extends AnyFlatSpec with ChiselScalatestTester {
  "OverlayRoccTestMAC2 test" should "pass" in {
    test(new OverlayRocc(32, 6, 6, 32)).withAnnotations(Seq(VerilatorBackendAnnotation, WriteVcdAnnotation)) { dut =>
      ///////////////////////////////////////////
      // MAC2
      ///////////////////////////////////////////
      
      var dataInValid = "b000000".U 
      var dataOutReady = "b111111".U 
      dut.io.dataInValid.poke(dataInValid)
      dut.io.dataOutReady.poke(dataOutReady)
      dut.clock.step(1)

      var cellConfig: UInt = 0.U 
      
      val source = Source.fromFile("src/test/scala/Bitstreams/mac2.txt")
      for (line <- source.getLines()){  
        cellConfig = ("b" + line).U  
        dut.io.cellConfig.poke(cellConfig)
        dut.clock.step(1)
        dut.clock.step(1)
        dut.clock.step(1)
      }
      source.close()
    
      ///////////////////////////////////////////
      // Test 1: x = Σ 1 (n = 4) + 3
      //         y = Σ 2 (n = 4) + 3
      ///////////////////////////////////////////
      /*
      for (i <- 1 to 16) {
          // ------------------------------------------------------------------------------------------------
          // |                 |    C5     |    C4      |      C3   |     C2     |     C1     |      C0     |
          // ------------------------------------------------------------------------------------------------
          // ------------------------------------------------------------------------------------------------
          // |                 |    y      |     x      |      d    |     c      |     a       |      b     |
          // ------------------------------------------------------------------------------------------------
          val din = BigInt("00000003" + "00000003" + "00000001"+ "00000001" + "00000001" + "00000001" ,16).S
              
          dut.io.dataIn.poke(din)
          dut.io.dataInValid.poke("b111111".U)
          dut.clock.step(1)
          dut.io.dataInValid.poke("b000000".U)
          dut.clock.step(10)
      }
      */

      ///////////////////////////////////////////
      // Test 2: x = Σ 8 (n = 5) + 3
      //         y = Σ 20i (n = 5) + 4
      ///////////////////////////////////////////
      
      for (i <- 1 to 16) {
          // ------------------------------------------------------------------------------------------------
          // |                 |    C5     |    C4      |      C3   |     C2     |     C1     |      C0     |
          // ------------------------------------------------------------------------------------------------
          // ------------------------------------------------------------------------------------------------
          // |                 |    y      |     x      |      d    |     c      |     a       |      b     |
          // ------------------------------------------------------------------------------------------------
          val din = BigInt("00000004" + "00000003" + (i).formatted("%08X") + "00000002" + "00000002" + "00000004" ,16).S
              
          dut.io.dataIn.poke(din)
          dut.io.dataInValid.poke("b111111".U)
          dut.clock.step(1)
          dut.io.dataInValid.poke("b000000".U)
          dut.clock.step(10)
      }

      // Finish 
      for( i <- 0 to 10){
          dut.clock.step(1)
      } 
      println("End of the simulation")         
    }
  } 
}
