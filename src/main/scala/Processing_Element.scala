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

class Processing_Element 
  (
    dataWidth: Int, 
    fifoDepth: Int
  ) 
  extends Module {
  val io = IO(new Bundle {
    //  Data in
    val northDin = Input(SInt(dataWidth.W))
    val northDinValid = Input(Bool())
    val northDinReady = Output(Bool())

    val eastDin = Input(SInt(dataWidth.W))
    val eastDinValid = Input(Bool())
    val eastDinReady = Output(Bool())

    val southDin = Input(SInt(dataWidth.W))
    val southDinValid = Input(Bool())
    val southDinReady = Output(Bool())

    val westDin = Input(SInt(dataWidth.W))
    val westDinValid = Input(Bool())
    val westDinReady = Output(Bool())

    //  Data out
    val northDout = Output(SInt(dataWidth.W))
    val northDoutValid = Output(Bool())
    val northDoutReady = Input(Bool())

    val eastDout = Output(SInt(dataWidth.W))
    val eastDoutValid = Output(Bool())
    val eastDoutReady = Input(Bool())

    val southDout = Output(SInt(dataWidth.W))
    val southDoutValid = Output(Bool())
    val southDoutReady = Input(Bool())

    val westDout = Output(SInt(dataWidth.W))
    val westDoutValid = Output(Bool())
    val westDoutReady = Input(Bool())
    
    //  Config
    val configBits = Input(UInt(182.W))
    val catchConfig = Input(Bool())
  })

  // Config signals
  val muxNsel = Wire(UInt(2.W))
  val muxEsel = Wire(UInt(2.W))
  val muxSsel = Wire(UInt(2.W))
  val muxWsel = Wire(UInt(2.W))
  val acceptMaskFrN = Wire(UInt(5.W))
  val acceptMaskFrE = Wire(UInt(5.W))
  val acceptMaskFrS = Wire(UInt(5.W))
  val acceptMaskFrW = Wire(UInt(5.W))
  val acceptMaskFsiN = Wire(UInt(5.W))
  val acceptMaskFsiE = Wire(UInt(5.W))
  val acceptMaskFsiS = Wire(UInt(5.W))
  val acceptMaskFsiW = Wire(UInt(5.W))

  val configBitsReg = RegInit(0.U(182.W))
  
  //  Interconnect signals
  val northBuffer = Wire(SInt(dataWidth.W))
  val eastBuffer = Wire(SInt(dataWidth.W))
  val southBuffer = Wire(SInt(dataWidth.W))
  val westBuffer = Wire(SInt(dataWidth.W))

  val northBufferValid = Wire(UInt(1.W))
  val eastBufferValid = Wire(UInt(1.W))
  val southBufferValid = Wire(UInt(1.W))
  val westBufferValid = Wire(UInt(1.W))

  val northBufferReady = Wire(UInt(1.W))
  val eastBufferReady = Wire(UInt(1.W))
  val southBufferReady = Wire(UInt(1.W))
  val westBufferReady = Wire(UInt(1.W))   
  
  val northRegDin = Wire(SInt(dataWidth.W))
  val eastRegDin = Wire(SInt(dataWidth.W))
  val southRegDin = Wire(SInt(dataWidth.W))
  val westRegDin = Wire(SInt(dataWidth.W))

  val northRegDinValid = Wire(UInt(1.W))
  val eastRegDinValid = Wire(UInt(1.W))
  val southRegDinValid = Wire(UInt(1.W))
  val westRegDinValid = Wire(UInt(1.W))

  val northRegDinReady = Wire(UInt(1.W))
  val eastRegDinReady = Wire(UInt(1.W))
  val southRegDinReady = Wire(UInt(1.W))
  val westRegDinReady = Wire(UInt(1.W))
  //  cell processing signals
  val fuDin1Ready = Wire(UInt(1.W))
  val fuDin2Ready = Wire(UInt(1.W))
  val fuDout = Wire(SInt(dataWidth.W))
  val fuDoutValid = Wire(UInt(1.W))
  
  when (io.catchConfig) {
      configBitsReg := io.configBits
  }
  // Configuration bits arrangement
  // val muxNsel = configBitsReg(7, 6)
  muxNsel := configBitsReg(7, 6)
  muxEsel := configBitsReg(9, 8)
  muxSsel := configBitsReg(11, 10)
  muxWsel := configBitsReg(13, 12)
  // cell_interior conf
  acceptMaskFsiN := configBitsReg(28, 24)
  acceptMaskFsiE := configBitsReg(33, 29)
  acceptMaskFsiS := configBitsReg(38, 34)
  acceptMaskFsiW := configBitsReg(43, 39)
  // cell_interior conf
  acceptMaskFrN := configBitsReg(61, 57)
  acceptMaskFrE := configBitsReg(66, 62)
  acceptMaskFrS := configBitsReg(71, 67)
  acceptMaskFrW := configBitsReg(76, 72)
  
  // ------------------------------- NORTH NODE -------------------------------

  val fifoNin = Module (new D_Fifo(dataWidth, fifoDepth))
  fifoNin.io.din := io.northDin  
  fifoNin.io.dinValid := io.northDinValid
  fifoNin.io.doutReady := northBufferReady
  io.northDinReady := fifoNin.io.dinReady 
  northBuffer := fifoNin.io.dout   
  northBufferValid := fifoNin.io.doutValid 

  val fsNin = Module (new Fs(5))
  val ready_out_fsNin = Cat(fuDin1Ready, fuDin2Ready, eastRegDinReady, southRegDinReady, westRegDinReady)     
  fsNin.io.readyOut := ready_out_fsNin
  northBufferReady := fsNin.io.readyIn
  fsNin.io.forkMask := acceptMaskFsiN
  
  val muxNout  = Module (new Conf_Mux(4, dataWidth))
  muxNout.io.selector := muxNsel
  muxNout.io.muxInput := (Cat(westBuffer, southBuffer, eastBuffer, fuDout)).asSInt 
  northRegDin := muxNout.io.muxOutput
  
  val frNout = Module (new Fr(4, 5))
  val ready_frNout = Cat(fuDin1Ready, fuDin2Ready, eastRegDinReady, southRegDinReady, westRegDinReady)  
  val validIn_frNout = Cat(westBufferValid, southBufferValid, eastBufferValid, fuDoutValid)  
  frNout.io.readyOut := ready_frNout
  frNout.io.validIn := validIn_frNout
  frNout.io.validMuxSel := muxNsel
  frNout.io.forkMask := acceptMaskFrN
  northRegDinValid := frNout.io.validOut 

  val regNout = Module (new D_Reg(dataWidth))
  
  regNout.io.din := northRegDin 
  regNout.io.dinValid := northRegDinValid 
  regNout.io.doutReady := io.northDoutReady

  northRegDinReady := regNout.io.dinReady
  io.northDout := regNout.io.dout  
  io.northDoutValid := regNout.io.doutValid 
      
  //------------------------------- NORTH NODE -------------------------------

  // ------------------------------- EAST  NODE -------------------------------
  
  val fifoEin = Module (new D_Fifo(dataWidth, fifoDepth))
  fifoEin.io.din := io.eastDin  
  fifoEin.io.dinValid := io.eastDinValid
  fifoEin.io.doutReady := eastBufferReady
  io.eastDinReady := fifoEin.io.dinReady 
  eastBuffer := fifoEin.io.dout   
  eastBufferValid := fifoEin.io.doutValid 

  val fsEin = Module (new Fs(5))
  val ready_out_fsEin = Cat(fuDin1Ready, fuDin2Ready, northRegDinReady, southRegDinReady, westRegDinReady)     
  fsEin.io.readyOut := ready_out_fsEin
  eastBufferReady := fsEin.io.readyIn
  fsEin.io.forkMask := acceptMaskFsiE

  val muxEout  = Module (new Conf_Mux(4, dataWidth))
  muxEout.io.selector := muxEsel
  muxEout.io.muxInput := (Cat(westBuffer, southBuffer, northBuffer, fuDout)).asSInt
  eastRegDin := muxEout.io.muxOutput
  
  val frEout = Module (new Fr(4, 5))
  val ready_frEout = Cat(fuDin1Ready, fuDin2Ready, northRegDinReady, southRegDinReady, westRegDinReady)  
  val validIn_frEout = Cat(westBufferValid, southBufferValid, northBufferValid, fuDoutValid)  
  frEout.io.readyOut := ready_frEout
  frEout.io.validIn := validIn_frEout
  frEout.io.validMuxSel := muxEsel
  frEout.io.forkMask := acceptMaskFrE
  eastRegDinValid := frEout.io.validOut 

  val regEout = Module (new D_Reg(dataWidth))
  
  regEout.io.din := eastRegDin 
  regEout.io.dinValid := eastRegDinValid 
  regEout.io.doutReady := io.eastDoutReady

  eastRegDinReady := regEout.io.dinReady
  io.eastDout := regEout.io.dout  
  io.eastDoutValid := regEout.io.doutValid 
      
  // ------------------------------- EAST  NODE -------------------------------

  // ------------------------------- SOUTH NODE -------------------------------
  
  val fifoSin = Module (new D_Fifo(dataWidth, fifoDepth))
  fifoSin.io.din := io.southDin  
  fifoSin.io.dinValid := io.southDinValid
  fifoSin.io.doutReady := southBufferReady
  io.southDinReady := fifoSin.io.dinReady 
  southBuffer := fifoSin.io.dout   
  southBufferValid := fifoSin.io.doutValid 

  val fsSin = Module (new Fs(5))
  val ready_out_fsSin = Cat(fuDin1Ready, fuDin2Ready, northRegDinReady, eastRegDinReady, westRegDinReady)     
  fsSin.io.readyOut := ready_out_fsSin
  southBufferReady := fsSin.io.readyIn
  fsSin.io.forkMask := acceptMaskFsiS
  
  val muxSout  = Module (new Conf_Mux(4, dataWidth))
  muxSout.io.selector := muxSsel
  muxSout.io.muxInput := (Cat(westBuffer, eastBuffer, northBuffer, fuDout)).asSInt
  southRegDin := muxSout.io.muxOutput

  val frSout = Module (new Fr(4, 5))
  val ready_frSout = Cat(fuDin1Ready, fuDin2Ready, northRegDinReady, eastRegDinReady, westRegDinReady)  
  val validIn_frSout = Cat(westBufferValid, eastBufferValid, northBufferValid, fuDoutValid)  
  frSout.io.readyOut := ready_frSout
  frSout.io.validIn := validIn_frSout
  frSout.io.validMuxSel := muxSsel
  frSout.io.forkMask := acceptMaskFrS
  southRegDinValid := frSout.io.validOut 

  val regSout = Module (new D_Reg(dataWidth))
  
  regSout.io.din := southRegDin 
  regSout.io.dinValid := southRegDinValid 
  regSout.io.doutReady := io.southDoutReady

  southRegDinReady := regSout.io.dinReady
  io.southDout := regSout.io.dout  
  io.southDoutValid := regSout.io.doutValid 
  // ------------------------------- SOUTH NODE -------------------------------

  // ------------------------------- WEST  NODE -------------------------------

  val fifoWin = Module (new D_Fifo(dataWidth, fifoDepth))
  fifoWin.io.din := io.westDin  
  fifoWin.io.dinValid := io.westDinValid
  fifoWin.io.doutReady := westBufferReady
  io.westDinReady := fifoWin.io.dinReady 
  westBuffer := fifoWin.io.dout   
  westBufferValid := fifoWin.io.doutValid 

  val fsWin = Module (new Fs(5))
  val ready_out_fsWin = Cat(fuDin1Ready, fuDin2Ready, northRegDinReady, eastRegDinReady, southRegDinReady)     
  fsWin.io.readyOut := ready_out_fsWin
  fsWin.io.forkMask :=  acceptMaskFsiW
  westBufferReady := fsWin.io.readyIn

  val muxWout  = Module (new Conf_Mux(4, dataWidth))
  muxWout.io.selector := muxWsel
  muxWout.io.muxInput := (Cat(southBuffer, eastBuffer, northBuffer, fuDout)).asSInt 
  westRegDin := muxWout.io.muxOutput

  val frWout = Module (new Fr(4, 5))
  val ready_frWout = Cat(fuDin1Ready, fuDin2Ready, northRegDinReady, eastRegDinReady, southRegDinReady)  
  val validIn_frWout = Cat(southBufferValid, eastBufferValid, northBufferValid, fuDoutValid)  
  frWout.io.readyOut := ready_frWout
  frWout.io.validIn := validIn_frWout
  frWout.io.validMuxSel := muxWsel
  frWout.io.forkMask := acceptMaskFrW
  westRegDinValid := frWout.io.validOut 

  val regWout = Module (new D_Reg(dataWidth))
  
  regWout.io.din := westRegDin 
  regWout.io.dinValid := westRegDinValid 
  regWout.io.doutReady := io.westDoutReady

  westRegDinReady := regWout.io.dinReady
  io.westDout := regWout.io.dout  
  io.westDoutValid := regWout.io.doutValid 
  // ------------------------------- WEST  NODE -------------------------------

  // cell processing
  val cell = Module (new Cell_Processing(dataWidth))
  cell.io.northDin := northBuffer
  cell.io.northDinValid := northBufferValid
  cell.io.eastDin := eastBuffer
  cell.io.eastDinValid := eastBufferValid
  cell.io.southDin := southBuffer
  cell.io.southDinValid := southBufferValid
  cell.io.westDin := westBuffer
  cell.io.westDinValid := westBufferValid
  cell.io.northDoutReady := northRegDinReady
  cell.io.eastDoutReady := eastRegDinReady
  cell.io.southDoutReady := southRegDinReady
  cell.io.westDoutReady := westRegDinReady
  cell.io.configBits := configBitsReg
  fuDin1Ready := cell.io.fuDin1Ready 
  fuDin2Ready := cell.io.fuDin2Ready 
  fuDout := cell.io.dout 
  fuDoutValid := cell.io.doutValid   
}

// Generate the Verilog code
object Processing_Element_Main extends App {
    println("Generating the hardware")
    (new chisel3.stage.ChiselStage).emitVerilog(new Processing_Element(32, 32), Array("--target-dir", "generated"))
}