///////////////////////////////////////
//                                   //
//           Cell Processing         //
//                                   //
///////////////////////////////////////

import chisel3._
import chisel3.util._

class CellProcessing 
    (
        DATA_WIDTH: Int
    ) 
    extends Module {
    val io = IO(new Bundle {
        //  Data in
        val north_din = Input(UInt(DATA_WIDTH.W))
        val north_din_v = Input(Bool())
        val east_din = Input(UInt(DATA_WIDTH.W))
        val east_din_v = Input(Bool())
        val south_din = Input(UInt(DATA_WIDTH.W))
        val south_din_v = Input(Bool())
        val west_din = Input(UInt(DATA_WIDTH.W))
        val west_din_v = Input(Bool())
        val FU_din_1_r = Output(Bool())  
        val FU_din_2_r = Output(Bool())  
         
        //  Data out
        val dout = Output(UInt(DATA_WIDTH.W))
        val dout_v = Output(Bool())  
        val north_dout_r = Input(Bool())
        val east_dout_r = Input(Bool())
        val south_dout_r = Input(Bool())
        val west_dout_r = Input(Bool())
        
        //  Config
        val config_bits = Input(UInt(182.W))
    })

    //  Config signals
    /*****************/
    // Changing std_logic_vector
    /***************/

    val selector_mux_1 = Wire(UInt(3.W))
    val selector_mux_2 = Wire(UInt(3.W))
    val fork_receiver_mask_1 = Wire(UInt(4.W))
    val fork_receiver_mask_2 = Wire(UInt(4.W))
    val op_config = Wire(UInt(5.W))
    val fork_sender_mask = Wire(UInt(5.W))
    val I1_const = Wire(UInt(DATA_WIDTH.W))
    val initial_value_load = Wire(UInt(DATA_WIDTH.W))
    val iterations_reset_load = Wire(UInt(16.W))
    val fifo_length_load = Wire(UInt(16.W))
    val load_initial_value = Wire(UInt(2.W))
    
    /*
    val selector_mux_1 = RegInit(0.U(3.W))
    val selector_mux_2 = RegInit(0.U(3.W))
    val fork_receiver_mask_1 = RegInit(0.U(4.W))
    val fork_receiver_mask_2 = RegInit(0.U(4.W))
    val op_config = RegInit(0.U(5.W))
    val fork_sender_mask = RegInit(0.U(5.W))
    val I1_const = RegInit(0.U(DATA_WIDTH.W))
    val initial_value_load = RegInit(0.U(DATA_WIDTH.W))
    val iterations_reset_load = RegInit(0.U(16.W))
    val fifo_length_load = RegInit(0.U(16.W))
    val load_initial_value = RegInit(0.U(2.W))
    */
    /***************/
    
    //  Interconnect signals
    
    /*****************/
    // Changing std_logic_vector
    /***************/

    val FU_dout = Wire(UInt(DATA_WIDTH.W))
    
    val EB_din_1 = Wire(UInt(DATA_WIDTH.W))
    val EB_din_2 = Wire(UInt(DATA_WIDTH.W))
    val join_din_1 = Wire(UInt(DATA_WIDTH.W))
    val join_din_2 = Wire(UInt(DATA_WIDTH.W))

    
    /*
    val FU_dout = RegInit(0.U(DATA_WIDTH.W))
    
    val EB_din_1 = RegInit(0.U(DATA_WIDTH.W))
    val EB_din_2 = RegInit(0.U(DATA_WIDTH.W))
    val join_din_1 = RegInit(0.U(DATA_WIDTH.W))
    val join_din_2 = RegInit(0.U(DATA_WIDTH.W))
    */


    /********************************
    val join_dout_1 = RegInit(0.U(DATA_WIDTH.W))
    val join_dout_2 = RegInit(0.U(DATA_WIDTH.W))
    *********************************/
    val join_dout_1 = Wire(UInt(DATA_WIDTH.W))
    val join_dout_2 = Wire(UInt(DATA_WIDTH.W))

    
    val FU_dout_v = Wire(Bool())
   
    val FU_dout_r = Wire(Bool())
    val EB_din_1_v = Wire(Bool())
    val EB_din_2_v = Wire(Bool())
    /********************************
    val join_din_1_v = Wire(Bool())
    *********************************/
    val join_din_1_v = Wire(Bool())

    val join_din_1_r = Wire(Bool())
    /********************************
    val join_din_2_v = Wire(Bool())
    *********************************/
    val join_din_2_v = Wire(Bool())
    val join_din_2_r = Wire(Bool())
    val join_dout_v = Wire(Bool())
    val join_dout_r = Wire(Bool())
    val forked_dout_r = Wire(Bool())

    //  Configuration bits arrangement
    selector_mux_1 := io.config_bits(2, 0) 
    selector_mux_2 := io.config_bits(5, 3)
    fork_receiver_mask_1 := io.config_bits(17, 14)
    //  2 fill bits (19 ,  18)
    fork_receiver_mask_2 := io.config_bits(23, 20)
    //  structure conf
    op_config := io.config_bits(48, 44)
    //  3 fill bits (50 ,  48)
    fork_sender_mask := io.config_bits(56, 52)
    //  structure conf
    I1_const  := io.config_bits(115, 84)
    initial_value_load := io.config_bits(147, 116)  
    //  rest of config
    fifo_length_load := io.config_bits(163, 148)
    iterations_reset_load := io.config_bits(179, 164)
    load_initial_value := io.config_bits(181, 180)

    val FR_1 = Module (new FR(6, 4))
    val ready_FR1 = Cat(io.north_dout_r, io.east_dout_r, io.south_dout_r, io.west_dout_r)  
    val valid_in_FR1 = Cat(FU_dout_v.asUInt, "b1".U, io.west_din_v, io.south_din_v, io.east_din_v, io.north_din_v)  
    FR_1.io.ready_out := ready_FR1
    FR_1.io.valid_in := valid_in_FR1
    FR_1.io.valid_mux_sel := selector_mux_1
    FR_1.io.fork_mask := fork_receiver_mask_1 
    EB_din_1_v := FR_1.io.valid_out 

    val MUX_1 = Module (new ConfMux(6, DATA_WIDTH))
    MUX_1.io.selector := selector_mux_1
    MUX_1.io.mux_input := Cat(FU_dout, I1_const, io.west_din, io.south_din, io.east_din, io.north_din)
    /********************************
    EB_din_1 := MUX_1.io.mux_output
    ********************************/
    EB_din_1 := MUX_1.io.mux_output

    val FR_2 = Module (new FR(6, 4))
    val ready_FR2 = Cat(io.north_dout_r, io.east_dout_r, io.south_dout_r, io.west_dout_r)  
    val valid_in_FR2 = Cat(FU_dout_v.asUInt, "b1".U, io.west_din_v, io.south_din_v, io.east_din_v, io.north_din_v)  
    FR_2.io.ready_out := ready_FR2
    FR_2.io.valid_in := valid_in_FR2
    FR_2.io.valid_mux_sel := selector_mux_2
    FR_2.io.fork_mask := fork_receiver_mask_2 
    EB_din_2_v := FR_2.io.valid_out 

    val MUX_2 = Module (new ConfMux(6, DATA_WIDTH))
    MUX_2.io.selector := selector_mux_2
    MUX_2.io.mux_input := Cat(FU_dout, I1_const, io.west_din, io.south_din, io.east_din, io.north_din) 
    /*********************************
    EB_din_2 := MUX_2.io.mux_output
    *********************************/
    EB_din_2 := MUX_2.io.mux_output

    val EB_1 = Module (new D_EB(DATA_WIDTH))
    /**********************************
    EB_1.io.din := EB_din_1
    **********************************/
    EB_1.io.din := EB_din_1
    //EB_1.io.din := MUX_1.io.mux_output
    EB_1.io.din_v := EB_din_1_v
    io.FU_din_1_r := EB_1.io.din_r 
    /**********************************
    join_din_1 := EB_1.io.dout   
    join_din_1_v := EB_1.io.dout_v 
    **********************************/
    join_din_1 := EB_1.io.dout   
    join_din_1_v := EB_1.io.dout_v 
    EB_1.io.dout_r := join_din_1_r

    val EB_2 = Module (new D_EB(DATA_WIDTH))
    /*********************************
    EB_2.io.din := EB_din_2
    *********************************/
    EB_2.io.din := EB_din_2
    EB_2.io.din := MUX_2.io.mux_output
    EB_2.io.din_v := EB_din_2_v
    io.FU_din_2_r := EB_2.io.din_r 
    /*********************************
    join_din_2 := EB_2.io.dout   
    join_din_2_v := EB_2.io.dout_v
    *********************************/
    join_din_2 := EB_2.io.dout   
    join_din_2_v := EB_2.io.dout_v
    EB_2.io.dout_r := join_din_2_r 

    val JOIN_INST = Module (new Join(DATA_WIDTH))
    /**********************************
    JOIN_INST.io.din_1 := join_din_1
    JOIN_INST.io.din_2 := join_din_2
    *********************************/
    JOIN_INST.io.din_1 := join_din_1
    JOIN_INST.io.din_2 := join_din_2
    JOIN_INST.io.din_1 := EB_1.io.dout   
    JOIN_INST.io.din_2 := EB_2.io.dout   

    JOIN_INST.io.dout_r := join_dout_r
    /**********************************
    JOIN_INST.io.din_1_v := join_din_1_v
    JOIN_INST.io.din_2_v := join_din_2_v
    *********************************/
    JOIN_INST.io.din_1_v := join_din_1_v
    JOIN_INST.io.din_2_v := join_din_2_v
    JOIN_INST.io.din_1_v := EB_1.io.dout_v
    JOIN_INST.io.din_2_v := EB_2.io.dout_v

    join_dout_v := JOIN_INST.io.dout_v 
    join_din_1_r := JOIN_INST.io.din_1_r 
    join_din_2_r := JOIN_INST.io.din_2_r 
    /**********************************
    join_dout_1 := JOIN_INST.io.dout_1 
    join_dout_2 := JOIN_INST.io.dout_2 
    *********************************/
    join_dout_1 := JOIN_INST.io.dout_1 
    join_dout_2 := JOIN_INST.io.dout_2 

    val FU_INST = Module (new FU(DATA_WIDTH, 5))
    FU_INST.io.din_1 := JOIN_INST.io.dout_1 
    FU_INST.io.din_2 := JOIN_INST.io.dout_2 
    /**********************************
    FU_INST.io.din_1 := join_dout_1
    FU_INST.io.din_2 := join_dout_2
    *********************************/
    FU_INST.io.din_1 := join_dout_1
    FU_INST.io.din_2 := join_dout_2
    FU_INST.io.din_v := join_dout_v
    join_dout_r := FU_INST.io.din_r 
    FU_INST.io.loop_source := load_initial_value
    FU_INST.io.iterations_reset := iterations_reset_load 
    FU_INST.io.op_config := op_config 
    ////// Question ==> val valid_in_FR1 = Cat(FU_dout_v.asUInt, "b1".U, io.west_din_v, io.south_din_v, io.east_din_v, io.north_din_v)
    FU_dout := FU_INST.io.dout    
    FU_dout_v := FU_INST.io.dout_v
    
    FU_INST.io.dout_r := FU_dout_r

    val EB_OUT = Module (new D_EB(DATA_WIDTH))
    /**********************************
    EB_OUT.io.din := FU_dout
    EB_OUT.io.din_v := FU_dout_v
    *********************************/
    EB_OUT.io.din := FU_dout
    EB_OUT.io.din_v := FU_dout_v
    EB_OUT.io.din := FU_INST.io.dout    
    EB_OUT.io.din_v := FU_INST.io.dout_v

    FU_dout_r := EB_OUT.io.din_r
    io.dout := EB_OUT.io.dout   
    io.dout_v := EB_OUT.io.dout_v 
    EB_OUT.io.dout_r := forked_dout_r

    val FS = Module (new FS(5))
    val ready_out_FS = Cat("b1".U, io.north_dout_r, io.east_dout_r, io.south_dout_r, io.west_dout_r)     
    FS.io.ready_out := ready_out_FS
    forked_dout_r := FS.io.ready_in
    FS.io.fork_mask := fork_sender_mask
}

// Generate the Verilog code
object CellProcessingMain extends App {
    println("Generating the hardware")
    (new chisel3.stage.ChiselStage).emitVerilog(new CellProcessing(32), Array("--target-dir", "generated"))
}
