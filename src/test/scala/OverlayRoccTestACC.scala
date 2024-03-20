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

class OverlayRoccTestACC extends AnyFlatSpec with ChiselScalatestTester {
  "OverlayRoccTestACC test" should "pass" in {
    test(new OverlayRocc(32, 6, 6, 32)).withAnnotations(Seq(VerilatorBackendAnnotation, WriteVcdAnnotation)) { dut =>
      ///////////////////////////////////////////
      // Accumulate
      ///////////////////////////////////////////
      
      var dataInValid = "b000000".U 
      var dataOutReady = "b111111".U 
      dut.io.dataInValid.poke(dataInValid)
      dut.io.dataOutReady.poke(dataOutReady)
      dut.clock.step(1)

      var cellConfig: UInt = 0.U 
      
      val source = Source.fromFile("src/test/scala/Bitstreams/acc.txt")
      for (line <- source.getLines()){  
        cellConfig = ("b" + line).U  
        dut.io.cellConfig.poke(cellConfig)
        dut.clock.step(1)
        dut.clock.step(1)
        dut.clock.step(1)
      }
      source.close()
  
      ///////////////////////////////////////////
      // Test 1: c = 2i 
      //         x = Σc (n = 4) + 1
      ///////////////////////////////////////////
      /*
      val din1 = BigInt("00000000"  + "00000001" + "00000002"+ "00000000" + "00000000" + "00000000" ,16).S
      dut.io.dataIn.poke(din1)
      dut.io.dataInValid.poke("b011000".U)
      dut.clock.step(30)
      dut.io.dataInValid.poke("b000000".U)
      

      for (i <- 1 to 16) {
      // ------------------------------------------------------------------------------------------------
      // |                 |    C5     |    C4      |      C3   |     C2     |     C1     |      C0     |
      // ------------------------------------------------------------------------------------------------
      // ------------------------------------------------------------------------------------------------
      // |                 |    a      |     x      |      c    |     -      |     -       |      b     |
      // ------------------------------------------------------------------------------------------------
        val din2 = BigInt("00000000"  + "00000000" + "00000000"+ "00000000" + "00000000" + f"$i%08X" ,16).S
        dut.io.dataIn.poke(din2)
        dut.io.dataInValid.poke("b100001".U)
        dut.clock.step(1)
        dut.io.dataInValid.poke("b000000".U)
        dut.clock.step(10)
      }
      */

      ///////////////////////////////////////////
      // Test 2: c = 2(i+1) 
      //         x = Σc (n = 5) + 2 
      ///////////////////////////////////////////
      
      val din1 = BigInt("00000000"  + "00000002" + "00000002"+ "00000000" + "00000000" + "00000000" ,16).S
      dut.io.dataIn.poke(din1)
      dut.io.dataInValid.poke("b011000".U)
      dut.clock.step(30)
      dut.io.dataInValid.poke("b000000".U)
      

      for (i <- 1 to 16) {
      // ------------------------------------------------------------------------------------------------
      // |                 |    C5     |    C4      |      C3   |     C2     |     C1     |      C0     |
      // ------------------------------------------------------------------------------------------------
      // ------------------------------------------------------------------------------------------------
      // |                 |    a      |     x      |      c    |     -      |     -       |      b     |
      // ------------------------------------------------------------------------------------------------
        val din2 = BigInt((i).formatted("%08X")  + "00000000" + "00000000"+ "00000000" + "00000000" + "00000001" ,16).S
        dut.io.dataIn.poke(din2)
        dut.io.dataInValid.poke("b100001".U)
        dut.clock.step(1)
        dut.io.dataInValid.poke("b000000".U)
        dut.clock.step(10)
      }
  
      // Finish 
      for( i <- 0 to 150){
        dut.clock.step(1)
      } 
      println("End of the simulation")       
    }
  } 
}