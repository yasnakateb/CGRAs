module D_FIFO(
  input         clock,
  input         reset,
  input         io_clock,
  input         io_reset,
  input  [31:0] io_din,
  input         io_din_v,
  input         io_dout_r,
  output        io_din_r,
  output [31:0] io_dout,
  output        io_dout_v
);
  wire  fifo_clock; // @[D_FIFO.scala 60:22]
  wire  fifo_reset; // @[D_FIFO.scala 60:22]
  wire [31:0] fifo_din; // @[D_FIFO.scala 60:22]
  wire  fifo_din_v; // @[D_FIFO.scala 60:22]
  wire  fifo_dout_r; // @[D_FIFO.scala 60:22]
  wire  fifo_din_r; // @[D_FIFO.scala 60:22]
  wire [31:0] fifo_dout; // @[D_FIFO.scala 60:22]
  wire  fifo_dout_v; // @[D_FIFO.scala 60:22]
  D_FIFO_V #(.DATA_WIDTH(32), .FIFO_DEPTH(32)) fifo ( // @[D_FIFO.scala 60:22]
    .clock(fifo_clock),
    .reset(fifo_reset),
    .din(fifo_din),
    .din_v(fifo_din_v),
    .dout_r(fifo_dout_r),
    .din_r(fifo_din_r),
    .dout(fifo_dout),
    .dout_v(fifo_dout_v)
  );
  assign io_din_r = fifo_din_r; // @[D_FIFO.scala 69:14]
  assign io_dout = fifo_dout; // @[D_FIFO.scala 70:14]
  assign io_dout_v = fifo_dout_v; // @[D_FIFO.scala 71:15]
  assign fifo_clock = io_clock; // @[D_FIFO.scala 62:19]
  assign fifo_reset = io_reset; // @[D_FIFO.scala 63:19]
  assign fifo_din = io_din; // @[D_FIFO.scala 64:17]
  assign fifo_din_v = io_din_v; // @[D_FIFO.scala 65:19]
  assign fifo_dout_r = io_dout_r; // @[D_FIFO.scala 66:20]
endmodule
