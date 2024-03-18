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
import chisel3.util._

object states
{
  def STATE_0 = 0.U(2.W)    // 00
  def STATE_1 = 1.U(2.W)    // 01
  def STATE_2 = 2.U(2.W)    // 10
  def STATE_3 = 3.U(2.W)    // 11
}

import states._

class Fu
  (
    dataWidth: Int, 
    opWidth: Int
  )
  extends Module {
  val io = IO(new Bundle {
    val din1 = Input(SInt(dataWidth.W))
    val din2 = Input(SInt(dataWidth.W))
    val dinValid = Input(Bool())
    val doutReady = Input(Bool())
    val loopSource = Input(UInt(2.W))
    val iterationsReset = Input(UInt(16.W))
    val opConfig = Input(UInt(opWidth.W))
    val dinReady = Output(Bool())
    val dout = Output(SInt(dataWidth.W))
    val doutValid = Output(Bool()) 
  })

  val aluDin1 = Wire(SInt(dataWidth.W))
  val aluDin2 = Wire(SInt(dataWidth.W))
  
  val aluDout = Wire(SInt(dataWidth.W))

  val doutReg = RegInit(0.S(dataWidth.W))
  val count = RegInit(0.U(16.W))
  val loaded = RegInit(0.U(1.W))

  //val valid = RegInit(0.U(1.W))
  val valid = Wire(Bool()) 

  val alu = Module (new Alu(dataWidth, opWidth))
  alu.io.din1 := aluDin1
  alu.io.din2 := aluDin2
  aluDout := alu.io.dout 
  alu.io.opConfig := io.opConfig
  
  when (io.loopSource === STATE_0) {
    aluDin1 := io.din1
    aluDin2 := io.din2  
  }
  .elsewhen (io.loopSource === STATE_1) {
    when (loaded === 0.U) {
      aluDin1 := io.din1
      aluDin2 := io.din2                              
    }  
    .otherwise {
      aluDin1 := doutReg
      aluDin2 := io.din2                      
    }                               
  } 
  .elsewhen (io.loopSource === STATE_2) {
    when (loaded === 0.U) {
      aluDin1 := io.din1
      aluDin2 := io.din2                                
    }  
    .otherwise {
      aluDin1 := io.din1
      aluDin2 := doutReg                      
    }                               
  } 
  .otherwise { 
    aluDin1 := (dataWidth - 1).S
    aluDin2 := (dataWidth - 1).S
  }
  
  when (io.doutReady === 1.U) {
    valid := 0.U           
  }.otherwise{
    valid := 1.U 
  }
  
  when (io.dinValid === 1.U && io.doutReady === 1.U && 
    (io.loopSource === STATE_1 || io.loopSource === STATE_2)) {
    loaded := 1.U
    count := count + 1.U                    
  }
  
  when (count === io.iterationsReset && 
    (io.loopSource === STATE_1 || io.loopSource === STATE_2) && 
    io.doutReady === 1.U){
    count := 0.U
    loaded := 0.U
    valid := 1.U         
    doutReg := aluDout
  }    
  .elsewhen ((io.loopSource === STATE_1 || io.loopSource === STATE_2) && 
      io.dinValid === 1.U && io.doutReady === 1.U){
    doutReg := aluDout
  } 

  io.dinReady := io.doutReady

  when (io.loopSource === STATE_0){
    io.dout := aluDout
    io.doutValid := io.dinValid 
  }
  .otherwise{
    io.dout := doutReg
    io.doutValid := valid    
  }   
}

// Generate the Verilog code
object FuMain extends App {
  println("Generating the hardware")
  (new chisel3.stage.ChiselStage).emitVerilog(new Fu(32, 5), Array("--target-dir", "generated"))
}