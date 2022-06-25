module FS(
  input   clock,
  input   reset,
  input   io_afu_in_1,
  input   io_afu_in_2,
  input   io_ae_out,
  input   io_as_out,
  input   io_aw_out,
  output  io_an_in
);
  assign io_an_in = io_ae_out & io_aw_out; // @[FS.scala 26:57]
endmodule
