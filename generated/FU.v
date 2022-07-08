module ALU(
  input  [7:0] io_din_1,
  input  [7:0] io_din_2,
  input  [7:0] io_op_config,
  output [7:0] io_dout
);
  wire [7:0] _io_dout_T_1 = io_din_1 + io_din_2; // @[ALU.scala 30:27]
  wire [15:0] _io_dout_T_2 = io_din_1 * io_din_2; // @[ALU.scala 33:27]
  wire [7:0] _io_dout_T_4 = io_din_1 - io_din_2; // @[ALU.scala 36:27]
  wire [262:0] _GEN_14 = {{255'd0}, io_din_1}; // @[ALU.scala 39:27]
  wire [262:0] _io_dout_T_5 = _GEN_14 << io_din_2; // @[ALU.scala 39:27]
  wire [7:0] _io_dout_T_6 = io_din_1 >> io_din_2; // @[ALU.scala 42:27]
  wire [7:0] _io_dout_T_7 = io_din_1 & io_din_2; // @[ALU.scala 45:27]
  wire [7:0] _io_dout_T_8 = io_din_1 | io_din_2; // @[ALU.scala 48:27]
  wire [7:0] _io_dout_T_9 = io_din_1 ^ io_din_2; // @[ALU.scala 51:27]
  wire [7:0] _GEN_0 = io_din_1 > io_din_2 ? io_din_2 : 8'h0; // @[ALU.scala 28:13 57:38 58:17]
  wire [7:0] _GEN_1 = io_din_1 <= io_din_2 ? io_din_1 : _GEN_0; // @[ALU.scala 54:35 55:17]
  wire [7:0] _GEN_2 = io_din_1 < io_din_2 ? io_din_2 : 8'h0; // @[ALU.scala 28:13 65:38 66:17]
  wire [7:0] _GEN_3 = io_din_1 >= io_din_2 ? io_din_1 : _GEN_2; // @[ALU.scala 62:35 63:17]
  wire [7:0] _GEN_4 = io_op_config == 8'h9 ? _GEN_3 : 8'h0; // @[ALU.scala 61:38 70:15]
  wire [7:0] _GEN_5 = io_op_config == 8'h8 ? _GEN_1 : _GEN_4; // @[ALU.scala 53:38]
  wire [7:0] _GEN_6 = io_op_config == 8'h7 ? _io_dout_T_9 : _GEN_5; // @[ALU.scala 50:38 51:15]
  wire [7:0] _GEN_7 = io_op_config == 8'h6 ? _io_dout_T_8 : _GEN_6; // @[ALU.scala 47:37 48:15]
  wire [7:0] _GEN_8 = io_op_config == 8'h5 ? _io_dout_T_7 : _GEN_7; // @[ALU.scala 44:38 45:15]
  wire [7:0] _GEN_9 = io_op_config == 8'h4 ? _io_dout_T_6 : _GEN_8; // @[ALU.scala 41:38 42:15]
  wire [262:0] _GEN_10 = io_op_config == 8'h3 ? _io_dout_T_5 : {{255'd0}, _GEN_9}; // @[ALU.scala 38:38 39:15]
  wire [262:0] _GEN_11 = io_op_config == 8'h2 ? {{255'd0}, _io_dout_T_4} : _GEN_10; // @[ALU.scala 35:38 36:15]
  wire [262:0] _GEN_12 = io_op_config == 8'h1 ? {{247'd0}, _io_dout_T_2} : _GEN_11; // @[ALU.scala 32:38 33:15]
  wire [262:0] _GEN_13 = io_op_config == 8'h0 ? {{255'd0}, _io_dout_T_1} : _GEN_12; // @[ALU.scala 29:33 30:15]
  assign io_dout = _GEN_13[7:0];
