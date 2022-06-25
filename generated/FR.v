module FR(
  input   clock,
  input   reset,
  input   io_afu_in_1,
  input   io_afu_in_2,
  input   io_ae_out,
  input   io_as_out,
  input   io_aw_out,
  input   io_vfu_out,
  input   io_ve_in,
  input   io_vs_in,
  input   io_vw_in,
  output  io_vn_out
);
  wire  _io_vn_out_T_18 = io_ae_out & io_aw_out; // @[FR.scala 37:57]
  assign io_vn_out = _io_vn_out_T_18 & io_ve_in; // @[FR.scala 38:57]
endmodule
