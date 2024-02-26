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

class Overlay_Rocc_Test_MAC2 extends AnyFlatSpec with ChiselScalatestTester {
  "Overlay_Rocc_Test_MAC2 test" should "pass" in {
    test(new Overlay_Rocc(32, 6, 6, 32)).withAnnotations(Seq(VerilatorBackendAnnotation, WriteVcdAnnotation)) { dut =>
      ///////////////////////////////////////////
      // MAC2
      ///////////////////////////////////////////
      
      var dataInValid = "b000000".U 
      var dataOutReady = "b111111".U 
      dut.io.dataInValid.poke(dataInValid)
      dut.io.dataOutReady.poke(dataOutReady)
      dut.clock.step(1)

      var cellConfig: UInt = 0.U 
      /*
      // Note: Original 
      val source = Source.fromFile("src/test/scala/Bitstreams/mac2.txt")
      for (line <- source.getLines()){  
        cellConfig = ("b" + line).U  
        dut.io.cellConfig.poke(cellConfig)
        dut.clock.step(1)
        dut.clock.step(1)
        dut.clock.step(1)
      }
      source.close()
      */

      cellConfig = "b100011000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000100000000000000000100000000".U
      dut.io.cellConfig.poke(cellConfig)
      dut.clock.step(1)
      dut.clock.step(1)
      dut.clock.step(1)
      cellConfig = "b100000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000010000000000000010000000000".U
      dut.io.cellConfig.poke(cellConfig)
      dut.clock.step(1)
      dut.clock.step(1)
      dut.clock.step(1)
      cellConfig = "b100110100000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000100000000000000000100000000".U
      dut.io.cellConfig.poke(cellConfig)
      dut.clock.step(1)
      dut.clock.step(1)
      dut.clock.step(1)
      cellConfig = "b100011100000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000100001000000000000000000000011000000000000000000000000000111100000000".U
      dut.io.cellConfig.poke(cellConfig)
      dut.clock.step(1)
      dut.clock.step(1)
      dut.clock.step(1)
      cellConfig = "b100000100000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000100000000000000000100000000".U
      dut.io.cellConfig.poke(cellConfig)
      dut.clock.step(1)
      dut.clock.step(1)
      dut.clock.step(1)
      cellConfig = "b101101000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000100000000000000000100000000".U
      dut.io.cellConfig.poke(cellConfig)
      dut.clock.step(1)
      dut.clock.step(1)
      dut.clock.step(1)
      cellConfig = "b101010000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000010000000000000010000000000".U
      dut.io.cellConfig.poke(cellConfig)
      dut.clock.step(1)
      dut.clock.step(1)
      dut.clock.step(1)
      cellConfig = "b100111000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000001000000000000000000000000000001000000000010000000000000000010000000000000010000100011".U
      dut.io.cellConfig.poke(cellConfig)
      dut.clock.step(1)
      dut.clock.step(1)
      dut.clock.step(1)
      cellConfig = "b100100000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000010000000000000010000000000100010000001000001010001000000000011100000001".U
      dut.io.cellConfig.poke(cellConfig)
      dut.clock.step(1)
      dut.clock.step(1)
      dut.clock.step(1)
      cellConfig = "b100001000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000001000000000100001100000000001000000000000000110000000010".U
      dut.io.cellConfig.poke(cellConfig)
      dut.clock.step(1)
      dut.clock.step(1)
      dut.clock.step(1)
      cellConfig = "b101101100000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000010000000000000000000000000000001100000000".U
      dut.io.cellConfig.poke(cellConfig)
      dut.clock.step(1)
      dut.clock.step(1)
      dut.clock.step(1)
      cellConfig = "b100111100000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000100000000000000100000000000000000111000000".U
      dut.io.cellConfig.poke(cellConfig)
      dut.clock.step(1)
      dut.clock.step(1)
      dut.clock.step(1)
      cellConfig = "b100100100000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000001000010000000000000000000011110000000000".U
      dut.io.cellConfig.poke(cellConfig)
      dut.clock.step(1)
      dut.clock.step(1)
      dut.clock.step(1)
      cellConfig = "b100001100000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000001000000000110000000000000001000000000000000000000000011".U
      dut.io.cellConfig.poke(cellConfig)
      dut.clock.step(1)
      dut.clock.step(1)
      dut.clock.step(1)
      cellConfig = "b101110000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000010000000000000000000000000000001100000000".U
      dut.io.cellConfig.poke(cellConfig)
      dut.clock.step(1)
      dut.clock.step(1)
      dut.clock.step(1)
      cellConfig = "b101000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000010000000000000000000000000000001100000000".U
      dut.io.cellConfig.poke(cellConfig)
      dut.clock.step(1)
      dut.clock.step(1)
      dut.clock.step(1)
      cellConfig = "b100101000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000100000000000000000100000000".U
      dut.io.cellConfig.poke(cellConfig)
      dut.clock.step(1)
      dut.clock.step(1)
      dut.clock.step(1)
      cellConfig = "b100010000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000010000000000000010000000000000011100000000".U
      dut.io.cellConfig.poke(cellConfig)
      dut.clock.step(1)
      dut.clock.step(1)
      dut.clock.step(1)
      cellConfig = "b101110100000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000100000000000000000000000000000000011000000".U
      dut.io.cellConfig.poke(cellConfig)
      dut.clock.step(1)
      dut.clock.step(1)
      dut.clock.step(1)
      cellConfig = "b101011100000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000001000000000000000000000000000010000000".U
      dut.io.cellConfig.poke(cellConfig)
      dut.clock.step(1)
      dut.clock.step(1)
      dut.clock.step(1)
      cellConfig = "b101000100000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000010000000000110000010000000000000000000000000000000010011".U
      dut.io.cellConfig.poke(cellConfig)
      dut.clock.step(1)
      dut.clock.step(1)
      dut.clock.step(1)

      // Test 1
      // cellConfig = "b100101100001000000000000010000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000001000000000010000010000000000000000000000000000000010011".U 

      // Test 2  
      cellConfig = "b100101100001000000000000010100000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000001000000000010000010000000000000000000000000000000010011".U 
        
      //cellConfig = "b100101100000000000000110010000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000001000000000010000010000000000000000000000000000000010011".U
      dut.io.cellConfig.poke(cellConfig)
      dut.clock.step(1)
      dut.clock.step(1)
      dut.clock.step(1)

      // Test 1
      //cellConfig = "b100010100010000000000000010000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000001000000000010000000000000001000000000000000000000000011".U
      
      // Test 2
      cellConfig = "b100010100010000000000000010100000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000001000000000010000000000000001000000000000000000000000011".U
      
      dut.io.cellConfig.poke(cellConfig)
      dut.clock.step(1)
      dut.clock.step(1)
      dut.clock.step(1)

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