endmodule
module FU(
  input         clock,
  input         reset,
  input  [7:0]  io_din_1,
  input  [7:0]  io_din_2,
  input         io_din_v,
  output        io_din_r,
  output [7:0]  io_dout,
  output        io_dout_v,
  input         io_dout_r,
  input  [1:0]  io_loop_source,
  input  [15:0] io_iterations_reset,
  input  [7:0]  io_op_config
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
  wire [7:0] ALU_io_din_1; // @[FU.scala 44:22]
  wire [7:0] ALU_io_din_2; // @[FU.scala 44:22]
  wire [7:0] ALU_io_op_config; // @[FU.scala 44:22]
  wire [7:0] ALU_io_dout; // @[FU.scala 44:22]
  reg [7:0] alu_din_1; // @[FU.scala 33:28]
  reg [7:0] alu_din_2; // @[FU.scala 34:28]
  reg [7:0] alu_dout; // @[FU.scala 35:27]
  reg [7:0] dout_Reg; // @[FU.scala 36:27]
  reg [15:0] count; // @[FU.scala 40:24]
  reg  loaded; // @[FU.scala 41:25]
  reg  valid; // @[FU.scala 42:24]
  wire  _T = io_loop_source == 2'h0; // @[FU.scala 51:26]
  wire  _T_1 = io_loop_source == 2'h1; // @[FU.scala 55:31]
  wire  _T_2 = ~loaded; // @[FU.scala 56:22]
  wire  _T_3 = io_loop_source == 2'h2; // @[FU.scala 65:31]
  wire [7:0] _GEN_3 = _T_2 ? io_din_2 : dout_Reg; // @[FU.scala 66:31 68:23 72:23]
  wire  _GEN_10 = io_dout_r ? 1'h0 : valid; // @[FU.scala 90:34 91:19 42:24]
  wire  _T_13 = _T_1 | _T_3; // @[FU.scala 94:42]
  wire  _T_14 = io_din_v & io_dout_r & _T_13; // @[FU.scala 93:53]
  wire [15:0] _count_T_1 = count + 16'h1; // @[FU.scala 97:29]
  wire  _T_19 = count == io_iterations_reset & _T_13; // @[FU.scala 99:45]
  wire  _T_21 = _T_19 & io_dout_r; // @[FU.scala 100:73]
  wire  _T_26 = _T_13 & io_din_v; // @[FU.scala 108:79]
  wire  _T_28 = _T_26 & io_dout_r; // @[FU.scala 109:37]
  wire  _GEN_16 = _T_21 | _GEN_10; // @[FU.scala 102:13 105:22]
  ALU ALU ( // @[FU.scala 44:22]
    .io_din_1(ALU_io_din_1),
    .io_din_2(ALU_io_din_2),
    .io_op_config(ALU_io_op_config),
    .io_dout(ALU_io_dout)
  );
  assign io_din_r = io_dout_r; // @[FU.scala 123:14]
  assign io_dout = _T ? alu_dout : dout_Reg; // @[FU.scala 125:38 126:17 129:17]
  assign io_dout_v = _T ? io_din_v : valid; // @[FU.scala 116:38 117:19 120:19]
  assign ALU_io_din_1 = alu_din_1; // @[FU.scala 45:18]
  assign ALU_io_din_2 = alu_din_2; // @[FU.scala 46:18]
  assign ALU_io_op_config = io_op_config; // @[FU.scala 48:22]
  always @(posedge clock) begin
    if (reset) begin // @[FU.scala 33:28]
      alu_din_1 <= 8'h0; // @[FU.scala 33:28]
    end else if (io_loop_source == 2'h0) begin // @[FU.scala 51:39]
      alu_din_1 <= io_din_1; // @[FU.scala 52:19]
    end else if (io_loop_source == 2'h1) begin // @[FU.scala 55:44]
      if (~loaded) begin // @[FU.scala 56:31]
        alu_din_1 <= io_din_1; // @[FU.scala 57:23]
      end else begin
        alu_din_1 <= dout_Reg; // @[FU.scala 61:23]
      end
    end else if (io_loop_source == 2'h2) begin // @[FU.scala 65:44]
      alu_din_1 <= io_din_1;
    end else begin
      alu_din_1 <= 8'h7; // @[FU.scala 76:19]
    end
    if (reset) begin // @[FU.scala 34:28]
      alu_din_2 <= 8'h0; // @[FU.scala 34:28]
    end else if (io_loop_source == 2'h0) begin // @[FU.scala 51:39]
      alu_din_2 <= io_din_2; // @[FU.scala 53:19]
    end else if (io_loop_source == 2'h1) begin // @[FU.scala 55:44]
      alu_din_2 <= io_din_2;
    end else if (io_loop_source == 2'h2) begin // @[FU.scala 65:44]
      alu_din_2 <= _GEN_3;
    end else begin
      alu_din_2 <= 8'h7; // @[FU.scala 77:19]
    end
    if (reset) begin // @[FU.scala 35:27]
      alu_dout <= 8'h0; // @[FU.scala 35:27]
    end else begin
      alu_dout <= ALU_io_dout; // @[FU.scala 47:14]
    end
    if (reset) begin // @[FU.scala 36:27]
      dout_Reg <= 8'h0; // @[FU.scala 36:27]
    end else if (_T_21) begin // @[FU.scala 102:13]
      dout_Reg <= alu_dout; // @[FU.scala 106:22]
    end else if (_T_28) begin // @[FU.scala 111:13]
      dout_Reg <= alu_dout; // @[FU.scala 112:22]
    end else begin
      dout_Reg <= 8'h0; // @[FU.scala 84:18]
    end
    if (reset) begin // @[FU.scala 40:24]
      count <= 16'hffff; // @[FU.scala 40:24]
    end else if (_T_21) begin // @[FU.scala 102:13]
      count <= 16'h0; // @[FU.scala 103:22]
    end else if (_T_14) begin // @[FU.scala 95:13]
      count <= _count_T_1; // @[FU.scala 97:20]
    end else begin
      count <= 16'h0; // @[FU.scala 83:15]
    end
    if (reset) begin // @[FU.scala 41:25]
      loaded <= 1'h0; // @[FU.scala 41:25]
    end else if (_T_21) begin // @[FU.scala 102:13]
      loaded <= 1'h0; // @[FU.scala 104:22]
    end else begin
      loaded <= _T_14;
    end
    if (reset) begin // @[FU.scala 42:24]
      valid <= 1'h0; // @[FU.scala 42:24]
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
  alu_din_1 = _RAND_0[7:0];
  _RAND_1 = {1{`RANDOM}};
  alu_din_2 = _RAND_1[7:0];
  _RAND_2 = {1{`RANDOM}};
  alu_dout = _RAND_2[7:0];
  _RAND_3 = {1{`RANDOM}};
  dout_Reg = _RAND_3[7:0];
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
