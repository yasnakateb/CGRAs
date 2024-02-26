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

object ProcessingElementParams
{
  def DATA_WIDTH = 32
  def FIFO_DEPTH = 32 
  def INSTRUCTION_CHANGE_DELAY = 5   
}

import ProcessingElementParams._

class Processing_Element_Test extends AnyFlatSpec with ChiselScalatestTester {
  "Processing_Element_Test test" should "pass" in {
    // Test code for summation with positive numbers

    test(new Processing_Element(DATA_WIDTH, FIFO_DEPTH)).withAnnotations(Seq(VerilatorBackendAnnotation, WriteVcdAnnotation)) { dut =>
        
      var numOfTests = 150

      var northDin = 0.S
      var northDinValid = false.B
      val northDoutReady = true.B  

      var eastDin = 0.S  
      var eastDinValid = false.B 
      val eastDoutReady = true.B 

      var southDin = 0.S  
      var southDinValid = false.B 
      val southDoutReady = true.B 

      var westDin = 0.S  
      var westDinValid = false.B 
      val westDoutReady = true.B 

      // Initialization
      dut.io.northDin.poke(northDin)
      dut.io.northDinValid.poke(northDinValid)
      dut.io.northDoutReady.poke(northDoutReady)
      
      dut.io.eastDin.poke(eastDin)
      dut.io.eastDinValid.poke(eastDinValid)
      dut.io.eastDoutReady.poke(eastDoutReady)

      dut.io.southDin.poke(southDin)
      dut.io.southDinValid.poke(southDinValid)
      dut.io.southDoutReady.poke(southDoutReady)

      dut.io.westDin.poke(westDin)
      dut.io.westDinValid.poke(westDinValid)
      dut.io.westDoutReady.poke(westDoutReady)

      ////////////////////////////////////////////////////////////////////////
      ////////
      ////////
      ////////
      //////// Feedback Loop
      ////////
      ////////
      ////////
      ////////
      ////////////////////////////////////////////////////////////////////////

      // **** Test case: SUM without feedback loop
      var configBits = "b0000000000011110110000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000100000000001000000000000000_1000_0000_0000_0000_0000_0000_0011".U 
      var catchConfig = true.B 
      // Configuration 
      dut.io.catchConfig.poke(catchConfig)
      dut.io.catchConfig.poke(true.B)
      dut.io.configBits.poke(configBits)
      dut.clock.step(1)
      dut.clock.step(1)
      dut.io.catchConfig.poke(false.B)
      configBits = 0.U
      dut.io.configBits.poke(configBits)
      
      // Inserting Data 
      dut.io.northDinValid.poke(true.B)
      dut.io.westDinValid.poke(true.B)
      
      //dut.io.northDin.poke(1.S)
      //dut.io.westDin.poke(1.S)
      for (i <- 1 until 16) {
        dut.io.northDin.poke(i.S)
        dut.io.westDin.poke((i).S)
        dut.io.northDinValid.poke(true.B)
        dut.io.westDinValid.poke(true.B)
        dut.clock.step(1)
        dut.io.northDinValid.poke(false.B)
        dut.io.westDinValid.poke(false.B)
        dut.clock.step(10)
      }
      dut.io.northDin.poke(0.S)
      dut.io.westDin.poke(0.S)
      dut.io.northDinValid.poke(false.B)
      dut.io.westDinValid.poke(false.B)
      for (i <- 0 until INSTRUCTION_CHANGE_DELAY) {
        dut.clock.step(1)
      }

      // **** Test case: Mul
      configBits = "b01000000000001101100000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000001000000000110000000000000001000000000000000000000000011".U 
      catchConfig = true.B 
      // Configuration 
      dut.io.catchConfig.poke(catchConfig)
      dut.io.catchConfig.poke(true.B)
      dut.io.configBits.poke(configBits)
      dut.clock.step(1)
      dut.clock.step(1)
      dut.io.catchConfig.poke(false.B)
      configBits = 0.U
      dut.io.configBits.poke(configBits)
      
      // Inserting Data 
      dut.io.northDinValid.poke(true.B)
      dut.io.westDinValid.poke(true.B)

      dut.io.northDin.poke(2.S)
      dut.io.westDin.poke(1.S)
      
      for (i <- 1 until 27) {
        //dut.io.northDin.poke(i.S)
        //dut.io.westDin.poke((i+1).S)
        dut.clock.step(1)
      }
      dut.io.northDin.poke(0.S)
      dut.io.westDin.poke(0.S)
      dut.io.northDinValid.poke(false.B)
      dut.io.westDinValid.poke(false.B)
      for (i <- 0 until INSTRUCTION_CHANGE_DELAY) {
        dut.clock.step(1)
      }

      // **** Test case: Sub
      configBits = "b01000000000111101100000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000001000000001010000000000000001000000000000000000000000011".U 
      catchConfig = true.B 
      // Configuration 
      dut.io.catchConfig.poke(catchConfig)
      dut.io.catchConfig.poke(true.B)
      dut.io.configBits.poke(configBits)
      dut.clock.step(1)
      dut.clock.step(1)
      dut.io.catchConfig.poke(false.B)
      configBits = 0.U
      dut.io.configBits.poke(configBits)
      
      // Inserting Data 
      dut.io.northDinValid.poke(true.B)
      dut.io.westDinValid.poke(true.B)
      
      dut.io.northDin.poke(1.S)
      dut.io.westDin.poke(124.S)
      
      for (i <- 1 until 123) {
        dut.clock.step(1)
      }
      dut.io.northDin.poke(0.S)
      dut.io.westDin.poke(0.S)
      dut.io.northDinValid.poke(false.B)
      dut.io.westDinValid.poke(false.B)
      for (i <- 0 until INSTRUCTION_CHANGE_DELAY) {
        dut.clock.step(1)
      }

      // **** Test case: Shift left (logic)
      //////////// North: din_2, West: din_1 
      configBits = "b01000000000001111100000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000001000000001110000000000000001000000000000000000000000011".U 
      catchConfig = true.B 
      // Configuration 
      dut.io.catchConfig.poke(catchConfig)
      dut.io.catchConfig.poke(true.B)
      dut.io.configBits.poke(configBits)
      dut.clock.step(1)
      dut.clock.step(1)
      dut.io.catchConfig.poke(false.B)
      configBits = 0.U
      dut.io.configBits.poke(configBits)
      
      // Inserting Data 
      dut.io.northDinValid.poke(true.B)
      dut.io.westDinValid.poke(true.B)
      
      dut.io.westDin.poke(1.S)
      dut.io.northDin.poke(1.S)
      for (i <- 1 until 31) {
          dut.clock.step(1)
      }
      dut.io.westDin.poke(0.S)
      dut.io.northDin.poke(0.S)
      dut.io.northDinValid.poke(false.B)
      dut.io.westDinValid.poke(false.B)
      for (i <- 0 until INSTRUCTION_CHANGE_DELAY) {
          dut.clock.step(1)
      }

      // **** Test case: Shift left (arithmetic) ????? or Right ? 

      configBits = "b01000000000111101100000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000001000000010010000000000000001000000000000000000000000011".U 
      catchConfig = true.B 
      // Configuration 
      dut.io.catchConfig.poke(catchConfig)
      dut.io.catchConfig.poke(true.B)
      dut.io.configBits.poke(configBits)
      dut.clock.step(1)
      dut.clock.step(1)
      dut.io.catchConfig.poke(false.B)
      configBits = 0.U
      dut.io.configBits.poke(configBits)
      
      // Inserting Data 
      dut.io.northDinValid.poke(true.B)
      dut.io.westDinValid.poke(true.B)
      
      
      for (i <- 1 until numOfTests) {
        dut.io.westDin.poke((-(i*4)).S)
        dut.io.northDin.poke((i-1).S)
        dut.clock.step(1)
      }
      dut.io.northDinValid.poke(false.B)
      dut.io.westDinValid.poke(false.B)
      for (i <- 0 until INSTRUCTION_CHANGE_DELAY) {
        dut.clock.step(1)
      }

      // **** Test case: Shift right (logic)

      configBits = "b01000000000111101100000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000001000000010110000000000000001000000000000000000000000011".U 
      catchConfig = true.B 
      // Configuration 
      dut.io.catchConfig.poke(catchConfig)
      dut.io.catchConfig.poke(true.B)
      dut.io.configBits.poke(configBits)
      dut.clock.step(1)
      dut.clock.step(1)
      dut.io.catchConfig.poke(false.B)
      configBits = 0.U
      dut.io.configBits.poke(configBits)
      
      // Inserting Data 
      dut.io.northDinValid.poke(true.B)
      dut.io.westDinValid.poke(true.B)
      
      dut.io.northDin.poke(1.S)
      for (i <- 1 until numOfTests) {
        dut.io.westDin.poke((-(i*2)).S)
        dut.io.northDin.poke((i-1).S)
        dut.clock.step(1)
      }
      
      dut.io.northDinValid.poke(false.B)
      dut.io.westDinValid.poke(false.B)
      for (i <- 0 until INSTRUCTION_CHANGE_DELAY) {
        dut.clock.step(1)
      }

      // **** Test case: AND
      configBits = "b01000000000111101100000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000001000000011010000000000000001000000000000000000000000011".U 
      catchConfig = true.B 
      // Configuration 
      dut.io.catchConfig.poke(catchConfig)
      dut.io.catchConfig.poke(true.B)
      dut.io.configBits.poke(configBits)
      dut.clock.step(1)
      dut.clock.step(1)
      dut.io.catchConfig.poke(false.B)
      configBits = 0.U
      dut.io.configBits.poke(configBits)
      
      // Inserting Data 
      dut.io.northDinValid.poke(true.B)
      dut.io.westDinValid.poke(true.B)
      
      
      for (i <- 1 until numOfTests) {
        dut.io.northDin.poke(i.S)
        if (i % 2 == 0) {
            dut.io.westDin.poke((i+1).S)
        } else {
            dut.io.westDin.poke((i+2).S)
        }
        dut.clock.step(1)
      }
      dut.io.northDinValid.poke(false.B)
      dut.io.westDinValid.poke(false.B)
      for (i <- 0 until INSTRUCTION_CHANGE_DELAY) {
        dut.clock.step(1)
      }

      // **** Test case: OR
      configBits = "b01000000000111101100000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000001000000011110000000000000001000000000000000000000000011".U 
      catchConfig = true.B 
      // Configuration 
      dut.io.catchConfig.poke(catchConfig)
      dut.io.catchConfig.poke(true.B)
      dut.io.configBits.poke(configBits)
      dut.clock.step(1)
      dut.clock.step(1)
      dut.io.catchConfig.poke(false.B)
      configBits = 0.U
      dut.io.configBits.poke(configBits)
      
      // Inserting Data 
      dut.io.northDinValid.poke(true.B)
      dut.io.westDinValid.poke(true.B)
      
      for (i <- 1 until numOfTests) {
        dut.io.northDin.poke(i.S)
        if (i % 2 == 0) {
            dut.io.westDin.poke((i+1).S)
        } else {
            dut.io.westDin.poke((i+2).S)
        }
        dut.clock.step(1)
      }
      dut.io.northDinValid.poke(false.B)
      dut.io.westDinValid.poke(false.B)
      for (i <- 0 until INSTRUCTION_CHANGE_DELAY) {
        dut.clock.step(1)
      }
      // **** Test case: XOR
      configBits = "b01000000000111101100000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000001000000100010000000000000001000000000000000000000000011".U 
      catchConfig = true.B 
      // Configuration 
      dut.io.catchConfig.poke(catchConfig)
      dut.io.catchConfig.poke(true.B)
      dut.io.configBits.poke(configBits)
      dut.clock.step(1)
      dut.clock.step(1)
      dut.io.catchConfig.poke(false.B)
      configBits = 0.U
      dut.io.configBits.poke(configBits)
      
      // Inserting Data 
      dut.io.northDinValid.poke(true.B)
      dut.io.westDinValid.poke(true.B)
      
      for (i <- 1 until numOfTests) {
        dut.io.northDin.poke(i.S)
        if (i % 2 == 0) {
            dut.io.westDin.poke((i+1).S)
        } else {
            dut.io.westDin.poke((i+2).S)
        }
        dut.clock.step(1)
      }
      dut.io.northDinValid.poke(false.B)
      dut.io.westDinValid.poke(false.B)
      for (i <- 0 until INSTRUCTION_CHANGE_DELAY) {
        dut.clock.step(1)
      }
    }
  } 
}