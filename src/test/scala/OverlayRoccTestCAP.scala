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

class OverlayRoccTestCAP extends AnyFlatSpec with ChiselScalatestTester {
  "OverlayRoccCAP test" should "pass" in {
    test(new OverlayRocc(32, 6, 6, 32)).withAnnotations(Seq(VerilatorBackendAnnotation, WriteVcdAnnotation)) { dut =>
      ///////////////////////////////////////////
      // CAP
      ///////////////////////////////////////////

      var dataInValid = "b000000".U 
      var dataOutReady = "b111111".U 
      dut.io.dataInValid.poke(dataInValid)
      dut.io.dataOutReady.poke(dataOutReady)
      dut.clock.step(1)

      var cellConfig: UInt = 0.U 
      /*
      // Note: Original 
      val source = Source.fromFile("src/test/scala/Bitstreams/cap.txt")
      for (line <- source.getLines()){
          
          cellConfig = ("b" + line).U  
          dut.io.cellConfig.poke(cellConfig)
          dut.clock.step(1)
          dut.clock.step(1)
          dut.clock.step(1)
      }
      source.close()
      */
      cellConfig = "b100000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000100000000000000000100000000".U  
      dut.io.cellConfig.poke(cellConfig)

      dut.clock.step(1)
      dut.clock.step(1)
      dut.clock.step(1)

      cellConfig = "b100000100000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000010000000000000000000000000000001100000000".U 
      dut.io.cellConfig.poke(cellConfig)

      dut.clock.step(1)
      dut.clock.step(1)
      dut.clock.step(1)
      cellConfig = "b101101000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000001000000000000000000000000000010000000001100000000000000010000000000000000000000100000".U 
      dut.io.cellConfig.poke(cellConfig)

      dut.clock.step(1)
      dut.clock.step(1)
      dut.clock.step(1)
      cellConfig = "b101010000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000001000000000100000100000001001000000000000000100000000010".U 
      dut.io.cellConfig.poke(cellConfig)

      dut.clock.step(1)
      dut.clock.step(1)
      dut.clock.step(1)

      cellConfig = "b100111000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000010000000000000000000000000000000100000010000000000000000010000000000000000000000100000".U 
      dut.io.cellConfig.poke(cellConfig)

      dut.clock.step(1)
      dut.clock.step(1)
      dut.clock.step(1)

      cellConfig = "b100100000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000110000000000000000000000000000000100000000100000000001000000100000000000000000100100001".U 
      dut.io.cellConfig.poke(cellConfig)

      dut.clock.step(1)
      dut.clock.step(1)
      dut.clock.step(1)

      cellConfig = "b100001000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000100001000000000000000000000011000000000000000000000000000111100000000".U 
      dut.io.cellConfig.poke(cellConfig)

      dut.clock.step(1)
      dut.clock.step(1)
      dut.clock.step(1)

      cellConfig = "b101010100000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000010000000000100000000000000010001100000000".U 
      dut.io.cellConfig.poke(cellConfig)

      dut.clock.step(1)
      dut.clock.step(1)
      dut.clock.step(1)

      cellConfig = "b100100100000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000010000000000000001000000000001001100000000".U 
      dut.io.cellConfig.poke(cellConfig)

      dut.clock.step(1)
      dut.clock.step(1)
      dut.clock.step(1)

      cellConfig = "b100001100000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000001000000000000000000000000000110000000000".U 
      dut.io.cellConfig.poke(cellConfig)

      dut.clock.step(1)
      dut.clock.step(1)
      dut.clock.step(1)

      cellConfig = "b101011000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000010000000000000001000000000001001100000000".U 
      dut.io.cellConfig.poke(cellConfig)

      dut.clock.step(1)
      dut.clock.step(1)
      dut.clock.step(1)

      cellConfig = "b101000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000010000000000000010000000000".U 
      dut.io.cellConfig.poke(cellConfig)

      dut.clock.step(1)
      dut.clock.step(1)
      dut.clock.step(1)

      cellConfig = "b100101000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000100001000000000000000000000011000000000000000000000000000111100000000".U 
      dut.io.cellConfig.poke(cellConfig)

      dut.clock.step(1)
      dut.clock.step(1)
      dut.clock.step(1)

      cellConfig = "b101011100000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000001000000000110000000000000001000000000000000000000000011".U  
      dut.io.cellConfig.poke(cellConfig)

      dut.clock.step(1)
      dut.clock.step(1)
      dut.clock.step(1)

      cellConfig = "b101000100000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000010000000000000000000000000000000100000010000000000000000010000000000000000000000100000".U  
      dut.io.cellConfig.poke(cellConfig)

      dut.clock.step(1)
      dut.clock.step(1)
      dut.clock.step(1)

      cellConfig = "b100101100000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000011000000000000000000000000000010000000000110000000000000000010000000000000010000100011".U 
      dut.io.cellConfig.poke(cellConfig)

      dut.clock.step(1)
      dut.clock.step(1)
      dut.clock.step(1)

      cellConfig = "b100010100000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000100000000100000100000000001000000000000000000000000010".U 
      dut.io.cellConfig.poke(cellConfig)

      dut.clock.step(1)
      dut.clock.step(1)
      dut.clock.step(1)

      ///////////////////////////////////////////
      // Test 1: int a [SIZE]= {2, 4, 8, 16,32};
      //         int m [SIZE]= {1, 2, 3, 4, 5};
      ///////////////////////////////////////////
      var din = BigInt("00000001"  + "00000000000000000000000000000000" + "00000002"  ,16).S    
      dut.io.dataIn.poke(din)
      dut.io.dataInValid.poke("b100001".U)
      dut.clock.step(1)
      dut.io.dataInValid.poke("b000000".U)
      dut.clock.step(10)

      din = BigInt("00000002"  + "00000000000000000000000000000000" + "00000004"  ,16).S    
      dut.io.dataIn.poke(din)
      dut.io.dataInValid.poke("b100001".U)
      dut.clock.step(1)
      dut.io.dataInValid.poke("b000000".U)
      dut.clock.step(10)

      din = BigInt("00000003"  + "00000000000000000000000000000000" + "00000008"  ,16).S    
      dut.io.dataIn.poke(din)
      dut.io.dataInValid.poke("b100001".U)
      dut.clock.step(1)
      dut.io.dataInValid.poke("b000000".U)
      dut.clock.step(10)

      din = BigInt("00000004"  + "00000000000000000000000000000000" + "00000010"  ,16).S    
      dut.io.dataIn.poke(din)
      dut.io.dataInValid.poke("b100001".U)
      dut.clock.step(1)
      dut.io.dataInValid.poke("b000000".U)
      dut.clock.step(10)

      din = BigInt("00000005"  + "00000000000000000000000000000000" + "00000020"  ,16).S    
      dut.io.dataIn.poke(din)
      dut.io.dataInValid.poke("b100001".U)
      dut.clock.step(1)
      dut.io.dataInValid.poke("b000000".U)
      dut.clock.step(10)
      ///////////////////////////////////////////
      // Test 2: int a [SIZE]= {1, 2, 3, 4, 5};
      //         int m [SIZE]= {1, 2, 3, 4, 5};
      ///////////////////////////////////////////
      din = BigInt("00000001"  + "00000000000000000000000000000000" + "00000001"  ,16).S    
      dut.io.dataIn.poke(din)
      dut.io.dataInValid.poke("b100001".U)
      dut.clock.step(1)
      dut.io.dataInValid.poke("b000000".U)
      dut.clock.step(10)

      din = BigInt("00000002"  + "00000000000000000000000000000000" + "00000002"  ,16).S    
      dut.io.dataIn.poke(din)
      dut.io.dataInValid.poke("b100001".U)
      dut.clock.step(1)
      dut.io.dataInValid.poke("b000000".U)
      dut.clock.step(10)

      din = BigInt("00000003"  + "00000000000000000000000000000000" + "00000003"  ,16).S    
      dut.io.dataIn.poke(din)
      dut.io.dataInValid.poke("b100001".U)
      dut.clock.step(1)
      dut.io.dataInValid.poke("b000000".U)
      dut.clock.step(10)

      din = BigInt("00000004"  + "00000000000000000000000000000000" + "00000004"  ,16).S    
      dut.io.dataIn.poke(din)
      dut.io.dataInValid.poke("b100001".U)
      dut.clock.step(1)
      dut.io.dataInValid.poke("b000000".U)
      dut.clock.step(10)

      din = BigInt("00000005"  + "00000000000000000000000000000000" + "00000005"  ,16).S    
      dut.io.dataIn.poke(din)
      dut.io.dataInValid.poke("b100001".U)
      dut.clock.step(1)
      dut.io.dataInValid.poke("b000000".U)
      dut.clock.step(10)

      // Finish 
      for( i <- 0 to 10){
        dut.clock.step(1)
      } 
      println("End of the simulation")         
    }
  } 
}
