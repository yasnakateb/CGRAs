module D_FIFO(
  input         clock,
  input         reset,
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
  assign io_din_r = fifo_din_r; // @[D_FIFO.scala 70:14]
  assign io_dout = fifo_dout; // @[D_FIFO.scala 71:14]
  assign io_dout_v = fifo_dout_v; // @[D_FIFO.scala 72:15]
  assign fifo_clock = clock; // @[D_FIFO.scala 62:19]
  assign fifo_reset = reset; // @[D_FIFO.scala 63:28]
  assign fifo_din = io_din; // @[D_FIFO.scala 65:17]
  assign fifo_din_v = io_din_v; // @[D_FIFO.scala 66:19]
  assign fifo_dout_r = io_dout_r; // @[D_FIFO.scala 67:20]
endmodule
module FS(
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
module ConfMux(
  input  [1:0]   io_selector,
  input  [127:0] io_mux_input,
  output [31:0]  io_mux_output
);
  wire [31:0] inputs_0 = io_mux_input[31:0]; // @[ConfMux.scala 28:70]
  wire [31:0] inputs_1 = io_mux_input[63:32]; // @[ConfMux.scala 28:70]
  wire [31:0] inputs_2 = io_mux_input[95:64]; // @[ConfMux.scala 28:70]
  wire [31:0] inputs_3 = io_mux_input[127:96]; // @[ConfMux.scala 28:70]
  wire [31:0] _GEN_1 = 2'h1 == io_selector ? $signed(inputs_1) : $signed(inputs_0); // @[ConfMux.scala 30:{19,19}]
  wire [31:0] _GEN_2 = 2'h2 == io_selector ? $signed(inputs_2) : $signed(_GEN_1); // @[ConfMux.scala 30:{19,19}]
  assign io_mux_output = 2'h3 == io_selector ? $signed(inputs_3) : $signed(_GEN_2); // @[ConfMux.scala 30:{19,19}]
endmodule
module ConfMux_1(
  input  [1:0] io_selector,
  input  [3:0] io_mux_input,
  output       io_mux_output
);
  wire  inputs_0 = io_mux_input[0]; // @[ConfMux.scala 28:70]
  wire  inputs_1 = io_mux_input[1]; // @[ConfMux.scala 28:70]
  wire  inputs_2 = io_mux_input[2]; // @[ConfMux.scala 28:70]
  wire  inputs_3 = io_mux_input[3]; // @[ConfMux.scala 28:70]
  wire  _GEN_1 = 2'h1 == io_selector ? $signed(inputs_1) : $signed(inputs_0); // @[ConfMux.scala 30:{19,19}]
  wire  _GEN_2 = 2'h2 == io_selector ? $signed(inputs_2) : $signed(_GEN_1); // @[ConfMux.scala 30:{19,19}]
  assign io_mux_output = 2'h3 == io_selector ? $signed(inputs_3) : $signed(_GEN_2); // @[ConfMux.scala 30:{19,19}]
endmodule
module FR(
  input  [3:0] io_valid_in,
  input  [4:0] io_ready_out,
  input  [1:0] io_valid_mux_sel,
  input  [4:0] io_fork_mask,
  output       io_valid_out
);
  wire [1:0] conf_mux_io_selector; // @[FR.scala 61:28]
  wire [3:0] conf_mux_io_mux_input; // @[FR.scala 61:28]
  wire  conf_mux_io_mux_output; // @[FR.scala 61:28]
  wire  aux_0 = ~io_fork_mask[0] | io_ready_out[0]; // @[FR.scala 59:39]
  wire  aux_1 = ~io_fork_mask[1] | io_ready_out[1]; // @[FR.scala 59:39]
  wire  aux_2 = ~io_fork_mask[2] | io_ready_out[2]; // @[FR.scala 59:39]
  wire  aux_3 = ~io_fork_mask[3] | io_ready_out[3]; // @[FR.scala 59:39]
  wire  aux_4 = ~io_fork_mask[4] | io_ready_out[4]; // @[FR.scala 59:39]
  wire  temp_1 = aux_0 & aux_1; // @[FR.scala 70:30]
  wire  temp_2 = temp_1 & aux_2; // @[FR.scala 70:30]
  wire  temp_3 = temp_2 & aux_3; // @[FR.scala 70:30]
  wire  temp_4 = temp_3 & aux_4; // @[FR.scala 70:30]
  ConfMux_1 conf_mux ( // @[FR.scala 61:28]
    .io_selector(conf_mux_io_selector),
    .io_mux_input(conf_mux_io_mux_input),
    .io_mux_output(conf_mux_io_mux_output)
  );
  assign io_valid_out = temp_4 & conf_mux_io_mux_output; // @[FR.scala 70:30]
  assign conf_mux_io_selector = io_valid_mux_sel; // @[FR.scala 62:26]
  assign conf_mux_io_mux_input = io_valid_in; // @[FR.scala 63:44]
endmodule
module D_REG(
  input         clock,
  input         reset,
  input  [31:0] io_din,
  input         io_din_v,
  input         io_dout_r,
  output [31:0] io_dout,
  output        io_dout_v,
  output        io_din_r
);
`ifdef RANDOMIZE_REG_INIT
  reg [31:0] _RAND_0;
  reg [31:0] _RAND_1;
`endif // RANDOMIZE_REG_INIT
  reg [31:0] data; // @[D_REG.scala 52:23]
  reg  valid; // @[D_REG.scala 53:24]
  wire  _GEN_1 = io_dout_r & io_din_v; // @[D_REG.scala 57:11 59:33 61:15]
  assign io_dout = data; // @[D_REG.scala 64:13]
  assign io_dout_v = valid; // @[D_REG.scala 65:15]
  assign io_din_r = io_dout_r; // @[D_REG.scala 66:14]
  always @(posedge clock) begin
    if (reset) begin // @[D_REG.scala 52:23]
      data <= 32'sh0; // @[D_REG.scala 52:23]
    end else if (io_dout_r) begin // @[D_REG.scala 59:33]
      data <= io_din; // @[D_REG.scala 60:14]
    end else begin
      data <= 32'sh0; // @[D_REG.scala 56:10]
    end
    if (reset) begin // @[D_REG.scala 53:24]
      valid <= 1'h0; // @[D_REG.scala 53:24]
    end else begin
      valid <= _GEN_1;
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
  data = _RAND_0[31:0];
  _RAND_1 = {1{`RANDOM}};
  valid = _RAND_1[0:0];
`endif // RANDOMIZE_REG_INIT
  `endif // RANDOMIZE
end // initial
`ifdef FIRRTL_AFTER_INITIAL
`FIRRTL_AFTER_INITIAL
`endif
`endif // SYNTHESIS
endmodule
module ConfMux_8(
  input  [2:0] io_selector,
  input  [5:0] io_mux_input,
  output       io_mux_output
);
  wire  inputs_0 = io_mux_input[0]; // @[ConfMux.scala 28:70]
  wire  inputs_1 = io_mux_input[1]; // @[ConfMux.scala 28:70]
  wire  inputs_2 = io_mux_input[2]; // @[ConfMux.scala 28:70]
  wire  inputs_3 = io_mux_input[3]; // @[ConfMux.scala 28:70]
  wire  inputs_4 = io_mux_input[4]; // @[ConfMux.scala 28:70]
  wire  inputs_5 = io_mux_input[5]; // @[ConfMux.scala 28:70]
  wire  _GEN_1 = 3'h1 == io_selector ? $signed(inputs_1) : $signed(inputs_0); // @[ConfMux.scala 30:{19,19}]
  wire  _GEN_2 = 3'h2 == io_selector ? $signed(inputs_2) : $signed(_GEN_1); // @[ConfMux.scala 30:{19,19}]
  wire  _GEN_3 = 3'h3 == io_selector ? $signed(inputs_3) : $signed(_GEN_2); // @[ConfMux.scala 30:{19,19}]
  wire  _GEN_4 = 3'h4 == io_selector ? $signed(inputs_4) : $signed(_GEN_3); // @[ConfMux.scala 30:{19,19}]
  assign io_mux_output = 3'h5 == io_selector ? $signed(inputs_5) : $signed(_GEN_4); // @[ConfMux.scala 30:{19,19}]
endmodule
module FR_4(
  input  [5:0] io_valid_in,
  input  [3:0] io_ready_out,
  input  [2:0] io_valid_mux_sel,
  input  [3:0] io_fork_mask,
  output       io_valid_out
);
  wire [2:0] conf_mux_io_selector; // @[FR.scala 61:28]
  wire [5:0] conf_mux_io_mux_input; // @[FR.scala 61:28]
  wire  conf_mux_io_mux_output; // @[FR.scala 61:28]
  wire  aux_0 = ~io_fork_mask[0] | io_ready_out[0]; // @[FR.scala 59:39]
  wire  aux_1 = ~io_fork_mask[1] | io_ready_out[1]; // @[FR.scala 59:39]
  wire  aux_2 = ~io_fork_mask[2] | io_ready_out[2]; // @[FR.scala 59:39]
  wire  aux_3 = ~io_fork_mask[3] | io_ready_out[3]; // @[FR.scala 59:39]
  wire  temp_1 = aux_0 & aux_1; // @[FR.scala 70:30]
  wire  temp_2 = temp_1 & aux_2; // @[FR.scala 70:30]
  wire  temp_3 = temp_2 & aux_3; // @[FR.scala 70:30]
  ConfMux_8 conf_mux ( // @[FR.scala 61:28]
    .io_selector(conf_mux_io_selector),
    .io_mux_input(conf_mux_io_mux_input),
    .io_mux_output(conf_mux_io_mux_output)
  );
  assign io_valid_out = temp_3 & conf_mux_io_mux_output; // @[FR.scala 70:30]
  assign conf_mux_io_selector = io_valid_mux_sel; // @[FR.scala 62:26]
  assign conf_mux_io_mux_input = io_valid_in; // @[FR.scala 63:44]
endmodule
module ConfMux_9(
  input  [2:0]   io_selector,
  input  [191:0] io_mux_input,
  output [31:0]  io_mux_output
);
  wire [31:0] inputs_0 = io_mux_input[31:0]; // @[ConfMux.scala 28:70]
  wire [31:0] inputs_1 = io_mux_input[63:32]; // @[ConfMux.scala 28:70]
  wire [31:0] inputs_2 = io_mux_input[95:64]; // @[ConfMux.scala 28:70]
  wire [31:0] inputs_3 = io_mux_input[127:96]; // @[ConfMux.scala 28:70]
  wire [31:0] inputs_4 = io_mux_input[159:128]; // @[ConfMux.scala 28:70]
  wire [31:0] inputs_5 = io_mux_input[191:160]; // @[ConfMux.scala 28:70]
  wire [31:0] _GEN_1 = 3'h1 == io_selector ? $signed(inputs_1) : $signed(inputs_0); // @[ConfMux.scala 30:{19,19}]
  wire [31:0] _GEN_2 = 3'h2 == io_selector ? $signed(inputs_2) : $signed(_GEN_1); // @[ConfMux.scala 30:{19,19}]
  wire [31:0] _GEN_3 = 3'h3 == io_selector ? $signed(inputs_3) : $signed(_GEN_2); // @[ConfMux.scala 30:{19,19}]
  wire [31:0] _GEN_4 = 3'h4 == io_selector ? $signed(inputs_4) : $signed(_GEN_3); // @[ConfMux.scala 30:{19,19}]
  assign io_mux_output = 3'h5 == io_selector ? $signed(inputs_5) : $signed(_GEN_4); // @[ConfMux.scala 30:{19,19}]
endmodule
module D_EB(
  input         clock,
  input         reset,
  input  [31:0] io_din,
  input         io_din_v,
  output        io_din_r,
  output [31:0] io_dout,
  output        io_dout_v,
  input         io_dout_r
);
`ifdef RANDOMIZE_REG_INIT
  reg [31:0] _RAND_0;
  reg [31:0] _RAND_1;
  reg [31:0] _RAND_2;
  reg [31:0] _RAND_3;
  reg [31:0] _RAND_4;
`endif // RANDOMIZE_REG_INIT
  reg [31:0] reg_din_1; // @[D_EB.scala 54:28]
  reg [31:0] reg_din_2; // @[D_EB.scala 55:28]
  reg  reg_din_v_1; // @[D_EB.scala 56:30]
  reg  reg_din_v_2; // @[D_EB.scala 57:30]
  reg  reg_areg; // @[D_EB.scala 58:27]
  assign io_din_r = reg_areg; // @[D_EB.scala 71:14]
  assign io_dout = reg_areg ? $signed(reg_din_1) : $signed(reg_din_2); // @[D_EB.scala 60:20 62:19 55:28]
  assign io_dout_v = reg_areg ? reg_din_v_1 : reg_din_v_2; // @[D_EB.scala 60:20 65:21 57:30]
  always @(posedge clock) begin
    if (reset) begin // @[D_EB.scala 54:28]
      reg_din_1 <= 32'sh0; // @[D_EB.scala 54:28]
    end else if (reg_areg) begin // @[D_EB.scala 60:20]
      reg_din_1 <= io_din; // @[D_EB.scala 61:19]
    end
    if (reset) begin // @[D_EB.scala 55:28]
      reg_din_2 <= 32'sh0; // @[D_EB.scala 55:28]
    end else if (reg_areg) begin // @[D_EB.scala 60:20]
      reg_din_2 <= reg_din_1; // @[D_EB.scala 62:19]
    end
    if (reset) begin // @[D_EB.scala 56:30]
      reg_din_v_1 <= 1'h0; // @[D_EB.scala 56:30]
    end else if (reg_areg) begin // @[D_EB.scala 60:20]
      reg_din_v_1 <= io_din_v; // @[D_EB.scala 64:21]
    end
    if (reset) begin // @[D_EB.scala 57:30]
      reg_din_v_2 <= 1'h0; // @[D_EB.scala 57:30]
    end else if (reg_areg) begin // @[D_EB.scala 60:20]
      reg_din_v_2 <= reg_din_v_1; // @[D_EB.scala 65:21]
    end
    if (reset) begin // @[D_EB.scala 58:27]
      reg_areg <= 1'h0; // @[D_EB.scala 58:27]
    end else begin
      reg_areg <= ~io_dout_v | io_dout_r; // @[D_EB.scala 68:14]
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
  reg_din_1 = _RAND_0[31:0];
  _RAND_1 = {1{`RANDOM}};
  reg_din_2 = _RAND_1[31:0];
  _RAND_2 = {1{`RANDOM}};
  reg_din_v_1 = _RAND_2[0:0];
  _RAND_3 = {1{`RANDOM}};
  reg_din_v_2 = _RAND_3[0:0];
  _RAND_4 = {1{`RANDOM}};
  reg_areg = _RAND_4[0:0];
`endif // RANDOMIZE_REG_INIT
  `endif // RANDOMIZE
end // initial
`ifdef FIRRTL_AFTER_INITIAL
`FIRRTL_AFTER_INITIAL
`endif
`endif // SYNTHESIS
endmodule
module Join(
  input  [31:0] io_din_1,
  input  [31:0] io_din_2,
  input         io_dout_r,
  input         io_din_1_v,
  input         io_din_2_v,
  output        io_dout_v,
  output        io_din_1_r,
  output        io_din_2_r,
  output [31:0] io_dout_1,
  output [31:0] io_dout_2
);
  assign io_dout_v = io_din_1_v & io_din_2_v; // @[Join.scala 61:29]
  assign io_din_1_r = io_dout_r & io_din_2_v; // @[Join.scala 63:29]
  assign io_din_2_r = io_dout_r & io_din_1_v; // @[Join.scala 64:29]
  assign io_dout_1 = io_din_1; // @[Join.scala 58:15]
  assign io_dout_2 = io_din_2; // @[Join.scala 59:15]
endmodule
module ALU(
  input  [31:0] io_din_1,
  input  [31:0] io_din_2,
  input  [4:0]  io_op_config,
  output [31:0] io_dout
);
  wire [31:0] _out_aux_T_2 = $signed(io_din_1) + $signed(io_din_2); // @[ALU.scala 71:27]
  wire [63:0] _out_aux_T_3 = $signed(io_din_1) * $signed(io_din_2); // @[ALU.scala 74:27]
  wire [31:0] _out_aux_T_6 = $signed(io_din_1) - $signed(io_din_2); // @[ALU.scala 77:27]
  wire [524318:0] _GEN_11 = {{524287{io_din_1[31]}},io_din_1}; // @[ALU.scala 81:27]
  wire [524318:0] _out_aux_T_8 = $signed(_GEN_11) << io_din_2[18:0]; // @[ALU.scala 81:27]
  wire [31:0] _out_aux_T_10 = $signed(io_din_1) >>> io_din_2; // @[ALU.scala 84:27]
  wire [31:0] _out_aux_T_14 = io_din_1 >> io_din_2; // @[ALU.scala 87:55]
  wire [31:0] _out_aux_T_16 = $signed(io_din_1) & $signed(io_din_2); // @[ALU.scala 90:27]
  wire [31:0] _out_aux_T_18 = $signed(io_din_1) | $signed(io_din_2); // @[ALU.scala 93:27]
  wire [31:0] _out_aux_T_20 = $signed(io_din_1) ^ $signed(io_din_2); // @[ALU.scala 96:27]
  wire [31:0] _GEN_0 = io_op_config == 5'h8 ? $signed(_out_aux_T_20) : $signed(32'sh0); // @[ALU.scala 95:38 96:15 99:15]
  wire [31:0] _GEN_1 = io_op_config == 5'h7 ? $signed(_out_aux_T_18) : $signed(_GEN_0); // @[ALU.scala 92:37 93:15]
  wire [31:0] _GEN_2 = io_op_config == 5'h6 ? $signed(_out_aux_T_16) : $signed(_GEN_1); // @[ALU.scala 89:38 90:15]
  wire [31:0] _GEN_3 = io_op_config == 5'h5 ? $signed(_out_aux_T_14) : $signed(_GEN_2); // @[ALU.scala 86:38 87:15]
  wire [31:0] _GEN_4 = io_op_config == 5'h4 ? $signed(_out_aux_T_10) : $signed(_GEN_3); // @[ALU.scala 83:38 84:15]
  wire [524318:0] _GEN_5 = io_op_config == 5'h3 ? $signed(_out_aux_T_8) : $signed({{524287{_GEN_4[31]}},_GEN_4}); // @[ALU.scala 79:38 81:15]
  wire [524318:0] _GEN_6 = io_op_config == 5'h2 ? $signed({{524287{_out_aux_T_6[31]}},_out_aux_T_6}) : $signed(_GEN_5); // @[ALU.scala 76:38 77:15]
  wire [524318:0] _GEN_7 = io_op_config == 5'h1 ? $signed({{524255{_out_aux_T_3[63]}},_out_aux_T_3}) : $signed(_GEN_6); // @[ALU.scala 73:38 74:15]
  wire [524318:0] _GEN_8 = io_op_config == 5'h0 ? $signed({{524287{_out_aux_T_2[31]}},_out_aux_T_2}) : $signed(_GEN_7); // @[ALU.scala 70:33 71:15]
  assign io_dout = _GEN_8[31:0]; // @[ALU.scala 68:23]
endmodule
module FU(
  input         clock,
  input         reset,
  input  [31:0] io_din_1,
  input  [31:0] io_din_2,
  input         io_din_v,
  input         io_dout_r,
  input  [1:0]  io_loop_source,
  input  [15:0] io_iterations_reset,
  input  [4:0]  io_op_config,
  output        io_din_r,
  output [31:0] io_dout,
  output        io_dout_v
);
`ifdef RANDOMIZE_REG_INIT
  reg [31:0] _RAND_0;
  reg [31:0] _RAND_1;
  reg [31:0] _RAND_2;
  reg [31:0] _RAND_3;
`endif // RANDOMIZE_REG_INIT
  wire [31:0] ALU_io_din_1; // @[FU.scala 81:22]
  wire [31:0] ALU_io_din_2; // @[FU.scala 81:22]
  wire [4:0] ALU_io_op_config; // @[FU.scala 81:22]
  wire [31:0] ALU_io_dout; // @[FU.scala 81:22]
  reg [31:0] dout_reg; // @[FU.scala 76:27]
  reg [15:0] count; // @[FU.scala 77:24]
  reg  loaded; // @[FU.scala 78:25]
  reg  valid; // @[FU.scala 79:24]
  wire  _T = io_loop_source == 2'h0; // @[FU.scala 87:26]
  wire  _T_1 = io_loop_source == 2'h1; // @[FU.scala 91:31]
  wire  _T_2 = ~loaded; // @[FU.scala 92:22]
  wire [31:0] _GEN_0 = ~loaded ? $signed(io_din_1) : $signed(dout_reg); // @[FU.scala 92:31 93:23 98:23]
  wire  _T_3 = io_loop_source == 2'h2; // @[FU.scala 102:31]
  wire [31:0] _GEN_3 = _T_2 ? $signed(io_din_2) : $signed(dout_reg); // @[FU.scala 103:31 105:23 109:23]
  wire [31:0] _GEN_4 = io_loop_source == 2'h2 ? $signed(io_din_1) : $signed(32'sh1f); // @[FU.scala 102:44 113:19]
  wire [31:0] _GEN_5 = io_loop_source == 2'h2 ? $signed(_GEN_3) : $signed(32'sh1f); // @[FU.scala 102:44 114:19]
  wire [31:0] _GEN_6 = io_loop_source == 2'h1 ? $signed(_GEN_0) : $signed(_GEN_4); // @[FU.scala 91:44]
  wire [31:0] _GEN_7 = io_loop_source == 2'h1 ? $signed(io_din_2) : $signed(_GEN_5); // @[FU.scala 91:44]
  wire  _GEN_10 = io_dout_r ? 1'h0 : valid; // @[FU.scala 117:30 118:15 79:24]
  wire  _T_11 = _T_1 | _T_3; // @[FU.scala 122:41]
  wire  _T_12 = io_din_v & io_dout_r & _T_11; // @[FU.scala 121:49]
  wire [15:0] _count_T_1 = count + 16'h1; // @[FU.scala 125:24]
  wire  _GEN_11 = _T_12 | loaded; // @[FU.scala 123:9 124:16 78:25]
  wire [15:0] _T_14 = io_iterations_reset - 16'h1; // @[FU.scala 128:41]
  wire  _T_19 = count == _T_14 & _T_11; // @[FU.scala 128:47]
  wire  _T_21 = _T_19 & io_dout_r; // @[FU.scala 129:72]
  wire  _T_26 = _T_11 & io_din_v; // @[FU.scala 137:75]
  wire  _T_28 = _T_26 & io_dout_r; // @[FU.scala 138:34]
  wire [31:0] alu_dout = ALU_io_dout; // @[FU.scala 74:24 84:14]
  wire  _GEN_16 = _T_21 | _GEN_10; // @[FU.scala 131:9 134:15]
  ALU ALU ( // @[FU.scala 81:22]
    .io_din_1(ALU_io_din_1),
    .io_din_2(ALU_io_din_2),
    .io_op_config(ALU_io_op_config),
    .io_dout(ALU_io_dout)
  );
  assign io_din_r = io_dout_r; // @[FU.scala 144:14]
  assign io_dout = _T ? $signed(alu_dout) : $signed(dout_reg); // @[FU.scala 146:38 147:17 151:17]
  assign io_dout_v = _T ? io_din_v : valid; // @[FU.scala 146:38 148:19 152:19]
  assign ALU_io_din_1 = io_loop_source == 2'h0 ? $signed(io_din_1) : $signed(_GEN_6); // @[FU.scala 87:39 88:19]
  assign ALU_io_din_2 = io_loop_source == 2'h0 ? $signed(io_din_2) : $signed(_GEN_7); // @[FU.scala 87:39 89:19]
  assign ALU_io_op_config = io_op_config; // @[FU.scala 85:22]
  always @(posedge clock) begin
    if (reset) begin // @[FU.scala 76:27]
      dout_reg <= 32'sh0; // @[FU.scala 76:27]
    end else if (_T_21) begin // @[FU.scala 131:9]
      dout_reg <= alu_dout; // @[FU.scala 135:18]
    end else if (_T_28) begin // @[FU.scala 140:9]
      dout_reg <= alu_dout; // @[FU.scala 141:18]
    end
    if (reset) begin // @[FU.scala 77:24]
      count <= 16'h0; // @[FU.scala 77:24]
    end else if (_T_21) begin // @[FU.scala 131:9]
      count <= 16'h0; // @[FU.scala 132:15]
    end else if (_T_12) begin // @[FU.scala 123:9]
      count <= _count_T_1; // @[FU.scala 125:15]
    end
    if (reset) begin // @[FU.scala 78:25]
      loaded <= 1'h0; // @[FU.scala 78:25]
    end else if (_T_21) begin // @[FU.scala 131:9]
      loaded <= 1'h0; // @[FU.scala 133:16]
    end else begin
      loaded <= _GEN_11;
    end
    if (reset) begin // @[FU.scala 79:24]
      valid <= 1'h0; // @[FU.scala 79:24]
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
  dout_reg = _RAND_0[31:0];
  _RAND_1 = {1{`RANDOM}};
  count = _RAND_1[15:0];
  _RAND_2 = {1{`RANDOM}};
  loaded = _RAND_2[0:0];
  _RAND_3 = {1{`RANDOM}};
  valid = _RAND_3[0:0];
`endif // RANDOMIZE_REG_INIT
  `endif // RANDOMIZE
end // initial
`ifdef FIRRTL_AFTER_INITIAL
`FIRRTL_AFTER_INITIAL
`endif
`endif // SYNTHESIS
endmodule
module CellProcessing(
  input          clock,
  input          reset,
  input  [31:0]  io_north_din,
  input          io_north_din_v,
  input  [31:0]  io_east_din,
  input          io_east_din_v,
  input  [31:0]  io_south_din,
  input          io_south_din_v,
  input  [31:0]  io_west_din,
  input          io_west_din_v,
  output         io_FU_din_1_r,
  output         io_FU_din_2_r,
  output [31:0]  io_dout,
  output         io_dout_v,
  input          io_north_dout_r,
  input          io_east_dout_r,
  input          io_south_dout_r,
  input          io_west_dout_r,
  input  [181:0] io_config_bits
);
  wire [5:0] FR_1_io_valid_in; // @[CellProcessing.scala 115:23]
  wire [3:0] FR_1_io_ready_out; // @[CellProcessing.scala 115:23]
  wire [2:0] FR_1_io_valid_mux_sel; // @[CellProcessing.scala 115:23]
  wire [3:0] FR_1_io_fork_mask; // @[CellProcessing.scala 115:23]
  wire  FR_1_io_valid_out; // @[CellProcessing.scala 115:23]
  wire [2:0] MUX_1_io_selector; // @[CellProcessing.scala 124:24]
  wire [191:0] MUX_1_io_mux_input; // @[CellProcessing.scala 124:24]
  wire [31:0] MUX_1_io_mux_output; // @[CellProcessing.scala 124:24]
  wire  EB_1_clock; // @[CellProcessing.scala 129:23]
  wire  EB_1_reset; // @[CellProcessing.scala 129:23]
  wire [31:0] EB_1_io_din; // @[CellProcessing.scala 129:23]
  wire  EB_1_io_din_v; // @[CellProcessing.scala 129:23]
  wire  EB_1_io_din_r; // @[CellProcessing.scala 129:23]
  wire [31:0] EB_1_io_dout; // @[CellProcessing.scala 129:23]
  wire  EB_1_io_dout_v; // @[CellProcessing.scala 129:23]
  wire  EB_1_io_dout_r; // @[CellProcessing.scala 129:23]
  wire [5:0] FR_2_io_valid_in; // @[CellProcessing.scala 137:23]
  wire [3:0] FR_2_io_ready_out; // @[CellProcessing.scala 137:23]
  wire [2:0] FR_2_io_valid_mux_sel; // @[CellProcessing.scala 137:23]
  wire [3:0] FR_2_io_fork_mask; // @[CellProcessing.scala 137:23]
  wire  FR_2_io_valid_out; // @[CellProcessing.scala 137:23]
  wire [2:0] MUX_2_io_selector; // @[CellProcessing.scala 146:24]
  wire [191:0] MUX_2_io_mux_input; // @[CellProcessing.scala 146:24]
  wire [31:0] MUX_2_io_mux_output; // @[CellProcessing.scala 146:24]
  wire  EB_2_clock; // @[CellProcessing.scala 151:23]
  wire  EB_2_reset; // @[CellProcessing.scala 151:23]
  wire [31:0] EB_2_io_din; // @[CellProcessing.scala 151:23]
  wire  EB_2_io_din_v; // @[CellProcessing.scala 151:23]
  wire  EB_2_io_din_r; // @[CellProcessing.scala 151:23]
  wire [31:0] EB_2_io_dout; // @[CellProcessing.scala 151:23]
  wire  EB_2_io_dout_v; // @[CellProcessing.scala 151:23]
  wire  EB_2_io_dout_r; // @[CellProcessing.scala 151:23]
  wire [31:0] JOIN_INST_io_din_1; // @[CellProcessing.scala 159:28]
  wire [31:0] JOIN_INST_io_din_2; // @[CellProcessing.scala 159:28]
  wire  JOIN_INST_io_dout_r; // @[CellProcessing.scala 159:28]
  wire  JOIN_INST_io_din_1_v; // @[CellProcessing.scala 159:28]
  wire  JOIN_INST_io_din_2_v; // @[CellProcessing.scala 159:28]
  wire  JOIN_INST_io_dout_v; // @[CellProcessing.scala 159:28]
  wire  JOIN_INST_io_din_1_r; // @[CellProcessing.scala 159:28]
  wire  JOIN_INST_io_din_2_r; // @[CellProcessing.scala 159:28]
  wire [31:0] JOIN_INST_io_dout_1; // @[CellProcessing.scala 159:28]
  wire [31:0] JOIN_INST_io_dout_2; // @[CellProcessing.scala 159:28]
  wire  FU_INST_clock; // @[CellProcessing.scala 172:26]
  wire  FU_INST_reset; // @[CellProcessing.scala 172:26]
  wire [31:0] FU_INST_io_din_1; // @[CellProcessing.scala 172:26]
  wire [31:0] FU_INST_io_din_2; // @[CellProcessing.scala 172:26]
  wire  FU_INST_io_din_v; // @[CellProcessing.scala 172:26]
  wire  FU_INST_io_dout_r; // @[CellProcessing.scala 172:26]
  wire [1:0] FU_INST_io_loop_source; // @[CellProcessing.scala 172:26]
  wire [15:0] FU_INST_io_iterations_reset; // @[CellProcessing.scala 172:26]
  wire [4:0] FU_INST_io_op_config; // @[CellProcessing.scala 172:26]
  wire  FU_INST_io_din_r; // @[CellProcessing.scala 172:26]
  wire [31:0] FU_INST_io_dout; // @[CellProcessing.scala 172:26]
  wire  FU_INST_io_dout_v; // @[CellProcessing.scala 172:26]
  wire  EB_OUT_clock; // @[CellProcessing.scala 185:25]
  wire  EB_OUT_reset; // @[CellProcessing.scala 185:25]
  wire [31:0] EB_OUT_io_din; // @[CellProcessing.scala 185:25]
  wire  EB_OUT_io_din_v; // @[CellProcessing.scala 185:25]
  wire  EB_OUT_io_din_r; // @[CellProcessing.scala 185:25]
  wire [31:0] EB_OUT_io_dout; // @[CellProcessing.scala 185:25]
  wire  EB_OUT_io_dout_v; // @[CellProcessing.scala 185:25]
  wire  EB_OUT_io_dout_r; // @[CellProcessing.scala 185:25]
  wire [4:0] FS_io_ready_out; // @[CellProcessing.scala 196:21]
  wire [4:0] FS_io_fork_mask; // @[CellProcessing.scala 196:21]
  wire  FS_io_ready_in; // @[CellProcessing.scala 196:21]
  wire [31:0] I1_const = io_config_bits[115:84]; // @[CellProcessing.scala 109:32]
  wire [1:0] ready_FR1_lo = {io_south_dout_r,io_west_dout_r}; // @[Cat.scala 31:58]
  wire [1:0] ready_FR1_hi = {io_north_dout_r,io_east_dout_r}; // @[Cat.scala 31:58]
  wire [2:0] valid_in_FR1_lo = {io_south_din_v,io_east_din_v,io_north_din_v}; // @[Cat.scala 31:58]
  wire  FU_dout_v = FU_INST_io_dout_v; // @[CellProcessing.scala 181:15 86:25]
  wire [2:0] valid_in_FR1_hi = {FU_dout_v,1'h1,io_west_din_v}; // @[Cat.scala 31:58]
  wire [2:0] ready_out_FS_hi = {1'h1,io_north_dout_r,io_east_dout_r}; // @[Cat.scala 31:58]
  FR_4 FR_1 ( // @[CellProcessing.scala 115:23]
    .io_valid_in(FR_1_io_valid_in),
    .io_ready_out(FR_1_io_ready_out),
    .io_valid_mux_sel(FR_1_io_valid_mux_sel),
    .io_fork_mask(FR_1_io_fork_mask),
    .io_valid_out(FR_1_io_valid_out)
  );
  ConfMux_9 MUX_1 ( // @[CellProcessing.scala 124:24]
    .io_selector(MUX_1_io_selector),
    .io_mux_input(MUX_1_io_mux_input),
    .io_mux_output(MUX_1_io_mux_output)
  );
  D_EB EB_1 ( // @[CellProcessing.scala 129:23]
    .clock(EB_1_clock),
    .reset(EB_1_reset),
    .io_din(EB_1_io_din),
    .io_din_v(EB_1_io_din_v),
    .io_din_r(EB_1_io_din_r),
    .io_dout(EB_1_io_dout),
    .io_dout_v(EB_1_io_dout_v),
    .io_dout_r(EB_1_io_dout_r)
  );
  FR_4 FR_2 ( // @[CellProcessing.scala 137:23]
    .io_valid_in(FR_2_io_valid_in),
    .io_ready_out(FR_2_io_ready_out),
    .io_valid_mux_sel(FR_2_io_valid_mux_sel),
    .io_fork_mask(FR_2_io_fork_mask),
    .io_valid_out(FR_2_io_valid_out)
  );
  ConfMux_9 MUX_2 ( // @[CellProcessing.scala 146:24]
    .io_selector(MUX_2_io_selector),
    .io_mux_input(MUX_2_io_mux_input),
    .io_mux_output(MUX_2_io_mux_output)
  );
  D_EB EB_2 ( // @[CellProcessing.scala 151:23]
    .clock(EB_2_clock),
    .reset(EB_2_reset),
    .io_din(EB_2_io_din),
    .io_din_v(EB_2_io_din_v),
    .io_din_r(EB_2_io_din_r),
    .io_dout(EB_2_io_dout),
    .io_dout_v(EB_2_io_dout_v),
    .io_dout_r(EB_2_io_dout_r)
  );
  Join JOIN_INST ( // @[CellProcessing.scala 159:28]
    .io_din_1(JOIN_INST_io_din_1),
    .io_din_2(JOIN_INST_io_din_2),
    .io_dout_r(JOIN_INST_io_dout_r),
    .io_din_1_v(JOIN_INST_io_din_1_v),
    .io_din_2_v(JOIN_INST_io_din_2_v),
    .io_dout_v(JOIN_INST_io_dout_v),
    .io_din_1_r(JOIN_INST_io_din_1_r),
    .io_din_2_r(JOIN_INST_io_din_2_r),
    .io_dout_1(JOIN_INST_io_dout_1),
    .io_dout_2(JOIN_INST_io_dout_2)
  );
  FU FU_INST ( // @[CellProcessing.scala 172:26]
    .clock(FU_INST_clock),
    .reset(FU_INST_reset),
    .io_din_1(FU_INST_io_din_1),
    .io_din_2(FU_INST_io_din_2),
    .io_din_v(FU_INST_io_din_v),
    .io_dout_r(FU_INST_io_dout_r),
    .io_loop_source(FU_INST_io_loop_source),
    .io_iterations_reset(FU_INST_io_iterations_reset),
    .io_op_config(FU_INST_io_op_config),
    .io_din_r(FU_INST_io_din_r),
    .io_dout(FU_INST_io_dout),
    .io_dout_v(FU_INST_io_dout_v)
  );
  D_EB EB_OUT ( // @[CellProcessing.scala 185:25]
    .clock(EB_OUT_clock),
    .reset(EB_OUT_reset),
    .io_din(EB_OUT_io_din),
    .io_din_v(EB_OUT_io_din_v),
    .io_din_r(EB_OUT_io_din_r),
    .io_dout(EB_OUT_io_dout),
    .io_dout_v(EB_OUT_io_dout_v),
    .io_dout_r(EB_OUT_io_dout_r)
  );
  FS FS ( // @[CellProcessing.scala 196:21]
    .io_ready_out(FS_io_ready_out),
    .io_fork_mask(FS_io_fork_mask),
    .io_ready_in(FS_io_ready_in)
  );
  assign io_FU_din_1_r = EB_1_io_din_r; // @[CellProcessing.scala 132:19]
  assign io_FU_din_2_r = EB_2_io_din_r; // @[CellProcessing.scala 154:19]
  assign io_dout = EB_OUT_io_dout; // @[CellProcessing.scala 192:13]
  assign io_dout_v = EB_OUT_io_dout_v; // @[CellProcessing.scala 193:15]
  assign FR_1_io_valid_in = {valid_in_FR1_hi,valid_in_FR1_lo}; // @[Cat.scala 31:58]
  assign FR_1_io_ready_out = {ready_FR1_hi,ready_FR1_lo}; // @[Cat.scala 31:58]
  assign FR_1_io_valid_mux_sel = io_config_bits[2:0]; // @[CellProcessing.scala 99:37]
  assign FR_1_io_fork_mask = io_config_bits[17:14]; // @[CellProcessing.scala 101:43]
  assign MUX_1_io_selector = io_config_bits[2:0]; // @[CellProcessing.scala 99:37]
  assign MUX_1_io_mux_input = {FU_INST_io_dout,I1_const,io_west_din,io_south_din,io_east_din,io_north_din}; // @[CellProcessing.scala 126:106]
  assign EB_1_clock = clock;
  assign EB_1_reset = reset;
  assign EB_1_io_din = MUX_1_io_mux_output; // @[CellProcessing.scala 127:14 80:24]
  assign EB_1_io_din_v = FR_1_io_valid_out; // @[CellProcessing.scala 122:16 88:26]
  assign EB_1_io_dout_r = JOIN_INST_io_din_1_r; // @[CellProcessing.scala 167:18 91:28]
  assign FR_2_io_valid_in = {valid_in_FR1_hi,valid_in_FR1_lo}; // @[Cat.scala 31:58]
  assign FR_2_io_ready_out = {ready_FR1_hi,ready_FR1_lo}; // @[Cat.scala 31:58]
  assign FR_2_io_valid_mux_sel = io_config_bits[5:3]; // @[CellProcessing.scala 100:37]
  assign FR_2_io_fork_mask = io_config_bits[23:20]; // @[CellProcessing.scala 103:43]
  assign MUX_2_io_selector = io_config_bits[5:3]; // @[CellProcessing.scala 100:37]
  assign MUX_2_io_mux_input = {FU_INST_io_dout,I1_const,io_west_din,io_south_din,io_east_din,io_north_din}; // @[CellProcessing.scala 148:106]
  assign EB_2_clock = clock;
  assign EB_2_reset = reset;
  assign EB_2_io_din = MUX_2_io_mux_output; // @[CellProcessing.scala 149:14 81:24]
  assign EB_2_io_din_v = FR_2_io_valid_out; // @[CellProcessing.scala 144:16 89:26]
  assign EB_2_io_dout_r = JOIN_INST_io_din_2_r; // @[CellProcessing.scala 168:18 93:28]
  assign JOIN_INST_io_din_1 = EB_1_io_dout; // @[CellProcessing.scala 133:16 82:26]
  assign JOIN_INST_io_din_2 = EB_2_io_dout; // @[CellProcessing.scala 155:16 83:26]
  assign JOIN_INST_io_dout_r = FU_INST_io_din_r; // @[CellProcessing.scala 176:17 95:27]
  assign JOIN_INST_io_din_1_v = EB_1_io_dout_v; // @[CellProcessing.scala 134:18 90:28]
  assign JOIN_INST_io_din_2_v = EB_2_io_dout_v; // @[CellProcessing.scala 156:18 92:28]
  assign FU_INST_clock = clock;
  assign FU_INST_reset = reset;
  assign FU_INST_io_din_1 = JOIN_INST_io_dout_1; // @[CellProcessing.scala 169:17 84:27]
  assign FU_INST_io_din_2 = JOIN_INST_io_dout_2; // @[CellProcessing.scala 170:17 85:27]
  assign FU_INST_io_din_v = JOIN_INST_io_dout_v; // @[CellProcessing.scala 166:17 94:27]
  assign FU_INST_io_dout_r = EB_OUT_io_din_r; // @[CellProcessing.scala 191:15 87:25]
  assign FU_INST_io_loop_source = io_config_bits[181:180]; // @[CellProcessing.scala 113:41]
  assign FU_INST_io_iterations_reset = io_config_bits[179:164]; // @[CellProcessing.scala 112:44]
  assign FU_INST_io_op_config = io_config_bits[48:44]; // @[CellProcessing.scala 105:32]
  assign EB_OUT_clock = clock;
  assign EB_OUT_reset = reset;
  assign EB_OUT_io_din = FU_INST_io_dout; // @[CellProcessing.scala 188:19]
  assign EB_OUT_io_din_v = FU_INST_io_dout_v; // @[CellProcessing.scala 189:21]
  assign EB_OUT_io_dout_r = FS_io_ready_in; // @[CellProcessing.scala 199:19 96:29]
  assign FS_io_ready_out = {ready_out_FS_hi,ready_FR1_lo}; // @[Cat.scala 31:58]
  assign FS_io_fork_mask = io_config_bits[56:52]; // @[CellProcessing.scala 107:39]
endmodule
module ProcessingElement(
  input          clock,
  input          reset,
  input  [31:0]  io_north_din,
  input          io_north_din_v,
  output         io_north_din_r,
  input  [31:0]  io_east_din,
  input          io_east_din_v,
  output         io_east_din_r,
  input  [31:0]  io_south_din,
  input          io_south_din_v,
  output         io_south_din_r,
  input  [31:0]  io_west_din,
  input          io_west_din_v,
  output         io_west_din_r,
  output [31:0]  io_north_dout,
  output         io_north_dout_v,
  input          io_north_dout_r,
  output [31:0]  io_east_dout,
  output         io_east_dout_v,
  input          io_east_dout_r,
  output [31:0]  io_south_dout,
  output         io_south_dout_v,
  input          io_south_dout_r,
  output [31:0]  io_west_dout,
  output         io_west_dout_v,
  input          io_west_dout_r,
  input  [181:0] io_config_bits,
  input          io_catch_config
);
`ifdef RANDOMIZE_REG_INIT
  reg [191:0] _RAND_0;
`endif // RANDOMIZE_REG_INIT
  wire  FIFO_Nin_clock; // @[ProcessingElement.scala 159:27]
  wire  FIFO_Nin_reset; // @[ProcessingElement.scala 159:27]
  wire [31:0] FIFO_Nin_io_din; // @[ProcessingElement.scala 159:27]
  wire  FIFO_Nin_io_din_v; // @[ProcessingElement.scala 159:27]
  wire  FIFO_Nin_io_dout_r; // @[ProcessingElement.scala 159:27]
  wire  FIFO_Nin_io_din_r; // @[ProcessingElement.scala 159:27]
  wire [31:0] FIFO_Nin_io_dout; // @[ProcessingElement.scala 159:27]
  wire  FIFO_Nin_io_dout_v; // @[ProcessingElement.scala 159:27]
  wire [4:0] FS_Nin_io_ready_out; // @[ProcessingElement.scala 167:25]
  wire [4:0] FS_Nin_io_fork_mask; // @[ProcessingElement.scala 167:25]
  wire  FS_Nin_io_ready_in; // @[ProcessingElement.scala 167:25]
  wire [1:0] MUX_Nout_io_selector; // @[ProcessingElement.scala 173:28]
  wire [127:0] MUX_Nout_io_mux_input; // @[ProcessingElement.scala 173:28]
  wire [31:0] MUX_Nout_io_mux_output; // @[ProcessingElement.scala 173:28]
  wire [3:0] FR_Nout_io_valid_in; // @[ProcessingElement.scala 178:26]
  wire [4:0] FR_Nout_io_ready_out; // @[ProcessingElement.scala 178:26]
  wire [1:0] FR_Nout_io_valid_mux_sel; // @[ProcessingElement.scala 178:26]
  wire [4:0] FR_Nout_io_fork_mask; // @[ProcessingElement.scala 178:26]
  wire  FR_Nout_io_valid_out; // @[ProcessingElement.scala 178:26]
  wire  REG_Nout_clock; // @[ProcessingElement.scala 187:27]
  wire  REG_Nout_reset; // @[ProcessingElement.scala 187:27]
  wire [31:0] REG_Nout_io_din; // @[ProcessingElement.scala 187:27]
  wire  REG_Nout_io_din_v; // @[ProcessingElement.scala 187:27]
  wire  REG_Nout_io_dout_r; // @[ProcessingElement.scala 187:27]
  wire [31:0] REG_Nout_io_dout; // @[ProcessingElement.scala 187:27]
  wire  REG_Nout_io_dout_v; // @[ProcessingElement.scala 187:27]
  wire  REG_Nout_io_din_r; // @[ProcessingElement.scala 187:27]
  wire  FIFO_Ein_clock; // @[ProcessingElement.scala 201:27]
  wire  FIFO_Ein_reset; // @[ProcessingElement.scala 201:27]
  wire [31:0] FIFO_Ein_io_din; // @[ProcessingElement.scala 201:27]
  wire  FIFO_Ein_io_din_v; // @[ProcessingElement.scala 201:27]
  wire  FIFO_Ein_io_dout_r; // @[ProcessingElement.scala 201:27]
  wire  FIFO_Ein_io_din_r; // @[ProcessingElement.scala 201:27]
  wire [31:0] FIFO_Ein_io_dout; // @[ProcessingElement.scala 201:27]
  wire  FIFO_Ein_io_dout_v; // @[ProcessingElement.scala 201:27]
  wire [4:0] FS_Ein_io_ready_out; // @[ProcessingElement.scala 209:25]
  wire [4:0] FS_Ein_io_fork_mask; // @[ProcessingElement.scala 209:25]
  wire  FS_Ein_io_ready_in; // @[ProcessingElement.scala 209:25]
  wire [1:0] MUX_Eout_io_selector; // @[ProcessingElement.scala 215:28]
  wire [127:0] MUX_Eout_io_mux_input; // @[ProcessingElement.scala 215:28]
  wire [31:0] MUX_Eout_io_mux_output; // @[ProcessingElement.scala 215:28]
  wire [3:0] FR_Eout_io_valid_in; // @[ProcessingElement.scala 220:26]
  wire [4:0] FR_Eout_io_ready_out; // @[ProcessingElement.scala 220:26]
  wire [1:0] FR_Eout_io_valid_mux_sel; // @[ProcessingElement.scala 220:26]
  wire [4:0] FR_Eout_io_fork_mask; // @[ProcessingElement.scala 220:26]
  wire  FR_Eout_io_valid_out; // @[ProcessingElement.scala 220:26]
  wire  REG_Eout_clock; // @[ProcessingElement.scala 229:27]
  wire  REG_Eout_reset; // @[ProcessingElement.scala 229:27]
  wire [31:0] REG_Eout_io_din; // @[ProcessingElement.scala 229:27]
  wire  REG_Eout_io_din_v; // @[ProcessingElement.scala 229:27]
  wire  REG_Eout_io_dout_r; // @[ProcessingElement.scala 229:27]
  wire [31:0] REG_Eout_io_dout; // @[ProcessingElement.scala 229:27]
  wire  REG_Eout_io_dout_v; // @[ProcessingElement.scala 229:27]
  wire  REG_Eout_io_din_r; // @[ProcessingElement.scala 229:27]
  wire  FIFO_Sin_clock; // @[ProcessingElement.scala 242:27]
  wire  FIFO_Sin_reset; // @[ProcessingElement.scala 242:27]
  wire [31:0] FIFO_Sin_io_din; // @[ProcessingElement.scala 242:27]
  wire  FIFO_Sin_io_din_v; // @[ProcessingElement.scala 242:27]
  wire  FIFO_Sin_io_dout_r; // @[ProcessingElement.scala 242:27]
  wire  FIFO_Sin_io_din_r; // @[ProcessingElement.scala 242:27]
  wire [31:0] FIFO_Sin_io_dout; // @[ProcessingElement.scala 242:27]
  wire  FIFO_Sin_io_dout_v; // @[ProcessingElement.scala 242:27]
  wire [4:0] FS_Sin_io_ready_out; // @[ProcessingElement.scala 250:25]
  wire [4:0] FS_Sin_io_fork_mask; // @[ProcessingElement.scala 250:25]
  wire  FS_Sin_io_ready_in; // @[ProcessingElement.scala 250:25]
  wire [1:0] MUX_Sout_io_selector; // @[ProcessingElement.scala 256:28]
  wire [127:0] MUX_Sout_io_mux_input; // @[ProcessingElement.scala 256:28]
  wire [31:0] MUX_Sout_io_mux_output; // @[ProcessingElement.scala 256:28]
  wire [3:0] FR_Sout_io_valid_in; // @[ProcessingElement.scala 261:26]
  wire [4:0] FR_Sout_io_ready_out; // @[ProcessingElement.scala 261:26]
  wire [1:0] FR_Sout_io_valid_mux_sel; // @[ProcessingElement.scala 261:26]
  wire [4:0] FR_Sout_io_fork_mask; // @[ProcessingElement.scala 261:26]
  wire  FR_Sout_io_valid_out; // @[ProcessingElement.scala 261:26]
  wire  REG_Sout_clock; // @[ProcessingElement.scala 270:27]
  wire  REG_Sout_reset; // @[ProcessingElement.scala 270:27]
  wire [31:0] REG_Sout_io_din; // @[ProcessingElement.scala 270:27]
  wire  REG_Sout_io_din_v; // @[ProcessingElement.scala 270:27]
  wire  REG_Sout_io_dout_r; // @[ProcessingElement.scala 270:27]
  wire [31:0] REG_Sout_io_dout; // @[ProcessingElement.scala 270:27]
  wire  REG_Sout_io_dout_v; // @[ProcessingElement.scala 270:27]
  wire  REG_Sout_io_din_r; // @[ProcessingElement.scala 270:27]
  wire  FIFO_Win_clock; // @[ProcessingElement.scala 283:27]
  wire  FIFO_Win_reset; // @[ProcessingElement.scala 283:27]
  wire [31:0] FIFO_Win_io_din; // @[ProcessingElement.scala 283:27]
  wire  FIFO_Win_io_din_v; // @[ProcessingElement.scala 283:27]
  wire  FIFO_Win_io_dout_r; // @[ProcessingElement.scala 283:27]
  wire  FIFO_Win_io_din_r; // @[ProcessingElement.scala 283:27]
  wire [31:0] FIFO_Win_io_dout; // @[ProcessingElement.scala 283:27]
  wire  FIFO_Win_io_dout_v; // @[ProcessingElement.scala 283:27]
  wire [4:0] FS_Win_io_ready_out; // @[ProcessingElement.scala 291:25]
  wire [4:0] FS_Win_io_fork_mask; // @[ProcessingElement.scala 291:25]
  wire  FS_Win_io_ready_in; // @[ProcessingElement.scala 291:25]
  wire [1:0] MUX_Wout_io_selector; // @[ProcessingElement.scala 298:28]
  wire [127:0] MUX_Wout_io_mux_input; // @[ProcessingElement.scala 298:28]
  wire [31:0] MUX_Wout_io_mux_output; // @[ProcessingElement.scala 298:28]
  wire [3:0] FR_Wout_io_valid_in; // @[ProcessingElement.scala 303:26]
  wire [4:0] FR_Wout_io_ready_out; // @[ProcessingElement.scala 303:26]
  wire [1:0] FR_Wout_io_valid_mux_sel; // @[ProcessingElement.scala 303:26]
  wire [4:0] FR_Wout_io_fork_mask; // @[ProcessingElement.scala 303:26]
  wire  FR_Wout_io_valid_out; // @[ProcessingElement.scala 303:26]
  wire  REG_Wout_clock; // @[ProcessingElement.scala 312:27]
  wire  REG_Wout_reset; // @[ProcessingElement.scala 312:27]
  wire [31:0] REG_Wout_io_din; // @[ProcessingElement.scala 312:27]
  wire  REG_Wout_io_din_v; // @[ProcessingElement.scala 312:27]
  wire  REG_Wout_io_dout_r; // @[ProcessingElement.scala 312:27]
  wire [31:0] REG_Wout_io_dout; // @[ProcessingElement.scala 312:27]
  wire  REG_Wout_io_dout_v; // @[ProcessingElement.scala 312:27]
  wire  REG_Wout_io_din_r; // @[ProcessingElement.scala 312:27]
  wire  CELL_clock; // @[ProcessingElement.scala 324:23]
  wire  CELL_reset; // @[ProcessingElement.scala 324:23]
  wire [31:0] CELL_io_north_din; // @[ProcessingElement.scala 324:23]
  wire  CELL_io_north_din_v; // @[ProcessingElement.scala 324:23]
  wire [31:0] CELL_io_east_din; // @[ProcessingElement.scala 324:23]
  wire  CELL_io_east_din_v; // @[ProcessingElement.scala 324:23]
  wire [31:0] CELL_io_south_din; // @[ProcessingElement.scala 324:23]
  wire  CELL_io_south_din_v; // @[ProcessingElement.scala 324:23]
  wire [31:0] CELL_io_west_din; // @[ProcessingElement.scala 324:23]
  wire  CELL_io_west_din_v; // @[ProcessingElement.scala 324:23]
  wire  CELL_io_FU_din_1_r; // @[ProcessingElement.scala 324:23]
  wire  CELL_io_FU_din_2_r; // @[ProcessingElement.scala 324:23]
  wire [31:0] CELL_io_dout; // @[ProcessingElement.scala 324:23]
  wire  CELL_io_dout_v; // @[ProcessingElement.scala 324:23]
  wire  CELL_io_north_dout_r; // @[ProcessingElement.scala 324:23]
  wire  CELL_io_east_dout_r; // @[ProcessingElement.scala 324:23]
  wire  CELL_io_south_dout_r; // @[ProcessingElement.scala 324:23]
  wire  CELL_io_west_dout_r; // @[ProcessingElement.scala 324:23]
  wire [181:0] CELL_io_config_bits; // @[ProcessingElement.scala 324:23]
  reg [181:0] config_bits_reg; // @[ProcessingElement.scala 97:34]
  wire  south_REG_din_r = REG_Sout_io_din_r; // @[ProcessingElement.scala 127:31 276:21]
  wire  west_REG_din_r = REG_Wout_io_din_r; // @[ProcessingElement.scala 128:30 318:20]
  wire [1:0] ready_out_FS_Nin_lo = {south_REG_din_r,west_REG_din_r}; // @[Cat.scala 31:58]
  wire  FU_din_1_r = CELL_io_FU_din_1_r; // @[ProcessingElement.scala 130:26 339:16]
  wire  FU_din_2_r = CELL_io_FU_din_2_r; // @[ProcessingElement.scala 131:26 340:16]
  wire  east_REG_din_r = REG_Eout_io_din_r; // @[ProcessingElement.scala 126:30 235:20]
  wire [2:0] ready_out_FS_Nin_hi = {FU_din_1_r,FU_din_2_r,east_REG_din_r}; // @[Cat.scala 31:58]
  wire  east_buffer_v = FIFO_Ein_io_dout_v; // @[ProcessingElement.scala 106:29 207:19]
  wire  FU_dout_v = CELL_io_dout_v; // @[ProcessingElement.scala 133:25 342:15]
  wire [1:0] valid_in_FR_Nout_lo = {east_buffer_v,FU_dout_v}; // @[Cat.scala 31:58]
  wire  west_buffer_v = FIFO_Win_io_dout_v; // @[ProcessingElement.scala 108:29 289:19]
  wire  south_buffer_v = FIFO_Sin_io_dout_v; // @[ProcessingElement.scala 107:30 248:20]
  wire [1:0] valid_in_FR_Nout_hi = {west_buffer_v,south_buffer_v}; // @[Cat.scala 31:58]
  wire  north_REG_din_r = REG_Nout_io_din_r; // @[ProcessingElement.scala 125:31 193:21]
  wire [2:0] ready_out_FS_Ein_hi = {FU_din_1_r,FU_din_2_r,north_REG_din_r}; // @[Cat.scala 31:58]
  wire  north_buffer_v = FIFO_Nin_io_dout_v; // @[ProcessingElement.scala 105:30 165:20]
  wire [1:0] valid_in_FR_Eout_lo = {north_buffer_v,FU_dout_v}; // @[Cat.scala 31:58]
  wire [1:0] ready_out_FS_Sin_lo = {east_REG_din_r,west_REG_din_r}; // @[Cat.scala 31:58]
  wire [1:0] valid_in_FR_Sout_hi = {west_buffer_v,east_buffer_v}; // @[Cat.scala 31:58]
  wire [1:0] ready_out_FS_Win_lo = {east_REG_din_r,south_REG_din_r}; // @[Cat.scala 31:58]
  wire [1:0] valid_in_FR_Wout_hi = {south_buffer_v,east_buffer_v}; // @[Cat.scala 31:58]
  D_FIFO FIFO_Nin ( // @[ProcessingElement.scala 159:27]
    .clock(FIFO_Nin_clock),
    .reset(FIFO_Nin_reset),
    .io_din(FIFO_Nin_io_din),
    .io_din_v(FIFO_Nin_io_din_v),
    .io_dout_r(FIFO_Nin_io_dout_r),
    .io_din_r(FIFO_Nin_io_din_r),
    .io_dout(FIFO_Nin_io_dout),
    .io_dout_v(FIFO_Nin_io_dout_v)
  );
  FS FS_Nin ( // @[ProcessingElement.scala 167:25]
    .io_ready_out(FS_Nin_io_ready_out),
    .io_fork_mask(FS_Nin_io_fork_mask),
    .io_ready_in(FS_Nin_io_ready_in)
  );
  ConfMux MUX_Nout ( // @[ProcessingElement.scala 173:28]
    .io_selector(MUX_Nout_io_selector),
    .io_mux_input(MUX_Nout_io_mux_input),
    .io_mux_output(MUX_Nout_io_mux_output)
  );
  FR FR_Nout ( // @[ProcessingElement.scala 178:26]
    .io_valid_in(FR_Nout_io_valid_in),
    .io_ready_out(FR_Nout_io_ready_out),
    .io_valid_mux_sel(FR_Nout_io_valid_mux_sel),
    .io_fork_mask(FR_Nout_io_fork_mask),
    .io_valid_out(FR_Nout_io_valid_out)
  );
  D_REG REG_Nout ( // @[ProcessingElement.scala 187:27]
    .clock(REG_Nout_clock),
    .reset(REG_Nout_reset),
    .io_din(REG_Nout_io_din),
    .io_din_v(REG_Nout_io_din_v),
    .io_dout_r(REG_Nout_io_dout_r),
    .io_dout(REG_Nout_io_dout),
    .io_dout_v(REG_Nout_io_dout_v),
    .io_din_r(REG_Nout_io_din_r)
  );
  D_FIFO FIFO_Ein ( // @[ProcessingElement.scala 201:27]
    .clock(FIFO_Ein_clock),
    .reset(FIFO_Ein_reset),
    .io_din(FIFO_Ein_io_din),
    .io_din_v(FIFO_Ein_io_din_v),
    .io_dout_r(FIFO_Ein_io_dout_r),
    .io_din_r(FIFO_Ein_io_din_r),
    .io_dout(FIFO_Ein_io_dout),
    .io_dout_v(FIFO_Ein_io_dout_v)
  );
  FS FS_Ein ( // @[ProcessingElement.scala 209:25]
    .io_ready_out(FS_Ein_io_ready_out),
    .io_fork_mask(FS_Ein_io_fork_mask),
    .io_ready_in(FS_Ein_io_ready_in)
  );
  ConfMux MUX_Eout ( // @[ProcessingElement.scala 215:28]
    .io_selector(MUX_Eout_io_selector),
    .io_mux_input(MUX_Eout_io_mux_input),
    .io_mux_output(MUX_Eout_io_mux_output)
  );
  FR FR_Eout ( // @[ProcessingElement.scala 220:26]
    .io_valid_in(FR_Eout_io_valid_in),
    .io_ready_out(FR_Eout_io_ready_out),
    .io_valid_mux_sel(FR_Eout_io_valid_mux_sel),
    .io_fork_mask(FR_Eout_io_fork_mask),
    .io_valid_out(FR_Eout_io_valid_out)
  );
  D_REG REG_Eout ( // @[ProcessingElement.scala 229:27]
    .clock(REG_Eout_clock),
    .reset(REG_Eout_reset),
    .io_din(REG_Eout_io_din),
    .io_din_v(REG_Eout_io_din_v),
    .io_dout_r(REG_Eout_io_dout_r),
    .io_dout(REG_Eout_io_dout),
    .io_dout_v(REG_Eout_io_dout_v),
    .io_din_r(REG_Eout_io_din_r)
  );
  D_FIFO FIFO_Sin ( // @[ProcessingElement.scala 242:27]
    .clock(FIFO_Sin_clock),
    .reset(FIFO_Sin_reset),
    .io_din(FIFO_Sin_io_din),
    .io_din_v(FIFO_Sin_io_din_v),
    .io_dout_r(FIFO_Sin_io_dout_r),
    .io_din_r(FIFO_Sin_io_din_r),
    .io_dout(FIFO_Sin_io_dout),
    .io_dout_v(FIFO_Sin_io_dout_v)
  );
  FS FS_Sin ( // @[ProcessingElement.scala 250:25]
    .io_ready_out(FS_Sin_io_ready_out),
    .io_fork_mask(FS_Sin_io_fork_mask),
    .io_ready_in(FS_Sin_io_ready_in)
  );
  ConfMux MUX_Sout ( // @[ProcessingElement.scala 256:28]
    .io_selector(MUX_Sout_io_selector),
    .io_mux_input(MUX_Sout_io_mux_input),
    .io_mux_output(MUX_Sout_io_mux_output)
  );
  FR FR_Sout ( // @[ProcessingElement.scala 261:26]
    .io_valid_in(FR_Sout_io_valid_in),
    .io_ready_out(FR_Sout_io_ready_out),
    .io_valid_mux_sel(FR_Sout_io_valid_mux_sel),
    .io_fork_mask(FR_Sout_io_fork_mask),
    .io_valid_out(FR_Sout_io_valid_out)
  );
  D_REG REG_Sout ( // @[ProcessingElement.scala 270:27]
    .clock(REG_Sout_clock),
    .reset(REG_Sout_reset),
    .io_din(REG_Sout_io_din),
    .io_din_v(REG_Sout_io_din_v),
    .io_dout_r(REG_Sout_io_dout_r),
    .io_dout(REG_Sout_io_dout),
    .io_dout_v(REG_Sout_io_dout_v),
    .io_din_r(REG_Sout_io_din_r)
  );
  D_FIFO FIFO_Win ( // @[ProcessingElement.scala 283:27]
    .clock(FIFO_Win_clock),
    .reset(FIFO_Win_reset),
    .io_din(FIFO_Win_io_din),
    .io_din_v(FIFO_Win_io_din_v),
    .io_dout_r(FIFO_Win_io_dout_r),
    .io_din_r(FIFO_Win_io_din_r),
    .io_dout(FIFO_Win_io_dout),
    .io_dout_v(FIFO_Win_io_dout_v)
  );
  FS FS_Win ( // @[ProcessingElement.scala 291:25]
    .io_ready_out(FS_Win_io_ready_out),
    .io_fork_mask(FS_Win_io_fork_mask),
    .io_ready_in(FS_Win_io_ready_in)
  );
  ConfMux MUX_Wout ( // @[ProcessingElement.scala 298:28]
    .io_selector(MUX_Wout_io_selector),
    .io_mux_input(MUX_Wout_io_mux_input),
    .io_mux_output(MUX_Wout_io_mux_output)
  );
  FR FR_Wout ( // @[ProcessingElement.scala 303:26]
    .io_valid_in(FR_Wout_io_valid_in),
    .io_ready_out(FR_Wout_io_ready_out),
    .io_valid_mux_sel(FR_Wout_io_valid_mux_sel),
    .io_fork_mask(FR_Wout_io_fork_mask),
    .io_valid_out(FR_Wout_io_valid_out)
  );
  D_REG REG_Wout ( // @[ProcessingElement.scala 312:27]
    .clock(REG_Wout_clock),
    .reset(REG_Wout_reset),
    .io_din(REG_Wout_io_din),
    .io_din_v(REG_Wout_io_din_v),
    .io_dout_r(REG_Wout_io_dout_r),
    .io_dout(REG_Wout_io_dout),
    .io_dout_v(REG_Wout_io_dout_v),
    .io_din_r(REG_Wout_io_din_r)
  );
  CellProcessing CELL ( // @[ProcessingElement.scala 324:23]
    .clock(CELL_clock),
    .reset(CELL_reset),
    .io_north_din(CELL_io_north_din),
    .io_north_din_v(CELL_io_north_din_v),
    .io_east_din(CELL_io_east_din),
    .io_east_din_v(CELL_io_east_din_v),
    .io_south_din(CELL_io_south_din),
    .io_south_din_v(CELL_io_south_din_v),
    .io_west_din(CELL_io_west_din),
    .io_west_din_v(CELL_io_west_din_v),
    .io_FU_din_1_r(CELL_io_FU_din_1_r),
    .io_FU_din_2_r(CELL_io_FU_din_2_r),
    .io_dout(CELL_io_dout),
    .io_dout_v(CELL_io_dout_v),
    .io_north_dout_r(CELL_io_north_dout_r),
    .io_east_dout_r(CELL_io_east_dout_r),
    .io_south_dout_r(CELL_io_south_dout_r),
    .io_west_dout_r(CELL_io_west_dout_r),
    .io_config_bits(CELL_io_config_bits)
  );
  assign io_north_din_r = FIFO_Nin_io_din_r; // @[ProcessingElement.scala 163:20]
  assign io_east_din_r = FIFO_Ein_io_din_r; // @[ProcessingElement.scala 205:19]
  assign io_south_din_r = FIFO_Sin_io_din_r; // @[ProcessingElement.scala 246:20]
  assign io_west_din_r = FIFO_Win_io_din_r; // @[ProcessingElement.scala 287:19]
  assign io_north_dout = REG_Nout_io_dout; // @[ProcessingElement.scala 194:19]
  assign io_north_dout_v = REG_Nout_io_dout_v; // @[ProcessingElement.scala 195:21]
  assign io_east_dout = REG_Eout_io_dout; // @[ProcessingElement.scala 236:18]
  assign io_east_dout_v = REG_Eout_io_dout_v; // @[ProcessingElement.scala 237:20]
  assign io_south_dout = REG_Sout_io_dout; // @[ProcessingElement.scala 277:19]
  assign io_south_dout_v = REG_Sout_io_dout_v; // @[ProcessingElement.scala 278:21]
  assign io_west_dout = REG_Wout_io_dout; // @[ProcessingElement.scala 319:18]
  assign io_west_dout_v = REG_Wout_io_dout_v; // @[ProcessingElement.scala 320:20]
  assign FIFO_Nin_clock = clock;
  assign FIFO_Nin_reset = reset;
  assign FIFO_Nin_io_din = io_north_din; // @[ProcessingElement.scala 160:21]
  assign FIFO_Nin_io_din_v = io_north_din_v; // @[ProcessingElement.scala 161:23]
  assign FIFO_Nin_io_dout_r = FS_Nin_io_ready_in; // @[ProcessingElement.scala 110:30 170:20]
  assign FS_Nin_io_ready_out = {ready_out_FS_Nin_hi,ready_out_FS_Nin_lo}; // @[Cat.scala 31:58]
  assign FS_Nin_io_fork_mask = config_bits_reg[28:24]; // @[ProcessingElement.scala 147:40]
  assign MUX_Nout_io_selector = config_bits_reg[7:6]; // @[ProcessingElement.scala 142:33]
  assign MUX_Nout_io_mux_input = {FIFO_Win_io_dout,FIFO_Sin_io_dout,FIFO_Ein_io_dout,CELL_io_dout}; // @[ProcessingElement.scala 175:85]
  assign FR_Nout_io_valid_in = {valid_in_FR_Nout_hi,valid_in_FR_Nout_lo}; // @[Cat.scala 31:58]
  assign FR_Nout_io_ready_out = {ready_out_FS_Nin_hi,ready_out_FS_Nin_lo}; // @[Cat.scala 31:58]
  assign FR_Nout_io_valid_mux_sel = config_bits_reg[7:6]; // @[ProcessingElement.scala 142:33]
  assign FR_Nout_io_fork_mask = config_bits_reg[61:57]; // @[ProcessingElement.scala 152:39]
  assign REG_Nout_clock = clock;
  assign REG_Nout_reset = reset;
  assign REG_Nout_io_din = MUX_Nout_io_mux_output; // @[ProcessingElement.scala 115:29 176:19]
  assign REG_Nout_io_din_v = FR_Nout_io_valid_out; // @[ProcessingElement.scala 120:31 185:21]
  assign REG_Nout_io_dout_r = io_north_dout_r; // @[ProcessingElement.scala 191:24]
  assign FIFO_Ein_clock = clock;
  assign FIFO_Ein_reset = reset;
  assign FIFO_Ein_io_din = io_east_din; // @[ProcessingElement.scala 202:21]
  assign FIFO_Ein_io_din_v = io_east_din_v; // @[ProcessingElement.scala 203:23]
  assign FIFO_Ein_io_dout_r = FS_Ein_io_ready_in; // @[ProcessingElement.scala 111:29 212:19]
  assign FS_Ein_io_ready_out = {ready_out_FS_Ein_hi,ready_out_FS_Nin_lo}; // @[Cat.scala 31:58]
  assign FS_Ein_io_fork_mask = config_bits_reg[33:29]; // @[ProcessingElement.scala 148:40]
  assign MUX_Eout_io_selector = config_bits_reg[9:8]; // @[ProcessingElement.scala 143:33]
  assign MUX_Eout_io_mux_input = {FIFO_Win_io_dout,FIFO_Sin_io_dout,FIFO_Nin_io_dout,CELL_io_dout}; // @[ProcessingElement.scala 217:86]
  assign FR_Eout_io_valid_in = {valid_in_FR_Nout_hi,valid_in_FR_Eout_lo}; // @[Cat.scala 31:58]
  assign FR_Eout_io_ready_out = {ready_out_FS_Ein_hi,ready_out_FS_Nin_lo}; // @[Cat.scala 31:58]
  assign FR_Eout_io_valid_mux_sel = config_bits_reg[9:8]; // @[ProcessingElement.scala 143:33]
  assign FR_Eout_io_fork_mask = config_bits_reg[66:62]; // @[ProcessingElement.scala 153:39]
  assign REG_Eout_clock = clock;
  assign REG_Eout_reset = reset;
  assign REG_Eout_io_din = MUX_Eout_io_mux_output; // @[ProcessingElement.scala 116:28 218:18]
  assign REG_Eout_io_din_v = FR_Eout_io_valid_out; // @[ProcessingElement.scala 121:30 227:20]
  assign REG_Eout_io_dout_r = io_east_dout_r; // @[ProcessingElement.scala 233:24]
  assign FIFO_Sin_clock = clock;
  assign FIFO_Sin_reset = reset;
  assign FIFO_Sin_io_din = io_south_din; // @[ProcessingElement.scala 243:21]
  assign FIFO_Sin_io_din_v = io_south_din_v; // @[ProcessingElement.scala 244:23]
  assign FIFO_Sin_io_dout_r = FS_Sin_io_ready_in; // @[ProcessingElement.scala 112:30 253:20]
  assign FS_Sin_io_ready_out = {ready_out_FS_Ein_hi,ready_out_FS_Sin_lo}; // @[Cat.scala 31:58]
  assign FS_Sin_io_fork_mask = config_bits_reg[38:34]; // @[ProcessingElement.scala 149:40]
  assign MUX_Sout_io_selector = config_bits_reg[11:10]; // @[ProcessingElement.scala 144:33]
  assign MUX_Sout_io_mux_input = {FIFO_Win_io_dout,FIFO_Ein_io_dout,FIFO_Nin_io_dout,CELL_io_dout}; // @[ProcessingElement.scala 258:85]
  assign FR_Sout_io_valid_in = {valid_in_FR_Sout_hi,valid_in_FR_Eout_lo}; // @[Cat.scala 31:58]
  assign FR_Sout_io_ready_out = {ready_out_FS_Ein_hi,ready_out_FS_Sin_lo}; // @[Cat.scala 31:58]
  assign FR_Sout_io_valid_mux_sel = config_bits_reg[11:10]; // @[ProcessingElement.scala 144:33]
  assign FR_Sout_io_fork_mask = config_bits_reg[71:67]; // @[ProcessingElement.scala 154:39]
  assign REG_Sout_clock = clock;
  assign REG_Sout_reset = reset;
  assign REG_Sout_io_din = MUX_Sout_io_mux_output; // @[ProcessingElement.scala 117:29 259:19]
  assign REG_Sout_io_din_v = FR_Sout_io_valid_out; // @[ProcessingElement.scala 122:31 268:21]
  assign REG_Sout_io_dout_r = io_south_dout_r; // @[ProcessingElement.scala 274:24]
  assign FIFO_Win_clock = clock;
  assign FIFO_Win_reset = reset;
  assign FIFO_Win_io_din = io_west_din; // @[ProcessingElement.scala 284:21]
  assign FIFO_Win_io_din_v = io_west_din_v; // @[ProcessingElement.scala 285:23]
  assign FIFO_Win_io_dout_r = FS_Win_io_ready_in; // @[ProcessingElement.scala 113:29 295:19]
  assign FS_Win_io_ready_out = {ready_out_FS_Ein_hi,ready_out_FS_Win_lo}; // @[Cat.scala 31:58]
  assign FS_Win_io_fork_mask = config_bits_reg[43:39]; // @[ProcessingElement.scala 150:40]
  assign MUX_Wout_io_selector = config_bits_reg[13:12]; // @[ProcessingElement.scala 145:33]
  assign MUX_Wout_io_mux_input = {FIFO_Sin_io_dout,FIFO_Ein_io_dout,FIFO_Nin_io_dout,CELL_io_dout}; // @[ProcessingElement.scala 300:86]
  assign FR_Wout_io_valid_in = {valid_in_FR_Wout_hi,valid_in_FR_Eout_lo}; // @[Cat.scala 31:58]
  assign FR_Wout_io_ready_out = {ready_out_FS_Ein_hi,ready_out_FS_Win_lo}; // @[Cat.scala 31:58]
  assign FR_Wout_io_valid_mux_sel = config_bits_reg[13:12]; // @[ProcessingElement.scala 145:33]
  assign FR_Wout_io_fork_mask = config_bits_reg[76:72]; // @[ProcessingElement.scala 155:39]
  assign REG_Wout_clock = clock;
  assign REG_Wout_reset = reset;
  assign REG_Wout_io_din = MUX_Wout_io_mux_output; // @[ProcessingElement.scala 118:28 301:18]
  assign REG_Wout_io_din_v = FR_Wout_io_valid_out; // @[ProcessingElement.scala 123:30 310:20]
  assign REG_Wout_io_dout_r = io_west_dout_r; // @[ProcessingElement.scala 316:24]
  assign CELL_clock = clock;
  assign CELL_reset = reset;
  assign CELL_io_north_din = FIFO_Nin_io_dout; // @[ProcessingElement.scala 100:28 164:18]
  assign CELL_io_north_din_v = FIFO_Nin_io_dout_v; // @[ProcessingElement.scala 105:30 165:20]
  assign CELL_io_east_din = FIFO_Ein_io_dout; // @[ProcessingElement.scala 101:27 206:17]
  assign CELL_io_east_din_v = FIFO_Ein_io_dout_v; // @[ProcessingElement.scala 106:29 207:19]
  assign CELL_io_south_din = FIFO_Sin_io_dout; // @[ProcessingElement.scala 102:28 247:18]
  assign CELL_io_south_din_v = FIFO_Sin_io_dout_v; // @[ProcessingElement.scala 107:30 248:20]
  assign CELL_io_west_din = FIFO_Win_io_dout; // @[ProcessingElement.scala 103:27 288:17]
  assign CELL_io_west_din_v = FIFO_Win_io_dout_v; // @[ProcessingElement.scala 108:29 289:19]
  assign CELL_io_north_dout_r = REG_Nout_io_din_r; // @[ProcessingElement.scala 125:31 193:21]
  assign CELL_io_east_dout_r = REG_Eout_io_din_r; // @[ProcessingElement.scala 126:30 235:20]
  assign CELL_io_south_dout_r = REG_Sout_io_din_r; // @[ProcessingElement.scala 127:31 276:21]
  assign CELL_io_west_dout_r = REG_Wout_io_din_r; // @[ProcessingElement.scala 128:30 318:20]
  assign CELL_io_config_bits = config_bits_reg; // @[ProcessingElement.scala 337:25]
  always @(posedge clock) begin
    if (reset) begin // @[ProcessingElement.scala 97:34]
      config_bits_reg <= 182'h0; // @[ProcessingElement.scala 97:34]
    end else if (io_catch_config) begin // @[ProcessingElement.scala 136:28]
      config_bits_reg <= io_config_bits; // @[ProcessingElement.scala 137:25]
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
  _RAND_0 = {6{`RANDOM}};
  config_bits_reg = _RAND_0[181:0];
`endif // RANDOMIZE_REG_INIT
  `endif // RANDOMIZE
end // initial
`ifdef FIRRTL_AFTER_INITIAL
`FIRRTL_AFTER_INITIAL
`endif
`endif // SYNTHESIS
endmodule
module OverlayRocc(
  input          clock,
  input          reset,
  input  [191:0] io_data_in,
  input  [5:0]   io_data_in_valid,
  output [5:0]   io_data_in_ready,
  output [191:0] io_data_out,
  output [5:0]   io_data_out_valid,
  input  [5:0]   io_data_out_ready,
  input  [191:0] io_cell_config
);
  wire  NORTHWEST_OV_clock; // @[OverlayRocc.scala 130:46]
  wire  NORTHWEST_OV_reset; // @[OverlayRocc.scala 130:46]
  wire [31:0] NORTHWEST_OV_io_north_din; // @[OverlayRocc.scala 130:46]
  wire  NORTHWEST_OV_io_north_din_v; // @[OverlayRocc.scala 130:46]
  wire  NORTHWEST_OV_io_north_din_r; // @[OverlayRocc.scala 130:46]
  wire [31:0] NORTHWEST_OV_io_east_din; // @[OverlayRocc.scala 130:46]
  wire  NORTHWEST_OV_io_east_din_v; // @[OverlayRocc.scala 130:46]
  wire  NORTHWEST_OV_io_east_din_r; // @[OverlayRocc.scala 130:46]
  wire [31:0] NORTHWEST_OV_io_south_din; // @[OverlayRocc.scala 130:46]
  wire  NORTHWEST_OV_io_south_din_v; // @[OverlayRocc.scala 130:46]
  wire  NORTHWEST_OV_io_south_din_r; // @[OverlayRocc.scala 130:46]
  wire [31:0] NORTHWEST_OV_io_west_din; // @[OverlayRocc.scala 130:46]
  wire  NORTHWEST_OV_io_west_din_v; // @[OverlayRocc.scala 130:46]
  wire  NORTHWEST_OV_io_west_din_r; // @[OverlayRocc.scala 130:46]
  wire [31:0] NORTHWEST_OV_io_north_dout; // @[OverlayRocc.scala 130:46]
  wire  NORTHWEST_OV_io_north_dout_v; // @[OverlayRocc.scala 130:46]
  wire  NORTHWEST_OV_io_north_dout_r; // @[OverlayRocc.scala 130:46]
  wire [31:0] NORTHWEST_OV_io_east_dout; // @[OverlayRocc.scala 130:46]
  wire  NORTHWEST_OV_io_east_dout_v; // @[OverlayRocc.scala 130:46]
  wire  NORTHWEST_OV_io_east_dout_r; // @[OverlayRocc.scala 130:46]
  wire [31:0] NORTHWEST_OV_io_south_dout; // @[OverlayRocc.scala 130:46]
  wire  NORTHWEST_OV_io_south_dout_v; // @[OverlayRocc.scala 130:46]
  wire  NORTHWEST_OV_io_south_dout_r; // @[OverlayRocc.scala 130:46]
  wire [31:0] NORTHWEST_OV_io_west_dout; // @[OverlayRocc.scala 130:46]
  wire  NORTHWEST_OV_io_west_dout_v; // @[OverlayRocc.scala 130:46]
  wire  NORTHWEST_OV_io_west_dout_r; // @[OverlayRocc.scala 130:46]
  wire [181:0] NORTHWEST_OV_io_config_bits; // @[OverlayRocc.scala 130:46]
  wire  NORTHWEST_OV_io_catch_config; // @[OverlayRocc.scala 130:46]
  wire  MIDWEST_OV_clock; // @[OverlayRocc.scala 179:44]
  wire  MIDWEST_OV_reset; // @[OverlayRocc.scala 179:44]
  wire [31:0] MIDWEST_OV_io_north_din; // @[OverlayRocc.scala 179:44]
  wire  MIDWEST_OV_io_north_din_v; // @[OverlayRocc.scala 179:44]
  wire  MIDWEST_OV_io_north_din_r; // @[OverlayRocc.scala 179:44]
  wire [31:0] MIDWEST_OV_io_east_din; // @[OverlayRocc.scala 179:44]
  wire  MIDWEST_OV_io_east_din_v; // @[OverlayRocc.scala 179:44]
  wire  MIDWEST_OV_io_east_din_r; // @[OverlayRocc.scala 179:44]
  wire [31:0] MIDWEST_OV_io_south_din; // @[OverlayRocc.scala 179:44]
  wire  MIDWEST_OV_io_south_din_v; // @[OverlayRocc.scala 179:44]
  wire  MIDWEST_OV_io_south_din_r; // @[OverlayRocc.scala 179:44]
  wire [31:0] MIDWEST_OV_io_west_din; // @[OverlayRocc.scala 179:44]
  wire  MIDWEST_OV_io_west_din_v; // @[OverlayRocc.scala 179:44]
  wire  MIDWEST_OV_io_west_din_r; // @[OverlayRocc.scala 179:44]
  wire [31:0] MIDWEST_OV_io_north_dout; // @[OverlayRocc.scala 179:44]
  wire  MIDWEST_OV_io_north_dout_v; // @[OverlayRocc.scala 179:44]
  wire  MIDWEST_OV_io_north_dout_r; // @[OverlayRocc.scala 179:44]
  wire [31:0] MIDWEST_OV_io_east_dout; // @[OverlayRocc.scala 179:44]
  wire  MIDWEST_OV_io_east_dout_v; // @[OverlayRocc.scala 179:44]
  wire  MIDWEST_OV_io_east_dout_r; // @[OverlayRocc.scala 179:44]
  wire [31:0] MIDWEST_OV_io_south_dout; // @[OverlayRocc.scala 179:44]
  wire  MIDWEST_OV_io_south_dout_v; // @[OverlayRocc.scala 179:44]
  wire  MIDWEST_OV_io_south_dout_r; // @[OverlayRocc.scala 179:44]
  wire [31:0] MIDWEST_OV_io_west_dout; // @[OverlayRocc.scala 179:44]
  wire  MIDWEST_OV_io_west_dout_v; // @[OverlayRocc.scala 179:44]
  wire  MIDWEST_OV_io_west_dout_r; // @[OverlayRocc.scala 179:44]
  wire [181:0] MIDWEST_OV_io_config_bits; // @[OverlayRocc.scala 179:44]
  wire  MIDWEST_OV_io_catch_config; // @[OverlayRocc.scala 179:44]
  wire  MIDWEST_OV_1_clock; // @[OverlayRocc.scala 179:44]
  wire  MIDWEST_OV_1_reset; // @[OverlayRocc.scala 179:44]
  wire [31:0] MIDWEST_OV_1_io_north_din; // @[OverlayRocc.scala 179:44]
  wire  MIDWEST_OV_1_io_north_din_v; // @[OverlayRocc.scala 179:44]
  wire  MIDWEST_OV_1_io_north_din_r; // @[OverlayRocc.scala 179:44]
  wire [31:0] MIDWEST_OV_1_io_east_din; // @[OverlayRocc.scala 179:44]
  wire  MIDWEST_OV_1_io_east_din_v; // @[OverlayRocc.scala 179:44]
  wire  MIDWEST_OV_1_io_east_din_r; // @[OverlayRocc.scala 179:44]
  wire [31:0] MIDWEST_OV_1_io_south_din; // @[OverlayRocc.scala 179:44]
  wire  MIDWEST_OV_1_io_south_din_v; // @[OverlayRocc.scala 179:44]
  wire  MIDWEST_OV_1_io_south_din_r; // @[OverlayRocc.scala 179:44]
  wire [31:0] MIDWEST_OV_1_io_west_din; // @[OverlayRocc.scala 179:44]
  wire  MIDWEST_OV_1_io_west_din_v; // @[OverlayRocc.scala 179:44]
  wire  MIDWEST_OV_1_io_west_din_r; // @[OverlayRocc.scala 179:44]
  wire [31:0] MIDWEST_OV_1_io_north_dout; // @[OverlayRocc.scala 179:44]
  wire  MIDWEST_OV_1_io_north_dout_v; // @[OverlayRocc.scala 179:44]
  wire  MIDWEST_OV_1_io_north_dout_r; // @[OverlayRocc.scala 179:44]
  wire [31:0] MIDWEST_OV_1_io_east_dout; // @[OverlayRocc.scala 179:44]
  wire  MIDWEST_OV_1_io_east_dout_v; // @[OverlayRocc.scala 179:44]
  wire  MIDWEST_OV_1_io_east_dout_r; // @[OverlayRocc.scala 179:44]
  wire [31:0] MIDWEST_OV_1_io_south_dout; // @[OverlayRocc.scala 179:44]
  wire  MIDWEST_OV_1_io_south_dout_v; // @[OverlayRocc.scala 179:44]
  wire  MIDWEST_OV_1_io_south_dout_r; // @[OverlayRocc.scala 179:44]
  wire [31:0] MIDWEST_OV_1_io_west_dout; // @[OverlayRocc.scala 179:44]
  wire  MIDWEST_OV_1_io_west_dout_v; // @[OverlayRocc.scala 179:44]
  wire  MIDWEST_OV_1_io_west_dout_r; // @[OverlayRocc.scala 179:44]
  wire [181:0] MIDWEST_OV_1_io_config_bits; // @[OverlayRocc.scala 179:44]
  wire  MIDWEST_OV_1_io_catch_config; // @[OverlayRocc.scala 179:44]
  wire  MIDWEST_OV_2_clock; // @[OverlayRocc.scala 179:44]
  wire  MIDWEST_OV_2_reset; // @[OverlayRocc.scala 179:44]
  wire [31:0] MIDWEST_OV_2_io_north_din; // @[OverlayRocc.scala 179:44]
  wire  MIDWEST_OV_2_io_north_din_v; // @[OverlayRocc.scala 179:44]
  wire  MIDWEST_OV_2_io_north_din_r; // @[OverlayRocc.scala 179:44]
  wire [31:0] MIDWEST_OV_2_io_east_din; // @[OverlayRocc.scala 179:44]
  wire  MIDWEST_OV_2_io_east_din_v; // @[OverlayRocc.scala 179:44]
  wire  MIDWEST_OV_2_io_east_din_r; // @[OverlayRocc.scala 179:44]
  wire [31:0] MIDWEST_OV_2_io_south_din; // @[OverlayRocc.scala 179:44]
  wire  MIDWEST_OV_2_io_south_din_v; // @[OverlayRocc.scala 179:44]
  wire  MIDWEST_OV_2_io_south_din_r; // @[OverlayRocc.scala 179:44]
  wire [31:0] MIDWEST_OV_2_io_west_din; // @[OverlayRocc.scala 179:44]
  wire  MIDWEST_OV_2_io_west_din_v; // @[OverlayRocc.scala 179:44]
  wire  MIDWEST_OV_2_io_west_din_r; // @[OverlayRocc.scala 179:44]
  wire [31:0] MIDWEST_OV_2_io_north_dout; // @[OverlayRocc.scala 179:44]
  wire  MIDWEST_OV_2_io_north_dout_v; // @[OverlayRocc.scala 179:44]
  wire  MIDWEST_OV_2_io_north_dout_r; // @[OverlayRocc.scala 179:44]
  wire [31:0] MIDWEST_OV_2_io_east_dout; // @[OverlayRocc.scala 179:44]
  wire  MIDWEST_OV_2_io_east_dout_v; // @[OverlayRocc.scala 179:44]
  wire  MIDWEST_OV_2_io_east_dout_r; // @[OverlayRocc.scala 179:44]
  wire [31:0] MIDWEST_OV_2_io_south_dout; // @[OverlayRocc.scala 179:44]
  wire  MIDWEST_OV_2_io_south_dout_v; // @[OverlayRocc.scala 179:44]
  wire  MIDWEST_OV_2_io_south_dout_r; // @[OverlayRocc.scala 179:44]
  wire [31:0] MIDWEST_OV_2_io_west_dout; // @[OverlayRocc.scala 179:44]
  wire  MIDWEST_OV_2_io_west_dout_v; // @[OverlayRocc.scala 179:44]
  wire  MIDWEST_OV_2_io_west_dout_r; // @[OverlayRocc.scala 179:44]
  wire [181:0] MIDWEST_OV_2_io_config_bits; // @[OverlayRocc.scala 179:44]
  wire  MIDWEST_OV_2_io_catch_config; // @[OverlayRocc.scala 179:44]
  wire  MIDWEST_OV_3_clock; // @[OverlayRocc.scala 179:44]
  wire  MIDWEST_OV_3_reset; // @[OverlayRocc.scala 179:44]
  wire [31:0] MIDWEST_OV_3_io_north_din; // @[OverlayRocc.scala 179:44]
  wire  MIDWEST_OV_3_io_north_din_v; // @[OverlayRocc.scala 179:44]
  wire  MIDWEST_OV_3_io_north_din_r; // @[OverlayRocc.scala 179:44]
  wire [31:0] MIDWEST_OV_3_io_east_din; // @[OverlayRocc.scala 179:44]
  wire  MIDWEST_OV_3_io_east_din_v; // @[OverlayRocc.scala 179:44]
  wire  MIDWEST_OV_3_io_east_din_r; // @[OverlayRocc.scala 179:44]
  wire [31:0] MIDWEST_OV_3_io_south_din; // @[OverlayRocc.scala 179:44]
  wire  MIDWEST_OV_3_io_south_din_v; // @[OverlayRocc.scala 179:44]
  wire  MIDWEST_OV_3_io_south_din_r; // @[OverlayRocc.scala 179:44]
  wire [31:0] MIDWEST_OV_3_io_west_din; // @[OverlayRocc.scala 179:44]
  wire  MIDWEST_OV_3_io_west_din_v; // @[OverlayRocc.scala 179:44]
  wire  MIDWEST_OV_3_io_west_din_r; // @[OverlayRocc.scala 179:44]
  wire [31:0] MIDWEST_OV_3_io_north_dout; // @[OverlayRocc.scala 179:44]
  wire  MIDWEST_OV_3_io_north_dout_v; // @[OverlayRocc.scala 179:44]
  wire  MIDWEST_OV_3_io_north_dout_r; // @[OverlayRocc.scala 179:44]
  wire [31:0] MIDWEST_OV_3_io_east_dout; // @[OverlayRocc.scala 179:44]
  wire  MIDWEST_OV_3_io_east_dout_v; // @[OverlayRocc.scala 179:44]
  wire  MIDWEST_OV_3_io_east_dout_r; // @[OverlayRocc.scala 179:44]
  wire [31:0] MIDWEST_OV_3_io_south_dout; // @[OverlayRocc.scala 179:44]
  wire  MIDWEST_OV_3_io_south_dout_v; // @[OverlayRocc.scala 179:44]
  wire  MIDWEST_OV_3_io_south_dout_r; // @[OverlayRocc.scala 179:44]
  wire [31:0] MIDWEST_OV_3_io_west_dout; // @[OverlayRocc.scala 179:44]
  wire  MIDWEST_OV_3_io_west_dout_v; // @[OverlayRocc.scala 179:44]
  wire  MIDWEST_OV_3_io_west_dout_r; // @[OverlayRocc.scala 179:44]
  wire [181:0] MIDWEST_OV_3_io_config_bits; // @[OverlayRocc.scala 179:44]
  wire  MIDWEST_OV_3_io_catch_config; // @[OverlayRocc.scala 179:44]
  wire  SOUTHWEST_OV_clock; // @[OverlayRocc.scala 228:46]
  wire  SOUTHWEST_OV_reset; // @[OverlayRocc.scala 228:46]
  wire [31:0] SOUTHWEST_OV_io_north_din; // @[OverlayRocc.scala 228:46]
  wire  SOUTHWEST_OV_io_north_din_v; // @[OverlayRocc.scala 228:46]
  wire  SOUTHWEST_OV_io_north_din_r; // @[OverlayRocc.scala 228:46]
  wire [31:0] SOUTHWEST_OV_io_east_din; // @[OverlayRocc.scala 228:46]
  wire  SOUTHWEST_OV_io_east_din_v; // @[OverlayRocc.scala 228:46]
  wire  SOUTHWEST_OV_io_east_din_r; // @[OverlayRocc.scala 228:46]
  wire [31:0] SOUTHWEST_OV_io_south_din; // @[OverlayRocc.scala 228:46]
  wire  SOUTHWEST_OV_io_south_din_v; // @[OverlayRocc.scala 228:46]
  wire  SOUTHWEST_OV_io_south_din_r; // @[OverlayRocc.scala 228:46]
  wire [31:0] SOUTHWEST_OV_io_west_din; // @[OverlayRocc.scala 228:46]
  wire  SOUTHWEST_OV_io_west_din_v; // @[OverlayRocc.scala 228:46]
  wire  SOUTHWEST_OV_io_west_din_r; // @[OverlayRocc.scala 228:46]
  wire [31:0] SOUTHWEST_OV_io_north_dout; // @[OverlayRocc.scala 228:46]
  wire  SOUTHWEST_OV_io_north_dout_v; // @[OverlayRocc.scala 228:46]
  wire  SOUTHWEST_OV_io_north_dout_r; // @[OverlayRocc.scala 228:46]
  wire [31:0] SOUTHWEST_OV_io_east_dout; // @[OverlayRocc.scala 228:46]
  wire  SOUTHWEST_OV_io_east_dout_v; // @[OverlayRocc.scala 228:46]
  wire  SOUTHWEST_OV_io_east_dout_r; // @[OverlayRocc.scala 228:46]
  wire [31:0] SOUTHWEST_OV_io_south_dout; // @[OverlayRocc.scala 228:46]
  wire  SOUTHWEST_OV_io_south_dout_v; // @[OverlayRocc.scala 228:46]
  wire  SOUTHWEST_OV_io_south_dout_r; // @[OverlayRocc.scala 228:46]
  wire [31:0] SOUTHWEST_OV_io_west_dout; // @[OverlayRocc.scala 228:46]
  wire  SOUTHWEST_OV_io_west_dout_v; // @[OverlayRocc.scala 228:46]
  wire  SOUTHWEST_OV_io_west_dout_r; // @[OverlayRocc.scala 228:46]
  wire [181:0] SOUTHWEST_OV_io_config_bits; // @[OverlayRocc.scala 228:46]
  wire  SOUTHWEST_OV_io_catch_config; // @[OverlayRocc.scala 228:46]
  wire  MIDDLENORTH_OV_clock; // @[OverlayRocc.scala 281:48]
  wire  MIDDLENORTH_OV_reset; // @[OverlayRocc.scala 281:48]
  wire [31:0] MIDDLENORTH_OV_io_north_din; // @[OverlayRocc.scala 281:48]
  wire  MIDDLENORTH_OV_io_north_din_v; // @[OverlayRocc.scala 281:48]
  wire  MIDDLENORTH_OV_io_north_din_r; // @[OverlayRocc.scala 281:48]
  wire [31:0] MIDDLENORTH_OV_io_east_din; // @[OverlayRocc.scala 281:48]
  wire  MIDDLENORTH_OV_io_east_din_v; // @[OverlayRocc.scala 281:48]
  wire  MIDDLENORTH_OV_io_east_din_r; // @[OverlayRocc.scala 281:48]
  wire [31:0] MIDDLENORTH_OV_io_south_din; // @[OverlayRocc.scala 281:48]
  wire  MIDDLENORTH_OV_io_south_din_v; // @[OverlayRocc.scala 281:48]
  wire  MIDDLENORTH_OV_io_south_din_r; // @[OverlayRocc.scala 281:48]
  wire [31:0] MIDDLENORTH_OV_io_west_din; // @[OverlayRocc.scala 281:48]
  wire  MIDDLENORTH_OV_io_west_din_v; // @[OverlayRocc.scala 281:48]
  wire  MIDDLENORTH_OV_io_west_din_r; // @[OverlayRocc.scala 281:48]
  wire [31:0] MIDDLENORTH_OV_io_north_dout; // @[OverlayRocc.scala 281:48]
  wire  MIDDLENORTH_OV_io_north_dout_v; // @[OverlayRocc.scala 281:48]
  wire  MIDDLENORTH_OV_io_north_dout_r; // @[OverlayRocc.scala 281:48]
  wire [31:0] MIDDLENORTH_OV_io_east_dout; // @[OverlayRocc.scala 281:48]
  wire  MIDDLENORTH_OV_io_east_dout_v; // @[OverlayRocc.scala 281:48]
  wire  MIDDLENORTH_OV_io_east_dout_r; // @[OverlayRocc.scala 281:48]
  wire [31:0] MIDDLENORTH_OV_io_south_dout; // @[OverlayRocc.scala 281:48]
  wire  MIDDLENORTH_OV_io_south_dout_v; // @[OverlayRocc.scala 281:48]
  wire  MIDDLENORTH_OV_io_south_dout_r; // @[OverlayRocc.scala 281:48]
  wire [31:0] MIDDLENORTH_OV_io_west_dout; // @[OverlayRocc.scala 281:48]
  wire  MIDDLENORTH_OV_io_west_dout_v; // @[OverlayRocc.scala 281:48]
  wire  MIDDLENORTH_OV_io_west_dout_r; // @[OverlayRocc.scala 281:48]
  wire [181:0] MIDDLENORTH_OV_io_config_bits; // @[OverlayRocc.scala 281:48]
  wire  MIDDLENORTH_OV_io_catch_config; // @[OverlayRocc.scala 281:48]
  wire  MIDDLEMIDDLE_OV_clock; // @[OverlayRocc.scala 330:49]
  wire  MIDDLEMIDDLE_OV_reset; // @[OverlayRocc.scala 330:49]
  wire [31:0] MIDDLEMIDDLE_OV_io_north_din; // @[OverlayRocc.scala 330:49]
  wire  MIDDLEMIDDLE_OV_io_north_din_v; // @[OverlayRocc.scala 330:49]
  wire  MIDDLEMIDDLE_OV_io_north_din_r; // @[OverlayRocc.scala 330:49]
  wire [31:0] MIDDLEMIDDLE_OV_io_east_din; // @[OverlayRocc.scala 330:49]
  wire  MIDDLEMIDDLE_OV_io_east_din_v; // @[OverlayRocc.scala 330:49]
  wire  MIDDLEMIDDLE_OV_io_east_din_r; // @[OverlayRocc.scala 330:49]
  wire [31:0] MIDDLEMIDDLE_OV_io_south_din; // @[OverlayRocc.scala 330:49]
  wire  MIDDLEMIDDLE_OV_io_south_din_v; // @[OverlayRocc.scala 330:49]
  wire  MIDDLEMIDDLE_OV_io_south_din_r; // @[OverlayRocc.scala 330:49]
  wire [31:0] MIDDLEMIDDLE_OV_io_west_din; // @[OverlayRocc.scala 330:49]
  wire  MIDDLEMIDDLE_OV_io_west_din_v; // @[OverlayRocc.scala 330:49]
  wire  MIDDLEMIDDLE_OV_io_west_din_r; // @[OverlayRocc.scala 330:49]
  wire [31:0] MIDDLEMIDDLE_OV_io_north_dout; // @[OverlayRocc.scala 330:49]
  wire  MIDDLEMIDDLE_OV_io_north_dout_v; // @[OverlayRocc.scala 330:49]
  wire  MIDDLEMIDDLE_OV_io_north_dout_r; // @[OverlayRocc.scala 330:49]
  wire [31:0] MIDDLEMIDDLE_OV_io_east_dout; // @[OverlayRocc.scala 330:49]
  wire  MIDDLEMIDDLE_OV_io_east_dout_v; // @[OverlayRocc.scala 330:49]
  wire  MIDDLEMIDDLE_OV_io_east_dout_r; // @[OverlayRocc.scala 330:49]
  wire [31:0] MIDDLEMIDDLE_OV_io_south_dout; // @[OverlayRocc.scala 330:49]
  wire  MIDDLEMIDDLE_OV_io_south_dout_v; // @[OverlayRocc.scala 330:49]
  wire  MIDDLEMIDDLE_OV_io_south_dout_r; // @[OverlayRocc.scala 330:49]
  wire [31:0] MIDDLEMIDDLE_OV_io_west_dout; // @[OverlayRocc.scala 330:49]
  wire  MIDDLEMIDDLE_OV_io_west_dout_v; // @[OverlayRocc.scala 330:49]
  wire  MIDDLEMIDDLE_OV_io_west_dout_r; // @[OverlayRocc.scala 330:49]
  wire [181:0] MIDDLEMIDDLE_OV_io_config_bits; // @[OverlayRocc.scala 330:49]
  wire  MIDDLEMIDDLE_OV_io_catch_config; // @[OverlayRocc.scala 330:49]
  wire  MIDDLEMIDDLE_OV_1_clock; // @[OverlayRocc.scala 330:49]
  wire  MIDDLEMIDDLE_OV_1_reset; // @[OverlayRocc.scala 330:49]
  wire [31:0] MIDDLEMIDDLE_OV_1_io_north_din; // @[OverlayRocc.scala 330:49]
  wire  MIDDLEMIDDLE_OV_1_io_north_din_v; // @[OverlayRocc.scala 330:49]
  wire  MIDDLEMIDDLE_OV_1_io_north_din_r; // @[OverlayRocc.scala 330:49]
  wire [31:0] MIDDLEMIDDLE_OV_1_io_east_din; // @[OverlayRocc.scala 330:49]
  wire  MIDDLEMIDDLE_OV_1_io_east_din_v; // @[OverlayRocc.scala 330:49]
  wire  MIDDLEMIDDLE_OV_1_io_east_din_r; // @[OverlayRocc.scala 330:49]
  wire [31:0] MIDDLEMIDDLE_OV_1_io_south_din; // @[OverlayRocc.scala 330:49]
  wire  MIDDLEMIDDLE_OV_1_io_south_din_v; // @[OverlayRocc.scala 330:49]
  wire  MIDDLEMIDDLE_OV_1_io_south_din_r; // @[OverlayRocc.scala 330:49]
  wire [31:0] MIDDLEMIDDLE_OV_1_io_west_din; // @[OverlayRocc.scala 330:49]
  wire  MIDDLEMIDDLE_OV_1_io_west_din_v; // @[OverlayRocc.scala 330:49]
  wire  MIDDLEMIDDLE_OV_1_io_west_din_r; // @[OverlayRocc.scala 330:49]
  wire [31:0] MIDDLEMIDDLE_OV_1_io_north_dout; // @[OverlayRocc.scala 330:49]
  wire  MIDDLEMIDDLE_OV_1_io_north_dout_v; // @[OverlayRocc.scala 330:49]
  wire  MIDDLEMIDDLE_OV_1_io_north_dout_r; // @[OverlayRocc.scala 330:49]
  wire [31:0] MIDDLEMIDDLE_OV_1_io_east_dout; // @[OverlayRocc.scala 330:49]
  wire  MIDDLEMIDDLE_OV_1_io_east_dout_v; // @[OverlayRocc.scala 330:49]
  wire  MIDDLEMIDDLE_OV_1_io_east_dout_r; // @[OverlayRocc.scala 330:49]
  wire [31:0] MIDDLEMIDDLE_OV_1_io_south_dout; // @[OverlayRocc.scala 330:49]
  wire  MIDDLEMIDDLE_OV_1_io_south_dout_v; // @[OverlayRocc.scala 330:49]
  wire  MIDDLEMIDDLE_OV_1_io_south_dout_r; // @[OverlayRocc.scala 330:49]
  wire [31:0] MIDDLEMIDDLE_OV_1_io_west_dout; // @[OverlayRocc.scala 330:49]
  wire  MIDDLEMIDDLE_OV_1_io_west_dout_v; // @[OverlayRocc.scala 330:49]
  wire  MIDDLEMIDDLE_OV_1_io_west_dout_r; // @[OverlayRocc.scala 330:49]
  wire [181:0] MIDDLEMIDDLE_OV_1_io_config_bits; // @[OverlayRocc.scala 330:49]
  wire  MIDDLEMIDDLE_OV_1_io_catch_config; // @[OverlayRocc.scala 330:49]
  wire  MIDDLEMIDDLE_OV_2_clock; // @[OverlayRocc.scala 330:49]
  wire  MIDDLEMIDDLE_OV_2_reset; // @[OverlayRocc.scala 330:49]
  wire [31:0] MIDDLEMIDDLE_OV_2_io_north_din; // @[OverlayRocc.scala 330:49]
  wire  MIDDLEMIDDLE_OV_2_io_north_din_v; // @[OverlayRocc.scala 330:49]
  wire  MIDDLEMIDDLE_OV_2_io_north_din_r; // @[OverlayRocc.scala 330:49]
  wire [31:0] MIDDLEMIDDLE_OV_2_io_east_din; // @[OverlayRocc.scala 330:49]
  wire  MIDDLEMIDDLE_OV_2_io_east_din_v; // @[OverlayRocc.scala 330:49]
  wire  MIDDLEMIDDLE_OV_2_io_east_din_r; // @[OverlayRocc.scala 330:49]
  wire [31:0] MIDDLEMIDDLE_OV_2_io_south_din; // @[OverlayRocc.scala 330:49]
  wire  MIDDLEMIDDLE_OV_2_io_south_din_v; // @[OverlayRocc.scala 330:49]
  wire  MIDDLEMIDDLE_OV_2_io_south_din_r; // @[OverlayRocc.scala 330:49]
  wire [31:0] MIDDLEMIDDLE_OV_2_io_west_din; // @[OverlayRocc.scala 330:49]
  wire  MIDDLEMIDDLE_OV_2_io_west_din_v; // @[OverlayRocc.scala 330:49]
  wire  MIDDLEMIDDLE_OV_2_io_west_din_r; // @[OverlayRocc.scala 330:49]
  wire [31:0] MIDDLEMIDDLE_OV_2_io_north_dout; // @[OverlayRocc.scala 330:49]
  wire  MIDDLEMIDDLE_OV_2_io_north_dout_v; // @[OverlayRocc.scala 330:49]
  wire  MIDDLEMIDDLE_OV_2_io_north_dout_r; // @[OverlayRocc.scala 330:49]
  wire [31:0] MIDDLEMIDDLE_OV_2_io_east_dout; // @[OverlayRocc.scala 330:49]
  wire  MIDDLEMIDDLE_OV_2_io_east_dout_v; // @[OverlayRocc.scala 330:49]
  wire  MIDDLEMIDDLE_OV_2_io_east_dout_r; // @[OverlayRocc.scala 330:49]
  wire [31:0] MIDDLEMIDDLE_OV_2_io_south_dout; // @[OverlayRocc.scala 330:49]
  wire  MIDDLEMIDDLE_OV_2_io_south_dout_v; // @[OverlayRocc.scala 330:49]
  wire  MIDDLEMIDDLE_OV_2_io_south_dout_r; // @[OverlayRocc.scala 330:49]
  wire [31:0] MIDDLEMIDDLE_OV_2_io_west_dout; // @[OverlayRocc.scala 330:49]
  wire  MIDDLEMIDDLE_OV_2_io_west_dout_v; // @[OverlayRocc.scala 330:49]
  wire  MIDDLEMIDDLE_OV_2_io_west_dout_r; // @[OverlayRocc.scala 330:49]
  wire [181:0] MIDDLEMIDDLE_OV_2_io_config_bits; // @[OverlayRocc.scala 330:49]
  wire  MIDDLEMIDDLE_OV_2_io_catch_config; // @[OverlayRocc.scala 330:49]
  wire  MIDDLEMIDDLE_OV_3_clock; // @[OverlayRocc.scala 330:49]
  wire  MIDDLEMIDDLE_OV_3_reset; // @[OverlayRocc.scala 330:49]
  wire [31:0] MIDDLEMIDDLE_OV_3_io_north_din; // @[OverlayRocc.scala 330:49]
  wire  MIDDLEMIDDLE_OV_3_io_north_din_v; // @[OverlayRocc.scala 330:49]
  wire  MIDDLEMIDDLE_OV_3_io_north_din_r; // @[OverlayRocc.scala 330:49]
  wire [31:0] MIDDLEMIDDLE_OV_3_io_east_din; // @[OverlayRocc.scala 330:49]
  wire  MIDDLEMIDDLE_OV_3_io_east_din_v; // @[OverlayRocc.scala 330:49]
  wire  MIDDLEMIDDLE_OV_3_io_east_din_r; // @[OverlayRocc.scala 330:49]
  wire [31:0] MIDDLEMIDDLE_OV_3_io_south_din; // @[OverlayRocc.scala 330:49]
  wire  MIDDLEMIDDLE_OV_3_io_south_din_v; // @[OverlayRocc.scala 330:49]
  wire  MIDDLEMIDDLE_OV_3_io_south_din_r; // @[OverlayRocc.scala 330:49]
  wire [31:0] MIDDLEMIDDLE_OV_3_io_west_din; // @[OverlayRocc.scala 330:49]
  wire  MIDDLEMIDDLE_OV_3_io_west_din_v; // @[OverlayRocc.scala 330:49]
  wire  MIDDLEMIDDLE_OV_3_io_west_din_r; // @[OverlayRocc.scala 330:49]
  wire [31:0] MIDDLEMIDDLE_OV_3_io_north_dout; // @[OverlayRocc.scala 330:49]
  wire  MIDDLEMIDDLE_OV_3_io_north_dout_v; // @[OverlayRocc.scala 330:49]
  wire  MIDDLEMIDDLE_OV_3_io_north_dout_r; // @[OverlayRocc.scala 330:49]
  wire [31:0] MIDDLEMIDDLE_OV_3_io_east_dout; // @[OverlayRocc.scala 330:49]
  wire  MIDDLEMIDDLE_OV_3_io_east_dout_v; // @[OverlayRocc.scala 330:49]
  wire  MIDDLEMIDDLE_OV_3_io_east_dout_r; // @[OverlayRocc.scala 330:49]
  wire [31:0] MIDDLEMIDDLE_OV_3_io_south_dout; // @[OverlayRocc.scala 330:49]
  wire  MIDDLEMIDDLE_OV_3_io_south_dout_v; // @[OverlayRocc.scala 330:49]
  wire  MIDDLEMIDDLE_OV_3_io_south_dout_r; // @[OverlayRocc.scala 330:49]
  wire [31:0] MIDDLEMIDDLE_OV_3_io_west_dout; // @[OverlayRocc.scala 330:49]
  wire  MIDDLEMIDDLE_OV_3_io_west_dout_v; // @[OverlayRocc.scala 330:49]
  wire  MIDDLEMIDDLE_OV_3_io_west_dout_r; // @[OverlayRocc.scala 330:49]
  wire [181:0] MIDDLEMIDDLE_OV_3_io_config_bits; // @[OverlayRocc.scala 330:49]
  wire  MIDDLEMIDDLE_OV_3_io_catch_config; // @[OverlayRocc.scala 330:49]
  wire  MIDDLESOUTH_OV_clock; // @[OverlayRocc.scala 379:48]
  wire  MIDDLESOUTH_OV_reset; // @[OverlayRocc.scala 379:48]
  wire [31:0] MIDDLESOUTH_OV_io_north_din; // @[OverlayRocc.scala 379:48]
  wire  MIDDLESOUTH_OV_io_north_din_v; // @[OverlayRocc.scala 379:48]
  wire  MIDDLESOUTH_OV_io_north_din_r; // @[OverlayRocc.scala 379:48]
  wire [31:0] MIDDLESOUTH_OV_io_east_din; // @[OverlayRocc.scala 379:48]
  wire  MIDDLESOUTH_OV_io_east_din_v; // @[OverlayRocc.scala 379:48]
  wire  MIDDLESOUTH_OV_io_east_din_r; // @[OverlayRocc.scala 379:48]
  wire [31:0] MIDDLESOUTH_OV_io_south_din; // @[OverlayRocc.scala 379:48]
  wire  MIDDLESOUTH_OV_io_south_din_v; // @[OverlayRocc.scala 379:48]
  wire  MIDDLESOUTH_OV_io_south_din_r; // @[OverlayRocc.scala 379:48]
  wire [31:0] MIDDLESOUTH_OV_io_west_din; // @[OverlayRocc.scala 379:48]
  wire  MIDDLESOUTH_OV_io_west_din_v; // @[OverlayRocc.scala 379:48]
  wire  MIDDLESOUTH_OV_io_west_din_r; // @[OverlayRocc.scala 379:48]
  wire [31:0] MIDDLESOUTH_OV_io_north_dout; // @[OverlayRocc.scala 379:48]
  wire  MIDDLESOUTH_OV_io_north_dout_v; // @[OverlayRocc.scala 379:48]
  wire  MIDDLESOUTH_OV_io_north_dout_r; // @[OverlayRocc.scala 379:48]
  wire [31:0] MIDDLESOUTH_OV_io_east_dout; // @[OverlayRocc.scala 379:48]
  wire  MIDDLESOUTH_OV_io_east_dout_v; // @[OverlayRocc.scala 379:48]
  wire  MIDDLESOUTH_OV_io_east_dout_r; // @[OverlayRocc.scala 379:48]
  wire [31:0] MIDDLESOUTH_OV_io_south_dout; // @[OverlayRocc.scala 379:48]
  wire  MIDDLESOUTH_OV_io_south_dout_v; // @[OverlayRocc.scala 379:48]
  wire  MIDDLESOUTH_OV_io_south_dout_r; // @[OverlayRocc.scala 379:48]
  wire [31:0] MIDDLESOUTH_OV_io_west_dout; // @[OverlayRocc.scala 379:48]
  wire  MIDDLESOUTH_OV_io_west_dout_v; // @[OverlayRocc.scala 379:48]
  wire  MIDDLESOUTH_OV_io_west_dout_r; // @[OverlayRocc.scala 379:48]
  wire [181:0] MIDDLESOUTH_OV_io_config_bits; // @[OverlayRocc.scala 379:48]
  wire  MIDDLESOUTH_OV_io_catch_config; // @[OverlayRocc.scala 379:48]
  wire  MIDDLENORTH_OV_1_clock; // @[OverlayRocc.scala 281:48]
  wire  MIDDLENORTH_OV_1_reset; // @[OverlayRocc.scala 281:48]
  wire [31:0] MIDDLENORTH_OV_1_io_north_din; // @[OverlayRocc.scala 281:48]
  wire  MIDDLENORTH_OV_1_io_north_din_v; // @[OverlayRocc.scala 281:48]
  wire  MIDDLENORTH_OV_1_io_north_din_r; // @[OverlayRocc.scala 281:48]
  wire [31:0] MIDDLENORTH_OV_1_io_east_din; // @[OverlayRocc.scala 281:48]
  wire  MIDDLENORTH_OV_1_io_east_din_v; // @[OverlayRocc.scala 281:48]
  wire  MIDDLENORTH_OV_1_io_east_din_r; // @[OverlayRocc.scala 281:48]
  wire [31:0] MIDDLENORTH_OV_1_io_south_din; // @[OverlayRocc.scala 281:48]
  wire  MIDDLENORTH_OV_1_io_south_din_v; // @[OverlayRocc.scala 281:48]
  wire  MIDDLENORTH_OV_1_io_south_din_r; // @[OverlayRocc.scala 281:48]
  wire [31:0] MIDDLENORTH_OV_1_io_west_din; // @[OverlayRocc.scala 281:48]
  wire  MIDDLENORTH_OV_1_io_west_din_v; // @[OverlayRocc.scala 281:48]
  wire  MIDDLENORTH_OV_1_io_west_din_r; // @[OverlayRocc.scala 281:48]
  wire [31:0] MIDDLENORTH_OV_1_io_north_dout; // @[OverlayRocc.scala 281:48]
  wire  MIDDLENORTH_OV_1_io_north_dout_v; // @[OverlayRocc.scala 281:48]
  wire  MIDDLENORTH_OV_1_io_north_dout_r; // @[OverlayRocc.scala 281:48]
  wire [31:0] MIDDLENORTH_OV_1_io_east_dout; // @[OverlayRocc.scala 281:48]
  wire  MIDDLENORTH_OV_1_io_east_dout_v; // @[OverlayRocc.scala 281:48]
  wire  MIDDLENORTH_OV_1_io_east_dout_r; // @[OverlayRocc.scala 281:48]
  wire [31:0] MIDDLENORTH_OV_1_io_south_dout; // @[OverlayRocc.scala 281:48]
  wire  MIDDLENORTH_OV_1_io_south_dout_v; // @[OverlayRocc.scala 281:48]
  wire  MIDDLENORTH_OV_1_io_south_dout_r; // @[OverlayRocc.scala 281:48]
  wire [31:0] MIDDLENORTH_OV_1_io_west_dout; // @[OverlayRocc.scala 281:48]
  wire  MIDDLENORTH_OV_1_io_west_dout_v; // @[OverlayRocc.scala 281:48]
  wire  MIDDLENORTH_OV_1_io_west_dout_r; // @[OverlayRocc.scala 281:48]
  wire [181:0] MIDDLENORTH_OV_1_io_config_bits; // @[OverlayRocc.scala 281:48]
  wire  MIDDLENORTH_OV_1_io_catch_config; // @[OverlayRocc.scala 281:48]
  wire  MIDDLEMIDDLE_OV_4_clock; // @[OverlayRocc.scala 330:49]
  wire  MIDDLEMIDDLE_OV_4_reset; // @[OverlayRocc.scala 330:49]
  wire [31:0] MIDDLEMIDDLE_OV_4_io_north_din; // @[OverlayRocc.scala 330:49]
  wire  MIDDLEMIDDLE_OV_4_io_north_din_v; // @[OverlayRocc.scala 330:49]
  wire  MIDDLEMIDDLE_OV_4_io_north_din_r; // @[OverlayRocc.scala 330:49]
  wire [31:0] MIDDLEMIDDLE_OV_4_io_east_din; // @[OverlayRocc.scala 330:49]
  wire  MIDDLEMIDDLE_OV_4_io_east_din_v; // @[OverlayRocc.scala 330:49]
  wire  MIDDLEMIDDLE_OV_4_io_east_din_r; // @[OverlayRocc.scala 330:49]
  wire [31:0] MIDDLEMIDDLE_OV_4_io_south_din; // @[OverlayRocc.scala 330:49]
  wire  MIDDLEMIDDLE_OV_4_io_south_din_v; // @[OverlayRocc.scala 330:49]
  wire  MIDDLEMIDDLE_OV_4_io_south_din_r; // @[OverlayRocc.scala 330:49]
  wire [31:0] MIDDLEMIDDLE_OV_4_io_west_din; // @[OverlayRocc.scala 330:49]
  wire  MIDDLEMIDDLE_OV_4_io_west_din_v; // @[OverlayRocc.scala 330:49]
  wire  MIDDLEMIDDLE_OV_4_io_west_din_r; // @[OverlayRocc.scala 330:49]
  wire [31:0] MIDDLEMIDDLE_OV_4_io_north_dout; // @[OverlayRocc.scala 330:49]
  wire  MIDDLEMIDDLE_OV_4_io_north_dout_v; // @[OverlayRocc.scala 330:49]
  wire  MIDDLEMIDDLE_OV_4_io_north_dout_r; // @[OverlayRocc.scala 330:49]
  wire [31:0] MIDDLEMIDDLE_OV_4_io_east_dout; // @[OverlayRocc.scala 330:49]
  wire  MIDDLEMIDDLE_OV_4_io_east_dout_v; // @[OverlayRocc.scala 330:49]
  wire  MIDDLEMIDDLE_OV_4_io_east_dout_r; // @[OverlayRocc.scala 330:49]
  wire [31:0] MIDDLEMIDDLE_OV_4_io_south_dout; // @[OverlayRocc.scala 330:49]
  wire  MIDDLEMIDDLE_OV_4_io_south_dout_v; // @[OverlayRocc.scala 330:49]
  wire  MIDDLEMIDDLE_OV_4_io_south_dout_r; // @[OverlayRocc.scala 330:49]
  wire [31:0] MIDDLEMIDDLE_OV_4_io_west_dout; // @[OverlayRocc.scala 330:49]
  wire  MIDDLEMIDDLE_OV_4_io_west_dout_v; // @[OverlayRocc.scala 330:49]
  wire  MIDDLEMIDDLE_OV_4_io_west_dout_r; // @[OverlayRocc.scala 330:49]
  wire [181:0] MIDDLEMIDDLE_OV_4_io_config_bits; // @[OverlayRocc.scala 330:49]
  wire  MIDDLEMIDDLE_OV_4_io_catch_config; // @[OverlayRocc.scala 330:49]
  wire  MIDDLEMIDDLE_OV_5_clock; // @[OverlayRocc.scala 330:49]
  wire  MIDDLEMIDDLE_OV_5_reset; // @[OverlayRocc.scala 330:49]
  wire [31:0] MIDDLEMIDDLE_OV_5_io_north_din; // @[OverlayRocc.scala 330:49]
  wire  MIDDLEMIDDLE_OV_5_io_north_din_v; // @[OverlayRocc.scala 330:49]
  wire  MIDDLEMIDDLE_OV_5_io_north_din_r; // @[OverlayRocc.scala 330:49]
  wire [31:0] MIDDLEMIDDLE_OV_5_io_east_din; // @[OverlayRocc.scala 330:49]
  wire  MIDDLEMIDDLE_OV_5_io_east_din_v; // @[OverlayRocc.scala 330:49]
  wire  MIDDLEMIDDLE_OV_5_io_east_din_r; // @[OverlayRocc.scala 330:49]
  wire [31:0] MIDDLEMIDDLE_OV_5_io_south_din; // @[OverlayRocc.scala 330:49]
  wire  MIDDLEMIDDLE_OV_5_io_south_din_v; // @[OverlayRocc.scala 330:49]
  wire  MIDDLEMIDDLE_OV_5_io_south_din_r; // @[OverlayRocc.scala 330:49]
  wire [31:0] MIDDLEMIDDLE_OV_5_io_west_din; // @[OverlayRocc.scala 330:49]
  wire  MIDDLEMIDDLE_OV_5_io_west_din_v; // @[OverlayRocc.scala 330:49]
  wire  MIDDLEMIDDLE_OV_5_io_west_din_r; // @[OverlayRocc.scala 330:49]
  wire [31:0] MIDDLEMIDDLE_OV_5_io_north_dout; // @[OverlayRocc.scala 330:49]
  wire  MIDDLEMIDDLE_OV_5_io_north_dout_v; // @[OverlayRocc.scala 330:49]
  wire  MIDDLEMIDDLE_OV_5_io_north_dout_r; // @[OverlayRocc.scala 330:49]
  wire [31:0] MIDDLEMIDDLE_OV_5_io_east_dout; // @[OverlayRocc.scala 330:49]
  wire  MIDDLEMIDDLE_OV_5_io_east_dout_v; // @[OverlayRocc.scala 330:49]
  wire  MIDDLEMIDDLE_OV_5_io_east_dout_r; // @[OverlayRocc.scala 330:49]
  wire [31:0] MIDDLEMIDDLE_OV_5_io_south_dout; // @[OverlayRocc.scala 330:49]
  wire  MIDDLEMIDDLE_OV_5_io_south_dout_v; // @[OverlayRocc.scala 330:49]
  wire  MIDDLEMIDDLE_OV_5_io_south_dout_r; // @[OverlayRocc.scala 330:49]
  wire [31:0] MIDDLEMIDDLE_OV_5_io_west_dout; // @[OverlayRocc.scala 330:49]
  wire  MIDDLEMIDDLE_OV_5_io_west_dout_v; // @[OverlayRocc.scala 330:49]
  wire  MIDDLEMIDDLE_OV_5_io_west_dout_r; // @[OverlayRocc.scala 330:49]
  wire [181:0] MIDDLEMIDDLE_OV_5_io_config_bits; // @[OverlayRocc.scala 330:49]
  wire  MIDDLEMIDDLE_OV_5_io_catch_config; // @[OverlayRocc.scala 330:49]
  wire  MIDDLEMIDDLE_OV_6_clock; // @[OverlayRocc.scala 330:49]
  wire  MIDDLEMIDDLE_OV_6_reset; // @[OverlayRocc.scala 330:49]
  wire [31:0] MIDDLEMIDDLE_OV_6_io_north_din; // @[OverlayRocc.scala 330:49]
  wire  MIDDLEMIDDLE_OV_6_io_north_din_v; // @[OverlayRocc.scala 330:49]
  wire  MIDDLEMIDDLE_OV_6_io_north_din_r; // @[OverlayRocc.scala 330:49]
  wire [31:0] MIDDLEMIDDLE_OV_6_io_east_din; // @[OverlayRocc.scala 330:49]
  wire  MIDDLEMIDDLE_OV_6_io_east_din_v; // @[OverlayRocc.scala 330:49]
  wire  MIDDLEMIDDLE_OV_6_io_east_din_r; // @[OverlayRocc.scala 330:49]
  wire [31:0] MIDDLEMIDDLE_OV_6_io_south_din; // @[OverlayRocc.scala 330:49]
  wire  MIDDLEMIDDLE_OV_6_io_south_din_v; // @[OverlayRocc.scala 330:49]
  wire  MIDDLEMIDDLE_OV_6_io_south_din_r; // @[OverlayRocc.scala 330:49]
  wire [31:0] MIDDLEMIDDLE_OV_6_io_west_din; // @[OverlayRocc.scala 330:49]
  wire  MIDDLEMIDDLE_OV_6_io_west_din_v; // @[OverlayRocc.scala 330:49]
  wire  MIDDLEMIDDLE_OV_6_io_west_din_r; // @[OverlayRocc.scala 330:49]
  wire [31:0] MIDDLEMIDDLE_OV_6_io_north_dout; // @[OverlayRocc.scala 330:49]
  wire  MIDDLEMIDDLE_OV_6_io_north_dout_v; // @[OverlayRocc.scala 330:49]
  wire  MIDDLEMIDDLE_OV_6_io_north_dout_r; // @[OverlayRocc.scala 330:49]
  wire [31:0] MIDDLEMIDDLE_OV_6_io_east_dout; // @[OverlayRocc.scala 330:49]
  wire  MIDDLEMIDDLE_OV_6_io_east_dout_v; // @[OverlayRocc.scala 330:49]
  wire  MIDDLEMIDDLE_OV_6_io_east_dout_r; // @[OverlayRocc.scala 330:49]
  wire [31:0] MIDDLEMIDDLE_OV_6_io_south_dout; // @[OverlayRocc.scala 330:49]
  wire  MIDDLEMIDDLE_OV_6_io_south_dout_v; // @[OverlayRocc.scala 330:49]
  wire  MIDDLEMIDDLE_OV_6_io_south_dout_r; // @[OverlayRocc.scala 330:49]
  wire [31:0] MIDDLEMIDDLE_OV_6_io_west_dout; // @[OverlayRocc.scala 330:49]
  wire  MIDDLEMIDDLE_OV_6_io_west_dout_v; // @[OverlayRocc.scala 330:49]
  wire  MIDDLEMIDDLE_OV_6_io_west_dout_r; // @[OverlayRocc.scala 330:49]
  wire [181:0] MIDDLEMIDDLE_OV_6_io_config_bits; // @[OverlayRocc.scala 330:49]
  wire  MIDDLEMIDDLE_OV_6_io_catch_config; // @[OverlayRocc.scala 330:49]
  wire  MIDDLEMIDDLE_OV_7_clock; // @[OverlayRocc.scala 330:49]
  wire  MIDDLEMIDDLE_OV_7_reset; // @[OverlayRocc.scala 330:49]
  wire [31:0] MIDDLEMIDDLE_OV_7_io_north_din; // @[OverlayRocc.scala 330:49]
  wire  MIDDLEMIDDLE_OV_7_io_north_din_v; // @[OverlayRocc.scala 330:49]
  wire  MIDDLEMIDDLE_OV_7_io_north_din_r; // @[OverlayRocc.scala 330:49]
  wire [31:0] MIDDLEMIDDLE_OV_7_io_east_din; // @[OverlayRocc.scala 330:49]
  wire  MIDDLEMIDDLE_OV_7_io_east_din_v; // @[OverlayRocc.scala 330:49]
  wire  MIDDLEMIDDLE_OV_7_io_east_din_r; // @[OverlayRocc.scala 330:49]
  wire [31:0] MIDDLEMIDDLE_OV_7_io_south_din; // @[OverlayRocc.scala 330:49]
  wire  MIDDLEMIDDLE_OV_7_io_south_din_v; // @[OverlayRocc.scala 330:49]
  wire  MIDDLEMIDDLE_OV_7_io_south_din_r; // @[OverlayRocc.scala 330:49]
  wire [31:0] MIDDLEMIDDLE_OV_7_io_west_din; // @[OverlayRocc.scala 330:49]
  wire  MIDDLEMIDDLE_OV_7_io_west_din_v; // @[OverlayRocc.scala 330:49]
  wire  MIDDLEMIDDLE_OV_7_io_west_din_r; // @[OverlayRocc.scala 330:49]
  wire [31:0] MIDDLEMIDDLE_OV_7_io_north_dout; // @[OverlayRocc.scala 330:49]
  wire  MIDDLEMIDDLE_OV_7_io_north_dout_v; // @[OverlayRocc.scala 330:49]
  wire  MIDDLEMIDDLE_OV_7_io_north_dout_r; // @[OverlayRocc.scala 330:49]
  wire [31:0] MIDDLEMIDDLE_OV_7_io_east_dout; // @[OverlayRocc.scala 330:49]
  wire  MIDDLEMIDDLE_OV_7_io_east_dout_v; // @[OverlayRocc.scala 330:49]
  wire  MIDDLEMIDDLE_OV_7_io_east_dout_r; // @[OverlayRocc.scala 330:49]
  wire [31:0] MIDDLEMIDDLE_OV_7_io_south_dout; // @[OverlayRocc.scala 330:49]
  wire  MIDDLEMIDDLE_OV_7_io_south_dout_v; // @[OverlayRocc.scala 330:49]
  wire  MIDDLEMIDDLE_OV_7_io_south_dout_r; // @[OverlayRocc.scala 330:49]
  wire [31:0] MIDDLEMIDDLE_OV_7_io_west_dout; // @[OverlayRocc.scala 330:49]
  wire  MIDDLEMIDDLE_OV_7_io_west_dout_v; // @[OverlayRocc.scala 330:49]
  wire  MIDDLEMIDDLE_OV_7_io_west_dout_r; // @[OverlayRocc.scala 330:49]
  wire [181:0] MIDDLEMIDDLE_OV_7_io_config_bits; // @[OverlayRocc.scala 330:49]
  wire  MIDDLEMIDDLE_OV_7_io_catch_config; // @[OverlayRocc.scala 330:49]
  wire  MIDDLESOUTH_OV_1_clock; // @[OverlayRocc.scala 379:48]
  wire  MIDDLESOUTH_OV_1_reset; // @[OverlayRocc.scala 379:48]
  wire [31:0] MIDDLESOUTH_OV_1_io_north_din; // @[OverlayRocc.scala 379:48]
  wire  MIDDLESOUTH_OV_1_io_north_din_v; // @[OverlayRocc.scala 379:48]
  wire  MIDDLESOUTH_OV_1_io_north_din_r; // @[OverlayRocc.scala 379:48]
  wire [31:0] MIDDLESOUTH_OV_1_io_east_din; // @[OverlayRocc.scala 379:48]
  wire  MIDDLESOUTH_OV_1_io_east_din_v; // @[OverlayRocc.scala 379:48]
  wire  MIDDLESOUTH_OV_1_io_east_din_r; // @[OverlayRocc.scala 379:48]
  wire [31:0] MIDDLESOUTH_OV_1_io_south_din; // @[OverlayRocc.scala 379:48]
  wire  MIDDLESOUTH_OV_1_io_south_din_v; // @[OverlayRocc.scala 379:48]
  wire  MIDDLESOUTH_OV_1_io_south_din_r; // @[OverlayRocc.scala 379:48]
  wire [31:0] MIDDLESOUTH_OV_1_io_west_din; // @[OverlayRocc.scala 379:48]
  wire  MIDDLESOUTH_OV_1_io_west_din_v; // @[OverlayRocc.scala 379:48]
  wire  MIDDLESOUTH_OV_1_io_west_din_r; // @[OverlayRocc.scala 379:48]
  wire [31:0] MIDDLESOUTH_OV_1_io_north_dout; // @[OverlayRocc.scala 379:48]
  wire  MIDDLESOUTH_OV_1_io_north_dout_v; // @[OverlayRocc.scala 379:48]
  wire  MIDDLESOUTH_OV_1_io_north_dout_r; // @[OverlayRocc.scala 379:48]
  wire [31:0] MIDDLESOUTH_OV_1_io_east_dout; // @[OverlayRocc.scala 379:48]
  wire  MIDDLESOUTH_OV_1_io_east_dout_v; // @[OverlayRocc.scala 379:48]
  wire  MIDDLESOUTH_OV_1_io_east_dout_r; // @[OverlayRocc.scala 379:48]
  wire [31:0] MIDDLESOUTH_OV_1_io_south_dout; // @[OverlayRocc.scala 379:48]
  wire  MIDDLESOUTH_OV_1_io_south_dout_v; // @[OverlayRocc.scala 379:48]
  wire  MIDDLESOUTH_OV_1_io_south_dout_r; // @[OverlayRocc.scala 379:48]
  wire [31:0] MIDDLESOUTH_OV_1_io_west_dout; // @[OverlayRocc.scala 379:48]
  wire  MIDDLESOUTH_OV_1_io_west_dout_v; // @[OverlayRocc.scala 379:48]
  wire  MIDDLESOUTH_OV_1_io_west_dout_r; // @[OverlayRocc.scala 379:48]
  wire [181:0] MIDDLESOUTH_OV_1_io_config_bits; // @[OverlayRocc.scala 379:48]
  wire  MIDDLESOUTH_OV_1_io_catch_config; // @[OverlayRocc.scala 379:48]
  wire  MIDDLENORTH_OV_2_clock; // @[OverlayRocc.scala 281:48]
  wire  MIDDLENORTH_OV_2_reset; // @[OverlayRocc.scala 281:48]
  wire [31:0] MIDDLENORTH_OV_2_io_north_din; // @[OverlayRocc.scala 281:48]
  wire  MIDDLENORTH_OV_2_io_north_din_v; // @[OverlayRocc.scala 281:48]
  wire  MIDDLENORTH_OV_2_io_north_din_r; // @[OverlayRocc.scala 281:48]
  wire [31:0] MIDDLENORTH_OV_2_io_east_din; // @[OverlayRocc.scala 281:48]
  wire  MIDDLENORTH_OV_2_io_east_din_v; // @[OverlayRocc.scala 281:48]
  wire  MIDDLENORTH_OV_2_io_east_din_r; // @[OverlayRocc.scala 281:48]
  wire [31:0] MIDDLENORTH_OV_2_io_south_din; // @[OverlayRocc.scala 281:48]
  wire  MIDDLENORTH_OV_2_io_south_din_v; // @[OverlayRocc.scala 281:48]
  wire  MIDDLENORTH_OV_2_io_south_din_r; // @[OverlayRocc.scala 281:48]
  wire [31:0] MIDDLENORTH_OV_2_io_west_din; // @[OverlayRocc.scala 281:48]
  wire  MIDDLENORTH_OV_2_io_west_din_v; // @[OverlayRocc.scala 281:48]
  wire  MIDDLENORTH_OV_2_io_west_din_r; // @[OverlayRocc.scala 281:48]
  wire [31:0] MIDDLENORTH_OV_2_io_north_dout; // @[OverlayRocc.scala 281:48]
  wire  MIDDLENORTH_OV_2_io_north_dout_v; // @[OverlayRocc.scala 281:48]
  wire  MIDDLENORTH_OV_2_io_north_dout_r; // @[OverlayRocc.scala 281:48]
  wire [31:0] MIDDLENORTH_OV_2_io_east_dout; // @[OverlayRocc.scala 281:48]
  wire  MIDDLENORTH_OV_2_io_east_dout_v; // @[OverlayRocc.scala 281:48]
  wire  MIDDLENORTH_OV_2_io_east_dout_r; // @[OverlayRocc.scala 281:48]
  wire [31:0] MIDDLENORTH_OV_2_io_south_dout; // @[OverlayRocc.scala 281:48]
  wire  MIDDLENORTH_OV_2_io_south_dout_v; // @[OverlayRocc.scala 281:48]
  wire  MIDDLENORTH_OV_2_io_south_dout_r; // @[OverlayRocc.scala 281:48]
  wire [31:0] MIDDLENORTH_OV_2_io_west_dout; // @[OverlayRocc.scala 281:48]
  wire  MIDDLENORTH_OV_2_io_west_dout_v; // @[OverlayRocc.scala 281:48]
  wire  MIDDLENORTH_OV_2_io_west_dout_r; // @[OverlayRocc.scala 281:48]
  wire [181:0] MIDDLENORTH_OV_2_io_config_bits; // @[OverlayRocc.scala 281:48]
  wire  MIDDLENORTH_OV_2_io_catch_config; // @[OverlayRocc.scala 281:48]
  wire  MIDDLEMIDDLE_OV_8_clock; // @[OverlayRocc.scala 330:49]
  wire  MIDDLEMIDDLE_OV_8_reset; // @[OverlayRocc.scala 330:49]
  wire [31:0] MIDDLEMIDDLE_OV_8_io_north_din; // @[OverlayRocc.scala 330:49]
  wire  MIDDLEMIDDLE_OV_8_io_north_din_v; // @[OverlayRocc.scala 330:49]
  wire  MIDDLEMIDDLE_OV_8_io_north_din_r; // @[OverlayRocc.scala 330:49]
  wire [31:0] MIDDLEMIDDLE_OV_8_io_east_din; // @[OverlayRocc.scala 330:49]
  wire  MIDDLEMIDDLE_OV_8_io_east_din_v; // @[OverlayRocc.scala 330:49]
  wire  MIDDLEMIDDLE_OV_8_io_east_din_r; // @[OverlayRocc.scala 330:49]
  wire [31:0] MIDDLEMIDDLE_OV_8_io_south_din; // @[OverlayRocc.scala 330:49]
  wire  MIDDLEMIDDLE_OV_8_io_south_din_v; // @[OverlayRocc.scala 330:49]
  wire  MIDDLEMIDDLE_OV_8_io_south_din_r; // @[OverlayRocc.scala 330:49]
  wire [31:0] MIDDLEMIDDLE_OV_8_io_west_din; // @[OverlayRocc.scala 330:49]
  wire  MIDDLEMIDDLE_OV_8_io_west_din_v; // @[OverlayRocc.scala 330:49]
  wire  MIDDLEMIDDLE_OV_8_io_west_din_r; // @[OverlayRocc.scala 330:49]
  wire [31:0] MIDDLEMIDDLE_OV_8_io_north_dout; // @[OverlayRocc.scala 330:49]
  wire  MIDDLEMIDDLE_OV_8_io_north_dout_v; // @[OverlayRocc.scala 330:49]
  wire  MIDDLEMIDDLE_OV_8_io_north_dout_r; // @[OverlayRocc.scala 330:49]
  wire [31:0] MIDDLEMIDDLE_OV_8_io_east_dout; // @[OverlayRocc.scala 330:49]
  wire  MIDDLEMIDDLE_OV_8_io_east_dout_v; // @[OverlayRocc.scala 330:49]
  wire  MIDDLEMIDDLE_OV_8_io_east_dout_r; // @[OverlayRocc.scala 330:49]
  wire [31:0] MIDDLEMIDDLE_OV_8_io_south_dout; // @[OverlayRocc.scala 330:49]
  wire  MIDDLEMIDDLE_OV_8_io_south_dout_v; // @[OverlayRocc.scala 330:49]
  wire  MIDDLEMIDDLE_OV_8_io_south_dout_r; // @[OverlayRocc.scala 330:49]
  wire [31:0] MIDDLEMIDDLE_OV_8_io_west_dout; // @[OverlayRocc.scala 330:49]
  wire  MIDDLEMIDDLE_OV_8_io_west_dout_v; // @[OverlayRocc.scala 330:49]
  wire  MIDDLEMIDDLE_OV_8_io_west_dout_r; // @[OverlayRocc.scala 330:49]
  wire [181:0] MIDDLEMIDDLE_OV_8_io_config_bits; // @[OverlayRocc.scala 330:49]
  wire  MIDDLEMIDDLE_OV_8_io_catch_config; // @[OverlayRocc.scala 330:49]
  wire  MIDDLEMIDDLE_OV_9_clock; // @[OverlayRocc.scala 330:49]
  wire  MIDDLEMIDDLE_OV_9_reset; // @[OverlayRocc.scala 330:49]
  wire [31:0] MIDDLEMIDDLE_OV_9_io_north_din; // @[OverlayRocc.scala 330:49]
  wire  MIDDLEMIDDLE_OV_9_io_north_din_v; // @[OverlayRocc.scala 330:49]
  wire  MIDDLEMIDDLE_OV_9_io_north_din_r; // @[OverlayRocc.scala 330:49]
  wire [31:0] MIDDLEMIDDLE_OV_9_io_east_din; // @[OverlayRocc.scala 330:49]
  wire  MIDDLEMIDDLE_OV_9_io_east_din_v; // @[OverlayRocc.scala 330:49]
  wire  MIDDLEMIDDLE_OV_9_io_east_din_r; // @[OverlayRocc.scala 330:49]
  wire [31:0] MIDDLEMIDDLE_OV_9_io_south_din; // @[OverlayRocc.scala 330:49]
  wire  MIDDLEMIDDLE_OV_9_io_south_din_v; // @[OverlayRocc.scala 330:49]
  wire  MIDDLEMIDDLE_OV_9_io_south_din_r; // @[OverlayRocc.scala 330:49]
  wire [31:0] MIDDLEMIDDLE_OV_9_io_west_din; // @[OverlayRocc.scala 330:49]
  wire  MIDDLEMIDDLE_OV_9_io_west_din_v; // @[OverlayRocc.scala 330:49]
  wire  MIDDLEMIDDLE_OV_9_io_west_din_r; // @[OverlayRocc.scala 330:49]
  wire [31:0] MIDDLEMIDDLE_OV_9_io_north_dout; // @[OverlayRocc.scala 330:49]
  wire  MIDDLEMIDDLE_OV_9_io_north_dout_v; // @[OverlayRocc.scala 330:49]
  wire  MIDDLEMIDDLE_OV_9_io_north_dout_r; // @[OverlayRocc.scala 330:49]
  wire [31:0] MIDDLEMIDDLE_OV_9_io_east_dout; // @[OverlayRocc.scala 330:49]
  wire  MIDDLEMIDDLE_OV_9_io_east_dout_v; // @[OverlayRocc.scala 330:49]
  wire  MIDDLEMIDDLE_OV_9_io_east_dout_r; // @[OverlayRocc.scala 330:49]
  wire [31:0] MIDDLEMIDDLE_OV_9_io_south_dout; // @[OverlayRocc.scala 330:49]
  wire  MIDDLEMIDDLE_OV_9_io_south_dout_v; // @[OverlayRocc.scala 330:49]
  wire  MIDDLEMIDDLE_OV_9_io_south_dout_r; // @[OverlayRocc.scala 330:49]
  wire [31:0] MIDDLEMIDDLE_OV_9_io_west_dout; // @[OverlayRocc.scala 330:49]
  wire  MIDDLEMIDDLE_OV_9_io_west_dout_v; // @[OverlayRocc.scala 330:49]
  wire  MIDDLEMIDDLE_OV_9_io_west_dout_r; // @[OverlayRocc.scala 330:49]
  wire [181:0] MIDDLEMIDDLE_OV_9_io_config_bits; // @[OverlayRocc.scala 330:49]
  wire  MIDDLEMIDDLE_OV_9_io_catch_config; // @[OverlayRocc.scala 330:49]
  wire  MIDDLEMIDDLE_OV_10_clock; // @[OverlayRocc.scala 330:49]
  wire  MIDDLEMIDDLE_OV_10_reset; // @[OverlayRocc.scala 330:49]
  wire [31:0] MIDDLEMIDDLE_OV_10_io_north_din; // @[OverlayRocc.scala 330:49]
  wire  MIDDLEMIDDLE_OV_10_io_north_din_v; // @[OverlayRocc.scala 330:49]
  wire  MIDDLEMIDDLE_OV_10_io_north_din_r; // @[OverlayRocc.scala 330:49]
  wire [31:0] MIDDLEMIDDLE_OV_10_io_east_din; // @[OverlayRocc.scala 330:49]
  wire  MIDDLEMIDDLE_OV_10_io_east_din_v; // @[OverlayRocc.scala 330:49]
  wire  MIDDLEMIDDLE_OV_10_io_east_din_r; // @[OverlayRocc.scala 330:49]
  wire [31:0] MIDDLEMIDDLE_OV_10_io_south_din; // @[OverlayRocc.scala 330:49]
  wire  MIDDLEMIDDLE_OV_10_io_south_din_v; // @[OverlayRocc.scala 330:49]
  wire  MIDDLEMIDDLE_OV_10_io_south_din_r; // @[OverlayRocc.scala 330:49]
  wire [31:0] MIDDLEMIDDLE_OV_10_io_west_din; // @[OverlayRocc.scala 330:49]
  wire  MIDDLEMIDDLE_OV_10_io_west_din_v; // @[OverlayRocc.scala 330:49]
  wire  MIDDLEMIDDLE_OV_10_io_west_din_r; // @[OverlayRocc.scala 330:49]
  wire [31:0] MIDDLEMIDDLE_OV_10_io_north_dout; // @[OverlayRocc.scala 330:49]
  wire  MIDDLEMIDDLE_OV_10_io_north_dout_v; // @[OverlayRocc.scala 330:49]
  wire  MIDDLEMIDDLE_OV_10_io_north_dout_r; // @[OverlayRocc.scala 330:49]
  wire [31:0] MIDDLEMIDDLE_OV_10_io_east_dout; // @[OverlayRocc.scala 330:49]
  wire  MIDDLEMIDDLE_OV_10_io_east_dout_v; // @[OverlayRocc.scala 330:49]
  wire  MIDDLEMIDDLE_OV_10_io_east_dout_r; // @[OverlayRocc.scala 330:49]
  wire [31:0] MIDDLEMIDDLE_OV_10_io_south_dout; // @[OverlayRocc.scala 330:49]
  wire  MIDDLEMIDDLE_OV_10_io_south_dout_v; // @[OverlayRocc.scala 330:49]
  wire  MIDDLEMIDDLE_OV_10_io_south_dout_r; // @[OverlayRocc.scala 330:49]
  wire [31:0] MIDDLEMIDDLE_OV_10_io_west_dout; // @[OverlayRocc.scala 330:49]
  wire  MIDDLEMIDDLE_OV_10_io_west_dout_v; // @[OverlayRocc.scala 330:49]
  wire  MIDDLEMIDDLE_OV_10_io_west_dout_r; // @[OverlayRocc.scala 330:49]
  wire [181:0] MIDDLEMIDDLE_OV_10_io_config_bits; // @[OverlayRocc.scala 330:49]
  wire  MIDDLEMIDDLE_OV_10_io_catch_config; // @[OverlayRocc.scala 330:49]
  wire  MIDDLEMIDDLE_OV_11_clock; // @[OverlayRocc.scala 330:49]
  wire  MIDDLEMIDDLE_OV_11_reset; // @[OverlayRocc.scala 330:49]
  wire [31:0] MIDDLEMIDDLE_OV_11_io_north_din; // @[OverlayRocc.scala 330:49]
  wire  MIDDLEMIDDLE_OV_11_io_north_din_v; // @[OverlayRocc.scala 330:49]
  wire  MIDDLEMIDDLE_OV_11_io_north_din_r; // @[OverlayRocc.scala 330:49]
  wire [31:0] MIDDLEMIDDLE_OV_11_io_east_din; // @[OverlayRocc.scala 330:49]
  wire  MIDDLEMIDDLE_OV_11_io_east_din_v; // @[OverlayRocc.scala 330:49]
  wire  MIDDLEMIDDLE_OV_11_io_east_din_r; // @[OverlayRocc.scala 330:49]
  wire [31:0] MIDDLEMIDDLE_OV_11_io_south_din; // @[OverlayRocc.scala 330:49]
  wire  MIDDLEMIDDLE_OV_11_io_south_din_v; // @[OverlayRocc.scala 330:49]
  wire  MIDDLEMIDDLE_OV_11_io_south_din_r; // @[OverlayRocc.scala 330:49]
  wire [31:0] MIDDLEMIDDLE_OV_11_io_west_din; // @[OverlayRocc.scala 330:49]
  wire  MIDDLEMIDDLE_OV_11_io_west_din_v; // @[OverlayRocc.scala 330:49]
  wire  MIDDLEMIDDLE_OV_11_io_west_din_r; // @[OverlayRocc.scala 330:49]
  wire [31:0] MIDDLEMIDDLE_OV_11_io_north_dout; // @[OverlayRocc.scala 330:49]
  wire  MIDDLEMIDDLE_OV_11_io_north_dout_v; // @[OverlayRocc.scala 330:49]
  wire  MIDDLEMIDDLE_OV_11_io_north_dout_r; // @[OverlayRocc.scala 330:49]
  wire [31:0] MIDDLEMIDDLE_OV_11_io_east_dout; // @[OverlayRocc.scala 330:49]
  wire  MIDDLEMIDDLE_OV_11_io_east_dout_v; // @[OverlayRocc.scala 330:49]
  wire  MIDDLEMIDDLE_OV_11_io_east_dout_r; // @[OverlayRocc.scala 330:49]
  wire [31:0] MIDDLEMIDDLE_OV_11_io_south_dout; // @[OverlayRocc.scala 330:49]
  wire  MIDDLEMIDDLE_OV_11_io_south_dout_v; // @[OverlayRocc.scala 330:49]
  wire  MIDDLEMIDDLE_OV_11_io_south_dout_r; // @[OverlayRocc.scala 330:49]
  wire [31:0] MIDDLEMIDDLE_OV_11_io_west_dout; // @[OverlayRocc.scala 330:49]
  wire  MIDDLEMIDDLE_OV_11_io_west_dout_v; // @[OverlayRocc.scala 330:49]
  wire  MIDDLEMIDDLE_OV_11_io_west_dout_r; // @[OverlayRocc.scala 330:49]
  wire [181:0] MIDDLEMIDDLE_OV_11_io_config_bits; // @[OverlayRocc.scala 330:49]
  wire  MIDDLEMIDDLE_OV_11_io_catch_config; // @[OverlayRocc.scala 330:49]
  wire  MIDDLESOUTH_OV_2_clock; // @[OverlayRocc.scala 379:48]
  wire  MIDDLESOUTH_OV_2_reset; // @[OverlayRocc.scala 379:48]
  wire [31:0] MIDDLESOUTH_OV_2_io_north_din; // @[OverlayRocc.scala 379:48]
  wire  MIDDLESOUTH_OV_2_io_north_din_v; // @[OverlayRocc.scala 379:48]
  wire  MIDDLESOUTH_OV_2_io_north_din_r; // @[OverlayRocc.scala 379:48]
  wire [31:0] MIDDLESOUTH_OV_2_io_east_din; // @[OverlayRocc.scala 379:48]
  wire  MIDDLESOUTH_OV_2_io_east_din_v; // @[OverlayRocc.scala 379:48]
  wire  MIDDLESOUTH_OV_2_io_east_din_r; // @[OverlayRocc.scala 379:48]
  wire [31:0] MIDDLESOUTH_OV_2_io_south_din; // @[OverlayRocc.scala 379:48]
  wire  MIDDLESOUTH_OV_2_io_south_din_v; // @[OverlayRocc.scala 379:48]
  wire  MIDDLESOUTH_OV_2_io_south_din_r; // @[OverlayRocc.scala 379:48]
  wire [31:0] MIDDLESOUTH_OV_2_io_west_din; // @[OverlayRocc.scala 379:48]
  wire  MIDDLESOUTH_OV_2_io_west_din_v; // @[OverlayRocc.scala 379:48]
  wire  MIDDLESOUTH_OV_2_io_west_din_r; // @[OverlayRocc.scala 379:48]
  wire [31:0] MIDDLESOUTH_OV_2_io_north_dout; // @[OverlayRocc.scala 379:48]
  wire  MIDDLESOUTH_OV_2_io_north_dout_v; // @[OverlayRocc.scala 379:48]
  wire  MIDDLESOUTH_OV_2_io_north_dout_r; // @[OverlayRocc.scala 379:48]
  wire [31:0] MIDDLESOUTH_OV_2_io_east_dout; // @[OverlayRocc.scala 379:48]
  wire  MIDDLESOUTH_OV_2_io_east_dout_v; // @[OverlayRocc.scala 379:48]
  wire  MIDDLESOUTH_OV_2_io_east_dout_r; // @[OverlayRocc.scala 379:48]
  wire [31:0] MIDDLESOUTH_OV_2_io_south_dout; // @[OverlayRocc.scala 379:48]
  wire  MIDDLESOUTH_OV_2_io_south_dout_v; // @[OverlayRocc.scala 379:48]
  wire  MIDDLESOUTH_OV_2_io_south_dout_r; // @[OverlayRocc.scala 379:48]
  wire [31:0] MIDDLESOUTH_OV_2_io_west_dout; // @[OverlayRocc.scala 379:48]
  wire  MIDDLESOUTH_OV_2_io_west_dout_v; // @[OverlayRocc.scala 379:48]
  wire  MIDDLESOUTH_OV_2_io_west_dout_r; // @[OverlayRocc.scala 379:48]
  wire [181:0] MIDDLESOUTH_OV_2_io_config_bits; // @[OverlayRocc.scala 379:48]
  wire  MIDDLESOUTH_OV_2_io_catch_config; // @[OverlayRocc.scala 379:48]
  wire  MIDDLENORTH_OV_3_clock; // @[OverlayRocc.scala 281:48]
  wire  MIDDLENORTH_OV_3_reset; // @[OverlayRocc.scala 281:48]
  wire [31:0] MIDDLENORTH_OV_3_io_north_din; // @[OverlayRocc.scala 281:48]
  wire  MIDDLENORTH_OV_3_io_north_din_v; // @[OverlayRocc.scala 281:48]
  wire  MIDDLENORTH_OV_3_io_north_din_r; // @[OverlayRocc.scala 281:48]
  wire [31:0] MIDDLENORTH_OV_3_io_east_din; // @[OverlayRocc.scala 281:48]
  wire  MIDDLENORTH_OV_3_io_east_din_v; // @[OverlayRocc.scala 281:48]
  wire  MIDDLENORTH_OV_3_io_east_din_r; // @[OverlayRocc.scala 281:48]
  wire [31:0] MIDDLENORTH_OV_3_io_south_din; // @[OverlayRocc.scala 281:48]
  wire  MIDDLENORTH_OV_3_io_south_din_v; // @[OverlayRocc.scala 281:48]
  wire  MIDDLENORTH_OV_3_io_south_din_r; // @[OverlayRocc.scala 281:48]
  wire [31:0] MIDDLENORTH_OV_3_io_west_din; // @[OverlayRocc.scala 281:48]
  wire  MIDDLENORTH_OV_3_io_west_din_v; // @[OverlayRocc.scala 281:48]
  wire  MIDDLENORTH_OV_3_io_west_din_r; // @[OverlayRocc.scala 281:48]
  wire [31:0] MIDDLENORTH_OV_3_io_north_dout; // @[OverlayRocc.scala 281:48]
  wire  MIDDLENORTH_OV_3_io_north_dout_v; // @[OverlayRocc.scala 281:48]
  wire  MIDDLENORTH_OV_3_io_north_dout_r; // @[OverlayRocc.scala 281:48]
  wire [31:0] MIDDLENORTH_OV_3_io_east_dout; // @[OverlayRocc.scala 281:48]
  wire  MIDDLENORTH_OV_3_io_east_dout_v; // @[OverlayRocc.scala 281:48]
  wire  MIDDLENORTH_OV_3_io_east_dout_r; // @[OverlayRocc.scala 281:48]
  wire [31:0] MIDDLENORTH_OV_3_io_south_dout; // @[OverlayRocc.scala 281:48]
  wire  MIDDLENORTH_OV_3_io_south_dout_v; // @[OverlayRocc.scala 281:48]
  wire  MIDDLENORTH_OV_3_io_south_dout_r; // @[OverlayRocc.scala 281:48]
  wire [31:0] MIDDLENORTH_OV_3_io_west_dout; // @[OverlayRocc.scala 281:48]
  wire  MIDDLENORTH_OV_3_io_west_dout_v; // @[OverlayRocc.scala 281:48]
  wire  MIDDLENORTH_OV_3_io_west_dout_r; // @[OverlayRocc.scala 281:48]
  wire [181:0] MIDDLENORTH_OV_3_io_config_bits; // @[OverlayRocc.scala 281:48]
  wire  MIDDLENORTH_OV_3_io_catch_config; // @[OverlayRocc.scala 281:48]
  wire  MIDDLEMIDDLE_OV_12_clock; // @[OverlayRocc.scala 330:49]
  wire  MIDDLEMIDDLE_OV_12_reset; // @[OverlayRocc.scala 330:49]
  wire [31:0] MIDDLEMIDDLE_OV_12_io_north_din; // @[OverlayRocc.scala 330:49]
  wire  MIDDLEMIDDLE_OV_12_io_north_din_v; // @[OverlayRocc.scala 330:49]
  wire  MIDDLEMIDDLE_OV_12_io_north_din_r; // @[OverlayRocc.scala 330:49]
  wire [31:0] MIDDLEMIDDLE_OV_12_io_east_din; // @[OverlayRocc.scala 330:49]
  wire  MIDDLEMIDDLE_OV_12_io_east_din_v; // @[OverlayRocc.scala 330:49]
  wire  MIDDLEMIDDLE_OV_12_io_east_din_r; // @[OverlayRocc.scala 330:49]
  wire [31:0] MIDDLEMIDDLE_OV_12_io_south_din; // @[OverlayRocc.scala 330:49]
  wire  MIDDLEMIDDLE_OV_12_io_south_din_v; // @[OverlayRocc.scala 330:49]
  wire  MIDDLEMIDDLE_OV_12_io_south_din_r; // @[OverlayRocc.scala 330:49]
  wire [31:0] MIDDLEMIDDLE_OV_12_io_west_din; // @[OverlayRocc.scala 330:49]
  wire  MIDDLEMIDDLE_OV_12_io_west_din_v; // @[OverlayRocc.scala 330:49]
  wire  MIDDLEMIDDLE_OV_12_io_west_din_r; // @[OverlayRocc.scala 330:49]
  wire [31:0] MIDDLEMIDDLE_OV_12_io_north_dout; // @[OverlayRocc.scala 330:49]
  wire  MIDDLEMIDDLE_OV_12_io_north_dout_v; // @[OverlayRocc.scala 330:49]
  wire  MIDDLEMIDDLE_OV_12_io_north_dout_r; // @[OverlayRocc.scala 330:49]
  wire [31:0] MIDDLEMIDDLE_OV_12_io_east_dout; // @[OverlayRocc.scala 330:49]
  wire  MIDDLEMIDDLE_OV_12_io_east_dout_v; // @[OverlayRocc.scala 330:49]
  wire  MIDDLEMIDDLE_OV_12_io_east_dout_r; // @[OverlayRocc.scala 330:49]
  wire [31:0] MIDDLEMIDDLE_OV_12_io_south_dout; // @[OverlayRocc.scala 330:49]
  wire  MIDDLEMIDDLE_OV_12_io_south_dout_v; // @[OverlayRocc.scala 330:49]
  wire  MIDDLEMIDDLE_OV_12_io_south_dout_r; // @[OverlayRocc.scala 330:49]
  wire [31:0] MIDDLEMIDDLE_OV_12_io_west_dout; // @[OverlayRocc.scala 330:49]
  wire  MIDDLEMIDDLE_OV_12_io_west_dout_v; // @[OverlayRocc.scala 330:49]
  wire  MIDDLEMIDDLE_OV_12_io_west_dout_r; // @[OverlayRocc.scala 330:49]
  wire [181:0] MIDDLEMIDDLE_OV_12_io_config_bits; // @[OverlayRocc.scala 330:49]
  wire  MIDDLEMIDDLE_OV_12_io_catch_config; // @[OverlayRocc.scala 330:49]
  wire  MIDDLEMIDDLE_OV_13_clock; // @[OverlayRocc.scala 330:49]
  wire  MIDDLEMIDDLE_OV_13_reset; // @[OverlayRocc.scala 330:49]
  wire [31:0] MIDDLEMIDDLE_OV_13_io_north_din; // @[OverlayRocc.scala 330:49]
  wire  MIDDLEMIDDLE_OV_13_io_north_din_v; // @[OverlayRocc.scala 330:49]
  wire  MIDDLEMIDDLE_OV_13_io_north_din_r; // @[OverlayRocc.scala 330:49]
  wire [31:0] MIDDLEMIDDLE_OV_13_io_east_din; // @[OverlayRocc.scala 330:49]
  wire  MIDDLEMIDDLE_OV_13_io_east_din_v; // @[OverlayRocc.scala 330:49]
  wire  MIDDLEMIDDLE_OV_13_io_east_din_r; // @[OverlayRocc.scala 330:49]
  wire [31:0] MIDDLEMIDDLE_OV_13_io_south_din; // @[OverlayRocc.scala 330:49]
  wire  MIDDLEMIDDLE_OV_13_io_south_din_v; // @[OverlayRocc.scala 330:49]
  wire  MIDDLEMIDDLE_OV_13_io_south_din_r; // @[OverlayRocc.scala 330:49]
  wire [31:0] MIDDLEMIDDLE_OV_13_io_west_din; // @[OverlayRocc.scala 330:49]
  wire  MIDDLEMIDDLE_OV_13_io_west_din_v; // @[OverlayRocc.scala 330:49]
  wire  MIDDLEMIDDLE_OV_13_io_west_din_r; // @[OverlayRocc.scala 330:49]
  wire [31:0] MIDDLEMIDDLE_OV_13_io_north_dout; // @[OverlayRocc.scala 330:49]
  wire  MIDDLEMIDDLE_OV_13_io_north_dout_v; // @[OverlayRocc.scala 330:49]
  wire  MIDDLEMIDDLE_OV_13_io_north_dout_r; // @[OverlayRocc.scala 330:49]
  wire [31:0] MIDDLEMIDDLE_OV_13_io_east_dout; // @[OverlayRocc.scala 330:49]
  wire  MIDDLEMIDDLE_OV_13_io_east_dout_v; // @[OverlayRocc.scala 330:49]
  wire  MIDDLEMIDDLE_OV_13_io_east_dout_r; // @[OverlayRocc.scala 330:49]
  wire [31:0] MIDDLEMIDDLE_OV_13_io_south_dout; // @[OverlayRocc.scala 330:49]
  wire  MIDDLEMIDDLE_OV_13_io_south_dout_v; // @[OverlayRocc.scala 330:49]
  wire  MIDDLEMIDDLE_OV_13_io_south_dout_r; // @[OverlayRocc.scala 330:49]
  wire [31:0] MIDDLEMIDDLE_OV_13_io_west_dout; // @[OverlayRocc.scala 330:49]
  wire  MIDDLEMIDDLE_OV_13_io_west_dout_v; // @[OverlayRocc.scala 330:49]
  wire  MIDDLEMIDDLE_OV_13_io_west_dout_r; // @[OverlayRocc.scala 330:49]
  wire [181:0] MIDDLEMIDDLE_OV_13_io_config_bits; // @[OverlayRocc.scala 330:49]
  wire  MIDDLEMIDDLE_OV_13_io_catch_config; // @[OverlayRocc.scala 330:49]
  wire  MIDDLEMIDDLE_OV_14_clock; // @[OverlayRocc.scala 330:49]
  wire  MIDDLEMIDDLE_OV_14_reset; // @[OverlayRocc.scala 330:49]
  wire [31:0] MIDDLEMIDDLE_OV_14_io_north_din; // @[OverlayRocc.scala 330:49]
  wire  MIDDLEMIDDLE_OV_14_io_north_din_v; // @[OverlayRocc.scala 330:49]
  wire  MIDDLEMIDDLE_OV_14_io_north_din_r; // @[OverlayRocc.scala 330:49]
  wire [31:0] MIDDLEMIDDLE_OV_14_io_east_din; // @[OverlayRocc.scala 330:49]
  wire  MIDDLEMIDDLE_OV_14_io_east_din_v; // @[OverlayRocc.scala 330:49]
  wire  MIDDLEMIDDLE_OV_14_io_east_din_r; // @[OverlayRocc.scala 330:49]
  wire [31:0] MIDDLEMIDDLE_OV_14_io_south_din; // @[OverlayRocc.scala 330:49]
  wire  MIDDLEMIDDLE_OV_14_io_south_din_v; // @[OverlayRocc.scala 330:49]
  wire  MIDDLEMIDDLE_OV_14_io_south_din_r; // @[OverlayRocc.scala 330:49]
  wire [31:0] MIDDLEMIDDLE_OV_14_io_west_din; // @[OverlayRocc.scala 330:49]
  wire  MIDDLEMIDDLE_OV_14_io_west_din_v; // @[OverlayRocc.scala 330:49]
  wire  MIDDLEMIDDLE_OV_14_io_west_din_r; // @[OverlayRocc.scala 330:49]
  wire [31:0] MIDDLEMIDDLE_OV_14_io_north_dout; // @[OverlayRocc.scala 330:49]
  wire  MIDDLEMIDDLE_OV_14_io_north_dout_v; // @[OverlayRocc.scala 330:49]
  wire  MIDDLEMIDDLE_OV_14_io_north_dout_r; // @[OverlayRocc.scala 330:49]
  wire [31:0] MIDDLEMIDDLE_OV_14_io_east_dout; // @[OverlayRocc.scala 330:49]
  wire  MIDDLEMIDDLE_OV_14_io_east_dout_v; // @[OverlayRocc.scala 330:49]
  wire  MIDDLEMIDDLE_OV_14_io_east_dout_r; // @[OverlayRocc.scala 330:49]
  wire [31:0] MIDDLEMIDDLE_OV_14_io_south_dout; // @[OverlayRocc.scala 330:49]
  wire  MIDDLEMIDDLE_OV_14_io_south_dout_v; // @[OverlayRocc.scala 330:49]
  wire  MIDDLEMIDDLE_OV_14_io_south_dout_r; // @[OverlayRocc.scala 330:49]
  wire [31:0] MIDDLEMIDDLE_OV_14_io_west_dout; // @[OverlayRocc.scala 330:49]
  wire  MIDDLEMIDDLE_OV_14_io_west_dout_v; // @[OverlayRocc.scala 330:49]
  wire  MIDDLEMIDDLE_OV_14_io_west_dout_r; // @[OverlayRocc.scala 330:49]
  wire [181:0] MIDDLEMIDDLE_OV_14_io_config_bits; // @[OverlayRocc.scala 330:49]
  wire  MIDDLEMIDDLE_OV_14_io_catch_config; // @[OverlayRocc.scala 330:49]
  wire  MIDDLEMIDDLE_OV_15_clock; // @[OverlayRocc.scala 330:49]
  wire  MIDDLEMIDDLE_OV_15_reset; // @[OverlayRocc.scala 330:49]
  wire [31:0] MIDDLEMIDDLE_OV_15_io_north_din; // @[OverlayRocc.scala 330:49]
  wire  MIDDLEMIDDLE_OV_15_io_north_din_v; // @[OverlayRocc.scala 330:49]
  wire  MIDDLEMIDDLE_OV_15_io_north_din_r; // @[OverlayRocc.scala 330:49]
  wire [31:0] MIDDLEMIDDLE_OV_15_io_east_din; // @[OverlayRocc.scala 330:49]
  wire  MIDDLEMIDDLE_OV_15_io_east_din_v; // @[OverlayRocc.scala 330:49]
  wire  MIDDLEMIDDLE_OV_15_io_east_din_r; // @[OverlayRocc.scala 330:49]
  wire [31:0] MIDDLEMIDDLE_OV_15_io_south_din; // @[OverlayRocc.scala 330:49]
  wire  MIDDLEMIDDLE_OV_15_io_south_din_v; // @[OverlayRocc.scala 330:49]
  wire  MIDDLEMIDDLE_OV_15_io_south_din_r; // @[OverlayRocc.scala 330:49]
  wire [31:0] MIDDLEMIDDLE_OV_15_io_west_din; // @[OverlayRocc.scala 330:49]
  wire  MIDDLEMIDDLE_OV_15_io_west_din_v; // @[OverlayRocc.scala 330:49]
  wire  MIDDLEMIDDLE_OV_15_io_west_din_r; // @[OverlayRocc.scala 330:49]
  wire [31:0] MIDDLEMIDDLE_OV_15_io_north_dout; // @[OverlayRocc.scala 330:49]
  wire  MIDDLEMIDDLE_OV_15_io_north_dout_v; // @[OverlayRocc.scala 330:49]
  wire  MIDDLEMIDDLE_OV_15_io_north_dout_r; // @[OverlayRocc.scala 330:49]
  wire [31:0] MIDDLEMIDDLE_OV_15_io_east_dout; // @[OverlayRocc.scala 330:49]
  wire  MIDDLEMIDDLE_OV_15_io_east_dout_v; // @[OverlayRocc.scala 330:49]
  wire  MIDDLEMIDDLE_OV_15_io_east_dout_r; // @[OverlayRocc.scala 330:49]
  wire [31:0] MIDDLEMIDDLE_OV_15_io_south_dout; // @[OverlayRocc.scala 330:49]
  wire  MIDDLEMIDDLE_OV_15_io_south_dout_v; // @[OverlayRocc.scala 330:49]
  wire  MIDDLEMIDDLE_OV_15_io_south_dout_r; // @[OverlayRocc.scala 330:49]
  wire [31:0] MIDDLEMIDDLE_OV_15_io_west_dout; // @[OverlayRocc.scala 330:49]
  wire  MIDDLEMIDDLE_OV_15_io_west_dout_v; // @[OverlayRocc.scala 330:49]
  wire  MIDDLEMIDDLE_OV_15_io_west_dout_r; // @[OverlayRocc.scala 330:49]
  wire [181:0] MIDDLEMIDDLE_OV_15_io_config_bits; // @[OverlayRocc.scala 330:49]
  wire  MIDDLEMIDDLE_OV_15_io_catch_config; // @[OverlayRocc.scala 330:49]
  wire  MIDDLESOUTH_OV_3_clock; // @[OverlayRocc.scala 379:48]
  wire  MIDDLESOUTH_OV_3_reset; // @[OverlayRocc.scala 379:48]
  wire [31:0] MIDDLESOUTH_OV_3_io_north_din; // @[OverlayRocc.scala 379:48]
  wire  MIDDLESOUTH_OV_3_io_north_din_v; // @[OverlayRocc.scala 379:48]
  wire  MIDDLESOUTH_OV_3_io_north_din_r; // @[OverlayRocc.scala 379:48]
  wire [31:0] MIDDLESOUTH_OV_3_io_east_din; // @[OverlayRocc.scala 379:48]
  wire  MIDDLESOUTH_OV_3_io_east_din_v; // @[OverlayRocc.scala 379:48]
  wire  MIDDLESOUTH_OV_3_io_east_din_r; // @[OverlayRocc.scala 379:48]
  wire [31:0] MIDDLESOUTH_OV_3_io_south_din; // @[OverlayRocc.scala 379:48]
  wire  MIDDLESOUTH_OV_3_io_south_din_v; // @[OverlayRocc.scala 379:48]
  wire  MIDDLESOUTH_OV_3_io_south_din_r; // @[OverlayRocc.scala 379:48]
  wire [31:0] MIDDLESOUTH_OV_3_io_west_din; // @[OverlayRocc.scala 379:48]
  wire  MIDDLESOUTH_OV_3_io_west_din_v; // @[OverlayRocc.scala 379:48]
  wire  MIDDLESOUTH_OV_3_io_west_din_r; // @[OverlayRocc.scala 379:48]
  wire [31:0] MIDDLESOUTH_OV_3_io_north_dout; // @[OverlayRocc.scala 379:48]
  wire  MIDDLESOUTH_OV_3_io_north_dout_v; // @[OverlayRocc.scala 379:48]
  wire  MIDDLESOUTH_OV_3_io_north_dout_r; // @[OverlayRocc.scala 379:48]
  wire [31:0] MIDDLESOUTH_OV_3_io_east_dout; // @[OverlayRocc.scala 379:48]
  wire  MIDDLESOUTH_OV_3_io_east_dout_v; // @[OverlayRocc.scala 379:48]
  wire  MIDDLESOUTH_OV_3_io_east_dout_r; // @[OverlayRocc.scala 379:48]
  wire [31:0] MIDDLESOUTH_OV_3_io_south_dout; // @[OverlayRocc.scala 379:48]
  wire  MIDDLESOUTH_OV_3_io_south_dout_v; // @[OverlayRocc.scala 379:48]
  wire  MIDDLESOUTH_OV_3_io_south_dout_r; // @[OverlayRocc.scala 379:48]
  wire [31:0] MIDDLESOUTH_OV_3_io_west_dout; // @[OverlayRocc.scala 379:48]
  wire  MIDDLESOUTH_OV_3_io_west_dout_v; // @[OverlayRocc.scala 379:48]
  wire  MIDDLESOUTH_OV_3_io_west_dout_r; // @[OverlayRocc.scala 379:48]
  wire [181:0] MIDDLESOUTH_OV_3_io_config_bits; // @[OverlayRocc.scala 379:48]
  wire  MIDDLESOUTH_OV_3_io_catch_config; // @[OverlayRocc.scala 379:48]
  wire  NORTHEAST_OV_clock; // @[OverlayRocc.scala 432:46]
  wire  NORTHEAST_OV_reset; // @[OverlayRocc.scala 432:46]
  wire [31:0] NORTHEAST_OV_io_north_din; // @[OverlayRocc.scala 432:46]
  wire  NORTHEAST_OV_io_north_din_v; // @[OverlayRocc.scala 432:46]
  wire  NORTHEAST_OV_io_north_din_r; // @[OverlayRocc.scala 432:46]
  wire [31:0] NORTHEAST_OV_io_east_din; // @[OverlayRocc.scala 432:46]
  wire  NORTHEAST_OV_io_east_din_v; // @[OverlayRocc.scala 432:46]
  wire  NORTHEAST_OV_io_east_din_r; // @[OverlayRocc.scala 432:46]
  wire [31:0] NORTHEAST_OV_io_south_din; // @[OverlayRocc.scala 432:46]
  wire  NORTHEAST_OV_io_south_din_v; // @[OverlayRocc.scala 432:46]
  wire  NORTHEAST_OV_io_south_din_r; // @[OverlayRocc.scala 432:46]
  wire [31:0] NORTHEAST_OV_io_west_din; // @[OverlayRocc.scala 432:46]
  wire  NORTHEAST_OV_io_west_din_v; // @[OverlayRocc.scala 432:46]
  wire  NORTHEAST_OV_io_west_din_r; // @[OverlayRocc.scala 432:46]
  wire [31:0] NORTHEAST_OV_io_north_dout; // @[OverlayRocc.scala 432:46]
  wire  NORTHEAST_OV_io_north_dout_v; // @[OverlayRocc.scala 432:46]
  wire  NORTHEAST_OV_io_north_dout_r; // @[OverlayRocc.scala 432:46]
  wire [31:0] NORTHEAST_OV_io_east_dout; // @[OverlayRocc.scala 432:46]
  wire  NORTHEAST_OV_io_east_dout_v; // @[OverlayRocc.scala 432:46]
  wire  NORTHEAST_OV_io_east_dout_r; // @[OverlayRocc.scala 432:46]
  wire [31:0] NORTHEAST_OV_io_south_dout; // @[OverlayRocc.scala 432:46]
  wire  NORTHEAST_OV_io_south_dout_v; // @[OverlayRocc.scala 432:46]
  wire  NORTHEAST_OV_io_south_dout_r; // @[OverlayRocc.scala 432:46]
  wire [31:0] NORTHEAST_OV_io_west_dout; // @[OverlayRocc.scala 432:46]
  wire  NORTHEAST_OV_io_west_dout_v; // @[OverlayRocc.scala 432:46]
  wire  NORTHEAST_OV_io_west_dout_r; // @[OverlayRocc.scala 432:46]
  wire [181:0] NORTHEAST_OV_io_config_bits; // @[OverlayRocc.scala 432:46]
  wire  NORTHEAST_OV_io_catch_config; // @[OverlayRocc.scala 432:46]
  wire  MIDDLEEAST_OV_clock; // @[OverlayRocc.scala 481:47]
  wire  MIDDLEEAST_OV_reset; // @[OverlayRocc.scala 481:47]
  wire [31:0] MIDDLEEAST_OV_io_north_din; // @[OverlayRocc.scala 481:47]
  wire  MIDDLEEAST_OV_io_north_din_v; // @[OverlayRocc.scala 481:47]
  wire  MIDDLEEAST_OV_io_north_din_r; // @[OverlayRocc.scala 481:47]
  wire [31:0] MIDDLEEAST_OV_io_east_din; // @[OverlayRocc.scala 481:47]
  wire  MIDDLEEAST_OV_io_east_din_v; // @[OverlayRocc.scala 481:47]
  wire  MIDDLEEAST_OV_io_east_din_r; // @[OverlayRocc.scala 481:47]
  wire [31:0] MIDDLEEAST_OV_io_south_din; // @[OverlayRocc.scala 481:47]
  wire  MIDDLEEAST_OV_io_south_din_v; // @[OverlayRocc.scala 481:47]
  wire  MIDDLEEAST_OV_io_south_din_r; // @[OverlayRocc.scala 481:47]
  wire [31:0] MIDDLEEAST_OV_io_west_din; // @[OverlayRocc.scala 481:47]
  wire  MIDDLEEAST_OV_io_west_din_v; // @[OverlayRocc.scala 481:47]
  wire  MIDDLEEAST_OV_io_west_din_r; // @[OverlayRocc.scala 481:47]
  wire [31:0] MIDDLEEAST_OV_io_north_dout; // @[OverlayRocc.scala 481:47]
  wire  MIDDLEEAST_OV_io_north_dout_v; // @[OverlayRocc.scala 481:47]
  wire  MIDDLEEAST_OV_io_north_dout_r; // @[OverlayRocc.scala 481:47]
  wire [31:0] MIDDLEEAST_OV_io_east_dout; // @[OverlayRocc.scala 481:47]
  wire  MIDDLEEAST_OV_io_east_dout_v; // @[OverlayRocc.scala 481:47]
  wire  MIDDLEEAST_OV_io_east_dout_r; // @[OverlayRocc.scala 481:47]
  wire [31:0] MIDDLEEAST_OV_io_south_dout; // @[OverlayRocc.scala 481:47]
  wire  MIDDLEEAST_OV_io_south_dout_v; // @[OverlayRocc.scala 481:47]
  wire  MIDDLEEAST_OV_io_south_dout_r; // @[OverlayRocc.scala 481:47]
  wire [31:0] MIDDLEEAST_OV_io_west_dout; // @[OverlayRocc.scala 481:47]
  wire  MIDDLEEAST_OV_io_west_dout_v; // @[OverlayRocc.scala 481:47]
  wire  MIDDLEEAST_OV_io_west_dout_r; // @[OverlayRocc.scala 481:47]
  wire [181:0] MIDDLEEAST_OV_io_config_bits; // @[OverlayRocc.scala 481:47]
  wire  MIDDLEEAST_OV_io_catch_config; // @[OverlayRocc.scala 481:47]
  wire  MIDDLEEAST_OV_1_clock; // @[OverlayRocc.scala 481:47]
  wire  MIDDLEEAST_OV_1_reset; // @[OverlayRocc.scala 481:47]
  wire [31:0] MIDDLEEAST_OV_1_io_north_din; // @[OverlayRocc.scala 481:47]
  wire  MIDDLEEAST_OV_1_io_north_din_v; // @[OverlayRocc.scala 481:47]
  wire  MIDDLEEAST_OV_1_io_north_din_r; // @[OverlayRocc.scala 481:47]
  wire [31:0] MIDDLEEAST_OV_1_io_east_din; // @[OverlayRocc.scala 481:47]
  wire  MIDDLEEAST_OV_1_io_east_din_v; // @[OverlayRocc.scala 481:47]
  wire  MIDDLEEAST_OV_1_io_east_din_r; // @[OverlayRocc.scala 481:47]
  wire [31:0] MIDDLEEAST_OV_1_io_south_din; // @[OverlayRocc.scala 481:47]
  wire  MIDDLEEAST_OV_1_io_south_din_v; // @[OverlayRocc.scala 481:47]
  wire  MIDDLEEAST_OV_1_io_south_din_r; // @[OverlayRocc.scala 481:47]
  wire [31:0] MIDDLEEAST_OV_1_io_west_din; // @[OverlayRocc.scala 481:47]
  wire  MIDDLEEAST_OV_1_io_west_din_v; // @[OverlayRocc.scala 481:47]
  wire  MIDDLEEAST_OV_1_io_west_din_r; // @[OverlayRocc.scala 481:47]
  wire [31:0] MIDDLEEAST_OV_1_io_north_dout; // @[OverlayRocc.scala 481:47]
  wire  MIDDLEEAST_OV_1_io_north_dout_v; // @[OverlayRocc.scala 481:47]
  wire  MIDDLEEAST_OV_1_io_north_dout_r; // @[OverlayRocc.scala 481:47]
  wire [31:0] MIDDLEEAST_OV_1_io_east_dout; // @[OverlayRocc.scala 481:47]
  wire  MIDDLEEAST_OV_1_io_east_dout_v; // @[OverlayRocc.scala 481:47]
  wire  MIDDLEEAST_OV_1_io_east_dout_r; // @[OverlayRocc.scala 481:47]
  wire [31:0] MIDDLEEAST_OV_1_io_south_dout; // @[OverlayRocc.scala 481:47]
  wire  MIDDLEEAST_OV_1_io_south_dout_v; // @[OverlayRocc.scala 481:47]
  wire  MIDDLEEAST_OV_1_io_south_dout_r; // @[OverlayRocc.scala 481:47]
  wire [31:0] MIDDLEEAST_OV_1_io_west_dout; // @[OverlayRocc.scala 481:47]
  wire  MIDDLEEAST_OV_1_io_west_dout_v; // @[OverlayRocc.scala 481:47]
  wire  MIDDLEEAST_OV_1_io_west_dout_r; // @[OverlayRocc.scala 481:47]
  wire [181:0] MIDDLEEAST_OV_1_io_config_bits; // @[OverlayRocc.scala 481:47]
  wire  MIDDLEEAST_OV_1_io_catch_config; // @[OverlayRocc.scala 481:47]
  wire  MIDDLEEAST_OV_2_clock; // @[OverlayRocc.scala 481:47]
  wire  MIDDLEEAST_OV_2_reset; // @[OverlayRocc.scala 481:47]
  wire [31:0] MIDDLEEAST_OV_2_io_north_din; // @[OverlayRocc.scala 481:47]
  wire  MIDDLEEAST_OV_2_io_north_din_v; // @[OverlayRocc.scala 481:47]
  wire  MIDDLEEAST_OV_2_io_north_din_r; // @[OverlayRocc.scala 481:47]
  wire [31:0] MIDDLEEAST_OV_2_io_east_din; // @[OverlayRocc.scala 481:47]
  wire  MIDDLEEAST_OV_2_io_east_din_v; // @[OverlayRocc.scala 481:47]
  wire  MIDDLEEAST_OV_2_io_east_din_r; // @[OverlayRocc.scala 481:47]
  wire [31:0] MIDDLEEAST_OV_2_io_south_din; // @[OverlayRocc.scala 481:47]
  wire  MIDDLEEAST_OV_2_io_south_din_v; // @[OverlayRocc.scala 481:47]
  wire  MIDDLEEAST_OV_2_io_south_din_r; // @[OverlayRocc.scala 481:47]
  wire [31:0] MIDDLEEAST_OV_2_io_west_din; // @[OverlayRocc.scala 481:47]
  wire  MIDDLEEAST_OV_2_io_west_din_v; // @[OverlayRocc.scala 481:47]
  wire  MIDDLEEAST_OV_2_io_west_din_r; // @[OverlayRocc.scala 481:47]
  wire [31:0] MIDDLEEAST_OV_2_io_north_dout; // @[OverlayRocc.scala 481:47]
  wire  MIDDLEEAST_OV_2_io_north_dout_v; // @[OverlayRocc.scala 481:47]
  wire  MIDDLEEAST_OV_2_io_north_dout_r; // @[OverlayRocc.scala 481:47]
  wire [31:0] MIDDLEEAST_OV_2_io_east_dout; // @[OverlayRocc.scala 481:47]
  wire  MIDDLEEAST_OV_2_io_east_dout_v; // @[OverlayRocc.scala 481:47]
  wire  MIDDLEEAST_OV_2_io_east_dout_r; // @[OverlayRocc.scala 481:47]
  wire [31:0] MIDDLEEAST_OV_2_io_south_dout; // @[OverlayRocc.scala 481:47]
  wire  MIDDLEEAST_OV_2_io_south_dout_v; // @[OverlayRocc.scala 481:47]
  wire  MIDDLEEAST_OV_2_io_south_dout_r; // @[OverlayRocc.scala 481:47]
  wire [31:0] MIDDLEEAST_OV_2_io_west_dout; // @[OverlayRocc.scala 481:47]
  wire  MIDDLEEAST_OV_2_io_west_dout_v; // @[OverlayRocc.scala 481:47]
  wire  MIDDLEEAST_OV_2_io_west_dout_r; // @[OverlayRocc.scala 481:47]
  wire [181:0] MIDDLEEAST_OV_2_io_config_bits; // @[OverlayRocc.scala 481:47]
  wire  MIDDLEEAST_OV_2_io_catch_config; // @[OverlayRocc.scala 481:47]
  wire  MIDDLEEAST_OV_3_clock; // @[OverlayRocc.scala 481:47]
  wire  MIDDLEEAST_OV_3_reset; // @[OverlayRocc.scala 481:47]
  wire [31:0] MIDDLEEAST_OV_3_io_north_din; // @[OverlayRocc.scala 481:47]
  wire  MIDDLEEAST_OV_3_io_north_din_v; // @[OverlayRocc.scala 481:47]
  wire  MIDDLEEAST_OV_3_io_north_din_r; // @[OverlayRocc.scala 481:47]
  wire [31:0] MIDDLEEAST_OV_3_io_east_din; // @[OverlayRocc.scala 481:47]
  wire  MIDDLEEAST_OV_3_io_east_din_v; // @[OverlayRocc.scala 481:47]
  wire  MIDDLEEAST_OV_3_io_east_din_r; // @[OverlayRocc.scala 481:47]
  wire [31:0] MIDDLEEAST_OV_3_io_south_din; // @[OverlayRocc.scala 481:47]
  wire  MIDDLEEAST_OV_3_io_south_din_v; // @[OverlayRocc.scala 481:47]
  wire  MIDDLEEAST_OV_3_io_south_din_r; // @[OverlayRocc.scala 481:47]
  wire [31:0] MIDDLEEAST_OV_3_io_west_din; // @[OverlayRocc.scala 481:47]
  wire  MIDDLEEAST_OV_3_io_west_din_v; // @[OverlayRocc.scala 481:47]
  wire  MIDDLEEAST_OV_3_io_west_din_r; // @[OverlayRocc.scala 481:47]
  wire [31:0] MIDDLEEAST_OV_3_io_north_dout; // @[OverlayRocc.scala 481:47]
  wire  MIDDLEEAST_OV_3_io_north_dout_v; // @[OverlayRocc.scala 481:47]
  wire  MIDDLEEAST_OV_3_io_north_dout_r; // @[OverlayRocc.scala 481:47]
  wire [31:0] MIDDLEEAST_OV_3_io_east_dout; // @[OverlayRocc.scala 481:47]
  wire  MIDDLEEAST_OV_3_io_east_dout_v; // @[OverlayRocc.scala 481:47]
  wire  MIDDLEEAST_OV_3_io_east_dout_r; // @[OverlayRocc.scala 481:47]
  wire [31:0] MIDDLEEAST_OV_3_io_south_dout; // @[OverlayRocc.scala 481:47]
  wire  MIDDLEEAST_OV_3_io_south_dout_v; // @[OverlayRocc.scala 481:47]
  wire  MIDDLEEAST_OV_3_io_south_dout_r; // @[OverlayRocc.scala 481:47]
  wire [31:0] MIDDLEEAST_OV_3_io_west_dout; // @[OverlayRocc.scala 481:47]
  wire  MIDDLEEAST_OV_3_io_west_dout_v; // @[OverlayRocc.scala 481:47]
  wire  MIDDLEEAST_OV_3_io_west_dout_r; // @[OverlayRocc.scala 481:47]
  wire [181:0] MIDDLEEAST_OV_3_io_config_bits; // @[OverlayRocc.scala 481:47]
  wire  MIDDLEEAST_OV_3_io_catch_config; // @[OverlayRocc.scala 481:47]
  wire  MIDDLESOUTH_OV_4_clock; // @[OverlayRocc.scala 530:48]
  wire  MIDDLESOUTH_OV_4_reset; // @[OverlayRocc.scala 530:48]
  wire [31:0] MIDDLESOUTH_OV_4_io_north_din; // @[OverlayRocc.scala 530:48]
  wire  MIDDLESOUTH_OV_4_io_north_din_v; // @[OverlayRocc.scala 530:48]
  wire  MIDDLESOUTH_OV_4_io_north_din_r; // @[OverlayRocc.scala 530:48]
  wire [31:0] MIDDLESOUTH_OV_4_io_east_din; // @[OverlayRocc.scala 530:48]
  wire  MIDDLESOUTH_OV_4_io_east_din_v; // @[OverlayRocc.scala 530:48]
  wire  MIDDLESOUTH_OV_4_io_east_din_r; // @[OverlayRocc.scala 530:48]
  wire [31:0] MIDDLESOUTH_OV_4_io_south_din; // @[OverlayRocc.scala 530:48]
  wire  MIDDLESOUTH_OV_4_io_south_din_v; // @[OverlayRocc.scala 530:48]
  wire  MIDDLESOUTH_OV_4_io_south_din_r; // @[OverlayRocc.scala 530:48]
  wire [31:0] MIDDLESOUTH_OV_4_io_west_din; // @[OverlayRocc.scala 530:48]
  wire  MIDDLESOUTH_OV_4_io_west_din_v; // @[OverlayRocc.scala 530:48]
  wire  MIDDLESOUTH_OV_4_io_west_din_r; // @[OverlayRocc.scala 530:48]
  wire [31:0] MIDDLESOUTH_OV_4_io_north_dout; // @[OverlayRocc.scala 530:48]
  wire  MIDDLESOUTH_OV_4_io_north_dout_v; // @[OverlayRocc.scala 530:48]
  wire  MIDDLESOUTH_OV_4_io_north_dout_r; // @[OverlayRocc.scala 530:48]
  wire [31:0] MIDDLESOUTH_OV_4_io_east_dout; // @[OverlayRocc.scala 530:48]
  wire  MIDDLESOUTH_OV_4_io_east_dout_v; // @[OverlayRocc.scala 530:48]
  wire  MIDDLESOUTH_OV_4_io_east_dout_r; // @[OverlayRocc.scala 530:48]
  wire [31:0] MIDDLESOUTH_OV_4_io_south_dout; // @[OverlayRocc.scala 530:48]
  wire  MIDDLESOUTH_OV_4_io_south_dout_v; // @[OverlayRocc.scala 530:48]
  wire  MIDDLESOUTH_OV_4_io_south_dout_r; // @[OverlayRocc.scala 530:48]
  wire [31:0] MIDDLESOUTH_OV_4_io_west_dout; // @[OverlayRocc.scala 530:48]
  wire  MIDDLESOUTH_OV_4_io_west_dout_v; // @[OverlayRocc.scala 530:48]
  wire  MIDDLESOUTH_OV_4_io_west_dout_r; // @[OverlayRocc.scala 530:48]
  wire [181:0] MIDDLESOUTH_OV_4_io_config_bits; // @[OverlayRocc.scala 530:48]
  wire  MIDDLESOUTH_OV_4_io_catch_config; // @[OverlayRocc.scala 530:48]
  wire [5:0] unsigned_cell_config = io_cell_config[190:185]; // @[OverlayRocc.scala 94:46]
  wire  _GEN_0 = 6'h0 == unsigned_cell_config; // @[OverlayRocc.scala 102:{44,44} 98:25]
  wire  _GEN_1 = 6'h1 == unsigned_cell_config; // @[OverlayRocc.scala 102:{44,44} 98:25]
  wire  _GEN_2 = 6'h2 == unsigned_cell_config; // @[OverlayRocc.scala 102:{44,44} 98:25]
  wire  _GEN_3 = 6'h3 == unsigned_cell_config; // @[OverlayRocc.scala 102:{44,44} 98:25]
  wire  _GEN_4 = 6'h4 == unsigned_cell_config; // @[OverlayRocc.scala 102:{44,44} 98:25]
  wire  _GEN_5 = 6'h5 == unsigned_cell_config; // @[OverlayRocc.scala 102:{44,44} 98:25]
  wire  _GEN_6 = 6'h6 == unsigned_cell_config; // @[OverlayRocc.scala 102:{44,44} 98:25]
  wire  _GEN_7 = 6'h7 == unsigned_cell_config; // @[OverlayRocc.scala 102:{44,44} 98:25]
  wire  _GEN_8 = 6'h8 == unsigned_cell_config; // @[OverlayRocc.scala 102:{44,44} 98:25]
  wire  _GEN_9 = 6'h9 == unsigned_cell_config; // @[OverlayRocc.scala 102:{44,44} 98:25]
  wire  _GEN_10 = 6'ha == unsigned_cell_config; // @[OverlayRocc.scala 102:{44,44} 98:25]
  wire  _GEN_11 = 6'hb == unsigned_cell_config; // @[OverlayRocc.scala 102:{44,44} 98:25]
  wire  _GEN_12 = 6'hc == unsigned_cell_config; // @[OverlayRocc.scala 102:{44,44} 98:25]
  wire  _GEN_13 = 6'hd == unsigned_cell_config; // @[OverlayRocc.scala 102:{44,44} 98:25]
  wire  _GEN_14 = 6'he == unsigned_cell_config; // @[OverlayRocc.scala 102:{44,44} 98:25]
  wire  _GEN_15 = 6'hf == unsigned_cell_config; // @[OverlayRocc.scala 102:{44,44} 98:25]
  wire  _GEN_16 = 6'h10 == unsigned_cell_config; // @[OverlayRocc.scala 102:{44,44} 98:25]
  wire  _GEN_17 = 6'h11 == unsigned_cell_config; // @[OverlayRocc.scala 102:{44,44} 98:25]
  wire  _GEN_18 = 6'h12 == unsigned_cell_config; // @[OverlayRocc.scala 102:{44,44} 98:25]
  wire  _GEN_19 = 6'h13 == unsigned_cell_config; // @[OverlayRocc.scala 102:{44,44} 98:25]
  wire  _GEN_20 = 6'h14 == unsigned_cell_config; // @[OverlayRocc.scala 102:{44,44} 98:25]
  wire  _GEN_21 = 6'h15 == unsigned_cell_config; // @[OverlayRocc.scala 102:{44,44} 98:25]
  wire  _GEN_22 = 6'h16 == unsigned_cell_config; // @[OverlayRocc.scala 102:{44,44} 98:25]
  wire  _GEN_23 = 6'h17 == unsigned_cell_config; // @[OverlayRocc.scala 102:{44,44} 98:25]
  wire  _GEN_24 = 6'h18 == unsigned_cell_config; // @[OverlayRocc.scala 102:{44,44} 98:25]
  wire  _GEN_25 = 6'h19 == unsigned_cell_config; // @[OverlayRocc.scala 102:{44,44} 98:25]
  wire  _GEN_26 = 6'h1a == unsigned_cell_config; // @[OverlayRocc.scala 102:{44,44} 98:25]
  wire  _GEN_27 = 6'h1b == unsigned_cell_config; // @[OverlayRocc.scala 102:{44,44} 98:25]
  wire  _GEN_28 = 6'h1c == unsigned_cell_config; // @[OverlayRocc.scala 102:{44,44} 98:25]
  wire  _GEN_29 = 6'h1d == unsigned_cell_config; // @[OverlayRocc.scala 102:{44,44} 98:25]
  wire  _GEN_30 = 6'h1e == unsigned_cell_config; // @[OverlayRocc.scala 102:{44,44} 98:25]
  wire  _GEN_31 = 6'h1f == unsigned_cell_config; // @[OverlayRocc.scala 102:{44,44} 98:25]
  wire  _GEN_32 = 6'h20 == unsigned_cell_config; // @[OverlayRocc.scala 102:{44,44} 98:25]
  wire  _GEN_33 = 6'h21 == unsigned_cell_config; // @[OverlayRocc.scala 102:{44,44} 98:25]
  wire  _GEN_34 = 6'h22 == unsigned_cell_config; // @[OverlayRocc.scala 102:{44,44} 98:25]
  wire  _GEN_35 = 6'h23 == unsigned_cell_config; // @[OverlayRocc.scala 102:{44,44} 98:25]
  wire  north_din_r_2 = MIDDLENORTH_OV_1_io_north_din_r; // @[OverlayRocc.scala 63:27 286:36]
  wire  north_din_r_1 = MIDDLENORTH_OV_io_north_din_r; // @[OverlayRocc.scala 63:27 286:36]
  wire  north_din_r_0 = NORTHWEST_OV_io_north_din_r; // @[OverlayRocc.scala 135:67]
  wire [2:0] io_data_in_ready_lo = {north_din_r_2,north_din_r_1,north_din_r_0}; // @[OverlayRocc.scala 112:43]
  wire  north_din_r_5 = NORTHEAST_OV_io_north_din_r; // @[OverlayRocc.scala 63:27 437:36]
  wire  north_din_r_4 = MIDDLENORTH_OV_3_io_north_din_r; // @[OverlayRocc.scala 63:27 286:36]
  wire  north_din_r_3 = MIDDLENORTH_OV_2_io_north_din_r; // @[OverlayRocc.scala 63:27 286:36]
  wire [2:0] io_data_in_ready_hi = {north_din_r_5,north_din_r_4,north_din_r_3}; // @[OverlayRocc.scala 112:43]
  wire [95:0] io_data_out_lo = {MIDDLEEAST_OV_1_io_east_dout,MIDDLEEAST_OV_io_east_dout,NORTHEAST_OV_io_east_dout}; // @[OverlayRocc.scala 588:33]
  wire [95:0] io_data_out_hi = {MIDDLESOUTH_OV_4_io_east_dout,MIDDLEEAST_OV_3_io_east_dout,MIDDLEEAST_OV_2_io_east_dout}
    ; // @[OverlayRocc.scala 588:33]
  wire  east_dout_v_2 = MIDDLEEAST_OV_1_io_east_dout_v; // @[OverlayRocc.scala 66:27 510:36]
  wire  east_dout_v_1 = MIDDLEEAST_OV_io_east_dout_v; // @[OverlayRocc.scala 66:27 510:36]
  wire  east_dout_v_0 = NORTHEAST_OV_io_east_dout_v; // @[OverlayRocc.scala 66:27 461:36]
  wire [2:0] io_data_out_valid_lo = {east_dout_v_2,east_dout_v_1,east_dout_v_0}; // @[OverlayRocc.scala 589:45]
  wire  east_dout_v_5 = MIDDLESOUTH_OV_4_io_east_dout_v; // @[OverlayRocc.scala 66:27 559:36]
  wire  east_dout_v_4 = MIDDLEEAST_OV_3_io_east_dout_v; // @[OverlayRocc.scala 66:27 510:36]
  wire  east_dout_v_3 = MIDDLEEAST_OV_2_io_east_dout_v; // @[OverlayRocc.scala 66:27 510:36]
  wire [2:0] io_data_out_valid_hi = {east_dout_v_5,east_dout_v_4,east_dout_v_3}; // @[OverlayRocc.scala 589:45]
  ProcessingElement NORTHWEST_OV ( // @[OverlayRocc.scala 130:46]
    .clock(NORTHWEST_OV_clock),
    .reset(NORTHWEST_OV_reset),
    .io_north_din(NORTHWEST_OV_io_north_din),
    .io_north_din_v(NORTHWEST_OV_io_north_din_v),
    .io_north_din_r(NORTHWEST_OV_io_north_din_r),
    .io_east_din(NORTHWEST_OV_io_east_din),
    .io_east_din_v(NORTHWEST_OV_io_east_din_v),
    .io_east_din_r(NORTHWEST_OV_io_east_din_r),
    .io_south_din(NORTHWEST_OV_io_south_din),
    .io_south_din_v(NORTHWEST_OV_io_south_din_v),
    .io_south_din_r(NORTHWEST_OV_io_south_din_r),
    .io_west_din(NORTHWEST_OV_io_west_din),
    .io_west_din_v(NORTHWEST_OV_io_west_din_v),
    .io_west_din_r(NORTHWEST_OV_io_west_din_r),
    .io_north_dout(NORTHWEST_OV_io_north_dout),
    .io_north_dout_v(NORTHWEST_OV_io_north_dout_v),
    .io_north_dout_r(NORTHWEST_OV_io_north_dout_r),
    .io_east_dout(NORTHWEST_OV_io_east_dout),
    .io_east_dout_v(NORTHWEST_OV_io_east_dout_v),
    .io_east_dout_r(NORTHWEST_OV_io_east_dout_r),
    .io_south_dout(NORTHWEST_OV_io_south_dout),
    .io_south_dout_v(NORTHWEST_OV_io_south_dout_v),
    .io_south_dout_r(NORTHWEST_OV_io_south_dout_r),
    .io_west_dout(NORTHWEST_OV_io_west_dout),
    .io_west_dout_v(NORTHWEST_OV_io_west_dout_v),
    .io_west_dout_r(NORTHWEST_OV_io_west_dout_r),
    .io_config_bits(NORTHWEST_OV_io_config_bits),
    .io_catch_config(NORTHWEST_OV_io_catch_config)
  );
  ProcessingElement MIDWEST_OV ( // @[OverlayRocc.scala 179:44]
    .clock(MIDWEST_OV_clock),
    .reset(MIDWEST_OV_reset),
    .io_north_din(MIDWEST_OV_io_north_din),
    .io_north_din_v(MIDWEST_OV_io_north_din_v),
    .io_north_din_r(MIDWEST_OV_io_north_din_r),
    .io_east_din(MIDWEST_OV_io_east_din),
    .io_east_din_v(MIDWEST_OV_io_east_din_v),
    .io_east_din_r(MIDWEST_OV_io_east_din_r),
    .io_south_din(MIDWEST_OV_io_south_din),
    .io_south_din_v(MIDWEST_OV_io_south_din_v),
    .io_south_din_r(MIDWEST_OV_io_south_din_r),
    .io_west_din(MIDWEST_OV_io_west_din),
    .io_west_din_v(MIDWEST_OV_io_west_din_v),
    .io_west_din_r(MIDWEST_OV_io_west_din_r),
    .io_north_dout(MIDWEST_OV_io_north_dout),
    .io_north_dout_v(MIDWEST_OV_io_north_dout_v),
    .io_north_dout_r(MIDWEST_OV_io_north_dout_r),
    .io_east_dout(MIDWEST_OV_io_east_dout),
    .io_east_dout_v(MIDWEST_OV_io_east_dout_v),
    .io_east_dout_r(MIDWEST_OV_io_east_dout_r),
    .io_south_dout(MIDWEST_OV_io_south_dout),
    .io_south_dout_v(MIDWEST_OV_io_south_dout_v),
    .io_south_dout_r(MIDWEST_OV_io_south_dout_r),
    .io_west_dout(MIDWEST_OV_io_west_dout),
    .io_west_dout_v(MIDWEST_OV_io_west_dout_v),
    .io_west_dout_r(MIDWEST_OV_io_west_dout_r),
    .io_config_bits(MIDWEST_OV_io_config_bits),
    .io_catch_config(MIDWEST_OV_io_catch_config)
  );
  ProcessingElement MIDWEST_OV_1 ( // @[OverlayRocc.scala 179:44]
    .clock(MIDWEST_OV_1_clock),
    .reset(MIDWEST_OV_1_reset),
    .io_north_din(MIDWEST_OV_1_io_north_din),
    .io_north_din_v(MIDWEST_OV_1_io_north_din_v),
    .io_north_din_r(MIDWEST_OV_1_io_north_din_r),
    .io_east_din(MIDWEST_OV_1_io_east_din),
    .io_east_din_v(MIDWEST_OV_1_io_east_din_v),
    .io_east_din_r(MIDWEST_OV_1_io_east_din_r),
    .io_south_din(MIDWEST_OV_1_io_south_din),
    .io_south_din_v(MIDWEST_OV_1_io_south_din_v),
    .io_south_din_r(MIDWEST_OV_1_io_south_din_r),
    .io_west_din(MIDWEST_OV_1_io_west_din),
    .io_west_din_v(MIDWEST_OV_1_io_west_din_v),
    .io_west_din_r(MIDWEST_OV_1_io_west_din_r),
    .io_north_dout(MIDWEST_OV_1_io_north_dout),
    .io_north_dout_v(MIDWEST_OV_1_io_north_dout_v),
    .io_north_dout_r(MIDWEST_OV_1_io_north_dout_r),
    .io_east_dout(MIDWEST_OV_1_io_east_dout),
    .io_east_dout_v(MIDWEST_OV_1_io_east_dout_v),
    .io_east_dout_r(MIDWEST_OV_1_io_east_dout_r),
    .io_south_dout(MIDWEST_OV_1_io_south_dout),
    .io_south_dout_v(MIDWEST_OV_1_io_south_dout_v),
    .io_south_dout_r(MIDWEST_OV_1_io_south_dout_r),
    .io_west_dout(MIDWEST_OV_1_io_west_dout),
    .io_west_dout_v(MIDWEST_OV_1_io_west_dout_v),
    .io_west_dout_r(MIDWEST_OV_1_io_west_dout_r),
    .io_config_bits(MIDWEST_OV_1_io_config_bits),
    .io_catch_config(MIDWEST_OV_1_io_catch_config)
  );
  ProcessingElement MIDWEST_OV_2 ( // @[OverlayRocc.scala 179:44]
    .clock(MIDWEST_OV_2_clock),
    .reset(MIDWEST_OV_2_reset),
    .io_north_din(MIDWEST_OV_2_io_north_din),
    .io_north_din_v(MIDWEST_OV_2_io_north_din_v),
    .io_north_din_r(MIDWEST_OV_2_io_north_din_r),
    .io_east_din(MIDWEST_OV_2_io_east_din),
    .io_east_din_v(MIDWEST_OV_2_io_east_din_v),
    .io_east_din_r(MIDWEST_OV_2_io_east_din_r),
    .io_south_din(MIDWEST_OV_2_io_south_din),
    .io_south_din_v(MIDWEST_OV_2_io_south_din_v),
    .io_south_din_r(MIDWEST_OV_2_io_south_din_r),
    .io_west_din(MIDWEST_OV_2_io_west_din),
    .io_west_din_v(MIDWEST_OV_2_io_west_din_v),
    .io_west_din_r(MIDWEST_OV_2_io_west_din_r),
    .io_north_dout(MIDWEST_OV_2_io_north_dout),
    .io_north_dout_v(MIDWEST_OV_2_io_north_dout_v),
    .io_north_dout_r(MIDWEST_OV_2_io_north_dout_r),
    .io_east_dout(MIDWEST_OV_2_io_east_dout),
    .io_east_dout_v(MIDWEST_OV_2_io_east_dout_v),
    .io_east_dout_r(MIDWEST_OV_2_io_east_dout_r),
    .io_south_dout(MIDWEST_OV_2_io_south_dout),
    .io_south_dout_v(MIDWEST_OV_2_io_south_dout_v),
    .io_south_dout_r(MIDWEST_OV_2_io_south_dout_r),
    .io_west_dout(MIDWEST_OV_2_io_west_dout),
    .io_west_dout_v(MIDWEST_OV_2_io_west_dout_v),
    .io_west_dout_r(MIDWEST_OV_2_io_west_dout_r),
    .io_config_bits(MIDWEST_OV_2_io_config_bits),
    .io_catch_config(MIDWEST_OV_2_io_catch_config)
  );
  ProcessingElement MIDWEST_OV_3 ( // @[OverlayRocc.scala 179:44]
    .clock(MIDWEST_OV_3_clock),
    .reset(MIDWEST_OV_3_reset),
    .io_north_din(MIDWEST_OV_3_io_north_din),
    .io_north_din_v(MIDWEST_OV_3_io_north_din_v),
    .io_north_din_r(MIDWEST_OV_3_io_north_din_r),
    .io_east_din(MIDWEST_OV_3_io_east_din),
    .io_east_din_v(MIDWEST_OV_3_io_east_din_v),
    .io_east_din_r(MIDWEST_OV_3_io_east_din_r),
    .io_south_din(MIDWEST_OV_3_io_south_din),
    .io_south_din_v(MIDWEST_OV_3_io_south_din_v),
    .io_south_din_r(MIDWEST_OV_3_io_south_din_r),
    .io_west_din(MIDWEST_OV_3_io_west_din),
    .io_west_din_v(MIDWEST_OV_3_io_west_din_v),
    .io_west_din_r(MIDWEST_OV_3_io_west_din_r),
    .io_north_dout(MIDWEST_OV_3_io_north_dout),
    .io_north_dout_v(MIDWEST_OV_3_io_north_dout_v),
    .io_north_dout_r(MIDWEST_OV_3_io_north_dout_r),
    .io_east_dout(MIDWEST_OV_3_io_east_dout),
    .io_east_dout_v(MIDWEST_OV_3_io_east_dout_v),
    .io_east_dout_r(MIDWEST_OV_3_io_east_dout_r),
    .io_south_dout(MIDWEST_OV_3_io_south_dout),
    .io_south_dout_v(MIDWEST_OV_3_io_south_dout_v),
    .io_south_dout_r(MIDWEST_OV_3_io_south_dout_r),
    .io_west_dout(MIDWEST_OV_3_io_west_dout),
    .io_west_dout_v(MIDWEST_OV_3_io_west_dout_v),
    .io_west_dout_r(MIDWEST_OV_3_io_west_dout_r),
    .io_config_bits(MIDWEST_OV_3_io_config_bits),
    .io_catch_config(MIDWEST_OV_3_io_catch_config)
  );
  ProcessingElement SOUTHWEST_OV ( // @[OverlayRocc.scala 228:46]
    .clock(SOUTHWEST_OV_clock),
    .reset(SOUTHWEST_OV_reset),
    .io_north_din(SOUTHWEST_OV_io_north_din),
    .io_north_din_v(SOUTHWEST_OV_io_north_din_v),
    .io_north_din_r(SOUTHWEST_OV_io_north_din_r),
    .io_east_din(SOUTHWEST_OV_io_east_din),
    .io_east_din_v(SOUTHWEST_OV_io_east_din_v),
    .io_east_din_r(SOUTHWEST_OV_io_east_din_r),
    .io_south_din(SOUTHWEST_OV_io_south_din),
    .io_south_din_v(SOUTHWEST_OV_io_south_din_v),
    .io_south_din_r(SOUTHWEST_OV_io_south_din_r),
    .io_west_din(SOUTHWEST_OV_io_west_din),
    .io_west_din_v(SOUTHWEST_OV_io_west_din_v),
    .io_west_din_r(SOUTHWEST_OV_io_west_din_r),
    .io_north_dout(SOUTHWEST_OV_io_north_dout),
    .io_north_dout_v(SOUTHWEST_OV_io_north_dout_v),
    .io_north_dout_r(SOUTHWEST_OV_io_north_dout_r),
    .io_east_dout(SOUTHWEST_OV_io_east_dout),
    .io_east_dout_v(SOUTHWEST_OV_io_east_dout_v),
    .io_east_dout_r(SOUTHWEST_OV_io_east_dout_r),
    .io_south_dout(SOUTHWEST_OV_io_south_dout),
    .io_south_dout_v(SOUTHWEST_OV_io_south_dout_v),
    .io_south_dout_r(SOUTHWEST_OV_io_south_dout_r),
    .io_west_dout(SOUTHWEST_OV_io_west_dout),
    .io_west_dout_v(SOUTHWEST_OV_io_west_dout_v),
    .io_west_dout_r(SOUTHWEST_OV_io_west_dout_r),
    .io_config_bits(SOUTHWEST_OV_io_config_bits),
    .io_catch_config(SOUTHWEST_OV_io_catch_config)
  );
  ProcessingElement MIDDLENORTH_OV ( // @[OverlayRocc.scala 281:48]
    .clock(MIDDLENORTH_OV_clock),
    .reset(MIDDLENORTH_OV_reset),
    .io_north_din(MIDDLENORTH_OV_io_north_din),
    .io_north_din_v(MIDDLENORTH_OV_io_north_din_v),
    .io_north_din_r(MIDDLENORTH_OV_io_north_din_r),
    .io_east_din(MIDDLENORTH_OV_io_east_din),
    .io_east_din_v(MIDDLENORTH_OV_io_east_din_v),
    .io_east_din_r(MIDDLENORTH_OV_io_east_din_r),
    .io_south_din(MIDDLENORTH_OV_io_south_din),
    .io_south_din_v(MIDDLENORTH_OV_io_south_din_v),
    .io_south_din_r(MIDDLENORTH_OV_io_south_din_r),
    .io_west_din(MIDDLENORTH_OV_io_west_din),
    .io_west_din_v(MIDDLENORTH_OV_io_west_din_v),
    .io_west_din_r(MIDDLENORTH_OV_io_west_din_r),
    .io_north_dout(MIDDLENORTH_OV_io_north_dout),
    .io_north_dout_v(MIDDLENORTH_OV_io_north_dout_v),
    .io_north_dout_r(MIDDLENORTH_OV_io_north_dout_r),
    .io_east_dout(MIDDLENORTH_OV_io_east_dout),
    .io_east_dout_v(MIDDLENORTH_OV_io_east_dout_v),
    .io_east_dout_r(MIDDLENORTH_OV_io_east_dout_r),
    .io_south_dout(MIDDLENORTH_OV_io_south_dout),
    .io_south_dout_v(MIDDLENORTH_OV_io_south_dout_v),
    .io_south_dout_r(MIDDLENORTH_OV_io_south_dout_r),
    .io_west_dout(MIDDLENORTH_OV_io_west_dout),
    .io_west_dout_v(MIDDLENORTH_OV_io_west_dout_v),
    .io_west_dout_r(MIDDLENORTH_OV_io_west_dout_r),
    .io_config_bits(MIDDLENORTH_OV_io_config_bits),
    .io_catch_config(MIDDLENORTH_OV_io_catch_config)
  );
  ProcessingElement MIDDLEMIDDLE_OV ( // @[OverlayRocc.scala 330:49]
    .clock(MIDDLEMIDDLE_OV_clock),
    .reset(MIDDLEMIDDLE_OV_reset),
    .io_north_din(MIDDLEMIDDLE_OV_io_north_din),
    .io_north_din_v(MIDDLEMIDDLE_OV_io_north_din_v),
    .io_north_din_r(MIDDLEMIDDLE_OV_io_north_din_r),
    .io_east_din(MIDDLEMIDDLE_OV_io_east_din),
    .io_east_din_v(MIDDLEMIDDLE_OV_io_east_din_v),
    .io_east_din_r(MIDDLEMIDDLE_OV_io_east_din_r),
    .io_south_din(MIDDLEMIDDLE_OV_io_south_din),
    .io_south_din_v(MIDDLEMIDDLE_OV_io_south_din_v),
    .io_south_din_r(MIDDLEMIDDLE_OV_io_south_din_r),
    .io_west_din(MIDDLEMIDDLE_OV_io_west_din),
    .io_west_din_v(MIDDLEMIDDLE_OV_io_west_din_v),
    .io_west_din_r(MIDDLEMIDDLE_OV_io_west_din_r),
    .io_north_dout(MIDDLEMIDDLE_OV_io_north_dout),
    .io_north_dout_v(MIDDLEMIDDLE_OV_io_north_dout_v),
    .io_north_dout_r(MIDDLEMIDDLE_OV_io_north_dout_r),
    .io_east_dout(MIDDLEMIDDLE_OV_io_east_dout),
    .io_east_dout_v(MIDDLEMIDDLE_OV_io_east_dout_v),
    .io_east_dout_r(MIDDLEMIDDLE_OV_io_east_dout_r),
    .io_south_dout(MIDDLEMIDDLE_OV_io_south_dout),
    .io_south_dout_v(MIDDLEMIDDLE_OV_io_south_dout_v),
    .io_south_dout_r(MIDDLEMIDDLE_OV_io_south_dout_r),
    .io_west_dout(MIDDLEMIDDLE_OV_io_west_dout),
    .io_west_dout_v(MIDDLEMIDDLE_OV_io_west_dout_v),
    .io_west_dout_r(MIDDLEMIDDLE_OV_io_west_dout_r),
    .io_config_bits(MIDDLEMIDDLE_OV_io_config_bits),
    .io_catch_config(MIDDLEMIDDLE_OV_io_catch_config)
  );
  ProcessingElement MIDDLEMIDDLE_OV_1 ( // @[OverlayRocc.scala 330:49]
    .clock(MIDDLEMIDDLE_OV_1_clock),
    .reset(MIDDLEMIDDLE_OV_1_reset),
    .io_north_din(MIDDLEMIDDLE_OV_1_io_north_din),
    .io_north_din_v(MIDDLEMIDDLE_OV_1_io_north_din_v),
    .io_north_din_r(MIDDLEMIDDLE_OV_1_io_north_din_r),
    .io_east_din(MIDDLEMIDDLE_OV_1_io_east_din),
    .io_east_din_v(MIDDLEMIDDLE_OV_1_io_east_din_v),
    .io_east_din_r(MIDDLEMIDDLE_OV_1_io_east_din_r),
    .io_south_din(MIDDLEMIDDLE_OV_1_io_south_din),
    .io_south_din_v(MIDDLEMIDDLE_OV_1_io_south_din_v),
    .io_south_din_r(MIDDLEMIDDLE_OV_1_io_south_din_r),
    .io_west_din(MIDDLEMIDDLE_OV_1_io_west_din),
    .io_west_din_v(MIDDLEMIDDLE_OV_1_io_west_din_v),
    .io_west_din_r(MIDDLEMIDDLE_OV_1_io_west_din_r),
    .io_north_dout(MIDDLEMIDDLE_OV_1_io_north_dout),
    .io_north_dout_v(MIDDLEMIDDLE_OV_1_io_north_dout_v),
    .io_north_dout_r(MIDDLEMIDDLE_OV_1_io_north_dout_r),
    .io_east_dout(MIDDLEMIDDLE_OV_1_io_east_dout),
    .io_east_dout_v(MIDDLEMIDDLE_OV_1_io_east_dout_v),
    .io_east_dout_r(MIDDLEMIDDLE_OV_1_io_east_dout_r),
    .io_south_dout(MIDDLEMIDDLE_OV_1_io_south_dout),
    .io_south_dout_v(MIDDLEMIDDLE_OV_1_io_south_dout_v),
    .io_south_dout_r(MIDDLEMIDDLE_OV_1_io_south_dout_r),
    .io_west_dout(MIDDLEMIDDLE_OV_1_io_west_dout),
    .io_west_dout_v(MIDDLEMIDDLE_OV_1_io_west_dout_v),
    .io_west_dout_r(MIDDLEMIDDLE_OV_1_io_west_dout_r),
    .io_config_bits(MIDDLEMIDDLE_OV_1_io_config_bits),
    .io_catch_config(MIDDLEMIDDLE_OV_1_io_catch_config)
  );
  ProcessingElement MIDDLEMIDDLE_OV_2 ( // @[OverlayRocc.scala 330:49]
    .clock(MIDDLEMIDDLE_OV_2_clock),
    .reset(MIDDLEMIDDLE_OV_2_reset),
    .io_north_din(MIDDLEMIDDLE_OV_2_io_north_din),
    .io_north_din_v(MIDDLEMIDDLE_OV_2_io_north_din_v),
    .io_north_din_r(MIDDLEMIDDLE_OV_2_io_north_din_r),
    .io_east_din(MIDDLEMIDDLE_OV_2_io_east_din),
    .io_east_din_v(MIDDLEMIDDLE_OV_2_io_east_din_v),
    .io_east_din_r(MIDDLEMIDDLE_OV_2_io_east_din_r),
    .io_south_din(MIDDLEMIDDLE_OV_2_io_south_din),
    .io_south_din_v(MIDDLEMIDDLE_OV_2_io_south_din_v),
    .io_south_din_r(MIDDLEMIDDLE_OV_2_io_south_din_r),
    .io_west_din(MIDDLEMIDDLE_OV_2_io_west_din),
    .io_west_din_v(MIDDLEMIDDLE_OV_2_io_west_din_v),
    .io_west_din_r(MIDDLEMIDDLE_OV_2_io_west_din_r),
    .io_north_dout(MIDDLEMIDDLE_OV_2_io_north_dout),
    .io_north_dout_v(MIDDLEMIDDLE_OV_2_io_north_dout_v),
    .io_north_dout_r(MIDDLEMIDDLE_OV_2_io_north_dout_r),
    .io_east_dout(MIDDLEMIDDLE_OV_2_io_east_dout),
    .io_east_dout_v(MIDDLEMIDDLE_OV_2_io_east_dout_v),
    .io_east_dout_r(MIDDLEMIDDLE_OV_2_io_east_dout_r),
    .io_south_dout(MIDDLEMIDDLE_OV_2_io_south_dout),
    .io_south_dout_v(MIDDLEMIDDLE_OV_2_io_south_dout_v),
    .io_south_dout_r(MIDDLEMIDDLE_OV_2_io_south_dout_r),
    .io_west_dout(MIDDLEMIDDLE_OV_2_io_west_dout),
    .io_west_dout_v(MIDDLEMIDDLE_OV_2_io_west_dout_v),
    .io_west_dout_r(MIDDLEMIDDLE_OV_2_io_west_dout_r),
    .io_config_bits(MIDDLEMIDDLE_OV_2_io_config_bits),
    .io_catch_config(MIDDLEMIDDLE_OV_2_io_catch_config)
  );
  ProcessingElement MIDDLEMIDDLE_OV_3 ( // @[OverlayRocc.scala 330:49]
    .clock(MIDDLEMIDDLE_OV_3_clock),
    .reset(MIDDLEMIDDLE_OV_3_reset),
    .io_north_din(MIDDLEMIDDLE_OV_3_io_north_din),
    .io_north_din_v(MIDDLEMIDDLE_OV_3_io_north_din_v),
    .io_north_din_r(MIDDLEMIDDLE_OV_3_io_north_din_r),
    .io_east_din(MIDDLEMIDDLE_OV_3_io_east_din),
    .io_east_din_v(MIDDLEMIDDLE_OV_3_io_east_din_v),
    .io_east_din_r(MIDDLEMIDDLE_OV_3_io_east_din_r),
    .io_south_din(MIDDLEMIDDLE_OV_3_io_south_din),
    .io_south_din_v(MIDDLEMIDDLE_OV_3_io_south_din_v),
    .io_south_din_r(MIDDLEMIDDLE_OV_3_io_south_din_r),
    .io_west_din(MIDDLEMIDDLE_OV_3_io_west_din),
    .io_west_din_v(MIDDLEMIDDLE_OV_3_io_west_din_v),
    .io_west_din_r(MIDDLEMIDDLE_OV_3_io_west_din_r),
    .io_north_dout(MIDDLEMIDDLE_OV_3_io_north_dout),
    .io_north_dout_v(MIDDLEMIDDLE_OV_3_io_north_dout_v),
    .io_north_dout_r(MIDDLEMIDDLE_OV_3_io_north_dout_r),
    .io_east_dout(MIDDLEMIDDLE_OV_3_io_east_dout),
    .io_east_dout_v(MIDDLEMIDDLE_OV_3_io_east_dout_v),
    .io_east_dout_r(MIDDLEMIDDLE_OV_3_io_east_dout_r),
    .io_south_dout(MIDDLEMIDDLE_OV_3_io_south_dout),
    .io_south_dout_v(MIDDLEMIDDLE_OV_3_io_south_dout_v),
    .io_south_dout_r(MIDDLEMIDDLE_OV_3_io_south_dout_r),
    .io_west_dout(MIDDLEMIDDLE_OV_3_io_west_dout),
    .io_west_dout_v(MIDDLEMIDDLE_OV_3_io_west_dout_v),
    .io_west_dout_r(MIDDLEMIDDLE_OV_3_io_west_dout_r),
    .io_config_bits(MIDDLEMIDDLE_OV_3_io_config_bits),
    .io_catch_config(MIDDLEMIDDLE_OV_3_io_catch_config)
  );
  ProcessingElement MIDDLESOUTH_OV ( // @[OverlayRocc.scala 379:48]
    .clock(MIDDLESOUTH_OV_clock),
    .reset(MIDDLESOUTH_OV_reset),
    .io_north_din(MIDDLESOUTH_OV_io_north_din),
    .io_north_din_v(MIDDLESOUTH_OV_io_north_din_v),
    .io_north_din_r(MIDDLESOUTH_OV_io_north_din_r),
    .io_east_din(MIDDLESOUTH_OV_io_east_din),
    .io_east_din_v(MIDDLESOUTH_OV_io_east_din_v),
    .io_east_din_r(MIDDLESOUTH_OV_io_east_din_r),
    .io_south_din(MIDDLESOUTH_OV_io_south_din),
    .io_south_din_v(MIDDLESOUTH_OV_io_south_din_v),
    .io_south_din_r(MIDDLESOUTH_OV_io_south_din_r),
    .io_west_din(MIDDLESOUTH_OV_io_west_din),
    .io_west_din_v(MIDDLESOUTH_OV_io_west_din_v),
    .io_west_din_r(MIDDLESOUTH_OV_io_west_din_r),
    .io_north_dout(MIDDLESOUTH_OV_io_north_dout),
    .io_north_dout_v(MIDDLESOUTH_OV_io_north_dout_v),
    .io_north_dout_r(MIDDLESOUTH_OV_io_north_dout_r),
    .io_east_dout(MIDDLESOUTH_OV_io_east_dout),
    .io_east_dout_v(MIDDLESOUTH_OV_io_east_dout_v),
    .io_east_dout_r(MIDDLESOUTH_OV_io_east_dout_r),
    .io_south_dout(MIDDLESOUTH_OV_io_south_dout),
    .io_south_dout_v(MIDDLESOUTH_OV_io_south_dout_v),
    .io_south_dout_r(MIDDLESOUTH_OV_io_south_dout_r),
    .io_west_dout(MIDDLESOUTH_OV_io_west_dout),
    .io_west_dout_v(MIDDLESOUTH_OV_io_west_dout_v),
    .io_west_dout_r(MIDDLESOUTH_OV_io_west_dout_r),
    .io_config_bits(MIDDLESOUTH_OV_io_config_bits),
    .io_catch_config(MIDDLESOUTH_OV_io_catch_config)
  );
  ProcessingElement MIDDLENORTH_OV_1 ( // @[OverlayRocc.scala 281:48]
    .clock(MIDDLENORTH_OV_1_clock),
    .reset(MIDDLENORTH_OV_1_reset),
    .io_north_din(MIDDLENORTH_OV_1_io_north_din),
    .io_north_din_v(MIDDLENORTH_OV_1_io_north_din_v),
    .io_north_din_r(MIDDLENORTH_OV_1_io_north_din_r),
    .io_east_din(MIDDLENORTH_OV_1_io_east_din),
    .io_east_din_v(MIDDLENORTH_OV_1_io_east_din_v),
    .io_east_din_r(MIDDLENORTH_OV_1_io_east_din_r),
    .io_south_din(MIDDLENORTH_OV_1_io_south_din),
    .io_south_din_v(MIDDLENORTH_OV_1_io_south_din_v),
    .io_south_din_r(MIDDLENORTH_OV_1_io_south_din_r),
    .io_west_din(MIDDLENORTH_OV_1_io_west_din),
    .io_west_din_v(MIDDLENORTH_OV_1_io_west_din_v),
    .io_west_din_r(MIDDLENORTH_OV_1_io_west_din_r),
    .io_north_dout(MIDDLENORTH_OV_1_io_north_dout),
    .io_north_dout_v(MIDDLENORTH_OV_1_io_north_dout_v),
    .io_north_dout_r(MIDDLENORTH_OV_1_io_north_dout_r),
    .io_east_dout(MIDDLENORTH_OV_1_io_east_dout),
    .io_east_dout_v(MIDDLENORTH_OV_1_io_east_dout_v),
    .io_east_dout_r(MIDDLENORTH_OV_1_io_east_dout_r),
    .io_south_dout(MIDDLENORTH_OV_1_io_south_dout),
    .io_south_dout_v(MIDDLENORTH_OV_1_io_south_dout_v),
    .io_south_dout_r(MIDDLENORTH_OV_1_io_south_dout_r),
    .io_west_dout(MIDDLENORTH_OV_1_io_west_dout),
    .io_west_dout_v(MIDDLENORTH_OV_1_io_west_dout_v),
    .io_west_dout_r(MIDDLENORTH_OV_1_io_west_dout_r),
    .io_config_bits(MIDDLENORTH_OV_1_io_config_bits),
    .io_catch_config(MIDDLENORTH_OV_1_io_catch_config)
  );
  ProcessingElement MIDDLEMIDDLE_OV_4 ( // @[OverlayRocc.scala 330:49]
    .clock(MIDDLEMIDDLE_OV_4_clock),
    .reset(MIDDLEMIDDLE_OV_4_reset),
    .io_north_din(MIDDLEMIDDLE_OV_4_io_north_din),
    .io_north_din_v(MIDDLEMIDDLE_OV_4_io_north_din_v),
    .io_north_din_r(MIDDLEMIDDLE_OV_4_io_north_din_r),
    .io_east_din(MIDDLEMIDDLE_OV_4_io_east_din),
    .io_east_din_v(MIDDLEMIDDLE_OV_4_io_east_din_v),
    .io_east_din_r(MIDDLEMIDDLE_OV_4_io_east_din_r),
    .io_south_din(MIDDLEMIDDLE_OV_4_io_south_din),
    .io_south_din_v(MIDDLEMIDDLE_OV_4_io_south_din_v),
    .io_south_din_r(MIDDLEMIDDLE_OV_4_io_south_din_r),
    .io_west_din(MIDDLEMIDDLE_OV_4_io_west_din),
    .io_west_din_v(MIDDLEMIDDLE_OV_4_io_west_din_v),
    .io_west_din_r(MIDDLEMIDDLE_OV_4_io_west_din_r),
    .io_north_dout(MIDDLEMIDDLE_OV_4_io_north_dout),
    .io_north_dout_v(MIDDLEMIDDLE_OV_4_io_north_dout_v),
    .io_north_dout_r(MIDDLEMIDDLE_OV_4_io_north_dout_r),
    .io_east_dout(MIDDLEMIDDLE_OV_4_io_east_dout),
    .io_east_dout_v(MIDDLEMIDDLE_OV_4_io_east_dout_v),
    .io_east_dout_r(MIDDLEMIDDLE_OV_4_io_east_dout_r),
    .io_south_dout(MIDDLEMIDDLE_OV_4_io_south_dout),
    .io_south_dout_v(MIDDLEMIDDLE_OV_4_io_south_dout_v),
    .io_south_dout_r(MIDDLEMIDDLE_OV_4_io_south_dout_r),
    .io_west_dout(MIDDLEMIDDLE_OV_4_io_west_dout),
    .io_west_dout_v(MIDDLEMIDDLE_OV_4_io_west_dout_v),
    .io_west_dout_r(MIDDLEMIDDLE_OV_4_io_west_dout_r),
    .io_config_bits(MIDDLEMIDDLE_OV_4_io_config_bits),
    .io_catch_config(MIDDLEMIDDLE_OV_4_io_catch_config)
  );
  ProcessingElement MIDDLEMIDDLE_OV_5 ( // @[OverlayRocc.scala 330:49]
    .clock(MIDDLEMIDDLE_OV_5_clock),
    .reset(MIDDLEMIDDLE_OV_5_reset),
    .io_north_din(MIDDLEMIDDLE_OV_5_io_north_din),
    .io_north_din_v(MIDDLEMIDDLE_OV_5_io_north_din_v),
    .io_north_din_r(MIDDLEMIDDLE_OV_5_io_north_din_r),
    .io_east_din(MIDDLEMIDDLE_OV_5_io_east_din),
    .io_east_din_v(MIDDLEMIDDLE_OV_5_io_east_din_v),
    .io_east_din_r(MIDDLEMIDDLE_OV_5_io_east_din_r),
    .io_south_din(MIDDLEMIDDLE_OV_5_io_south_din),
    .io_south_din_v(MIDDLEMIDDLE_OV_5_io_south_din_v),
    .io_south_din_r(MIDDLEMIDDLE_OV_5_io_south_din_r),
    .io_west_din(MIDDLEMIDDLE_OV_5_io_west_din),
    .io_west_din_v(MIDDLEMIDDLE_OV_5_io_west_din_v),
    .io_west_din_r(MIDDLEMIDDLE_OV_5_io_west_din_r),
    .io_north_dout(MIDDLEMIDDLE_OV_5_io_north_dout),
    .io_north_dout_v(MIDDLEMIDDLE_OV_5_io_north_dout_v),
    .io_north_dout_r(MIDDLEMIDDLE_OV_5_io_north_dout_r),
    .io_east_dout(MIDDLEMIDDLE_OV_5_io_east_dout),
    .io_east_dout_v(MIDDLEMIDDLE_OV_5_io_east_dout_v),
    .io_east_dout_r(MIDDLEMIDDLE_OV_5_io_east_dout_r),
    .io_south_dout(MIDDLEMIDDLE_OV_5_io_south_dout),
    .io_south_dout_v(MIDDLEMIDDLE_OV_5_io_south_dout_v),
    .io_south_dout_r(MIDDLEMIDDLE_OV_5_io_south_dout_r),
    .io_west_dout(MIDDLEMIDDLE_OV_5_io_west_dout),
    .io_west_dout_v(MIDDLEMIDDLE_OV_5_io_west_dout_v),
    .io_west_dout_r(MIDDLEMIDDLE_OV_5_io_west_dout_r),
    .io_config_bits(MIDDLEMIDDLE_OV_5_io_config_bits),
    .io_catch_config(MIDDLEMIDDLE_OV_5_io_catch_config)
  );
  ProcessingElement MIDDLEMIDDLE_OV_6 ( // @[OverlayRocc.scala 330:49]
    .clock(MIDDLEMIDDLE_OV_6_clock),
    .reset(MIDDLEMIDDLE_OV_6_reset),
    .io_north_din(MIDDLEMIDDLE_OV_6_io_north_din),
    .io_north_din_v(MIDDLEMIDDLE_OV_6_io_north_din_v),
    .io_north_din_r(MIDDLEMIDDLE_OV_6_io_north_din_r),
    .io_east_din(MIDDLEMIDDLE_OV_6_io_east_din),
    .io_east_din_v(MIDDLEMIDDLE_OV_6_io_east_din_v),
    .io_east_din_r(MIDDLEMIDDLE_OV_6_io_east_din_r),
    .io_south_din(MIDDLEMIDDLE_OV_6_io_south_din),
    .io_south_din_v(MIDDLEMIDDLE_OV_6_io_south_din_v),
    .io_south_din_r(MIDDLEMIDDLE_OV_6_io_south_din_r),
    .io_west_din(MIDDLEMIDDLE_OV_6_io_west_din),
    .io_west_din_v(MIDDLEMIDDLE_OV_6_io_west_din_v),
    .io_west_din_r(MIDDLEMIDDLE_OV_6_io_west_din_r),
    .io_north_dout(MIDDLEMIDDLE_OV_6_io_north_dout),
    .io_north_dout_v(MIDDLEMIDDLE_OV_6_io_north_dout_v),
    .io_north_dout_r(MIDDLEMIDDLE_OV_6_io_north_dout_r),
    .io_east_dout(MIDDLEMIDDLE_OV_6_io_east_dout),
    .io_east_dout_v(MIDDLEMIDDLE_OV_6_io_east_dout_v),
    .io_east_dout_r(MIDDLEMIDDLE_OV_6_io_east_dout_r),
    .io_south_dout(MIDDLEMIDDLE_OV_6_io_south_dout),
    .io_south_dout_v(MIDDLEMIDDLE_OV_6_io_south_dout_v),
    .io_south_dout_r(MIDDLEMIDDLE_OV_6_io_south_dout_r),
    .io_west_dout(MIDDLEMIDDLE_OV_6_io_west_dout),
    .io_west_dout_v(MIDDLEMIDDLE_OV_6_io_west_dout_v),
    .io_west_dout_r(MIDDLEMIDDLE_OV_6_io_west_dout_r),
    .io_config_bits(MIDDLEMIDDLE_OV_6_io_config_bits),
    .io_catch_config(MIDDLEMIDDLE_OV_6_io_catch_config)
  );
  ProcessingElement MIDDLEMIDDLE_OV_7 ( // @[OverlayRocc.scala 330:49]
    .clock(MIDDLEMIDDLE_OV_7_clock),
    .reset(MIDDLEMIDDLE_OV_7_reset),
    .io_north_din(MIDDLEMIDDLE_OV_7_io_north_din),
    .io_north_din_v(MIDDLEMIDDLE_OV_7_io_north_din_v),
    .io_north_din_r(MIDDLEMIDDLE_OV_7_io_north_din_r),
    .io_east_din(MIDDLEMIDDLE_OV_7_io_east_din),
    .io_east_din_v(MIDDLEMIDDLE_OV_7_io_east_din_v),
    .io_east_din_r(MIDDLEMIDDLE_OV_7_io_east_din_r),
    .io_south_din(MIDDLEMIDDLE_OV_7_io_south_din),
    .io_south_din_v(MIDDLEMIDDLE_OV_7_io_south_din_v),
    .io_south_din_r(MIDDLEMIDDLE_OV_7_io_south_din_r),
    .io_west_din(MIDDLEMIDDLE_OV_7_io_west_din),
    .io_west_din_v(MIDDLEMIDDLE_OV_7_io_west_din_v),
    .io_west_din_r(MIDDLEMIDDLE_OV_7_io_west_din_r),
    .io_north_dout(MIDDLEMIDDLE_OV_7_io_north_dout),
    .io_north_dout_v(MIDDLEMIDDLE_OV_7_io_north_dout_v),
    .io_north_dout_r(MIDDLEMIDDLE_OV_7_io_north_dout_r),
    .io_east_dout(MIDDLEMIDDLE_OV_7_io_east_dout),
    .io_east_dout_v(MIDDLEMIDDLE_OV_7_io_east_dout_v),
    .io_east_dout_r(MIDDLEMIDDLE_OV_7_io_east_dout_r),
    .io_south_dout(MIDDLEMIDDLE_OV_7_io_south_dout),
    .io_south_dout_v(MIDDLEMIDDLE_OV_7_io_south_dout_v),
    .io_south_dout_r(MIDDLEMIDDLE_OV_7_io_south_dout_r),
    .io_west_dout(MIDDLEMIDDLE_OV_7_io_west_dout),
    .io_west_dout_v(MIDDLEMIDDLE_OV_7_io_west_dout_v),
    .io_west_dout_r(MIDDLEMIDDLE_OV_7_io_west_dout_r),
    .io_config_bits(MIDDLEMIDDLE_OV_7_io_config_bits),
    .io_catch_config(MIDDLEMIDDLE_OV_7_io_catch_config)
  );
  ProcessingElement MIDDLESOUTH_OV_1 ( // @[OverlayRocc.scala 379:48]
    .clock(MIDDLESOUTH_OV_1_clock),
    .reset(MIDDLESOUTH_OV_1_reset),
    .io_north_din(MIDDLESOUTH_OV_1_io_north_din),
    .io_north_din_v(MIDDLESOUTH_OV_1_io_north_din_v),
    .io_north_din_r(MIDDLESOUTH_OV_1_io_north_din_r),
    .io_east_din(MIDDLESOUTH_OV_1_io_east_din),
    .io_east_din_v(MIDDLESOUTH_OV_1_io_east_din_v),
    .io_east_din_r(MIDDLESOUTH_OV_1_io_east_din_r),
    .io_south_din(MIDDLESOUTH_OV_1_io_south_din),
    .io_south_din_v(MIDDLESOUTH_OV_1_io_south_din_v),
    .io_south_din_r(MIDDLESOUTH_OV_1_io_south_din_r),
    .io_west_din(MIDDLESOUTH_OV_1_io_west_din),
    .io_west_din_v(MIDDLESOUTH_OV_1_io_west_din_v),
    .io_west_din_r(MIDDLESOUTH_OV_1_io_west_din_r),
    .io_north_dout(MIDDLESOUTH_OV_1_io_north_dout),
    .io_north_dout_v(MIDDLESOUTH_OV_1_io_north_dout_v),
    .io_north_dout_r(MIDDLESOUTH_OV_1_io_north_dout_r),
    .io_east_dout(MIDDLESOUTH_OV_1_io_east_dout),
    .io_east_dout_v(MIDDLESOUTH_OV_1_io_east_dout_v),
    .io_east_dout_r(MIDDLESOUTH_OV_1_io_east_dout_r),
    .io_south_dout(MIDDLESOUTH_OV_1_io_south_dout),
    .io_south_dout_v(MIDDLESOUTH_OV_1_io_south_dout_v),
    .io_south_dout_r(MIDDLESOUTH_OV_1_io_south_dout_r),
    .io_west_dout(MIDDLESOUTH_OV_1_io_west_dout),
    .io_west_dout_v(MIDDLESOUTH_OV_1_io_west_dout_v),
    .io_west_dout_r(MIDDLESOUTH_OV_1_io_west_dout_r),
    .io_config_bits(MIDDLESOUTH_OV_1_io_config_bits),
    .io_catch_config(MIDDLESOUTH_OV_1_io_catch_config)
  );
  ProcessingElement MIDDLENORTH_OV_2 ( // @[OverlayRocc.scala 281:48]
    .clock(MIDDLENORTH_OV_2_clock),
    .reset(MIDDLENORTH_OV_2_reset),
    .io_north_din(MIDDLENORTH_OV_2_io_north_din),
    .io_north_din_v(MIDDLENORTH_OV_2_io_north_din_v),
    .io_north_din_r(MIDDLENORTH_OV_2_io_north_din_r),
    .io_east_din(MIDDLENORTH_OV_2_io_east_din),
    .io_east_din_v(MIDDLENORTH_OV_2_io_east_din_v),
    .io_east_din_r(MIDDLENORTH_OV_2_io_east_din_r),
    .io_south_din(MIDDLENORTH_OV_2_io_south_din),
    .io_south_din_v(MIDDLENORTH_OV_2_io_south_din_v),
    .io_south_din_r(MIDDLENORTH_OV_2_io_south_din_r),
    .io_west_din(MIDDLENORTH_OV_2_io_west_din),
    .io_west_din_v(MIDDLENORTH_OV_2_io_west_din_v),
    .io_west_din_r(MIDDLENORTH_OV_2_io_west_din_r),
    .io_north_dout(MIDDLENORTH_OV_2_io_north_dout),
    .io_north_dout_v(MIDDLENORTH_OV_2_io_north_dout_v),
    .io_north_dout_r(MIDDLENORTH_OV_2_io_north_dout_r),
    .io_east_dout(MIDDLENORTH_OV_2_io_east_dout),
    .io_east_dout_v(MIDDLENORTH_OV_2_io_east_dout_v),
    .io_east_dout_r(MIDDLENORTH_OV_2_io_east_dout_r),
    .io_south_dout(MIDDLENORTH_OV_2_io_south_dout),
    .io_south_dout_v(MIDDLENORTH_OV_2_io_south_dout_v),
    .io_south_dout_r(MIDDLENORTH_OV_2_io_south_dout_r),
    .io_west_dout(MIDDLENORTH_OV_2_io_west_dout),
    .io_west_dout_v(MIDDLENORTH_OV_2_io_west_dout_v),
    .io_west_dout_r(MIDDLENORTH_OV_2_io_west_dout_r),
    .io_config_bits(MIDDLENORTH_OV_2_io_config_bits),
    .io_catch_config(MIDDLENORTH_OV_2_io_catch_config)
  );
  ProcessingElement MIDDLEMIDDLE_OV_8 ( // @[OverlayRocc.scala 330:49]
    .clock(MIDDLEMIDDLE_OV_8_clock),
    .reset(MIDDLEMIDDLE_OV_8_reset),
    .io_north_din(MIDDLEMIDDLE_OV_8_io_north_din),
    .io_north_din_v(MIDDLEMIDDLE_OV_8_io_north_din_v),
    .io_north_din_r(MIDDLEMIDDLE_OV_8_io_north_din_r),
    .io_east_din(MIDDLEMIDDLE_OV_8_io_east_din),
    .io_east_din_v(MIDDLEMIDDLE_OV_8_io_east_din_v),
    .io_east_din_r(MIDDLEMIDDLE_OV_8_io_east_din_r),
    .io_south_din(MIDDLEMIDDLE_OV_8_io_south_din),
    .io_south_din_v(MIDDLEMIDDLE_OV_8_io_south_din_v),
    .io_south_din_r(MIDDLEMIDDLE_OV_8_io_south_din_r),
    .io_west_din(MIDDLEMIDDLE_OV_8_io_west_din),
    .io_west_din_v(MIDDLEMIDDLE_OV_8_io_west_din_v),
    .io_west_din_r(MIDDLEMIDDLE_OV_8_io_west_din_r),
    .io_north_dout(MIDDLEMIDDLE_OV_8_io_north_dout),
    .io_north_dout_v(MIDDLEMIDDLE_OV_8_io_north_dout_v),
    .io_north_dout_r(MIDDLEMIDDLE_OV_8_io_north_dout_r),
    .io_east_dout(MIDDLEMIDDLE_OV_8_io_east_dout),
    .io_east_dout_v(MIDDLEMIDDLE_OV_8_io_east_dout_v),
    .io_east_dout_r(MIDDLEMIDDLE_OV_8_io_east_dout_r),
    .io_south_dout(MIDDLEMIDDLE_OV_8_io_south_dout),
    .io_south_dout_v(MIDDLEMIDDLE_OV_8_io_south_dout_v),
    .io_south_dout_r(MIDDLEMIDDLE_OV_8_io_south_dout_r),
    .io_west_dout(MIDDLEMIDDLE_OV_8_io_west_dout),
    .io_west_dout_v(MIDDLEMIDDLE_OV_8_io_west_dout_v),
    .io_west_dout_r(MIDDLEMIDDLE_OV_8_io_west_dout_r),
    .io_config_bits(MIDDLEMIDDLE_OV_8_io_config_bits),
    .io_catch_config(MIDDLEMIDDLE_OV_8_io_catch_config)
  );
  ProcessingElement MIDDLEMIDDLE_OV_9 ( // @[OverlayRocc.scala 330:49]
    .clock(MIDDLEMIDDLE_OV_9_clock),
    .reset(MIDDLEMIDDLE_OV_9_reset),
    .io_north_din(MIDDLEMIDDLE_OV_9_io_north_din),
    .io_north_din_v(MIDDLEMIDDLE_OV_9_io_north_din_v),
    .io_north_din_r(MIDDLEMIDDLE_OV_9_io_north_din_r),
    .io_east_din(MIDDLEMIDDLE_OV_9_io_east_din),
    .io_east_din_v(MIDDLEMIDDLE_OV_9_io_east_din_v),
    .io_east_din_r(MIDDLEMIDDLE_OV_9_io_east_din_r),
    .io_south_din(MIDDLEMIDDLE_OV_9_io_south_din),
    .io_south_din_v(MIDDLEMIDDLE_OV_9_io_south_din_v),
    .io_south_din_r(MIDDLEMIDDLE_OV_9_io_south_din_r),
    .io_west_din(MIDDLEMIDDLE_OV_9_io_west_din),
    .io_west_din_v(MIDDLEMIDDLE_OV_9_io_west_din_v),
    .io_west_din_r(MIDDLEMIDDLE_OV_9_io_west_din_r),
    .io_north_dout(MIDDLEMIDDLE_OV_9_io_north_dout),
    .io_north_dout_v(MIDDLEMIDDLE_OV_9_io_north_dout_v),
    .io_north_dout_r(MIDDLEMIDDLE_OV_9_io_north_dout_r),
    .io_east_dout(MIDDLEMIDDLE_OV_9_io_east_dout),
    .io_east_dout_v(MIDDLEMIDDLE_OV_9_io_east_dout_v),
    .io_east_dout_r(MIDDLEMIDDLE_OV_9_io_east_dout_r),
    .io_south_dout(MIDDLEMIDDLE_OV_9_io_south_dout),
    .io_south_dout_v(MIDDLEMIDDLE_OV_9_io_south_dout_v),
    .io_south_dout_r(MIDDLEMIDDLE_OV_9_io_south_dout_r),
    .io_west_dout(MIDDLEMIDDLE_OV_9_io_west_dout),
    .io_west_dout_v(MIDDLEMIDDLE_OV_9_io_west_dout_v),
    .io_west_dout_r(MIDDLEMIDDLE_OV_9_io_west_dout_r),
    .io_config_bits(MIDDLEMIDDLE_OV_9_io_config_bits),
    .io_catch_config(MIDDLEMIDDLE_OV_9_io_catch_config)
  );
  ProcessingElement MIDDLEMIDDLE_OV_10 ( // @[OverlayRocc.scala 330:49]
    .clock(MIDDLEMIDDLE_OV_10_clock),
    .reset(MIDDLEMIDDLE_OV_10_reset),
    .io_north_din(MIDDLEMIDDLE_OV_10_io_north_din),
    .io_north_din_v(MIDDLEMIDDLE_OV_10_io_north_din_v),
    .io_north_din_r(MIDDLEMIDDLE_OV_10_io_north_din_r),
    .io_east_din(MIDDLEMIDDLE_OV_10_io_east_din),
    .io_east_din_v(MIDDLEMIDDLE_OV_10_io_east_din_v),
    .io_east_din_r(MIDDLEMIDDLE_OV_10_io_east_din_r),
    .io_south_din(MIDDLEMIDDLE_OV_10_io_south_din),
    .io_south_din_v(MIDDLEMIDDLE_OV_10_io_south_din_v),
    .io_south_din_r(MIDDLEMIDDLE_OV_10_io_south_din_r),
    .io_west_din(MIDDLEMIDDLE_OV_10_io_west_din),
    .io_west_din_v(MIDDLEMIDDLE_OV_10_io_west_din_v),
    .io_west_din_r(MIDDLEMIDDLE_OV_10_io_west_din_r),
    .io_north_dout(MIDDLEMIDDLE_OV_10_io_north_dout),
    .io_north_dout_v(MIDDLEMIDDLE_OV_10_io_north_dout_v),
    .io_north_dout_r(MIDDLEMIDDLE_OV_10_io_north_dout_r),
    .io_east_dout(MIDDLEMIDDLE_OV_10_io_east_dout),
    .io_east_dout_v(MIDDLEMIDDLE_OV_10_io_east_dout_v),
    .io_east_dout_r(MIDDLEMIDDLE_OV_10_io_east_dout_r),
    .io_south_dout(MIDDLEMIDDLE_OV_10_io_south_dout),
    .io_south_dout_v(MIDDLEMIDDLE_OV_10_io_south_dout_v),
    .io_south_dout_r(MIDDLEMIDDLE_OV_10_io_south_dout_r),
    .io_west_dout(MIDDLEMIDDLE_OV_10_io_west_dout),
    .io_west_dout_v(MIDDLEMIDDLE_OV_10_io_west_dout_v),
    .io_west_dout_r(MIDDLEMIDDLE_OV_10_io_west_dout_r),
    .io_config_bits(MIDDLEMIDDLE_OV_10_io_config_bits),
    .io_catch_config(MIDDLEMIDDLE_OV_10_io_catch_config)
  );
  ProcessingElement MIDDLEMIDDLE_OV_11 ( // @[OverlayRocc.scala 330:49]
    .clock(MIDDLEMIDDLE_OV_11_clock),
    .reset(MIDDLEMIDDLE_OV_11_reset),
    .io_north_din(MIDDLEMIDDLE_OV_11_io_north_din),
    .io_north_din_v(MIDDLEMIDDLE_OV_11_io_north_din_v),
    .io_north_din_r(MIDDLEMIDDLE_OV_11_io_north_din_r),
    .io_east_din(MIDDLEMIDDLE_OV_11_io_east_din),
    .io_east_din_v(MIDDLEMIDDLE_OV_11_io_east_din_v),
    .io_east_din_r(MIDDLEMIDDLE_OV_11_io_east_din_r),
    .io_south_din(MIDDLEMIDDLE_OV_11_io_south_din),
    .io_south_din_v(MIDDLEMIDDLE_OV_11_io_south_din_v),
    .io_south_din_r(MIDDLEMIDDLE_OV_11_io_south_din_r),
    .io_west_din(MIDDLEMIDDLE_OV_11_io_west_din),
    .io_west_din_v(MIDDLEMIDDLE_OV_11_io_west_din_v),
    .io_west_din_r(MIDDLEMIDDLE_OV_11_io_west_din_r),
    .io_north_dout(MIDDLEMIDDLE_OV_11_io_north_dout),
    .io_north_dout_v(MIDDLEMIDDLE_OV_11_io_north_dout_v),
    .io_north_dout_r(MIDDLEMIDDLE_OV_11_io_north_dout_r),
    .io_east_dout(MIDDLEMIDDLE_OV_11_io_east_dout),
    .io_east_dout_v(MIDDLEMIDDLE_OV_11_io_east_dout_v),
    .io_east_dout_r(MIDDLEMIDDLE_OV_11_io_east_dout_r),
    .io_south_dout(MIDDLEMIDDLE_OV_11_io_south_dout),
    .io_south_dout_v(MIDDLEMIDDLE_OV_11_io_south_dout_v),
    .io_south_dout_r(MIDDLEMIDDLE_OV_11_io_south_dout_r),
    .io_west_dout(MIDDLEMIDDLE_OV_11_io_west_dout),
    .io_west_dout_v(MIDDLEMIDDLE_OV_11_io_west_dout_v),
    .io_west_dout_r(MIDDLEMIDDLE_OV_11_io_west_dout_r),
    .io_config_bits(MIDDLEMIDDLE_OV_11_io_config_bits),
    .io_catch_config(MIDDLEMIDDLE_OV_11_io_catch_config)
  );
  ProcessingElement MIDDLESOUTH_OV_2 ( // @[OverlayRocc.scala 379:48]
    .clock(MIDDLESOUTH_OV_2_clock),
    .reset(MIDDLESOUTH_OV_2_reset),
    .io_north_din(MIDDLESOUTH_OV_2_io_north_din),
    .io_north_din_v(MIDDLESOUTH_OV_2_io_north_din_v),
    .io_north_din_r(MIDDLESOUTH_OV_2_io_north_din_r),
    .io_east_din(MIDDLESOUTH_OV_2_io_east_din),
    .io_east_din_v(MIDDLESOUTH_OV_2_io_east_din_v),
    .io_east_din_r(MIDDLESOUTH_OV_2_io_east_din_r),
    .io_south_din(MIDDLESOUTH_OV_2_io_south_din),
    .io_south_din_v(MIDDLESOUTH_OV_2_io_south_din_v),
    .io_south_din_r(MIDDLESOUTH_OV_2_io_south_din_r),
    .io_west_din(MIDDLESOUTH_OV_2_io_west_din),
    .io_west_din_v(MIDDLESOUTH_OV_2_io_west_din_v),
    .io_west_din_r(MIDDLESOUTH_OV_2_io_west_din_r),
    .io_north_dout(MIDDLESOUTH_OV_2_io_north_dout),
    .io_north_dout_v(MIDDLESOUTH_OV_2_io_north_dout_v),
    .io_north_dout_r(MIDDLESOUTH_OV_2_io_north_dout_r),
    .io_east_dout(MIDDLESOUTH_OV_2_io_east_dout),
    .io_east_dout_v(MIDDLESOUTH_OV_2_io_east_dout_v),
    .io_east_dout_r(MIDDLESOUTH_OV_2_io_east_dout_r),
    .io_south_dout(MIDDLESOUTH_OV_2_io_south_dout),
    .io_south_dout_v(MIDDLESOUTH_OV_2_io_south_dout_v),
    .io_south_dout_r(MIDDLESOUTH_OV_2_io_south_dout_r),
    .io_west_dout(MIDDLESOUTH_OV_2_io_west_dout),
    .io_west_dout_v(MIDDLESOUTH_OV_2_io_west_dout_v),
    .io_west_dout_r(MIDDLESOUTH_OV_2_io_west_dout_r),
    .io_config_bits(MIDDLESOUTH_OV_2_io_config_bits),
    .io_catch_config(MIDDLESOUTH_OV_2_io_catch_config)
  );
  ProcessingElement MIDDLENORTH_OV_3 ( // @[OverlayRocc.scala 281:48]
    .clock(MIDDLENORTH_OV_3_clock),
    .reset(MIDDLENORTH_OV_3_reset),
    .io_north_din(MIDDLENORTH_OV_3_io_north_din),
    .io_north_din_v(MIDDLENORTH_OV_3_io_north_din_v),
    .io_north_din_r(MIDDLENORTH_OV_3_io_north_din_r),
    .io_east_din(MIDDLENORTH_OV_3_io_east_din),
    .io_east_din_v(MIDDLENORTH_OV_3_io_east_din_v),
    .io_east_din_r(MIDDLENORTH_OV_3_io_east_din_r),
    .io_south_din(MIDDLENORTH_OV_3_io_south_din),
    .io_south_din_v(MIDDLENORTH_OV_3_io_south_din_v),
    .io_south_din_r(MIDDLENORTH_OV_3_io_south_din_r),
    .io_west_din(MIDDLENORTH_OV_3_io_west_din),
    .io_west_din_v(MIDDLENORTH_OV_3_io_west_din_v),
    .io_west_din_r(MIDDLENORTH_OV_3_io_west_din_r),
    .io_north_dout(MIDDLENORTH_OV_3_io_north_dout),
    .io_north_dout_v(MIDDLENORTH_OV_3_io_north_dout_v),
    .io_north_dout_r(MIDDLENORTH_OV_3_io_north_dout_r),
    .io_east_dout(MIDDLENORTH_OV_3_io_east_dout),
    .io_east_dout_v(MIDDLENORTH_OV_3_io_east_dout_v),
    .io_east_dout_r(MIDDLENORTH_OV_3_io_east_dout_r),
    .io_south_dout(MIDDLENORTH_OV_3_io_south_dout),
    .io_south_dout_v(MIDDLENORTH_OV_3_io_south_dout_v),
    .io_south_dout_r(MIDDLENORTH_OV_3_io_south_dout_r),
    .io_west_dout(MIDDLENORTH_OV_3_io_west_dout),
    .io_west_dout_v(MIDDLENORTH_OV_3_io_west_dout_v),
    .io_west_dout_r(MIDDLENORTH_OV_3_io_west_dout_r),
    .io_config_bits(MIDDLENORTH_OV_3_io_config_bits),
    .io_catch_config(MIDDLENORTH_OV_3_io_catch_config)
  );
  ProcessingElement MIDDLEMIDDLE_OV_12 ( // @[OverlayRocc.scala 330:49]
    .clock(MIDDLEMIDDLE_OV_12_clock),
    .reset(MIDDLEMIDDLE_OV_12_reset),
    .io_north_din(MIDDLEMIDDLE_OV_12_io_north_din),
    .io_north_din_v(MIDDLEMIDDLE_OV_12_io_north_din_v),
    .io_north_din_r(MIDDLEMIDDLE_OV_12_io_north_din_r),
    .io_east_din(MIDDLEMIDDLE_OV_12_io_east_din),
    .io_east_din_v(MIDDLEMIDDLE_OV_12_io_east_din_v),
    .io_east_din_r(MIDDLEMIDDLE_OV_12_io_east_din_r),
    .io_south_din(MIDDLEMIDDLE_OV_12_io_south_din),
    .io_south_din_v(MIDDLEMIDDLE_OV_12_io_south_din_v),
    .io_south_din_r(MIDDLEMIDDLE_OV_12_io_south_din_r),
    .io_west_din(MIDDLEMIDDLE_OV_12_io_west_din),
    .io_west_din_v(MIDDLEMIDDLE_OV_12_io_west_din_v),
    .io_west_din_r(MIDDLEMIDDLE_OV_12_io_west_din_r),
    .io_north_dout(MIDDLEMIDDLE_OV_12_io_north_dout),
    .io_north_dout_v(MIDDLEMIDDLE_OV_12_io_north_dout_v),
    .io_north_dout_r(MIDDLEMIDDLE_OV_12_io_north_dout_r),
    .io_east_dout(MIDDLEMIDDLE_OV_12_io_east_dout),
    .io_east_dout_v(MIDDLEMIDDLE_OV_12_io_east_dout_v),
    .io_east_dout_r(MIDDLEMIDDLE_OV_12_io_east_dout_r),
    .io_south_dout(MIDDLEMIDDLE_OV_12_io_south_dout),
    .io_south_dout_v(MIDDLEMIDDLE_OV_12_io_south_dout_v),
    .io_south_dout_r(MIDDLEMIDDLE_OV_12_io_south_dout_r),
    .io_west_dout(MIDDLEMIDDLE_OV_12_io_west_dout),
    .io_west_dout_v(MIDDLEMIDDLE_OV_12_io_west_dout_v),
    .io_west_dout_r(MIDDLEMIDDLE_OV_12_io_west_dout_r),
    .io_config_bits(MIDDLEMIDDLE_OV_12_io_config_bits),
    .io_catch_config(MIDDLEMIDDLE_OV_12_io_catch_config)
  );
  ProcessingElement MIDDLEMIDDLE_OV_13 ( // @[OverlayRocc.scala 330:49]
    .clock(MIDDLEMIDDLE_OV_13_clock),
    .reset(MIDDLEMIDDLE_OV_13_reset),
    .io_north_din(MIDDLEMIDDLE_OV_13_io_north_din),
    .io_north_din_v(MIDDLEMIDDLE_OV_13_io_north_din_v),
    .io_north_din_r(MIDDLEMIDDLE_OV_13_io_north_din_r),
    .io_east_din(MIDDLEMIDDLE_OV_13_io_east_din),
    .io_east_din_v(MIDDLEMIDDLE_OV_13_io_east_din_v),
    .io_east_din_r(MIDDLEMIDDLE_OV_13_io_east_din_r),
    .io_south_din(MIDDLEMIDDLE_OV_13_io_south_din),
    .io_south_din_v(MIDDLEMIDDLE_OV_13_io_south_din_v),
    .io_south_din_r(MIDDLEMIDDLE_OV_13_io_south_din_r),
    .io_west_din(MIDDLEMIDDLE_OV_13_io_west_din),
    .io_west_din_v(MIDDLEMIDDLE_OV_13_io_west_din_v),
    .io_west_din_r(MIDDLEMIDDLE_OV_13_io_west_din_r),
    .io_north_dout(MIDDLEMIDDLE_OV_13_io_north_dout),
    .io_north_dout_v(MIDDLEMIDDLE_OV_13_io_north_dout_v),
    .io_north_dout_r(MIDDLEMIDDLE_OV_13_io_north_dout_r),
    .io_east_dout(MIDDLEMIDDLE_OV_13_io_east_dout),
    .io_east_dout_v(MIDDLEMIDDLE_OV_13_io_east_dout_v),
    .io_east_dout_r(MIDDLEMIDDLE_OV_13_io_east_dout_r),
    .io_south_dout(MIDDLEMIDDLE_OV_13_io_south_dout),
    .io_south_dout_v(MIDDLEMIDDLE_OV_13_io_south_dout_v),
    .io_south_dout_r(MIDDLEMIDDLE_OV_13_io_south_dout_r),
    .io_west_dout(MIDDLEMIDDLE_OV_13_io_west_dout),
    .io_west_dout_v(MIDDLEMIDDLE_OV_13_io_west_dout_v),
    .io_west_dout_r(MIDDLEMIDDLE_OV_13_io_west_dout_r),
    .io_config_bits(MIDDLEMIDDLE_OV_13_io_config_bits),
    .io_catch_config(MIDDLEMIDDLE_OV_13_io_catch_config)
  );
  ProcessingElement MIDDLEMIDDLE_OV_14 ( // @[OverlayRocc.scala 330:49]
    .clock(MIDDLEMIDDLE_OV_14_clock),
    .reset(MIDDLEMIDDLE_OV_14_reset),
    .io_north_din(MIDDLEMIDDLE_OV_14_io_north_din),
    .io_north_din_v(MIDDLEMIDDLE_OV_14_io_north_din_v),
    .io_north_din_r(MIDDLEMIDDLE_OV_14_io_north_din_r),
    .io_east_din(MIDDLEMIDDLE_OV_14_io_east_din),
    .io_east_din_v(MIDDLEMIDDLE_OV_14_io_east_din_v),
    .io_east_din_r(MIDDLEMIDDLE_OV_14_io_east_din_r),
    .io_south_din(MIDDLEMIDDLE_OV_14_io_south_din),
    .io_south_din_v(MIDDLEMIDDLE_OV_14_io_south_din_v),
    .io_south_din_r(MIDDLEMIDDLE_OV_14_io_south_din_r),
    .io_west_din(MIDDLEMIDDLE_OV_14_io_west_din),
    .io_west_din_v(MIDDLEMIDDLE_OV_14_io_west_din_v),
    .io_west_din_r(MIDDLEMIDDLE_OV_14_io_west_din_r),
    .io_north_dout(MIDDLEMIDDLE_OV_14_io_north_dout),
    .io_north_dout_v(MIDDLEMIDDLE_OV_14_io_north_dout_v),
    .io_north_dout_r(MIDDLEMIDDLE_OV_14_io_north_dout_r),
    .io_east_dout(MIDDLEMIDDLE_OV_14_io_east_dout),
    .io_east_dout_v(MIDDLEMIDDLE_OV_14_io_east_dout_v),
    .io_east_dout_r(MIDDLEMIDDLE_OV_14_io_east_dout_r),
    .io_south_dout(MIDDLEMIDDLE_OV_14_io_south_dout),
    .io_south_dout_v(MIDDLEMIDDLE_OV_14_io_south_dout_v),
    .io_south_dout_r(MIDDLEMIDDLE_OV_14_io_south_dout_r),
    .io_west_dout(MIDDLEMIDDLE_OV_14_io_west_dout),
    .io_west_dout_v(MIDDLEMIDDLE_OV_14_io_west_dout_v),
    .io_west_dout_r(MIDDLEMIDDLE_OV_14_io_west_dout_r),
    .io_config_bits(MIDDLEMIDDLE_OV_14_io_config_bits),
    .io_catch_config(MIDDLEMIDDLE_OV_14_io_catch_config)
  );
  ProcessingElement MIDDLEMIDDLE_OV_15 ( // @[OverlayRocc.scala 330:49]
    .clock(MIDDLEMIDDLE_OV_15_clock),
    .reset(MIDDLEMIDDLE_OV_15_reset),
    .io_north_din(MIDDLEMIDDLE_OV_15_io_north_din),
    .io_north_din_v(MIDDLEMIDDLE_OV_15_io_north_din_v),
    .io_north_din_r(MIDDLEMIDDLE_OV_15_io_north_din_r),
    .io_east_din(MIDDLEMIDDLE_OV_15_io_east_din),
    .io_east_din_v(MIDDLEMIDDLE_OV_15_io_east_din_v),
    .io_east_din_r(MIDDLEMIDDLE_OV_15_io_east_din_r),
    .io_south_din(MIDDLEMIDDLE_OV_15_io_south_din),
    .io_south_din_v(MIDDLEMIDDLE_OV_15_io_south_din_v),
    .io_south_din_r(MIDDLEMIDDLE_OV_15_io_south_din_r),
    .io_west_din(MIDDLEMIDDLE_OV_15_io_west_din),
    .io_west_din_v(MIDDLEMIDDLE_OV_15_io_west_din_v),
    .io_west_din_r(MIDDLEMIDDLE_OV_15_io_west_din_r),
    .io_north_dout(MIDDLEMIDDLE_OV_15_io_north_dout),
    .io_north_dout_v(MIDDLEMIDDLE_OV_15_io_north_dout_v),
    .io_north_dout_r(MIDDLEMIDDLE_OV_15_io_north_dout_r),
    .io_east_dout(MIDDLEMIDDLE_OV_15_io_east_dout),
    .io_east_dout_v(MIDDLEMIDDLE_OV_15_io_east_dout_v),
    .io_east_dout_r(MIDDLEMIDDLE_OV_15_io_east_dout_r),
    .io_south_dout(MIDDLEMIDDLE_OV_15_io_south_dout),
    .io_south_dout_v(MIDDLEMIDDLE_OV_15_io_south_dout_v),
    .io_south_dout_r(MIDDLEMIDDLE_OV_15_io_south_dout_r),
    .io_west_dout(MIDDLEMIDDLE_OV_15_io_west_dout),
    .io_west_dout_v(MIDDLEMIDDLE_OV_15_io_west_dout_v),
    .io_west_dout_r(MIDDLEMIDDLE_OV_15_io_west_dout_r),
    .io_config_bits(MIDDLEMIDDLE_OV_15_io_config_bits),
    .io_catch_config(MIDDLEMIDDLE_OV_15_io_catch_config)
  );
  ProcessingElement MIDDLESOUTH_OV_3 ( // @[OverlayRocc.scala 379:48]
    .clock(MIDDLESOUTH_OV_3_clock),
    .reset(MIDDLESOUTH_OV_3_reset),
    .io_north_din(MIDDLESOUTH_OV_3_io_north_din),
    .io_north_din_v(MIDDLESOUTH_OV_3_io_north_din_v),
    .io_north_din_r(MIDDLESOUTH_OV_3_io_north_din_r),
    .io_east_din(MIDDLESOUTH_OV_3_io_east_din),
    .io_east_din_v(MIDDLESOUTH_OV_3_io_east_din_v),
    .io_east_din_r(MIDDLESOUTH_OV_3_io_east_din_r),
    .io_south_din(MIDDLESOUTH_OV_3_io_south_din),
    .io_south_din_v(MIDDLESOUTH_OV_3_io_south_din_v),
    .io_south_din_r(MIDDLESOUTH_OV_3_io_south_din_r),
    .io_west_din(MIDDLESOUTH_OV_3_io_west_din),
    .io_west_din_v(MIDDLESOUTH_OV_3_io_west_din_v),
    .io_west_din_r(MIDDLESOUTH_OV_3_io_west_din_r),
    .io_north_dout(MIDDLESOUTH_OV_3_io_north_dout),
    .io_north_dout_v(MIDDLESOUTH_OV_3_io_north_dout_v),
    .io_north_dout_r(MIDDLESOUTH_OV_3_io_north_dout_r),
    .io_east_dout(MIDDLESOUTH_OV_3_io_east_dout),
    .io_east_dout_v(MIDDLESOUTH_OV_3_io_east_dout_v),
    .io_east_dout_r(MIDDLESOUTH_OV_3_io_east_dout_r),
    .io_south_dout(MIDDLESOUTH_OV_3_io_south_dout),
    .io_south_dout_v(MIDDLESOUTH_OV_3_io_south_dout_v),
    .io_south_dout_r(MIDDLESOUTH_OV_3_io_south_dout_r),
    .io_west_dout(MIDDLESOUTH_OV_3_io_west_dout),
    .io_west_dout_v(MIDDLESOUTH_OV_3_io_west_dout_v),
    .io_west_dout_r(MIDDLESOUTH_OV_3_io_west_dout_r),
    .io_config_bits(MIDDLESOUTH_OV_3_io_config_bits),
    .io_catch_config(MIDDLESOUTH_OV_3_io_catch_config)
  );
  ProcessingElement NORTHEAST_OV ( // @[OverlayRocc.scala 432:46]
    .clock(NORTHEAST_OV_clock),
    .reset(NORTHEAST_OV_reset),
    .io_north_din(NORTHEAST_OV_io_north_din),
    .io_north_din_v(NORTHEAST_OV_io_north_din_v),
    .io_north_din_r(NORTHEAST_OV_io_north_din_r),
    .io_east_din(NORTHEAST_OV_io_east_din),
    .io_east_din_v(NORTHEAST_OV_io_east_din_v),
    .io_east_din_r(NORTHEAST_OV_io_east_din_r),
    .io_south_din(NORTHEAST_OV_io_south_din),
    .io_south_din_v(NORTHEAST_OV_io_south_din_v),
    .io_south_din_r(NORTHEAST_OV_io_south_din_r),
    .io_west_din(NORTHEAST_OV_io_west_din),
    .io_west_din_v(NORTHEAST_OV_io_west_din_v),
    .io_west_din_r(NORTHEAST_OV_io_west_din_r),
    .io_north_dout(NORTHEAST_OV_io_north_dout),
    .io_north_dout_v(NORTHEAST_OV_io_north_dout_v),
    .io_north_dout_r(NORTHEAST_OV_io_north_dout_r),
    .io_east_dout(NORTHEAST_OV_io_east_dout),
    .io_east_dout_v(NORTHEAST_OV_io_east_dout_v),
    .io_east_dout_r(NORTHEAST_OV_io_east_dout_r),
    .io_south_dout(NORTHEAST_OV_io_south_dout),
    .io_south_dout_v(NORTHEAST_OV_io_south_dout_v),
    .io_south_dout_r(NORTHEAST_OV_io_south_dout_r),
    .io_west_dout(NORTHEAST_OV_io_west_dout),
    .io_west_dout_v(NORTHEAST_OV_io_west_dout_v),
    .io_west_dout_r(NORTHEAST_OV_io_west_dout_r),
    .io_config_bits(NORTHEAST_OV_io_config_bits),
    .io_catch_config(NORTHEAST_OV_io_catch_config)
  );
  ProcessingElement MIDDLEEAST_OV ( // @[OverlayRocc.scala 481:47]
    .clock(MIDDLEEAST_OV_clock),
    .reset(MIDDLEEAST_OV_reset),
    .io_north_din(MIDDLEEAST_OV_io_north_din),
    .io_north_din_v(MIDDLEEAST_OV_io_north_din_v),
    .io_north_din_r(MIDDLEEAST_OV_io_north_din_r),
    .io_east_din(MIDDLEEAST_OV_io_east_din),
    .io_east_din_v(MIDDLEEAST_OV_io_east_din_v),
    .io_east_din_r(MIDDLEEAST_OV_io_east_din_r),
    .io_south_din(MIDDLEEAST_OV_io_south_din),
    .io_south_din_v(MIDDLEEAST_OV_io_south_din_v),
    .io_south_din_r(MIDDLEEAST_OV_io_south_din_r),
    .io_west_din(MIDDLEEAST_OV_io_west_din),
    .io_west_din_v(MIDDLEEAST_OV_io_west_din_v),
    .io_west_din_r(MIDDLEEAST_OV_io_west_din_r),
    .io_north_dout(MIDDLEEAST_OV_io_north_dout),
    .io_north_dout_v(MIDDLEEAST_OV_io_north_dout_v),
    .io_north_dout_r(MIDDLEEAST_OV_io_north_dout_r),
    .io_east_dout(MIDDLEEAST_OV_io_east_dout),
    .io_east_dout_v(MIDDLEEAST_OV_io_east_dout_v),
    .io_east_dout_r(MIDDLEEAST_OV_io_east_dout_r),
    .io_south_dout(MIDDLEEAST_OV_io_south_dout),
    .io_south_dout_v(MIDDLEEAST_OV_io_south_dout_v),
    .io_south_dout_r(MIDDLEEAST_OV_io_south_dout_r),
    .io_west_dout(MIDDLEEAST_OV_io_west_dout),
    .io_west_dout_v(MIDDLEEAST_OV_io_west_dout_v),
    .io_west_dout_r(MIDDLEEAST_OV_io_west_dout_r),
    .io_config_bits(MIDDLEEAST_OV_io_config_bits),
    .io_catch_config(MIDDLEEAST_OV_io_catch_config)
  );
  ProcessingElement MIDDLEEAST_OV_1 ( // @[OverlayRocc.scala 481:47]
    .clock(MIDDLEEAST_OV_1_clock),
    .reset(MIDDLEEAST_OV_1_reset),
    .io_north_din(MIDDLEEAST_OV_1_io_north_din),
    .io_north_din_v(MIDDLEEAST_OV_1_io_north_din_v),
    .io_north_din_r(MIDDLEEAST_OV_1_io_north_din_r),
    .io_east_din(MIDDLEEAST_OV_1_io_east_din),
    .io_east_din_v(MIDDLEEAST_OV_1_io_east_din_v),
    .io_east_din_r(MIDDLEEAST_OV_1_io_east_din_r),
    .io_south_din(MIDDLEEAST_OV_1_io_south_din),
    .io_south_din_v(MIDDLEEAST_OV_1_io_south_din_v),
    .io_south_din_r(MIDDLEEAST_OV_1_io_south_din_r),
    .io_west_din(MIDDLEEAST_OV_1_io_west_din),
    .io_west_din_v(MIDDLEEAST_OV_1_io_west_din_v),
    .io_west_din_r(MIDDLEEAST_OV_1_io_west_din_r),
    .io_north_dout(MIDDLEEAST_OV_1_io_north_dout),
    .io_north_dout_v(MIDDLEEAST_OV_1_io_north_dout_v),
    .io_north_dout_r(MIDDLEEAST_OV_1_io_north_dout_r),
    .io_east_dout(MIDDLEEAST_OV_1_io_east_dout),
    .io_east_dout_v(MIDDLEEAST_OV_1_io_east_dout_v),
    .io_east_dout_r(MIDDLEEAST_OV_1_io_east_dout_r),
    .io_south_dout(MIDDLEEAST_OV_1_io_south_dout),
    .io_south_dout_v(MIDDLEEAST_OV_1_io_south_dout_v),
    .io_south_dout_r(MIDDLEEAST_OV_1_io_south_dout_r),
    .io_west_dout(MIDDLEEAST_OV_1_io_west_dout),
    .io_west_dout_v(MIDDLEEAST_OV_1_io_west_dout_v),
    .io_west_dout_r(MIDDLEEAST_OV_1_io_west_dout_r),
    .io_config_bits(MIDDLEEAST_OV_1_io_config_bits),
    .io_catch_config(MIDDLEEAST_OV_1_io_catch_config)
  );
  ProcessingElement MIDDLEEAST_OV_2 ( // @[OverlayRocc.scala 481:47]
    .clock(MIDDLEEAST_OV_2_clock),
    .reset(MIDDLEEAST_OV_2_reset),
    .io_north_din(MIDDLEEAST_OV_2_io_north_din),
    .io_north_din_v(MIDDLEEAST_OV_2_io_north_din_v),
    .io_north_din_r(MIDDLEEAST_OV_2_io_north_din_r),
    .io_east_din(MIDDLEEAST_OV_2_io_east_din),
    .io_east_din_v(MIDDLEEAST_OV_2_io_east_din_v),
    .io_east_din_r(MIDDLEEAST_OV_2_io_east_din_r),
    .io_south_din(MIDDLEEAST_OV_2_io_south_din),
    .io_south_din_v(MIDDLEEAST_OV_2_io_south_din_v),
    .io_south_din_r(MIDDLEEAST_OV_2_io_south_din_r),
    .io_west_din(MIDDLEEAST_OV_2_io_west_din),
    .io_west_din_v(MIDDLEEAST_OV_2_io_west_din_v),
    .io_west_din_r(MIDDLEEAST_OV_2_io_west_din_r),
    .io_north_dout(MIDDLEEAST_OV_2_io_north_dout),
    .io_north_dout_v(MIDDLEEAST_OV_2_io_north_dout_v),
    .io_north_dout_r(MIDDLEEAST_OV_2_io_north_dout_r),
    .io_east_dout(MIDDLEEAST_OV_2_io_east_dout),
    .io_east_dout_v(MIDDLEEAST_OV_2_io_east_dout_v),
    .io_east_dout_r(MIDDLEEAST_OV_2_io_east_dout_r),
    .io_south_dout(MIDDLEEAST_OV_2_io_south_dout),
    .io_south_dout_v(MIDDLEEAST_OV_2_io_south_dout_v),
    .io_south_dout_r(MIDDLEEAST_OV_2_io_south_dout_r),
    .io_west_dout(MIDDLEEAST_OV_2_io_west_dout),
    .io_west_dout_v(MIDDLEEAST_OV_2_io_west_dout_v),
    .io_west_dout_r(MIDDLEEAST_OV_2_io_west_dout_r),
    .io_config_bits(MIDDLEEAST_OV_2_io_config_bits),
    .io_catch_config(MIDDLEEAST_OV_2_io_catch_config)
  );
  ProcessingElement MIDDLEEAST_OV_3 ( // @[OverlayRocc.scala 481:47]
    .clock(MIDDLEEAST_OV_3_clock),
    .reset(MIDDLEEAST_OV_3_reset),
    .io_north_din(MIDDLEEAST_OV_3_io_north_din),
    .io_north_din_v(MIDDLEEAST_OV_3_io_north_din_v),
    .io_north_din_r(MIDDLEEAST_OV_3_io_north_din_r),
    .io_east_din(MIDDLEEAST_OV_3_io_east_din),
    .io_east_din_v(MIDDLEEAST_OV_3_io_east_din_v),
    .io_east_din_r(MIDDLEEAST_OV_3_io_east_din_r),
    .io_south_din(MIDDLEEAST_OV_3_io_south_din),
    .io_south_din_v(MIDDLEEAST_OV_3_io_south_din_v),
    .io_south_din_r(MIDDLEEAST_OV_3_io_south_din_r),
    .io_west_din(MIDDLEEAST_OV_3_io_west_din),
    .io_west_din_v(MIDDLEEAST_OV_3_io_west_din_v),
    .io_west_din_r(MIDDLEEAST_OV_3_io_west_din_r),
    .io_north_dout(MIDDLEEAST_OV_3_io_north_dout),
    .io_north_dout_v(MIDDLEEAST_OV_3_io_north_dout_v),
    .io_north_dout_r(MIDDLEEAST_OV_3_io_north_dout_r),
    .io_east_dout(MIDDLEEAST_OV_3_io_east_dout),
    .io_east_dout_v(MIDDLEEAST_OV_3_io_east_dout_v),
    .io_east_dout_r(MIDDLEEAST_OV_3_io_east_dout_r),
    .io_south_dout(MIDDLEEAST_OV_3_io_south_dout),
    .io_south_dout_v(MIDDLEEAST_OV_3_io_south_dout_v),
    .io_south_dout_r(MIDDLEEAST_OV_3_io_south_dout_r),
    .io_west_dout(MIDDLEEAST_OV_3_io_west_dout),
    .io_west_dout_v(MIDDLEEAST_OV_3_io_west_dout_v),
    .io_west_dout_r(MIDDLEEAST_OV_3_io_west_dout_r),
    .io_config_bits(MIDDLEEAST_OV_3_io_config_bits),
    .io_catch_config(MIDDLEEAST_OV_3_io_catch_config)
  );
  ProcessingElement MIDDLESOUTH_OV_4 ( // @[OverlayRocc.scala 530:48]
    .clock(MIDDLESOUTH_OV_4_clock),
    .reset(MIDDLESOUTH_OV_4_reset),
    .io_north_din(MIDDLESOUTH_OV_4_io_north_din),
    .io_north_din_v(MIDDLESOUTH_OV_4_io_north_din_v),
    .io_north_din_r(MIDDLESOUTH_OV_4_io_north_din_r),
    .io_east_din(MIDDLESOUTH_OV_4_io_east_din),
    .io_east_din_v(MIDDLESOUTH_OV_4_io_east_din_v),
    .io_east_din_r(MIDDLESOUTH_OV_4_io_east_din_r),
    .io_south_din(MIDDLESOUTH_OV_4_io_south_din),
    .io_south_din_v(MIDDLESOUTH_OV_4_io_south_din_v),
    .io_south_din_r(MIDDLESOUTH_OV_4_io_south_din_r),
    .io_west_din(MIDDLESOUTH_OV_4_io_west_din),
    .io_west_din_v(MIDDLESOUTH_OV_4_io_west_din_v),
    .io_west_din_r(MIDDLESOUTH_OV_4_io_west_din_r),
    .io_north_dout(MIDDLESOUTH_OV_4_io_north_dout),
    .io_north_dout_v(MIDDLESOUTH_OV_4_io_north_dout_v),
    .io_north_dout_r(MIDDLESOUTH_OV_4_io_north_dout_r),
    .io_east_dout(MIDDLESOUTH_OV_4_io_east_dout),
    .io_east_dout_v(MIDDLESOUTH_OV_4_io_east_dout_v),
    .io_east_dout_r(MIDDLESOUTH_OV_4_io_east_dout_r),
    .io_south_dout(MIDDLESOUTH_OV_4_io_south_dout),
    .io_south_dout_v(MIDDLESOUTH_OV_4_io_south_dout_v),
    .io_south_dout_r(MIDDLESOUTH_OV_4_io_south_dout_r),
    .io_west_dout(MIDDLESOUTH_OV_4_io_west_dout),
    .io_west_dout_v(MIDDLESOUTH_OV_4_io_west_dout_v),
    .io_west_dout_r(MIDDLESOUTH_OV_4_io_west_dout_r),
    .io_config_bits(MIDDLESOUTH_OV_4_io_config_bits),
    .io_catch_config(MIDDLESOUTH_OV_4_io_catch_config)
  );
  assign io_data_in_ready = {io_data_in_ready_hi,io_data_in_ready_lo}; // @[OverlayRocc.scala 112:43]
  assign io_data_out = {io_data_out_hi,io_data_out_lo}; // @[OverlayRocc.scala 588:33]
  assign io_data_out_valid = {io_data_out_valid_hi,io_data_out_valid_lo}; // @[OverlayRocc.scala 589:45]
  assign NORTHWEST_OV_clock = clock;
  assign NORTHWEST_OV_reset = reset;
  assign NORTHWEST_OV_io_north_din = io_data_in[31:0]; // @[OverlayRocc.scala 106:74]
  assign NORTHWEST_OV_io_north_din_v = io_data_in_valid[0]; // @[OverlayRocc.scala 107:43]
  assign NORTHWEST_OV_io_east_din = MIDDLENORTH_OV_io_west_dout; // @[OverlayRocc.scala 319:44 70:68]
  assign NORTHWEST_OV_io_east_din_v = MIDDLENORTH_OV_io_west_dout_v; // @[OverlayRocc.scala 320:45 73:69]
  assign NORTHWEST_OV_io_south_din = MIDWEST_OV_io_north_dout; // @[OverlayRocc.scala 202:44 80:69]
  assign NORTHWEST_OV_io_south_din_v = MIDWEST_OV_io_north_dout_v; // @[OverlayRocc.scala 203:45 83:69]
  assign NORTHWEST_OV_io_west_din = 32'sh0; // @[OverlayRocc.scala 148:46]
  assign NORTHWEST_OV_io_west_din_v = 1'h0; // @[OverlayRocc.scala 149:48]
  assign NORTHWEST_OV_io_north_dout_r = 1'h0; // @[OverlayRocc.scala 155:50]
  assign NORTHWEST_OV_io_east_dout_r = MIDDLENORTH_OV_io_west_din_r; // @[OverlayRocc.scala 301:45 77:69]
  assign NORTHWEST_OV_io_south_dout_r = MIDWEST_OV_io_north_din_r; // @[OverlayRocc.scala 184:45 87:69]
  assign NORTHWEST_OV_io_west_dout_r = 1'h0; // @[OverlayRocc.scala 170:49]
  assign NORTHWEST_OV_io_config_bits = io_cell_config[181:0]; // @[OverlayRocc.scala 95:34]
  assign NORTHWEST_OV_io_catch_config = io_cell_config[191] & _GEN_0; // @[OverlayRocc.scala 101:39 98:25]
  assign MIDWEST_OV_clock = clock;
  assign MIDWEST_OV_reset = reset;
  assign MIDWEST_OV_io_north_din = NORTHWEST_OV_io_south_dout; // @[OverlayRocc.scala 163:42 81:69]
  assign MIDWEST_OV_io_north_din_v = NORTHWEST_OV_io_south_dout_v; // @[OverlayRocc.scala 164:43 84:69]
  assign MIDWEST_OV_io_east_din = MIDDLEMIDDLE_OV_io_west_dout; // @[OverlayRocc.scala 368:44 70:68]
  assign MIDWEST_OV_io_east_din_v = MIDDLEMIDDLE_OV_io_west_dout_v; // @[OverlayRocc.scala 369:45 73:69]
  assign MIDWEST_OV_io_south_din = MIDWEST_OV_1_io_north_dout; // @[OverlayRocc.scala 202:44 80:69]
  assign MIDWEST_OV_io_south_din_v = MIDWEST_OV_1_io_north_dout_v; // @[OverlayRocc.scala 203:45 83:69]
  assign MIDWEST_OV_io_west_din = 32'sh0; // @[OverlayRocc.scala 197:44]
  assign MIDWEST_OV_io_west_din_v = 1'h0; // @[OverlayRocc.scala 198:46]
  assign MIDWEST_OV_io_north_dout_r = NORTHWEST_OV_io_south_din_r; // @[OverlayRocc.scala 145:43 86:69]
  assign MIDWEST_OV_io_east_dout_r = MIDDLEMIDDLE_OV_io_west_din_r; // @[OverlayRocc.scala 350:45 77:69]
  assign MIDWEST_OV_io_south_dout_r = MIDWEST_OV_1_io_north_din_r; // @[OverlayRocc.scala 184:45 87:69]
  assign MIDWEST_OV_io_west_dout_r = 1'h0; // @[OverlayRocc.scala 219:47]
  assign MIDWEST_OV_io_config_bits = io_cell_config[181:0]; // @[OverlayRocc.scala 95:34]
  assign MIDWEST_OV_io_catch_config = io_cell_config[191] & _GEN_6; // @[OverlayRocc.scala 101:39 98:25]
  assign MIDWEST_OV_1_clock = clock;
  assign MIDWEST_OV_1_reset = reset;
  assign MIDWEST_OV_1_io_north_din = MIDWEST_OV_io_south_dout; // @[OverlayRocc.scala 212:42 81:69]
  assign MIDWEST_OV_1_io_north_din_v = MIDWEST_OV_io_south_dout_v; // @[OverlayRocc.scala 213:43 84:69]
  assign MIDWEST_OV_1_io_east_din = MIDDLEMIDDLE_OV_1_io_west_dout; // @[OverlayRocc.scala 368:44 70:68]
  assign MIDWEST_OV_1_io_east_din_v = MIDDLEMIDDLE_OV_1_io_west_dout_v; // @[OverlayRocc.scala 369:45 73:69]
  assign MIDWEST_OV_1_io_south_din = MIDWEST_OV_2_io_north_dout; // @[OverlayRocc.scala 202:44 80:69]
  assign MIDWEST_OV_1_io_south_din_v = MIDWEST_OV_2_io_north_dout_v; // @[OverlayRocc.scala 203:45 83:69]
  assign MIDWEST_OV_1_io_west_din = 32'sh0; // @[OverlayRocc.scala 197:44]
  assign MIDWEST_OV_1_io_west_din_v = 1'h0; // @[OverlayRocc.scala 198:46]
  assign MIDWEST_OV_1_io_north_dout_r = MIDWEST_OV_io_south_din_r; // @[OverlayRocc.scala 194:43 86:69]
  assign MIDWEST_OV_1_io_east_dout_r = MIDDLEMIDDLE_OV_1_io_west_din_r; // @[OverlayRocc.scala 350:45 77:69]
  assign MIDWEST_OV_1_io_south_dout_r = MIDWEST_OV_2_io_north_din_r; // @[OverlayRocc.scala 184:45 87:69]
  assign MIDWEST_OV_1_io_west_dout_r = 1'h0; // @[OverlayRocc.scala 219:47]
  assign MIDWEST_OV_1_io_config_bits = io_cell_config[181:0]; // @[OverlayRocc.scala 95:34]
  assign MIDWEST_OV_1_io_catch_config = io_cell_config[191] & _GEN_12; // @[OverlayRocc.scala 101:39 98:25]
  assign MIDWEST_OV_2_clock = clock;
  assign MIDWEST_OV_2_reset = reset;
  assign MIDWEST_OV_2_io_north_din = MIDWEST_OV_1_io_south_dout; // @[OverlayRocc.scala 212:42 81:69]
  assign MIDWEST_OV_2_io_north_din_v = MIDWEST_OV_1_io_south_dout_v; // @[OverlayRocc.scala 213:43 84:69]
  assign MIDWEST_OV_2_io_east_din = MIDDLEMIDDLE_OV_2_io_west_dout; // @[OverlayRocc.scala 368:44 70:68]
  assign MIDWEST_OV_2_io_east_din_v = MIDDLEMIDDLE_OV_2_io_west_dout_v; // @[OverlayRocc.scala 369:45 73:69]
  assign MIDWEST_OV_2_io_south_din = MIDWEST_OV_3_io_north_dout; // @[OverlayRocc.scala 202:44 80:69]
  assign MIDWEST_OV_2_io_south_din_v = MIDWEST_OV_3_io_north_dout_v; // @[OverlayRocc.scala 203:45 83:69]
  assign MIDWEST_OV_2_io_west_din = 32'sh0; // @[OverlayRocc.scala 197:44]
  assign MIDWEST_OV_2_io_west_din_v = 1'h0; // @[OverlayRocc.scala 198:46]
  assign MIDWEST_OV_2_io_north_dout_r = MIDWEST_OV_1_io_south_din_r; // @[OverlayRocc.scala 194:43 86:69]
  assign MIDWEST_OV_2_io_east_dout_r = MIDDLEMIDDLE_OV_2_io_west_din_r; // @[OverlayRocc.scala 350:45 77:69]
  assign MIDWEST_OV_2_io_south_dout_r = MIDWEST_OV_3_io_north_din_r; // @[OverlayRocc.scala 184:45 87:69]
  assign MIDWEST_OV_2_io_west_dout_r = 1'h0; // @[OverlayRocc.scala 219:47]
  assign MIDWEST_OV_2_io_config_bits = io_cell_config[181:0]; // @[OverlayRocc.scala 95:34]
  assign MIDWEST_OV_2_io_catch_config = io_cell_config[191] & _GEN_18; // @[OverlayRocc.scala 101:39 98:25]
  assign MIDWEST_OV_3_clock = clock;
  assign MIDWEST_OV_3_reset = reset;
  assign MIDWEST_OV_3_io_north_din = MIDWEST_OV_2_io_south_dout; // @[OverlayRocc.scala 212:42 81:69]
  assign MIDWEST_OV_3_io_north_din_v = MIDWEST_OV_2_io_south_dout_v; // @[OverlayRocc.scala 213:43 84:69]
  assign MIDWEST_OV_3_io_east_din = MIDDLEMIDDLE_OV_3_io_west_dout; // @[OverlayRocc.scala 368:44 70:68]
  assign MIDWEST_OV_3_io_east_din_v = MIDDLEMIDDLE_OV_3_io_west_dout_v; // @[OverlayRocc.scala 369:45 73:69]
  assign MIDWEST_OV_3_io_south_din = SOUTHWEST_OV_io_north_dout; // @[OverlayRocc.scala 251:44 80:69]
  assign MIDWEST_OV_3_io_south_din_v = SOUTHWEST_OV_io_north_dout_v; // @[OverlayRocc.scala 252:45 83:69]
  assign MIDWEST_OV_3_io_west_din = 32'sh0; // @[OverlayRocc.scala 197:44]
  assign MIDWEST_OV_3_io_west_din_v = 1'h0; // @[OverlayRocc.scala 198:46]
  assign MIDWEST_OV_3_io_north_dout_r = MIDWEST_OV_2_io_south_din_r; // @[OverlayRocc.scala 194:43 86:69]
  assign MIDWEST_OV_3_io_east_dout_r = MIDDLEMIDDLE_OV_3_io_west_din_r; // @[OverlayRocc.scala 350:45 77:69]
  assign MIDWEST_OV_3_io_south_dout_r = SOUTHWEST_OV_io_north_din_r; // @[OverlayRocc.scala 233:45 87:69]
  assign MIDWEST_OV_3_io_west_dout_r = 1'h0; // @[OverlayRocc.scala 219:47]
  assign MIDWEST_OV_3_io_config_bits = io_cell_config[181:0]; // @[OverlayRocc.scala 95:34]
  assign MIDWEST_OV_3_io_catch_config = io_cell_config[191] & _GEN_24; // @[OverlayRocc.scala 101:39 98:25]
  assign SOUTHWEST_OV_clock = clock;
  assign SOUTHWEST_OV_reset = reset;
  assign SOUTHWEST_OV_io_north_din = MIDWEST_OV_3_io_south_dout; // @[OverlayRocc.scala 212:42 81:69]
  assign SOUTHWEST_OV_io_north_din_v = MIDWEST_OV_3_io_south_dout_v; // @[OverlayRocc.scala 213:43 84:69]
  assign SOUTHWEST_OV_io_east_din = MIDDLESOUTH_OV_io_west_dout; // @[OverlayRocc.scala 417:44 70:68]
  assign SOUTHWEST_OV_io_east_din_v = MIDDLESOUTH_OV_io_west_dout_v; // @[OverlayRocc.scala 418:45 73:69]
  assign SOUTHWEST_OV_io_south_din = 32'sh0; // @[OverlayRocc.scala 241:47]
  assign SOUTHWEST_OV_io_south_din_v = 1'h0; // @[OverlayRocc.scala 242:49]
  assign SOUTHWEST_OV_io_west_din = 32'sh0; // @[OverlayRocc.scala 246:46]
  assign SOUTHWEST_OV_io_west_din_v = 1'h0; // @[OverlayRocc.scala 247:48]
  assign SOUTHWEST_OV_io_north_dout_r = MIDWEST_OV_3_io_south_din_r; // @[OverlayRocc.scala 194:43 86:69]
  assign SOUTHWEST_OV_io_east_dout_r = MIDDLESOUTH_OV_io_west_din_r; // @[OverlayRocc.scala 399:45 77:69]
  assign SOUTHWEST_OV_io_south_dout_r = 1'h0; // @[OverlayRocc.scala 263:50]
  assign SOUTHWEST_OV_io_west_dout_r = 1'h0; // @[OverlayRocc.scala 268:49]
  assign SOUTHWEST_OV_io_config_bits = io_cell_config[181:0]; // @[OverlayRocc.scala 95:34]
  assign SOUTHWEST_OV_io_catch_config = io_cell_config[191] & _GEN_30; // @[OverlayRocc.scala 101:39 98:25]
  assign MIDDLENORTH_OV_clock = clock;
  assign MIDDLENORTH_OV_reset = reset;
  assign MIDDLENORTH_OV_io_north_din = io_data_in[63:32]; // @[OverlayRocc.scala 106:74]
  assign MIDDLENORTH_OV_io_north_din_v = io_data_in_valid[1]; // @[OverlayRocc.scala 107:43]
  assign MIDDLENORTH_OV_io_east_din = MIDDLENORTH_OV_1_io_west_dout; // @[OverlayRocc.scala 319:44 70:68]
  assign MIDDLENORTH_OV_io_east_din_v = MIDDLENORTH_OV_1_io_west_dout_v; // @[OverlayRocc.scala 320:45 73:69]
  assign MIDDLENORTH_OV_io_south_din = MIDDLEMIDDLE_OV_io_north_dout; // @[OverlayRocc.scala 353:44 80:69]
  assign MIDDLENORTH_OV_io_south_din_v = MIDDLEMIDDLE_OV_io_north_dout_v; // @[OverlayRocc.scala 354:45 83:69]
  assign MIDDLENORTH_OV_io_west_din = NORTHWEST_OV_io_east_dout; // @[OverlayRocc.scala 158:42 71:68]
  assign MIDDLENORTH_OV_io_west_din_v = NORTHWEST_OV_io_east_dout_v; // @[OverlayRocc.scala 159:43 74:69]
  assign MIDDLENORTH_OV_io_north_dout_r = 1'h0; // @[OverlayRocc.scala 306:52]
  assign MIDDLENORTH_OV_io_east_dout_r = MIDDLENORTH_OV_1_io_west_din_r; // @[OverlayRocc.scala 301:45 77:69]
  assign MIDDLENORTH_OV_io_south_dout_r = MIDDLEMIDDLE_OV_io_north_din_r; // @[OverlayRocc.scala 335:45 87:69]
  assign MIDDLENORTH_OV_io_west_dout_r = NORTHWEST_OV_io_east_din_r; // @[OverlayRocc.scala 140:43 76:69]
  assign MIDDLENORTH_OV_io_config_bits = io_cell_config[181:0]; // @[OverlayRocc.scala 95:34]
  assign MIDDLENORTH_OV_io_catch_config = io_cell_config[191] & _GEN_1; // @[OverlayRocc.scala 101:39 98:25]
  assign MIDDLEMIDDLE_OV_clock = clock;
  assign MIDDLEMIDDLE_OV_reset = reset;
  assign MIDDLEMIDDLE_OV_io_north_din = MIDDLENORTH_OV_io_south_dout; // @[OverlayRocc.scala 314:42 81:69]
  assign MIDDLEMIDDLE_OV_io_north_din_v = MIDDLENORTH_OV_io_south_dout_v; // @[OverlayRocc.scala 315:43 84:69]
  assign MIDDLEMIDDLE_OV_io_east_din = MIDDLEMIDDLE_OV_4_io_west_dout; // @[OverlayRocc.scala 368:44 70:68]
  assign MIDDLEMIDDLE_OV_io_east_din_v = MIDDLEMIDDLE_OV_4_io_west_dout_v; // @[OverlayRocc.scala 369:45 73:69]
  assign MIDDLEMIDDLE_OV_io_south_din = MIDDLEMIDDLE_OV_1_io_north_dout; // @[OverlayRocc.scala 353:44 80:69]
  assign MIDDLEMIDDLE_OV_io_south_din_v = MIDDLEMIDDLE_OV_1_io_north_dout_v; // @[OverlayRocc.scala 354:45 83:69]
  assign MIDDLEMIDDLE_OV_io_west_din = MIDWEST_OV_io_east_dout; // @[OverlayRocc.scala 207:42 71:68]
  assign MIDDLEMIDDLE_OV_io_west_din_v = MIDWEST_OV_io_east_dout_v; // @[OverlayRocc.scala 208:43 74:69]
  assign MIDDLEMIDDLE_OV_io_north_dout_r = MIDDLENORTH_OV_io_south_din_r; // @[OverlayRocc.scala 296:43 86:69]
  assign MIDDLEMIDDLE_OV_io_east_dout_r = MIDDLEMIDDLE_OV_4_io_west_din_r; // @[OverlayRocc.scala 350:45 77:69]
  assign MIDDLEMIDDLE_OV_io_south_dout_r = MIDDLEMIDDLE_OV_1_io_north_din_r; // @[OverlayRocc.scala 335:45 87:69]
  assign MIDDLEMIDDLE_OV_io_west_dout_r = MIDWEST_OV_io_east_din_r; // @[OverlayRocc.scala 189:43 76:69]
  assign MIDDLEMIDDLE_OV_io_config_bits = io_cell_config[181:0]; // @[OverlayRocc.scala 95:34]
  assign MIDDLEMIDDLE_OV_io_catch_config = io_cell_config[191] & _GEN_7; // @[OverlayRocc.scala 101:39 98:25]
  assign MIDDLEMIDDLE_OV_1_clock = clock;
  assign MIDDLEMIDDLE_OV_1_reset = reset;
  assign MIDDLEMIDDLE_OV_1_io_north_din = MIDDLEMIDDLE_OV_io_south_dout; // @[OverlayRocc.scala 363:42 81:69]
  assign MIDDLEMIDDLE_OV_1_io_north_din_v = MIDDLEMIDDLE_OV_io_south_dout_v; // @[OverlayRocc.scala 364:43 84:69]
  assign MIDDLEMIDDLE_OV_1_io_east_din = MIDDLEMIDDLE_OV_5_io_west_dout; // @[OverlayRocc.scala 368:44 70:68]
  assign MIDDLEMIDDLE_OV_1_io_east_din_v = MIDDLEMIDDLE_OV_5_io_west_dout_v; // @[OverlayRocc.scala 369:45 73:69]
  assign MIDDLEMIDDLE_OV_1_io_south_din = MIDDLEMIDDLE_OV_2_io_north_dout; // @[OverlayRocc.scala 353:44 80:69]
  assign MIDDLEMIDDLE_OV_1_io_south_din_v = MIDDLEMIDDLE_OV_2_io_north_dout_v; // @[OverlayRocc.scala 354:45 83:69]
  assign MIDDLEMIDDLE_OV_1_io_west_din = MIDWEST_OV_1_io_east_dout; // @[OverlayRocc.scala 207:42 71:68]
  assign MIDDLEMIDDLE_OV_1_io_west_din_v = MIDWEST_OV_1_io_east_dout_v; // @[OverlayRocc.scala 208:43 74:69]
  assign MIDDLEMIDDLE_OV_1_io_north_dout_r = MIDDLEMIDDLE_OV_io_south_din_r; // @[OverlayRocc.scala 345:43 86:69]
  assign MIDDLEMIDDLE_OV_1_io_east_dout_r = MIDDLEMIDDLE_OV_5_io_west_din_r; // @[OverlayRocc.scala 350:45 77:69]
  assign MIDDLEMIDDLE_OV_1_io_south_dout_r = MIDDLEMIDDLE_OV_2_io_north_din_r; // @[OverlayRocc.scala 335:45 87:69]
  assign MIDDLEMIDDLE_OV_1_io_west_dout_r = MIDWEST_OV_1_io_east_din_r; // @[OverlayRocc.scala 189:43 76:69]
  assign MIDDLEMIDDLE_OV_1_io_config_bits = io_cell_config[181:0]; // @[OverlayRocc.scala 95:34]
  assign MIDDLEMIDDLE_OV_1_io_catch_config = io_cell_config[191] & _GEN_13; // @[OverlayRocc.scala 101:39 98:25]
  assign MIDDLEMIDDLE_OV_2_clock = clock;
  assign MIDDLEMIDDLE_OV_2_reset = reset;
  assign MIDDLEMIDDLE_OV_2_io_north_din = MIDDLEMIDDLE_OV_1_io_south_dout; // @[OverlayRocc.scala 363:42 81:69]
  assign MIDDLEMIDDLE_OV_2_io_north_din_v = MIDDLEMIDDLE_OV_1_io_south_dout_v; // @[OverlayRocc.scala 364:43 84:69]
  assign MIDDLEMIDDLE_OV_2_io_east_din = MIDDLEMIDDLE_OV_6_io_west_dout; // @[OverlayRocc.scala 368:44 70:68]
  assign MIDDLEMIDDLE_OV_2_io_east_din_v = MIDDLEMIDDLE_OV_6_io_west_dout_v; // @[OverlayRocc.scala 369:45 73:69]
  assign MIDDLEMIDDLE_OV_2_io_south_din = MIDDLEMIDDLE_OV_3_io_north_dout; // @[OverlayRocc.scala 353:44 80:69]
  assign MIDDLEMIDDLE_OV_2_io_south_din_v = MIDDLEMIDDLE_OV_3_io_north_dout_v; // @[OverlayRocc.scala 354:45 83:69]
  assign MIDDLEMIDDLE_OV_2_io_west_din = MIDWEST_OV_2_io_east_dout; // @[OverlayRocc.scala 207:42 71:68]
  assign MIDDLEMIDDLE_OV_2_io_west_din_v = MIDWEST_OV_2_io_east_dout_v; // @[OverlayRocc.scala 208:43 74:69]
  assign MIDDLEMIDDLE_OV_2_io_north_dout_r = MIDDLEMIDDLE_OV_1_io_south_din_r; // @[OverlayRocc.scala 345:43 86:69]
  assign MIDDLEMIDDLE_OV_2_io_east_dout_r = MIDDLEMIDDLE_OV_6_io_west_din_r; // @[OverlayRocc.scala 350:45 77:69]
  assign MIDDLEMIDDLE_OV_2_io_south_dout_r = MIDDLEMIDDLE_OV_3_io_north_din_r; // @[OverlayRocc.scala 335:45 87:69]
  assign MIDDLEMIDDLE_OV_2_io_west_dout_r = MIDWEST_OV_2_io_east_din_r; // @[OverlayRocc.scala 189:43 76:69]
  assign MIDDLEMIDDLE_OV_2_io_config_bits = io_cell_config[181:0]; // @[OverlayRocc.scala 95:34]
  assign MIDDLEMIDDLE_OV_2_io_catch_config = io_cell_config[191] & _GEN_19; // @[OverlayRocc.scala 101:39 98:25]
  assign MIDDLEMIDDLE_OV_3_clock = clock;
  assign MIDDLEMIDDLE_OV_3_reset = reset;
  assign MIDDLEMIDDLE_OV_3_io_north_din = MIDDLEMIDDLE_OV_2_io_south_dout; // @[OverlayRocc.scala 363:42 81:69]
  assign MIDDLEMIDDLE_OV_3_io_north_din_v = MIDDLEMIDDLE_OV_2_io_south_dout_v; // @[OverlayRocc.scala 364:43 84:69]
  assign MIDDLEMIDDLE_OV_3_io_east_din = MIDDLEMIDDLE_OV_7_io_west_dout; // @[OverlayRocc.scala 368:44 70:68]
  assign MIDDLEMIDDLE_OV_3_io_east_din_v = MIDDLEMIDDLE_OV_7_io_west_dout_v; // @[OverlayRocc.scala 369:45 73:69]
  assign MIDDLEMIDDLE_OV_3_io_south_din = MIDDLESOUTH_OV_io_north_dout; // @[OverlayRocc.scala 402:44 80:69]
  assign MIDDLEMIDDLE_OV_3_io_south_din_v = MIDDLESOUTH_OV_io_north_dout_v; // @[OverlayRocc.scala 403:45 83:69]
  assign MIDDLEMIDDLE_OV_3_io_west_din = MIDWEST_OV_3_io_east_dout; // @[OverlayRocc.scala 207:42 71:68]
  assign MIDDLEMIDDLE_OV_3_io_west_din_v = MIDWEST_OV_3_io_east_dout_v; // @[OverlayRocc.scala 208:43 74:69]
  assign MIDDLEMIDDLE_OV_3_io_north_dout_r = MIDDLEMIDDLE_OV_2_io_south_din_r; // @[OverlayRocc.scala 345:43 86:69]
  assign MIDDLEMIDDLE_OV_3_io_east_dout_r = MIDDLEMIDDLE_OV_7_io_west_din_r; // @[OverlayRocc.scala 350:45 77:69]
  assign MIDDLEMIDDLE_OV_3_io_south_dout_r = MIDDLESOUTH_OV_io_north_din_r; // @[OverlayRocc.scala 384:45 87:69]
  assign MIDDLEMIDDLE_OV_3_io_west_dout_r = MIDWEST_OV_3_io_east_din_r; // @[OverlayRocc.scala 189:43 76:69]
  assign MIDDLEMIDDLE_OV_3_io_config_bits = io_cell_config[181:0]; // @[OverlayRocc.scala 95:34]
  assign MIDDLEMIDDLE_OV_3_io_catch_config = io_cell_config[191] & _GEN_25; // @[OverlayRocc.scala 101:39 98:25]
  assign MIDDLESOUTH_OV_clock = clock;
  assign MIDDLESOUTH_OV_reset = reset;
  assign MIDDLESOUTH_OV_io_north_din = MIDDLEMIDDLE_OV_3_io_south_dout; // @[OverlayRocc.scala 363:42 81:69]
  assign MIDDLESOUTH_OV_io_north_din_v = MIDDLEMIDDLE_OV_3_io_south_dout_v; // @[OverlayRocc.scala 364:43 84:69]
  assign MIDDLESOUTH_OV_io_east_din = MIDDLESOUTH_OV_1_io_west_dout; // @[OverlayRocc.scala 417:44 70:68]
  assign MIDDLESOUTH_OV_io_east_din_v = MIDDLESOUTH_OV_1_io_west_dout_v; // @[OverlayRocc.scala 418:45 73:69]
  assign MIDDLESOUTH_OV_io_south_din = 32'sh0; // @[OverlayRocc.scala 392:49]
  assign MIDDLESOUTH_OV_io_south_din_v = 1'h0; // @[OverlayRocc.scala 393:51]
  assign MIDDLESOUTH_OV_io_west_din = SOUTHWEST_OV_io_east_dout; // @[OverlayRocc.scala 256:42 71:68]
  assign MIDDLESOUTH_OV_io_west_din_v = SOUTHWEST_OV_io_east_dout_v; // @[OverlayRocc.scala 257:43 74:69]
  assign MIDDLESOUTH_OV_io_north_dout_r = MIDDLEMIDDLE_OV_3_io_south_din_r; // @[OverlayRocc.scala 345:43 86:69]
  assign MIDDLESOUTH_OV_io_east_dout_r = MIDDLESOUTH_OV_1_io_west_din_r; // @[OverlayRocc.scala 399:45 77:69]
  assign MIDDLESOUTH_OV_io_south_dout_r = 1'h0; // @[OverlayRocc.scala 414:52]
  assign MIDDLESOUTH_OV_io_west_dout_r = SOUTHWEST_OV_io_east_din_r; // @[OverlayRocc.scala 238:43 76:69]
  assign MIDDLESOUTH_OV_io_config_bits = io_cell_config[181:0]; // @[OverlayRocc.scala 95:34]
  assign MIDDLESOUTH_OV_io_catch_config = io_cell_config[191] & _GEN_31; // @[OverlayRocc.scala 101:39 98:25]
  assign MIDDLENORTH_OV_1_clock = clock;
  assign MIDDLENORTH_OV_1_reset = reset;
  assign MIDDLENORTH_OV_1_io_north_din = io_data_in[95:64]; // @[OverlayRocc.scala 106:74]
  assign MIDDLENORTH_OV_1_io_north_din_v = io_data_in_valid[2]; // @[OverlayRocc.scala 107:43]
  assign MIDDLENORTH_OV_1_io_east_din = MIDDLENORTH_OV_2_io_west_dout; // @[OverlayRocc.scala 319:44 70:68]
  assign MIDDLENORTH_OV_1_io_east_din_v = MIDDLENORTH_OV_2_io_west_dout_v; // @[OverlayRocc.scala 320:45 73:69]
  assign MIDDLENORTH_OV_1_io_south_din = MIDDLEMIDDLE_OV_4_io_north_dout; // @[OverlayRocc.scala 353:44 80:69]
  assign MIDDLENORTH_OV_1_io_south_din_v = MIDDLEMIDDLE_OV_4_io_north_dout_v; // @[OverlayRocc.scala 354:45 83:69]
  assign MIDDLENORTH_OV_1_io_west_din = MIDDLENORTH_OV_io_east_dout; // @[OverlayRocc.scala 309:42 71:68]
  assign MIDDLENORTH_OV_1_io_west_din_v = MIDDLENORTH_OV_io_east_dout_v; // @[OverlayRocc.scala 310:43 74:69]
  assign MIDDLENORTH_OV_1_io_north_dout_r = 1'h0; // @[OverlayRocc.scala 306:52]
  assign MIDDLENORTH_OV_1_io_east_dout_r = MIDDLENORTH_OV_2_io_west_din_r; // @[OverlayRocc.scala 301:45 77:69]
  assign MIDDLENORTH_OV_1_io_south_dout_r = MIDDLEMIDDLE_OV_4_io_north_din_r; // @[OverlayRocc.scala 335:45 87:69]
  assign MIDDLENORTH_OV_1_io_west_dout_r = MIDDLENORTH_OV_io_east_din_r; // @[OverlayRocc.scala 291:43 76:69]
  assign MIDDLENORTH_OV_1_io_config_bits = io_cell_config[181:0]; // @[OverlayRocc.scala 95:34]
  assign MIDDLENORTH_OV_1_io_catch_config = io_cell_config[191] & _GEN_2; // @[OverlayRocc.scala 101:39 98:25]
  assign MIDDLEMIDDLE_OV_4_clock = clock;
  assign MIDDLEMIDDLE_OV_4_reset = reset;
  assign MIDDLEMIDDLE_OV_4_io_north_din = MIDDLENORTH_OV_1_io_south_dout; // @[OverlayRocc.scala 314:42 81:69]
  assign MIDDLEMIDDLE_OV_4_io_north_din_v = MIDDLENORTH_OV_1_io_south_dout_v; // @[OverlayRocc.scala 315:43 84:69]
  assign MIDDLEMIDDLE_OV_4_io_east_din = MIDDLEMIDDLE_OV_8_io_west_dout; // @[OverlayRocc.scala 368:44 70:68]
  assign MIDDLEMIDDLE_OV_4_io_east_din_v = MIDDLEMIDDLE_OV_8_io_west_dout_v; // @[OverlayRocc.scala 369:45 73:69]
  assign MIDDLEMIDDLE_OV_4_io_south_din = MIDDLEMIDDLE_OV_5_io_north_dout; // @[OverlayRocc.scala 353:44 80:69]
  assign MIDDLEMIDDLE_OV_4_io_south_din_v = MIDDLEMIDDLE_OV_5_io_north_dout_v; // @[OverlayRocc.scala 354:45 83:69]
  assign MIDDLEMIDDLE_OV_4_io_west_din = MIDDLEMIDDLE_OV_io_east_dout; // @[OverlayRocc.scala 358:42 71:68]
  assign MIDDLEMIDDLE_OV_4_io_west_din_v = MIDDLEMIDDLE_OV_io_east_dout_v; // @[OverlayRocc.scala 359:43 74:69]
  assign MIDDLEMIDDLE_OV_4_io_north_dout_r = MIDDLENORTH_OV_1_io_south_din_r; // @[OverlayRocc.scala 296:43 86:69]
  assign MIDDLEMIDDLE_OV_4_io_east_dout_r = MIDDLEMIDDLE_OV_8_io_west_din_r; // @[OverlayRocc.scala 350:45 77:69]
  assign MIDDLEMIDDLE_OV_4_io_south_dout_r = MIDDLEMIDDLE_OV_5_io_north_din_r; // @[OverlayRocc.scala 335:45 87:69]
  assign MIDDLEMIDDLE_OV_4_io_west_dout_r = MIDDLEMIDDLE_OV_io_east_din_r; // @[OverlayRocc.scala 340:43 76:69]
  assign MIDDLEMIDDLE_OV_4_io_config_bits = io_cell_config[181:0]; // @[OverlayRocc.scala 95:34]
  assign MIDDLEMIDDLE_OV_4_io_catch_config = io_cell_config[191] & _GEN_8; // @[OverlayRocc.scala 101:39 98:25]
  assign MIDDLEMIDDLE_OV_5_clock = clock;
  assign MIDDLEMIDDLE_OV_5_reset = reset;
  assign MIDDLEMIDDLE_OV_5_io_north_din = MIDDLEMIDDLE_OV_4_io_south_dout; // @[OverlayRocc.scala 363:42 81:69]
  assign MIDDLEMIDDLE_OV_5_io_north_din_v = MIDDLEMIDDLE_OV_4_io_south_dout_v; // @[OverlayRocc.scala 364:43 84:69]
  assign MIDDLEMIDDLE_OV_5_io_east_din = MIDDLEMIDDLE_OV_9_io_west_dout; // @[OverlayRocc.scala 368:44 70:68]
  assign MIDDLEMIDDLE_OV_5_io_east_din_v = MIDDLEMIDDLE_OV_9_io_west_dout_v; // @[OverlayRocc.scala 369:45 73:69]
  assign MIDDLEMIDDLE_OV_5_io_south_din = MIDDLEMIDDLE_OV_6_io_north_dout; // @[OverlayRocc.scala 353:44 80:69]
  assign MIDDLEMIDDLE_OV_5_io_south_din_v = MIDDLEMIDDLE_OV_6_io_north_dout_v; // @[OverlayRocc.scala 354:45 83:69]
  assign MIDDLEMIDDLE_OV_5_io_west_din = MIDDLEMIDDLE_OV_1_io_east_dout; // @[OverlayRocc.scala 358:42 71:68]
  assign MIDDLEMIDDLE_OV_5_io_west_din_v = MIDDLEMIDDLE_OV_1_io_east_dout_v; // @[OverlayRocc.scala 359:43 74:69]
  assign MIDDLEMIDDLE_OV_5_io_north_dout_r = MIDDLEMIDDLE_OV_4_io_south_din_r; // @[OverlayRocc.scala 345:43 86:69]
  assign MIDDLEMIDDLE_OV_5_io_east_dout_r = MIDDLEMIDDLE_OV_9_io_west_din_r; // @[OverlayRocc.scala 350:45 77:69]
  assign MIDDLEMIDDLE_OV_5_io_south_dout_r = MIDDLEMIDDLE_OV_6_io_north_din_r; // @[OverlayRocc.scala 335:45 87:69]
  assign MIDDLEMIDDLE_OV_5_io_west_dout_r = MIDDLEMIDDLE_OV_1_io_east_din_r; // @[OverlayRocc.scala 340:43 76:69]
  assign MIDDLEMIDDLE_OV_5_io_config_bits = io_cell_config[181:0]; // @[OverlayRocc.scala 95:34]
  assign MIDDLEMIDDLE_OV_5_io_catch_config = io_cell_config[191] & _GEN_14; // @[OverlayRocc.scala 101:39 98:25]
  assign MIDDLEMIDDLE_OV_6_clock = clock;
  assign MIDDLEMIDDLE_OV_6_reset = reset;
  assign MIDDLEMIDDLE_OV_6_io_north_din = MIDDLEMIDDLE_OV_5_io_south_dout; // @[OverlayRocc.scala 363:42 81:69]
  assign MIDDLEMIDDLE_OV_6_io_north_din_v = MIDDLEMIDDLE_OV_5_io_south_dout_v; // @[OverlayRocc.scala 364:43 84:69]
  assign MIDDLEMIDDLE_OV_6_io_east_din = MIDDLEMIDDLE_OV_10_io_west_dout; // @[OverlayRocc.scala 368:44 70:68]
  assign MIDDLEMIDDLE_OV_6_io_east_din_v = MIDDLEMIDDLE_OV_10_io_west_dout_v; // @[OverlayRocc.scala 369:45 73:69]
  assign MIDDLEMIDDLE_OV_6_io_south_din = MIDDLEMIDDLE_OV_7_io_north_dout; // @[OverlayRocc.scala 353:44 80:69]
  assign MIDDLEMIDDLE_OV_6_io_south_din_v = MIDDLEMIDDLE_OV_7_io_north_dout_v; // @[OverlayRocc.scala 354:45 83:69]
  assign MIDDLEMIDDLE_OV_6_io_west_din = MIDDLEMIDDLE_OV_2_io_east_dout; // @[OverlayRocc.scala 358:42 71:68]
  assign MIDDLEMIDDLE_OV_6_io_west_din_v = MIDDLEMIDDLE_OV_2_io_east_dout_v; // @[OverlayRocc.scala 359:43 74:69]
  assign MIDDLEMIDDLE_OV_6_io_north_dout_r = MIDDLEMIDDLE_OV_5_io_south_din_r; // @[OverlayRocc.scala 345:43 86:69]
  assign MIDDLEMIDDLE_OV_6_io_east_dout_r = MIDDLEMIDDLE_OV_10_io_west_din_r; // @[OverlayRocc.scala 350:45 77:69]
  assign MIDDLEMIDDLE_OV_6_io_south_dout_r = MIDDLEMIDDLE_OV_7_io_north_din_r; // @[OverlayRocc.scala 335:45 87:69]
  assign MIDDLEMIDDLE_OV_6_io_west_dout_r = MIDDLEMIDDLE_OV_2_io_east_din_r; // @[OverlayRocc.scala 340:43 76:69]
  assign MIDDLEMIDDLE_OV_6_io_config_bits = io_cell_config[181:0]; // @[OverlayRocc.scala 95:34]
  assign MIDDLEMIDDLE_OV_6_io_catch_config = io_cell_config[191] & _GEN_20; // @[OverlayRocc.scala 101:39 98:25]
  assign MIDDLEMIDDLE_OV_7_clock = clock;
  assign MIDDLEMIDDLE_OV_7_reset = reset;
  assign MIDDLEMIDDLE_OV_7_io_north_din = MIDDLEMIDDLE_OV_6_io_south_dout; // @[OverlayRocc.scala 363:42 81:69]
  assign MIDDLEMIDDLE_OV_7_io_north_din_v = MIDDLEMIDDLE_OV_6_io_south_dout_v; // @[OverlayRocc.scala 364:43 84:69]
  assign MIDDLEMIDDLE_OV_7_io_east_din = MIDDLEMIDDLE_OV_11_io_west_dout; // @[OverlayRocc.scala 368:44 70:68]
  assign MIDDLEMIDDLE_OV_7_io_east_din_v = MIDDLEMIDDLE_OV_11_io_west_dout_v; // @[OverlayRocc.scala 369:45 73:69]
  assign MIDDLEMIDDLE_OV_7_io_south_din = MIDDLESOUTH_OV_1_io_north_dout; // @[OverlayRocc.scala 402:44 80:69]
  assign MIDDLEMIDDLE_OV_7_io_south_din_v = MIDDLESOUTH_OV_1_io_north_dout_v; // @[OverlayRocc.scala 403:45 83:69]
  assign MIDDLEMIDDLE_OV_7_io_west_din = MIDDLEMIDDLE_OV_3_io_east_dout; // @[OverlayRocc.scala 358:42 71:68]
  assign MIDDLEMIDDLE_OV_7_io_west_din_v = MIDDLEMIDDLE_OV_3_io_east_dout_v; // @[OverlayRocc.scala 359:43 74:69]
  assign MIDDLEMIDDLE_OV_7_io_north_dout_r = MIDDLEMIDDLE_OV_6_io_south_din_r; // @[OverlayRocc.scala 345:43 86:69]
  assign MIDDLEMIDDLE_OV_7_io_east_dout_r = MIDDLEMIDDLE_OV_11_io_west_din_r; // @[OverlayRocc.scala 350:45 77:69]
  assign MIDDLEMIDDLE_OV_7_io_south_dout_r = MIDDLESOUTH_OV_1_io_north_din_r; // @[OverlayRocc.scala 384:45 87:69]
  assign MIDDLEMIDDLE_OV_7_io_west_dout_r = MIDDLEMIDDLE_OV_3_io_east_din_r; // @[OverlayRocc.scala 340:43 76:69]
  assign MIDDLEMIDDLE_OV_7_io_config_bits = io_cell_config[181:0]; // @[OverlayRocc.scala 95:34]
  assign MIDDLEMIDDLE_OV_7_io_catch_config = io_cell_config[191] & _GEN_26; // @[OverlayRocc.scala 101:39 98:25]
  assign MIDDLESOUTH_OV_1_clock = clock;
  assign MIDDLESOUTH_OV_1_reset = reset;
  assign MIDDLESOUTH_OV_1_io_north_din = MIDDLEMIDDLE_OV_7_io_south_dout; // @[OverlayRocc.scala 363:42 81:69]
  assign MIDDLESOUTH_OV_1_io_north_din_v = MIDDLEMIDDLE_OV_7_io_south_dout_v; // @[OverlayRocc.scala 364:43 84:69]
  assign MIDDLESOUTH_OV_1_io_east_din = MIDDLESOUTH_OV_2_io_west_dout; // @[OverlayRocc.scala 417:44 70:68]
  assign MIDDLESOUTH_OV_1_io_east_din_v = MIDDLESOUTH_OV_2_io_west_dout_v; // @[OverlayRocc.scala 418:45 73:69]
  assign MIDDLESOUTH_OV_1_io_south_din = 32'sh0; // @[OverlayRocc.scala 392:49]
  assign MIDDLESOUTH_OV_1_io_south_din_v = 1'h0; // @[OverlayRocc.scala 393:51]
  assign MIDDLESOUTH_OV_1_io_west_din = MIDDLESOUTH_OV_io_east_dout; // @[OverlayRocc.scala 407:42 71:68]
  assign MIDDLESOUTH_OV_1_io_west_din_v = MIDDLESOUTH_OV_io_east_dout_v; // @[OverlayRocc.scala 408:43 74:69]
  assign MIDDLESOUTH_OV_1_io_north_dout_r = MIDDLEMIDDLE_OV_7_io_south_din_r; // @[OverlayRocc.scala 345:43 86:69]
  assign MIDDLESOUTH_OV_1_io_east_dout_r = MIDDLESOUTH_OV_2_io_west_din_r; // @[OverlayRocc.scala 399:45 77:69]
  assign MIDDLESOUTH_OV_1_io_south_dout_r = 1'h0; // @[OverlayRocc.scala 414:52]
  assign MIDDLESOUTH_OV_1_io_west_dout_r = MIDDLESOUTH_OV_io_east_din_r; // @[OverlayRocc.scala 389:43 76:69]
  assign MIDDLESOUTH_OV_1_io_config_bits = io_cell_config[181:0]; // @[OverlayRocc.scala 95:34]
  assign MIDDLESOUTH_OV_1_io_catch_config = io_cell_config[191] & _GEN_32; // @[OverlayRocc.scala 101:39 98:25]
  assign MIDDLENORTH_OV_2_clock = clock;
  assign MIDDLENORTH_OV_2_reset = reset;
  assign MIDDLENORTH_OV_2_io_north_din = io_data_in[127:96]; // @[OverlayRocc.scala 106:74]
  assign MIDDLENORTH_OV_2_io_north_din_v = io_data_in_valid[3]; // @[OverlayRocc.scala 107:43]
  assign MIDDLENORTH_OV_2_io_east_din = MIDDLENORTH_OV_3_io_west_dout; // @[OverlayRocc.scala 319:44 70:68]
  assign MIDDLENORTH_OV_2_io_east_din_v = MIDDLENORTH_OV_3_io_west_dout_v; // @[OverlayRocc.scala 320:45 73:69]
  assign MIDDLENORTH_OV_2_io_south_din = MIDDLEMIDDLE_OV_8_io_north_dout; // @[OverlayRocc.scala 353:44 80:69]
  assign MIDDLENORTH_OV_2_io_south_din_v = MIDDLEMIDDLE_OV_8_io_north_dout_v; // @[OverlayRocc.scala 354:45 83:69]
  assign MIDDLENORTH_OV_2_io_west_din = MIDDLENORTH_OV_1_io_east_dout; // @[OverlayRocc.scala 309:42 71:68]
  assign MIDDLENORTH_OV_2_io_west_din_v = MIDDLENORTH_OV_1_io_east_dout_v; // @[OverlayRocc.scala 310:43 74:69]
  assign MIDDLENORTH_OV_2_io_north_dout_r = 1'h0; // @[OverlayRocc.scala 306:52]
  assign MIDDLENORTH_OV_2_io_east_dout_r = MIDDLENORTH_OV_3_io_west_din_r; // @[OverlayRocc.scala 301:45 77:69]
  assign MIDDLENORTH_OV_2_io_south_dout_r = MIDDLEMIDDLE_OV_8_io_north_din_r; // @[OverlayRocc.scala 335:45 87:69]
  assign MIDDLENORTH_OV_2_io_west_dout_r = MIDDLENORTH_OV_1_io_east_din_r; // @[OverlayRocc.scala 291:43 76:69]
  assign MIDDLENORTH_OV_2_io_config_bits = io_cell_config[181:0]; // @[OverlayRocc.scala 95:34]
  assign MIDDLENORTH_OV_2_io_catch_config = io_cell_config[191] & _GEN_3; // @[OverlayRocc.scala 101:39 98:25]
  assign MIDDLEMIDDLE_OV_8_clock = clock;
  assign MIDDLEMIDDLE_OV_8_reset = reset;
  assign MIDDLEMIDDLE_OV_8_io_north_din = MIDDLENORTH_OV_2_io_south_dout; // @[OverlayRocc.scala 314:42 81:69]
  assign MIDDLEMIDDLE_OV_8_io_north_din_v = MIDDLENORTH_OV_2_io_south_dout_v; // @[OverlayRocc.scala 315:43 84:69]
  assign MIDDLEMIDDLE_OV_8_io_east_din = MIDDLEMIDDLE_OV_12_io_west_dout; // @[OverlayRocc.scala 368:44 70:68]
  assign MIDDLEMIDDLE_OV_8_io_east_din_v = MIDDLEMIDDLE_OV_12_io_west_dout_v; // @[OverlayRocc.scala 369:45 73:69]
  assign MIDDLEMIDDLE_OV_8_io_south_din = MIDDLEMIDDLE_OV_9_io_north_dout; // @[OverlayRocc.scala 353:44 80:69]
  assign MIDDLEMIDDLE_OV_8_io_south_din_v = MIDDLEMIDDLE_OV_9_io_north_dout_v; // @[OverlayRocc.scala 354:45 83:69]
  assign MIDDLEMIDDLE_OV_8_io_west_din = MIDDLEMIDDLE_OV_4_io_east_dout; // @[OverlayRocc.scala 358:42 71:68]
  assign MIDDLEMIDDLE_OV_8_io_west_din_v = MIDDLEMIDDLE_OV_4_io_east_dout_v; // @[OverlayRocc.scala 359:43 74:69]
  assign MIDDLEMIDDLE_OV_8_io_north_dout_r = MIDDLENORTH_OV_2_io_south_din_r; // @[OverlayRocc.scala 296:43 86:69]
  assign MIDDLEMIDDLE_OV_8_io_east_dout_r = MIDDLEMIDDLE_OV_12_io_west_din_r; // @[OverlayRocc.scala 350:45 77:69]
  assign MIDDLEMIDDLE_OV_8_io_south_dout_r = MIDDLEMIDDLE_OV_9_io_north_din_r; // @[OverlayRocc.scala 335:45 87:69]
  assign MIDDLEMIDDLE_OV_8_io_west_dout_r = MIDDLEMIDDLE_OV_4_io_east_din_r; // @[OverlayRocc.scala 340:43 76:69]
  assign MIDDLEMIDDLE_OV_8_io_config_bits = io_cell_config[181:0]; // @[OverlayRocc.scala 95:34]
  assign MIDDLEMIDDLE_OV_8_io_catch_config = io_cell_config[191] & _GEN_9; // @[OverlayRocc.scala 101:39 98:25]
  assign MIDDLEMIDDLE_OV_9_clock = clock;
  assign MIDDLEMIDDLE_OV_9_reset = reset;
  assign MIDDLEMIDDLE_OV_9_io_north_din = MIDDLEMIDDLE_OV_8_io_south_dout; // @[OverlayRocc.scala 363:42 81:69]
  assign MIDDLEMIDDLE_OV_9_io_north_din_v = MIDDLEMIDDLE_OV_8_io_south_dout_v; // @[OverlayRocc.scala 364:43 84:69]
  assign MIDDLEMIDDLE_OV_9_io_east_din = MIDDLEMIDDLE_OV_13_io_west_dout; // @[OverlayRocc.scala 368:44 70:68]
  assign MIDDLEMIDDLE_OV_9_io_east_din_v = MIDDLEMIDDLE_OV_13_io_west_dout_v; // @[OverlayRocc.scala 369:45 73:69]
  assign MIDDLEMIDDLE_OV_9_io_south_din = MIDDLEMIDDLE_OV_10_io_north_dout; // @[OverlayRocc.scala 353:44 80:69]
  assign MIDDLEMIDDLE_OV_9_io_south_din_v = MIDDLEMIDDLE_OV_10_io_north_dout_v; // @[OverlayRocc.scala 354:45 83:69]
  assign MIDDLEMIDDLE_OV_9_io_west_din = MIDDLEMIDDLE_OV_5_io_east_dout; // @[OverlayRocc.scala 358:42 71:68]
  assign MIDDLEMIDDLE_OV_9_io_west_din_v = MIDDLEMIDDLE_OV_5_io_east_dout_v; // @[OverlayRocc.scala 359:43 74:69]
  assign MIDDLEMIDDLE_OV_9_io_north_dout_r = MIDDLEMIDDLE_OV_8_io_south_din_r; // @[OverlayRocc.scala 345:43 86:69]
  assign MIDDLEMIDDLE_OV_9_io_east_dout_r = MIDDLEMIDDLE_OV_13_io_west_din_r; // @[OverlayRocc.scala 350:45 77:69]
  assign MIDDLEMIDDLE_OV_9_io_south_dout_r = MIDDLEMIDDLE_OV_10_io_north_din_r; // @[OverlayRocc.scala 335:45 87:69]
  assign MIDDLEMIDDLE_OV_9_io_west_dout_r = MIDDLEMIDDLE_OV_5_io_east_din_r; // @[OverlayRocc.scala 340:43 76:69]
  assign MIDDLEMIDDLE_OV_9_io_config_bits = io_cell_config[181:0]; // @[OverlayRocc.scala 95:34]
  assign MIDDLEMIDDLE_OV_9_io_catch_config = io_cell_config[191] & _GEN_15; // @[OverlayRocc.scala 101:39 98:25]
  assign MIDDLEMIDDLE_OV_10_clock = clock;
  assign MIDDLEMIDDLE_OV_10_reset = reset;
  assign MIDDLEMIDDLE_OV_10_io_north_din = MIDDLEMIDDLE_OV_9_io_south_dout; // @[OverlayRocc.scala 363:42 81:69]
  assign MIDDLEMIDDLE_OV_10_io_north_din_v = MIDDLEMIDDLE_OV_9_io_south_dout_v; // @[OverlayRocc.scala 364:43 84:69]
  assign MIDDLEMIDDLE_OV_10_io_east_din = MIDDLEMIDDLE_OV_14_io_west_dout; // @[OverlayRocc.scala 368:44 70:68]
  assign MIDDLEMIDDLE_OV_10_io_east_din_v = MIDDLEMIDDLE_OV_14_io_west_dout_v; // @[OverlayRocc.scala 369:45 73:69]
  assign MIDDLEMIDDLE_OV_10_io_south_din = MIDDLEMIDDLE_OV_11_io_north_dout; // @[OverlayRocc.scala 353:44 80:69]
  assign MIDDLEMIDDLE_OV_10_io_south_din_v = MIDDLEMIDDLE_OV_11_io_north_dout_v; // @[OverlayRocc.scala 354:45 83:69]
  assign MIDDLEMIDDLE_OV_10_io_west_din = MIDDLEMIDDLE_OV_6_io_east_dout; // @[OverlayRocc.scala 358:42 71:68]
  assign MIDDLEMIDDLE_OV_10_io_west_din_v = MIDDLEMIDDLE_OV_6_io_east_dout_v; // @[OverlayRocc.scala 359:43 74:69]
  assign MIDDLEMIDDLE_OV_10_io_north_dout_r = MIDDLEMIDDLE_OV_9_io_south_din_r; // @[OverlayRocc.scala 345:43 86:69]
  assign MIDDLEMIDDLE_OV_10_io_east_dout_r = MIDDLEMIDDLE_OV_14_io_west_din_r; // @[OverlayRocc.scala 350:45 77:69]
  assign MIDDLEMIDDLE_OV_10_io_south_dout_r = MIDDLEMIDDLE_OV_11_io_north_din_r; // @[OverlayRocc.scala 335:45 87:69]
  assign MIDDLEMIDDLE_OV_10_io_west_dout_r = MIDDLEMIDDLE_OV_6_io_east_din_r; // @[OverlayRocc.scala 340:43 76:69]
  assign MIDDLEMIDDLE_OV_10_io_config_bits = io_cell_config[181:0]; // @[OverlayRocc.scala 95:34]
  assign MIDDLEMIDDLE_OV_10_io_catch_config = io_cell_config[191] & _GEN_21; // @[OverlayRocc.scala 101:39 98:25]
  assign MIDDLEMIDDLE_OV_11_clock = clock;
  assign MIDDLEMIDDLE_OV_11_reset = reset;
  assign MIDDLEMIDDLE_OV_11_io_north_din = MIDDLEMIDDLE_OV_10_io_south_dout; // @[OverlayRocc.scala 363:42 81:69]
  assign MIDDLEMIDDLE_OV_11_io_north_din_v = MIDDLEMIDDLE_OV_10_io_south_dout_v; // @[OverlayRocc.scala 364:43 84:69]
  assign MIDDLEMIDDLE_OV_11_io_east_din = MIDDLEMIDDLE_OV_15_io_west_dout; // @[OverlayRocc.scala 368:44 70:68]
  assign MIDDLEMIDDLE_OV_11_io_east_din_v = MIDDLEMIDDLE_OV_15_io_west_dout_v; // @[OverlayRocc.scala 369:45 73:69]
  assign MIDDLEMIDDLE_OV_11_io_south_din = MIDDLESOUTH_OV_2_io_north_dout; // @[OverlayRocc.scala 402:44 80:69]
  assign MIDDLEMIDDLE_OV_11_io_south_din_v = MIDDLESOUTH_OV_2_io_north_dout_v; // @[OverlayRocc.scala 403:45 83:69]
  assign MIDDLEMIDDLE_OV_11_io_west_din = MIDDLEMIDDLE_OV_7_io_east_dout; // @[OverlayRocc.scala 358:42 71:68]
  assign MIDDLEMIDDLE_OV_11_io_west_din_v = MIDDLEMIDDLE_OV_7_io_east_dout_v; // @[OverlayRocc.scala 359:43 74:69]
  assign MIDDLEMIDDLE_OV_11_io_north_dout_r = MIDDLEMIDDLE_OV_10_io_south_din_r; // @[OverlayRocc.scala 345:43 86:69]
  assign MIDDLEMIDDLE_OV_11_io_east_dout_r = MIDDLEMIDDLE_OV_15_io_west_din_r; // @[OverlayRocc.scala 350:45 77:69]
  assign MIDDLEMIDDLE_OV_11_io_south_dout_r = MIDDLESOUTH_OV_2_io_north_din_r; // @[OverlayRocc.scala 384:45 87:69]
  assign MIDDLEMIDDLE_OV_11_io_west_dout_r = MIDDLEMIDDLE_OV_7_io_east_din_r; // @[OverlayRocc.scala 340:43 76:69]
  assign MIDDLEMIDDLE_OV_11_io_config_bits = io_cell_config[181:0]; // @[OverlayRocc.scala 95:34]
  assign MIDDLEMIDDLE_OV_11_io_catch_config = io_cell_config[191] & _GEN_27; // @[OverlayRocc.scala 101:39 98:25]
  assign MIDDLESOUTH_OV_2_clock = clock;
  assign MIDDLESOUTH_OV_2_reset = reset;
  assign MIDDLESOUTH_OV_2_io_north_din = MIDDLEMIDDLE_OV_11_io_south_dout; // @[OverlayRocc.scala 363:42 81:69]
  assign MIDDLESOUTH_OV_2_io_north_din_v = MIDDLEMIDDLE_OV_11_io_south_dout_v; // @[OverlayRocc.scala 364:43 84:69]
  assign MIDDLESOUTH_OV_2_io_east_din = MIDDLESOUTH_OV_3_io_west_dout; // @[OverlayRocc.scala 417:44 70:68]
  assign MIDDLESOUTH_OV_2_io_east_din_v = MIDDLESOUTH_OV_3_io_west_dout_v; // @[OverlayRocc.scala 418:45 73:69]
  assign MIDDLESOUTH_OV_2_io_south_din = 32'sh0; // @[OverlayRocc.scala 392:49]
  assign MIDDLESOUTH_OV_2_io_south_din_v = 1'h0; // @[OverlayRocc.scala 393:51]
  assign MIDDLESOUTH_OV_2_io_west_din = MIDDLESOUTH_OV_1_io_east_dout; // @[OverlayRocc.scala 407:42 71:68]
  assign MIDDLESOUTH_OV_2_io_west_din_v = MIDDLESOUTH_OV_1_io_east_dout_v; // @[OverlayRocc.scala 408:43 74:69]
  assign MIDDLESOUTH_OV_2_io_north_dout_r = MIDDLEMIDDLE_OV_11_io_south_din_r; // @[OverlayRocc.scala 345:43 86:69]
  assign MIDDLESOUTH_OV_2_io_east_dout_r = MIDDLESOUTH_OV_3_io_west_din_r; // @[OverlayRocc.scala 399:45 77:69]
  assign MIDDLESOUTH_OV_2_io_south_dout_r = 1'h0; // @[OverlayRocc.scala 414:52]
  assign MIDDLESOUTH_OV_2_io_west_dout_r = MIDDLESOUTH_OV_1_io_east_din_r; // @[OverlayRocc.scala 389:43 76:69]
  assign MIDDLESOUTH_OV_2_io_config_bits = io_cell_config[181:0]; // @[OverlayRocc.scala 95:34]
  assign MIDDLESOUTH_OV_2_io_catch_config = io_cell_config[191] & _GEN_33; // @[OverlayRocc.scala 101:39 98:25]
  assign MIDDLENORTH_OV_3_clock = clock;
  assign MIDDLENORTH_OV_3_reset = reset;
  assign MIDDLENORTH_OV_3_io_north_din = io_data_in[159:128]; // @[OverlayRocc.scala 106:74]
  assign MIDDLENORTH_OV_3_io_north_din_v = io_data_in_valid[4]; // @[OverlayRocc.scala 107:43]
  assign MIDDLENORTH_OV_3_io_east_din = NORTHEAST_OV_io_west_dout; // @[OverlayRocc.scala 470:44 70:68]
  assign MIDDLENORTH_OV_3_io_east_din_v = NORTHEAST_OV_io_west_dout_v; // @[OverlayRocc.scala 471:45 73:69]
  assign MIDDLENORTH_OV_3_io_south_din = MIDDLEMIDDLE_OV_12_io_north_dout; // @[OverlayRocc.scala 353:44 80:69]
  assign MIDDLENORTH_OV_3_io_south_din_v = MIDDLEMIDDLE_OV_12_io_north_dout_v; // @[OverlayRocc.scala 354:45 83:69]
  assign MIDDLENORTH_OV_3_io_west_din = MIDDLENORTH_OV_2_io_east_dout; // @[OverlayRocc.scala 309:42 71:68]
  assign MIDDLENORTH_OV_3_io_west_din_v = MIDDLENORTH_OV_2_io_east_dout_v; // @[OverlayRocc.scala 310:43 74:69]
  assign MIDDLENORTH_OV_3_io_north_dout_r = 1'h0; // @[OverlayRocc.scala 306:52]
  assign MIDDLENORTH_OV_3_io_east_dout_r = NORTHEAST_OV_io_west_din_r; // @[OverlayRocc.scala 452:45 77:69]
  assign MIDDLENORTH_OV_3_io_south_dout_r = MIDDLEMIDDLE_OV_12_io_north_din_r; // @[OverlayRocc.scala 335:45 87:69]
  assign MIDDLENORTH_OV_3_io_west_dout_r = MIDDLENORTH_OV_2_io_east_din_r; // @[OverlayRocc.scala 291:43 76:69]
  assign MIDDLENORTH_OV_3_io_config_bits = io_cell_config[181:0]; // @[OverlayRocc.scala 95:34]
  assign MIDDLENORTH_OV_3_io_catch_config = io_cell_config[191] & _GEN_4; // @[OverlayRocc.scala 101:39 98:25]
  assign MIDDLEMIDDLE_OV_12_clock = clock;
  assign MIDDLEMIDDLE_OV_12_reset = reset;
  assign MIDDLEMIDDLE_OV_12_io_north_din = MIDDLENORTH_OV_3_io_south_dout; // @[OverlayRocc.scala 314:42 81:69]
  assign MIDDLEMIDDLE_OV_12_io_north_din_v = MIDDLENORTH_OV_3_io_south_dout_v; // @[OverlayRocc.scala 315:43 84:69]
  assign MIDDLEMIDDLE_OV_12_io_east_din = MIDDLEEAST_OV_io_west_dout; // @[OverlayRocc.scala 519:44 70:68]
  assign MIDDLEMIDDLE_OV_12_io_east_din_v = MIDDLEEAST_OV_io_west_dout_v; // @[OverlayRocc.scala 520:45 73:69]
  assign MIDDLEMIDDLE_OV_12_io_south_din = MIDDLEMIDDLE_OV_13_io_north_dout; // @[OverlayRocc.scala 353:44 80:69]
  assign MIDDLEMIDDLE_OV_12_io_south_din_v = MIDDLEMIDDLE_OV_13_io_north_dout_v; // @[OverlayRocc.scala 354:45 83:69]
  assign MIDDLEMIDDLE_OV_12_io_west_din = MIDDLEMIDDLE_OV_8_io_east_dout; // @[OverlayRocc.scala 358:42 71:68]
  assign MIDDLEMIDDLE_OV_12_io_west_din_v = MIDDLEMIDDLE_OV_8_io_east_dout_v; // @[OverlayRocc.scala 359:43 74:69]
  assign MIDDLEMIDDLE_OV_12_io_north_dout_r = MIDDLENORTH_OV_3_io_south_din_r; // @[OverlayRocc.scala 296:43 86:69]
  assign MIDDLEMIDDLE_OV_12_io_east_dout_r = MIDDLEEAST_OV_io_west_din_r; // @[OverlayRocc.scala 501:45 77:69]
  assign MIDDLEMIDDLE_OV_12_io_south_dout_r = MIDDLEMIDDLE_OV_13_io_north_din_r; // @[OverlayRocc.scala 335:45 87:69]
  assign MIDDLEMIDDLE_OV_12_io_west_dout_r = MIDDLEMIDDLE_OV_8_io_east_din_r; // @[OverlayRocc.scala 340:43 76:69]
  assign MIDDLEMIDDLE_OV_12_io_config_bits = io_cell_config[181:0]; // @[OverlayRocc.scala 95:34]
  assign MIDDLEMIDDLE_OV_12_io_catch_config = io_cell_config[191] & _GEN_10; // @[OverlayRocc.scala 101:39 98:25]
  assign MIDDLEMIDDLE_OV_13_clock = clock;
  assign MIDDLEMIDDLE_OV_13_reset = reset;
  assign MIDDLEMIDDLE_OV_13_io_north_din = MIDDLEMIDDLE_OV_12_io_south_dout; // @[OverlayRocc.scala 363:42 81:69]
  assign MIDDLEMIDDLE_OV_13_io_north_din_v = MIDDLEMIDDLE_OV_12_io_south_dout_v; // @[OverlayRocc.scala 364:43 84:69]
  assign MIDDLEMIDDLE_OV_13_io_east_din = MIDDLEEAST_OV_1_io_west_dout; // @[OverlayRocc.scala 519:44 70:68]
  assign MIDDLEMIDDLE_OV_13_io_east_din_v = MIDDLEEAST_OV_1_io_west_dout_v; // @[OverlayRocc.scala 520:45 73:69]
  assign MIDDLEMIDDLE_OV_13_io_south_din = MIDDLEMIDDLE_OV_14_io_north_dout; // @[OverlayRocc.scala 353:44 80:69]
  assign MIDDLEMIDDLE_OV_13_io_south_din_v = MIDDLEMIDDLE_OV_14_io_north_dout_v; // @[OverlayRocc.scala 354:45 83:69]
  assign MIDDLEMIDDLE_OV_13_io_west_din = MIDDLEMIDDLE_OV_9_io_east_dout; // @[OverlayRocc.scala 358:42 71:68]
  assign MIDDLEMIDDLE_OV_13_io_west_din_v = MIDDLEMIDDLE_OV_9_io_east_dout_v; // @[OverlayRocc.scala 359:43 74:69]
  assign MIDDLEMIDDLE_OV_13_io_north_dout_r = MIDDLEMIDDLE_OV_12_io_south_din_r; // @[OverlayRocc.scala 345:43 86:69]
  assign MIDDLEMIDDLE_OV_13_io_east_dout_r = MIDDLEEAST_OV_1_io_west_din_r; // @[OverlayRocc.scala 501:45 77:69]
  assign MIDDLEMIDDLE_OV_13_io_south_dout_r = MIDDLEMIDDLE_OV_14_io_north_din_r; // @[OverlayRocc.scala 335:45 87:69]
  assign MIDDLEMIDDLE_OV_13_io_west_dout_r = MIDDLEMIDDLE_OV_9_io_east_din_r; // @[OverlayRocc.scala 340:43 76:69]
  assign MIDDLEMIDDLE_OV_13_io_config_bits = io_cell_config[181:0]; // @[OverlayRocc.scala 95:34]
  assign MIDDLEMIDDLE_OV_13_io_catch_config = io_cell_config[191] & _GEN_16; // @[OverlayRocc.scala 101:39 98:25]
  assign MIDDLEMIDDLE_OV_14_clock = clock;
  assign MIDDLEMIDDLE_OV_14_reset = reset;
  assign MIDDLEMIDDLE_OV_14_io_north_din = MIDDLEMIDDLE_OV_13_io_south_dout; // @[OverlayRocc.scala 363:42 81:69]
  assign MIDDLEMIDDLE_OV_14_io_north_din_v = MIDDLEMIDDLE_OV_13_io_south_dout_v; // @[OverlayRocc.scala 364:43 84:69]
  assign MIDDLEMIDDLE_OV_14_io_east_din = MIDDLEEAST_OV_2_io_west_dout; // @[OverlayRocc.scala 519:44 70:68]
  assign MIDDLEMIDDLE_OV_14_io_east_din_v = MIDDLEEAST_OV_2_io_west_dout_v; // @[OverlayRocc.scala 520:45 73:69]
  assign MIDDLEMIDDLE_OV_14_io_south_din = MIDDLEMIDDLE_OV_15_io_north_dout; // @[OverlayRocc.scala 353:44 80:69]
  assign MIDDLEMIDDLE_OV_14_io_south_din_v = MIDDLEMIDDLE_OV_15_io_north_dout_v; // @[OverlayRocc.scala 354:45 83:69]
  assign MIDDLEMIDDLE_OV_14_io_west_din = MIDDLEMIDDLE_OV_10_io_east_dout; // @[OverlayRocc.scala 358:42 71:68]
  assign MIDDLEMIDDLE_OV_14_io_west_din_v = MIDDLEMIDDLE_OV_10_io_east_dout_v; // @[OverlayRocc.scala 359:43 74:69]
  assign MIDDLEMIDDLE_OV_14_io_north_dout_r = MIDDLEMIDDLE_OV_13_io_south_din_r; // @[OverlayRocc.scala 345:43 86:69]
  assign MIDDLEMIDDLE_OV_14_io_east_dout_r = MIDDLEEAST_OV_2_io_west_din_r; // @[OverlayRocc.scala 501:45 77:69]
  assign MIDDLEMIDDLE_OV_14_io_south_dout_r = MIDDLEMIDDLE_OV_15_io_north_din_r; // @[OverlayRocc.scala 335:45 87:69]
  assign MIDDLEMIDDLE_OV_14_io_west_dout_r = MIDDLEMIDDLE_OV_10_io_east_din_r; // @[OverlayRocc.scala 340:43 76:69]
  assign MIDDLEMIDDLE_OV_14_io_config_bits = io_cell_config[181:0]; // @[OverlayRocc.scala 95:34]
  assign MIDDLEMIDDLE_OV_14_io_catch_config = io_cell_config[191] & _GEN_22; // @[OverlayRocc.scala 101:39 98:25]
  assign MIDDLEMIDDLE_OV_15_clock = clock;
  assign MIDDLEMIDDLE_OV_15_reset = reset;
  assign MIDDLEMIDDLE_OV_15_io_north_din = MIDDLEMIDDLE_OV_14_io_south_dout; // @[OverlayRocc.scala 363:42 81:69]
  assign MIDDLEMIDDLE_OV_15_io_north_din_v = MIDDLEMIDDLE_OV_14_io_south_dout_v; // @[OverlayRocc.scala 364:43 84:69]
  assign MIDDLEMIDDLE_OV_15_io_east_din = MIDDLEEAST_OV_3_io_west_dout; // @[OverlayRocc.scala 519:44 70:68]
  assign MIDDLEMIDDLE_OV_15_io_east_din_v = MIDDLEEAST_OV_3_io_west_dout_v; // @[OverlayRocc.scala 520:45 73:69]
  assign MIDDLEMIDDLE_OV_15_io_south_din = MIDDLESOUTH_OV_3_io_north_dout; // @[OverlayRocc.scala 402:44 80:69]
  assign MIDDLEMIDDLE_OV_15_io_south_din_v = MIDDLESOUTH_OV_3_io_north_dout_v; // @[OverlayRocc.scala 403:45 83:69]
  assign MIDDLEMIDDLE_OV_15_io_west_din = MIDDLEMIDDLE_OV_11_io_east_dout; // @[OverlayRocc.scala 358:42 71:68]
  assign MIDDLEMIDDLE_OV_15_io_west_din_v = MIDDLEMIDDLE_OV_11_io_east_dout_v; // @[OverlayRocc.scala 359:43 74:69]
  assign MIDDLEMIDDLE_OV_15_io_north_dout_r = MIDDLEMIDDLE_OV_14_io_south_din_r; // @[OverlayRocc.scala 345:43 86:69]
  assign MIDDLEMIDDLE_OV_15_io_east_dout_r = MIDDLEEAST_OV_3_io_west_din_r; // @[OverlayRocc.scala 501:45 77:69]
  assign MIDDLEMIDDLE_OV_15_io_south_dout_r = MIDDLESOUTH_OV_3_io_north_din_r; // @[OverlayRocc.scala 384:45 87:69]
  assign MIDDLEMIDDLE_OV_15_io_west_dout_r = MIDDLEMIDDLE_OV_11_io_east_din_r; // @[OverlayRocc.scala 340:43 76:69]
  assign MIDDLEMIDDLE_OV_15_io_config_bits = io_cell_config[181:0]; // @[OverlayRocc.scala 95:34]
  assign MIDDLEMIDDLE_OV_15_io_catch_config = io_cell_config[191] & _GEN_28; // @[OverlayRocc.scala 101:39 98:25]
  assign MIDDLESOUTH_OV_3_clock = clock;
  assign MIDDLESOUTH_OV_3_reset = reset;
  assign MIDDLESOUTH_OV_3_io_north_din = MIDDLEMIDDLE_OV_15_io_south_dout; // @[OverlayRocc.scala 363:42 81:69]
  assign MIDDLESOUTH_OV_3_io_north_din_v = MIDDLEMIDDLE_OV_15_io_south_dout_v; // @[OverlayRocc.scala 364:43 84:69]
  assign MIDDLESOUTH_OV_3_io_east_din = MIDDLESOUTH_OV_4_io_west_dout; // @[OverlayRocc.scala 568:44 70:68]
  assign MIDDLESOUTH_OV_3_io_east_din_v = MIDDLESOUTH_OV_4_io_west_dout_v; // @[OverlayRocc.scala 569:45 73:69]
  assign MIDDLESOUTH_OV_3_io_south_din = 32'sh0; // @[OverlayRocc.scala 392:49]
  assign MIDDLESOUTH_OV_3_io_south_din_v = 1'h0; // @[OverlayRocc.scala 393:51]
  assign MIDDLESOUTH_OV_3_io_west_din = MIDDLESOUTH_OV_2_io_east_dout; // @[OverlayRocc.scala 407:42 71:68]
  assign MIDDLESOUTH_OV_3_io_west_din_v = MIDDLESOUTH_OV_2_io_east_dout_v; // @[OverlayRocc.scala 408:43 74:69]
  assign MIDDLESOUTH_OV_3_io_north_dout_r = MIDDLEMIDDLE_OV_15_io_south_din_r; // @[OverlayRocc.scala 345:43 86:69]
  assign MIDDLESOUTH_OV_3_io_east_dout_r = MIDDLESOUTH_OV_4_io_west_din_r; // @[OverlayRocc.scala 550:45 77:69]
  assign MIDDLESOUTH_OV_3_io_south_dout_r = 1'h0; // @[OverlayRocc.scala 414:52]
  assign MIDDLESOUTH_OV_3_io_west_dout_r = MIDDLESOUTH_OV_2_io_east_din_r; // @[OverlayRocc.scala 389:43 76:69]
  assign MIDDLESOUTH_OV_3_io_config_bits = io_cell_config[181:0]; // @[OverlayRocc.scala 95:34]
  assign MIDDLESOUTH_OV_3_io_catch_config = io_cell_config[191] & _GEN_34; // @[OverlayRocc.scala 101:39 98:25]
  assign NORTHEAST_OV_clock = clock;
  assign NORTHEAST_OV_reset = reset;
  assign NORTHEAST_OV_io_north_din = io_data_in[191:160]; // @[OverlayRocc.scala 106:74]
  assign NORTHEAST_OV_io_north_din_v = io_data_in_valid[5]; // @[OverlayRocc.scala 107:43]
  assign NORTHEAST_OV_io_east_din = 32'sh0; // @[OverlayRocc.scala 440:46]
  assign NORTHEAST_OV_io_east_din_v = 1'h0; // @[OverlayRocc.scala 441:48]
  assign NORTHEAST_OV_io_south_din = MIDDLEEAST_OV_io_north_dout; // @[OverlayRocc.scala 504:44 80:69]
  assign NORTHEAST_OV_io_south_din_v = MIDDLEEAST_OV_io_north_dout_v; // @[OverlayRocc.scala 505:45 83:69]
  assign NORTHEAST_OV_io_west_din = MIDDLENORTH_OV_3_io_east_dout; // @[OverlayRocc.scala 309:42 71:68]
  assign NORTHEAST_OV_io_west_din_v = MIDDLENORTH_OV_3_io_east_dout_v; // @[OverlayRocc.scala 310:43 74:69]
  assign NORTHEAST_OV_io_north_dout_r = 1'h0; // @[OverlayRocc.scala 457:50]
  assign NORTHEAST_OV_io_east_dout_r = io_data_out_ready[0]; // @[OverlayRocc.scala 586:44]
  assign NORTHEAST_OV_io_south_dout_r = MIDDLEEAST_OV_io_north_din_r; // @[OverlayRocc.scala 486:45 87:69]
  assign NORTHEAST_OV_io_west_dout_r = MIDDLENORTH_OV_3_io_east_din_r; // @[OverlayRocc.scala 291:43 76:69]
  assign NORTHEAST_OV_io_config_bits = io_cell_config[181:0]; // @[OverlayRocc.scala 95:34]
  assign NORTHEAST_OV_io_catch_config = io_cell_config[191] & _GEN_5; // @[OverlayRocc.scala 101:39 98:25]
  assign MIDDLEEAST_OV_clock = clock;
  assign MIDDLEEAST_OV_reset = reset;
  assign MIDDLEEAST_OV_io_north_din = NORTHEAST_OV_io_south_dout; // @[OverlayRocc.scala 465:42 81:69]
  assign MIDDLEEAST_OV_io_north_din_v = NORTHEAST_OV_io_south_dout_v; // @[OverlayRocc.scala 466:43 84:69]
  assign MIDDLEEAST_OV_io_east_din = 32'sh0; // @[OverlayRocc.scala 489:47]
  assign MIDDLEEAST_OV_io_east_din_v = 1'h0; // @[OverlayRocc.scala 490:49]
  assign MIDDLEEAST_OV_io_south_din = MIDDLEEAST_OV_1_io_north_dout; // @[OverlayRocc.scala 504:44 80:69]
  assign MIDDLEEAST_OV_io_south_din_v = MIDDLEEAST_OV_1_io_north_dout_v; // @[OverlayRocc.scala 505:45 83:69]
  assign MIDDLEEAST_OV_io_west_din = MIDDLEMIDDLE_OV_12_io_east_dout; // @[OverlayRocc.scala 358:42 71:68]
  assign MIDDLEEAST_OV_io_west_din_v = MIDDLEMIDDLE_OV_12_io_east_dout_v; // @[OverlayRocc.scala 359:43 74:69]
  assign MIDDLEEAST_OV_io_north_dout_r = NORTHEAST_OV_io_south_din_r; // @[OverlayRocc.scala 447:43 86:69]
  assign MIDDLEEAST_OV_io_east_dout_r = io_data_out_ready[1]; // @[OverlayRocc.scala 586:44]
  assign MIDDLEEAST_OV_io_south_dout_r = MIDDLEEAST_OV_1_io_north_din_r; // @[OverlayRocc.scala 486:45 87:69]
  assign MIDDLEEAST_OV_io_west_dout_r = MIDDLEMIDDLE_OV_12_io_east_din_r; // @[OverlayRocc.scala 340:43 76:69]
  assign MIDDLEEAST_OV_io_config_bits = io_cell_config[181:0]; // @[OverlayRocc.scala 95:34]
  assign MIDDLEEAST_OV_io_catch_config = io_cell_config[191] & _GEN_11; // @[OverlayRocc.scala 101:39 98:25]
  assign MIDDLEEAST_OV_1_clock = clock;
  assign MIDDLEEAST_OV_1_reset = reset;
  assign MIDDLEEAST_OV_1_io_north_din = MIDDLEEAST_OV_io_south_dout; // @[OverlayRocc.scala 514:42 81:69]
  assign MIDDLEEAST_OV_1_io_north_din_v = MIDDLEEAST_OV_io_south_dout_v; // @[OverlayRocc.scala 515:43 84:69]
  assign MIDDLEEAST_OV_1_io_east_din = 32'sh0; // @[OverlayRocc.scala 489:47]
  assign MIDDLEEAST_OV_1_io_east_din_v = 1'h0; // @[OverlayRocc.scala 490:49]
  assign MIDDLEEAST_OV_1_io_south_din = MIDDLEEAST_OV_2_io_north_dout; // @[OverlayRocc.scala 504:44 80:69]
  assign MIDDLEEAST_OV_1_io_south_din_v = MIDDLEEAST_OV_2_io_north_dout_v; // @[OverlayRocc.scala 505:45 83:69]
  assign MIDDLEEAST_OV_1_io_west_din = MIDDLEMIDDLE_OV_13_io_east_dout; // @[OverlayRocc.scala 358:42 71:68]
  assign MIDDLEEAST_OV_1_io_west_din_v = MIDDLEMIDDLE_OV_13_io_east_dout_v; // @[OverlayRocc.scala 359:43 74:69]
  assign MIDDLEEAST_OV_1_io_north_dout_r = MIDDLEEAST_OV_io_south_din_r; // @[OverlayRocc.scala 496:43 86:69]
  assign MIDDLEEAST_OV_1_io_east_dout_r = io_data_out_ready[2]; // @[OverlayRocc.scala 586:44]
  assign MIDDLEEAST_OV_1_io_south_dout_r = MIDDLEEAST_OV_2_io_north_din_r; // @[OverlayRocc.scala 486:45 87:69]
  assign MIDDLEEAST_OV_1_io_west_dout_r = MIDDLEMIDDLE_OV_13_io_east_din_r; // @[OverlayRocc.scala 340:43 76:69]
  assign MIDDLEEAST_OV_1_io_config_bits = io_cell_config[181:0]; // @[OverlayRocc.scala 95:34]
  assign MIDDLEEAST_OV_1_io_catch_config = io_cell_config[191] & _GEN_17; // @[OverlayRocc.scala 101:39 98:25]
  assign MIDDLEEAST_OV_2_clock = clock;
  assign MIDDLEEAST_OV_2_reset = reset;
  assign MIDDLEEAST_OV_2_io_north_din = MIDDLEEAST_OV_1_io_south_dout; // @[OverlayRocc.scala 514:42 81:69]
  assign MIDDLEEAST_OV_2_io_north_din_v = MIDDLEEAST_OV_1_io_south_dout_v; // @[OverlayRocc.scala 515:43 84:69]
  assign MIDDLEEAST_OV_2_io_east_din = 32'sh0; // @[OverlayRocc.scala 489:47]
  assign MIDDLEEAST_OV_2_io_east_din_v = 1'h0; // @[OverlayRocc.scala 490:49]
  assign MIDDLEEAST_OV_2_io_south_din = MIDDLEEAST_OV_3_io_north_dout; // @[OverlayRocc.scala 504:44 80:69]
  assign MIDDLEEAST_OV_2_io_south_din_v = MIDDLEEAST_OV_3_io_north_dout_v; // @[OverlayRocc.scala 505:45 83:69]
  assign MIDDLEEAST_OV_2_io_west_din = MIDDLEMIDDLE_OV_14_io_east_dout; // @[OverlayRocc.scala 358:42 71:68]
  assign MIDDLEEAST_OV_2_io_west_din_v = MIDDLEMIDDLE_OV_14_io_east_dout_v; // @[OverlayRocc.scala 359:43 74:69]
  assign MIDDLEEAST_OV_2_io_north_dout_r = MIDDLEEAST_OV_1_io_south_din_r; // @[OverlayRocc.scala 496:43 86:69]
  assign MIDDLEEAST_OV_2_io_east_dout_r = io_data_out_ready[3]; // @[OverlayRocc.scala 586:44]
  assign MIDDLEEAST_OV_2_io_south_dout_r = MIDDLEEAST_OV_3_io_north_din_r; // @[OverlayRocc.scala 486:45 87:69]
  assign MIDDLEEAST_OV_2_io_west_dout_r = MIDDLEMIDDLE_OV_14_io_east_din_r; // @[OverlayRocc.scala 340:43 76:69]
  assign MIDDLEEAST_OV_2_io_config_bits = io_cell_config[181:0]; // @[OverlayRocc.scala 95:34]
  assign MIDDLEEAST_OV_2_io_catch_config = io_cell_config[191] & _GEN_23; // @[OverlayRocc.scala 101:39 98:25]
  assign MIDDLEEAST_OV_3_clock = clock;
  assign MIDDLEEAST_OV_3_reset = reset;
  assign MIDDLEEAST_OV_3_io_north_din = MIDDLEEAST_OV_2_io_south_dout; // @[OverlayRocc.scala 514:42 81:69]
  assign MIDDLEEAST_OV_3_io_north_din_v = MIDDLEEAST_OV_2_io_south_dout_v; // @[OverlayRocc.scala 515:43 84:69]
  assign MIDDLEEAST_OV_3_io_east_din = 32'sh0; // @[OverlayRocc.scala 489:47]
  assign MIDDLEEAST_OV_3_io_east_din_v = 1'h0; // @[OverlayRocc.scala 490:49]
  assign MIDDLEEAST_OV_3_io_south_din = MIDDLESOUTH_OV_4_io_north_dout; // @[OverlayRocc.scala 553:44 80:69]
  assign MIDDLEEAST_OV_3_io_south_din_v = MIDDLESOUTH_OV_4_io_north_dout_v; // @[OverlayRocc.scala 554:45 83:69]
  assign MIDDLEEAST_OV_3_io_west_din = MIDDLEMIDDLE_OV_15_io_east_dout; // @[OverlayRocc.scala 358:42 71:68]
  assign MIDDLEEAST_OV_3_io_west_din_v = MIDDLEMIDDLE_OV_15_io_east_dout_v; // @[OverlayRocc.scala 359:43 74:69]
  assign MIDDLEEAST_OV_3_io_north_dout_r = MIDDLEEAST_OV_2_io_south_din_r; // @[OverlayRocc.scala 496:43 86:69]
  assign MIDDLEEAST_OV_3_io_east_dout_r = io_data_out_ready[4]; // @[OverlayRocc.scala 586:44]
  assign MIDDLEEAST_OV_3_io_south_dout_r = MIDDLESOUTH_OV_4_io_north_din_r; // @[OverlayRocc.scala 535:45 87:69]
  assign MIDDLEEAST_OV_3_io_west_dout_r = MIDDLEMIDDLE_OV_15_io_east_din_r; // @[OverlayRocc.scala 340:43 76:69]
  assign MIDDLEEAST_OV_3_io_config_bits = io_cell_config[181:0]; // @[OverlayRocc.scala 95:34]
  assign MIDDLEEAST_OV_3_io_catch_config = io_cell_config[191] & _GEN_29; // @[OverlayRocc.scala 101:39 98:25]
  assign MIDDLESOUTH_OV_4_clock = clock;
  assign MIDDLESOUTH_OV_4_reset = reset;
  assign MIDDLESOUTH_OV_4_io_north_din = MIDDLEEAST_OV_3_io_south_dout; // @[OverlayRocc.scala 514:42 81:69]
  assign MIDDLESOUTH_OV_4_io_north_din_v = MIDDLEEAST_OV_3_io_south_dout_v; // @[OverlayRocc.scala 515:43 84:69]
  assign MIDDLESOUTH_OV_4_io_east_din = 32'sh0; // @[OverlayRocc.scala 538:48]
  assign MIDDLESOUTH_OV_4_io_east_din_v = 1'h0; // @[OverlayRocc.scala 539:50]
  assign MIDDLESOUTH_OV_4_io_south_din = 32'sh0; // @[OverlayRocc.scala 543:49]
  assign MIDDLESOUTH_OV_4_io_south_din_v = 1'h0; // @[OverlayRocc.scala 544:51]
  assign MIDDLESOUTH_OV_4_io_west_din = MIDDLESOUTH_OV_3_io_east_dout; // @[OverlayRocc.scala 407:42 71:68]
  assign MIDDLESOUTH_OV_4_io_west_din_v = MIDDLESOUTH_OV_3_io_east_dout_v; // @[OverlayRocc.scala 408:43 74:69]
  assign MIDDLESOUTH_OV_4_io_north_dout_r = MIDDLEEAST_OV_3_io_south_din_r; // @[OverlayRocc.scala 496:43 86:69]
  assign MIDDLESOUTH_OV_4_io_east_dout_r = io_data_out_ready[5]; // @[OverlayRocc.scala 586:44]
  assign MIDDLESOUTH_OV_4_io_south_dout_r = 1'h0; // @[OverlayRocc.scala 565:52]
  assign MIDDLESOUTH_OV_4_io_west_dout_r = MIDDLESOUTH_OV_3_io_east_din_r; // @[OverlayRocc.scala 389:43 76:69]
  assign MIDDLESOUTH_OV_4_io_config_bits = io_cell_config[181:0]; // @[OverlayRocc.scala 95:34]
  assign MIDDLESOUTH_OV_4_io_catch_config = io_cell_config[191] & _GEN_35; // @[OverlayRocc.scala 101:39 98:25]
endmodule
