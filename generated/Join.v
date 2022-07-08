module Join(
  input        clock,
  input        reset,
  input  [7:0] io_din_1,
  input  [7:0] io_din_2,
  output       io_din_1_r,
  output       io_din_2_r,
  output [7:0] io_dout_1,
  output [7:0] io_dout_2,
  input        io_din_1_v,
  input        io_din_2_v,
  output       io_dout_v,
  input        io_dout_r
);
  assign io_din_1_r = io_din_2_v & io_dout_r; // @[Join.scala 25:30]
  assign io_din_2_r = io_din_1_v & io_dout_r; // @[Join.scala 26:30]
  assign io_dout_1 = io_din_1; // @[Join.scala 20:15]
  assign io_dout_2 = io_din_2; // @[Join.scala 21:15]
  assign io_dout_v = io_din_1_v & io_din_2_v; // @[Join.scala 23:29]
endmodule
