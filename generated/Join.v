module Join(
  input        clock,
  input        reset,
  input  [7:0] io_d_in_1,
  input  [7:0] io_d_in_2,
  output       io_a_in_1,
  output       io_a_in_2,
  output [7:0] io_d_out_1,
  output [7:0] io_d_out_2,
  input        io_v_in_1,
  input        io_v_in_2,
  output       io_v_out,
  input        io_a_out
);
  assign io_a_in_1 = io_v_in_2 & io_a_out; // @[Join.scala 25:28]
  assign io_a_in_2 = io_v_in_1 & io_a_out; // @[Join.scala 26:28]
  assign io_d_out_1 = io_d_in_1; // @[Join.scala 20:16]
  assign io_d_out_2 = io_d_in_2; // @[Join.scala 21:16]
  assign io_v_out = io_v_in_1 & io_v_in_2; // @[Join.scala 23:27]
endmodule
