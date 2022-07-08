module ConfMux(
  input  [2:0] io_selector,
  input  [4:0] io_mux_input,
  output       io_mux_output
);
  wire  inputs_0 = io_mux_input[0]; // @[ConfMux.scala 27:34]
  wire  inputs_1 = io_mux_input[1]; // @[ConfMux.scala 27:34]
  wire  inputs_2 = io_mux_input[2]; // @[ConfMux.scala 27:34]
  wire  inputs_3 = io_mux_input[3]; // @[ConfMux.scala 27:34]
  wire  inputs_4 = io_mux_input[4]; // @[ConfMux.scala 27:34]
  wire  _GEN_1 = 3'h1 == io_selector ? inputs_1 : inputs_0; // @[ConfMux.scala 30:{19,19}]
  wire  _GEN_2 = 3'h2 == io_selector ? inputs_2 : _GEN_1; // @[ConfMux.scala 30:{19,19}]
  wire  _GEN_3 = 3'h3 == io_selector ? inputs_3 : _GEN_2; // @[ConfMux.scala 30:{19,19}]
  assign io_mux_output = 3'h4 == io_selector ? inputs_4 : _GEN_3; // @[ConfMux.scala 30:{19,19}]
endmodule
module FR(
  input        clock,
  input        reset,
  input  [4:0] io_valid_in,
  input  [4:0] io_ready_out,
  input  [2:0] io_valid_mux_sel,
  input  [4:0] io_fork_mask,
  output       io_valid_out
);
  wire [2:0] conf_mux_io_selector; // @[FR.scala 29:28]
  wire [4:0] conf_mux_io_mux_input; // @[FR.scala 29:28]
  wire  conf_mux_io_mux_output; // @[FR.scala 29:28]
  wire  aux_0 = ~io_fork_mask[0] | io_ready_out[0]; // @[FR.scala 27:39]
  wire  aux_1 = ~io_fork_mask[1] | io_ready_out[1]; // @[FR.scala 27:39]
  wire  aux_2 = ~io_fork_mask[2] | io_ready_out[2]; // @[FR.scala 27:39]
  wire  aux_3 = ~io_fork_mask[3] | io_ready_out[3]; // @[FR.scala 27:39]
  wire  aux_4 = ~io_fork_mask[4] | io_ready_out[4]; // @[FR.scala 27:39]
  wire  Vaux = conf_mux_io_mux_output; // @[FR.scala 24:20 32:28]
  wire  temp_1 = aux_0 & aux_1; // @[FR.scala 38:30]
  wire  temp_2 = temp_1 & aux_2; // @[FR.scala 38:30]
  wire  temp_3 = temp_2 & aux_3; // @[FR.scala 38:30]
  wire  temp_4 = temp_3 & aux_4; // @[FR.scala 38:30]
  ConfMux conf_mux ( // @[FR.scala 29:28]
    .io_selector(conf_mux_io_selector),
    .io_mux_input(conf_mux_io_mux_input),
    .io_mux_output(conf_mux_io_mux_output)
  );
  assign io_valid_out = temp_4 & Vaux; // @[FR.scala 38:30]
  assign conf_mux_io_selector = io_valid_mux_sel; // @[FR.scala 30:26]
  assign conf_mux_io_mux_input = io_valid_in; // @[FR.scala 31:27]
endmodule
