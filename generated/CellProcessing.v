module ConfMux(
  input  [2:0] io_selector,
  input  [5:0] io_mux_input,
  output       io_mux_output
);
  wire  inputs_0 = io_mux_input[0]; // @[ConfMux.scala 27:34]
  wire  inputs_1 = io_mux_input[1]; // @[ConfMux.scala 27:34]
  wire  inputs_2 = io_mux_input[2]; // @[ConfMux.scala 27:34]
  wire  inputs_3 = io_mux_input[3]; // @[ConfMux.scala 27:34]
  wire  inputs_4 = io_mux_input[4]; // @[ConfMux.scala 27:34]
  wire  inputs_5 = io_mux_input[5]; // @[ConfMux.scala 27:34]
  wire  _GEN_1 = 3'h1 == io_selector ? inputs_1 : inputs_0; // @[ConfMux.scala 30:{19,19}]
  wire  _GEN_2 = 3'h2 == io_selector ? inputs_2 : _GEN_1; // @[ConfMux.scala 30:{19,19}]
  wire  _GEN_3 = 3'h3 == io_selector ? inputs_3 : _GEN_2; // @[ConfMux.scala 30:{19,19}]
  wire  _GEN_4 = 3'h4 == io_selector ? inputs_4 : _GEN_3; // @[ConfMux.scala 30:{19,19}]
  assign io_mux_output = 3'h5 == io_selector ? inputs_5 : _GEN_4; // @[ConfMux.scala 30:{19,19}]
endmodule
module FR(
  input  [5:0] io_valid_in,
  input  [3:0] io_ready_out,
  input  [2:0] io_valid_mux_sel,
  input  [3:0] io_fork_mask,
  output       io_valid_out
);
  wire [2:0] conf_mux_io_selector; // @[FR.scala 29:28]
  wire [5:0] conf_mux_io_mux_input; // @[FR.scala 29:28]
  wire  conf_mux_io_mux_output; // @[FR.scala 29:28]
  wire  aux_0 = ~io_fork_mask[0] | io_ready_out[0]; // @[FR.scala 27:39]
  wire  aux_1 = ~io_fork_mask[1] | io_ready_out[1]; // @[FR.scala 27:39]
  wire  aux_2 = ~io_fork_mask[2] | io_ready_out[2]; // @[FR.scala 27:39]
  wire  aux_3 = ~io_fork_mask[3] | io_ready_out[3]; // @[FR.scala 27:39]
  wire  Vaux = conf_mux_io_mux_output; // @[FR.scala 24:20 32:28]
  wire  temp_1 = aux_0 & aux_1; // @[FR.scala 38:30]
  wire  temp_2 = temp_1 & aux_2; // @[FR.scala 38:30]
  wire  temp_3 = temp_2 & aux_3; // @[FR.scala 38:30]
  ConfMux conf_mux ( // @[FR.scala 29:28]
    .io_selector(conf_mux_io_selector),
    .io_mux_input(conf_mux_io_mux_input),
    .io_mux_output(conf_mux_io_mux_output)
  );
  assign io_valid_out = temp_3 & Vaux; // @[FR.scala 38:30]
  assign conf_mux_io_selector = io_valid_mux_sel; // @[FR.scala 30:26]
  assign conf_mux_io_mux_input = io_valid_in; // @[FR.scala 31:27]
endmodule
module ConfMux_1(
  input  [2:0]   io_selector,
  input  [191:0] io_mux_input,
  output [31:0]  io_mux_output
);
  wire [31:0] inputs_0 = io_mux_input[31:0]; // @[ConfMux.scala 27:34]
  wire [31:0] inputs_1 = io_mux_input[63:32]; // @[ConfMux.scala 27:34]
  wire [31:0] inputs_2 = io_mux_input[95:64]; // @[ConfMux.scala 27:34]
  wire [31:0] inputs_3 = io_mux_input[127:96]; // @[ConfMux.scala 27:34]
  wire [31:0] inputs_4 = io_mux_input[159:128]; // @[ConfMux.scala 27:34]
  wire [31:0] inputs_5 = io_mux_input[191:160]; // @[ConfMux.scala 27:34]
  wire [31:0] _GEN_1 = 3'h1 == io_selector ? inputs_1 : inputs_0; // @[ConfMux.scala 30:{19,19}]
  wire [31:0] _GEN_2 = 3'h2 == io_selector ? inputs_2 : _GEN_1; // @[ConfMux.scala 30:{19,19}]
  wire [31:0] _GEN_3 = 3'h3 == io_selector ? inputs_3 : _GEN_2; // @[ConfMux.scala 30:{19,19}]
  wire [31:0] _GEN_4 = 3'h4 == io_selector ? inputs_4 : _GEN_3; // @[ConfMux.scala 30:{19,19}]
  assign io_mux_output = 3'h5 == io_selector ? inputs_5 : _GEN_4; // @[ConfMux.scala 30:{19,19}]
endmodule
module RegEnable(
  input         clock,
  input         reset,
  input  [31:0] io_in,
  input         io_en,
  output [31:0] io_out
);
`ifdef RANDOMIZE_REG_INIT
  reg [31:0] _RAND_0;
`endif // RANDOMIZE_REG_INIT
  reg [31:0] reg_; // @[RegEnable.scala 11:22]
  assign io_out = reg_; // @[RegEnable.scala 15:12]
  always @(posedge clock) begin
    if (reset) begin // @[RegEnable.scala 11:22]
      reg_ <= 32'h0; // @[RegEnable.scala 11:22]
    end else if (io_en) begin // @[RegEnable.scala 12:17]
      reg_ <= io_in; // @[RegEnable.scala 13:13]
    end
  end
// Register and memory initialization
`ifdef RANDOMIZE_GARBAGE_ASSIGN
`define RANDOMIZE
`endif
`ifdef RANDOMIZE_INVALID_ASSIGN
`define RANDOMIZE
`endif
`ifdef RANDOMIZE_REG_INIT
`define RANDOMIZE
`endif
`ifdef RANDOMIZE_MEM_INIT
`define RANDOMIZE
`endif
`ifndef RANDOM
`define RANDOM $random
`endif
`ifdef RANDOMIZE_MEM_INIT
  integer initvar;
