///////////////////////////////////////
//                                   //
//        Processing Element         //
//                                   //
///////////////////////////////////////

import chisel3._
import chisel3.util._

class ProcessingElement 
    (
        DATA_WIDTH: Int, 
        FIFO_DEPTH: Int
    ) 
    extends Module {
    val io = IO(new Bundle {
        //  Data in
        val north_din = Input(UInt(DATA_WIDTH.W))
        val north_din_v = Input(Bool())
        val north_din_r = Output(Bool())

        val east_din = Input(UInt(DATA_WIDTH.W))
        val east_din_v = Input(Bool())
        val east_din_r = Output(Bool())

        val south_din = Input(UInt(DATA_WIDTH.W))
        val south_din_v = Input(Bool())
        val south_din_r = Output(Bool())

        val west_din = Input(UInt(DATA_WIDTH.W))
        val west_din_v = Input(Bool())
        val west_din_r = Output(Bool())

        //  Data out
        val north_dout = Output(UInt(DATA_WIDTH.W))
        val north_dout_v = Output(Bool())
        val north_dout_r = Input(Bool())

        val east_dout = Output(UInt(DATA_WIDTH.W))
        val east_dout_v = Output(Bool())
        val east_dout_r = Input(Bool())

        val south_dout = Output(UInt(DATA_WIDTH.W))
        val south_dout_v = Output(Bool())
        val south_dout_r = Input(Bool())

        val west_dout = Output(UInt(DATA_WIDTH.W))
        val west_dout_v = Output(Bool())
        val west_dout_r = Input(Bool())
        
        //  Config
        val config_bits = Input(UInt(182.W))
        val catch_config = Input(Bool())
    })

    // Config signals
    val mux_N_sel = RegInit(0.U(2.W))
    val mux_E_sel = RegInit(0.U(2.W))
    val mux_S_sel = RegInit(0.U(2.W))
    val mux_W_sel = RegInit(0.U(2.W))
    val accept_mask_frN = RegInit(0.U(5.W))
    val accept_mask_frE = RegInit(0.U(5.W))
    val accept_mask_frS = RegInit(0.U(5.W))
    val accept_mask_frW = RegInit(0.U(5.W))
    val accept_mask_fsiN = RegInit(0.U(5.W))
    val accept_mask_fsiE = RegInit(0.U(5.W))
    val accept_mask_fsiS = RegInit(0.U(5.W))
    val accept_mask_fsiW = RegInit(0.U(5.W))
    val config_bits_reg = RegInit(0.U(182.W))
    
    //  Interconnect signals
    //  FIFO signals
    val north_buffer = RegInit(0.U(DATA_WIDTH.W))
    val east_buffer = RegInit(0.U(DATA_WIDTH.W))
    val south_buffer = RegInit(0.U(DATA_WIDTH.W))
    val west_buffer = RegInit(0.U(DATA_WIDTH.W))

    val north_buffer_v = RegInit(0.U(1.W))
    val east_buffer_v = RegInit(0.U(1.W))
    val south_buffer_v = RegInit(0.U(1.W))
    val west_buffer_v = RegInit(0.U(1.W))

    val north_buffer_r = RegInit(0.U(1.W))
    val east_buffer_r = RegInit(0.U(1.W))
    val south_buffer_r = RegInit(0.U(1.W))
    val west_buffer_r = RegInit(0.U(1.W))
    //  REG signals
    val north_REG_din = RegInit(0.U(DATA_WIDTH.W))
    val east_REG_din = RegInit(0.U(DATA_WIDTH.W))
    val south_REG_din = RegInit(0.U(DATA_WIDTH.W))
    val west_REG_din = RegInit(0.U(DATA_WIDTH.W))
    val north_REG_din_v = RegInit(0.U(1.W))
    val east_REG_din_v = RegInit(0.U(1.W))
    val south_REG_din_v = RegInit(0.U(1.W))
    val west_REG_din_v = RegInit(0.U(1.W))
    val north_REG_din_r = RegInit(0.U(1.W))
    val east_REG_din_r = RegInit(0.U(1.W))
    val south_REG_din_r = RegInit(0.U(1.W))
    val west_REG_din_r = RegInit(0.U(1.W))
    //  Cell processing signals
    val FU_din_1_r = RegInit(0.U(1.W))
    val FU_din_2_r = RegInit(0.U(1.W))
    val FU_dout = RegInit(0.U(DATA_WIDTH.W))
    val FU_dout_v = RegInit(0.U(1.W))
    val FU_dout_r = RegInit(0.U(1.W))

    when (io.catch_config) {
        config_bits_reg := io.config_bits
    }

    // Configuration bits arrangement
    mux_N_sel := config_bits_reg(7, 6)
    mux_E_sel := config_bits_reg(9, 8)
    mux_S_sel := config_bits_reg(11, 10)
    mux_W_sel := config_bits_reg(13, 12)
    // cell_interior conf
    accept_mask_fsiN := config_bits_reg(28, 24)
    accept_mask_fsiE := config_bits_reg(33, 29)
    accept_mask_fsiS := config_bits_reg(38, 34)
    accept_mask_fsiW := config_bits_reg(43, 39)
    // cell_interior conf
    accept_mask_frN := config_bits_reg(61, 57)
    accept_mask_frE := config_bits_reg(66, 62)
    accept_mask_frS := config_bits_reg(71, 67)
    accept_mask_frW := config_bits_reg(76, 72)
    
    // ------------------------------- NORTH NODE -------------------------------

    val FIFO_Nin = Module (new D_FIFO(DATA_WIDTH, FIFO_DEPTH))
    FIFO_Nin.io.din := io.north_din  
    FIFO_Nin.io.din_v := io.north_din_v
    FIFO_Nin.io.dout_r := north_buffer_r
    io.north_din_r := FIFO_Nin.io.din_r 
    north_buffer := FIFO_Nin.io.dout   
    north_buffer_v := FIFO_Nin.io.dout_v 

    val FS_Nin = Module (new FS(5))
    val ready_out_FS_Nin = Cat(FU_din_1_r, FU_din_2_r, east_REG_din_r, south_REG_din_r, west_REG_din_r)     
    FS_Nin.io.ready_out := ready_out_FS_Nin
    north_buffer_r := FS_Nin.io.ready_in
    FS_Nin.io.fork_mask := accept_mask_fsiN
    
    val MUX_Nout  = Module (new ConfMux(4, DATA_WIDTH))
    MUX_Nout.io.selector := mux_N_sel
    MUX_Nout.io.mux_input := Cat(west_buffer, south_buffer, east_buffer, FU_dout)  
    north_REG_din := MUX_Nout.io.mux_output
    
    val FR_Nout = Module (new FR(4, 5))
    val ready_FR_Nout = Cat(FU_din_1_r, FU_din_2_r, east_REG_din_r, south_REG_din_r, west_REG_din_r)  
    val valid_in_FR_Nout = Cat(west_buffer_v, south_buffer_v, east_buffer_v, FU_dout_v)  
    FR_Nout.io.ready_out := ready_FR_Nout
    FR_Nout.io.valid_in := valid_in_FR_Nout
    FR_Nout.io.valid_mux_sel := mux_N_sel
    FR_Nout.io.fork_mask := accept_mask_frN
    north_REG_din_v := FR_Nout.io.valid_out 

    val REG_Nout = Module (new D_REG(DATA_WIDTH))
    
    REG_Nout.io.din := north_REG_din 
    REG_Nout.io.din_v := north_REG_din_v 
    REG_Nout.io.dout_r := io.north_dout_r

    north_REG_din_r := REG_Nout.io.din_r
    io.north_dout := REG_Nout.io.dout  
    io.north_dout_v := REG_Nout.io.dout_v 
        
    //------------------------------- NORTH NODE -------------------------------

    // ------------------------------- EAST  NODE -------------------------------
    
    val FIFO_Ein = Module (new D_FIFO(DATA_WIDTH, FIFO_DEPTH))
    FIFO_Ein.io.din := io.east_din  
    FIFO_Ein.io.din_v := io.east_din_v
    FIFO_Ein.io.dout_r := east_buffer_r
    io.east_din_r := FIFO_Ein.io.din_r 
    east_buffer := FIFO_Ein.io.dout   
    east_buffer_v := FIFO_Ein.io.dout_v 

    val FS_Ein = Module (new FS(5))
    val ready_out_FS_Ein = Cat(FU_din_1_r, FU_din_2_r, north_REG_din_r, south_REG_din_r, west_REG_din_r)     
    FS_Ein.io.ready_out := ready_out_FS_Ein
    east_buffer_r := FS_Ein.io.ready_in
    FS_Ein.io.fork_mask := accept_mask_fsiE

    val MUX_Eout  = Module (new ConfMux(4, DATA_WIDTH))
    MUX_Eout.io.selector := mux_E_sel
    MUX_Eout.io.mux_input := Cat(west_buffer, south_buffer, north_buffer, FU_dout) 
    east_REG_din := MUX_Eout.io.mux_output
    
    val FR_Eout = Module (new FR(4, 5))
    val ready_FR_Eout = Cat(FU_din_1_r, FU_din_2_r, north_REG_din_r, south_REG_din_r, west_REG_din_r)  
    val valid_in_FR_Eout = Cat(west_buffer_v, south_buffer_v, north_buffer_v, FU_dout_v)  
    FR_Eout.io.ready_out := ready_FR_Eout
    FR_Eout.io.valid_in := valid_in_FR_Eout
    FR_Eout.io.valid_mux_sel := mux_E_sel
    FR_Eout.io.fork_mask := accept_mask_frE
    east_REG_din_v := FR_Eout.io.valid_out 

    val REG_Eout = Module (new D_REG(DATA_WIDTH))
    
    REG_Eout.io.din := east_REG_din 
    REG_Eout.io.din_v := east_REG_din_v 
    REG_Eout.io.dout_r := io.east_dout_r

    east_REG_din_r := REG_Eout.io.din_r
    io.east_dout := REG_Eout.io.dout  
    io.east_dout_v := REG_Eout.io.dout_v 
        
    // ------------------------------- EAST  NODE -------------------------------

    // ------------------------------- SOUTH NODE -------------------------------
    val FIFO_Sin = Module (new D_FIFO(DATA_WIDTH, FIFO_DEPTH))
    FIFO_Sin.io.din := io.south_din  
    FIFO_Sin.io.din_v := io.south_din_v
    FIFO_Sin.io.dout_r := south_buffer_r
    io.south_din_r := FIFO_Sin.io.din_r 
    south_buffer := FIFO_Sin.io.dout   
    south_buffer_v := FIFO_Sin.io.dout_v 

    val FS_Sin = Module (new FS(5))
    val ready_out_FS_Sin = Cat(FU_din_1_r, FU_din_2_r, north_REG_din_r, east_REG_din_r, west_REG_din_r)     
    FS_Sin.io.ready_out := ready_out_FS_Sin
    south_buffer_r := FS_Sin.io.ready_in
    FS_Sin.io.fork_mask := accept_mask_fsiS
    
    val MUX_Sout  = Module (new ConfMux(4, DATA_WIDTH))
    MUX_Sout.io.selector := mux_S_sel
    MUX_Sout.io.mux_input := Cat(west_buffer, east_buffer, north_buffer, FU_dout)
    south_REG_din := MUX_Sout.io.mux_output

    val FR_Sout = Module (new FR(4, 5))
    val ready_FR_Sout = Cat(FU_din_1_r, FU_din_2_r, north_REG_din_r, east_REG_din_r, west_REG_din_r)  
    val valid_in_FR_Sout = Cat(west_buffer_v, east_buffer_v, north_buffer_v, FU_dout_v)  
    FR_Sout.io.ready_out := ready_FR_Sout
    FR_Sout.io.valid_in := valid_in_FR_Sout
    FR_Sout.io.valid_mux_sel := mux_S_sel
    FR_Sout.io.fork_mask := accept_mask_frS
    south_REG_din_v := FR_Sout.io.valid_out 

    val REG_Sout = Module (new D_REG(DATA_WIDTH))
    
    REG_Sout.io.din := south_REG_din 
    REG_Sout.io.din_v := south_REG_din_v 
    REG_Sout.io.dout_r := io.south_dout_r

    south_REG_din_r := REG_Sout.io.din_r
    io.south_dout := REG_Sout.io.dout  
    io.south_dout_v := REG_Sout.io.dout_v 
    // ------------------------------- SOUTH NODE -------------------------------

    // ------------------------------- WEST  NODE -------------------------------

    val FIFO_Win = Module (new D_FIFO(DATA_WIDTH, FIFO_DEPTH))
    FIFO_Win.io.din := io.west_din  
    FIFO_Win.io.din_v := io.west_din_v
    FIFO_Win.io.dout_r := west_buffer_r
    io.west_din_r := FIFO_Win.io.din_r 
    west_buffer := FIFO_Win.io.dout   
    west_buffer_v := FIFO_Win.io.dout_v 

    val FS_Win = Module (new FS(5))
    val ready_out_FS_Win = Cat(FU_din_1_r, FU_din_2_r, north_REG_din_r, east_REG_din_r, south_REG_din_r)     
    FS_Win.io.ready_out := ready_out_FS_Win
    west_buffer_r := FS_Win.io.ready_in
    FS_Win.io.fork_mask :=  accept_mask_fsiW

    val MUX_Wout  = Module (new ConfMux(4, DATA_WIDTH))
    MUX_Wout.io.selector := mux_W_sel
    MUX_Wout.io.mux_input := Cat(south_buffer, east_buffer, north_buffer, FU_dout) 
    west_REG_din := MUX_Wout.io.mux_output

    val FR_Wout = Module (new FR(4, 5))
    val ready_FR_Wout = Cat(FU_din_1_r, FU_din_2_r, north_REG_din_r, east_REG_din_r, south_REG_din_r)  
    val valid_in_FR_Wout = Cat(south_buffer_v, east_buffer_v, north_buffer_v, FU_dout_v)  
    FR_Wout.io.ready_out := ready_FR_Wout
    FR_Wout.io.valid_in := valid_in_FR_Wout
    FR_Wout.io.valid_mux_sel := mux_W_sel
    FR_Wout.io.fork_mask := accept_mask_frW
    west_REG_din_v := FR_Wout.io.valid_out 

    val REG_Wout = Module (new D_REG(DATA_WIDTH))
    
    REG_Wout.io.din := west_REG_din 
    REG_Wout.io.din_v := west_REG_din_v 
    REG_Wout.io.dout_r := io.west_dout_r

    west_REG_din_r := REG_Wout.io.din_r
    io.west_dout := REG_Wout.io.dout  
    io.west_dout_v := REG_Wout.io.dout_v 
    // ------------------------------- WEST  NODE -------------------------------

    // Cell processing
    val CELL = Module (new CellProcessing(DATA_WIDTH))
    CELL.io.north_din := north_buffer
    CELL.io.north_din_v := north_buffer_v
    CELL.io.east_din := east_buffer
    CELL.io.east_din_v := east_buffer_v
    CELL.io.south_din := south_buffer
    CELL.io.south_din_v := south_buffer_v
    CELL.io.west_din := west_buffer
    CELL.io.west_din_v := west_buffer_v
    CELL.io.north_dout_r := north_REG_din_r
    CELL.io.east_dout_r := east_REG_din_r
    CELL.io.south_dout_r := south_REG_din_r
    CELL.io.west_dout_r := west_REG_din_r
    CELL.io.config_bits := config_bits_reg
   
    FU_din_1_r := CELL.io.FU_din_1_r 
    FU_din_2_r := CELL.io.FU_din_2_r 
    FU_dout := CELL.io.dout 
    FU_dout_v := CELL.io.dout_v   
}

// Generate the Verilog code
object ProcessingElementMain extends App {
    println("Generating the hardware")
    (new chisel3.stage.ChiselStage).emitVerilog(new ProcessingElement(32, 32), Array("--target-dir", "generated"))
}
