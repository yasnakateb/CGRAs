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

class CellProcessing 
  (
    dataWidth: Int
  ) 
  extends Module {
  val io = IO(new Bundle {
    val northDin = Input(SInt(dataWidth.W))
    val northDinValid = Input(Bool())
    val eastDin = Input(SInt(dataWidth.W))
    val eastDinValid = Input(Bool())
    val southDin = Input(SInt(dataWidth.W))
    val southDinValid = Input(Bool())
    val westDin = Input(SInt(dataWidth.W))
    val westDinValid = Input(Bool())
    val fuDin1Ready = Output(Bool())  
    val fuDin2Ready = Output(Bool())  
    val dout = Output(SInt(dataWidth.W))
    val doutValid = Output(Bool())  
    val northDoutReady = Input(Bool())
    val eastDoutReady = Input(Bool())
    val southDoutReady = Input(Bool())
    val westDoutReady = Input(Bool())
    val configBits = Input(UInt(182.W))
  })
  //  Config signals
  val selectorMux1 = Wire(UInt(3.W))
  val selectorMux2 = Wire(UInt(3.W))
  val forkReceiverMask1 = Wire(UInt(4.W))
  val forkReceiverMask2 = Wire(UInt(4.W))
  val opConfig = Wire(UInt(5.W))
  val forkSenderMask = Wire(UInt(5.W))
  val I1CONST = Wire(UInt(dataWidth.W))
  val initialVaueLoad = Wire(UInt(dataWidth.W))
  val iterationsResetLoad = Wire(UInt(16.W))
  val fifoLengthLoad = Wire(UInt(16.W))
  val loadInitialValue = Wire(UInt(2.W))
  val fuDout = Wire(SInt(dataWidth.W))
  val ebDin1 = Wire(SInt(dataWidth.W))
  val ebDin2 = Wire(SInt(dataWidth.W))
  val joinDin1 = Wire(SInt(dataWidth.W))
  val joindin2 = Wire(SInt(dataWidth.W))
  val joinDout1 = Wire(SInt(dataWidth.W))
  val joinDout2 = Wire(SInt(dataWidth.W))
  val fuDoutValid = Wire(Bool())
  val fuDoutReady = Wire(Bool())
  val ebDin1Valid = Wire(Bool())
  val ebDin2Valid = Wire(Bool())
  val joinDin1Valid = Wire(Bool())
  val joinDin1Ready = Wire(Bool())
  val joinDin2Valid = Wire(Bool())
  val joinDin2Ready = Wire(Bool())
  val joinDoutValid = Wire(Bool())
  val joinDoutReady = Wire(Bool())
  val forkedDoutReady = Wire(Bool())

  //  Configuration bits arrangement
  selectorMux1 := io.configBits(2, 0) 
  selectorMux2 := io.configBits(5, 3)
  forkReceiverMask1 := io.configBits(17, 14)
  //  2 fill bits (19 ,  18)
  forkReceiverMask2 := io.configBits(23, 20)
  //  structure conf
  opConfig := io.configBits(48, 44)
  //  3 fill bits (50 ,  48)
  forkSenderMask := io.configBits(56, 52)
  //  structure conf
  I1CONST := io.configBits(115, 84)
  initialVaueLoad := io.configBits(147, 116)  
  fifoLengthLoad := io.configBits(163, 148)
  iterationsResetLoad := io.configBits(179, 164)
  loadInitialValue := io.configBits(181, 180)

  val fr1 = Module (new Fr(6, 4))
  val readyfr1 = Cat(io.northDoutReady, io.eastDoutReady, io.southDoutReady, io.westDoutReady)  
  val validInfr1 = Cat(fuDoutValid.asUInt, "b1".U, io.westDinValid, io.southDinValid, io.eastDinValid, io.northDinValid)  
  fr1.io.readyOut := readyfr1
  fr1.io.validIn := validInfr1
  fr1.io.validMuxSel := selectorMux1
  fr1.io.forkMask := forkReceiverMask1 
  ebDin1Valid := fr1.io.validOut 

  val mux1 = Module (new ConfMux(6, dataWidth))
  mux1.io.selector := selectorMux1
  mux1.io.muxInput := (Cat(fuDout, I1CONST, io.westDin, io.southDin, io.eastDin, io.northDin)).asSInt
  ebDin1 := mux1.io.muxOutput

  val eb1 = Module (new DEb(dataWidth))
  eb1.io.din := ebDin1
  eb1.io.dinValid := ebDin1Valid
  io.fuDin1Ready := eb1.io.dinReady 
  joinDin1 := eb1.io.dout   
  joinDin1Valid := eb1.io.doutValid 
  eb1.io.doutReady := joinDin1Ready

  val fr2 = Module (new Fr(6, 4))
  val ready_fr2 = Cat(io.northDoutReady, io.eastDoutReady, io.southDoutReady, io.westDoutReady)  
  val validIn_fr2 = Cat(fuDoutValid.asUInt, "b1".U, io.westDinValid, io.southDinValid, io.eastDinValid, io.northDinValid)  
  fr2.io.readyOut := ready_fr2
  fr2.io.validIn := validIn_fr2
  fr2.io.validMuxSel := selectorMux2
  fr2.io.forkMask := forkReceiverMask2 
  ebDin2Valid := fr2.io.validOut 

  val mux2 = Module (new ConfMux(6, dataWidth))
  mux2.io.selector := selectorMux2
  mux2.io.muxInput := (Cat(fuDout, I1CONST, io.westDin, io.southDin, io.eastDin, io.northDin)).asSInt 
  ebDin2 := mux2.io.muxOutput

  val eb2 = Module (new DEb(dataWidth))
  eb2.io.din := ebDin2
  eb2.io.dinValid := ebDin2Valid
  io.fuDin2Ready := eb2.io.dinReady 
  joindin2 := eb2.io.dout   
  joinDin2Valid := eb2.io.doutValid
  eb2.io.doutReady := joinDin2Ready 

  val joinInst = Module (new Join(dataWidth))
  joinInst.io.din1 := joinDin1
  joinInst.io.din2 := joindin2 
  joinInst.io.doutReady := joinDoutReady
  joinInst.io.din1Valid := joinDin1Valid
  joinInst.io.din2Valid := joinDin2Valid

  joinDoutValid := joinInst.io.doutValid 
  joinDin1Ready := joinInst.io.din1Ready 
  joinDin2Ready := joinInst.io.din2Ready 
  joinDout1 := joinInst.io.dout1
  joinDout2 := joinInst.io.dout2

  val fuInst = Module (new Fu(dataWidth, 5))
  fuInst.io.din1 := joinDout1
  fuInst.io.din2 := joinDout2
  fuInst.io.dinValid := joinDoutValid
  joinDoutReady := fuInst.io.dinReady 
  fuInst.io.loopSource := loadInitialValue
  fuInst.io.iterationsReset := iterationsResetLoad 
  fuInst.io.opConfig := opConfig 
  fuDout := fuInst.io.dout    
  fuDoutValid := fuInst.io.doutValid
  
  fuInst.io.doutReady := fuDoutReady

  val ebOut = Module (new DEb(dataWidth))
  ebOut.io.din := fuDout
  ebOut.io.dinValid := fuDoutValid
  ebOut.io.din := fuInst.io.dout    
  ebOut.io.dinValid := fuInst.io.doutValid

  fuDoutReady := ebOut.io.dinReady
  io.dout := ebOut.io.dout   
  io.doutValid := ebOut.io.doutValid 
  ebOut.io.doutReady := forkedDoutReady

  val fs = Module (new Fs(5))
  val readyOutFs = Cat("b1".U, io.northDoutReady, io.eastDoutReady, io.southDoutReady, io.westDoutReady)     
  fs.io.readyOut := readyOutFs
  forkedDoutReady := fs.io.readyIn
  fs.io.forkMask := forkSenderMask
}

// Generate the Verilog code
object CellProcessingMain extends App {
  println("Generating the hardware")
  (new chisel3.stage.ChiselStage).emitVerilog(new CellProcessing(32), Array("--target-dir", "generated"))
}