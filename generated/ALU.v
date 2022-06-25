module ALU(
  input        clock,
  input        reset,
  input  [7:0] io_d_in_1,
  input  [7:0] io_d_in_2,
  input  [7:0] io_op_config,
  output [7:0] io_d_out
);
  wire [7:0] _io_d_out_T_1 = io_d_in_1 + io_d_in_2; // @[ALU.scala 30:29]
  wire [15:0] _io_d_out_T_2 = io_d_in_1 * io_d_in_2; // @[ALU.scala 33:29]
  wire [7:0] _io_d_out_T_4 = io_d_in_1 - io_d_in_2; // @[ALU.scala 36:29]
  wire [262:0] _GEN_14 = {{255'd0}, io_d_in_1}; // @[ALU.scala 39:29]
  wire [262:0] _io_d_out_T_5 = _GEN_14 << io_d_in_2; // @[ALU.scala 39:29]
  wire [7:0] _io_d_out_T_6 = io_d_in_1 >> io_d_in_2; // @[ALU.scala 42:29]
  wire [7:0] _io_d_out_T_7 = io_d_in_1 & io_d_in_2; // @[ALU.scala 45:29]
  wire [7:0] _io_d_out_T_8 = io_d_in_1 | io_d_in_2; // @[ALU.scala 48:29]
  wire [7:0] _io_d_out_T_9 = io_d_in_1 ^ io_d_in_2; // @[ALU.scala 51:29]
  wire [7:0] _GEN_0 = io_d_in_1 > io_d_in_2 ? io_d_in_2 : 8'h0; // @[ALU.scala 28:14 57:40 58:18]
  wire [7:0] _GEN_1 = io_d_in_1 <= io_d_in_2 ? io_d_in_1 : _GEN_0; // @[ALU.scala 54:37 55:18]
  wire [7:0] _GEN_2 = io_d_in_1 < io_d_in_2 ? io_d_in_2 : 8'h0; // @[ALU.scala 28:14 65:40 66:18]
  wire [7:0] _GEN_3 = io_d_in_1 >= io_d_in_2 ? io_d_in_1 : _GEN_2; // @[ALU.scala 62:37 63:18]
  wire [7:0] _GEN_4 = io_op_config == 8'h9 ? _GEN_3 : 8'h0; // @[ALU.scala 61:38 70:16]
  wire [7:0] _GEN_5 = io_op_config == 8'h8 ? _GEN_1 : _GEN_4; // @[ALU.scala 53:38]
  wire [7:0] _GEN_6 = io_op_config == 8'h7 ? _io_d_out_T_9 : _GEN_5; // @[ALU.scala 50:38 51:16]
  wire [7:0] _GEN_7 = io_op_config == 8'h6 ? _io_d_out_T_8 : _GEN_6; // @[ALU.scala 47:37 48:16]
  wire [7:0] _GEN_8 = io_op_config == 8'h5 ? _io_d_out_T_7 : _GEN_7; // @[ALU.scala 44:38 45:16]
  wire [7:0] _GEN_9 = io_op_config == 8'h4 ? _io_d_out_T_6 : _GEN_8; // @[ALU.scala 41:38 42:16]
  wire [262:0] _GEN_10 = io_op_config == 8'h3 ? _io_d_out_T_5 : {{255'd0}, _GEN_9}; // @[ALU.scala 38:38 39:16]
  wire [262:0] _GEN_11 = io_op_config == 8'h2 ? {{255'd0}, _io_d_out_T_4} : _GEN_10; // @[ALU.scala 35:38 36:16]
  wire [262:0] _GEN_12 = io_op_config == 8'h1 ? {{247'd0}, _io_d_out_T_2} : _GEN_11; // @[ALU.scala 32:38 33:16]
  wire [262:0] _GEN_13 = io_op_config == 8'h0 ? {{255'd0}, _io_d_out_T_1} : _GEN_12; // @[ALU.scala 29:33 30:16]
  assign io_d_out = _GEN_13[7:0];
endmodule
