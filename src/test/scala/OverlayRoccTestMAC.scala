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

class OverlayRoccTestMAC extends AnyFlatSpec with ChiselScalatestTester {
  "OverlayRoccTestMAC test" should "pass" in {
    test(new OverlayRocc(32, 6, 6, 32)).withAnnotations(Seq(VerilatorBackendAnnotation, WriteVcdAnnotation)) { dut =>  
      ///////////////////////////////////////////
      // MAC
      ///////////////////////////////////////////

      var dataInValid = "b000000".U 
      var dataOutReady = "b111111".U 
      dut.io.dataInValid.poke(dataInValid)
      dut.io.dataOutReady.poke(dataOutReady)
      dut.clock.step(1)

      var cellConfig: UInt = 0.U 
     
      val source = Source.fromFile("src/test/scala/Bitstreams/mac.txt")
      for (line <- source.getLines()){
          
          cellConfig = ("b" + line).U  
          dut.io.cellConfig.poke(cellConfig)
          dut.clock.step(1)
          dut.clock.step(1)
          dut.clock.step(1)
      }
      source.close()
      
      ///////////////////////////////////////////
      // Test 1: a = 2
      //         b = i
      //         x = Σc (n = 4) + 0
      ///////////////////////////////////////////
      /*
      for (i <- 1 to 101) {
          val c4 = i.toString()
          val c5 = i.toString()
          
          val din = BigInt("00000000"  + f"$i%08X" + "00000002"+ "00000000" + "00000000" + "00000000" ,16).S
          
          dut.io.dataIn.poke(din)
          dut.io.dataInValid.poke("b111000".U)
          dut.clock.step(1)
          dut.io.dataInValid.poke("b000000".U)
          dut.clock.step(10)
      }
      */
      ///////////////////////////////////////////
      // Test 2: a = i
      //         b = i
      //         x = Σc (n = 5) + 3
      ///////////////////////////////////////////

      for (i <- 1 to 101) {
          // ------------------------------------------------------------------------------------------------
          // |                 |    C5     |    C4      |      C3   |     C2     |     C1     |      C0     |
          // ------------------------------------------------------------------------------------------------
          // ------------------------------------------------------------------------------------------------
          // |                 |    x      |    b       |      a    |     -      |     -      |      -      |
          // ------------------------------------------------------------------------------------------------
          val din = BigInt("00000003" + (i).formatted("%08X")  + (i).formatted("%08X") + "00000000" + "00000000" + "00000000" ,16).S
          dut.io.dataIn.poke(din)
          dut.io.dataInValid.poke("b111000".U)
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