`endif
`ifndef SYNTHESIS
`ifdef FIRRTL_BEFORE_INITIAL
`FIRRTL_BEFORE_INITIAL
`endif
initial begin
  `ifdef RANDOMIZE
    `ifdef INIT_RANDOM
      `INIT_RANDOM
    `endif
    `ifndef VERILATOR
      `ifdef RANDOMIZE_DELAY
        #`RANDOMIZE_DELAY begin end
      `else
        #0.002 begin end
      `endif
    `endif
`ifdef RANDOMIZE_REG_INIT
  _RAND_0 = {1{`RANDOM}};
  reg_ = _RAND_0[31:0];
`endif // RANDOMIZE_REG_INIT
  `endif // RANDOMIZE
end // initial
`ifdef FIRRTL_AFTER_INITIAL
`FIRRTL_AFTER_INITIAL
`endif
`endif // SYNTHESIS
endmodule
module RegEnable_2(
  input   clock,
  input   reset,
  input   io_in,
  input   io_en,
  output  io_out
);
`ifdef RANDOMIZE_REG_INIT
  reg [31:0] _RAND_0;
`endif // RANDOMIZE_REG_INIT
  reg  reg_; // @[RegEnable.scala 11:22]
  assign io_out = reg_; // @[RegEnable.scala 15:12]
  always @(posedge clock) begin
    if (reset) begin // @[RegEnable.scala 11:22]
      reg_ <= 1'h0; // @[RegEnable.scala 11:22]
    end else if (io_en) begin // @[RegEnable.scala 12:17]
      reg_ <= io_in; // @[RegEnable.scala 13:13]
    end
  end
// Register and memory initialization
`ifdef RANDOMIZE_GARBAGE_ASSIGN
`define RANDOMIZE
`endif
`ifdef RANDOMIZE_INVALID_ASSIGN
`define RANDOMIZE
`endif
`ifdef RANDOMIZE_REG_INIT
`define RANDOMIZE
`endif
`ifdef RANDOMIZE_MEM_INIT
`define RANDOMIZE
`endif
`ifndef RANDOM
`define RANDOM $random
`endif
`ifdef RANDOMIZE_MEM_INIT
  integer initvar;
`endif
`ifndef SYNTHESIS
`ifdef FIRRTL_BEFORE_INITIAL
`FIRRTL_BEFORE_INITIAL
`endif
initial begin
  `ifdef RANDOMIZE
    `ifdef INIT_RANDOM
      `INIT_RANDOM
    `endif
    `ifndef VERILATOR
      `ifdef RANDOMIZE_DELAY
        #`RANDOMIZE_DELAY begin end
      `else
        #0.002 begin end
      `endif
    `endif
`ifdef RANDOMIZE_REG_INIT
  _RAND_0 = {1{`RANDOM}};
  reg_ = _RAND_0[0:0];
`endif // RANDOMIZE_REG_INIT
  `endif // RANDOMIZE
end // initial
`ifdef FIRRTL_AFTER_INITIAL
`FIRRTL_AFTER_INITIAL
`endif
`endif // SYNTHESIS
endmodule
module D_SEB(
  input         clock,
  input         reset,
  input  [31:0] io_din,
  input         io_din_v,
  output        io_din_r,
  output [31:0] io_dout,
  output        io_dout_v,
  input         io_dout_r
);
`ifdef RANDOMIZE_REG_INIT
  reg [31:0] _RAND_0;
`endif // RANDOMIZE_REG_INIT
  wire  main_clock; // @[D_SEB.scala 14:24]
  wire  main_reset; // @[D_SEB.scala 14:24]
  wire [31:0] main_io_in; // @[D_SEB.scala 14:24]
  wire  main_io_en; // @[D_SEB.scala 14:24]
  wire [31:0] main_io_out; // @[D_SEB.scala 14:24]
  wire  aux_clock; // @[D_SEB.scala 15:23]
  wire  aux_reset; // @[D_SEB.scala 15:23]
  wire [31:0] aux_io_in; // @[D_SEB.scala 15:23]
  wire  aux_io_en; // @[D_SEB.scala 15:23]
  wire [31:0] aux_io_out; // @[D_SEB.scala 15:23]
  wire  reg_1_clock; // @[D_SEB.scala 16:25]
  wire  reg_1_reset; // @[D_SEB.scala 16:25]
  wire  reg_1_io_in; // @[D_SEB.scala 16:25]
  wire  reg_1_io_en; // @[D_SEB.scala 16:25]
  wire  reg_1_io_out; // @[D_SEB.scala 16:25]
  wire  reg_2_clock; // @[D_SEB.scala 17:25]
  wire  reg_2_reset; // @[D_SEB.scala 17:25]
  wire  reg_2_io_in; // @[D_SEB.scala 17:25]
  wire  reg_2_io_en; // @[D_SEB.scala 17:25]
  wire  reg_2_io_out; // @[D_SEB.scala 17:25]
  reg  reg_; // @[D_SEB.scala 19:22]
  wire  mux2_out = reg_ ? reg_1_io_out : reg_2_io_out; // @[D_SEB.scala 23:23]
  RegEnable main ( // @[D_SEB.scala 14:24]
    .clock(main_clock),
    .reset(main_reset),
    .io_in(main_io_in),
    .io_en(main_io_en),
    .io_out(main_io_out)
  );
  RegEnable aux ( // @[D_SEB.scala 15:23]
    .clock(aux_clock),
    .reset(aux_reset),
    .io_in(aux_io_in),
    .io_en(aux_io_en),
    .io_out(aux_io_out)
  );
  RegEnable_2 reg_1 ( // @[D_SEB.scala 16:25]
    .clock(reg_1_clock),
    .reset(reg_1_reset),
    .io_in(reg_1_io_in),
    .io_en(reg_1_io_en),
    .io_out(reg_1_io_out)
  );
  RegEnable_2 reg_2 ( // @[D_SEB.scala 17:25]
    .clock(reg_2_clock),
    .reset(reg_2_reset),
    .io_in(reg_2_io_in),
    .io_en(reg_2_io_en),
    .io_out(reg_2_io_out)
  );
  assign io_din_r = reg_; // @[D_SEB.scala 25:20]
  assign io_dout = reg_ ? main_io_out : aux_io_out; // @[D_SEB.scala 41:19]
  assign io_dout_v = reg_ ? reg_1_io_out : reg_2_io_out; // @[D_SEB.scala 23:23]
  assign main_clock = clock;
  assign main_reset = reset;
  assign main_io_in = io_din; // @[D_SEB.scala 31:16]
  assign main_io_en = reg_; // @[D_SEB.scala 25:20]
  assign aux_clock = clock;
  assign aux_reset = reset;
  assign aux_io_in = main_io_out; // @[D_SEB.scala 32:15]
  assign aux_io_en = reg_; // @[D_SEB.scala 25:20]
  assign reg_1_clock = clock;
  assign reg_1_reset = reset;
  assign reg_1_io_in = io_din_v; // @[D_SEB.scala 33:17]
  assign reg_1_io_en = reg_; // @[D_SEB.scala 25:20]
  assign reg_2_clock = clock;
  assign reg_2_reset = reset;
  assign reg_2_io_in = reg_1_io_out; // @[D_SEB.scala 34:17]
  assign reg_2_io_en = reg_; // @[D_SEB.scala 25:20]
  always @(posedge clock) begin
    if (reset) begin // @[D_SEB.scala 19:22]
      reg_ <= 1'h0; // @[D_SEB.scala 19:22]
    end else begin
      reg_ <= io_dout_r | ~mux2_out; // @[D_SEB.scala 24:9]
    end
  end
// Register and memory initialization
`ifdef RANDOMIZE_GARBAGE_ASSIGN
`define RANDOMIZE
`endif
`ifdef RANDOMIZE_INVALID_ASSIGN
`define RANDOMIZE
`endif
`ifdef RANDOMIZE_REG_INIT
`define RANDOMIZE
`endif
`ifdef RANDOMIZE_MEM_INIT
`define RANDOMIZE
`endif
`ifndef RANDOM
`define RANDOM $random
`endif
`ifdef RANDOMIZE_MEM_INIT
  integer initvar;
`endif
`ifndef SYNTHESIS
`ifdef FIRRTL_BEFORE_INITIAL
`FIRRTL_BEFORE_INITIAL
`endif
initial begin
  `ifdef RANDOMIZE
    `ifdef INIT_RANDOM
      `INIT_RANDOM
    `endif
    `ifndef VERILATOR
      `ifdef RANDOMIZE_DELAY
        #`RANDOMIZE_DELAY begin end
      `else
        #0.002 begin end
      `endif
    `endif
`ifdef RANDOMIZE_REG_INIT
  _RAND_0 = {1{`RANDOM}};
  reg_ = _RAND_0[0:0];
`endif // RANDOMIZE_REG_INIT
  `endif // RANDOMIZE
end // initial
`ifdef FIRRTL_AFTER_INITIAL
`FIRRTL_AFTER_INITIAL
`endif
`endif // SYNTHESIS
endmodule
module Join(
  input  [31:0] io_din_1,
  input  [31:0] io_din_2,
  input         io_dout_r,
  input         io_din_1_v,
  input         io_din_2_v,
  output        io_dout_v,
  output        io_din_1_r,
  output        io_din_2_r,
  output [31:0] io_dout_1,
  output [31:0] io_dout_2
);
  assign io_dout_v = io_din_1_v & io_din_2_v; // @[Join.scala 24:29]
  assign io_din_1_r = io_din_2_v & io_dout_r; // @[Join.scala 26:30]
  assign io_din_2_r = io_din_1_v & io_dout_r; // @[Join.scala 27:30]
  assign io_dout_1 = io_din_1; // @[Join.scala 21:15]
  assign io_dout_2 = io_din_2; // @[Join.scala 22:15]
endmodule
module ALU(
  input  [31:0] io_din_1,
  input  [31:0] io_din_2,
  input  [3:0]  io_op_config,
  output [31:0] io_dout
);
  wire [31:0] _io_dout_T_1 = io_din_1 + io_din_2; // @[ALU.scala 30:27]
  wire [63:0] _io_dout_T_2 = io_din_1 * io_din_2; // @[ALU.scala 33:27]
  wire [31:0] _io_dout_T_4 = io_din_1 - io_din_2; // @[ALU.scala 36:27]
  wire [31:0] _io_dout_T_5 = io_din_1 >> io_din_2; // @[ALU.scala 43:27]
  wire [31:0] _io_dout_T_6 = io_din_1 & io_din_2; // @[ALU.scala 46:27]
  wire [31:0] _io_dout_T_7 = io_din_1 | io_din_2; // @[ALU.scala 49:27]
  wire [31:0] _io_dout_T_8 = io_din_1 ^ io_din_2; // @[ALU.scala 52:27]
  wire [31:0] _GEN_0 = io_din_1 > io_din_2 ? io_din_2 : 32'h0; // @[ALU.scala 28:13 58:38 59:17]
  wire [31:0] _GEN_1 = io_din_1 <= io_din_2 ? io_din_1 : _GEN_0; // @[ALU.scala 55:35 56:17]
  wire [31:0] _GEN_2 = io_din_1 < io_din_2 ? io_din_2 : 32'h0; // @[ALU.scala 28:13 66:38 67:17]
  wire [31:0] _GEN_3 = io_din_1 >= io_din_2 ? io_din_1 : _GEN_2; // @[ALU.scala 63:35 64:17]
  wire [31:0] _GEN_4 = io_op_config == 4'h9 ? _GEN_3 : 32'h0; // @[ALU.scala 62:38 71:15]
  wire [31:0] _GEN_5 = io_op_config == 4'h8 ? _GEN_1 : _GEN_4; // @[ALU.scala 54:38]
  wire [31:0] _GEN_6 = io_op_config == 4'h7 ? _io_dout_T_8 : _GEN_5; // @[ALU.scala 51:38 52:15]
  wire [31:0] _GEN_7 = io_op_config == 4'h6 ? _io_dout_T_7 : _GEN_6; // @[ALU.scala 48:37 49:15]
  wire [31:0] _GEN_8 = io_op_config == 4'h5 ? _io_dout_T_6 : _GEN_7; // @[ALU.scala 45:38 46:15]
  wire [31:0] _GEN_9 = io_op_config == 4'h4 ? _io_dout_T_5 : _GEN_8; // @[ALU.scala 42:38 43:15]
  wire [31:0] _GEN_10 = io_op_config == 4'h3 ? 32'h1 : _GEN_9; // @[ALU.scala 38:38 40:15]
  wire [31:0] _GEN_11 = io_op_config == 4'h2 ? _io_dout_T_4 : _GEN_10; // @[ALU.scala 35:38 36:15]
  wire [63:0] _GEN_12 = io_op_config == 4'h1 ? _io_dout_T_2 : {{32'd0}, _GEN_11}; // @[ALU.scala 32:38 33:15]
  wire [63:0] _GEN_13 = io_op_config == 4'h0 ? {{32'd0}, _io_dout_T_1} : _GEN_12; // @[ALU.scala 29:33 30:15]
  assign io_dout = _GEN_13[31:0];
endmodule
module FU(
  input         clock,
  input         reset,
  input  [31:0] io_din_1,
  input  [31:0] io_din_2,
  input         io_din_v,
  input         io_dout_r,
  input  [1:0]  io_loop_source,
  input  [15:0] io_iterations_reset,
  input  [3:0]  io_op_config,
  output        io_din_r,
  output [31:0] io_dout,
  output        io_dout_v
);
`ifdef RANDOMIZE_REG_INIT
  reg [31:0] _RAND_0;
  reg [31:0] _RAND_1;
  reg [31:0] _RAND_2;
  reg [31:0] _RAND_3;
  reg [31:0] _RAND_4;
  reg [31:0] _RAND_5;
  reg [31:0] _RAND_6;
`endif // RANDOMIZE_REG_INIT
  wire [31:0] ALU_io_din_1; // @[FU.scala 49:22]
  wire [31:0] ALU_io_din_2; // @[FU.scala 49:22]
  wire [3:0] ALU_io_op_config; // @[FU.scala 49:22]
  wire [31:0] ALU_io_dout; // @[FU.scala 49:22]
  reg [31:0] alu_din_1; // @[FU.scala 38:28]
  reg [31:0] alu_din_2; // @[FU.scala 39:28]
  reg [31:0] alu_dout; // @[FU.scala 40:27]
  reg [31:0] dout_Reg; // @[FU.scala 41:27]
  reg [15:0] count; // @[FU.scala 45:24]
  reg  loaded; // @[FU.scala 46:25]
  reg  valid; // @[FU.scala 47:24]
  wire  _T = io_loop_source == 2'h0; // @[FU.scala 56:26]
  wire  _T_1 = io_loop_source == 2'h1; // @[FU.scala 60:31]
  wire  _T_2 = ~loaded; // @[FU.scala 61:22]
  wire  _T_3 = io_loop_source == 2'h2; // @[FU.scala 70:31]
  wire [31:0] _GEN_3 = _T_2 ? io_din_2 : dout_Reg; // @[FU.scala 71:31 73:23 77:23]
  wire  _GEN_10 = io_dout_r ? 1'h0 : valid; // @[FU.scala 95:34 96:19 47:24]
  wire  _T_13 = _T_1 | _T_3; // @[FU.scala 99:42]
  wire  _T_14 = io_din_v & io_dout_r & _T_13; // @[FU.scala 98:53]
  wire [15:0] _count_T_1 = count + 16'h1; // @[FU.scala 102:29]
  wire  _T_19 = count == io_iterations_reset & _T_13; // @[FU.scala 104:45]
  wire  _T_21 = _T_19 & io_dout_r; // @[FU.scala 105:73]
  wire  _T_26 = _T_13 & io_din_v; // @[FU.scala 113:79]
  wire  _T_28 = _T_26 & io_dout_r; // @[FU.scala 114:37]
  wire  _GEN_16 = _T_21 | _GEN_10; // @[FU.scala 107:13 110:22]
  ALU ALU ( // @[FU.scala 49:22]
    .io_din_1(ALU_io_din_1),
    .io_din_2(ALU_io_din_2),
    .io_op_config(ALU_io_op_config),
    .io_dout(ALU_io_dout)
  );
  assign io_din_r = io_dout_r; // @[FU.scala 128:14]
  assign io_dout = _T ? alu_dout : dout_Reg; // @[FU.scala 130:38 131:17 134:17]
  assign io_dout_v = _T ? io_din_v : valid; // @[FU.scala 121:38 122:19 125:19]
  assign ALU_io_din_1 = alu_din_1; // @[FU.scala 50:18]
  assign ALU_io_din_2 = alu_din_2; // @[FU.scala 51:18]
  assign ALU_io_op_config = io_op_config; // @[FU.scala 53:22]
  always @(posedge clock) begin
    if (reset) begin // @[FU.scala 38:28]
      alu_din_1 <= 32'h0; // @[FU.scala 38:28]
    end else if (io_loop_source == 2'h0) begin // @[FU.scala 56:39]
      alu_din_1 <= io_din_1; // @[FU.scala 57:19]
    end else if (io_loop_source == 2'h1) begin // @[FU.scala 60:44]
      if (~loaded) begin // @[FU.scala 61:31]
        alu_din_1 <= io_din_1; // @[FU.scala 62:23]
      end else begin
        alu_din_1 <= dout_Reg; // @[FU.scala 66:23]
      end
    end else if (io_loop_source == 2'h2) begin // @[FU.scala 70:44]
      alu_din_1 <= io_din_1;
    end else begin
      alu_din_1 <= 32'h1f; // @[FU.scala 81:19]
    end
    if (reset) begin // @[FU.scala 39:28]
      alu_din_2 <= 32'h0; // @[FU.scala 39:28]
    end else if (io_loop_source == 2'h0) begin // @[FU.scala 56:39]
      alu_din_2 <= io_din_2; // @[FU.scala 58:19]
    end else if (io_loop_source == 2'h1) begin // @[FU.scala 60:44]
      alu_din_2 <= io_din_2;
    end else if (io_loop_source == 2'h2) begin // @[FU.scala 70:44]
      alu_din_2 <= _GEN_3;
    end else begin
      alu_din_2 <= 32'h1f; // @[FU.scala 82:19]
    end
    if (reset) begin // @[FU.scala 40:27]
      alu_dout <= 32'h0; // @[FU.scala 40:27]
    end else begin
      alu_dout <= ALU_io_dout; // @[FU.scala 52:14]
    end
    if (reset) begin // @[FU.scala 41:27]
      dout_Reg <= 32'h0; // @[FU.scala 41:27]
    end else if (_T_21) begin // @[FU.scala 107:13]
      dout_Reg <= alu_dout; // @[FU.scala 111:22]
    end else if (_T_28) begin // @[FU.scala 116:13]
      dout_Reg <= alu_dout; // @[FU.scala 117:22]
    end else begin
      dout_Reg <= 32'h0; // @[FU.scala 89:18]
    end
    if (reset) begin // @[FU.scala 45:24]
      count <= 16'hffff; // @[FU.scala 45:24]
    end else if (_T_21) begin // @[FU.scala 107:13]
      count <= 16'h0; // @[FU.scala 108:22]
    end else if (_T_14) begin // @[FU.scala 100:13]
      count <= _count_T_1; // @[FU.scala 102:20]
    end else begin
      count <= 16'h0; // @[FU.scala 88:15]
    end
    if (reset) begin // @[FU.scala 46:25]
      loaded <= 1'h0; // @[FU.scala 46:25]
    end else if (_T_21) begin // @[FU.scala 107:13]
      loaded <= 1'h0; // @[FU.scala 109:22]
    end else begin
      loaded <= _T_14;
    end
    if (reset) begin // @[FU.scala 47:24]
      valid <= 1'h0; // @[FU.scala 47:24]
    end else begin
      valid <= _GEN_16;
    end
  end
// Register and memory initialization
`ifdef RANDOMIZE_GARBAGE_ASSIGN
`define RANDOMIZE
`endif
`ifdef RANDOMIZE_INVALID_ASSIGN
`define RANDOMIZE
`endif
`ifdef RANDOMIZE_REG_INIT
`define RANDOMIZE
`endif
`ifdef RANDOMIZE_MEM_INIT
`define RANDOMIZE
`endif
`ifndef RANDOM
`define RANDOM $random
`endif
`ifdef RANDOMIZE_MEM_INIT
  integer initvar;
`endif
`ifndef SYNTHESIS
`ifdef FIRRTL_BEFORE_INITIAL
`FIRRTL_BEFORE_INITIAL
`endif
initial begin
  `ifdef RANDOMIZE
    `ifdef INIT_RANDOM
      `INIT_RANDOM
    `endif
    `ifndef VERILATOR
      `ifdef RANDOMIZE_DELAY
        #`RANDOMIZE_DELAY begin end
      `else
        #0.002 begin end
      `endif
    `endif
`ifdef RANDOMIZE_REG_INIT
  _RAND_0 = {1{`RANDOM}};
  alu_din_1 = _RAND_0[31:0];
  _RAND_1 = {1{`RANDOM}};
  alu_din_2 = _RAND_1[31:0];
  _RAND_2 = {1{`RANDOM}};
  alu_dout = _RAND_2[31:0];
  _RAND_3 = {1{`RANDOM}};
  dout_Reg = _RAND_3[31:0];
  _RAND_4 = {1{`RANDOM}};
  count = _RAND_4[15:0];
  _RAND_5 = {1{`RANDOM}};
  loaded = _RAND_5[0:0];
  _RAND_6 = {1{`RANDOM}};
  valid = _RAND_6[0:0];
`endif // RANDOMIZE_REG_INIT
  `endif // RANDOMIZE
end // initial
`ifdef FIRRTL_AFTER_INITIAL
`FIRRTL_AFTER_INITIAL
`endif
`endif // SYNTHESIS
endmodule
module FS(
  input  [4:0] io_ready_out,
  input  [4:0] io_fork_mask,
  output       io_ready_in
);
  wire  aux_0 = ~io_fork_mask[0] | io_ready_out[0]; // @[FS.scala 24:39]
  wire  aux_1 = ~io_fork_mask[1] | io_ready_out[1]; // @[FS.scala 24:39]
  wire  aux_2 = ~io_fork_mask[2] | io_ready_out[2]; // @[FS.scala 24:39]
  wire  aux_3 = ~io_fork_mask[3] | io_ready_out[3]; // @[FS.scala 24:39]
  wire  aux_4 = ~io_fork_mask[4] | io_ready_out[4]; // @[FS.scala 24:39]
  wire  temp_1 = aux_0 & aux_1; // @[FS.scala 30:30]
  wire  temp_2 = temp_1 & aux_2; // @[FS.scala 30:30]
  wire  temp_3 = temp_2 & aux_3; // @[FS.scala 30:30]
  assign io_ready_in = temp_3 & aux_4; // @[FS.scala 30:30]
endmodule
module CellProcessing(
  input          clock,
  input          reset,
  input  [31:0]  io_north_din,
  input          io_north_din_v,
  input  [31:0]  io_east_din,
  input          io_east_din_v,
  input  [31:0]  io_south_din,
  input          io_south_din_v,
  input  [31:0]  io_west_din,
  input          io_west_din_v,
  output         io_FU_din_1_r,
  output         io_FU_din_2_r,
  output [31:0]  io_dout,
  output         io_dout_v,
  input          io_north_dout_r,
  input          io_east_dout_r,
  input          io_south_dout_r,
  input          io_west_dout_r,
  input  [181:0] io_config_bits
);
`ifdef RANDOMIZE_REG_INIT
  reg [31:0] _RAND_0;
  reg [31:0] _RAND_1;
  reg [31:0] _RAND_2;
  reg [31:0] _RAND_3;
  reg [31:0] _RAND_4;
  reg [31:0] _RAND_5;
  reg [31:0] _RAND_6;
  reg [31:0] _RAND_7;
  reg [31:0] _RAND_8;
  reg [31:0] _RAND_9;
  reg [31:0] _RAND_10;
  reg [31:0] _RAND_11;
  reg [31:0] _RAND_12;
  reg [31:0] _RAND_13;
  reg [31:0] _RAND_14;
`endif // RANDOMIZE_REG_INIT
  wire [5:0] FR_1_io_valid_in; // @[CellProcessing.scala 88:23]
  wire [3:0] FR_1_io_ready_out; // @[CellProcessing.scala 88:23]
  wire [2:0] FR_1_io_valid_mux_sel; // @[CellProcessing.scala 88:23]
  wire [3:0] FR_1_io_fork_mask; // @[CellProcessing.scala 88:23]
  wire  FR_1_io_valid_out; // @[CellProcessing.scala 88:23]
  wire [2:0] MUX_1_io_selector; // @[CellProcessing.scala 97:25]
  wire [191:0] MUX_1_io_mux_input; // @[CellProcessing.scala 97:25]
  wire [31:0] MUX_1_io_mux_output; // @[CellProcessing.scala 97:25]
  wire  SEB_1_clock; // @[CellProcessing.scala 102:24]
  wire  SEB_1_reset; // @[CellProcessing.scala 102:24]
  wire [31:0] SEB_1_io_din; // @[CellProcessing.scala 102:24]
  wire  SEB_1_io_din_v; // @[CellProcessing.scala 102:24]
  wire  SEB_1_io_din_r; // @[CellProcessing.scala 102:24]
  wire [31:0] SEB_1_io_dout; // @[CellProcessing.scala 102:24]
  wire  SEB_1_io_dout_v; // @[CellProcessing.scala 102:24]
  wire  SEB_1_io_dout_r; // @[CellProcessing.scala 102:24]
  wire [5:0] FR_2_io_valid_in; // @[CellProcessing.scala 110:23]
  wire [3:0] FR_2_io_ready_out; // @[CellProcessing.scala 110:23]
  wire [2:0] FR_2_io_valid_mux_sel; // @[CellProcessing.scala 110:23]
  wire [3:0] FR_2_io_fork_mask; // @[CellProcessing.scala 110:23]
  wire  FR_2_io_valid_out; // @[CellProcessing.scala 110:23]
  wire [2:0] MUX_2_io_selector; // @[CellProcessing.scala 119:25]
  wire [191:0] MUX_2_io_mux_input; // @[CellProcessing.scala 119:25]
  wire [31:0] MUX_2_io_mux_output; // @[CellProcessing.scala 119:25]
  wire  SEB_2_clock; // @[CellProcessing.scala 124:24]
  wire  SEB_2_reset; // @[CellProcessing.scala 124:24]
  wire [31:0] SEB_2_io_din; // @[CellProcessing.scala 124:24]
  wire  SEB_2_io_din_v; // @[CellProcessing.scala 124:24]
  wire  SEB_2_io_din_r; // @[CellProcessing.scala 124:24]
  wire [31:0] SEB_2_io_dout; // @[CellProcessing.scala 124:24]
  wire  SEB_2_io_dout_v; // @[CellProcessing.scala 124:24]
  wire  SEB_2_io_dout_r; // @[CellProcessing.scala 124:24]
  wire [31:0] JOIN_INST_io_din_1; // @[CellProcessing.scala 132:28]
  wire [31:0] JOIN_INST_io_din_2; // @[CellProcessing.scala 132:28]
  wire  JOIN_INST_io_dout_r; // @[CellProcessing.scala 132:28]
  wire  JOIN_INST_io_din_1_v; // @[CellProcessing.scala 132:28]
  wire  JOIN_INST_io_din_2_v; // @[CellProcessing.scala 132:28]
  wire  JOIN_INST_io_dout_v; // @[CellProcessing.scala 132:28]
  wire  JOIN_INST_io_din_1_r; // @[CellProcessing.scala 132:28]
  wire  JOIN_INST_io_din_2_r; // @[CellProcessing.scala 132:28]
  wire [31:0] JOIN_INST_io_dout_1; // @[CellProcessing.scala 132:28]
  wire [31:0] JOIN_INST_io_dout_2; // @[CellProcessing.scala 132:28]
  wire  FU_INST_clock; // @[CellProcessing.scala 145:26]
  wire  FU_INST_reset; // @[CellProcessing.scala 145:26]
  wire [31:0] FU_INST_io_din_1; // @[CellProcessing.scala 145:26]
  wire [31:0] FU_INST_io_din_2; // @[CellProcessing.scala 145:26]
  wire  FU_INST_io_din_v; // @[CellProcessing.scala 145:26]
  wire  FU_INST_io_dout_r; // @[CellProcessing.scala 145:26]
  wire [1:0] FU_INST_io_loop_source; // @[CellProcessing.scala 145:26]
  wire [15:0] FU_INST_io_iterations_reset; // @[CellProcessing.scala 145:26]
  wire [3:0] FU_INST_io_op_config; // @[CellProcessing.scala 145:26]
  wire  FU_INST_io_din_r; // @[CellProcessing.scala 145:26]
  wire [31:0] FU_INST_io_dout; // @[CellProcessing.scala 145:26]
  wire  FU_INST_io_dout_v; // @[CellProcessing.scala 145:26]
  wire  SEB_OUT_clock; // @[CellProcessing.scala 158:26]
  wire  SEB_OUT_reset; // @[CellProcessing.scala 158:26]
  wire [31:0] SEB_OUT_io_din; // @[CellProcessing.scala 158:26]
  wire  SEB_OUT_io_din_v; // @[CellProcessing.scala 158:26]
  wire  SEB_OUT_io_din_r; // @[CellProcessing.scala 158:26]
  wire [31:0] SEB_OUT_io_dout; // @[CellProcessing.scala 158:26]
  wire  SEB_OUT_io_dout_v; // @[CellProcessing.scala 158:26]
  wire  SEB_OUT_io_dout_r; // @[CellProcessing.scala 158:26]
  wire [4:0] FS_io_ready_out; // @[CellProcessing.scala 166:21]
  wire [4:0] FS_io_fork_mask; // @[CellProcessing.scala 166:21]
  wire  FS_io_ready_in; // @[CellProcessing.scala 166:21]
  reg [2:0] selector_mux_1; // @[CellProcessing.scala 37:33]
  reg [2:0] selector_mux_2; // @[CellProcessing.scala 38:33]
  reg [3:0] fork_receiver_mask_1; // @[CellProcessing.scala 39:39]
  reg [3:0] fork_receiver_mask_2; // @[CellProcessing.scala 40:39]
  reg [4:0] op_config; // @[CellProcessing.scala 41:28]
  reg [4:0] fork_sender_mask; // @[CellProcessing.scala 42:35]
  reg [31:0] I1_const; // @[CellProcessing.scala 43:27]
  reg [15:0] iterations_reset_load; // @[CellProcessing.scala 45:40]
  reg [1:0] load_initial_value; // @[CellProcessing.scala 47:37]
  reg [31:0] FU_dout; // @[CellProcessing.scala 50:26]
  reg [31:0] EB_din_1; // @[CellProcessing.scala 51:27]
  reg [31:0] EB_din_2; // @[CellProcessing.scala 52:27]
  reg [31:0] join_din_1; // @[CellProcessing.scala 53:29]
  reg [31:0] join_dout_1; // @[CellProcessing.scala 55:30]
  reg [31:0] join_dout_2; // @[CellProcessing.scala 56:30]
  wire [1:0] ready_FR1_lo = {io_south_dout_r,io_west_dout_r}; // @[Cat.scala 31:58]
  wire [1:0] ready_FR1_hi = {io_north_dout_r,io_east_dout_r}; // @[Cat.scala 31:58]
  wire [2:0] valid_in_FR1_lo = {io_south_din_v,io_east_din_v,io_north_din_v}; // @[Cat.scala 31:58]
  wire  FU_dout_v = FU_INST_io_dout_v; // @[CellProcessing.scala 155:15 58:25]
  wire [2:0] valid_in_FR1_hi = {FU_dout_v,1'h1,io_west_din_v}; // @[Cat.scala 31:58]
  wire [31:0] _MUX_1_io_mux_input_T = FU_dout & I1_const; // @[CellProcessing.scala 99:35]
  wire [31:0] _MUX_1_io_mux_input_T_1 = _MUX_1_io_mux_input_T & io_west_din; // @[CellProcessing.scala 99:46]
  wire [31:0] _MUX_1_io_mux_input_T_2 = _MUX_1_io_mux_input_T_1 & io_south_din; // @[CellProcessing.scala 99:60]
  wire [31:0] _MUX_1_io_mux_input_T_3 = _MUX_1_io_mux_input_T_2 & io_east_din; // @[CellProcessing.scala 99:75]
  wire [31:0] _MUX_1_io_mux_input_T_4 = _MUX_1_io_mux_input_T_3 & io_north_din; // @[CellProcessing.scala 99:89]
  wire [2:0] ready_out_FS_hi = {1'h1,io_north_dout_r,io_east_dout_r}; // @[Cat.scala 31:58]
  wire  join_din_1_v = SEB_1_io_dout_v; // @[CellProcessing.scala 107:18 62:28]
  FR FR_1 ( // @[CellProcessing.scala 88:23]
    .io_valid_in(FR_1_io_valid_in),
    .io_ready_out(FR_1_io_ready_out),
    .io_valid_mux_sel(FR_1_io_valid_mux_sel),
    .io_fork_mask(FR_1_io_fork_mask),
    .io_valid_out(FR_1_io_valid_out)
  );
  ConfMux_1 MUX_1 ( // @[CellProcessing.scala 97:25]
    .io_selector(MUX_1_io_selector),
    .io_mux_input(MUX_1_io_mux_input),
    .io_mux_output(MUX_1_io_mux_output)
  );
  D_SEB SEB_1 ( // @[CellProcessing.scala 102:24]
    .clock(SEB_1_clock),
    .reset(SEB_1_reset),
    .io_din(SEB_1_io_din),
    .io_din_v(SEB_1_io_din_v),
    .io_din_r(SEB_1_io_din_r),
    .io_dout(SEB_1_io_dout),
    .io_dout_v(SEB_1_io_dout_v),
    .io_dout_r(SEB_1_io_dout_r)
  );
  FR FR_2 ( // @[CellProcessing.scala 110:23]
    .io_valid_in(FR_2_io_valid_in),
    .io_ready_out(FR_2_io_ready_out),
    .io_valid_mux_sel(FR_2_io_valid_mux_sel),
    .io_fork_mask(FR_2_io_fork_mask),
    .io_valid_out(FR_2_io_valid_out)
  );
  ConfMux_1 MUX_2 ( // @[CellProcessing.scala 119:25]
    .io_selector(MUX_2_io_selector),
    .io_mux_input(MUX_2_io_mux_input),
    .io_mux_output(MUX_2_io_mux_output)
  );
  D_SEB SEB_2 ( // @[CellProcessing.scala 124:24]
    .clock(SEB_2_clock),
    .reset(SEB_2_reset),
    .io_din(SEB_2_io_din),
    .io_din_v(SEB_2_io_din_v),
    .io_din_r(SEB_2_io_din_r),
    .io_dout(SEB_2_io_dout),
    .io_dout_v(SEB_2_io_dout_v),
    .io_dout_r(SEB_2_io_dout_r)
  );
  Join JOIN_INST ( // @[CellProcessing.scala 132:28]
    .io_din_1(JOIN_INST_io_din_1),
    .io_din_2(JOIN_INST_io_din_2),
    .io_dout_r(JOIN_INST_io_dout_r),
    .io_din_1_v(JOIN_INST_io_din_1_v),
    .io_din_2_v(JOIN_INST_io_din_2_v),
    .io_dout_v(JOIN_INST_io_dout_v),
    .io_din_1_r(JOIN_INST_io_din_1_r),
    .io_din_2_r(JOIN_INST_io_din_2_r),
    .io_dout_1(JOIN_INST_io_dout_1),
    .io_dout_2(JOIN_INST_io_dout_2)
  );
  FU FU_INST ( // @[CellProcessing.scala 145:26]
    .clock(FU_INST_clock),
    .reset(FU_INST_reset),
    .io_din_1(FU_INST_io_din_1),
    .io_din_2(FU_INST_io_din_2),
    .io_din_v(FU_INST_io_din_v),
    .io_dout_r(FU_INST_io_dout_r),
    .io_loop_source(FU_INST_io_loop_source),
    .io_iterations_reset(FU_INST_io_iterations_reset),
    .io_op_config(FU_INST_io_op_config),
    .io_din_r(FU_INST_io_din_r),
    .io_dout(FU_INST_io_dout),
    .io_dout_v(FU_INST_io_dout_v)
  );
  D_SEB SEB_OUT ( // @[CellProcessing.scala 158:26]
    .clock(SEB_OUT_clock),
    .reset(SEB_OUT_reset),
    .io_din(SEB_OUT_io_din),
    .io_din_v(SEB_OUT_io_din_v),
    .io_din_r(SEB_OUT_io_din_r),
    .io_dout(SEB_OUT_io_dout),
    .io_dout_v(SEB_OUT_io_dout_v),
    .io_dout_r(SEB_OUT_io_dout_r)
  );
  FS FS ( // @[CellProcessing.scala 166:21]
    .io_ready_out(FS_io_ready_out),
    .io_fork_mask(FS_io_fork_mask),
    .io_ready_in(FS_io_ready_in)
  );
  assign io_FU_din_1_r = SEB_1_io_din_r; // @[CellProcessing.scala 105:20]
  assign io_FU_din_2_r = SEB_2_io_din_r; // @[CellProcessing.scala 127:19]
  assign io_dout = SEB_OUT_io_dout; // @[CellProcessing.scala 162:13]
  assign io_dout_v = SEB_OUT_io_dout_v; // @[CellProcessing.scala 163:15]
  assign FR_1_io_valid_in = {valid_in_FR1_hi,valid_in_FR1_lo}; // @[Cat.scala 31:58]
  assign FR_1_io_ready_out = {ready_FR1_hi,ready_FR1_lo}; // @[Cat.scala 31:58]
  assign FR_1_io_valid_mux_sel = selector_mux_1; // @[CellProcessing.scala 93:27]
  assign FR_1_io_fork_mask = fork_receiver_mask_1; // @[CellProcessing.scala 94:23]
  assign MUX_1_io_selector = selector_mux_1; // @[CellProcessing.scala 98:23]
  assign MUX_1_io_mux_input = {{160'd0}, _MUX_1_io_mux_input_T_4}; // @[CellProcessing.scala 99:24]
  assign SEB_1_clock = clock;
  assign SEB_1_reset = reset;
  assign SEB_1_io_din = EB_din_1; // @[CellProcessing.scala 103:18]
  assign SEB_1_io_din_v = FR_1_io_valid_out; // @[CellProcessing.scala 60:26 95:16]
  assign SEB_1_io_dout_r = JOIN_INST_io_din_1_r; // @[CellProcessing.scala 140:18 63:28]
  assign FR_2_io_valid_in = {valid_in_FR1_hi,valid_in_FR1_lo}; // @[Cat.scala 31:58]
  assign FR_2_io_ready_out = {ready_FR1_hi,ready_FR1_lo}; // @[Cat.scala 31:58]
  assign FR_2_io_valid_mux_sel = selector_mux_2; // @[CellProcessing.scala 115:27]
  assign FR_2_io_fork_mask = fork_receiver_mask_2; // @[CellProcessing.scala 116:23]
  assign MUX_2_io_selector = selector_mux_2; // @[CellProcessing.scala 120:23]
  assign MUX_2_io_mux_input = {{160'd0}, _MUX_1_io_mux_input_T_4}; // @[CellProcessing.scala 121:24]
  assign SEB_2_clock = clock;
  assign SEB_2_reset = reset;
  assign SEB_2_io_din = EB_din_2; // @[CellProcessing.scala 125:18]
  assign SEB_2_io_din_v = FR_2_io_valid_out; // @[CellProcessing.scala 117:16 61:26]
  assign SEB_2_io_dout_r = JOIN_INST_io_din_2_r; // @[CellProcessing.scala 141:18 65:28]
  assign JOIN_INST_io_din_1 = join_din_1; // @[CellProcessing.scala 133:24]
  assign JOIN_INST_io_din_2 = {{31'd0}, join_din_1_v}; // @[CellProcessing.scala 134:24]
  assign JOIN_INST_io_dout_r = FU_INST_io_din_r; // @[CellProcessing.scala 149:17 67:27]
  assign JOIN_INST_io_din_1_v = SEB_1_io_dout_v; // @[CellProcessing.scala 107:18 62:28]
  assign JOIN_INST_io_din_2_v = SEB_1_io_dout_v; // @[CellProcessing.scala 129:18 64:28]
  assign FU_INST_clock = clock;
  assign FU_INST_reset = reset;
  assign FU_INST_io_din_1 = join_dout_1; // @[CellProcessing.scala 146:22]
  assign FU_INST_io_din_2 = join_dout_2; // @[CellProcessing.scala 147:22]
  assign FU_INST_io_din_v = JOIN_INST_io_dout_v; // @[CellProcessing.scala 139:17 66:27]
  assign FU_INST_io_dout_r = SEB_OUT_io_din_r; // @[CellProcessing.scala 161:15 59:25]
  assign FU_INST_io_loop_source = load_initial_value; // @[CellProcessing.scala 150:28]
  assign FU_INST_io_iterations_reset = iterations_reset_load; // @[CellProcessing.scala 151:33]
  assign FU_INST_io_op_config = op_config[3:0]; // @[CellProcessing.scala 152:26]
  assign SEB_OUT_clock = clock;
  assign SEB_OUT_reset = reset;
  assign SEB_OUT_io_din = FU_dout; // @[CellProcessing.scala 159:20]
  assign SEB_OUT_io_din_v = FU_INST_io_dout_v; // @[CellProcessing.scala 155:15 58:25]
  assign SEB_OUT_io_dout_r = FS_io_ready_in; // @[CellProcessing.scala 169:19 68:29]
  assign FS_io_ready_out = {ready_out_FS_hi,ready_FR1_lo}; // @[Cat.scala 31:58]
  assign FS_io_fork_mask = fork_sender_mask; // @[CellProcessing.scala 170:21]
  always @(posedge clock) begin
    if (reset) begin // @[CellProcessing.scala 37:33]
      selector_mux_1 <= 3'h0; // @[CellProcessing.scala 37:33]
    end else begin
      selector_mux_1 <= io_config_bits[2:0]; // @[CellProcessing.scala 71:20]
    end
    if (reset) begin // @[CellProcessing.scala 38:33]
      selector_mux_2 <= 3'h0; // @[CellProcessing.scala 38:33]
    end else begin
      selector_mux_2 <= io_config_bits[5:3]; // @[CellProcessing.scala 72:20]
    end
    if (reset) begin // @[CellProcessing.scala 39:39]
      fork_receiver_mask_1 <= 4'h0; // @[CellProcessing.scala 39:39]
    end else begin
      fork_receiver_mask_1 <= io_config_bits[17:14]; // @[CellProcessing.scala 73:26]
    end
    if (reset) begin // @[CellProcessing.scala 40:39]
      fork_receiver_mask_2 <= 4'h0; // @[CellProcessing.scala 40:39]
    end else begin
      fork_receiver_mask_2 <= io_config_bits[23:20]; // @[CellProcessing.scala 75:26]
    end
    if (reset) begin // @[CellProcessing.scala 41:28]
      op_config <= 5'h0; // @[CellProcessing.scala 41:28]
    end else begin
      op_config <= io_config_bits[48:44]; // @[CellProcessing.scala 77:15]
    end
    if (reset) begin // @[CellProcessing.scala 42:35]
      fork_sender_mask <= 5'h0; // @[CellProcessing.scala 42:35]
    end else begin
      fork_sender_mask <= io_config_bits[56:52]; // @[CellProcessing.scala 79:22]
    end
    if (reset) begin // @[CellProcessing.scala 43:27]
      I1_const <= 32'h0; // @[CellProcessing.scala 43:27]
    end else begin
      I1_const <= io_config_bits[115:84]; // @[CellProcessing.scala 81:15]
    end
    if (reset) begin // @[CellProcessing.scala 45:40]
      iterations_reset_load <= 16'h0; // @[CellProcessing.scala 45:40]
    end else begin
      iterations_reset_load <= io_config_bits[179:164]; // @[CellProcessing.scala 85:27]
    end
    if (reset) begin // @[CellProcessing.scala 47:37]
      load_initial_value <= 2'h0; // @[CellProcessing.scala 47:37]
    end else begin
      load_initial_value <= io_config_bits[181:180]; // @[CellProcessing.scala 86:24]
    end
    if (reset) begin // @[CellProcessing.scala 50:26]
      FU_dout <= 32'h0; // @[CellProcessing.scala 50:26]
    end else begin
      FU_dout <= FU_INST_io_dout; // @[CellProcessing.scala 154:13]
    end
    if (reset) begin // @[CellProcessing.scala 51:27]
      EB_din_1 <= 32'h0; // @[CellProcessing.scala 51:27]
    end else begin
      EB_din_1 <= MUX_1_io_mux_output; // @[CellProcessing.scala 100:14]
    end
    if (reset) begin // @[CellProcessing.scala 52:27]
      EB_din_2 <= 32'h0; // @[CellProcessing.scala 52:27]
    end else begin
      EB_din_2 <= MUX_2_io_mux_output; // @[CellProcessing.scala 122:14]
    end
    if (reset) begin // @[CellProcessing.scala 53:29]
      join_din_1 <= 32'h0; // @[CellProcessing.scala 53:29]
    end else begin
      join_din_1 <= SEB_1_io_dout; // @[CellProcessing.scala 106:16]
    end
    if (reset) begin // @[CellProcessing.scala 55:30]
      join_dout_1 <= 32'h0; // @[CellProcessing.scala 55:30]
    end else begin
      join_dout_1 <= JOIN_INST_io_dout_1; // @[CellProcessing.scala 142:17]
    end
    if (reset) begin // @[CellProcessing.scala 56:30]
      join_dout_2 <= 32'h0; // @[CellProcessing.scala 56:30]
    end else begin
      join_dout_2 <= JOIN_INST_io_dout_2; // @[CellProcessing.scala 143:17]
    end
  end
// Register and memory initialization
`ifdef RANDOMIZE_GARBAGE_ASSIGN
`define RANDOMIZE
`endif
`ifdef RANDOMIZE_INVALID_ASSIGN
`define RANDOMIZE
`endif
`ifdef RANDOMIZE_REG_INIT
`define RANDOMIZE
`endif
`ifdef RANDOMIZE_MEM_INIT
`define RANDOMIZE
`endif
`ifndef RANDOM
`define RANDOM $random
`endif
`ifdef RANDOMIZE_MEM_INIT
  integer initvar;
`endif
`ifndef SYNTHESIS
`ifdef FIRRTL_BEFORE_INITIAL
`FIRRTL_BEFORE_INITIAL
`endif
initial begin
  `ifdef RANDOMIZE
    `ifdef INIT_RANDOM
      `INIT_RANDOM
    `endif
    `ifndef VERILATOR
      `ifdef RANDOMIZE_DELAY
        #`RANDOMIZE_DELAY begin end
      `else
        #0.002 begin end
      `endif
    `endif
`ifdef RANDOMIZE_REG_INIT
  _RAND_0 = {1{`RANDOM}};
  selector_mux_1 = _RAND_0[2:0];
  _RAND_1 = {1{`RANDOM}};
  selector_mux_2 = _RAND_1[2:0];
  _RAND_2 = {1{`RANDOM}};
  fork_receiver_mask_1 = _RAND_2[3:0];
  _RAND_3 = {1{`RANDOM}};
  fork_receiver_mask_2 = _RAND_3[3:0];
  _RAND_4 = {1{`RANDOM}};
  op_config = _RAND_4[4:0];
  _RAND_5 = {1{`RANDOM}};
  fork_sender_mask = _RAND_5[4:0];
  _RAND_6 = {1{`RANDOM}};
  I1_const = _RAND_6[31:0];
  _RAND_7 = {1{`RANDOM}};
  iterations_reset_load = _RAND_7[15:0];
  _RAND_8 = {1{`RANDOM}};
  load_initial_value = _RAND_8[1:0];
  _RAND_9 = {1{`RANDOM}};
  FU_dout = _RAND_9[31:0];
  _RAND_10 = {1{`RANDOM}};
  EB_din_1 = _RAND_10[31:0];
  _RAND_11 = {1{`RANDOM}};
  EB_din_2 = _RAND_11[31:0];
  _RAND_12 = {1{`RANDOM}};
  join_din_1 = _RAND_12[31:0];
  _RAND_13 = {1{`RANDOM}};
  join_dout_1 = _RAND_13[31:0];
  _RAND_14 = {1{`RANDOM}};
  join_dout_2 = _RAND_14[31:0];
`endif // RANDOMIZE_REG_INIT
  `endif // RANDOMIZE
end // initial
`ifdef FIRRTL_AFTER_INITIAL
`FIRRTL_AFTER_INITIAL
`endif
`endif // SYNTHESIS
endmodule
