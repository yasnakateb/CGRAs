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

class OverlayRocc 
    (
        DATA_WIDTH: Int = 32, 
        INPUT_NODES: Int = 6, 
        OUTPUT_NODES: Int = 6, 
        FIFO_DEPTH: Int = 32
    ) 
    extends Module { val io = IO(new Bundle {
        //  Data 
        val data_in = Input(SInt((DATA_WIDTH*INPUT_NODES).W))
        val data_in_valid = Input(UInt(INPUT_NODES.W))
        val data_in_ready = Output(UInt(INPUT_NODES.W))
        val data_out = Output(UInt((DATA_WIDTH*INPUT_NODES).W))
        val data_out_valid = Output(UInt(INPUT_NODES.W))
        val data_out_ready = Input(UInt(INPUT_NODES.W))

        //  Config
        val cell_config = Input(UInt(192.W))
    })
    
    val north_din = Wire(Vec(INPUT_NODES, SInt(DATA_WIDTH.W)))
    val north_din_v = Wire(Vec(INPUT_NODES, Bool()))

    val vec_data_in_ready = Wire(Vec(INPUT_NODES, Bool()))

    val vec_data_out_valid = Wire(Vec(INPUT_NODES, Bool()))
    val north_din_r = Wire(Vec(INPUT_NODES, Bool()))

    val east_dout = Wire(Vec(OUTPUT_NODES, SInt(DATA_WIDTH.W)))
    val east_dout_v = Wire(Vec(OUTPUT_NODES, Bool()))
    val east_dout_r = Wire(Vec(OUTPUT_NODES, Bool()))
    

    val interc_data_we = VecInit.fill(INPUT_NODES -1, OUTPUT_NODES)(0.asSInt(DATA_WIDTH.W)) 
    val interc_data_ew = VecInit.fill(INPUT_NODES -1, OUTPUT_NODES)(0.asSInt(DATA_WIDTH.W)) 

    val interc_valid_we = VecInit.fill(INPUT_NODES -1, OUTPUT_NODES)(0.asUInt(1.W)) 
    val interc_valid_ew = VecInit.fill(INPUT_NODES -1, OUTPUT_NODES)(0.asUInt(1.W)) 

    val interc_ready_we = VecInit.fill(INPUT_NODES -1, OUTPUT_NODES)(0.asUInt(1.W)) 
    val interc_ready_ew = VecInit.fill(INPUT_NODES -1, OUTPUT_NODES)(0.asUInt(1.W)) 


    val interc_data_ns = VecInit.fill(INPUT_NODES, OUTPUT_NODES - 1)(0.asSInt(DATA_WIDTH.W)) 
    val interc_data_sn = VecInit.fill(INPUT_NODES, OUTPUT_NODES - 1)(0.asSInt(DATA_WIDTH.W)) 

    val interc_valid_ns = VecInit.fill(INPUT_NODES, OUTPUT_NODES -1)(0.asUInt(1.W))
    val interc_valid_sn = VecInit.fill(INPUT_NODES, OUTPUT_NODES -1)(0.asUInt(1.W))

    val interc_ready_ns = VecInit.fill(INPUT_NODES, OUTPUT_NODES -1)(0.asUInt(1.W))
    val interc_ready_sn = VecInit.fill(INPUT_NODES, OUTPUT_NODES -1)(0.asUInt(1.W))

    val config_bits = Wire(UInt(182.W))
    val catch_config = Wire(Vec(INPUT_NODES*OUTPUT_NODES, Bool()))


    
    
    // ***************************************************************** Needs test
    val unsigned_cell_config = io.cell_config(190,185).asUInt
    config_bits := io.cell_config(181,0)

    for( i <- 0 to INPUT_NODES*OUTPUT_NODES - 1){
        catch_config(i) := 0.B 
    }

    when (io.cell_config(191) === 1.U){
        catch_config(unsigned_cell_config) := 1.B 
    }

    for( i <- 0 to INPUT_NODES - 1){
        north_din(i) := (io.data_in(DATA_WIDTH*(i+1) - 1, DATA_WIDTH*i)).asSInt
        
        // ==> Error: Cannot reassign to read-only

        // north_din_v(i) := io.data_in_valid(i) 

        north_din_v(i) := io.data_in_valid(i) 
        vec_data_in_ready(i) := north_din_r(i)
        
    }

    io.data_in_ready := vec_data_in_ready.asUInt 
    //north_din_v := io.data_in_valid
    //io.data_in_ready := north_din_r.asUInt
    
    //  ***************************************************************** Fix 
   
    val vec_data_out = Wire(Vec(OUTPUT_NODES, SInt(DATA_WIDTH.W)))

    val I = RegInit(0.U(log2Ceil(INPUT_NODES).W))
    val J = RegInit(0.U(log2Ceil(OUTPUT_NODES).W))

    for (I <- 0 until INPUT_NODES) 
    { 
        for (J <- 0 until OUTPUT_NODES) 
        {
            // WEST_OV 
            if (I == 0) 
            {
                if (J == 0) 
                {
                    val NORTHWEST_OV = Module(new ProcessingElement(DATA_WIDTH, FIFO_DEPTH))

                    // ********* North
                    NORTHWEST_OV.io.north_din := north_din(I)
                    NORTHWEST_OV.io.north_din_v := north_din_v(I)
                    north_din_r(I) := NORTHWEST_OV.io.north_din_r.asBool 

                    // ********* East
                    NORTHWEST_OV.io.east_din := interc_data_we(I)(J)
                    NORTHWEST_OV.io.east_din_v := interc_valid_we(I)(J)
                    interc_ready_we(I)(J) := NORTHWEST_OV.io.east_din_r 

                    // ********* South 
                    NORTHWEST_OV.io.south_din := interc_data_ns(I)(J)
                    NORTHWEST_OV.io.south_din_v := interc_valid_ns(I)(J)
                    interc_ready_ns(I)(J) := NORTHWEST_OV.io.south_din_r 

                    // ********* West
                    NORTHWEST_OV.io.west_din := 0.S     
                    NORTHWEST_OV.io.west_din_v := 0.U 
                    // west_din_r = open 

                    // ********* North
                    // north_dout = open
                    // north_dout_v = open
                    NORTHWEST_OV.io.north_dout_r := 0.U 

                    // ********* East
                    interc_data_ew(I)(J) := NORTHWEST_OV.io.east_dout 
                    interc_valid_ew(I)(J) := NORTHWEST_OV.io.east_dout_v 
                    NORTHWEST_OV.io.east_dout_r := interc_ready_ew(I)(J)

                    // ********* South
                    interc_data_sn(I)(J) := NORTHWEST_OV.io.south_dout 
                    interc_valid_sn(I)(J) := NORTHWEST_OV.io.south_dout_v 
                    NORTHWEST_OV.io.south_dout_r := interc_ready_sn(I)(J)

                    // ********* West
                    // west_dout = open
                    // west_dout_v = open
                    NORTHWEST_OV.io.west_dout_r := 0.U  

                    // ********* Config
                    NORTHWEST_OV.io.config_bits := config_bits
                    NORTHWEST_OV.io.catch_config := catch_config(I+INPUT_NODES*J) 
                }

                if (J != 0 & J != OUTPUT_NODES - 1) 
                {
                    val MIDWEST_OV = Module(new ProcessingElement(DATA_WIDTH, FIFO_DEPTH))

                    // ********* North
                    MIDWEST_OV.io.north_din := interc_data_sn(I)(J-1) 
                    MIDWEST_OV.io.north_din_v := interc_valid_sn(I)(J-1) 
                    interc_ready_sn(I)(J-1) := MIDWEST_OV.io.north_din_r 

                    // ********* East
                    MIDWEST_OV.io.east_din := interc_data_we(I)(J) 
                    MIDWEST_OV.io.east_din_v := interc_valid_we(I)(J)  
                    interc_ready_we(I)(J) := MIDWEST_OV.io.east_din_r 

                    // ********* South
                    MIDWEST_OV.io.south_din := interc_data_ns(I)(J) 
                    MIDWEST_OV.io.south_din_v := interc_valid_ns(I)(J) 
                    interc_ready_ns(I)(J) := MIDWEST_OV.io.south_din_r 

                    // ********* West
                    MIDWEST_OV.io.west_din := 0.S  
                    MIDWEST_OV.io.west_din_v := 0.U
                    //west_din_r = open  

                    // ********* North
                    interc_data_ns(I)(J-1) := MIDWEST_OV.io.north_dout  
                    interc_valid_ns(I)(J-1) := MIDWEST_OV.io.north_dout_v 
                    MIDWEST_OV.io.north_dout_r := interc_ready_ns(I)(J-1)   

                    // ********* East
                    interc_data_ew(I)(J) := MIDWEST_OV.io.east_dout 
                    interc_valid_ew(I)(J) := MIDWEST_OV.io.east_dout_v 
                    MIDWEST_OV.io.east_dout_r := interc_ready_ew(I)(J) 

                    // ********* South
                    interc_data_sn(I)(J) := MIDWEST_OV.io.south_dout 
                    interc_valid_sn(I)(J) := MIDWEST_OV.io.south_dout_v 
                    MIDWEST_OV.io.south_dout_r := interc_ready_sn(I)(J) 

                    // ********* West
                    //west_dout = open 
                    //west_dout_v = open 
                    MIDWEST_OV.io.west_dout_r := 0.U 

                    // ********* Config
                    MIDWEST_OV.io.config_bits := config_bits
                    MIDWEST_OV.io.catch_config := catch_config(I+INPUT_NODES*J) 
                }

                if (J == OUTPUT_NODES - 1) 
                {
                    val SOUTHWEST_OV = Module(new ProcessingElement(DATA_WIDTH, FIFO_DEPTH))

                    // ********* North
                    SOUTHWEST_OV.io.north_din := interc_data_sn(I)(J-1) 
                    SOUTHWEST_OV.io.north_din_v := interc_valid_sn(I)(J-1) 
                    interc_ready_sn(I)(J-1) := SOUTHWEST_OV.io.north_din_r 

                    // ********* East
                    SOUTHWEST_OV.io.east_din := interc_data_we(I)(J)  
                    SOUTHWEST_OV.io.east_din_v := interc_valid_we(I)(J) 
                    interc_ready_we(I)(J) := SOUTHWEST_OV.io.east_din_r  

                    // ********* South
                    SOUTHWEST_OV.io.south_din := 0.S    
                    SOUTHWEST_OV.io.south_din_v := 0.U 
                    // south_din_r = open

                    // ********* West
                    SOUTHWEST_OV.io.west_din := 0.S     
                    SOUTHWEST_OV.io.west_din_v := 0.U 
                    // west_din_r = open 

                    // ********* North
                    interc_data_ns(I)(J-1) := SOUTHWEST_OV.io.north_dout 
                    interc_valid_ns(I)(J-1) := SOUTHWEST_OV.io.north_dout_v 
                    SOUTHWEST_OV.io.north_dout_r := interc_ready_ns(I)(J-1) 

                    // ********* East
                    interc_data_ew(I)(J) := SOUTHWEST_OV.io.east_dout
                    interc_valid_ew(I)(J) := SOUTHWEST_OV.io.east_dout_v
                    SOUTHWEST_OV.io.east_dout_r := interc_ready_ew(I)(J) 

                    // ********* South
                    // south_dout = open 
                    // south_dout_v = open 
                    SOUTHWEST_OV.io.south_dout_r := 0.U 

                    // ********* West
                    // west_dout = open 
                    // west_dout_v = open 
                    SOUTHWEST_OV.io.west_dout_r := 0.U 

                    // ********* Config
                    SOUTHWEST_OV.io.config_bits := config_bits
                    SOUTHWEST_OV.io.catch_config := catch_config(I+INPUT_NODES*J) 
                }
            } 
            //////////////////////////////////////////////////// Get data from the west 
            // MIDDLE_OV 
            if (I != 0 & I != INPUT_NODES - 1) 
            {
                if (J == 0)
                {
                    val MIDDLENORTH_OV = Module(new ProcessingElement(DATA_WIDTH, FIFO_DEPTH))

                    // ********* North
                    MIDDLENORTH_OV.io.north_din := north_din(I) 
                    MIDDLENORTH_OV.io.north_din_v := north_din_v(I) 
                    north_din_r(I) := MIDDLENORTH_OV.io.north_din_r 

                    // ********* East
                    MIDDLENORTH_OV.io.east_din:= interc_data_we(I)(J)  
                    MIDDLENORTH_OV.io.east_din_v := interc_valid_we(I)(J) 
                    interc_ready_we(I)(J) := MIDDLENORTH_OV.io.east_din_r  

                    // ********* South
                    MIDDLENORTH_OV.io.south_din := interc_data_ns(I)(J) 
                    MIDDLENORTH_OV.io.south_din_v := interc_valid_ns(I)(J) 
                    interc_ready_ns(I)(J) := MIDDLENORTH_OV.io.south_din_r 

                    // ********* West
                    MIDDLENORTH_OV.io.west_din:= interc_data_ew(I-1)(J) 
                    MIDDLENORTH_OV.io.west_din_v := interc_valid_ew(I-1)(J)  
                    interc_ready_ew(I-1)(J) := MIDDLENORTH_OV.io.west_din_r 
                    
                    // ********* North
                    // north_dout = open 
                    // north_dout_v = open 
                    MIDDLENORTH_OV.io.north_dout_r := 0.U

                    // ********* East 
                    interc_data_ew(I)(J) := MIDDLENORTH_OV.io.east_dout  
                    interc_valid_ew(I)(J) := MIDDLENORTH_OV.io.east_dout_v 
                    MIDDLENORTH_OV.io.east_dout_r := interc_ready_ew(I)(J)

                    // ********* South
                    interc_data_sn(I)(J) := MIDDLENORTH_OV.io.south_dout 
                    interc_valid_sn(I)(J) := MIDDLENORTH_OV.io.south_dout_v
                    MIDDLENORTH_OV.io.south_dout_r := interc_ready_sn(I)(J)

                    // ********* West
                    interc_data_we(I-1)(J) := MIDDLENORTH_OV.io.west_dout 
                    interc_valid_we(I-1)(J) := MIDDLENORTH_OV.io.west_dout_v 
                    MIDDLENORTH_OV.io.west_dout_r := interc_ready_we(I-1)(J)

                    // ********* Config
                    MIDDLENORTH_OV.io.config_bits := config_bits 
                    MIDDLENORTH_OV.io.catch_config := catch_config(I+INPUT_NODES*J) 
                }

                if(J != 0 & J != OUTPUT_NODES - 1)
                {
                    val MIDDLEMIDDLE_OV = Module(new ProcessingElement(DATA_WIDTH, FIFO_DEPTH))

                    // ********* North
                    MIDDLEMIDDLE_OV.io.north_din := interc_data_sn(I)(J-1) 
                    MIDDLEMIDDLE_OV.io.north_din_v := interc_valid_sn(I)(J-1) 
                    interc_ready_sn(I)(J-1) := MIDDLEMIDDLE_OV.io.north_din_r  

                    // ********* East
                    MIDDLEMIDDLE_OV.io.east_din := interc_data_we(I)(J)  
                    MIDDLEMIDDLE_OV.io.east_din_v := interc_valid_we(I)(J)    
                    interc_ready_we(I)(J) := MIDDLEMIDDLE_OV.io.east_din_r  

                    // ********* South
                    MIDDLEMIDDLE_OV.io.south_din := interc_data_ns(I)(J) 
                    MIDDLEMIDDLE_OV.io.south_din_v := interc_valid_ns(I)(J) 
                    interc_ready_ns(I)(J) := MIDDLEMIDDLE_OV.io.south_din_r  

                    // ********* West
                    MIDDLEMIDDLE_OV.io.west_din := interc_data_ew(I-1)(J) 
                    MIDDLEMIDDLE_OV.io.west_din_v := interc_valid_ew(I-1)(J)
                    interc_ready_ew(I-1)(J) := MIDDLEMIDDLE_OV.io.west_din_r  

                    // ********* North
                    interc_data_ns(I)(J-1) := MIDDLEMIDDLE_OV.io.north_dout 
                    interc_valid_ns(I)(J-1) := MIDDLEMIDDLE_OV.io.north_dout_v
                    MIDDLEMIDDLE_OV.io.north_dout_r := interc_ready_ns(I)(J-1)

                    // ********* East
                    interc_data_ew(I)(J) := MIDDLEMIDDLE_OV.io.east_dout
                    interc_valid_ew(I)(J) := MIDDLEMIDDLE_OV.io.east_dout_v 
                    MIDDLEMIDDLE_OV.io.east_dout_r := interc_ready_ew(I)(J)

                    // ********* South
                    interc_data_sn(I)(J) := MIDDLEMIDDLE_OV.io.south_dout  
                    interc_valid_sn(I)(J) := MIDDLEMIDDLE_OV.io.south_dout_v
                    MIDDLEMIDDLE_OV.io.south_dout_r := interc_ready_sn(I)(J) 

                    // ********* West
                    interc_data_we(I-1)(J) := MIDDLEMIDDLE_OV.io.west_dout 
                    interc_valid_we(I-1)(J) := MIDDLEMIDDLE_OV.io.west_dout_v 
                    MIDDLEMIDDLE_OV.io.west_dout_r := interc_ready_we(I-1)(J) 

                    // ********* Config
                    MIDDLEMIDDLE_OV.io.config_bits := config_bits
                    MIDDLEMIDDLE_OV.io.catch_config:= catch_config(I+INPUT_NODES*J) 
                } 

                if (J == OUTPUT_NODES - 1)
                {
                    val MIDDLESOUTH_OV = Module(new ProcessingElement(DATA_WIDTH, FIFO_DEPTH))

                    // ********* North
                    MIDDLESOUTH_OV.io.north_din := interc_data_sn(I)(J-1) 
                    MIDDLESOUTH_OV.io.north_din_v := interc_valid_sn(I)(J-1)
                    interc_ready_sn(I)(J-1) := MIDDLESOUTH_OV.io.north_din_r  

                    // ********* East
                    MIDDLESOUTH_OV.io.east_din := interc_data_we(I)(J) 
                    MIDDLESOUTH_OV.io.east_din_v := interc_valid_we(I)(J) 
                    interc_ready_we(I)(J) := MIDDLESOUTH_OV.io.east_din_r 

                    // ********* South
                    MIDDLESOUTH_OV.io.south_din := 0.S  
                    MIDDLESOUTH_OV.io.south_din_v := 0.U 
                    // south_din_r = open 

                    // ********* West
                    MIDDLESOUTH_OV.io.west_din := interc_data_ew(I-1)(J) 
                    MIDDLESOUTH_OV.io.west_din_v := interc_valid_ew(I-1)(J) 
                    interc_ready_ew(I-1)(J) := MIDDLESOUTH_OV.io.west_din_r 
                    
                    // ********* North
                    interc_data_ns(I)(J-1) := MIDDLESOUTH_OV.io.north_dout 
                    interc_valid_ns(I)(J-1) := MIDDLESOUTH_OV.io.north_dout_v 
                    MIDDLESOUTH_OV.io.north_dout_r := interc_ready_ns(I)(J-1) 

                    // ********* East
                    interc_data_ew(I)(J) := MIDDLESOUTH_OV.io.east_dout 
                    interc_valid_ew(I)(J) := MIDDLESOUTH_OV.io.east_dout_v 
                    MIDDLESOUTH_OV.io.east_dout_r := interc_ready_ew(I)(J)

                    // ********* South
                    // south_dout = open 
                    // south_dout_v = open 
                    MIDDLESOUTH_OV.io.south_dout_r := 0.U

                    // ********* West
                    interc_data_we(I-1)(J) := MIDDLESOUTH_OV.io.west_dout 
                    interc_valid_we(I-1)(J) := MIDDLESOUTH_OV.io.west_dout_v 
                    MIDDLESOUTH_OV.io.west_dout_r := interc_ready_we(I-1)(J) 

                    // ********* Config
                    MIDDLESOUTH_OV.io.config_bits := config_bits
                    MIDDLESOUTH_OV.io.catch_config := catch_config(I+INPUT_NODES*J) 
                }       
            }
            
            // EAST_OV  
            if (I == INPUT_NODES - 1)
            {
                if (J == 0)
                {
                    val NORTHEAST_OV = Module(new ProcessingElement(DATA_WIDTH, FIFO_DEPTH))

                    // ********* North
                    NORTHEAST_OV.io.north_din := north_din(I) 
                    NORTHEAST_OV.io.north_din_v := north_din_v(I) 
                    north_din_r(I) := NORTHEAST_OV.io.north_din_r 

                    // ********* East
                    NORTHEAST_OV.io.east_din := 0.S 
                    NORTHEAST_OV.io.east_din_v := 0.U 
                    // east_din_r = open 

                    // ********* South
                    NORTHEAST_OV.io.south_din := interc_data_ns(I)(J) 
                    NORTHEAST_OV.io.south_din_v := interc_valid_ns(I)(J) 
                    interc_ready_ns(I)(J) := NORTHEAST_OV.io.south_din_r  

                    // ********* West
                    NORTHEAST_OV.io.west_din := interc_data_ew(I-1)(J) 
                    NORTHEAST_OV.io.west_din_v := interc_valid_ew(I-1)(J) 
                    interc_ready_ew(I-1)(J) := NORTHEAST_OV.io.west_din_r  

                    // ********* North
                    // north_dout = open 
                    // north_dout_v = open   
                    NORTHEAST_OV.io.north_dout_r := 0.U 

                    // ********* East
                    east_dout(J) := NORTHEAST_OV.io.east_dout  
                    east_dout_v(J) := NORTHEAST_OV.io.east_dout_v 
                    NORTHEAST_OV.io.east_dout_r := east_dout_r(J) 

                    // ********* South
                    interc_data_sn(I)(J) := NORTHEAST_OV.io.south_dout 
                    interc_valid_sn(I)(J) := NORTHEAST_OV.io.south_dout_v 
                    NORTHEAST_OV.io.south_dout_r := interc_ready_sn(I)(J) 

                    // ********* West
                    interc_data_we(I-1)(J) := NORTHEAST_OV.io.west_dout 
                    interc_valid_we(I-1)(J) := NORTHEAST_OV.io.west_dout_v 
                    NORTHEAST_OV.io.west_dout_r := interc_ready_we(I-1)(J)

                    // ********* Config
                    NORTHEAST_OV.io.config_bits := config_bits
                    NORTHEAST_OV.io.catch_config := catch_config(I+INPUT_NODES*J) 
                }

                if (J != 0 &  J != OUTPUT_NODES - 1)
                {
                    val MIDDLEEAST_OV = Module(new ProcessingElement(DATA_WIDTH,FIFO_DEPTH))

                    // ********* North
                    MIDDLEEAST_OV.io.north_din := interc_data_sn(I)(J-1) 
                    MIDDLEEAST_OV.io.north_din_v := interc_valid_sn(I)(J-1)
                    interc_ready_sn(I)(J-1) := MIDDLEEAST_OV.io.north_din_r  
                    
                    // ********* East
                    MIDDLEEAST_OV.io.east_din := 0.S      
                    MIDDLEEAST_OV.io.east_din_v := 0.U 
                    // io.east_din_r = open 

                    // ********* South
                    MIDDLEEAST_OV.io.south_din := interc_data_ns(I)(J)
                    MIDDLEEAST_OV.io.south_din_v:= interc_valid_ns(I)(J)
                    interc_ready_ns(I)(J) := MIDDLEEAST_OV.io.south_din_r 

                    // ********* West
                    MIDDLEEAST_OV.io.west_din := interc_data_ew(I-1)(J)
                    MIDDLEEAST_OV.io.west_din_v := interc_valid_ew(I-1)(J) 
                    interc_ready_ew(I-1)(J) := MIDDLEEAST_OV.io.west_din_r  

                    // ********* North
                    interc_data_ns(I)(J-1) := MIDDLEEAST_OV.io.north_dout 
                    interc_valid_ns(I)(J-1) := MIDDLEEAST_OV.io.north_dout_v  
                    MIDDLEEAST_OV.io.north_dout_r := interc_ready_ns(I)(J-1)

                    // ********* East
                    east_dout(J) := MIDDLEEAST_OV.io.east_dout  
                    east_dout_v(J) := MIDDLEEAST_OV.io.east_dout_v 
                    MIDDLEEAST_OV.io.east_dout_r := east_dout_r(J)

                    // ********* South
                    interc_data_sn(I)(J) := MIDDLEEAST_OV.io.south_dout 
                    interc_valid_sn(I)(J) := MIDDLEEAST_OV.io.south_dout_v 
                    MIDDLEEAST_OV.io.south_dout_r := interc_ready_sn(I)(J)

                    // ********* West
                    interc_data_we(I-1)(J) := MIDDLEEAST_OV.io.west_dout 
                    interc_valid_we(I-1)(J) := MIDDLEEAST_OV.io.west_dout_v 
                    MIDDLEEAST_OV.io.west_dout_r := interc_ready_we(I-1)(J)

                    // ********* Config
                    MIDDLEEAST_OV.io.config_bits := config_bits
                    MIDDLEEAST_OV.io.catch_config := catch_config(I+INPUT_NODES*J) 
                }  

                if (J == OUTPUT_NODES - 1)
                {
                    val MIDDLESOUTH_OV = Module(new ProcessingElement(DATA_WIDTH, FIFO_DEPTH))

                    // ********* North
                    MIDDLESOUTH_OV.io.north_din := interc_data_sn(I)(J-1)
                    MIDDLESOUTH_OV.io.north_din_v := interc_valid_sn(I)(J-1)
                    interc_ready_sn(I)(J-1) := MIDDLESOUTH_OV.io.north_din_r   

                    // ********* East
                    MIDDLESOUTH_OV.io.east_din := 0.S   
                    MIDDLESOUTH_OV.io.east_din_v := 0.U
                    //io.east_din_r = open

                    // ********* South
                    MIDDLESOUTH_OV.io.south_din := 0.S  
                    MIDDLESOUTH_OV.io.south_din_v := 0.U
                    // io.south_din_r = open

                    // ********* West
                    MIDDLESOUTH_OV.io.west_din := interc_data_ew(I-1)(J)
                    MIDDLESOUTH_OV.io.west_din_v := interc_valid_ew(I-1)(J)
                    interc_ready_ew(I-1)(J) := MIDDLESOUTH_OV.io.west_din_r 

                    // ********* North
                    interc_data_ns(I)(J-1) := MIDDLESOUTH_OV.io.north_dout 
                    interc_valid_ns(I)(J-1) := MIDDLESOUTH_OV.io.north_dout_v 
                    MIDDLESOUTH_OV.io.north_dout_r := interc_ready_ns(I)(J-1)

                    // ********* East
                    east_dout(J) := MIDDLESOUTH_OV.io.east_dout 
                    east_dout_v(J) := MIDDLESOUTH_OV.io.east_dout_v 
                    MIDDLESOUTH_OV.io.east_dout_r := east_dout_r(J)

                    // ********* South
                    // south_dout = open
                    // south_dout_v = open
                    MIDDLESOUTH_OV.io.south_dout_r := 0.U

                    // ********* West
                    interc_data_we(I-1)(J) := MIDDLESOUTH_OV.io.west_dout 
                    interc_valid_we(I-1)(J) := MIDDLESOUTH_OV.io.west_dout_v 
                    MIDDLESOUTH_OV.io.west_dout_r := interc_ready_we(I-1)(J)

                    // ********* Config
                    MIDDLESOUTH_OV.io.config_bits := config_bits
                    MIDDLESOUTH_OV.io.catch_config := catch_config(I+INPUT_NODES*J)
                }            
            }
        }    
    }


    // Fix 

    for( i <- 0 to OUTPUT_NODES - 1){
        vec_data_out(i) := east_dout(i)
        // // ==> Error: Cannot reassign to read-only
        //io.data_out(DATA_WIDTH*(i+1) - 1, DATA_WIDTH*i) := east_dout(i)
        vec_data_out_valid (i) := east_dout_v(i) 
        // io.data_out_valid(i) := east_dout_v(i) 
        east_dout_r(i) := io.data_out_ready(i)
    }
    
    // io.data_out_valid := east_dout_v.asUInt 
    io.data_out := vec_data_out.asUInt 
    io.data_out_valid := vec_data_out_valid.asUInt 

    // east_dout_r := io.data_out_ready   
     
}

// Generate the Verilog code
object OverlayRoccMain extends App {
    println("Generating the hardware")
    (new chisel3.stage.ChiselStage).emitVerilog(new OverlayRocc(32, 6, 6, 32), Array("--target-dir", "generated"))
}
