module ConfMux(
  input        clock,
  input        reset,
  input        io_selector,
  input  [1:0] io_mux_input,
  output       io_mux_output
);
  wire  inputs_0 = io_mux_input[0]; // @[ConfMux.scala 32:34]
  wire  inputs_1 = io_mux_input[1]; // @[ConfMux.scala 32:34]
  assign io_mux_output = io_selector ? inputs_1 : inputs_0; // @[ConfMux.scala 34:{19,19}]
endmodule
