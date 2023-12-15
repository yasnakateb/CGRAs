module FS(
  input        clock,
  input        reset,
  input  [4:0] io_ready_out,
  input  [4:0] io_fork_mask,
  output       io_ready_in
);
  wire  aux_0 = ~io_fork_mask[0] | io_ready_out[0]; // @[FS.scala 55:39]
  wire  aux_1 = ~io_fork_mask[1] | io_ready_out[1]; // @[FS.scala 55:39]
  wire  aux_2 = ~io_fork_mask[2] | io_ready_out[2]; // @[FS.scala 55:39]
  wire  aux_3 = ~io_fork_mask[3] | io_ready_out[3]; // @[FS.scala 55:39]
  wire  aux_4 = ~io_fork_mask[4] | io_ready_out[4]; // @[FS.scala 55:39]
  wire  temp_1 = aux_0 & aux_1; // @[FS.scala 61:30]
  wire  temp_2 = temp_1 & aux_2; // @[FS.scala 61:30]
  wire  temp_3 = temp_2 & aux_3; // @[FS.scala 61:30]
  assign io_ready_in = temp_3 & aux_4; // @[FS.scala 61:30]
endmodule
