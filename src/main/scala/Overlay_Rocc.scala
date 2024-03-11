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

class Overlay_Rocc 
  (
    dataWidth: Int = 32, 
    inputNodes: Int = 6, 
    outputNodes: Int = 6, 
    fifoDepth: Int = 32
  ) 
  extends Module { val io = IO(new Bundle {
    val dataIn = Input(SInt((dataWidth*inputNodes).W))
    val dataInValid = Input(UInt(inputNodes.W))
    val dataInReady = Output(UInt(inputNodes.W))
    val dataOut = Output(UInt((dataWidth*inputNodes).W))
    val dataOutValid = Output(UInt(inputNodes.W))
    val dataOutReady = Input(UInt(inputNodes.W))
    val cellConfig = Input(UInt(192.W))
  })
  
  val northDin = Wire(Vec(inputNodes, SInt(dataWidth.W)))
  val northDinValid = Wire(Vec(inputNodes, Bool()))

  val vecDataInReady = Wire(Vec(inputNodes, Bool()))

  val vecDataOutValid = Wire(Vec(inputNodes, Bool()))
  val northDinReady = Wire(Vec(inputNodes, Bool()))

  val eastDout = Wire(Vec(outputNodes, SInt(dataWidth.W)))
  val eastDoutValid = Wire(Vec(outputNodes, Bool()))
  val eastDoutReady = Wire(Vec(outputNodes, Bool()))
  

  val intercDataWE = VecInit.fill(inputNodes -1, outputNodes)(0.asSInt(dataWidth.W)) 
  val intercDataEW = VecInit.fill(inputNodes -1, outputNodes)(0.asSInt(dataWidth.W)) 

  val intercValidWE = VecInit.fill(inputNodes -1, outputNodes)(0.asUInt(1.W)) 
  val intercValidEW = VecInit.fill(inputNodes -1, outputNodes)(0.asUInt(1.W)) 

  val intercReadyWE = VecInit.fill(inputNodes -1, outputNodes)(0.asUInt(1.W)) 
  val intercReadyEW = VecInit.fill(inputNodes -1, outputNodes)(0.asUInt(1.W)) 


  val intercDataNS = VecInit.fill(inputNodes, outputNodes - 1)(0.asSInt(dataWidth.W)) 
  val intercDataSN = VecInit.fill(inputNodes, outputNodes - 1)(0.asSInt(dataWidth.W)) 

  val intercValidNS = VecInit.fill(inputNodes, outputNodes -1)(0.asUInt(1.W))
  val intercValidSN = VecInit.fill(inputNodes, outputNodes -1)(0.asUInt(1.W))

  val intercReadyNS = VecInit.fill(inputNodes, outputNodes -1)(0.asUInt(1.W))
  val intercReadySN = VecInit.fill(inputNodes, outputNodes -1)(0.asUInt(1.W))

  val configBits = Wire(UInt(182.W))
  val catchConfig = Wire(Vec(inputNodes*outputNodes, Bool()))

  
  // ***************************************************************** Needs test
  val unsignedCellConfig = io.cellConfig(190,185).asUInt
  configBits := io.cellConfig(181,0)

  for( i <- 0 to inputNodes*outputNodes - 1){
    catchConfig(i) := 0.B 
  }

  when (io.cellConfig(191) === 1.U){
    catchConfig(unsignedCellConfig) := 1.B 
  }

  for( i <- 0 to inputNodes - 1){
    northDin(i) := (io.dataIn(dataWidth*(i+1) - 1, dataWidth*i)).asSInt
    northDinValid(i) := io.dataInValid(i) 
    vecDataInReady(i) := northDinReady(i)
      
  }

  io.dataInReady := vecDataInReady.asUInt 
  val vecDataOut = Wire(Vec(outputNodes, SInt(dataWidth.W)))

  val I = RegInit(0.U(log2Ceil(inputNodes).W))
  val J = RegInit(0.U(log2Ceil(outputNodes).W))

  for (I <- 0 until inputNodes) 
  { 
    for (J <- 0 until outputNodes) 
    {
      // WEST_OV 
      if (I == 0) 
      {
        if (J == 0) 
        {
          val northWestOv = Module(new Processing_Element(dataWidth, fifoDepth))

          // ********* North
          northWestOv.io.northDin := northDin(I)
          northWestOv.io.northDinValid := northDinValid(I)
          northDinReady(I) := northWestOv.io.northDinReady.asBool 

          // ********* East
          northWestOv.io.eastDin := intercDataWE(I)(J)
          northWestOv.io.eastDinValid := intercValidWE(I)(J)
          intercReadyWE(I)(J) := northWestOv.io.eastDinReady 

          // ********* South 
          northWestOv.io.southDin := intercDataNS(I)(J)
          northWestOv.io.southDinValid := intercValidNS(I)(J)
          intercReadyNS(I)(J) := northWestOv.io.southDinReady 

          // ********* West
          northWestOv.io.westDin := 0.S     
          northWestOv.io.westDinValid := 0.U 
          // westDinReady = open 

          // ********* North
          // northDout = open
          // northDoutValid = open
          northWestOv.io.northDoutReady := 0.U 

          // ********* East
          intercDataEW(I)(J) := northWestOv.io.eastDout 
          intercValidEW(I)(J) := northWestOv.io.eastDoutValid 
          northWestOv.io.eastDoutReady := intercReadyEW(I)(J)

          // ********* South
          intercDataSN(I)(J) := northWestOv.io.southDout 
          intercValidSN(I)(J) := northWestOv.io.southDoutValid 
          northWestOv.io.southDoutReady := intercReadySN(I)(J)

          // ********* West
          // westDout = open
          // westDoutValid = open
          northWestOv.io.westDoutReady := 0.U  

          // ********* Config
          northWestOv.io.configBits := configBits
          northWestOv.io.catchConfig := catchConfig(I+inputNodes*J) 
        }

        if (J != 0 & J != outputNodes - 1) 
        {
          val midWestOv = Module(new Processing_Element(dataWidth, fifoDepth))

          // ********* North
          midWestOv.io.northDin := intercDataSN(I)(J-1) 
          midWestOv.io.northDinValid := intercValidSN(I)(J-1) 
          intercReadySN(I)(J-1) := midWestOv.io.northDinReady 

          // ********* East
          midWestOv.io.eastDin := intercDataWE(I)(J) 
          midWestOv.io.eastDinValid := intercValidWE(I)(J)  
          intercReadyWE(I)(J) := midWestOv.io.eastDinReady 

          // ********* South
          midWestOv.io.southDin := intercDataNS(I)(J) 
          midWestOv.io.southDinValid := intercValidNS(I)(J) 
          intercReadyNS(I)(J) := midWestOv.io.southDinReady 

          // ********* West
          midWestOv.io.westDin := 0.S  
          midWestOv.io.westDinValid := 0.U
          //westDinReady = open  

          // ********* North
          intercDataNS(I)(J-1) := midWestOv.io.northDout  
          intercValidNS(I)(J-1) := midWestOv.io.northDoutValid 
          midWestOv.io.northDoutReady := intercReadyNS(I)(J-1)   

          // ********* East
          intercDataEW(I)(J) := midWestOv.io.eastDout 
          intercValidEW(I)(J) := midWestOv.io.eastDoutValid 
          midWestOv.io.eastDoutReady := intercReadyEW(I)(J) 

          // ********* South
          intercDataSN(I)(J) := midWestOv.io.southDout 
          intercValidSN(I)(J) := midWestOv.io.southDoutValid 
          midWestOv.io.southDoutReady := intercReadySN(I)(J) 

          // ********* West
          //westDout = open 
          //westDoutValid = open 
          midWestOv.io.westDoutReady := 0.U 

          // ********* Config
          midWestOv.io.configBits := configBits
          midWestOv.io.catchConfig := catchConfig(I+inputNodes*J) 
        }

        if (J == outputNodes - 1) 
        {
          val southWestOv = Module(new Processing_Element(dataWidth, fifoDepth))

          // ********* North
          southWestOv.io.northDin := intercDataSN(I)(J-1) 
          southWestOv.io.northDinValid := intercValidSN(I)(J-1) 
          intercReadySN(I)(J-1) := southWestOv.io.northDinReady 

          // ********* East
          southWestOv.io.eastDin := intercDataWE(I)(J)  
          southWestOv.io.eastDinValid := intercValidWE(I)(J) 
          intercReadyWE(I)(J) := southWestOv.io.eastDinReady  

          // ********* South
          southWestOv.io.southDin := 0.S    
          southWestOv.io.southDinValid := 0.U 
          // southDinReady = open

          // ********* West
          southWestOv.io.westDin := 0.S     
          southWestOv.io.westDinValid := 0.U 
          // westDinReady = open 

          // ********* North
          intercDataNS(I)(J-1) := southWestOv.io.northDout 
          intercValidNS(I)(J-1) := southWestOv.io.northDoutValid 
          southWestOv.io.northDoutReady := intercReadyNS(I)(J-1) 

          // ********* East
          intercDataEW(I)(J) := southWestOv.io.eastDout
          intercValidEW(I)(J) := southWestOv.io.eastDoutValid
          southWestOv.io.eastDoutReady := intercReadyEW(I)(J) 

          // ********* South
          // southDout = open 
          // southDoutValid = open 
          southWestOv.io.southDoutReady := 0.U 

          // ********* West
          // westDout = open 
          // westDoutValid = open 
          southWestOv.io.westDoutReady := 0.U 

          // ********* Config
          southWestOv.io.configBits := configBits
          southWestOv.io.catchConfig := catchConfig(I+inputNodes*J) 
        }
      } 
      //////////////////////////////////////////////////// 
      // MIDDLE_OV 
      if (I != 0 & I != inputNodes - 1) 
      {
        if (J == 0)
        {
          val middleNorthOv = Module(new Processing_Element(dataWidth, fifoDepth))

          // ********* North
          middleNorthOv.io.northDin := northDin(I) 
          middleNorthOv.io.northDinValid := northDinValid(I) 
          northDinReady(I) := middleNorthOv.io.northDinReady 

          // ********* East
          middleNorthOv.io.eastDin:= intercDataWE(I)(J)  
          middleNorthOv.io.eastDinValid := intercValidWE(I)(J) 
          intercReadyWE(I)(J) := middleNorthOv.io.eastDinReady  

          // ********* South
          middleNorthOv.io.southDin := intercDataNS(I)(J) 
          middleNorthOv.io.southDinValid := intercValidNS(I)(J) 
          intercReadyNS(I)(J) := middleNorthOv.io.southDinReady 

          // ********* West
          middleNorthOv.io.westDin:= intercDataEW(I-1)(J) 
          middleNorthOv.io.westDinValid := intercValidEW(I-1)(J)  
          intercReadyEW(I-1)(J) := middleNorthOv.io.westDinReady 
          
          // ********* North
          // northDout = open 
          // northDoutValid = open 
          middleNorthOv.io.northDoutReady := 0.U

          // ********* East 
          intercDataEW(I)(J) := middleNorthOv.io.eastDout  
          intercValidEW(I)(J) := middleNorthOv.io.eastDoutValid 
          middleNorthOv.io.eastDoutReady := intercReadyEW(I)(J)

          // ********* South
          intercDataSN(I)(J) := middleNorthOv.io.southDout 
          intercValidSN(I)(J) := middleNorthOv.io.southDoutValid
          middleNorthOv.io.southDoutReady := intercReadySN(I)(J)

          // ********* West
          intercDataWE(I-1)(J) := middleNorthOv.io.westDout 
          intercValidWE(I-1)(J) := middleNorthOv.io.westDoutValid 
          middleNorthOv.io.westDoutReady := intercReadyWE(I-1)(J)

          // ********* Config
          middleNorthOv.io.configBits := configBits 
          middleNorthOv.io.catchConfig := catchConfig(I+inputNodes*J) 
        }

        if(J != 0 & J != outputNodes - 1)
        {
          val middleMiddleOv = Module(new Processing_Element(dataWidth, fifoDepth))

          // ********* North
          middleMiddleOv.io.northDin := intercDataSN(I)(J-1) 
          middleMiddleOv.io.northDinValid := intercValidSN(I)(J-1) 
          intercReadySN(I)(J-1) := middleMiddleOv.io.northDinReady  

          // ********* East
          middleMiddleOv.io.eastDin := intercDataWE(I)(J)  
          middleMiddleOv.io.eastDinValid := intercValidWE(I)(J)    
          intercReadyWE(I)(J) := middleMiddleOv.io.eastDinReady  

          // ********* South
          middleMiddleOv.io.southDin := intercDataNS(I)(J) 
          middleMiddleOv.io.southDinValid := intercValidNS(I)(J) 
          intercReadyNS(I)(J) := middleMiddleOv.io.southDinReady  

          // ********* West
          middleMiddleOv.io.westDin := intercDataEW(I-1)(J) 
          middleMiddleOv.io.westDinValid := intercValidEW(I-1)(J)
          intercReadyEW(I-1)(J) := middleMiddleOv.io.westDinReady  

          // ********* North
          intercDataNS(I)(J-1) := middleMiddleOv.io.northDout 
          intercValidNS(I)(J-1) := middleMiddleOv.io.northDoutValid
          middleMiddleOv.io.northDoutReady := intercReadyNS(I)(J-1)

          // ********* East
          intercDataEW(I)(J) := middleMiddleOv.io.eastDout
          intercValidEW(I)(J) := middleMiddleOv.io.eastDoutValid 
          middleMiddleOv.io.eastDoutReady := intercReadyEW(I)(J)

          // ********* South
          intercDataSN(I)(J) := middleMiddleOv.io.southDout  
          intercValidSN(I)(J) := middleMiddleOv.io.southDoutValid
          middleMiddleOv.io.southDoutReady := intercReadySN(I)(J) 

          // ********* West
          intercDataWE(I-1)(J) := middleMiddleOv.io.westDout 
          intercValidWE(I-1)(J) := middleMiddleOv.io.westDoutValid 
          middleMiddleOv.io.westDoutReady := intercReadyWE(I-1)(J) 

          // ********* Config
          middleMiddleOv.io.configBits := configBits
          middleMiddleOv.io.catchConfig:= catchConfig(I+inputNodes*J) 
        } 

        if (J == outputNodes - 1)
        {
          val middleSouthOv = Module(new Processing_Element(dataWidth, fifoDepth))

          // ********* North
          middleSouthOv.io.northDin := intercDataSN(I)(J-1) 
          middleSouthOv.io.northDinValid := intercValidSN(I)(J-1)
          intercReadySN(I)(J-1) := middleSouthOv.io.northDinReady  

          // ********* East
          middleSouthOv.io.eastDin := intercDataWE(I)(J) 
          middleSouthOv.io.eastDinValid := intercValidWE(I)(J) 
          intercReadyWE(I)(J) := middleSouthOv.io.eastDinReady 

          // ********* South
          middleSouthOv.io.southDin := 0.S  
          middleSouthOv.io.southDinValid := 0.U 
          // southDinReady = open 

          // ********* West
          middleSouthOv.io.westDin := intercDataEW(I-1)(J) 
          middleSouthOv.io.westDinValid := intercValidEW(I-1)(J) 
          intercReadyEW(I-1)(J) := middleSouthOv.io.westDinReady 
          
          // ********* North
          intercDataNS(I)(J-1) := middleSouthOv.io.northDout 
          intercValidNS(I)(J-1) := middleSouthOv.io.northDoutValid 
          middleSouthOv.io.northDoutReady := intercReadyNS(I)(J-1) 

          // ********* East
          intercDataEW(I)(J) := middleSouthOv.io.eastDout 
          intercValidEW(I)(J) := middleSouthOv.io.eastDoutValid 
          middleSouthOv.io.eastDoutReady := intercReadyEW(I)(J)

          // ********* South
          // southDout = open 
          // southDoutValid = open 
          middleSouthOv.io.southDoutReady := 0.U

          // ********* West
          intercDataWE(I-1)(J) := middleSouthOv.io.westDout 
          intercValidWE(I-1)(J) := middleSouthOv.io.westDoutValid 
          middleSouthOv.io.westDoutReady := intercReadyWE(I-1)(J) 

          // ********* Config
          middleSouthOv.io.configBits := configBits
          middleSouthOv.io.catchConfig := catchConfig(I+inputNodes*J) 
        }       
      }
      
      // EAST_OV  
      if (I == inputNodes - 1)
      {
        if (J == 0)
        {
          val northEastOv = Module(new Processing_Element(dataWidth, fifoDepth))

          // ********* North
          northEastOv.io.northDin := northDin(I) 
          northEastOv.io.northDinValid := northDinValid(I) 
          northDinReady(I) := northEastOv.io.northDinReady 

          // ********* East
          northEastOv.io.eastDin := 0.S 
          northEastOv.io.eastDinValid := 0.U 
          // eastDinReady = open 

          // ********* South
          northEastOv.io.southDin := intercDataNS(I)(J) 
          northEastOv.io.southDinValid := intercValidNS(I)(J) 
          intercReadyNS(I)(J) := northEastOv.io.southDinReady  

          // ********* West
          northEastOv.io.westDin := intercDataEW(I-1)(J) 
          northEastOv.io.westDinValid := intercValidEW(I-1)(J) 
          intercReadyEW(I-1)(J) := northEastOv.io.westDinReady  

          // ********* North
          // northDout = open 
          // northDoutValid = open   
          northEastOv.io.northDoutReady := 0.U 

          // ********* East
          eastDout(J) := northEastOv.io.eastDout  
          eastDoutValid(J) := northEastOv.io.eastDoutValid 
          northEastOv.io.eastDoutReady := eastDoutReady(J) 

          // ********* South
          intercDataSN(I)(J) := northEastOv.io.southDout 
          intercValidSN(I)(J) := northEastOv.io.southDoutValid 
          northEastOv.io.southDoutReady := intercReadySN(I)(J) 

          // ********* West
          intercDataWE(I-1)(J) := northEastOv.io.westDout 
          intercValidWE(I-1)(J) := northEastOv.io.westDoutValid 
          northEastOv.io.westDoutReady := intercReadyWE(I-1)(J)

          // ********* Config
          northEastOv.io.configBits := configBits
          northEastOv.io.catchConfig := catchConfig(I+inputNodes*J) 
        }

        if (J != 0 &  J != outputNodes - 1)
        {
          val middleEastOv = Module(new Processing_Element(dataWidth,fifoDepth))

          // ********* North
          middleEastOv.io.northDin := intercDataSN(I)(J-1) 
          middleEastOv.io.northDinValid := intercValidSN(I)(J-1)
          intercReadySN(I)(J-1) := middleEastOv.io.northDinReady  
          
          // ********* East
          middleEastOv.io.eastDin := 0.S      
          middleEastOv.io.eastDinValid := 0.U 
          // io.eastDinReady = open 

          // ********* South
          middleEastOv.io.southDin := intercDataNS(I)(J)
          middleEastOv.io.southDinValid:= intercValidNS(I)(J)
          intercReadyNS(I)(J) := middleEastOv.io.southDinReady 

          // ********* West
          middleEastOv.io.westDin := intercDataEW(I-1)(J)
          middleEastOv.io.westDinValid := intercValidEW(I-1)(J) 
          intercReadyEW(I-1)(J) := middleEastOv.io.westDinReady  

          // ********* North
          intercDataNS(I)(J-1) := middleEastOv.io.northDout 
          intercValidNS(I)(J-1) := middleEastOv.io.northDoutValid  
          middleEastOv.io.northDoutReady := intercReadyNS(I)(J-1)

          // ********* East
          eastDout(J) := middleEastOv.io.eastDout  
          eastDoutValid(J) := middleEastOv.io.eastDoutValid 
          middleEastOv.io.eastDoutReady := eastDoutReady(J)

          // ********* South
          intercDataSN(I)(J) := middleEastOv.io.southDout 
          intercValidSN(I)(J) := middleEastOv.io.southDoutValid 
          middleEastOv.io.southDoutReady := intercReadySN(I)(J)

          // ********* West
          intercDataWE(I-1)(J) := middleEastOv.io.westDout 
          intercValidWE(I-1)(J) := middleEastOv.io.westDoutValid 
          middleEastOv.io.westDoutReady := intercReadyWE(I-1)(J)

          // ********* Config
          middleEastOv.io.configBits := configBits
          middleEastOv.io.catchConfig := catchConfig(I+inputNodes*J) 
        }  

        if (J == outputNodes - 1)
        {
          val middleSouthOv = Module(new Processing_Element(dataWidth, fifoDepth))

          // ********* North
          middleSouthOv.io.northDin := intercDataSN(I)(J-1)
          middleSouthOv.io.northDinValid := intercValidSN(I)(J-1)
          intercReadySN(I)(J-1) := middleSouthOv.io.northDinReady   

          // ********* East
          middleSouthOv.io.eastDin := 0.S   
          middleSouthOv.io.eastDinValid := 0.U
          //io.eastDinReady = open

          // ********* South
          middleSouthOv.io.southDin := 0.S  
          middleSouthOv.io.southDinValid := 0.U
          // io.southDinReady = open

          // ********* West
          middleSouthOv.io.westDin := intercDataEW(I-1)(J)
          middleSouthOv.io.westDinValid := intercValidEW(I-1)(J)
          intercReadyEW(I-1)(J) := middleSouthOv.io.westDinReady 

          // ********* North
          intercDataNS(I)(J-1) := middleSouthOv.io.northDout 
          intercValidNS(I)(J-1) := middleSouthOv.io.northDoutValid 
          middleSouthOv.io.northDoutReady := intercReadyNS(I)(J-1)

          // ********* East
          eastDout(J) := middleSouthOv.io.eastDout 
          eastDoutValid(J) := middleSouthOv.io.eastDoutValid 
          middleSouthOv.io.eastDoutReady := eastDoutReady(J)

          // ********* South
          // southDout = open
          // southDoutValid = open
          middleSouthOv.io.southDoutReady := 0.U

          // ********* West
          intercDataWE(I-1)(J) := middleSouthOv.io.westDout 
          intercValidWE(I-1)(J) := middleSouthOv.io.westDoutValid 
          middleSouthOv.io.westDoutReady := intercReadyWE(I-1)(J)

          // ********* Config
          middleSouthOv.io.configBits := configBits
          middleSouthOv.io.catchConfig := catchConfig(I+inputNodes*J)
        }            
      }
    }    
  }
  for( i <- 0 to outputNodes - 1){
    vecDataOut(i) := eastDout(i)
    vecDataOutValid (i) := eastDoutValid(i) 
    eastDoutReady(i) := io.dataOutReady(i)
  }
  io.dataOut := vecDataOut.asUInt 
  io.dataOutValid := vecDataOutValid.asUInt     
}

// Generate the Verilog code
object Overlay_Rocc_Main extends App {
  println("Generating the hardware")
  (new chisel3.stage.ChiselStage).emitVerilog(new Overlay_Rocc(32, 6, 6, 32), Array("--target-dir", "generated"))
}
