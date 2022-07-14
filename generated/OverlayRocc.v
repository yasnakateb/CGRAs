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
`ifdef RANDOMIZE_MEM_INIT
  reg [31:0] _RAND_0;
`endif // RANDOMIZE_MEM_INIT
`ifdef RANDOMIZE_REG_INIT
  reg [31:0] _RAND_1;
  reg [31:0] _RAND_2;
  reg [31:0] _RAND_3;
  reg [31:0] _RAND_4;
  reg [31:0] _RAND_5;
`endif // RANDOMIZE_REG_INIT
  reg [31:0] memory [0:31]; // @[D_FIFO.scala 17:29]
  wire  memory_io_dout_MPORT_en; // @[D_FIFO.scala 17:29]
  wire [4:0] memory_io_dout_MPORT_addr; // @[D_FIFO.scala 17:29]
  wire [31:0] memory_io_dout_MPORT_data; // @[D_FIFO.scala 17:29]
  wire [31:0] memory_MPORT_data; // @[D_FIFO.scala 17:29]
  wire [4:0] memory_MPORT_addr; // @[D_FIFO.scala 17:29]
  wire  memory_MPORT_mask; // @[D_FIFO.scala 17:29]
  wire  memory_MPORT_en; // @[D_FIFO.scala 17:29]
  reg  memory_io_dout_MPORT_en_pipe_0;
  reg [4:0] memory_io_dout_MPORT_addr_pipe_0;
  reg [31:0] write_pointer; // @[D_FIFO.scala 19:36]
  reg [31:0] read_pointer; // @[D_FIFO.scala 20:31]
  reg [31:0] num_data; // @[D_FIFO.scala 21:27]
  wire  full = num_data == 32'h20; // @[D_FIFO.scala 64:20]
  wire  _T = ~full; // @[D_FIFO.scala 41:16]
  wire  wr_en = io_din_v & _T; // @[D_FIFO.scala 76:23]
  wire [31:0] _num_data_T_1 = num_data + 32'h1; // @[D_FIFO.scala 43:30]
  wire [5:0] _T_5 = 6'h20 - 6'h1; // @[D_FIFO.scala 45:46]
  wire [31:0] _GEN_19 = {{26'd0}, _T_5}; // @[D_FIFO.scala 45:29]
  wire [31:0] _write_pointer_T_1 = write_pointer + 32'h1; // @[D_FIFO.scala 48:44]
  wire  empty = num_data == 32'h0; // @[D_FIFO.scala 70:20]
  wire  _T_7 = ~empty; // @[D_FIFO.scala 52:17]
  wire  rd_en = io_dout_r & _T_7; // @[D_FIFO.scala 77:28]
  wire [31:0] _num_data_T_3 = num_data - 32'h1; // @[D_FIFO.scala 55:30]
  wire [31:0] _read_pointer_T_1 = read_pointer + 32'h1; // @[D_FIFO.scala 60:42]
  assign memory_io_dout_MPORT_en = memory_io_dout_MPORT_en_pipe_0;
  assign memory_io_dout_MPORT_addr = memory_io_dout_MPORT_addr_pipe_0;
  assign memory_io_dout_MPORT_data = memory[memory_io_dout_MPORT_addr]; // @[D_FIFO.scala 17:29]
  assign memory_MPORT_data = io_din;
  assign memory_MPORT_addr = write_pointer[4:0];
  assign memory_MPORT_mask = 1'h1;
  assign memory_MPORT_en = _T & wr_en;
  assign io_din_r = ~full; // @[D_FIFO.scala 78:22]
  assign io_dout = ~empty & rd_en ? memory_io_dout_MPORT_data : 32'h0; // @[D_FIFO.scala 34:13 52:51 53:17]
  assign io_dout_v = ~empty & rd_en; // @[D_FIFO.scala 52:30]
  always @(posedge clock) begin
    if (memory_MPORT_en & memory_MPORT_mask) begin
      memory[memory_MPORT_addr] <= memory_MPORT_data; // @[D_FIFO.scala 17:29]
    end
    memory_io_dout_MPORT_en_pipe_0 <= _T_7 & rd_en;
    if (_T_7 & rd_en) begin
      memory_io_dout_MPORT_addr_pipe_0 <= read_pointer[4:0];
    end
    if (reset) begin // @[D_FIFO.scala 19:36]
      write_pointer <= 32'h0; // @[D_FIFO.scala 19:36]
    end else if (~full & wr_en) begin // @[D_FIFO.scala 41:50]
      if (write_pointer == _GEN_19) begin // @[D_FIFO.scala 45:54]
        write_pointer <= 32'h0; // @[D_FIFO.scala 46:27]
      end else begin
        write_pointer <= _write_pointer_T_1; // @[D_FIFO.scala 48:27]
      end
    end else begin
      write_pointer <= 32'h0; // @[D_FIFO.scala 31:23]
    end
    if (reset) begin // @[D_FIFO.scala 20:31]
      read_pointer <= 32'h0; // @[D_FIFO.scala 20:31]
    end else if (~empty & rd_en) begin // @[D_FIFO.scala 52:51]
      if (read_pointer == _GEN_19) begin // @[D_FIFO.scala 57:53]
        read_pointer <= 32'h0; // @[D_FIFO.scala 58:26]
      end else begin
        read_pointer <= _read_pointer_T_1; // @[D_FIFO.scala 60:26]
      end
    end else begin
      read_pointer <= 32'h0; // @[D_FIFO.scala 32:18]
    end
    if (reset) begin // @[D_FIFO.scala 21:27]
      num_data <= 32'h0; // @[D_FIFO.scala 21:27]
    end else if (~empty & rd_en) begin // @[D_FIFO.scala 52:51]
      num_data <= _num_data_T_3; // @[D_FIFO.scala 55:18]
    end else if (~full & wr_en) begin // @[D_FIFO.scala 41:50]
      num_data <= _num_data_T_1; // @[D_FIFO.scala 43:18]
    end else begin
      num_data <= 32'h0; // @[D_FIFO.scala 33:18]
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
`ifdef RANDOMIZE_MEM_INIT
  _RAND_0 = {1{`RANDOM}};
  for (initvar = 0; initvar < 32; initvar = initvar+1)
    memory[initvar] = _RAND_0[31:0];
`endif // RANDOMIZE_MEM_INIT
`ifdef RANDOMIZE_REG_INIT
  _RAND_1 = {1{`RANDOM}};
  memory_io_dout_MPORT_en_pipe_0 = _RAND_1[0:0];
  _RAND_2 = {1{`RANDOM}};
  memory_io_dout_MPORT_addr_pipe_0 = _RAND_2[4:0];
  _RAND_3 = {1{`RANDOM}};
  write_pointer = _RAND_3[31:0];
  _RAND_4 = {1{`RANDOM}};
  read_pointer = _RAND_4[31:0];
  _RAND_5 = {1{`RANDOM}};
  num_data = _RAND_5[31:0];
`endif // RANDOMIZE_REG_INIT
  `endif // RANDOMIZE
end // initial
`ifdef FIRRTL_AFTER_INITIAL
`FIRRTL_AFTER_INITIAL
`endif
`endif // SYNTHESIS
endmodule
module FS(
  input  [4:0] io_ready_out,
  input  [4:0] io_fork_mask,
  output       io_ready_in
);
  wire  aux_0 = ~io_fork_mask[0] | io_ready_out[0]; // @[FS.scala 24:39]
  wire  aux_1 = ~io_fork_mask[1] | io_ready_out[1]; // @[FS.scala 24:39]
  wire  aux_2 = ~io_fork_mask[2] | io_ready_out[2]; // @[FS.scala 24:39]
  wire  aux_3 = ~io_fork_mask[3] | io_ready_out[3]; // @[FS.scala 24:39]
  wire  aux_4 = ~io_fork_mask[4] | io_ready_out[4]; // @[FS.scala 24:39]
  wire  temp_1 = aux_0 & aux_1; // @[FS.scala 30:30]
  wire  temp_2 = temp_1 & aux_2; // @[FS.scala 30:30]
  wire  temp_3 = temp_2 & aux_3; // @[FS.scala 30:30]
  assign io_ready_in = temp_3 & aux_4; // @[FS.scala 30:30]
endmodule
module ConfMux(
  input  [1:0]   io_selector,
  input  [127:0] io_mux_input,
  output [31:0]  io_mux_output
);
  wire [31:0] inputs_0 = io_mux_input[31:0]; // @[ConfMux.scala 27:34]
  wire [31:0] inputs_1 = io_mux_input[63:32]; // @[ConfMux.scala 27:34]
  wire [31:0] inputs_2 = io_mux_input[95:64]; // @[ConfMux.scala 27:34]
  wire [31:0] inputs_3 = io_mux_input[127:96]; // @[ConfMux.scala 27:34]
  wire [31:0] _GEN_1 = 2'h1 == io_selector ? inputs_1 : inputs_0; // @[ConfMux.scala 30:{19,19}]
  wire [31:0] _GEN_2 = 2'h2 == io_selector ? inputs_2 : _GEN_1; // @[ConfMux.scala 30:{19,19}]
  assign io_mux_output = 2'h3 == io_selector ? inputs_3 : _GEN_2; // @[ConfMux.scala 30:{19,19}]
endmodule
module ConfMux_1(
  input  [1:0] io_selector,
  input  [3:0] io_mux_input,
  output       io_mux_output
);
  wire  inputs_0 = io_mux_input[0]; // @[ConfMux.scala 27:34]
  wire  inputs_1 = io_mux_input[1]; // @[ConfMux.scala 27:34]
  wire  inputs_2 = io_mux_input[2]; // @[ConfMux.scala 27:34]
  wire  inputs_3 = io_mux_input[3]; // @[ConfMux.scala 27:34]
  wire  _GEN_1 = 2'h1 == io_selector ? inputs_1 : inputs_0; // @[ConfMux.scala 30:{19,19}]
  wire  _GEN_2 = 2'h2 == io_selector ? inputs_2 : _GEN_1; // @[ConfMux.scala 30:{19,19}]
  assign io_mux_output = 2'h3 == io_selector ? inputs_3 : _GEN_2; // @[ConfMux.scala 30:{19,19}]
endmodule
module FR(
  input  [3:0] io_valid_in,
  input  [4:0] io_ready_out,
  input  [1:0] io_valid_mux_sel,
  input  [4:0] io_fork_mask,
  output       io_valid_out
);
  wire [1:0] conf_mux_io_selector; // @[FR.scala 29:28]
  wire [3:0] conf_mux_io_mux_input; // @[FR.scala 29:28]
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
  ConfMux_1 conf_mux ( // @[FR.scala 29:28]
    .io_selector(conf_mux_io_selector),
    .io_mux_input(conf_mux_io_mux_input),
    .io_mux_output(conf_mux_io_mux_output)
  );
  assign io_valid_out = temp_4 & Vaux; // @[FR.scala 38:30]
  assign conf_mux_io_selector = io_valid_mux_sel; // @[FR.scala 30:26]
  assign conf_mux_io_mux_input = io_valid_in; // @[FR.scala 31:27]
endmodule
module RegEnable(
  input         clock,
  input         reset,
  input  [31:0] io_in,
  input         io_en,
  output [31:0] io_out
);
`ifdef RANDOMIZE_REG_INIT
  reg [31:0] _RAND_0;
`endif // RANDOMIZE_REG_INIT
  reg [31:0] reg_; // @[RegEnable.scala 11:22]
  assign io_out = reg_; // @[RegEnable.scala 15:12]
  always @(posedge clock) begin
    if (reset) begin // @[RegEnable.scala 11:22]
      reg_ <= 32'h0; // @[RegEnable.scala 11:22]
    end else if (io_en) begin // @[RegEnable.scala 12:17]
      reg_ <= io_in; // @[RegEnable.scala 13:13]
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
  reg_ = _RAND_0[31:0];
`endif // RANDOMIZE_REG_INIT
  `endif // RANDOMIZE
end // initial
`ifdef FIRRTL_AFTER_INITIAL
`FIRRTL_AFTER_INITIAL
`endif
`endif // SYNTHESIS
endmodule
module RegEnable_1(
  input   clock,
  input   reset,
  input   io_in,
  input   io_en,
  output  io_out
);
`ifdef RANDOMIZE_REG_INIT
  reg [31:0] _RAND_0;
`endif // RANDOMIZE_REG_INIT
  reg  reg_; // @[RegEnable.scala 11:22]
  assign io_out = reg_; // @[RegEnable.scala 15:12]
  always @(posedge clock) begin
    if (reset) begin // @[RegEnable.scala 11:22]
      reg_ <= 1'h0; // @[RegEnable.scala 11:22]
    end else if (io_en) begin // @[RegEnable.scala 12:17]
      reg_ <= io_in; // @[RegEnable.scala 13:13]
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
  reg_ = _RAND_0[0:0];
`endif // RANDOMIZE_REG_INIT
  `endif // RANDOMIZE
end // initial
`ifdef FIRRTL_AFTER_INITIAL
`FIRRTL_AFTER_INITIAL
`endif
`endif // SYNTHESIS
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
  wire  reg_1_clock; // @[D_REG.scala 14:25]
  wire  reg_1_reset; // @[D_REG.scala 14:25]
  wire [31:0] reg_1_io_in; // @[D_REG.scala 14:25]
  wire  reg_1_io_en; // @[D_REG.scala 14:25]
  wire [31:0] reg_1_io_out; // @[D_REG.scala 14:25]
  wire  reg_2_clock; // @[D_REG.scala 15:25]
  wire  reg_2_reset; // @[D_REG.scala 15:25]
  wire  reg_2_io_in; // @[D_REG.scala 15:25]
  wire  reg_2_io_en; // @[D_REG.scala 15:25]
  wire  reg_2_io_out; // @[D_REG.scala 15:25]
  RegEnable reg_1 ( // @[D_REG.scala 14:25]
    .clock(reg_1_clock),
    .reset(reg_1_reset),
    .io_in(reg_1_io_in),
    .io_en(reg_1_io_en),
    .io_out(reg_1_io_out)
  );
  RegEnable_1 reg_2 ( // @[D_REG.scala 15:25]
    .clock(reg_2_clock),
    .reset(reg_2_reset),
    .io_in(reg_2_io_in),
    .io_en(reg_2_io_en),
    .io_out(reg_2_io_out)
  );
  assign io_dout = reg_1_io_out; // @[D_REG.scala 21:13]
  assign io_dout_v = reg_2_io_out; // @[D_REG.scala 22:15]
  assign io_din_r = io_dout_r; // @[D_REG.scala 23:14]
  assign reg_1_clock = clock;
  assign reg_1_reset = reset;
  assign reg_1_io_in = io_din; // @[D_REG.scala 17:17]
  assign reg_1_io_en = io_dout_r; // @[D_REG.scala 19:17]
  assign reg_2_clock = clock;
  assign reg_2_reset = reset;
  assign reg_2_io_in = io_din_v; // @[D_REG.scala 18:17]
  assign reg_2_io_en = io_dout_r; // @[D_REG.scala 20:17]
endmodule
module ConfMux_8(
  input  [2:0] io_selector,
  input  [5:0] io_mux_input,
  output       io_mux_output
);
  wire  inputs_0 = io_mux_input[0]; // @[ConfMux.scala 27:34]
  wire  inputs_1 = io_mux_input[1]; // @[ConfMux.scala 27:34]
  wire  inputs_2 = io_mux_input[2]; // @[ConfMux.scala 27:34]
  wire  inputs_3 = io_mux_input[3]; // @[ConfMux.scala 27:34]
  wire  inputs_4 = io_mux_input[4]; // @[ConfMux.scala 27:34]
  wire  inputs_5 = io_mux_input[5]; // @[ConfMux.scala 27:34]
  wire  _GEN_1 = 3'h1 == io_selector ? inputs_1 : inputs_0; // @[ConfMux.scala 30:{19,19}]
  wire  _GEN_2 = 3'h2 == io_selector ? inputs_2 : _GEN_1; // @[ConfMux.scala 30:{19,19}]
  wire  _GEN_3 = 3'h3 == io_selector ? inputs_3 : _GEN_2; // @[ConfMux.scala 30:{19,19}]
  wire  _GEN_4 = 3'h4 == io_selector ? inputs_4 : _GEN_3; // @[ConfMux.scala 30:{19,19}]
  assign io_mux_output = 3'h5 == io_selector ? inputs_5 : _GEN_4; // @[ConfMux.scala 30:{19,19}]
endmodule
module FR_4(
  input  [5:0] io_valid_in,
  input  [3:0] io_ready_out,
  input  [2:0] io_valid_mux_sel,
  input  [3:0] io_fork_mask,
  output       io_valid_out
);
  wire [2:0] conf_mux_io_selector; // @[FR.scala 29:28]
  wire [5:0] conf_mux_io_mux_input; // @[FR.scala 29:28]
  wire  conf_mux_io_mux_output; // @[FR.scala 29:28]
  wire  aux_0 = ~io_fork_mask[0] | io_ready_out[0]; // @[FR.scala 27:39]
  wire  aux_1 = ~io_fork_mask[1] | io_ready_out[1]; // @[FR.scala 27:39]
  wire  aux_2 = ~io_fork_mask[2] | io_ready_out[2]; // @[FR.scala 27:39]
  wire  aux_3 = ~io_fork_mask[3] | io_ready_out[3]; // @[FR.scala 27:39]
  wire  Vaux = conf_mux_io_mux_output; // @[FR.scala 24:20 32:28]
  wire  temp_1 = aux_0 & aux_1; // @[FR.scala 38:30]
  wire  temp_2 = temp_1 & aux_2; // @[FR.scala 38:30]
  wire  temp_3 = temp_2 & aux_3; // @[FR.scala 38:30]
  ConfMux_8 conf_mux ( // @[FR.scala 29:28]
    .io_selector(conf_mux_io_selector),
    .io_mux_input(conf_mux_io_mux_input),
    .io_mux_output(conf_mux_io_mux_output)
  );
  assign io_valid_out = temp_3 & Vaux; // @[FR.scala 38:30]
  assign conf_mux_io_selector = io_valid_mux_sel; // @[FR.scala 30:26]
  assign conf_mux_io_mux_input = io_valid_in; // @[FR.scala 31:27]
endmodule
module ConfMux_9(
  input  [2:0]   io_selector,
  input  [191:0] io_mux_input,
  output [31:0]  io_mux_output
);
  wire [31:0] inputs_0 = io_mux_input[31:0]; // @[ConfMux.scala 27:34]
  wire [31:0] inputs_1 = io_mux_input[63:32]; // @[ConfMux.scala 27:34]
  wire [31:0] inputs_2 = io_mux_input[95:64]; // @[ConfMux.scala 27:34]
  wire [31:0] inputs_3 = io_mux_input[127:96]; // @[ConfMux.scala 27:34]
  wire [31:0] inputs_4 = io_mux_input[159:128]; // @[ConfMux.scala 27:34]
  wire [31:0] inputs_5 = io_mux_input[191:160]; // @[ConfMux.scala 27:34]
  wire [31:0] _GEN_1 = 3'h1 == io_selector ? inputs_1 : inputs_0; // @[ConfMux.scala 30:{19,19}]
  wire [31:0] _GEN_2 = 3'h2 == io_selector ? inputs_2 : _GEN_1; // @[ConfMux.scala 30:{19,19}]
  wire [31:0] _GEN_3 = 3'h3 == io_selector ? inputs_3 : _GEN_2; // @[ConfMux.scala 30:{19,19}]
  wire [31:0] _GEN_4 = 3'h4 == io_selector ? inputs_4 : _GEN_3; // @[ConfMux.scala 30:{19,19}]
  assign io_mux_output = 3'h5 == io_selector ? inputs_5 : _GEN_4; // @[ConfMux.scala 30:{19,19}]
endmodule
module D_SEB(
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
`endif // RANDOMIZE_REG_INIT
  wire  main_clock; // @[D_SEB.scala 14:24]
  wire  main_reset; // @[D_SEB.scala 14:24]
  wire [31:0] main_io_in; // @[D_SEB.scala 14:24]
  wire  main_io_en; // @[D_SEB.scala 14:24]
  wire [31:0] main_io_out; // @[D_SEB.scala 14:24]
  wire  aux_clock; // @[D_SEB.scala 15:23]
  wire  aux_reset; // @[D_SEB.scala 15:23]
  wire [31:0] aux_io_in; // @[D_SEB.scala 15:23]
  wire  aux_io_en; // @[D_SEB.scala 15:23]
  wire [31:0] aux_io_out; // @[D_SEB.scala 15:23]
  wire  reg_1_clock; // @[D_SEB.scala 16:25]
  wire  reg_1_reset; // @[D_SEB.scala 16:25]
  wire  reg_1_io_in; // @[D_SEB.scala 16:25]
  wire  reg_1_io_en; // @[D_SEB.scala 16:25]
  wire  reg_1_io_out; // @[D_SEB.scala 16:25]
  wire  reg_2_clock; // @[D_SEB.scala 17:25]
  wire  reg_2_reset; // @[D_SEB.scala 17:25]
  wire  reg_2_io_in; // @[D_SEB.scala 17:25]
  wire  reg_2_io_en; // @[D_SEB.scala 17:25]
  wire  reg_2_io_out; // @[D_SEB.scala 17:25]
  reg  reg_; // @[D_SEB.scala 19:22]
  wire  mux2_out = reg_ ? reg_1_io_out : reg_2_io_out; // @[D_SEB.scala 23:23]
  RegEnable main ( // @[D_SEB.scala 14:24]
    .clock(main_clock),
    .reset(main_reset),
    .io_in(main_io_in),
    .io_en(main_io_en),
    .io_out(main_io_out)
  );
  RegEnable aux ( // @[D_SEB.scala 15:23]
    .clock(aux_clock),
    .reset(aux_reset),
    .io_in(aux_io_in),
    .io_en(aux_io_en),
    .io_out(aux_io_out)
  );
  RegEnable_1 reg_1 ( // @[D_SEB.scala 16:25]
    .clock(reg_1_clock),
    .reset(reg_1_reset),
    .io_in(reg_1_io_in),
    .io_en(reg_1_io_en),
    .io_out(reg_1_io_out)
  );
  RegEnable_1 reg_2 ( // @[D_SEB.scala 17:25]
    .clock(reg_2_clock),
    .reset(reg_2_reset),
    .io_in(reg_2_io_in),
    .io_en(reg_2_io_en),
    .io_out(reg_2_io_out)
  );
  assign io_din_r = reg_; // @[D_SEB.scala 25:20]
  assign io_dout = reg_ ? main_io_out : aux_io_out; // @[D_SEB.scala 41:19]
  assign io_dout_v = reg_ ? reg_1_io_out : reg_2_io_out; // @[D_SEB.scala 23:23]
  assign main_clock = clock;
  assign main_reset = reset;
  assign main_io_in = io_din; // @[D_SEB.scala 31:16]
  assign main_io_en = reg_; // @[D_SEB.scala 25:20]
  assign aux_clock = clock;
  assign aux_reset = reset;
  assign aux_io_in = main_io_out; // @[D_SEB.scala 32:15]
  assign aux_io_en = reg_; // @[D_SEB.scala 25:20]
  assign reg_1_clock = clock;
  assign reg_1_reset = reset;
  assign reg_1_io_in = io_din_v; // @[D_SEB.scala 33:17]
  assign reg_1_io_en = reg_; // @[D_SEB.scala 25:20]
  assign reg_2_clock = clock;
  assign reg_2_reset = reset;
  assign reg_2_io_in = reg_1_io_out; // @[D_SEB.scala 34:17]
  assign reg_2_io_en = reg_; // @[D_SEB.scala 25:20]
  always @(posedge clock) begin
    if (reset) begin // @[D_SEB.scala 19:22]
      reg_ <= 1'h0; // @[D_SEB.scala 19:22]
    end else begin
      reg_ <= io_dout_r | ~mux2_out; // @[D_SEB.scala 24:9]
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
  reg_ = _RAND_0[0:0];
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
  assign io_dout_v = io_din_1_v & io_din_2_v; // @[Join.scala 24:29]
  assign io_din_1_r = io_din_2_v & io_dout_r; // @[Join.scala 26:30]
  assign io_din_2_r = io_din_1_v & io_dout_r; // @[Join.scala 27:30]
  assign io_dout_1 = io_din_1; // @[Join.scala 21:15]
  assign io_dout_2 = io_din_2; // @[Join.scala 22:15]
endmodule
module ALU(
  input  [31:0] io_din_1,
  input  [31:0] io_din_2,
  input  [3:0]  io_op_config,
  output [31:0] io_dout
);
  wire [31:0] _io_dout_T_1 = io_din_1 + io_din_2; // @[ALU.scala 30:27]
  wire [63:0] _io_dout_T_2 = io_din_1 * io_din_2; // @[ALU.scala 33:27]
  wire [31:0] _io_dout_T_4 = io_din_1 - io_din_2; // @[ALU.scala 36:27]
  wire [31:0] _io_dout_T_5 = io_din_1 >> io_din_2; // @[ALU.scala 43:27]
  wire [31:0] _io_dout_T_6 = io_din_1 & io_din_2; // @[ALU.scala 46:27]
  wire [31:0] _io_dout_T_7 = io_din_1 | io_din_2; // @[ALU.scala 49:27]
  wire [31:0] _io_dout_T_8 = io_din_1 ^ io_din_2; // @[ALU.scala 52:27]
  wire [31:0] _GEN_0 = io_din_1 > io_din_2 ? io_din_2 : 32'h0; // @[ALU.scala 28:13 58:38 59:17]
  wire [31:0] _GEN_1 = io_din_1 <= io_din_2 ? io_din_1 : _GEN_0; // @[ALU.scala 55:35 56:17]
  wire [31:0] _GEN_2 = io_din_1 < io_din_2 ? io_din_2 : 32'h0; // @[ALU.scala 28:13 66:38 67:17]
  wire [31:0] _GEN_3 = io_din_1 >= io_din_2 ? io_din_1 : _GEN_2; // @[ALU.scala 63:35 64:17]
  wire [31:0] _GEN_4 = io_op_config == 4'h9 ? _GEN_3 : 32'h0; // @[ALU.scala 62:38 71:15]
  wire [31:0] _GEN_5 = io_op_config == 4'h8 ? _GEN_1 : _GEN_4; // @[ALU.scala 54:38]
  wire [31:0] _GEN_6 = io_op_config == 4'h7 ? _io_dout_T_8 : _GEN_5; // @[ALU.scala 51:38 52:15]
  wire [31:0] _GEN_7 = io_op_config == 4'h6 ? _io_dout_T_7 : _GEN_6; // @[ALU.scala 48:37 49:15]
  wire [31:0] _GEN_8 = io_op_config == 4'h5 ? _io_dout_T_6 : _GEN_7; // @[ALU.scala 45:38 46:15]
  wire [31:0] _GEN_9 = io_op_config == 4'h4 ? _io_dout_T_5 : _GEN_8; // @[ALU.scala 42:38 43:15]
  wire [31:0] _GEN_10 = io_op_config == 4'h3 ? 32'h1 : _GEN_9; // @[ALU.scala 38:38 40:15]
  wire [31:0] _GEN_11 = io_op_config == 4'h2 ? _io_dout_T_4 : _GEN_10; // @[ALU.scala 35:38 36:15]
  wire [63:0] _GEN_12 = io_op_config == 4'h1 ? _io_dout_T_2 : {{32'd0}, _GEN_11}; // @[ALU.scala 32:38 33:15]
  wire [63:0] _GEN_13 = io_op_config == 4'h0 ? {{32'd0}, _io_dout_T_1} : _GEN_12; // @[ALU.scala 29:33 30:15]
  assign io_dout = _GEN_13[31:0];
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
  input  [3:0]  io_op_config,
  output        io_din_r,
  output [31:0] io_dout,
  output        io_dout_v
);
`ifdef RANDOMIZE_REG_INIT
  reg [31:0] _RAND_0;
  reg [31:0] _RAND_1;
  reg [31:0] _RAND_2;
  reg [31:0] _RAND_3;
  reg [31:0] _RAND_4;
  reg [31:0] _RAND_5;
  reg [31:0] _RAND_6;
`endif // RANDOMIZE_REG_INIT
  wire [31:0] ALU_io_din_1; // @[FU.scala 49:22]
  wire [31:0] ALU_io_din_2; // @[FU.scala 49:22]
  wire [3:0] ALU_io_op_config; // @[FU.scala 49:22]
  wire [31:0] ALU_io_dout; // @[FU.scala 49:22]
  reg [31:0] alu_din_1; // @[FU.scala 38:28]
  reg [31:0] alu_din_2; // @[FU.scala 39:28]
  reg [31:0] alu_dout; // @[FU.scala 40:27]
  reg [31:0] dout_Reg; // @[FU.scala 41:27]
  reg [15:0] count; // @[FU.scala 45:24]
  reg  loaded; // @[FU.scala 46:25]
  reg  valid; // @[FU.scala 47:24]
  wire  _T = io_loop_source == 2'h0; // @[FU.scala 56:26]
  wire  _T_1 = io_loop_source == 2'h1; // @[FU.scala 60:31]
  wire  _T_2 = ~loaded; // @[FU.scala 61:22]
  wire  _T_3 = io_loop_source == 2'h2; // @[FU.scala 70:31]
  wire [31:0] _GEN_3 = _T_2 ? io_din_2 : dout_Reg; // @[FU.scala 71:31 73:23 77:23]
  wire  _GEN_10 = io_dout_r ? 1'h0 : valid; // @[FU.scala 95:34 96:19 47:24]
  wire  _T_13 = _T_1 | _T_3; // @[FU.scala 99:42]
  wire  _T_14 = io_din_v & io_dout_r & _T_13; // @[FU.scala 98:53]
  wire [15:0] _count_T_1 = count + 16'h1; // @[FU.scala 102:29]
  wire  _T_19 = count == io_iterations_reset & _T_13; // @[FU.scala 104:45]
  wire  _T_21 = _T_19 & io_dout_r; // @[FU.scala 105:73]
  wire  _T_26 = _T_13 & io_din_v; // @[FU.scala 113:79]
  wire  _T_28 = _T_26 & io_dout_r; // @[FU.scala 114:37]
  wire  _GEN_16 = _T_21 | _GEN_10; // @[FU.scala 107:13 110:22]
  ALU ALU ( // @[FU.scala 49:22]
    .io_din_1(ALU_io_din_1),
    .io_din_2(ALU_io_din_2),
    .io_op_config(ALU_io_op_config),
    .io_dout(ALU_io_dout)
  );
  assign io_din_r = io_dout_r; // @[FU.scala 128:14]
  assign io_dout = _T ? alu_dout : dout_Reg; // @[FU.scala 130:38 131:17 134:17]
  assign io_dout_v = _T ? io_din_v : valid; // @[FU.scala 121:38 122:19 125:19]
  assign ALU_io_din_1 = alu_din_1; // @[FU.scala 50:18]
  assign ALU_io_din_2 = alu_din_2; // @[FU.scala 51:18]
  assign ALU_io_op_config = io_op_config; // @[FU.scala 53:22]
  always @(posedge clock) begin
    if (reset) begin // @[FU.scala 38:28]
      alu_din_1 <= 32'h0; // @[FU.scala 38:28]
    end else if (io_loop_source == 2'h0) begin // @[FU.scala 56:39]
      alu_din_1 <= io_din_1; // @[FU.scala 57:19]
    end else if (io_loop_source == 2'h1) begin // @[FU.scala 60:44]
      if (~loaded) begin // @[FU.scala 61:31]
        alu_din_1 <= io_din_1; // @[FU.scala 62:23]
      end else begin
        alu_din_1 <= dout_Reg; // @[FU.scala 66:23]
      end
    end else if (io_loop_source == 2'h2) begin // @[FU.scala 70:44]
      alu_din_1 <= io_din_1;
    end else begin
      alu_din_1 <= 32'h1f; // @[FU.scala 81:19]
    end
    if (reset) begin // @[FU.scala 39:28]
      alu_din_2 <= 32'h0; // @[FU.scala 39:28]
    end else if (io_loop_source == 2'h0) begin // @[FU.scala 56:39]
      alu_din_2 <= io_din_2; // @[FU.scala 58:19]
    end else if (io_loop_source == 2'h1) begin // @[FU.scala 60:44]
      alu_din_2 <= io_din_2;
    end else if (io_loop_source == 2'h2) begin // @[FU.scala 70:44]
      alu_din_2 <= _GEN_3;
    end else begin
      alu_din_2 <= 32'h1f; // @[FU.scala 82:19]
    end
    if (reset) begin // @[FU.scala 40:27]
      alu_dout <= 32'h0; // @[FU.scala 40:27]
    end else begin
      alu_dout <= ALU_io_dout; // @[FU.scala 52:14]
    end
    if (reset) begin // @[FU.scala 41:27]
      dout_Reg <= 32'h0; // @[FU.scala 41:27]
    end else if (_T_21) begin // @[FU.scala 107:13]
      dout_Reg <= alu_dout; // @[FU.scala 111:22]
    end else if (_T_28) begin // @[FU.scala 116:13]
      dout_Reg <= alu_dout; // @[FU.scala 117:22]
    end else begin
      dout_Reg <= 32'h0; // @[FU.scala 89:18]
    end
    if (reset) begin // @[FU.scala 45:24]
      count <= 16'hffff; // @[FU.scala 45:24]
    end else if (_T_21) begin // @[FU.scala 107:13]
      count <= 16'h0; // @[FU.scala 108:22]
    end else if (_T_14) begin // @[FU.scala 100:13]
      count <= _count_T_1; // @[FU.scala 102:20]
    end else begin
      count <= 16'h0; // @[FU.scala 88:15]
    end
    if (reset) begin // @[FU.scala 46:25]
      loaded <= 1'h0; // @[FU.scala 46:25]
    end else if (_T_21) begin // @[FU.scala 107:13]
      loaded <= 1'h0; // @[FU.scala 109:22]
    end else begin
      loaded <= _T_14;
    end
    if (reset) begin // @[FU.scala 47:24]
      valid <= 1'h0; // @[FU.scala 47:24]
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
  alu_din_1 = _RAND_0[31:0];
  _RAND_1 = {1{`RANDOM}};
  alu_din_2 = _RAND_1[31:0];
  _RAND_2 = {1{`RANDOM}};
  alu_dout = _RAND_2[31:0];
  _RAND_3 = {1{`RANDOM}};
  dout_Reg = _RAND_3[31:0];
  _RAND_4 = {1{`RANDOM}};
  count = _RAND_4[15:0];
  _RAND_5 = {1{`RANDOM}};
  loaded = _RAND_5[0:0];
  _RAND_6 = {1{`RANDOM}};
  valid = _RAND_6[0:0];
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
`ifdef RANDOMIZE_REG_INIT
  reg [31:0] _RAND_0;
  reg [31:0] _RAND_1;
  reg [31:0] _RAND_2;
  reg [31:0] _RAND_3;
  reg [31:0] _RAND_4;
  reg [31:0] _RAND_5;
  reg [31:0] _RAND_6;
  reg [31:0] _RAND_7;
  reg [31:0] _RAND_8;
  reg [31:0] _RAND_9;
  reg [31:0] _RAND_10;
  reg [31:0] _RAND_11;
  reg [31:0] _RAND_12;
  reg [31:0] _RAND_13;
  reg [31:0] _RAND_14;
`endif // RANDOMIZE_REG_INIT
  wire [5:0] FR_1_io_valid_in; // @[CellProcessing.scala 83:23]
  wire [3:0] FR_1_io_ready_out; // @[CellProcessing.scala 83:23]
  wire [2:0] FR_1_io_valid_mux_sel; // @[CellProcessing.scala 83:23]
  wire [3:0] FR_1_io_fork_mask; // @[CellProcessing.scala 83:23]
  wire  FR_1_io_valid_out; // @[CellProcessing.scala 83:23]
  wire [2:0] MUX_1_io_selector; // @[CellProcessing.scala 92:25]
  wire [191:0] MUX_1_io_mux_input; // @[CellProcessing.scala 92:25]
  wire [31:0] MUX_1_io_mux_output; // @[CellProcessing.scala 92:25]
  wire  SEB_1_clock; // @[CellProcessing.scala 97:24]
  wire  SEB_1_reset; // @[CellProcessing.scala 97:24]
  wire [31:0] SEB_1_io_din; // @[CellProcessing.scala 97:24]
  wire  SEB_1_io_din_v; // @[CellProcessing.scala 97:24]
  wire  SEB_1_io_din_r; // @[CellProcessing.scala 97:24]
  wire [31:0] SEB_1_io_dout; // @[CellProcessing.scala 97:24]
  wire  SEB_1_io_dout_v; // @[CellProcessing.scala 97:24]
  wire  SEB_1_io_dout_r; // @[CellProcessing.scala 97:24]
  wire [5:0] FR_2_io_valid_in; // @[CellProcessing.scala 105:23]
  wire [3:0] FR_2_io_ready_out; // @[CellProcessing.scala 105:23]
  wire [2:0] FR_2_io_valid_mux_sel; // @[CellProcessing.scala 105:23]
  wire [3:0] FR_2_io_fork_mask; // @[CellProcessing.scala 105:23]
  wire  FR_2_io_valid_out; // @[CellProcessing.scala 105:23]
  wire [2:0] MUX_2_io_selector; // @[CellProcessing.scala 114:25]
  wire [191:0] MUX_2_io_mux_input; // @[CellProcessing.scala 114:25]
  wire [31:0] MUX_2_io_mux_output; // @[CellProcessing.scala 114:25]
  wire  SEB_2_clock; // @[CellProcessing.scala 119:24]
  wire  SEB_2_reset; // @[CellProcessing.scala 119:24]
  wire [31:0] SEB_2_io_din; // @[CellProcessing.scala 119:24]
  wire  SEB_2_io_din_v; // @[CellProcessing.scala 119:24]
  wire  SEB_2_io_din_r; // @[CellProcessing.scala 119:24]
  wire [31:0] SEB_2_io_dout; // @[CellProcessing.scala 119:24]
  wire  SEB_2_io_dout_v; // @[CellProcessing.scala 119:24]
  wire  SEB_2_io_dout_r; // @[CellProcessing.scala 119:24]
  wire [31:0] JOIN_INST_io_din_1; // @[CellProcessing.scala 127:28]
  wire [31:0] JOIN_INST_io_din_2; // @[CellProcessing.scala 127:28]
  wire  JOIN_INST_io_dout_r; // @[CellProcessing.scala 127:28]
  wire  JOIN_INST_io_din_1_v; // @[CellProcessing.scala 127:28]
  wire  JOIN_INST_io_din_2_v; // @[CellProcessing.scala 127:28]
  wire  JOIN_INST_io_dout_v; // @[CellProcessing.scala 127:28]
  wire  JOIN_INST_io_din_1_r; // @[CellProcessing.scala 127:28]
  wire  JOIN_INST_io_din_2_r; // @[CellProcessing.scala 127:28]
  wire [31:0] JOIN_INST_io_dout_1; // @[CellProcessing.scala 127:28]
  wire [31:0] JOIN_INST_io_dout_2; // @[CellProcessing.scala 127:28]
  wire  FU_INST_clock; // @[CellProcessing.scala 140:26]
  wire  FU_INST_reset; // @[CellProcessing.scala 140:26]
  wire [31:0] FU_INST_io_din_1; // @[CellProcessing.scala 140:26]
  wire [31:0] FU_INST_io_din_2; // @[CellProcessing.scala 140:26]
  wire  FU_INST_io_din_v; // @[CellProcessing.scala 140:26]
  wire  FU_INST_io_dout_r; // @[CellProcessing.scala 140:26]
  wire [1:0] FU_INST_io_loop_source; // @[CellProcessing.scala 140:26]
  wire [15:0] FU_INST_io_iterations_reset; // @[CellProcessing.scala 140:26]
  wire [3:0] FU_INST_io_op_config; // @[CellProcessing.scala 140:26]
  wire  FU_INST_io_din_r; // @[CellProcessing.scala 140:26]
  wire [31:0] FU_INST_io_dout; // @[CellProcessing.scala 140:26]
  wire  FU_INST_io_dout_v; // @[CellProcessing.scala 140:26]
  wire  SEB_OUT_clock; // @[CellProcessing.scala 153:26]
  wire  SEB_OUT_reset; // @[CellProcessing.scala 153:26]
  wire [31:0] SEB_OUT_io_din; // @[CellProcessing.scala 153:26]
  wire  SEB_OUT_io_din_v; // @[CellProcessing.scala 153:26]
  wire  SEB_OUT_io_din_r; // @[CellProcessing.scala 153:26]
  wire [31:0] SEB_OUT_io_dout; // @[CellProcessing.scala 153:26]
  wire  SEB_OUT_io_dout_v; // @[CellProcessing.scala 153:26]
  wire  SEB_OUT_io_dout_r; // @[CellProcessing.scala 153:26]
  wire [4:0] FS_io_ready_out; // @[CellProcessing.scala 161:21]
  wire [4:0] FS_io_fork_mask; // @[CellProcessing.scala 161:21]
  wire  FS_io_ready_in; // @[CellProcessing.scala 161:21]
  reg [2:0] selector_mux_1; // @[CellProcessing.scala 32:33]
  reg [2:0] selector_mux_2; // @[CellProcessing.scala 33:33]
  reg [3:0] fork_receiver_mask_1; // @[CellProcessing.scala 34:39]
  reg [3:0] fork_receiver_mask_2; // @[CellProcessing.scala 35:39]
  reg [4:0] op_config; // @[CellProcessing.scala 36:28]
  reg [4:0] fork_sender_mask; // @[CellProcessing.scala 37:35]
  reg [31:0] I1_const; // @[CellProcessing.scala 38:27]
  reg [15:0] iterations_reset_load; // @[CellProcessing.scala 40:40]
  reg [1:0] load_initial_value; // @[CellProcessing.scala 42:37]
  reg [31:0] FU_dout; // @[CellProcessing.scala 45:26]
  reg [31:0] EB_din_1; // @[CellProcessing.scala 46:27]
  reg [31:0] EB_din_2; // @[CellProcessing.scala 47:27]
  reg [31:0] join_din_1; // @[CellProcessing.scala 48:29]
  reg [31:0] join_dout_1; // @[CellProcessing.scala 50:30]
  reg [31:0] join_dout_2; // @[CellProcessing.scala 51:30]
  wire [1:0] ready_FR1_lo = {io_south_dout_r,io_west_dout_r}; // @[Cat.scala 31:58]
  wire [1:0] ready_FR1_hi = {io_north_dout_r,io_east_dout_r}; // @[Cat.scala 31:58]
  wire [2:0] valid_in_FR1_lo = {io_south_din_v,io_east_din_v,io_north_din_v}; // @[Cat.scala 31:58]
  wire  FU_dout_v = FU_INST_io_dout_v; // @[CellProcessing.scala 150:15 53:25]
  wire [2:0] valid_in_FR1_hi = {FU_dout_v,1'h1,io_west_din_v}; // @[Cat.scala 31:58]
  wire [31:0] _MUX_1_io_mux_input_T = FU_dout & I1_const; // @[CellProcessing.scala 94:35]
  wire [31:0] _MUX_1_io_mux_input_T_1 = _MUX_1_io_mux_input_T & io_west_din; // @[CellProcessing.scala 94:46]
  wire [31:0] _MUX_1_io_mux_input_T_2 = _MUX_1_io_mux_input_T_1 & io_south_din; // @[CellProcessing.scala 94:60]
  wire [31:0] _MUX_1_io_mux_input_T_3 = _MUX_1_io_mux_input_T_2 & io_east_din; // @[CellProcessing.scala 94:75]
  wire [31:0] _MUX_1_io_mux_input_T_4 = _MUX_1_io_mux_input_T_3 & io_north_din; // @[CellProcessing.scala 94:89]
  wire [2:0] ready_out_FS_hi = {1'h1,io_north_dout_r,io_east_dout_r}; // @[Cat.scala 31:58]
  wire  join_din_1_v = SEB_1_io_dout_v; // @[CellProcessing.scala 102:18 57:28]
  FR_4 FR_1 ( // @[CellProcessing.scala 83:23]
    .io_valid_in(FR_1_io_valid_in),
    .io_ready_out(FR_1_io_ready_out),
    .io_valid_mux_sel(FR_1_io_valid_mux_sel),
    .io_fork_mask(FR_1_io_fork_mask),
    .io_valid_out(FR_1_io_valid_out)
  );
  ConfMux_9 MUX_1 ( // @[CellProcessing.scala 92:25]
    .io_selector(MUX_1_io_selector),
    .io_mux_input(MUX_1_io_mux_input),
    .io_mux_output(MUX_1_io_mux_output)
  );
  D_SEB SEB_1 ( // @[CellProcessing.scala 97:24]
    .clock(SEB_1_clock),
    .reset(SEB_1_reset),
    .io_din(SEB_1_io_din),
    .io_din_v(SEB_1_io_din_v),
    .io_din_r(SEB_1_io_din_r),
    .io_dout(SEB_1_io_dout),
    .io_dout_v(SEB_1_io_dout_v),
    .io_dout_r(SEB_1_io_dout_r)
  );
  FR_4 FR_2 ( // @[CellProcessing.scala 105:23]
    .io_valid_in(FR_2_io_valid_in),
    .io_ready_out(FR_2_io_ready_out),
    .io_valid_mux_sel(FR_2_io_valid_mux_sel),
    .io_fork_mask(FR_2_io_fork_mask),
    .io_valid_out(FR_2_io_valid_out)
  );
  ConfMux_9 MUX_2 ( // @[CellProcessing.scala 114:25]
    .io_selector(MUX_2_io_selector),
    .io_mux_input(MUX_2_io_mux_input),
    .io_mux_output(MUX_2_io_mux_output)
  );
  D_SEB SEB_2 ( // @[CellProcessing.scala 119:24]
    .clock(SEB_2_clock),
    .reset(SEB_2_reset),
    .io_din(SEB_2_io_din),
    .io_din_v(SEB_2_io_din_v),
    .io_din_r(SEB_2_io_din_r),
    .io_dout(SEB_2_io_dout),
    .io_dout_v(SEB_2_io_dout_v),
    .io_dout_r(SEB_2_io_dout_r)
  );
  Join JOIN_INST ( // @[CellProcessing.scala 127:28]
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
  FU FU_INST ( // @[CellProcessing.scala 140:26]
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
  D_SEB SEB_OUT ( // @[CellProcessing.scala 153:26]
    .clock(SEB_OUT_clock),
    .reset(SEB_OUT_reset),
    .io_din(SEB_OUT_io_din),
    .io_din_v(SEB_OUT_io_din_v),
    .io_din_r(SEB_OUT_io_din_r),
    .io_dout(SEB_OUT_io_dout),
    .io_dout_v(SEB_OUT_io_dout_v),
    .io_dout_r(SEB_OUT_io_dout_r)
  );
  FS FS ( // @[CellProcessing.scala 161:21]
    .io_ready_out(FS_io_ready_out),
    .io_fork_mask(FS_io_fork_mask),
    .io_ready_in(FS_io_ready_in)
  );
  assign io_FU_din_1_r = SEB_1_io_din_r; // @[CellProcessing.scala 100:20]
  assign io_FU_din_2_r = SEB_2_io_din_r; // @[CellProcessing.scala 122:19]
  assign io_dout = SEB_OUT_io_dout; // @[CellProcessing.scala 157:13]
  assign io_dout_v = SEB_OUT_io_dout_v; // @[CellProcessing.scala 158:15]
  assign FR_1_io_valid_in = {valid_in_FR1_hi,valid_in_FR1_lo}; // @[Cat.scala 31:58]
  assign FR_1_io_ready_out = {ready_FR1_hi,ready_FR1_lo}; // @[Cat.scala 31:58]
  assign FR_1_io_valid_mux_sel = selector_mux_1; // @[CellProcessing.scala 88:27]
  assign FR_1_io_fork_mask = fork_receiver_mask_1; // @[CellProcessing.scala 89:23]
  assign MUX_1_io_selector = selector_mux_1; // @[CellProcessing.scala 93:23]
  assign MUX_1_io_mux_input = {{160'd0}, _MUX_1_io_mux_input_T_4}; // @[CellProcessing.scala 94:24]
  assign SEB_1_clock = clock;
  assign SEB_1_reset = reset;
  assign SEB_1_io_din = EB_din_1; // @[CellProcessing.scala 98:18]
  assign SEB_1_io_din_v = FR_1_io_valid_out; // @[CellProcessing.scala 55:26 90:16]
  assign SEB_1_io_dout_r = JOIN_INST_io_din_1_r; // @[CellProcessing.scala 135:18 58:28]
  assign FR_2_io_valid_in = {valid_in_FR1_hi,valid_in_FR1_lo}; // @[Cat.scala 31:58]
  assign FR_2_io_ready_out = {ready_FR1_hi,ready_FR1_lo}; // @[Cat.scala 31:58]
  assign FR_2_io_valid_mux_sel = selector_mux_2; // @[CellProcessing.scala 110:27]
  assign FR_2_io_fork_mask = fork_receiver_mask_2; // @[CellProcessing.scala 111:23]
  assign MUX_2_io_selector = selector_mux_2; // @[CellProcessing.scala 115:23]
  assign MUX_2_io_mux_input = {{160'd0}, _MUX_1_io_mux_input_T_4}; // @[CellProcessing.scala 116:24]
  assign SEB_2_clock = clock;
  assign SEB_2_reset = reset;
  assign SEB_2_io_din = EB_din_2; // @[CellProcessing.scala 120:18]
  assign SEB_2_io_din_v = FR_2_io_valid_out; // @[CellProcessing.scala 112:16 56:26]
  assign SEB_2_io_dout_r = JOIN_INST_io_din_2_r; // @[CellProcessing.scala 136:18 60:28]
  assign JOIN_INST_io_din_1 = join_din_1; // @[CellProcessing.scala 128:24]
  assign JOIN_INST_io_din_2 = {{31'd0}, join_din_1_v}; // @[CellProcessing.scala 129:24]
  assign JOIN_INST_io_dout_r = FU_INST_io_din_r; // @[CellProcessing.scala 144:17 62:27]
  assign JOIN_INST_io_din_1_v = SEB_1_io_dout_v; // @[CellProcessing.scala 102:18 57:28]
  assign JOIN_INST_io_din_2_v = SEB_1_io_dout_v; // @[CellProcessing.scala 124:18 59:28]
  assign FU_INST_clock = clock;
  assign FU_INST_reset = reset;
  assign FU_INST_io_din_1 = join_dout_1; // @[CellProcessing.scala 141:22]
  assign FU_INST_io_din_2 = join_dout_2; // @[CellProcessing.scala 142:22]
  assign FU_INST_io_din_v = JOIN_INST_io_dout_v; // @[CellProcessing.scala 134:17 61:27]
  assign FU_INST_io_dout_r = SEB_OUT_io_din_r; // @[CellProcessing.scala 156:15 54:25]
  assign FU_INST_io_loop_source = load_initial_value; // @[CellProcessing.scala 145:28]
  assign FU_INST_io_iterations_reset = iterations_reset_load; // @[CellProcessing.scala 146:33]
  assign FU_INST_io_op_config = op_config[3:0]; // @[CellProcessing.scala 147:26]
  assign SEB_OUT_clock = clock;
  assign SEB_OUT_reset = reset;
  assign SEB_OUT_io_din = FU_dout; // @[CellProcessing.scala 154:20]
  assign SEB_OUT_io_din_v = FU_INST_io_dout_v; // @[CellProcessing.scala 150:15 53:25]
  assign SEB_OUT_io_dout_r = FS_io_ready_in; // @[CellProcessing.scala 164:19 63:29]
  assign FS_io_ready_out = {ready_out_FS_hi,ready_FR1_lo}; // @[Cat.scala 31:58]
  assign FS_io_fork_mask = fork_sender_mask; // @[CellProcessing.scala 165:21]
  always @(posedge clock) begin
    if (reset) begin // @[CellProcessing.scala 32:33]
      selector_mux_1 <= 3'h0; // @[CellProcessing.scala 32:33]
    end else begin
      selector_mux_1 <= io_config_bits[2:0]; // @[CellProcessing.scala 66:20]
    end
    if (reset) begin // @[CellProcessing.scala 33:33]
      selector_mux_2 <= 3'h0; // @[CellProcessing.scala 33:33]
    end else begin
      selector_mux_2 <= io_config_bits[5:3]; // @[CellProcessing.scala 67:20]
    end
    if (reset) begin // @[CellProcessing.scala 34:39]
      fork_receiver_mask_1 <= 4'h0; // @[CellProcessing.scala 34:39]
    end else begin
      fork_receiver_mask_1 <= io_config_bits[17:14]; // @[CellProcessing.scala 68:26]
    end
    if (reset) begin // @[CellProcessing.scala 35:39]
      fork_receiver_mask_2 <= 4'h0; // @[CellProcessing.scala 35:39]
    end else begin
      fork_receiver_mask_2 <= io_config_bits[23:20]; // @[CellProcessing.scala 70:26]
    end
    if (reset) begin // @[CellProcessing.scala 36:28]
      op_config <= 5'h0; // @[CellProcessing.scala 36:28]
    end else begin
      op_config <= io_config_bits[48:44]; // @[CellProcessing.scala 72:15]
    end
    if (reset) begin // @[CellProcessing.scala 37:35]
      fork_sender_mask <= 5'h0; // @[CellProcessing.scala 37:35]
    end else begin
      fork_sender_mask <= io_config_bits[56:52]; // @[CellProcessing.scala 74:22]
    end
    if (reset) begin // @[CellProcessing.scala 38:27]
      I1_const <= 32'h0; // @[CellProcessing.scala 38:27]
    end else begin
      I1_const <= io_config_bits[115:84]; // @[CellProcessing.scala 76:15]
    end
    if (reset) begin // @[CellProcessing.scala 40:40]
      iterations_reset_load <= 16'h0; // @[CellProcessing.scala 40:40]
    end else begin
      iterations_reset_load <= io_config_bits[179:164]; // @[CellProcessing.scala 80:27]
    end
    if (reset) begin // @[CellProcessing.scala 42:37]
      load_initial_value <= 2'h0; // @[CellProcessing.scala 42:37]
    end else begin
      load_initial_value <= io_config_bits[181:180]; // @[CellProcessing.scala 81:24]
    end
    if (reset) begin // @[CellProcessing.scala 45:26]
      FU_dout <= 32'h0; // @[CellProcessing.scala 45:26]
    end else begin
      FU_dout <= FU_INST_io_dout; // @[CellProcessing.scala 149:13]
    end
    if (reset) begin // @[CellProcessing.scala 46:27]
      EB_din_1 <= 32'h0; // @[CellProcessing.scala 46:27]
    end else begin
      EB_din_1 <= MUX_1_io_mux_output; // @[CellProcessing.scala 95:14]
    end
    if (reset) begin // @[CellProcessing.scala 47:27]
      EB_din_2 <= 32'h0; // @[CellProcessing.scala 47:27]
    end else begin
      EB_din_2 <= MUX_2_io_mux_output; // @[CellProcessing.scala 117:14]
    end
    if (reset) begin // @[CellProcessing.scala 48:29]
      join_din_1 <= 32'h0; // @[CellProcessing.scala 48:29]
    end else begin
      join_din_1 <= SEB_1_io_dout; // @[CellProcessing.scala 101:16]
    end
    if (reset) begin // @[CellProcessing.scala 50:30]
      join_dout_1 <= 32'h0; // @[CellProcessing.scala 50:30]
    end else begin
      join_dout_1 <= JOIN_INST_io_dout_1; // @[CellProcessing.scala 137:17]
    end
    if (reset) begin // @[CellProcessing.scala 51:30]
      join_dout_2 <= 32'h0; // @[CellProcessing.scala 51:30]
    end else begin
      join_dout_2 <= JOIN_INST_io_dout_2; // @[CellProcessing.scala 138:17]
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
  selector_mux_1 = _RAND_0[2:0];
  _RAND_1 = {1{`RANDOM}};
  selector_mux_2 = _RAND_1[2:0];
  _RAND_2 = {1{`RANDOM}};
  fork_receiver_mask_1 = _RAND_2[3:0];
  _RAND_3 = {1{`RANDOM}};
  fork_receiver_mask_2 = _RAND_3[3:0];
  _RAND_4 = {1{`RANDOM}};
  op_config = _RAND_4[4:0];
  _RAND_5 = {1{`RANDOM}};
  fork_sender_mask = _RAND_5[4:0];
  _RAND_6 = {1{`RANDOM}};
  I1_const = _RAND_6[31:0];
  _RAND_7 = {1{`RANDOM}};
  iterations_reset_load = _RAND_7[15:0];
  _RAND_8 = {1{`RANDOM}};
  load_initial_value = _RAND_8[1:0];
  _RAND_9 = {1{`RANDOM}};
  FU_dout = _RAND_9[31:0];
  _RAND_10 = {1{`RANDOM}};
  EB_din_1 = _RAND_10[31:0];
  _RAND_11 = {1{`RANDOM}};
  EB_din_2 = _RAND_11[31:0];
  _RAND_12 = {1{`RANDOM}};
  join_din_1 = _RAND_12[31:0];
  _RAND_13 = {1{`RANDOM}};
  join_dout_1 = _RAND_13[31:0];
  _RAND_14 = {1{`RANDOM}};
  join_dout_2 = _RAND_14[31:0];
`endif // RANDOMIZE_REG_INIT
  `endif // RANDOMIZE
end // initial
`ifdef FIRRTL_AFTER_INITIAL
`FIRRTL_AFTER_INITIAL
`endif
`endif // SYNTHESIS
endmodule
module ProcessingElement(
  input          clock,
  input          reset,
  input  [31:0]  io_north_din,
  input          io_north_din_v,
  output         io_north_din_r,
  output         io_east_din_r,
  output         io_south_din_r,
  input  [31:0]  io_west_din,
  input          io_west_din_v,
  input          io_north_dout_r,
  output [31:0]  io_east_dout,
  output         io_east_dout_v,
  input          io_east_dout_r,
  output [31:0]  io_south_dout,
  output         io_south_dout_v,
  input          io_west_dout_r,
  input  [181:0] io_config_bits,
  input          io_catch_config
);
`ifdef RANDOMIZE_REG_INIT
  reg [31:0] _RAND_0;
  reg [31:0] _RAND_1;
  reg [31:0] _RAND_2;
  reg [31:0] _RAND_3;
  reg [31:0] _RAND_4;
  reg [31:0] _RAND_5;
  reg [31:0] _RAND_6;
  reg [31:0] _RAND_7;
  reg [31:0] _RAND_8;
  reg [31:0] _RAND_9;
  reg [31:0] _RAND_10;
  reg [31:0] _RAND_11;
  reg [191:0] _RAND_12;
  reg [31:0] _RAND_13;
  reg [31:0] _RAND_14;
  reg [31:0] _RAND_15;
  reg [31:0] _RAND_16;
  reg [31:0] _RAND_17;
  reg [31:0] _RAND_18;
  reg [31:0] _RAND_19;
  reg [31:0] _RAND_20;
  reg [31:0] _RAND_21;
  reg [31:0] _RAND_22;
  reg [31:0] _RAND_23;
  reg [31:0] _RAND_24;
  reg [31:0] _RAND_25;
  reg [31:0] _RAND_26;
  reg [31:0] _RAND_27;
  reg [31:0] _RAND_28;
  reg [31:0] _RAND_29;
  reg [31:0] _RAND_30;
  reg [31:0] _RAND_31;
  reg [31:0] _RAND_32;
  reg [31:0] _RAND_33;
  reg [31:0] _RAND_34;
  reg [31:0] _RAND_35;
  reg [31:0] _RAND_36;
  reg [31:0] _RAND_37;
  reg [31:0] _RAND_38;
  reg [31:0] _RAND_39;
  reg [31:0] _RAND_40;
`endif // RANDOMIZE_REG_INIT
  wire  FIFO_Nin_clock; // @[ProcessingElement.scala 120:27]
  wire  FIFO_Nin_reset; // @[ProcessingElement.scala 120:27]
  wire [31:0] FIFO_Nin_io_din; // @[ProcessingElement.scala 120:27]
  wire  FIFO_Nin_io_din_v; // @[ProcessingElement.scala 120:27]
  wire  FIFO_Nin_io_dout_r; // @[ProcessingElement.scala 120:27]
  wire  FIFO_Nin_io_din_r; // @[ProcessingElement.scala 120:27]
  wire [31:0] FIFO_Nin_io_dout; // @[ProcessingElement.scala 120:27]
  wire  FIFO_Nin_io_dout_v; // @[ProcessingElement.scala 120:27]
  wire [4:0] FS_Nin_io_ready_out; // @[ProcessingElement.scala 128:25]
  wire [4:0] FS_Nin_io_fork_mask; // @[ProcessingElement.scala 128:25]
  wire  FS_Nin_io_ready_in; // @[ProcessingElement.scala 128:25]
  wire [1:0] MUX_Nout_io_selector; // @[ProcessingElement.scala 134:28]
  wire [127:0] MUX_Nout_io_mux_input; // @[ProcessingElement.scala 134:28]
  wire [31:0] MUX_Nout_io_mux_output; // @[ProcessingElement.scala 134:28]
  wire [3:0] FR_Nout_io_valid_in; // @[ProcessingElement.scala 139:26]
  wire [4:0] FR_Nout_io_ready_out; // @[ProcessingElement.scala 139:26]
  wire [1:0] FR_Nout_io_valid_mux_sel; // @[ProcessingElement.scala 139:26]
  wire [4:0] FR_Nout_io_fork_mask; // @[ProcessingElement.scala 139:26]
  wire  FR_Nout_io_valid_out; // @[ProcessingElement.scala 139:26]
  wire  REG_Nout_clock; // @[ProcessingElement.scala 148:27]
  wire  REG_Nout_reset; // @[ProcessingElement.scala 148:27]
  wire [31:0] REG_Nout_io_din; // @[ProcessingElement.scala 148:27]
  wire  REG_Nout_io_din_v; // @[ProcessingElement.scala 148:27]
  wire  REG_Nout_io_dout_r; // @[ProcessingElement.scala 148:27]
  wire [31:0] REG_Nout_io_dout; // @[ProcessingElement.scala 148:27]
  wire  REG_Nout_io_dout_v; // @[ProcessingElement.scala 148:27]
  wire  REG_Nout_io_din_r; // @[ProcessingElement.scala 148:27]
  wire  FIFO_Ein_clock; // @[ProcessingElement.scala 162:27]
  wire  FIFO_Ein_reset; // @[ProcessingElement.scala 162:27]
  wire [31:0] FIFO_Ein_io_din; // @[ProcessingElement.scala 162:27]
  wire  FIFO_Ein_io_din_v; // @[ProcessingElement.scala 162:27]
  wire  FIFO_Ein_io_dout_r; // @[ProcessingElement.scala 162:27]
  wire  FIFO_Ein_io_din_r; // @[ProcessingElement.scala 162:27]
  wire [31:0] FIFO_Ein_io_dout; // @[ProcessingElement.scala 162:27]
  wire  FIFO_Ein_io_dout_v; // @[ProcessingElement.scala 162:27]
  wire [4:0] FS_Ein_io_ready_out; // @[ProcessingElement.scala 170:25]
  wire [4:0] FS_Ein_io_fork_mask; // @[ProcessingElement.scala 170:25]
  wire  FS_Ein_io_ready_in; // @[ProcessingElement.scala 170:25]
  wire [1:0] MUX_Eout_io_selector; // @[ProcessingElement.scala 176:28]
  wire [127:0] MUX_Eout_io_mux_input; // @[ProcessingElement.scala 176:28]
  wire [31:0] MUX_Eout_io_mux_output; // @[ProcessingElement.scala 176:28]
  wire [3:0] FR_Eout_io_valid_in; // @[ProcessingElement.scala 181:26]
  wire [4:0] FR_Eout_io_ready_out; // @[ProcessingElement.scala 181:26]
  wire [1:0] FR_Eout_io_valid_mux_sel; // @[ProcessingElement.scala 181:26]
  wire [4:0] FR_Eout_io_fork_mask; // @[ProcessingElement.scala 181:26]
  wire  FR_Eout_io_valid_out; // @[ProcessingElement.scala 181:26]
  wire  REG_Eout_clock; // @[ProcessingElement.scala 190:27]
  wire  REG_Eout_reset; // @[ProcessingElement.scala 190:27]
  wire [31:0] REG_Eout_io_din; // @[ProcessingElement.scala 190:27]
  wire  REG_Eout_io_din_v; // @[ProcessingElement.scala 190:27]
  wire  REG_Eout_io_dout_r; // @[ProcessingElement.scala 190:27]
  wire [31:0] REG_Eout_io_dout; // @[ProcessingElement.scala 190:27]
  wire  REG_Eout_io_dout_v; // @[ProcessingElement.scala 190:27]
  wire  REG_Eout_io_din_r; // @[ProcessingElement.scala 190:27]
  wire  FIFO_Sin_clock; // @[ProcessingElement.scala 203:27]
  wire  FIFO_Sin_reset; // @[ProcessingElement.scala 203:27]
  wire [31:0] FIFO_Sin_io_din; // @[ProcessingElement.scala 203:27]
  wire  FIFO_Sin_io_din_v; // @[ProcessingElement.scala 203:27]
  wire  FIFO_Sin_io_dout_r; // @[ProcessingElement.scala 203:27]
  wire  FIFO_Sin_io_din_r; // @[ProcessingElement.scala 203:27]
  wire [31:0] FIFO_Sin_io_dout; // @[ProcessingElement.scala 203:27]
  wire  FIFO_Sin_io_dout_v; // @[ProcessingElement.scala 203:27]
  wire [4:0] FS_Sin_io_ready_out; // @[ProcessingElement.scala 211:25]
  wire [4:0] FS_Sin_io_fork_mask; // @[ProcessingElement.scala 211:25]
  wire  FS_Sin_io_ready_in; // @[ProcessingElement.scala 211:25]
  wire [1:0] MUX_Sout_io_selector; // @[ProcessingElement.scala 217:28]
  wire [127:0] MUX_Sout_io_mux_input; // @[ProcessingElement.scala 217:28]
  wire [31:0] MUX_Sout_io_mux_output; // @[ProcessingElement.scala 217:28]
  wire [3:0] FR_Sout_io_valid_in; // @[ProcessingElement.scala 222:26]
  wire [4:0] FR_Sout_io_ready_out; // @[ProcessingElement.scala 222:26]
  wire [1:0] FR_Sout_io_valid_mux_sel; // @[ProcessingElement.scala 222:26]
  wire [4:0] FR_Sout_io_fork_mask; // @[ProcessingElement.scala 222:26]
  wire  FR_Sout_io_valid_out; // @[ProcessingElement.scala 222:26]
  wire  REG_Sout_clock; // @[ProcessingElement.scala 231:27]
  wire  REG_Sout_reset; // @[ProcessingElement.scala 231:27]
  wire [31:0] REG_Sout_io_din; // @[ProcessingElement.scala 231:27]
  wire  REG_Sout_io_din_v; // @[ProcessingElement.scala 231:27]
  wire  REG_Sout_io_dout_r; // @[ProcessingElement.scala 231:27]
  wire [31:0] REG_Sout_io_dout; // @[ProcessingElement.scala 231:27]
  wire  REG_Sout_io_dout_v; // @[ProcessingElement.scala 231:27]
  wire  REG_Sout_io_din_r; // @[ProcessingElement.scala 231:27]
  wire  FIFO_Win_clock; // @[ProcessingElement.scala 244:27]
  wire  FIFO_Win_reset; // @[ProcessingElement.scala 244:27]
  wire [31:0] FIFO_Win_io_din; // @[ProcessingElement.scala 244:27]
  wire  FIFO_Win_io_din_v; // @[ProcessingElement.scala 244:27]
  wire  FIFO_Win_io_dout_r; // @[ProcessingElement.scala 244:27]
  wire  FIFO_Win_io_din_r; // @[ProcessingElement.scala 244:27]
  wire [31:0] FIFO_Win_io_dout; // @[ProcessingElement.scala 244:27]
  wire  FIFO_Win_io_dout_v; // @[ProcessingElement.scala 244:27]
  wire [4:0] FS_Win_io_ready_out; // @[ProcessingElement.scala 252:25]
  wire [4:0] FS_Win_io_fork_mask; // @[ProcessingElement.scala 252:25]
  wire  FS_Win_io_ready_in; // @[ProcessingElement.scala 252:25]
  wire [1:0] MUX_Wout_io_selector; // @[ProcessingElement.scala 258:28]
  wire [127:0] MUX_Wout_io_mux_input; // @[ProcessingElement.scala 258:28]
  wire [31:0] MUX_Wout_io_mux_output; // @[ProcessingElement.scala 258:28]
  wire [3:0] FR_Wout_io_valid_in; // @[ProcessingElement.scala 263:26]
  wire [4:0] FR_Wout_io_ready_out; // @[ProcessingElement.scala 263:26]
  wire [1:0] FR_Wout_io_valid_mux_sel; // @[ProcessingElement.scala 263:26]
  wire [4:0] FR_Wout_io_fork_mask; // @[ProcessingElement.scala 263:26]
  wire  FR_Wout_io_valid_out; // @[ProcessingElement.scala 263:26]
  wire  REG_Wout_clock; // @[ProcessingElement.scala 272:27]
  wire  REG_Wout_reset; // @[ProcessingElement.scala 272:27]
  wire [31:0] REG_Wout_io_din; // @[ProcessingElement.scala 272:27]
  wire  REG_Wout_io_din_v; // @[ProcessingElement.scala 272:27]
  wire  REG_Wout_io_dout_r; // @[ProcessingElement.scala 272:27]
  wire [31:0] REG_Wout_io_dout; // @[ProcessingElement.scala 272:27]
  wire  REG_Wout_io_dout_v; // @[ProcessingElement.scala 272:27]
  wire  REG_Wout_io_din_r; // @[ProcessingElement.scala 272:27]
  wire  CELL_clock; // @[ProcessingElement.scala 284:23]
  wire  CELL_reset; // @[ProcessingElement.scala 284:23]
  wire [31:0] CELL_io_north_din; // @[ProcessingElement.scala 284:23]
  wire  CELL_io_north_din_v; // @[ProcessingElement.scala 284:23]
  wire [31:0] CELL_io_east_din; // @[ProcessingElement.scala 284:23]
  wire  CELL_io_east_din_v; // @[ProcessingElement.scala 284:23]
  wire [31:0] CELL_io_south_din; // @[ProcessingElement.scala 284:23]
  wire  CELL_io_south_din_v; // @[ProcessingElement.scala 284:23]
  wire [31:0] CELL_io_west_din; // @[ProcessingElement.scala 284:23]
  wire  CELL_io_west_din_v; // @[ProcessingElement.scala 284:23]
  wire  CELL_io_FU_din_1_r; // @[ProcessingElement.scala 284:23]
  wire  CELL_io_FU_din_2_r; // @[ProcessingElement.scala 284:23]
  wire [31:0] CELL_io_dout; // @[ProcessingElement.scala 284:23]
  wire  CELL_io_dout_v; // @[ProcessingElement.scala 284:23]
  wire  CELL_io_north_dout_r; // @[ProcessingElement.scala 284:23]
  wire  CELL_io_east_dout_r; // @[ProcessingElement.scala 284:23]
  wire  CELL_io_south_dout_r; // @[ProcessingElement.scala 284:23]
  wire  CELL_io_west_dout_r; // @[ProcessingElement.scala 284:23]
  wire [181:0] CELL_io_config_bits; // @[ProcessingElement.scala 284:23]
  reg [1:0] mux_N_sel; // @[ProcessingElement.scala 47:28]
  reg [1:0] mux_E_sel; // @[ProcessingElement.scala 48:28]
  reg [1:0] mux_S_sel; // @[ProcessingElement.scala 49:28]
  reg [1:0] mux_W_sel; // @[ProcessingElement.scala 50:28]
  reg [4:0] accept_mask_frN; // @[ProcessingElement.scala 51:34]
  reg [4:0] accept_mask_frE; // @[ProcessingElement.scala 52:34]
  reg [4:0] accept_mask_frS; // @[ProcessingElement.scala 53:34]
  reg [4:0] accept_mask_frW; // @[ProcessingElement.scala 54:34]
  reg [4:0] accept_mask_fsiN; // @[ProcessingElement.scala 55:35]
  reg [4:0] accept_mask_fsiE; // @[ProcessingElement.scala 56:35]
  reg [4:0] accept_mask_fsiS; // @[ProcessingElement.scala 57:35]
  reg [4:0] accept_mask_fsiW; // @[ProcessingElement.scala 58:35]
  reg [181:0] config_bits_reg; // @[ProcessingElement.scala 59:34]
  reg [31:0] north_buffer; // @[ProcessingElement.scala 63:31]
  reg [31:0] east_buffer; // @[ProcessingElement.scala 64:30]
  reg [31:0] south_buffer; // @[ProcessingElement.scala 65:31]
  reg [31:0] west_buffer; // @[ProcessingElement.scala 66:30]
  reg  north_buffer_v; // @[ProcessingElement.scala 68:33]
  reg  east_buffer_v; // @[ProcessingElement.scala 69:32]
  reg  south_buffer_v; // @[ProcessingElement.scala 70:33]
  reg  west_buffer_v; // @[ProcessingElement.scala 71:32]
  reg  north_buffer_r; // @[ProcessingElement.scala 73:33]
  reg  east_buffer_r; // @[ProcessingElement.scala 74:32]
  reg  south_buffer_r; // @[ProcessingElement.scala 75:33]
  reg  west_buffer_r; // @[ProcessingElement.scala 76:32]
  reg [31:0] north_REG_din; // @[ProcessingElement.scala 78:32]
  reg [31:0] east_REG_din; // @[ProcessingElement.scala 79:31]
  reg [31:0] south_REG_din; // @[ProcessingElement.scala 80:32]
  reg [31:0] west_REG_din; // @[ProcessingElement.scala 81:31]
  reg  north_REG_din_v; // @[ProcessingElement.scala 83:34]
  reg  east_REG_din_v; // @[ProcessingElement.scala 84:33]
  reg  south_REG_din_v; // @[ProcessingElement.scala 85:34]
  reg  west_REG_din_v; // @[ProcessingElement.scala 86:33]
  reg  north_REG_din_r; // @[ProcessingElement.scala 87:34]
  reg  east_REG_din_r; // @[ProcessingElement.scala 88:33]
  reg  south_REG_din_r; // @[ProcessingElement.scala 89:34]
  reg  west_REG_din_r; // @[ProcessingElement.scala 90:33]
  reg  FU_din_1_r; // @[ProcessingElement.scala 92:29]
  reg  FU_din_2_r; // @[ProcessingElement.scala 93:29]
  reg [31:0] FU_dout; // @[ProcessingElement.scala 94:26]
  reg  FU_dout_v; // @[ProcessingElement.scala 95:28]
  wire [1:0] ready_out_FS_Nin_lo = {south_REG_din_r,west_REG_din_r}; // @[Cat.scala 31:58]
  wire [2:0] ready_out_FS_Nin_hi = {FU_din_1_r,FU_din_2_r,east_REG_din_r}; // @[Cat.scala 31:58]
  wire [31:0] _MUX_Nout_io_mux_input_T = west_buffer & south_buffer; // @[ProcessingElement.scala 136:42]
  wire [31:0] _MUX_Nout_io_mux_input_T_1 = _MUX_Nout_io_mux_input_T & east_buffer; // @[ProcessingElement.scala 136:57]
  wire [31:0] _MUX_Nout_io_mux_input_T_2 = _MUX_Nout_io_mux_input_T_1 & FU_dout; // @[ProcessingElement.scala 136:71]
  wire [1:0] valid_in_FR_Nout_lo = {east_buffer_v,FU_dout_v}; // @[Cat.scala 31:58]
  wire [1:0] valid_in_FR_Nout_hi = {west_buffer_v,south_buffer_v}; // @[Cat.scala 31:58]
  wire [2:0] ready_out_FS_Ein_hi = {FU_din_1_r,FU_din_2_r,north_REG_din_r}; // @[Cat.scala 31:58]
  wire [31:0] _MUX_Eout_io_mux_input_T_1 = _MUX_Nout_io_mux_input_T & north_buffer; // @[ProcessingElement.scala 178:57]
  wire [31:0] _MUX_Eout_io_mux_input_T_2 = _MUX_Eout_io_mux_input_T_1 & FU_dout; // @[ProcessingElement.scala 178:72]
  wire [1:0] valid_in_FR_Eout_lo = {north_buffer_v,FU_dout_v}; // @[Cat.scala 31:58]
  wire [1:0] ready_out_FS_Sin_lo = {east_REG_din_r,west_REG_din_r}; // @[Cat.scala 31:58]
  wire [31:0] _MUX_Sout_io_mux_input_T = west_buffer & east_buffer; // @[ProcessingElement.scala 219:42]
  wire [31:0] _MUX_Sout_io_mux_input_T_1 = _MUX_Sout_io_mux_input_T & north_buffer; // @[ProcessingElement.scala 219:56]
  wire [31:0] _MUX_Sout_io_mux_input_T_2 = _MUX_Sout_io_mux_input_T_1 & FU_dout; // @[ProcessingElement.scala 219:71]
  wire [1:0] valid_in_FR_Sout_hi = {west_buffer_v,east_buffer_v}; // @[Cat.scala 31:58]
  wire [1:0] ready_out_FS_Win_lo = {east_REG_din_r,south_REG_din_r}; // @[Cat.scala 31:58]
  wire [31:0] _MUX_Wout_io_mux_input_T = south_buffer & east_buffer; // @[ProcessingElement.scala 260:43]
  wire [31:0] _MUX_Wout_io_mux_input_T_1 = _MUX_Wout_io_mux_input_T & north_buffer; // @[ProcessingElement.scala 260:57]
  wire [31:0] _MUX_Wout_io_mux_input_T_2 = _MUX_Wout_io_mux_input_T_1 & FU_dout; // @[ProcessingElement.scala 260:72]
  wire [1:0] valid_in_FR_Wout_hi = {south_buffer_v,east_buffer_v}; // @[Cat.scala 31:58]
  D_FIFO FIFO_Nin ( // @[ProcessingElement.scala 120:27]
    .clock(FIFO_Nin_clock),
    .reset(FIFO_Nin_reset),
    .io_din(FIFO_Nin_io_din),
    .io_din_v(FIFO_Nin_io_din_v),
    .io_dout_r(FIFO_Nin_io_dout_r),
    .io_din_r(FIFO_Nin_io_din_r),
    .io_dout(FIFO_Nin_io_dout),
    .io_dout_v(FIFO_Nin_io_dout_v)
  );
  FS FS_Nin ( // @[ProcessingElement.scala 128:25]
    .io_ready_out(FS_Nin_io_ready_out),
    .io_fork_mask(FS_Nin_io_fork_mask),
    .io_ready_in(FS_Nin_io_ready_in)
  );
  ConfMux MUX_Nout ( // @[ProcessingElement.scala 134:28]
    .io_selector(MUX_Nout_io_selector),
    .io_mux_input(MUX_Nout_io_mux_input),
    .io_mux_output(MUX_Nout_io_mux_output)
  );
  FR FR_Nout ( // @[ProcessingElement.scala 139:26]
    .io_valid_in(FR_Nout_io_valid_in),
    .io_ready_out(FR_Nout_io_ready_out),
    .io_valid_mux_sel(FR_Nout_io_valid_mux_sel),
    .io_fork_mask(FR_Nout_io_fork_mask),
    .io_valid_out(FR_Nout_io_valid_out)
  );
  D_REG REG_Nout ( // @[ProcessingElement.scala 148:27]
    .clock(REG_Nout_clock),
    .reset(REG_Nout_reset),
    .io_din(REG_Nout_io_din),
    .io_din_v(REG_Nout_io_din_v),
    .io_dout_r(REG_Nout_io_dout_r),
    .io_dout(REG_Nout_io_dout),
    .io_dout_v(REG_Nout_io_dout_v),
    .io_din_r(REG_Nout_io_din_r)
  );
  D_FIFO FIFO_Ein ( // @[ProcessingElement.scala 162:27]
    .clock(FIFO_Ein_clock),
    .reset(FIFO_Ein_reset),
    .io_din(FIFO_Ein_io_din),
    .io_din_v(FIFO_Ein_io_din_v),
    .io_dout_r(FIFO_Ein_io_dout_r),
    .io_din_r(FIFO_Ein_io_din_r),
    .io_dout(FIFO_Ein_io_dout),
    .io_dout_v(FIFO_Ein_io_dout_v)
  );
  FS FS_Ein ( // @[ProcessingElement.scala 170:25]
    .io_ready_out(FS_Ein_io_ready_out),
    .io_fork_mask(FS_Ein_io_fork_mask),
    .io_ready_in(FS_Ein_io_ready_in)
  );
  ConfMux MUX_Eout ( // @[ProcessingElement.scala 176:28]
    .io_selector(MUX_Eout_io_selector),
    .io_mux_input(MUX_Eout_io_mux_input),
    .io_mux_output(MUX_Eout_io_mux_output)
  );
  FR FR_Eout ( // @[ProcessingElement.scala 181:26]
    .io_valid_in(FR_Eout_io_valid_in),
    .io_ready_out(FR_Eout_io_ready_out),
    .io_valid_mux_sel(FR_Eout_io_valid_mux_sel),
    .io_fork_mask(FR_Eout_io_fork_mask),
    .io_valid_out(FR_Eout_io_valid_out)
  );
  D_REG REG_Eout ( // @[ProcessingElement.scala 190:27]
    .clock(REG_Eout_clock),
    .reset(REG_Eout_reset),
    .io_din(REG_Eout_io_din),
    .io_din_v(REG_Eout_io_din_v),
    .io_dout_r(REG_Eout_io_dout_r),
    .io_dout(REG_Eout_io_dout),
    .io_dout_v(REG_Eout_io_dout_v),
    .io_din_r(REG_Eout_io_din_r)
  );
  D_FIFO FIFO_Sin ( // @[ProcessingElement.scala 203:27]
    .clock(FIFO_Sin_clock),
    .reset(FIFO_Sin_reset),
    .io_din(FIFO_Sin_io_din),
    .io_din_v(FIFO_Sin_io_din_v),
    .io_dout_r(FIFO_Sin_io_dout_r),
    .io_din_r(FIFO_Sin_io_din_r),
    .io_dout(FIFO_Sin_io_dout),
    .io_dout_v(FIFO_Sin_io_dout_v)
  );
  FS FS_Sin ( // @[ProcessingElement.scala 211:25]
    .io_ready_out(FS_Sin_io_ready_out),
    .io_fork_mask(FS_Sin_io_fork_mask),
    .io_ready_in(FS_Sin_io_ready_in)
  );
  ConfMux MUX_Sout ( // @[ProcessingElement.scala 217:28]
    .io_selector(MUX_Sout_io_selector),
    .io_mux_input(MUX_Sout_io_mux_input),
    .io_mux_output(MUX_Sout_io_mux_output)
  );
  FR FR_Sout ( // @[ProcessingElement.scala 222:26]
    .io_valid_in(FR_Sout_io_valid_in),
    .io_ready_out(FR_Sout_io_ready_out),
    .io_valid_mux_sel(FR_Sout_io_valid_mux_sel),
    .io_fork_mask(FR_Sout_io_fork_mask),
    .io_valid_out(FR_Sout_io_valid_out)
  );
  D_REG REG_Sout ( // @[ProcessingElement.scala 231:27]
    .clock(REG_Sout_clock),
    .reset(REG_Sout_reset),
    .io_din(REG_Sout_io_din),
    .io_din_v(REG_Sout_io_din_v),
    .io_dout_r(REG_Sout_io_dout_r),
    .io_dout(REG_Sout_io_dout),
    .io_dout_v(REG_Sout_io_dout_v),
    .io_din_r(REG_Sout_io_din_r)
  );
  D_FIFO FIFO_Win ( // @[ProcessingElement.scala 244:27]
    .clock(FIFO_Win_clock),
    .reset(FIFO_Win_reset),
    .io_din(FIFO_Win_io_din),
    .io_din_v(FIFO_Win_io_din_v),
    .io_dout_r(FIFO_Win_io_dout_r),
    .io_din_r(FIFO_Win_io_din_r),
    .io_dout(FIFO_Win_io_dout),
    .io_dout_v(FIFO_Win_io_dout_v)
  );
  FS FS_Win ( // @[ProcessingElement.scala 252:25]
    .io_ready_out(FS_Win_io_ready_out),
    .io_fork_mask(FS_Win_io_fork_mask),
    .io_ready_in(FS_Win_io_ready_in)
  );
  ConfMux MUX_Wout ( // @[ProcessingElement.scala 258:28]
    .io_selector(MUX_Wout_io_selector),
    .io_mux_input(MUX_Wout_io_mux_input),
    .io_mux_output(MUX_Wout_io_mux_output)
  );
  FR FR_Wout ( // @[ProcessingElement.scala 263:26]
    .io_valid_in(FR_Wout_io_valid_in),
    .io_ready_out(FR_Wout_io_ready_out),
    .io_valid_mux_sel(FR_Wout_io_valid_mux_sel),
    .io_fork_mask(FR_Wout_io_fork_mask),
    .io_valid_out(FR_Wout_io_valid_out)
  );
  D_REG REG_Wout ( // @[ProcessingElement.scala 272:27]
    .clock(REG_Wout_clock),
    .reset(REG_Wout_reset),
    .io_din(REG_Wout_io_din),
    .io_din_v(REG_Wout_io_din_v),
    .io_dout_r(REG_Wout_io_dout_r),
    .io_dout(REG_Wout_io_dout),
    .io_dout_v(REG_Wout_io_dout_v),
    .io_din_r(REG_Wout_io_din_r)
  );
  CellProcessing CELL ( // @[ProcessingElement.scala 284:23]
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
  assign io_north_din_r = FIFO_Nin_io_din_r; // @[ProcessingElement.scala 124:20]
  assign io_east_din_r = FIFO_Ein_io_din_r; // @[ProcessingElement.scala 166:19]
  assign io_south_din_r = FIFO_Sin_io_din_r; // @[ProcessingElement.scala 207:20]
  assign io_east_dout = REG_Eout_io_dout; // @[ProcessingElement.scala 197:18]
  assign io_east_dout_v = REG_Eout_io_dout_v; // @[ProcessingElement.scala 198:20]
  assign io_south_dout = REG_Sout_io_dout; // @[ProcessingElement.scala 238:19]
  assign io_south_dout_v = REG_Sout_io_dout_v; // @[ProcessingElement.scala 239:21]
  assign FIFO_Nin_clock = clock;
  assign FIFO_Nin_reset = reset;
  assign FIFO_Nin_io_din = io_north_din; // @[ProcessingElement.scala 121:21]
  assign FIFO_Nin_io_din_v = io_north_din_v; // @[ProcessingElement.scala 122:23]
  assign FIFO_Nin_io_dout_r = north_buffer_r; // @[ProcessingElement.scala 123:24]
  assign FS_Nin_io_ready_out = {ready_out_FS_Nin_hi,ready_out_FS_Nin_lo}; // @[Cat.scala 31:58]
  assign FS_Nin_io_fork_mask = accept_mask_fsiN; // @[ProcessingElement.scala 132:25]
  assign MUX_Nout_io_selector = mux_N_sel; // @[ProcessingElement.scala 135:26]
  assign MUX_Nout_io_mux_input = {{96'd0}, _MUX_Nout_io_mux_input_T_2}; // @[ProcessingElement.scala 136:27]
  assign FR_Nout_io_valid_in = {valid_in_FR_Nout_hi,valid_in_FR_Nout_lo}; // @[Cat.scala 31:58]
  assign FR_Nout_io_ready_out = {ready_out_FS_Nin_hi,ready_out_FS_Nin_lo}; // @[Cat.scala 31:58]
  assign FR_Nout_io_valid_mux_sel = mux_N_sel; // @[ProcessingElement.scala 144:30]
  assign FR_Nout_io_fork_mask = accept_mask_frN; // @[ProcessingElement.scala 145:26]
  assign REG_Nout_clock = clock;
  assign REG_Nout_reset = reset;
  assign REG_Nout_io_din = north_REG_din; // @[ProcessingElement.scala 150:21]
  assign REG_Nout_io_din_v = north_REG_din_v; // @[ProcessingElement.scala 151:23]
  assign REG_Nout_io_dout_r = io_north_dout_r; // @[ProcessingElement.scala 152:24]
  assign FIFO_Ein_clock = clock;
  assign FIFO_Ein_reset = reset;
  assign FIFO_Ein_io_din = 32'h0; // @[ProcessingElement.scala 163:21]
  assign FIFO_Ein_io_din_v = 1'h0; // @[ProcessingElement.scala 164:23]
  assign FIFO_Ein_io_dout_r = east_buffer_r; // @[ProcessingElement.scala 165:24]
  assign FS_Ein_io_ready_out = {ready_out_FS_Ein_hi,ready_out_FS_Nin_lo}; // @[Cat.scala 31:58]
  assign FS_Ein_io_fork_mask = accept_mask_fsiE; // @[ProcessingElement.scala 174:25]
  assign MUX_Eout_io_selector = mux_E_sel; // @[ProcessingElement.scala 177:26]
  assign MUX_Eout_io_mux_input = {{96'd0}, _MUX_Eout_io_mux_input_T_2}; // @[ProcessingElement.scala 178:27]
  assign FR_Eout_io_valid_in = {valid_in_FR_Nout_hi,valid_in_FR_Eout_lo}; // @[Cat.scala 31:58]
  assign FR_Eout_io_ready_out = {ready_out_FS_Ein_hi,ready_out_FS_Nin_lo}; // @[Cat.scala 31:58]
  assign FR_Eout_io_valid_mux_sel = mux_E_sel; // @[ProcessingElement.scala 186:30]
  assign FR_Eout_io_fork_mask = accept_mask_frE; // @[ProcessingElement.scala 187:26]
  assign REG_Eout_clock = clock;
  assign REG_Eout_reset = reset;
  assign REG_Eout_io_din = east_REG_din; // @[ProcessingElement.scala 192:21]
  assign REG_Eout_io_din_v = east_REG_din_v; // @[ProcessingElement.scala 193:23]
  assign REG_Eout_io_dout_r = io_east_dout_r; // @[ProcessingElement.scala 194:24]
  assign FIFO_Sin_clock = clock;
  assign FIFO_Sin_reset = reset;
  assign FIFO_Sin_io_din = 32'h0; // @[ProcessingElement.scala 204:21]
  assign FIFO_Sin_io_din_v = 1'h0; // @[ProcessingElement.scala 205:23]
  assign FIFO_Sin_io_dout_r = south_buffer_r; // @[ProcessingElement.scala 206:24]
  assign FS_Sin_io_ready_out = {ready_out_FS_Ein_hi,ready_out_FS_Sin_lo}; // @[Cat.scala 31:58]
  assign FS_Sin_io_fork_mask = accept_mask_fsiS; // @[ProcessingElement.scala 215:25]
  assign MUX_Sout_io_selector = mux_S_sel; // @[ProcessingElement.scala 218:26]
  assign MUX_Sout_io_mux_input = {{96'd0}, _MUX_Sout_io_mux_input_T_2}; // @[ProcessingElement.scala 219:27]
  assign FR_Sout_io_valid_in = {valid_in_FR_Sout_hi,valid_in_FR_Eout_lo}; // @[Cat.scala 31:58]
  assign FR_Sout_io_ready_out = {ready_out_FS_Ein_hi,ready_out_FS_Sin_lo}; // @[Cat.scala 31:58]
  assign FR_Sout_io_valid_mux_sel = mux_S_sel; // @[ProcessingElement.scala 227:30]
  assign FR_Sout_io_fork_mask = accept_mask_frS; // @[ProcessingElement.scala 228:26]
  assign REG_Sout_clock = clock;
  assign REG_Sout_reset = reset;
  assign REG_Sout_io_din = south_REG_din; // @[ProcessingElement.scala 233:21]
  assign REG_Sout_io_din_v = south_REG_din_v; // @[ProcessingElement.scala 234:23]
  assign REG_Sout_io_dout_r = 1'h0; // @[ProcessingElement.scala 235:24]
  assign FIFO_Win_clock = clock;
  assign FIFO_Win_reset = reset;
  assign FIFO_Win_io_din = io_west_din; // @[ProcessingElement.scala 245:21]
  assign FIFO_Win_io_din_v = io_west_din_v; // @[ProcessingElement.scala 246:23]
  assign FIFO_Win_io_dout_r = west_buffer_r; // @[ProcessingElement.scala 247:24]
  assign FS_Win_io_ready_out = {ready_out_FS_Ein_hi,ready_out_FS_Win_lo}; // @[Cat.scala 31:58]
  assign FS_Win_io_fork_mask = accept_mask_fsiW; // @[ProcessingElement.scala 256:25]
  assign MUX_Wout_io_selector = mux_W_sel; // @[ProcessingElement.scala 259:26]
  assign MUX_Wout_io_mux_input = {{96'd0}, _MUX_Wout_io_mux_input_T_2}; // @[ProcessingElement.scala 260:27]
  assign FR_Wout_io_valid_in = {valid_in_FR_Wout_hi,valid_in_FR_Eout_lo}; // @[Cat.scala 31:58]
  assign FR_Wout_io_ready_out = {ready_out_FS_Ein_hi,ready_out_FS_Win_lo}; // @[Cat.scala 31:58]
  assign FR_Wout_io_valid_mux_sel = mux_W_sel; // @[ProcessingElement.scala 268:30]
  assign FR_Wout_io_fork_mask = accept_mask_frW; // @[ProcessingElement.scala 269:26]
  assign REG_Wout_clock = clock;
  assign REG_Wout_reset = reset;
  assign REG_Wout_io_din = west_REG_din; // @[ProcessingElement.scala 274:21]
  assign REG_Wout_io_din_v = west_REG_din_v; // @[ProcessingElement.scala 275:23]
  assign REG_Wout_io_dout_r = io_west_dout_r; // @[ProcessingElement.scala 276:24]
  assign CELL_clock = clock;
  assign CELL_reset = reset;
  assign CELL_io_north_din = north_buffer; // @[ProcessingElement.scala 285:23]
  assign CELL_io_north_din_v = north_buffer_v; // @[ProcessingElement.scala 286:25]
  assign CELL_io_east_din = east_buffer; // @[ProcessingElement.scala 287:22]
  assign CELL_io_east_din_v = east_buffer_v; // @[ProcessingElement.scala 288:24]
  assign CELL_io_south_din = south_buffer; // @[ProcessingElement.scala 289:23]
  assign CELL_io_south_din_v = south_buffer_v; // @[ProcessingElement.scala 290:25]
  assign CELL_io_west_din = west_buffer; // @[ProcessingElement.scala 291:22]
  assign CELL_io_west_din_v = west_buffer_v; // @[ProcessingElement.scala 292:24]
  assign CELL_io_north_dout_r = north_REG_din_r; // @[ProcessingElement.scala 293:26]
  assign CELL_io_east_dout_r = east_REG_din_r; // @[ProcessingElement.scala 294:25]
  assign CELL_io_south_dout_r = south_REG_din_r; // @[ProcessingElement.scala 295:26]
  assign CELL_io_west_dout_r = west_REG_din_r; // @[ProcessingElement.scala 296:25]
  assign CELL_io_config_bits = config_bits_reg; // @[ProcessingElement.scala 297:25]
  always @(posedge clock) begin
    if (reset) begin // @[ProcessingElement.scala 47:28]
      mux_N_sel <= 2'h0; // @[ProcessingElement.scala 47:28]
    end else begin
      mux_N_sel <= config_bits_reg[7:6]; // @[ProcessingElement.scala 103:15]
    end
    if (reset) begin // @[ProcessingElement.scala 48:28]
      mux_E_sel <= 2'h0; // @[ProcessingElement.scala 48:28]
    end else begin
      mux_E_sel <= config_bits_reg[9:8]; // @[ProcessingElement.scala 104:15]
    end
    if (reset) begin // @[ProcessingElement.scala 49:28]
      mux_S_sel <= 2'h0; // @[ProcessingElement.scala 49:28]
    end else begin
      mux_S_sel <= config_bits_reg[11:10]; // @[ProcessingElement.scala 105:15]
    end
    if (reset) begin // @[ProcessingElement.scala 50:28]
      mux_W_sel <= 2'h0; // @[ProcessingElement.scala 50:28]
    end else begin
      mux_W_sel <= config_bits_reg[13:12]; // @[ProcessingElement.scala 106:15]
    end
    if (reset) begin // @[ProcessingElement.scala 51:34]
      accept_mask_frN <= 5'h0; // @[ProcessingElement.scala 51:34]
    end else begin
      accept_mask_frN <= config_bits_reg[61:57]; // @[ProcessingElement.scala 113:21]
    end
    if (reset) begin // @[ProcessingElement.scala 52:34]
      accept_mask_frE <= 5'h0; // @[ProcessingElement.scala 52:34]
    end else begin
      accept_mask_frE <= config_bits_reg[66:62]; // @[ProcessingElement.scala 114:21]
    end
    if (reset) begin // @[ProcessingElement.scala 53:34]
      accept_mask_frS <= 5'h0; // @[ProcessingElement.scala 53:34]
    end else begin
      accept_mask_frS <= config_bits_reg[71:67]; // @[ProcessingElement.scala 115:21]
    end
    if (reset) begin // @[ProcessingElement.scala 54:34]
      accept_mask_frW <= 5'h0; // @[ProcessingElement.scala 54:34]
    end else begin
      accept_mask_frW <= config_bits_reg[76:72]; // @[ProcessingElement.scala 116:21]
    end
    if (reset) begin // @[ProcessingElement.scala 55:35]
      accept_mask_fsiN <= 5'h0; // @[ProcessingElement.scala 55:35]
    end else begin
      accept_mask_fsiN <= config_bits_reg[28:24]; // @[ProcessingElement.scala 108:22]
    end
    if (reset) begin // @[ProcessingElement.scala 56:35]
      accept_mask_fsiE <= 5'h0; // @[ProcessingElement.scala 56:35]
    end else begin
      accept_mask_fsiE <= config_bits_reg[33:29]; // @[ProcessingElement.scala 109:22]
    end
    if (reset) begin // @[ProcessingElement.scala 57:35]
      accept_mask_fsiS <= 5'h0; // @[ProcessingElement.scala 57:35]
    end else begin
      accept_mask_fsiS <= config_bits_reg[38:34]; // @[ProcessingElement.scala 110:22]
    end
    if (reset) begin // @[ProcessingElement.scala 58:35]
      accept_mask_fsiW <= 5'h0; // @[ProcessingElement.scala 58:35]
    end else begin
      accept_mask_fsiW <= config_bits_reg[43:39]; // @[ProcessingElement.scala 111:22]
    end
    if (reset) begin // @[ProcessingElement.scala 59:34]
      config_bits_reg <= 182'h0; // @[ProcessingElement.scala 59:34]
    end else if (io_catch_config) begin // @[ProcessingElement.scala 98:28]
      config_bits_reg <= io_config_bits; // @[ProcessingElement.scala 99:25]
    end
    if (reset) begin // @[ProcessingElement.scala 63:31]
      north_buffer <= 32'h0; // @[ProcessingElement.scala 63:31]
    end else begin
      north_buffer <= FIFO_Nin_io_dout; // @[ProcessingElement.scala 125:18]
    end
    if (reset) begin // @[ProcessingElement.scala 64:30]
      east_buffer <= 32'h0; // @[ProcessingElement.scala 64:30]
    end else begin
      east_buffer <= FIFO_Ein_io_dout; // @[ProcessingElement.scala 167:17]
    end
    if (reset) begin // @[ProcessingElement.scala 65:31]
      south_buffer <= 32'h0; // @[ProcessingElement.scala 65:31]
    end else begin
      south_buffer <= FIFO_Sin_io_dout; // @[ProcessingElement.scala 208:18]
    end
    if (reset) begin // @[ProcessingElement.scala 66:30]
      west_buffer <= 32'h0; // @[ProcessingElement.scala 66:30]
    end else begin
      west_buffer <= FIFO_Win_io_dout; // @[ProcessingElement.scala 249:17]
    end
    if (reset) begin // @[ProcessingElement.scala 68:33]
      north_buffer_v <= 1'h0; // @[ProcessingElement.scala 68:33]
    end else begin
      north_buffer_v <= FIFO_Nin_io_dout_v; // @[ProcessingElement.scala 126:20]
    end
    if (reset) begin // @[ProcessingElement.scala 69:32]
      east_buffer_v <= 1'h0; // @[ProcessingElement.scala 69:32]
    end else begin
      east_buffer_v <= FIFO_Ein_io_dout_v; // @[ProcessingElement.scala 168:19]
    end
    if (reset) begin // @[ProcessingElement.scala 70:33]
      south_buffer_v <= 1'h0; // @[ProcessingElement.scala 70:33]
    end else begin
      south_buffer_v <= FIFO_Sin_io_dout_v; // @[ProcessingElement.scala 209:20]
    end
    if (reset) begin // @[ProcessingElement.scala 71:32]
      west_buffer_v <= 1'h0; // @[ProcessingElement.scala 71:32]
    end else begin
      west_buffer_v <= FIFO_Win_io_dout_v; // @[ProcessingElement.scala 250:19]
    end
    if (reset) begin // @[ProcessingElement.scala 73:33]
      north_buffer_r <= 1'h0; // @[ProcessingElement.scala 73:33]
    end else begin
      north_buffer_r <= FS_Nin_io_ready_in; // @[ProcessingElement.scala 131:20]
    end
    if (reset) begin // @[ProcessingElement.scala 74:32]
      east_buffer_r <= 1'h0; // @[ProcessingElement.scala 74:32]
    end else begin
      east_buffer_r <= FS_Ein_io_ready_in; // @[ProcessingElement.scala 173:19]
    end
    if (reset) begin // @[ProcessingElement.scala 75:33]
      south_buffer_r <= 1'h0; // @[ProcessingElement.scala 75:33]
    end else begin
      south_buffer_r <= FS_Sin_io_ready_in; // @[ProcessingElement.scala 214:20]
    end
    if (reset) begin // @[ProcessingElement.scala 76:32]
      west_buffer_r <= 1'h0; // @[ProcessingElement.scala 76:32]
    end else begin
      west_buffer_r <= FS_Win_io_ready_in; // @[ProcessingElement.scala 255:19]
    end
    if (reset) begin // @[ProcessingElement.scala 78:32]
      north_REG_din <= 32'h0; // @[ProcessingElement.scala 78:32]
    end else begin
      north_REG_din <= MUX_Nout_io_mux_output; // @[ProcessingElement.scala 137:19]
    end
    if (reset) begin // @[ProcessingElement.scala 79:31]
      east_REG_din <= 32'h0; // @[ProcessingElement.scala 79:31]
    end else begin
      east_REG_din <= MUX_Eout_io_mux_output; // @[ProcessingElement.scala 179:18]
    end
    if (reset) begin // @[ProcessingElement.scala 80:32]
      south_REG_din <= 32'h0; // @[ProcessingElement.scala 80:32]
    end else begin
      south_REG_din <= MUX_Sout_io_mux_output; // @[ProcessingElement.scala 220:19]
    end
    if (reset) begin // @[ProcessingElement.scala 81:31]
      west_REG_din <= 32'h0; // @[ProcessingElement.scala 81:31]
    end else begin
      west_REG_din <= MUX_Wout_io_mux_output; // @[ProcessingElement.scala 261:18]
    end
    if (reset) begin // @[ProcessingElement.scala 83:34]
      north_REG_din_v <= 1'h0; // @[ProcessingElement.scala 83:34]
    end else begin
      north_REG_din_v <= FR_Nout_io_valid_out; // @[ProcessingElement.scala 146:21]
    end
    if (reset) begin // @[ProcessingElement.scala 84:33]
      east_REG_din_v <= 1'h0; // @[ProcessingElement.scala 84:33]
    end else begin
      east_REG_din_v <= FR_Eout_io_valid_out; // @[ProcessingElement.scala 188:20]
    end
    if (reset) begin // @[ProcessingElement.scala 85:34]
      south_REG_din_v <= 1'h0; // @[ProcessingElement.scala 85:34]
    end else begin
      south_REG_din_v <= FR_Sout_io_valid_out; // @[ProcessingElement.scala 229:21]
    end
    if (reset) begin // @[ProcessingElement.scala 86:33]
      west_REG_din_v <= 1'h0; // @[ProcessingElement.scala 86:33]
    end else begin
      west_REG_din_v <= FR_Wout_io_valid_out; // @[ProcessingElement.scala 270:20]
    end
    if (reset) begin // @[ProcessingElement.scala 87:34]
      north_REG_din_r <= 1'h0; // @[ProcessingElement.scala 87:34]
    end else begin
      north_REG_din_r <= REG_Nout_io_din_r; // @[ProcessingElement.scala 154:21]
    end
    if (reset) begin // @[ProcessingElement.scala 88:33]
      east_REG_din_r <= 1'h0; // @[ProcessingElement.scala 88:33]
    end else begin
      east_REG_din_r <= REG_Eout_io_din_r; // @[ProcessingElement.scala 196:20]
    end
    if (reset) begin // @[ProcessingElement.scala 89:34]
      south_REG_din_r <= 1'h0; // @[ProcessingElement.scala 89:34]
    end else begin
      south_REG_din_r <= REG_Sout_io_din_r; // @[ProcessingElement.scala 237:21]
    end
    if (reset) begin // @[ProcessingElement.scala 90:33]
      west_REG_din_r <= 1'h0; // @[ProcessingElement.scala 90:33]
    end else begin
      west_REG_din_r <= REG_Wout_io_din_r; // @[ProcessingElement.scala 278:20]
    end
    if (reset) begin // @[ProcessingElement.scala 92:29]
      FU_din_1_r <= 1'h0; // @[ProcessingElement.scala 92:29]
    end else begin
      FU_din_1_r <= CELL_io_FU_din_1_r; // @[ProcessingElement.scala 299:16]
    end
    if (reset) begin // @[ProcessingElement.scala 93:29]
      FU_din_2_r <= 1'h0; // @[ProcessingElement.scala 93:29]
    end else begin
      FU_din_2_r <= CELL_io_FU_din_2_r; // @[ProcessingElement.scala 300:16]
    end
    if (reset) begin // @[ProcessingElement.scala 94:26]
      FU_dout <= 32'h0; // @[ProcessingElement.scala 94:26]
    end else begin
      FU_dout <= CELL_io_dout; // @[ProcessingElement.scala 301:13]
    end
    if (reset) begin // @[ProcessingElement.scala 95:28]
      FU_dout_v <= 1'h0; // @[ProcessingElement.scala 95:28]
    end else begin
      FU_dout_v <= CELL_io_dout_v; // @[ProcessingElement.scala 302:15]
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
  mux_N_sel = _RAND_0[1:0];
  _RAND_1 = {1{`RANDOM}};
  mux_E_sel = _RAND_1[1:0];
  _RAND_2 = {1{`RANDOM}};
  mux_S_sel = _RAND_2[1:0];
  _RAND_3 = {1{`RANDOM}};
  mux_W_sel = _RAND_3[1:0];
  _RAND_4 = {1{`RANDOM}};
  accept_mask_frN = _RAND_4[4:0];
  _RAND_5 = {1{`RANDOM}};
  accept_mask_frE = _RAND_5[4:0];
  _RAND_6 = {1{`RANDOM}};
  accept_mask_frS = _RAND_6[4:0];
  _RAND_7 = {1{`RANDOM}};
  accept_mask_frW = _RAND_7[4:0];
  _RAND_8 = {1{`RANDOM}};
  accept_mask_fsiN = _RAND_8[4:0];
  _RAND_9 = {1{`RANDOM}};
  accept_mask_fsiE = _RAND_9[4:0];
  _RAND_10 = {1{`RANDOM}};
  accept_mask_fsiS = _RAND_10[4:0];
  _RAND_11 = {1{`RANDOM}};
  accept_mask_fsiW = _RAND_11[4:0];
  _RAND_12 = {6{`RANDOM}};
  config_bits_reg = _RAND_12[181:0];
  _RAND_13 = {1{`RANDOM}};
  north_buffer = _RAND_13[31:0];
  _RAND_14 = {1{`RANDOM}};
  east_buffer = _RAND_14[31:0];
  _RAND_15 = {1{`RANDOM}};
  south_buffer = _RAND_15[31:0];
  _RAND_16 = {1{`RANDOM}};
  west_buffer = _RAND_16[31:0];
  _RAND_17 = {1{`RANDOM}};
  north_buffer_v = _RAND_17[0:0];
  _RAND_18 = {1{`RANDOM}};
  east_buffer_v = _RAND_18[0:0];
  _RAND_19 = {1{`RANDOM}};
  south_buffer_v = _RAND_19[0:0];
  _RAND_20 = {1{`RANDOM}};
  west_buffer_v = _RAND_20[0:0];
  _RAND_21 = {1{`RANDOM}};
  north_buffer_r = _RAND_21[0:0];
  _RAND_22 = {1{`RANDOM}};
  east_buffer_r = _RAND_22[0:0];
  _RAND_23 = {1{`RANDOM}};
  south_buffer_r = _RAND_23[0:0];
  _RAND_24 = {1{`RANDOM}};
  west_buffer_r = _RAND_24[0:0];
  _RAND_25 = {1{`RANDOM}};
  north_REG_din = _RAND_25[31:0];
  _RAND_26 = {1{`RANDOM}};
  east_REG_din = _RAND_26[31:0];
  _RAND_27 = {1{`RANDOM}};
  south_REG_din = _RAND_27[31:0];
  _RAND_28 = {1{`RANDOM}};
  west_REG_din = _RAND_28[31:0];
  _RAND_29 = {1{`RANDOM}};
  north_REG_din_v = _RAND_29[0:0];
  _RAND_30 = {1{`RANDOM}};
  east_REG_din_v = _RAND_30[0:0];
  _RAND_31 = {1{`RANDOM}};
  south_REG_din_v = _RAND_31[0:0];
  _RAND_32 = {1{`RANDOM}};
  west_REG_din_v = _RAND_32[0:0];
  _RAND_33 = {1{`RANDOM}};
  north_REG_din_r = _RAND_33[0:0];
  _RAND_34 = {1{`RANDOM}};
  east_REG_din_r = _RAND_34[0:0];
  _RAND_35 = {1{`RANDOM}};
  south_REG_din_r = _RAND_35[0:0];
  _RAND_36 = {1{`RANDOM}};
  west_REG_din_r = _RAND_36[0:0];
  _RAND_37 = {1{`RANDOM}};
  FU_din_1_r = _RAND_37[0:0];
  _RAND_38 = {1{`RANDOM}};
  FU_din_2_r = _RAND_38[0:0];
  _RAND_39 = {1{`RANDOM}};
  FU_dout = _RAND_39[31:0];
  _RAND_40 = {1{`RANDOM}};
  FU_dout_v = _RAND_40[0:0];
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
  input  [255:0] io_data_in,
  input  [7:0]   io_data_in_valid,
  output [7:0]   io_data_in_ready,
  output [255:0] io_data_out,
  output [7:0]   io_data_out_valid,
  input  [7:0]   io_data_out_ready,
  input  [191:0] io_cell_config
);
`ifdef RANDOMIZE_REG_INIT
  reg [31:0] _RAND_0;
  reg [31:0] _RAND_1;
  reg [31:0] _RAND_2;
  reg [31:0] _RAND_3;
  reg [31:0] _RAND_4;
  reg [31:0] _RAND_5;
  reg [31:0] _RAND_6;
  reg [31:0] _RAND_7;
  reg [31:0] _RAND_8;
  reg [31:0] _RAND_9;
  reg [31:0] _RAND_10;
  reg [31:0] _RAND_11;
  reg [31:0] _RAND_12;
  reg [31:0] _RAND_13;
  reg [31:0] _RAND_14;
  reg [31:0] _RAND_15;
  reg [31:0] _RAND_16;
  reg [31:0] _RAND_17;
  reg [191:0] _RAND_18;
  reg [191:0] _RAND_19;
  reg [191:0] _RAND_20;
  reg [191:0] _RAND_21;
  reg [191:0] _RAND_22;
  reg [191:0] _RAND_23;
  reg [191:0] _RAND_24;
  reg [191:0] _RAND_25;
  reg [191:0] _RAND_26;
  reg [191:0] _RAND_27;
  reg [191:0] _RAND_28;
  reg [191:0] _RAND_29;
  reg [191:0] _RAND_30;
  reg [191:0] _RAND_31;
  reg [191:0] _RAND_32;
  reg [191:0] _RAND_33;
  reg [191:0] _RAND_34;
  reg [191:0] _RAND_35;
  reg [191:0] _RAND_36;
  reg [191:0] _RAND_37;
  reg [191:0] _RAND_38;
  reg [191:0] _RAND_39;
  reg [191:0] _RAND_40;
  reg [191:0] _RAND_41;
  reg [191:0] _RAND_42;
  reg [191:0] _RAND_43;
  reg [191:0] _RAND_44;
  reg [191:0] _RAND_45;
  reg [191:0] _RAND_46;
  reg [191:0] _RAND_47;
  reg [191:0] _RAND_48;
  reg [191:0] _RAND_49;
  reg [191:0] _RAND_50;
  reg [191:0] _RAND_51;
  reg [191:0] _RAND_52;
  reg [191:0] _RAND_53;
  reg [191:0] _RAND_54;
  reg [191:0] _RAND_55;
  reg [191:0] _RAND_56;
  reg [191:0] _RAND_57;
  reg [191:0] _RAND_58;
  reg [191:0] _RAND_59;
  reg [191:0] _RAND_60;
  reg [191:0] _RAND_61;
  reg [191:0] _RAND_62;
  reg [191:0] _RAND_63;
  reg [191:0] _RAND_64;
  reg [191:0] _RAND_65;
  reg [191:0] _RAND_66;
  reg [191:0] _RAND_67;
  reg [191:0] _RAND_68;
  reg [191:0] _RAND_69;
  reg [191:0] _RAND_70;
  reg [191:0] _RAND_71;
  reg [191:0] _RAND_72;
  reg [191:0] _RAND_73;
  reg [191:0] _RAND_74;
  reg [191:0] _RAND_75;
  reg [191:0] _RAND_76;
  reg [191:0] _RAND_77;
  reg [191:0] _RAND_78;
  reg [191:0] _RAND_79;
  reg [191:0] _RAND_80;
  reg [191:0] _RAND_81;
  reg [191:0] _RAND_82;
  reg [191:0] _RAND_83;
  reg [191:0] _RAND_84;
  reg [191:0] _RAND_85;
  reg [191:0] _RAND_86;
  reg [191:0] _RAND_87;
  reg [191:0] _RAND_88;
  reg [191:0] _RAND_89;
  reg [191:0] _RAND_90;
  reg [191:0] _RAND_91;
  reg [191:0] _RAND_92;
  reg [191:0] _RAND_93;
  reg [191:0] _RAND_94;
  reg [191:0] _RAND_95;
  reg [191:0] _RAND_96;
  reg [191:0] _RAND_97;
  reg [191:0] _RAND_98;
  reg [191:0] _RAND_99;
  reg [191:0] _RAND_100;
  reg [191:0] _RAND_101;
  reg [191:0] _RAND_102;
  reg [191:0] _RAND_103;
  reg [191:0] _RAND_104;
  reg [191:0] _RAND_105;
  reg [191:0] _RAND_106;
  reg [191:0] _RAND_107;
  reg [191:0] _RAND_108;
  reg [191:0] _RAND_109;
  reg [191:0] _RAND_110;
  reg [191:0] _RAND_111;
  reg [191:0] _RAND_112;
  reg [191:0] _RAND_113;
  reg [191:0] _RAND_114;
  reg [191:0] _RAND_115;
  reg [191:0] _RAND_116;
  reg [191:0] _RAND_117;
  reg [191:0] _RAND_118;
  reg [191:0] _RAND_119;
  reg [191:0] _RAND_120;
  reg [191:0] _RAND_121;
  reg [191:0] _RAND_122;
  reg [191:0] _RAND_123;
  reg [191:0] _RAND_124;
  reg [191:0] _RAND_125;
  reg [191:0] _RAND_126;
  reg [191:0] _RAND_127;
  reg [191:0] _RAND_128;
  reg [191:0] _RAND_129;
  reg [191:0] _RAND_130;
  reg [191:0] _RAND_131;
  reg [191:0] _RAND_132;
  reg [191:0] _RAND_133;
  reg [191:0] _RAND_134;
  reg [191:0] _RAND_135;
  reg [191:0] _RAND_136;
  reg [191:0] _RAND_137;
  reg [191:0] _RAND_138;
  reg [191:0] _RAND_139;
  reg [191:0] _RAND_140;
  reg [191:0] _RAND_141;
  reg [191:0] _RAND_142;
  reg [191:0] _RAND_143;
  reg [191:0] _RAND_144;
  reg [191:0] _RAND_145;
  reg [31:0] _RAND_146;
  reg [31:0] _RAND_147;
  reg [31:0] _RAND_148;
  reg [31:0] _RAND_149;
  reg [31:0] _RAND_150;
  reg [31:0] _RAND_151;
  reg [31:0] _RAND_152;
  reg [31:0] _RAND_153;
`endif // RANDOMIZE_REG_INIT
  wire  NORTHWEST_OV_clock; // @[OverlayRocc.scala 169:46]
  wire  NORTHWEST_OV_reset; // @[OverlayRocc.scala 169:46]
  wire [31:0] NORTHWEST_OV_io_north_din; // @[OverlayRocc.scala 169:46]
  wire  NORTHWEST_OV_io_north_din_v; // @[OverlayRocc.scala 169:46]
  wire  NORTHWEST_OV_io_north_din_r; // @[OverlayRocc.scala 169:46]
  wire  NORTHWEST_OV_io_east_din_r; // @[OverlayRocc.scala 169:46]
  wire  NORTHWEST_OV_io_south_din_r; // @[OverlayRocc.scala 169:46]
  wire [31:0] NORTHWEST_OV_io_west_din; // @[OverlayRocc.scala 169:46]
  wire  NORTHWEST_OV_io_west_din_v; // @[OverlayRocc.scala 169:46]
  wire  NORTHWEST_OV_io_north_dout_r; // @[OverlayRocc.scala 169:46]
  wire [31:0] NORTHWEST_OV_io_east_dout; // @[OverlayRocc.scala 169:46]
  wire  NORTHWEST_OV_io_east_dout_v; // @[OverlayRocc.scala 169:46]
  wire  NORTHWEST_OV_io_east_dout_r; // @[OverlayRocc.scala 169:46]
  wire [31:0] NORTHWEST_OV_io_south_dout; // @[OverlayRocc.scala 169:46]
  wire  NORTHWEST_OV_io_south_dout_v; // @[OverlayRocc.scala 169:46]
  wire  NORTHWEST_OV_io_west_dout_r; // @[OverlayRocc.scala 169:46]
  wire [181:0] NORTHWEST_OV_io_config_bits; // @[OverlayRocc.scala 169:46]
  wire  NORTHWEST_OV_io_catch_config; // @[OverlayRocc.scala 169:46]
  wire  MIDWEST_OV_clock; // @[OverlayRocc.scala 218:44]
  wire  MIDWEST_OV_reset; // @[OverlayRocc.scala 218:44]
  wire [31:0] MIDWEST_OV_io_north_din; // @[OverlayRocc.scala 218:44]
  wire  MIDWEST_OV_io_north_din_v; // @[OverlayRocc.scala 218:44]
  wire  MIDWEST_OV_io_north_din_r; // @[OverlayRocc.scala 218:44]
  wire  MIDWEST_OV_io_east_din_r; // @[OverlayRocc.scala 218:44]
  wire  MIDWEST_OV_io_south_din_r; // @[OverlayRocc.scala 218:44]
  wire [31:0] MIDWEST_OV_io_west_din; // @[OverlayRocc.scala 218:44]
  wire  MIDWEST_OV_io_west_din_v; // @[OverlayRocc.scala 218:44]
  wire  MIDWEST_OV_io_north_dout_r; // @[OverlayRocc.scala 218:44]
  wire [31:0] MIDWEST_OV_io_east_dout; // @[OverlayRocc.scala 218:44]
  wire  MIDWEST_OV_io_east_dout_v; // @[OverlayRocc.scala 218:44]
  wire  MIDWEST_OV_io_east_dout_r; // @[OverlayRocc.scala 218:44]
  wire [31:0] MIDWEST_OV_io_south_dout; // @[OverlayRocc.scala 218:44]
  wire  MIDWEST_OV_io_south_dout_v; // @[OverlayRocc.scala 218:44]
  wire  MIDWEST_OV_io_west_dout_r; // @[OverlayRocc.scala 218:44]
  wire [181:0] MIDWEST_OV_io_config_bits; // @[OverlayRocc.scala 218:44]
  wire  MIDWEST_OV_io_catch_config; // @[OverlayRocc.scala 218:44]
  wire  MIDWEST_OV_1_clock; // @[OverlayRocc.scala 218:44]
  wire  MIDWEST_OV_1_reset; // @[OverlayRocc.scala 218:44]
  wire [31:0] MIDWEST_OV_1_io_north_din; // @[OverlayRocc.scala 218:44]
  wire  MIDWEST_OV_1_io_north_din_v; // @[OverlayRocc.scala 218:44]
  wire  MIDWEST_OV_1_io_north_din_r; // @[OverlayRocc.scala 218:44]
  wire  MIDWEST_OV_1_io_east_din_r; // @[OverlayRocc.scala 218:44]
  wire  MIDWEST_OV_1_io_south_din_r; // @[OverlayRocc.scala 218:44]
  wire [31:0] MIDWEST_OV_1_io_west_din; // @[OverlayRocc.scala 218:44]
  wire  MIDWEST_OV_1_io_west_din_v; // @[OverlayRocc.scala 218:44]
  wire  MIDWEST_OV_1_io_north_dout_r; // @[OverlayRocc.scala 218:44]
  wire [31:0] MIDWEST_OV_1_io_east_dout; // @[OverlayRocc.scala 218:44]
  wire  MIDWEST_OV_1_io_east_dout_v; // @[OverlayRocc.scala 218:44]
  wire  MIDWEST_OV_1_io_east_dout_r; // @[OverlayRocc.scala 218:44]
  wire [31:0] MIDWEST_OV_1_io_south_dout; // @[OverlayRocc.scala 218:44]
  wire  MIDWEST_OV_1_io_south_dout_v; // @[OverlayRocc.scala 218:44]
  wire  MIDWEST_OV_1_io_west_dout_r; // @[OverlayRocc.scala 218:44]
  wire [181:0] MIDWEST_OV_1_io_config_bits; // @[OverlayRocc.scala 218:44]
  wire  MIDWEST_OV_1_io_catch_config; // @[OverlayRocc.scala 218:44]
  wire  MIDWEST_OV_2_clock; // @[OverlayRocc.scala 218:44]
  wire  MIDWEST_OV_2_reset; // @[OverlayRocc.scala 218:44]
  wire [31:0] MIDWEST_OV_2_io_north_din; // @[OverlayRocc.scala 218:44]
  wire  MIDWEST_OV_2_io_north_din_v; // @[OverlayRocc.scala 218:44]
  wire  MIDWEST_OV_2_io_north_din_r; // @[OverlayRocc.scala 218:44]
  wire  MIDWEST_OV_2_io_east_din_r; // @[OverlayRocc.scala 218:44]
  wire  MIDWEST_OV_2_io_south_din_r; // @[OverlayRocc.scala 218:44]
  wire [31:0] MIDWEST_OV_2_io_west_din; // @[OverlayRocc.scala 218:44]
  wire  MIDWEST_OV_2_io_west_din_v; // @[OverlayRocc.scala 218:44]
  wire  MIDWEST_OV_2_io_north_dout_r; // @[OverlayRocc.scala 218:44]
  wire [31:0] MIDWEST_OV_2_io_east_dout; // @[OverlayRocc.scala 218:44]
  wire  MIDWEST_OV_2_io_east_dout_v; // @[OverlayRocc.scala 218:44]
  wire  MIDWEST_OV_2_io_east_dout_r; // @[OverlayRocc.scala 218:44]
  wire [31:0] MIDWEST_OV_2_io_south_dout; // @[OverlayRocc.scala 218:44]
  wire  MIDWEST_OV_2_io_south_dout_v; // @[OverlayRocc.scala 218:44]
  wire  MIDWEST_OV_2_io_west_dout_r; // @[OverlayRocc.scala 218:44]
  wire [181:0] MIDWEST_OV_2_io_config_bits; // @[OverlayRocc.scala 218:44]
  wire  MIDWEST_OV_2_io_catch_config; // @[OverlayRocc.scala 218:44]
  wire  MIDWEST_OV_3_clock; // @[OverlayRocc.scala 218:44]
  wire  MIDWEST_OV_3_reset; // @[OverlayRocc.scala 218:44]
  wire [31:0] MIDWEST_OV_3_io_north_din; // @[OverlayRocc.scala 218:44]
  wire  MIDWEST_OV_3_io_north_din_v; // @[OverlayRocc.scala 218:44]
  wire  MIDWEST_OV_3_io_north_din_r; // @[OverlayRocc.scala 218:44]
  wire  MIDWEST_OV_3_io_east_din_r; // @[OverlayRocc.scala 218:44]
  wire  MIDWEST_OV_3_io_south_din_r; // @[OverlayRocc.scala 218:44]
  wire [31:0] MIDWEST_OV_3_io_west_din; // @[OverlayRocc.scala 218:44]
  wire  MIDWEST_OV_3_io_west_din_v; // @[OverlayRocc.scala 218:44]
  wire  MIDWEST_OV_3_io_north_dout_r; // @[OverlayRocc.scala 218:44]
  wire [31:0] MIDWEST_OV_3_io_east_dout; // @[OverlayRocc.scala 218:44]
  wire  MIDWEST_OV_3_io_east_dout_v; // @[OverlayRocc.scala 218:44]
  wire  MIDWEST_OV_3_io_east_dout_r; // @[OverlayRocc.scala 218:44]
  wire [31:0] MIDWEST_OV_3_io_south_dout; // @[OverlayRocc.scala 218:44]
  wire  MIDWEST_OV_3_io_south_dout_v; // @[OverlayRocc.scala 218:44]
  wire  MIDWEST_OV_3_io_west_dout_r; // @[OverlayRocc.scala 218:44]
  wire [181:0] MIDWEST_OV_3_io_config_bits; // @[OverlayRocc.scala 218:44]
  wire  MIDWEST_OV_3_io_catch_config; // @[OverlayRocc.scala 218:44]
  wire  MIDWEST_OV_4_clock; // @[OverlayRocc.scala 218:44]
  wire  MIDWEST_OV_4_reset; // @[OverlayRocc.scala 218:44]
  wire [31:0] MIDWEST_OV_4_io_north_din; // @[OverlayRocc.scala 218:44]
  wire  MIDWEST_OV_4_io_north_din_v; // @[OverlayRocc.scala 218:44]
  wire  MIDWEST_OV_4_io_north_din_r; // @[OverlayRocc.scala 218:44]
  wire  MIDWEST_OV_4_io_east_din_r; // @[OverlayRocc.scala 218:44]
  wire  MIDWEST_OV_4_io_south_din_r; // @[OverlayRocc.scala 218:44]
  wire [31:0] MIDWEST_OV_4_io_west_din; // @[OverlayRocc.scala 218:44]
  wire  MIDWEST_OV_4_io_west_din_v; // @[OverlayRocc.scala 218:44]
  wire  MIDWEST_OV_4_io_north_dout_r; // @[OverlayRocc.scala 218:44]
  wire [31:0] MIDWEST_OV_4_io_east_dout; // @[OverlayRocc.scala 218:44]
  wire  MIDWEST_OV_4_io_east_dout_v; // @[OverlayRocc.scala 218:44]
  wire  MIDWEST_OV_4_io_east_dout_r; // @[OverlayRocc.scala 218:44]
  wire [31:0] MIDWEST_OV_4_io_south_dout; // @[OverlayRocc.scala 218:44]
  wire  MIDWEST_OV_4_io_south_dout_v; // @[OverlayRocc.scala 218:44]
  wire  MIDWEST_OV_4_io_west_dout_r; // @[OverlayRocc.scala 218:44]
  wire [181:0] MIDWEST_OV_4_io_config_bits; // @[OverlayRocc.scala 218:44]
  wire  MIDWEST_OV_4_io_catch_config; // @[OverlayRocc.scala 218:44]
  wire  MIDWEST_OV_5_clock; // @[OverlayRocc.scala 218:44]
  wire  MIDWEST_OV_5_reset; // @[OverlayRocc.scala 218:44]
  wire [31:0] MIDWEST_OV_5_io_north_din; // @[OverlayRocc.scala 218:44]
  wire  MIDWEST_OV_5_io_north_din_v; // @[OverlayRocc.scala 218:44]
  wire  MIDWEST_OV_5_io_north_din_r; // @[OverlayRocc.scala 218:44]
  wire  MIDWEST_OV_5_io_east_din_r; // @[OverlayRocc.scala 218:44]
  wire  MIDWEST_OV_5_io_south_din_r; // @[OverlayRocc.scala 218:44]
  wire [31:0] MIDWEST_OV_5_io_west_din; // @[OverlayRocc.scala 218:44]
  wire  MIDWEST_OV_5_io_west_din_v; // @[OverlayRocc.scala 218:44]
  wire  MIDWEST_OV_5_io_north_dout_r; // @[OverlayRocc.scala 218:44]
  wire [31:0] MIDWEST_OV_5_io_east_dout; // @[OverlayRocc.scala 218:44]
  wire  MIDWEST_OV_5_io_east_dout_v; // @[OverlayRocc.scala 218:44]
  wire  MIDWEST_OV_5_io_east_dout_r; // @[OverlayRocc.scala 218:44]
  wire [31:0] MIDWEST_OV_5_io_south_dout; // @[OverlayRocc.scala 218:44]
  wire  MIDWEST_OV_5_io_south_dout_v; // @[OverlayRocc.scala 218:44]
  wire  MIDWEST_OV_5_io_west_dout_r; // @[OverlayRocc.scala 218:44]
  wire [181:0] MIDWEST_OV_5_io_config_bits; // @[OverlayRocc.scala 218:44]
  wire  MIDWEST_OV_5_io_catch_config; // @[OverlayRocc.scala 218:44]
  wire  SOUTHWEST_OV_clock; // @[OverlayRocc.scala 267:46]
  wire  SOUTHWEST_OV_reset; // @[OverlayRocc.scala 267:46]
  wire [31:0] SOUTHWEST_OV_io_north_din; // @[OverlayRocc.scala 267:46]
  wire  SOUTHWEST_OV_io_north_din_v; // @[OverlayRocc.scala 267:46]
  wire  SOUTHWEST_OV_io_north_din_r; // @[OverlayRocc.scala 267:46]
  wire  SOUTHWEST_OV_io_east_din_r; // @[OverlayRocc.scala 267:46]
  wire  SOUTHWEST_OV_io_south_din_r; // @[OverlayRocc.scala 267:46]
  wire [31:0] SOUTHWEST_OV_io_west_din; // @[OverlayRocc.scala 267:46]
  wire  SOUTHWEST_OV_io_west_din_v; // @[OverlayRocc.scala 267:46]
  wire  SOUTHWEST_OV_io_north_dout_r; // @[OverlayRocc.scala 267:46]
  wire [31:0] SOUTHWEST_OV_io_east_dout; // @[OverlayRocc.scala 267:46]
  wire  SOUTHWEST_OV_io_east_dout_v; // @[OverlayRocc.scala 267:46]
  wire  SOUTHWEST_OV_io_east_dout_r; // @[OverlayRocc.scala 267:46]
  wire [31:0] SOUTHWEST_OV_io_south_dout; // @[OverlayRocc.scala 267:46]
  wire  SOUTHWEST_OV_io_south_dout_v; // @[OverlayRocc.scala 267:46]
  wire  SOUTHWEST_OV_io_west_dout_r; // @[OverlayRocc.scala 267:46]
  wire [181:0] SOUTHWEST_OV_io_config_bits; // @[OverlayRocc.scala 267:46]
  wire  SOUTHWEST_OV_io_catch_config; // @[OverlayRocc.scala 267:46]
  wire  MIDDLENORTH_OV_clock; // @[OverlayRocc.scala 320:48]
  wire  MIDDLENORTH_OV_reset; // @[OverlayRocc.scala 320:48]
  wire [31:0] MIDDLENORTH_OV_io_north_din; // @[OverlayRocc.scala 320:48]
  wire  MIDDLENORTH_OV_io_north_din_v; // @[OverlayRocc.scala 320:48]
  wire  MIDDLENORTH_OV_io_north_din_r; // @[OverlayRocc.scala 320:48]
  wire  MIDDLENORTH_OV_io_east_din_r; // @[OverlayRocc.scala 320:48]
  wire  MIDDLENORTH_OV_io_south_din_r; // @[OverlayRocc.scala 320:48]
  wire [31:0] MIDDLENORTH_OV_io_west_din; // @[OverlayRocc.scala 320:48]
  wire  MIDDLENORTH_OV_io_west_din_v; // @[OverlayRocc.scala 320:48]
  wire  MIDDLENORTH_OV_io_north_dout_r; // @[OverlayRocc.scala 320:48]
  wire [31:0] MIDDLENORTH_OV_io_east_dout; // @[OverlayRocc.scala 320:48]
  wire  MIDDLENORTH_OV_io_east_dout_v; // @[OverlayRocc.scala 320:48]
  wire  MIDDLENORTH_OV_io_east_dout_r; // @[OverlayRocc.scala 320:48]
  wire [31:0] MIDDLENORTH_OV_io_south_dout; // @[OverlayRocc.scala 320:48]
  wire  MIDDLENORTH_OV_io_south_dout_v; // @[OverlayRocc.scala 320:48]
  wire  MIDDLENORTH_OV_io_west_dout_r; // @[OverlayRocc.scala 320:48]
  wire [181:0] MIDDLENORTH_OV_io_config_bits; // @[OverlayRocc.scala 320:48]
  wire  MIDDLENORTH_OV_io_catch_config; // @[OverlayRocc.scala 320:48]
  wire  MIDDLEMIDDLE_OV_clock; // @[OverlayRocc.scala 369:49]
  wire  MIDDLEMIDDLE_OV_reset; // @[OverlayRocc.scala 369:49]
  wire [31:0] MIDDLEMIDDLE_OV_io_north_din; // @[OverlayRocc.scala 369:49]
  wire  MIDDLEMIDDLE_OV_io_north_din_v; // @[OverlayRocc.scala 369:49]
  wire  MIDDLEMIDDLE_OV_io_north_din_r; // @[OverlayRocc.scala 369:49]
  wire  MIDDLEMIDDLE_OV_io_east_din_r; // @[OverlayRocc.scala 369:49]
  wire  MIDDLEMIDDLE_OV_io_south_din_r; // @[OverlayRocc.scala 369:49]
  wire [31:0] MIDDLEMIDDLE_OV_io_west_din; // @[OverlayRocc.scala 369:49]
  wire  MIDDLEMIDDLE_OV_io_west_din_v; // @[OverlayRocc.scala 369:49]
  wire  MIDDLEMIDDLE_OV_io_north_dout_r; // @[OverlayRocc.scala 369:49]
  wire [31:0] MIDDLEMIDDLE_OV_io_east_dout; // @[OverlayRocc.scala 369:49]
  wire  MIDDLEMIDDLE_OV_io_east_dout_v; // @[OverlayRocc.scala 369:49]
  wire  MIDDLEMIDDLE_OV_io_east_dout_r; // @[OverlayRocc.scala 369:49]
  wire [31:0] MIDDLEMIDDLE_OV_io_south_dout; // @[OverlayRocc.scala 369:49]
  wire  MIDDLEMIDDLE_OV_io_south_dout_v; // @[OverlayRocc.scala 369:49]
  wire  MIDDLEMIDDLE_OV_io_west_dout_r; // @[OverlayRocc.scala 369:49]
  wire [181:0] MIDDLEMIDDLE_OV_io_config_bits; // @[OverlayRocc.scala 369:49]
  wire  MIDDLEMIDDLE_OV_io_catch_config; // @[OverlayRocc.scala 369:49]
  wire  MIDDLEMIDDLE_OV_1_clock; // @[OverlayRocc.scala 369:49]
  wire  MIDDLEMIDDLE_OV_1_reset; // @[OverlayRocc.scala 369:49]
  wire [31:0] MIDDLEMIDDLE_OV_1_io_north_din; // @[OverlayRocc.scala 369:49]
  wire  MIDDLEMIDDLE_OV_1_io_north_din_v; // @[OverlayRocc.scala 369:49]
  wire  MIDDLEMIDDLE_OV_1_io_north_din_r; // @[OverlayRocc.scala 369:49]
  wire  MIDDLEMIDDLE_OV_1_io_east_din_r; // @[OverlayRocc.scala 369:49]
  wire  MIDDLEMIDDLE_OV_1_io_south_din_r; // @[OverlayRocc.scala 369:49]
  wire [31:0] MIDDLEMIDDLE_OV_1_io_west_din; // @[OverlayRocc.scala 369:49]
  wire  MIDDLEMIDDLE_OV_1_io_west_din_v; // @[OverlayRocc.scala 369:49]
  wire  MIDDLEMIDDLE_OV_1_io_north_dout_r; // @[OverlayRocc.scala 369:49]
  wire [31:0] MIDDLEMIDDLE_OV_1_io_east_dout; // @[OverlayRocc.scala 369:49]
  wire  MIDDLEMIDDLE_OV_1_io_east_dout_v; // @[OverlayRocc.scala 369:49]
  wire  MIDDLEMIDDLE_OV_1_io_east_dout_r; // @[OverlayRocc.scala 369:49]
  wire [31:0] MIDDLEMIDDLE_OV_1_io_south_dout; // @[OverlayRocc.scala 369:49]
  wire  MIDDLEMIDDLE_OV_1_io_south_dout_v; // @[OverlayRocc.scala 369:49]
  wire  MIDDLEMIDDLE_OV_1_io_west_dout_r; // @[OverlayRocc.scala 369:49]
  wire [181:0] MIDDLEMIDDLE_OV_1_io_config_bits; // @[OverlayRocc.scala 369:49]
  wire  MIDDLEMIDDLE_OV_1_io_catch_config; // @[OverlayRocc.scala 369:49]
  wire  MIDDLEMIDDLE_OV_2_clock; // @[OverlayRocc.scala 369:49]
  wire  MIDDLEMIDDLE_OV_2_reset; // @[OverlayRocc.scala 369:49]
  wire [31:0] MIDDLEMIDDLE_OV_2_io_north_din; // @[OverlayRocc.scala 369:49]
  wire  MIDDLEMIDDLE_OV_2_io_north_din_v; // @[OverlayRocc.scala 369:49]
  wire  MIDDLEMIDDLE_OV_2_io_north_din_r; // @[OverlayRocc.scala 369:49]
  wire  MIDDLEMIDDLE_OV_2_io_east_din_r; // @[OverlayRocc.scala 369:49]
  wire  MIDDLEMIDDLE_OV_2_io_south_din_r; // @[OverlayRocc.scala 369:49]
  wire [31:0] MIDDLEMIDDLE_OV_2_io_west_din; // @[OverlayRocc.scala 369:49]
  wire  MIDDLEMIDDLE_OV_2_io_west_din_v; // @[OverlayRocc.scala 369:49]
  wire  MIDDLEMIDDLE_OV_2_io_north_dout_r; // @[OverlayRocc.scala 369:49]
  wire [31:0] MIDDLEMIDDLE_OV_2_io_east_dout; // @[OverlayRocc.scala 369:49]
  wire  MIDDLEMIDDLE_OV_2_io_east_dout_v; // @[OverlayRocc.scala 369:49]
  wire  MIDDLEMIDDLE_OV_2_io_east_dout_r; // @[OverlayRocc.scala 369:49]
  wire [31:0] MIDDLEMIDDLE_OV_2_io_south_dout; // @[OverlayRocc.scala 369:49]
  wire  MIDDLEMIDDLE_OV_2_io_south_dout_v; // @[OverlayRocc.scala 369:49]
  wire  MIDDLEMIDDLE_OV_2_io_west_dout_r; // @[OverlayRocc.scala 369:49]
  wire [181:0] MIDDLEMIDDLE_OV_2_io_config_bits; // @[OverlayRocc.scala 369:49]
  wire  MIDDLEMIDDLE_OV_2_io_catch_config; // @[OverlayRocc.scala 369:49]
  wire  MIDDLEMIDDLE_OV_3_clock; // @[OverlayRocc.scala 369:49]
  wire  MIDDLEMIDDLE_OV_3_reset; // @[OverlayRocc.scala 369:49]
  wire [31:0] MIDDLEMIDDLE_OV_3_io_north_din; // @[OverlayRocc.scala 369:49]
  wire  MIDDLEMIDDLE_OV_3_io_north_din_v; // @[OverlayRocc.scala 369:49]
  wire  MIDDLEMIDDLE_OV_3_io_north_din_r; // @[OverlayRocc.scala 369:49]
  wire  MIDDLEMIDDLE_OV_3_io_east_din_r; // @[OverlayRocc.scala 369:49]
  wire  MIDDLEMIDDLE_OV_3_io_south_din_r; // @[OverlayRocc.scala 369:49]
  wire [31:0] MIDDLEMIDDLE_OV_3_io_west_din; // @[OverlayRocc.scala 369:49]
  wire  MIDDLEMIDDLE_OV_3_io_west_din_v; // @[OverlayRocc.scala 369:49]
  wire  MIDDLEMIDDLE_OV_3_io_north_dout_r; // @[OverlayRocc.scala 369:49]
  wire [31:0] MIDDLEMIDDLE_OV_3_io_east_dout; // @[OverlayRocc.scala 369:49]
  wire  MIDDLEMIDDLE_OV_3_io_east_dout_v; // @[OverlayRocc.scala 369:49]
  wire  MIDDLEMIDDLE_OV_3_io_east_dout_r; // @[OverlayRocc.scala 369:49]
  wire [31:0] MIDDLEMIDDLE_OV_3_io_south_dout; // @[OverlayRocc.scala 369:49]
  wire  MIDDLEMIDDLE_OV_3_io_south_dout_v; // @[OverlayRocc.scala 369:49]
  wire  MIDDLEMIDDLE_OV_3_io_west_dout_r; // @[OverlayRocc.scala 369:49]
  wire [181:0] MIDDLEMIDDLE_OV_3_io_config_bits; // @[OverlayRocc.scala 369:49]
  wire  MIDDLEMIDDLE_OV_3_io_catch_config; // @[OverlayRocc.scala 369:49]
  wire  MIDDLEMIDDLE_OV_4_clock; // @[OverlayRocc.scala 369:49]
  wire  MIDDLEMIDDLE_OV_4_reset; // @[OverlayRocc.scala 369:49]
  wire [31:0] MIDDLEMIDDLE_OV_4_io_north_din; // @[OverlayRocc.scala 369:49]
  wire  MIDDLEMIDDLE_OV_4_io_north_din_v; // @[OverlayRocc.scala 369:49]
  wire  MIDDLEMIDDLE_OV_4_io_north_din_r; // @[OverlayRocc.scala 369:49]
  wire  MIDDLEMIDDLE_OV_4_io_east_din_r; // @[OverlayRocc.scala 369:49]
  wire  MIDDLEMIDDLE_OV_4_io_south_din_r; // @[OverlayRocc.scala 369:49]
  wire [31:0] MIDDLEMIDDLE_OV_4_io_west_din; // @[OverlayRocc.scala 369:49]
  wire  MIDDLEMIDDLE_OV_4_io_west_din_v; // @[OverlayRocc.scala 369:49]
  wire  MIDDLEMIDDLE_OV_4_io_north_dout_r; // @[OverlayRocc.scala 369:49]
  wire [31:0] MIDDLEMIDDLE_OV_4_io_east_dout; // @[OverlayRocc.scala 369:49]
  wire  MIDDLEMIDDLE_OV_4_io_east_dout_v; // @[OverlayRocc.scala 369:49]
  wire  MIDDLEMIDDLE_OV_4_io_east_dout_r; // @[OverlayRocc.scala 369:49]
  wire [31:0] MIDDLEMIDDLE_OV_4_io_south_dout; // @[OverlayRocc.scala 369:49]
  wire  MIDDLEMIDDLE_OV_4_io_south_dout_v; // @[OverlayRocc.scala 369:49]
  wire  MIDDLEMIDDLE_OV_4_io_west_dout_r; // @[OverlayRocc.scala 369:49]
  wire [181:0] MIDDLEMIDDLE_OV_4_io_config_bits; // @[OverlayRocc.scala 369:49]
  wire  MIDDLEMIDDLE_OV_4_io_catch_config; // @[OverlayRocc.scala 369:49]
  wire  MIDDLEMIDDLE_OV_5_clock; // @[OverlayRocc.scala 369:49]
  wire  MIDDLEMIDDLE_OV_5_reset; // @[OverlayRocc.scala 369:49]
  wire [31:0] MIDDLEMIDDLE_OV_5_io_north_din; // @[OverlayRocc.scala 369:49]
  wire  MIDDLEMIDDLE_OV_5_io_north_din_v; // @[OverlayRocc.scala 369:49]
  wire  MIDDLEMIDDLE_OV_5_io_north_din_r; // @[OverlayRocc.scala 369:49]
  wire  MIDDLEMIDDLE_OV_5_io_east_din_r; // @[OverlayRocc.scala 369:49]
  wire  MIDDLEMIDDLE_OV_5_io_south_din_r; // @[OverlayRocc.scala 369:49]
  wire [31:0] MIDDLEMIDDLE_OV_5_io_west_din; // @[OverlayRocc.scala 369:49]
  wire  MIDDLEMIDDLE_OV_5_io_west_din_v; // @[OverlayRocc.scala 369:49]
  wire  MIDDLEMIDDLE_OV_5_io_north_dout_r; // @[OverlayRocc.scala 369:49]
  wire [31:0] MIDDLEMIDDLE_OV_5_io_east_dout; // @[OverlayRocc.scala 369:49]
  wire  MIDDLEMIDDLE_OV_5_io_east_dout_v; // @[OverlayRocc.scala 369:49]
  wire  MIDDLEMIDDLE_OV_5_io_east_dout_r; // @[OverlayRocc.scala 369:49]
  wire [31:0] MIDDLEMIDDLE_OV_5_io_south_dout; // @[OverlayRocc.scala 369:49]
  wire  MIDDLEMIDDLE_OV_5_io_south_dout_v; // @[OverlayRocc.scala 369:49]
  wire  MIDDLEMIDDLE_OV_5_io_west_dout_r; // @[OverlayRocc.scala 369:49]
  wire [181:0] MIDDLEMIDDLE_OV_5_io_config_bits; // @[OverlayRocc.scala 369:49]
  wire  MIDDLEMIDDLE_OV_5_io_catch_config; // @[OverlayRocc.scala 369:49]
  wire  MIDDLESOUTH_OV_clock; // @[OverlayRocc.scala 418:48]
  wire  MIDDLESOUTH_OV_reset; // @[OverlayRocc.scala 418:48]
  wire [31:0] MIDDLESOUTH_OV_io_north_din; // @[OverlayRocc.scala 418:48]
  wire  MIDDLESOUTH_OV_io_north_din_v; // @[OverlayRocc.scala 418:48]
  wire  MIDDLESOUTH_OV_io_north_din_r; // @[OverlayRocc.scala 418:48]
  wire  MIDDLESOUTH_OV_io_east_din_r; // @[OverlayRocc.scala 418:48]
  wire  MIDDLESOUTH_OV_io_south_din_r; // @[OverlayRocc.scala 418:48]
  wire [31:0] MIDDLESOUTH_OV_io_west_din; // @[OverlayRocc.scala 418:48]
  wire  MIDDLESOUTH_OV_io_west_din_v; // @[OverlayRocc.scala 418:48]
  wire  MIDDLESOUTH_OV_io_north_dout_r; // @[OverlayRocc.scala 418:48]
  wire [31:0] MIDDLESOUTH_OV_io_east_dout; // @[OverlayRocc.scala 418:48]
  wire  MIDDLESOUTH_OV_io_east_dout_v; // @[OverlayRocc.scala 418:48]
  wire  MIDDLESOUTH_OV_io_east_dout_r; // @[OverlayRocc.scala 418:48]
  wire [31:0] MIDDLESOUTH_OV_io_south_dout; // @[OverlayRocc.scala 418:48]
  wire  MIDDLESOUTH_OV_io_south_dout_v; // @[OverlayRocc.scala 418:48]
  wire  MIDDLESOUTH_OV_io_west_dout_r; // @[OverlayRocc.scala 418:48]
  wire [181:0] MIDDLESOUTH_OV_io_config_bits; // @[OverlayRocc.scala 418:48]
  wire  MIDDLESOUTH_OV_io_catch_config; // @[OverlayRocc.scala 418:48]
  wire  MIDDLENORTH_OV_1_clock; // @[OverlayRocc.scala 320:48]
  wire  MIDDLENORTH_OV_1_reset; // @[OverlayRocc.scala 320:48]
  wire [31:0] MIDDLENORTH_OV_1_io_north_din; // @[OverlayRocc.scala 320:48]
  wire  MIDDLENORTH_OV_1_io_north_din_v; // @[OverlayRocc.scala 320:48]
  wire  MIDDLENORTH_OV_1_io_north_din_r; // @[OverlayRocc.scala 320:48]
  wire  MIDDLENORTH_OV_1_io_east_din_r; // @[OverlayRocc.scala 320:48]
  wire  MIDDLENORTH_OV_1_io_south_din_r; // @[OverlayRocc.scala 320:48]
  wire [31:0] MIDDLENORTH_OV_1_io_west_din; // @[OverlayRocc.scala 320:48]
  wire  MIDDLENORTH_OV_1_io_west_din_v; // @[OverlayRocc.scala 320:48]
  wire  MIDDLENORTH_OV_1_io_north_dout_r; // @[OverlayRocc.scala 320:48]
  wire [31:0] MIDDLENORTH_OV_1_io_east_dout; // @[OverlayRocc.scala 320:48]
  wire  MIDDLENORTH_OV_1_io_east_dout_v; // @[OverlayRocc.scala 320:48]
  wire  MIDDLENORTH_OV_1_io_east_dout_r; // @[OverlayRocc.scala 320:48]
  wire [31:0] MIDDLENORTH_OV_1_io_south_dout; // @[OverlayRocc.scala 320:48]
  wire  MIDDLENORTH_OV_1_io_south_dout_v; // @[OverlayRocc.scala 320:48]
  wire  MIDDLENORTH_OV_1_io_west_dout_r; // @[OverlayRocc.scala 320:48]
  wire [181:0] MIDDLENORTH_OV_1_io_config_bits; // @[OverlayRocc.scala 320:48]
  wire  MIDDLENORTH_OV_1_io_catch_config; // @[OverlayRocc.scala 320:48]
  wire  MIDDLEMIDDLE_OV_6_clock; // @[OverlayRocc.scala 369:49]
  wire  MIDDLEMIDDLE_OV_6_reset; // @[OverlayRocc.scala 369:49]
  wire [31:0] MIDDLEMIDDLE_OV_6_io_north_din; // @[OverlayRocc.scala 369:49]
  wire  MIDDLEMIDDLE_OV_6_io_north_din_v; // @[OverlayRocc.scala 369:49]
  wire  MIDDLEMIDDLE_OV_6_io_north_din_r; // @[OverlayRocc.scala 369:49]
  wire  MIDDLEMIDDLE_OV_6_io_east_din_r; // @[OverlayRocc.scala 369:49]
  wire  MIDDLEMIDDLE_OV_6_io_south_din_r; // @[OverlayRocc.scala 369:49]
  wire [31:0] MIDDLEMIDDLE_OV_6_io_west_din; // @[OverlayRocc.scala 369:49]
  wire  MIDDLEMIDDLE_OV_6_io_west_din_v; // @[OverlayRocc.scala 369:49]
  wire  MIDDLEMIDDLE_OV_6_io_north_dout_r; // @[OverlayRocc.scala 369:49]
  wire [31:0] MIDDLEMIDDLE_OV_6_io_east_dout; // @[OverlayRocc.scala 369:49]
  wire  MIDDLEMIDDLE_OV_6_io_east_dout_v; // @[OverlayRocc.scala 369:49]
  wire  MIDDLEMIDDLE_OV_6_io_east_dout_r; // @[OverlayRocc.scala 369:49]
  wire [31:0] MIDDLEMIDDLE_OV_6_io_south_dout; // @[OverlayRocc.scala 369:49]
  wire  MIDDLEMIDDLE_OV_6_io_south_dout_v; // @[OverlayRocc.scala 369:49]
  wire  MIDDLEMIDDLE_OV_6_io_west_dout_r; // @[OverlayRocc.scala 369:49]
  wire [181:0] MIDDLEMIDDLE_OV_6_io_config_bits; // @[OverlayRocc.scala 369:49]
  wire  MIDDLEMIDDLE_OV_6_io_catch_config; // @[OverlayRocc.scala 369:49]
  wire  MIDDLEMIDDLE_OV_7_clock; // @[OverlayRocc.scala 369:49]
  wire  MIDDLEMIDDLE_OV_7_reset; // @[OverlayRocc.scala 369:49]
  wire [31:0] MIDDLEMIDDLE_OV_7_io_north_din; // @[OverlayRocc.scala 369:49]
  wire  MIDDLEMIDDLE_OV_7_io_north_din_v; // @[OverlayRocc.scala 369:49]
  wire  MIDDLEMIDDLE_OV_7_io_north_din_r; // @[OverlayRocc.scala 369:49]
  wire  MIDDLEMIDDLE_OV_7_io_east_din_r; // @[OverlayRocc.scala 369:49]
  wire  MIDDLEMIDDLE_OV_7_io_south_din_r; // @[OverlayRocc.scala 369:49]
  wire [31:0] MIDDLEMIDDLE_OV_7_io_west_din; // @[OverlayRocc.scala 369:49]
  wire  MIDDLEMIDDLE_OV_7_io_west_din_v; // @[OverlayRocc.scala 369:49]
  wire  MIDDLEMIDDLE_OV_7_io_north_dout_r; // @[OverlayRocc.scala 369:49]
  wire [31:0] MIDDLEMIDDLE_OV_7_io_east_dout; // @[OverlayRocc.scala 369:49]
  wire  MIDDLEMIDDLE_OV_7_io_east_dout_v; // @[OverlayRocc.scala 369:49]
  wire  MIDDLEMIDDLE_OV_7_io_east_dout_r; // @[OverlayRocc.scala 369:49]
  wire [31:0] MIDDLEMIDDLE_OV_7_io_south_dout; // @[OverlayRocc.scala 369:49]
  wire  MIDDLEMIDDLE_OV_7_io_south_dout_v; // @[OverlayRocc.scala 369:49]
  wire  MIDDLEMIDDLE_OV_7_io_west_dout_r; // @[OverlayRocc.scala 369:49]
  wire [181:0] MIDDLEMIDDLE_OV_7_io_config_bits; // @[OverlayRocc.scala 369:49]
  wire  MIDDLEMIDDLE_OV_7_io_catch_config; // @[OverlayRocc.scala 369:49]
  wire  MIDDLEMIDDLE_OV_8_clock; // @[OverlayRocc.scala 369:49]
  wire  MIDDLEMIDDLE_OV_8_reset; // @[OverlayRocc.scala 369:49]
  wire [31:0] MIDDLEMIDDLE_OV_8_io_north_din; // @[OverlayRocc.scala 369:49]
  wire  MIDDLEMIDDLE_OV_8_io_north_din_v; // @[OverlayRocc.scala 369:49]
  wire  MIDDLEMIDDLE_OV_8_io_north_din_r; // @[OverlayRocc.scala 369:49]
  wire  MIDDLEMIDDLE_OV_8_io_east_din_r; // @[OverlayRocc.scala 369:49]
  wire  MIDDLEMIDDLE_OV_8_io_south_din_r; // @[OverlayRocc.scala 369:49]
  wire [31:0] MIDDLEMIDDLE_OV_8_io_west_din; // @[OverlayRocc.scala 369:49]
  wire  MIDDLEMIDDLE_OV_8_io_west_din_v; // @[OverlayRocc.scala 369:49]
  wire  MIDDLEMIDDLE_OV_8_io_north_dout_r; // @[OverlayRocc.scala 369:49]
  wire [31:0] MIDDLEMIDDLE_OV_8_io_east_dout; // @[OverlayRocc.scala 369:49]
  wire  MIDDLEMIDDLE_OV_8_io_east_dout_v; // @[OverlayRocc.scala 369:49]
  wire  MIDDLEMIDDLE_OV_8_io_east_dout_r; // @[OverlayRocc.scala 369:49]
  wire [31:0] MIDDLEMIDDLE_OV_8_io_south_dout; // @[OverlayRocc.scala 369:49]
  wire  MIDDLEMIDDLE_OV_8_io_south_dout_v; // @[OverlayRocc.scala 369:49]
  wire  MIDDLEMIDDLE_OV_8_io_west_dout_r; // @[OverlayRocc.scala 369:49]
  wire [181:0] MIDDLEMIDDLE_OV_8_io_config_bits; // @[OverlayRocc.scala 369:49]
  wire  MIDDLEMIDDLE_OV_8_io_catch_config; // @[OverlayRocc.scala 369:49]
  wire  MIDDLEMIDDLE_OV_9_clock; // @[OverlayRocc.scala 369:49]
  wire  MIDDLEMIDDLE_OV_9_reset; // @[OverlayRocc.scala 369:49]
  wire [31:0] MIDDLEMIDDLE_OV_9_io_north_din; // @[OverlayRocc.scala 369:49]
  wire  MIDDLEMIDDLE_OV_9_io_north_din_v; // @[OverlayRocc.scala 369:49]
  wire  MIDDLEMIDDLE_OV_9_io_north_din_r; // @[OverlayRocc.scala 369:49]
  wire  MIDDLEMIDDLE_OV_9_io_east_din_r; // @[OverlayRocc.scala 369:49]
  wire  MIDDLEMIDDLE_OV_9_io_south_din_r; // @[OverlayRocc.scala 369:49]
  wire [31:0] MIDDLEMIDDLE_OV_9_io_west_din; // @[OverlayRocc.scala 369:49]
  wire  MIDDLEMIDDLE_OV_9_io_west_din_v; // @[OverlayRocc.scala 369:49]
  wire  MIDDLEMIDDLE_OV_9_io_north_dout_r; // @[OverlayRocc.scala 369:49]
  wire [31:0] MIDDLEMIDDLE_OV_9_io_east_dout; // @[OverlayRocc.scala 369:49]
  wire  MIDDLEMIDDLE_OV_9_io_east_dout_v; // @[OverlayRocc.scala 369:49]
  wire  MIDDLEMIDDLE_OV_9_io_east_dout_r; // @[OverlayRocc.scala 369:49]
  wire [31:0] MIDDLEMIDDLE_OV_9_io_south_dout; // @[OverlayRocc.scala 369:49]
  wire  MIDDLEMIDDLE_OV_9_io_south_dout_v; // @[OverlayRocc.scala 369:49]
  wire  MIDDLEMIDDLE_OV_9_io_west_dout_r; // @[OverlayRocc.scala 369:49]
  wire [181:0] MIDDLEMIDDLE_OV_9_io_config_bits; // @[OverlayRocc.scala 369:49]
  wire  MIDDLEMIDDLE_OV_9_io_catch_config; // @[OverlayRocc.scala 369:49]
  wire  MIDDLEMIDDLE_OV_10_clock; // @[OverlayRocc.scala 369:49]
  wire  MIDDLEMIDDLE_OV_10_reset; // @[OverlayRocc.scala 369:49]
  wire [31:0] MIDDLEMIDDLE_OV_10_io_north_din; // @[OverlayRocc.scala 369:49]
  wire  MIDDLEMIDDLE_OV_10_io_north_din_v; // @[OverlayRocc.scala 369:49]
  wire  MIDDLEMIDDLE_OV_10_io_north_din_r; // @[OverlayRocc.scala 369:49]
  wire  MIDDLEMIDDLE_OV_10_io_east_din_r; // @[OverlayRocc.scala 369:49]
  wire  MIDDLEMIDDLE_OV_10_io_south_din_r; // @[OverlayRocc.scala 369:49]
  wire [31:0] MIDDLEMIDDLE_OV_10_io_west_din; // @[OverlayRocc.scala 369:49]
  wire  MIDDLEMIDDLE_OV_10_io_west_din_v; // @[OverlayRocc.scala 369:49]
  wire  MIDDLEMIDDLE_OV_10_io_north_dout_r; // @[OverlayRocc.scala 369:49]
  wire [31:0] MIDDLEMIDDLE_OV_10_io_east_dout; // @[OverlayRocc.scala 369:49]
  wire  MIDDLEMIDDLE_OV_10_io_east_dout_v; // @[OverlayRocc.scala 369:49]
  wire  MIDDLEMIDDLE_OV_10_io_east_dout_r; // @[OverlayRocc.scala 369:49]
  wire [31:0] MIDDLEMIDDLE_OV_10_io_south_dout; // @[OverlayRocc.scala 369:49]
  wire  MIDDLEMIDDLE_OV_10_io_south_dout_v; // @[OverlayRocc.scala 369:49]
  wire  MIDDLEMIDDLE_OV_10_io_west_dout_r; // @[OverlayRocc.scala 369:49]
  wire [181:0] MIDDLEMIDDLE_OV_10_io_config_bits; // @[OverlayRocc.scala 369:49]
  wire  MIDDLEMIDDLE_OV_10_io_catch_config; // @[OverlayRocc.scala 369:49]
  wire  MIDDLEMIDDLE_OV_11_clock; // @[OverlayRocc.scala 369:49]
  wire  MIDDLEMIDDLE_OV_11_reset; // @[OverlayRocc.scala 369:49]
  wire [31:0] MIDDLEMIDDLE_OV_11_io_north_din; // @[OverlayRocc.scala 369:49]
  wire  MIDDLEMIDDLE_OV_11_io_north_din_v; // @[OverlayRocc.scala 369:49]
  wire  MIDDLEMIDDLE_OV_11_io_north_din_r; // @[OverlayRocc.scala 369:49]
  wire  MIDDLEMIDDLE_OV_11_io_east_din_r; // @[OverlayRocc.scala 369:49]
  wire  MIDDLEMIDDLE_OV_11_io_south_din_r; // @[OverlayRocc.scala 369:49]
  wire [31:0] MIDDLEMIDDLE_OV_11_io_west_din; // @[OverlayRocc.scala 369:49]
  wire  MIDDLEMIDDLE_OV_11_io_west_din_v; // @[OverlayRocc.scala 369:49]
  wire  MIDDLEMIDDLE_OV_11_io_north_dout_r; // @[OverlayRocc.scala 369:49]
  wire [31:0] MIDDLEMIDDLE_OV_11_io_east_dout; // @[OverlayRocc.scala 369:49]
  wire  MIDDLEMIDDLE_OV_11_io_east_dout_v; // @[OverlayRocc.scala 369:49]
  wire  MIDDLEMIDDLE_OV_11_io_east_dout_r; // @[OverlayRocc.scala 369:49]
  wire [31:0] MIDDLEMIDDLE_OV_11_io_south_dout; // @[OverlayRocc.scala 369:49]
  wire  MIDDLEMIDDLE_OV_11_io_south_dout_v; // @[OverlayRocc.scala 369:49]
  wire  MIDDLEMIDDLE_OV_11_io_west_dout_r; // @[OverlayRocc.scala 369:49]
  wire [181:0] MIDDLEMIDDLE_OV_11_io_config_bits; // @[OverlayRocc.scala 369:49]
  wire  MIDDLEMIDDLE_OV_11_io_catch_config; // @[OverlayRocc.scala 369:49]
  wire  MIDDLESOUTH_OV_1_clock; // @[OverlayRocc.scala 418:48]
  wire  MIDDLESOUTH_OV_1_reset; // @[OverlayRocc.scala 418:48]
  wire [31:0] MIDDLESOUTH_OV_1_io_north_din; // @[OverlayRocc.scala 418:48]
  wire  MIDDLESOUTH_OV_1_io_north_din_v; // @[OverlayRocc.scala 418:48]
  wire  MIDDLESOUTH_OV_1_io_north_din_r; // @[OverlayRocc.scala 418:48]
  wire  MIDDLESOUTH_OV_1_io_east_din_r; // @[OverlayRocc.scala 418:48]
  wire  MIDDLESOUTH_OV_1_io_south_din_r; // @[OverlayRocc.scala 418:48]
  wire [31:0] MIDDLESOUTH_OV_1_io_west_din; // @[OverlayRocc.scala 418:48]
  wire  MIDDLESOUTH_OV_1_io_west_din_v; // @[OverlayRocc.scala 418:48]
  wire  MIDDLESOUTH_OV_1_io_north_dout_r; // @[OverlayRocc.scala 418:48]
  wire [31:0] MIDDLESOUTH_OV_1_io_east_dout; // @[OverlayRocc.scala 418:48]
  wire  MIDDLESOUTH_OV_1_io_east_dout_v; // @[OverlayRocc.scala 418:48]
  wire  MIDDLESOUTH_OV_1_io_east_dout_r; // @[OverlayRocc.scala 418:48]
  wire [31:0] MIDDLESOUTH_OV_1_io_south_dout; // @[OverlayRocc.scala 418:48]
  wire  MIDDLESOUTH_OV_1_io_south_dout_v; // @[OverlayRocc.scala 418:48]
  wire  MIDDLESOUTH_OV_1_io_west_dout_r; // @[OverlayRocc.scala 418:48]
  wire [181:0] MIDDLESOUTH_OV_1_io_config_bits; // @[OverlayRocc.scala 418:48]
  wire  MIDDLESOUTH_OV_1_io_catch_config; // @[OverlayRocc.scala 418:48]
  wire  MIDDLENORTH_OV_2_clock; // @[OverlayRocc.scala 320:48]
  wire  MIDDLENORTH_OV_2_reset; // @[OverlayRocc.scala 320:48]
  wire [31:0] MIDDLENORTH_OV_2_io_north_din; // @[OverlayRocc.scala 320:48]
  wire  MIDDLENORTH_OV_2_io_north_din_v; // @[OverlayRocc.scala 320:48]
  wire  MIDDLENORTH_OV_2_io_north_din_r; // @[OverlayRocc.scala 320:48]
  wire  MIDDLENORTH_OV_2_io_east_din_r; // @[OverlayRocc.scala 320:48]
  wire  MIDDLENORTH_OV_2_io_south_din_r; // @[OverlayRocc.scala 320:48]
  wire [31:0] MIDDLENORTH_OV_2_io_west_din; // @[OverlayRocc.scala 320:48]
  wire  MIDDLENORTH_OV_2_io_west_din_v; // @[OverlayRocc.scala 320:48]
  wire  MIDDLENORTH_OV_2_io_north_dout_r; // @[OverlayRocc.scala 320:48]
  wire [31:0] MIDDLENORTH_OV_2_io_east_dout; // @[OverlayRocc.scala 320:48]
  wire  MIDDLENORTH_OV_2_io_east_dout_v; // @[OverlayRocc.scala 320:48]
  wire  MIDDLENORTH_OV_2_io_east_dout_r; // @[OverlayRocc.scala 320:48]
  wire [31:0] MIDDLENORTH_OV_2_io_south_dout; // @[OverlayRocc.scala 320:48]
  wire  MIDDLENORTH_OV_2_io_south_dout_v; // @[OverlayRocc.scala 320:48]
  wire  MIDDLENORTH_OV_2_io_west_dout_r; // @[OverlayRocc.scala 320:48]
  wire [181:0] MIDDLENORTH_OV_2_io_config_bits; // @[OverlayRocc.scala 320:48]
  wire  MIDDLENORTH_OV_2_io_catch_config; // @[OverlayRocc.scala 320:48]
  wire  MIDDLEMIDDLE_OV_12_clock; // @[OverlayRocc.scala 369:49]
  wire  MIDDLEMIDDLE_OV_12_reset; // @[OverlayRocc.scala 369:49]
  wire [31:0] MIDDLEMIDDLE_OV_12_io_north_din; // @[OverlayRocc.scala 369:49]
  wire  MIDDLEMIDDLE_OV_12_io_north_din_v; // @[OverlayRocc.scala 369:49]
  wire  MIDDLEMIDDLE_OV_12_io_north_din_r; // @[OverlayRocc.scala 369:49]
  wire  MIDDLEMIDDLE_OV_12_io_east_din_r; // @[OverlayRocc.scala 369:49]
  wire  MIDDLEMIDDLE_OV_12_io_south_din_r; // @[OverlayRocc.scala 369:49]
  wire [31:0] MIDDLEMIDDLE_OV_12_io_west_din; // @[OverlayRocc.scala 369:49]
  wire  MIDDLEMIDDLE_OV_12_io_west_din_v; // @[OverlayRocc.scala 369:49]
  wire  MIDDLEMIDDLE_OV_12_io_north_dout_r; // @[OverlayRocc.scala 369:49]
  wire [31:0] MIDDLEMIDDLE_OV_12_io_east_dout; // @[OverlayRocc.scala 369:49]
  wire  MIDDLEMIDDLE_OV_12_io_east_dout_v; // @[OverlayRocc.scala 369:49]
  wire  MIDDLEMIDDLE_OV_12_io_east_dout_r; // @[OverlayRocc.scala 369:49]
  wire [31:0] MIDDLEMIDDLE_OV_12_io_south_dout; // @[OverlayRocc.scala 369:49]
  wire  MIDDLEMIDDLE_OV_12_io_south_dout_v; // @[OverlayRocc.scala 369:49]
  wire  MIDDLEMIDDLE_OV_12_io_west_dout_r; // @[OverlayRocc.scala 369:49]
  wire [181:0] MIDDLEMIDDLE_OV_12_io_config_bits; // @[OverlayRocc.scala 369:49]
  wire  MIDDLEMIDDLE_OV_12_io_catch_config; // @[OverlayRocc.scala 369:49]
  wire  MIDDLEMIDDLE_OV_13_clock; // @[OverlayRocc.scala 369:49]
  wire  MIDDLEMIDDLE_OV_13_reset; // @[OverlayRocc.scala 369:49]
  wire [31:0] MIDDLEMIDDLE_OV_13_io_north_din; // @[OverlayRocc.scala 369:49]
  wire  MIDDLEMIDDLE_OV_13_io_north_din_v; // @[OverlayRocc.scala 369:49]
  wire  MIDDLEMIDDLE_OV_13_io_north_din_r; // @[OverlayRocc.scala 369:49]
  wire  MIDDLEMIDDLE_OV_13_io_east_din_r; // @[OverlayRocc.scala 369:49]
  wire  MIDDLEMIDDLE_OV_13_io_south_din_r; // @[OverlayRocc.scala 369:49]
  wire [31:0] MIDDLEMIDDLE_OV_13_io_west_din; // @[OverlayRocc.scala 369:49]
  wire  MIDDLEMIDDLE_OV_13_io_west_din_v; // @[OverlayRocc.scala 369:49]
  wire  MIDDLEMIDDLE_OV_13_io_north_dout_r; // @[OverlayRocc.scala 369:49]
  wire [31:0] MIDDLEMIDDLE_OV_13_io_east_dout; // @[OverlayRocc.scala 369:49]
  wire  MIDDLEMIDDLE_OV_13_io_east_dout_v; // @[OverlayRocc.scala 369:49]
  wire  MIDDLEMIDDLE_OV_13_io_east_dout_r; // @[OverlayRocc.scala 369:49]
  wire [31:0] MIDDLEMIDDLE_OV_13_io_south_dout; // @[OverlayRocc.scala 369:49]
  wire  MIDDLEMIDDLE_OV_13_io_south_dout_v; // @[OverlayRocc.scala 369:49]
  wire  MIDDLEMIDDLE_OV_13_io_west_dout_r; // @[OverlayRocc.scala 369:49]
  wire [181:0] MIDDLEMIDDLE_OV_13_io_config_bits; // @[OverlayRocc.scala 369:49]
  wire  MIDDLEMIDDLE_OV_13_io_catch_config; // @[OverlayRocc.scala 369:49]
  wire  MIDDLEMIDDLE_OV_14_clock; // @[OverlayRocc.scala 369:49]
  wire  MIDDLEMIDDLE_OV_14_reset; // @[OverlayRocc.scala 369:49]
  wire [31:0] MIDDLEMIDDLE_OV_14_io_north_din; // @[OverlayRocc.scala 369:49]
  wire  MIDDLEMIDDLE_OV_14_io_north_din_v; // @[OverlayRocc.scala 369:49]
  wire  MIDDLEMIDDLE_OV_14_io_north_din_r; // @[OverlayRocc.scala 369:49]
  wire  MIDDLEMIDDLE_OV_14_io_east_din_r; // @[OverlayRocc.scala 369:49]
  wire  MIDDLEMIDDLE_OV_14_io_south_din_r; // @[OverlayRocc.scala 369:49]
  wire [31:0] MIDDLEMIDDLE_OV_14_io_west_din; // @[OverlayRocc.scala 369:49]
  wire  MIDDLEMIDDLE_OV_14_io_west_din_v; // @[OverlayRocc.scala 369:49]
  wire  MIDDLEMIDDLE_OV_14_io_north_dout_r; // @[OverlayRocc.scala 369:49]
  wire [31:0] MIDDLEMIDDLE_OV_14_io_east_dout; // @[OverlayRocc.scala 369:49]
  wire  MIDDLEMIDDLE_OV_14_io_east_dout_v; // @[OverlayRocc.scala 369:49]
  wire  MIDDLEMIDDLE_OV_14_io_east_dout_r; // @[OverlayRocc.scala 369:49]
  wire [31:0] MIDDLEMIDDLE_OV_14_io_south_dout; // @[OverlayRocc.scala 369:49]
  wire  MIDDLEMIDDLE_OV_14_io_south_dout_v; // @[OverlayRocc.scala 369:49]
  wire  MIDDLEMIDDLE_OV_14_io_west_dout_r; // @[OverlayRocc.scala 369:49]
  wire [181:0] MIDDLEMIDDLE_OV_14_io_config_bits; // @[OverlayRocc.scala 369:49]
  wire  MIDDLEMIDDLE_OV_14_io_catch_config; // @[OverlayRocc.scala 369:49]
  wire  MIDDLEMIDDLE_OV_15_clock; // @[OverlayRocc.scala 369:49]
  wire  MIDDLEMIDDLE_OV_15_reset; // @[OverlayRocc.scala 369:49]
  wire [31:0] MIDDLEMIDDLE_OV_15_io_north_din; // @[OverlayRocc.scala 369:49]
  wire  MIDDLEMIDDLE_OV_15_io_north_din_v; // @[OverlayRocc.scala 369:49]
  wire  MIDDLEMIDDLE_OV_15_io_north_din_r; // @[OverlayRocc.scala 369:49]
  wire  MIDDLEMIDDLE_OV_15_io_east_din_r; // @[OverlayRocc.scala 369:49]
  wire  MIDDLEMIDDLE_OV_15_io_south_din_r; // @[OverlayRocc.scala 369:49]
  wire [31:0] MIDDLEMIDDLE_OV_15_io_west_din; // @[OverlayRocc.scala 369:49]
  wire  MIDDLEMIDDLE_OV_15_io_west_din_v; // @[OverlayRocc.scala 369:49]
  wire  MIDDLEMIDDLE_OV_15_io_north_dout_r; // @[OverlayRocc.scala 369:49]
  wire [31:0] MIDDLEMIDDLE_OV_15_io_east_dout; // @[OverlayRocc.scala 369:49]
  wire  MIDDLEMIDDLE_OV_15_io_east_dout_v; // @[OverlayRocc.scala 369:49]
  wire  MIDDLEMIDDLE_OV_15_io_east_dout_r; // @[OverlayRocc.scala 369:49]
  wire [31:0] MIDDLEMIDDLE_OV_15_io_south_dout; // @[OverlayRocc.scala 369:49]
  wire  MIDDLEMIDDLE_OV_15_io_south_dout_v; // @[OverlayRocc.scala 369:49]
  wire  MIDDLEMIDDLE_OV_15_io_west_dout_r; // @[OverlayRocc.scala 369:49]
  wire [181:0] MIDDLEMIDDLE_OV_15_io_config_bits; // @[OverlayRocc.scala 369:49]
  wire  MIDDLEMIDDLE_OV_15_io_catch_config; // @[OverlayRocc.scala 369:49]
  wire  MIDDLEMIDDLE_OV_16_clock; // @[OverlayRocc.scala 369:49]
  wire  MIDDLEMIDDLE_OV_16_reset; // @[OverlayRocc.scala 369:49]
  wire [31:0] MIDDLEMIDDLE_OV_16_io_north_din; // @[OverlayRocc.scala 369:49]
  wire  MIDDLEMIDDLE_OV_16_io_north_din_v; // @[OverlayRocc.scala 369:49]
  wire  MIDDLEMIDDLE_OV_16_io_north_din_r; // @[OverlayRocc.scala 369:49]
  wire  MIDDLEMIDDLE_OV_16_io_east_din_r; // @[OverlayRocc.scala 369:49]
  wire  MIDDLEMIDDLE_OV_16_io_south_din_r; // @[OverlayRocc.scala 369:49]
  wire [31:0] MIDDLEMIDDLE_OV_16_io_west_din; // @[OverlayRocc.scala 369:49]
  wire  MIDDLEMIDDLE_OV_16_io_west_din_v; // @[OverlayRocc.scala 369:49]
  wire  MIDDLEMIDDLE_OV_16_io_north_dout_r; // @[OverlayRocc.scala 369:49]
  wire [31:0] MIDDLEMIDDLE_OV_16_io_east_dout; // @[OverlayRocc.scala 369:49]
  wire  MIDDLEMIDDLE_OV_16_io_east_dout_v; // @[OverlayRocc.scala 369:49]
  wire  MIDDLEMIDDLE_OV_16_io_east_dout_r; // @[OverlayRocc.scala 369:49]
  wire [31:0] MIDDLEMIDDLE_OV_16_io_south_dout; // @[OverlayRocc.scala 369:49]
  wire  MIDDLEMIDDLE_OV_16_io_south_dout_v; // @[OverlayRocc.scala 369:49]
  wire  MIDDLEMIDDLE_OV_16_io_west_dout_r; // @[OverlayRocc.scala 369:49]
  wire [181:0] MIDDLEMIDDLE_OV_16_io_config_bits; // @[OverlayRocc.scala 369:49]
  wire  MIDDLEMIDDLE_OV_16_io_catch_config; // @[OverlayRocc.scala 369:49]
  wire  MIDDLEMIDDLE_OV_17_clock; // @[OverlayRocc.scala 369:49]
  wire  MIDDLEMIDDLE_OV_17_reset; // @[OverlayRocc.scala 369:49]
  wire [31:0] MIDDLEMIDDLE_OV_17_io_north_din; // @[OverlayRocc.scala 369:49]
  wire  MIDDLEMIDDLE_OV_17_io_north_din_v; // @[OverlayRocc.scala 369:49]
  wire  MIDDLEMIDDLE_OV_17_io_north_din_r; // @[OverlayRocc.scala 369:49]
  wire  MIDDLEMIDDLE_OV_17_io_east_din_r; // @[OverlayRocc.scala 369:49]
  wire  MIDDLEMIDDLE_OV_17_io_south_din_r; // @[OverlayRocc.scala 369:49]
  wire [31:0] MIDDLEMIDDLE_OV_17_io_west_din; // @[OverlayRocc.scala 369:49]
  wire  MIDDLEMIDDLE_OV_17_io_west_din_v; // @[OverlayRocc.scala 369:49]
  wire  MIDDLEMIDDLE_OV_17_io_north_dout_r; // @[OverlayRocc.scala 369:49]
  wire [31:0] MIDDLEMIDDLE_OV_17_io_east_dout; // @[OverlayRocc.scala 369:49]
  wire  MIDDLEMIDDLE_OV_17_io_east_dout_v; // @[OverlayRocc.scala 369:49]
  wire  MIDDLEMIDDLE_OV_17_io_east_dout_r; // @[OverlayRocc.scala 369:49]
  wire [31:0] MIDDLEMIDDLE_OV_17_io_south_dout; // @[OverlayRocc.scala 369:49]
  wire  MIDDLEMIDDLE_OV_17_io_south_dout_v; // @[OverlayRocc.scala 369:49]
  wire  MIDDLEMIDDLE_OV_17_io_west_dout_r; // @[OverlayRocc.scala 369:49]
  wire [181:0] MIDDLEMIDDLE_OV_17_io_config_bits; // @[OverlayRocc.scala 369:49]
  wire  MIDDLEMIDDLE_OV_17_io_catch_config; // @[OverlayRocc.scala 369:49]
  wire  MIDDLESOUTH_OV_2_clock; // @[OverlayRocc.scala 418:48]
  wire  MIDDLESOUTH_OV_2_reset; // @[OverlayRocc.scala 418:48]
  wire [31:0] MIDDLESOUTH_OV_2_io_north_din; // @[OverlayRocc.scala 418:48]
  wire  MIDDLESOUTH_OV_2_io_north_din_v; // @[OverlayRocc.scala 418:48]
  wire  MIDDLESOUTH_OV_2_io_north_din_r; // @[OverlayRocc.scala 418:48]
  wire  MIDDLESOUTH_OV_2_io_east_din_r; // @[OverlayRocc.scala 418:48]
  wire  MIDDLESOUTH_OV_2_io_south_din_r; // @[OverlayRocc.scala 418:48]
  wire [31:0] MIDDLESOUTH_OV_2_io_west_din; // @[OverlayRocc.scala 418:48]
  wire  MIDDLESOUTH_OV_2_io_west_din_v; // @[OverlayRocc.scala 418:48]
  wire  MIDDLESOUTH_OV_2_io_north_dout_r; // @[OverlayRocc.scala 418:48]
  wire [31:0] MIDDLESOUTH_OV_2_io_east_dout; // @[OverlayRocc.scala 418:48]
  wire  MIDDLESOUTH_OV_2_io_east_dout_v; // @[OverlayRocc.scala 418:48]
  wire  MIDDLESOUTH_OV_2_io_east_dout_r; // @[OverlayRocc.scala 418:48]
  wire [31:0] MIDDLESOUTH_OV_2_io_south_dout; // @[OverlayRocc.scala 418:48]
  wire  MIDDLESOUTH_OV_2_io_south_dout_v; // @[OverlayRocc.scala 418:48]
  wire  MIDDLESOUTH_OV_2_io_west_dout_r; // @[OverlayRocc.scala 418:48]
  wire [181:0] MIDDLESOUTH_OV_2_io_config_bits; // @[OverlayRocc.scala 418:48]
  wire  MIDDLESOUTH_OV_2_io_catch_config; // @[OverlayRocc.scala 418:48]
  wire  MIDDLENORTH_OV_3_clock; // @[OverlayRocc.scala 320:48]
  wire  MIDDLENORTH_OV_3_reset; // @[OverlayRocc.scala 320:48]
  wire [31:0] MIDDLENORTH_OV_3_io_north_din; // @[OverlayRocc.scala 320:48]
  wire  MIDDLENORTH_OV_3_io_north_din_v; // @[OverlayRocc.scala 320:48]
  wire  MIDDLENORTH_OV_3_io_north_din_r; // @[OverlayRocc.scala 320:48]
  wire  MIDDLENORTH_OV_3_io_east_din_r; // @[OverlayRocc.scala 320:48]
  wire  MIDDLENORTH_OV_3_io_south_din_r; // @[OverlayRocc.scala 320:48]
  wire [31:0] MIDDLENORTH_OV_3_io_west_din; // @[OverlayRocc.scala 320:48]
  wire  MIDDLENORTH_OV_3_io_west_din_v; // @[OverlayRocc.scala 320:48]
  wire  MIDDLENORTH_OV_3_io_north_dout_r; // @[OverlayRocc.scala 320:48]
  wire [31:0] MIDDLENORTH_OV_3_io_east_dout; // @[OverlayRocc.scala 320:48]
  wire  MIDDLENORTH_OV_3_io_east_dout_v; // @[OverlayRocc.scala 320:48]
  wire  MIDDLENORTH_OV_3_io_east_dout_r; // @[OverlayRocc.scala 320:48]
  wire [31:0] MIDDLENORTH_OV_3_io_south_dout; // @[OverlayRocc.scala 320:48]
  wire  MIDDLENORTH_OV_3_io_south_dout_v; // @[OverlayRocc.scala 320:48]
  wire  MIDDLENORTH_OV_3_io_west_dout_r; // @[OverlayRocc.scala 320:48]
  wire [181:0] MIDDLENORTH_OV_3_io_config_bits; // @[OverlayRocc.scala 320:48]
  wire  MIDDLENORTH_OV_3_io_catch_config; // @[OverlayRocc.scala 320:48]
  wire  MIDDLEMIDDLE_OV_18_clock; // @[OverlayRocc.scala 369:49]
  wire  MIDDLEMIDDLE_OV_18_reset; // @[OverlayRocc.scala 369:49]
  wire [31:0] MIDDLEMIDDLE_OV_18_io_north_din; // @[OverlayRocc.scala 369:49]
  wire  MIDDLEMIDDLE_OV_18_io_north_din_v; // @[OverlayRocc.scala 369:49]
  wire  MIDDLEMIDDLE_OV_18_io_north_din_r; // @[OverlayRocc.scala 369:49]
  wire  MIDDLEMIDDLE_OV_18_io_east_din_r; // @[OverlayRocc.scala 369:49]
  wire  MIDDLEMIDDLE_OV_18_io_south_din_r; // @[OverlayRocc.scala 369:49]
  wire [31:0] MIDDLEMIDDLE_OV_18_io_west_din; // @[OverlayRocc.scala 369:49]
  wire  MIDDLEMIDDLE_OV_18_io_west_din_v; // @[OverlayRocc.scala 369:49]
  wire  MIDDLEMIDDLE_OV_18_io_north_dout_r; // @[OverlayRocc.scala 369:49]
  wire [31:0] MIDDLEMIDDLE_OV_18_io_east_dout; // @[OverlayRocc.scala 369:49]
  wire  MIDDLEMIDDLE_OV_18_io_east_dout_v; // @[OverlayRocc.scala 369:49]
  wire  MIDDLEMIDDLE_OV_18_io_east_dout_r; // @[OverlayRocc.scala 369:49]
  wire [31:0] MIDDLEMIDDLE_OV_18_io_south_dout; // @[OverlayRocc.scala 369:49]
  wire  MIDDLEMIDDLE_OV_18_io_south_dout_v; // @[OverlayRocc.scala 369:49]
  wire  MIDDLEMIDDLE_OV_18_io_west_dout_r; // @[OverlayRocc.scala 369:49]
  wire [181:0] MIDDLEMIDDLE_OV_18_io_config_bits; // @[OverlayRocc.scala 369:49]
  wire  MIDDLEMIDDLE_OV_18_io_catch_config; // @[OverlayRocc.scala 369:49]
  wire  MIDDLEMIDDLE_OV_19_clock; // @[OverlayRocc.scala 369:49]
  wire  MIDDLEMIDDLE_OV_19_reset; // @[OverlayRocc.scala 369:49]
  wire [31:0] MIDDLEMIDDLE_OV_19_io_north_din; // @[OverlayRocc.scala 369:49]
  wire  MIDDLEMIDDLE_OV_19_io_north_din_v; // @[OverlayRocc.scala 369:49]
  wire  MIDDLEMIDDLE_OV_19_io_north_din_r; // @[OverlayRocc.scala 369:49]
  wire  MIDDLEMIDDLE_OV_19_io_east_din_r; // @[OverlayRocc.scala 369:49]
  wire  MIDDLEMIDDLE_OV_19_io_south_din_r; // @[OverlayRocc.scala 369:49]
  wire [31:0] MIDDLEMIDDLE_OV_19_io_west_din; // @[OverlayRocc.scala 369:49]
  wire  MIDDLEMIDDLE_OV_19_io_west_din_v; // @[OverlayRocc.scala 369:49]
  wire  MIDDLEMIDDLE_OV_19_io_north_dout_r; // @[OverlayRocc.scala 369:49]
  wire [31:0] MIDDLEMIDDLE_OV_19_io_east_dout; // @[OverlayRocc.scala 369:49]
  wire  MIDDLEMIDDLE_OV_19_io_east_dout_v; // @[OverlayRocc.scala 369:49]
  wire  MIDDLEMIDDLE_OV_19_io_east_dout_r; // @[OverlayRocc.scala 369:49]
  wire [31:0] MIDDLEMIDDLE_OV_19_io_south_dout; // @[OverlayRocc.scala 369:49]
  wire  MIDDLEMIDDLE_OV_19_io_south_dout_v; // @[OverlayRocc.scala 369:49]
  wire  MIDDLEMIDDLE_OV_19_io_west_dout_r; // @[OverlayRocc.scala 369:49]
  wire [181:0] MIDDLEMIDDLE_OV_19_io_config_bits; // @[OverlayRocc.scala 369:49]
  wire  MIDDLEMIDDLE_OV_19_io_catch_config; // @[OverlayRocc.scala 369:49]
  wire  MIDDLEMIDDLE_OV_20_clock; // @[OverlayRocc.scala 369:49]
  wire  MIDDLEMIDDLE_OV_20_reset; // @[OverlayRocc.scala 369:49]
  wire [31:0] MIDDLEMIDDLE_OV_20_io_north_din; // @[OverlayRocc.scala 369:49]
  wire  MIDDLEMIDDLE_OV_20_io_north_din_v; // @[OverlayRocc.scala 369:49]
  wire  MIDDLEMIDDLE_OV_20_io_north_din_r; // @[OverlayRocc.scala 369:49]
  wire  MIDDLEMIDDLE_OV_20_io_east_din_r; // @[OverlayRocc.scala 369:49]
  wire  MIDDLEMIDDLE_OV_20_io_south_din_r; // @[OverlayRocc.scala 369:49]
  wire [31:0] MIDDLEMIDDLE_OV_20_io_west_din; // @[OverlayRocc.scala 369:49]
  wire  MIDDLEMIDDLE_OV_20_io_west_din_v; // @[OverlayRocc.scala 369:49]
  wire  MIDDLEMIDDLE_OV_20_io_north_dout_r; // @[OverlayRocc.scala 369:49]
  wire [31:0] MIDDLEMIDDLE_OV_20_io_east_dout; // @[OverlayRocc.scala 369:49]
  wire  MIDDLEMIDDLE_OV_20_io_east_dout_v; // @[OverlayRocc.scala 369:49]
  wire  MIDDLEMIDDLE_OV_20_io_east_dout_r; // @[OverlayRocc.scala 369:49]
  wire [31:0] MIDDLEMIDDLE_OV_20_io_south_dout; // @[OverlayRocc.scala 369:49]
  wire  MIDDLEMIDDLE_OV_20_io_south_dout_v; // @[OverlayRocc.scala 369:49]
  wire  MIDDLEMIDDLE_OV_20_io_west_dout_r; // @[OverlayRocc.scala 369:49]
  wire [181:0] MIDDLEMIDDLE_OV_20_io_config_bits; // @[OverlayRocc.scala 369:49]
  wire  MIDDLEMIDDLE_OV_20_io_catch_config; // @[OverlayRocc.scala 369:49]
  wire  MIDDLEMIDDLE_OV_21_clock; // @[OverlayRocc.scala 369:49]
  wire  MIDDLEMIDDLE_OV_21_reset; // @[OverlayRocc.scala 369:49]
  wire [31:0] MIDDLEMIDDLE_OV_21_io_north_din; // @[OverlayRocc.scala 369:49]
  wire  MIDDLEMIDDLE_OV_21_io_north_din_v; // @[OverlayRocc.scala 369:49]
  wire  MIDDLEMIDDLE_OV_21_io_north_din_r; // @[OverlayRocc.scala 369:49]
  wire  MIDDLEMIDDLE_OV_21_io_east_din_r; // @[OverlayRocc.scala 369:49]
  wire  MIDDLEMIDDLE_OV_21_io_south_din_r; // @[OverlayRocc.scala 369:49]
  wire [31:0] MIDDLEMIDDLE_OV_21_io_west_din; // @[OverlayRocc.scala 369:49]
  wire  MIDDLEMIDDLE_OV_21_io_west_din_v; // @[OverlayRocc.scala 369:49]
  wire  MIDDLEMIDDLE_OV_21_io_north_dout_r; // @[OverlayRocc.scala 369:49]
  wire [31:0] MIDDLEMIDDLE_OV_21_io_east_dout; // @[OverlayRocc.scala 369:49]
  wire  MIDDLEMIDDLE_OV_21_io_east_dout_v; // @[OverlayRocc.scala 369:49]
  wire  MIDDLEMIDDLE_OV_21_io_east_dout_r; // @[OverlayRocc.scala 369:49]
  wire [31:0] MIDDLEMIDDLE_OV_21_io_south_dout; // @[OverlayRocc.scala 369:49]
  wire  MIDDLEMIDDLE_OV_21_io_south_dout_v; // @[OverlayRocc.scala 369:49]
  wire  MIDDLEMIDDLE_OV_21_io_west_dout_r; // @[OverlayRocc.scala 369:49]
  wire [181:0] MIDDLEMIDDLE_OV_21_io_config_bits; // @[OverlayRocc.scala 369:49]
  wire  MIDDLEMIDDLE_OV_21_io_catch_config; // @[OverlayRocc.scala 369:49]
  wire  MIDDLEMIDDLE_OV_22_clock; // @[OverlayRocc.scala 369:49]
  wire  MIDDLEMIDDLE_OV_22_reset; // @[OverlayRocc.scala 369:49]
  wire [31:0] MIDDLEMIDDLE_OV_22_io_north_din; // @[OverlayRocc.scala 369:49]
  wire  MIDDLEMIDDLE_OV_22_io_north_din_v; // @[OverlayRocc.scala 369:49]
  wire  MIDDLEMIDDLE_OV_22_io_north_din_r; // @[OverlayRocc.scala 369:49]
  wire  MIDDLEMIDDLE_OV_22_io_east_din_r; // @[OverlayRocc.scala 369:49]
  wire  MIDDLEMIDDLE_OV_22_io_south_din_r; // @[OverlayRocc.scala 369:49]
  wire [31:0] MIDDLEMIDDLE_OV_22_io_west_din; // @[OverlayRocc.scala 369:49]
  wire  MIDDLEMIDDLE_OV_22_io_west_din_v; // @[OverlayRocc.scala 369:49]
  wire  MIDDLEMIDDLE_OV_22_io_north_dout_r; // @[OverlayRocc.scala 369:49]
  wire [31:0] MIDDLEMIDDLE_OV_22_io_east_dout; // @[OverlayRocc.scala 369:49]
  wire  MIDDLEMIDDLE_OV_22_io_east_dout_v; // @[OverlayRocc.scala 369:49]
  wire  MIDDLEMIDDLE_OV_22_io_east_dout_r; // @[OverlayRocc.scala 369:49]
  wire [31:0] MIDDLEMIDDLE_OV_22_io_south_dout; // @[OverlayRocc.scala 369:49]
  wire  MIDDLEMIDDLE_OV_22_io_south_dout_v; // @[OverlayRocc.scala 369:49]
  wire  MIDDLEMIDDLE_OV_22_io_west_dout_r; // @[OverlayRocc.scala 369:49]
  wire [181:0] MIDDLEMIDDLE_OV_22_io_config_bits; // @[OverlayRocc.scala 369:49]
  wire  MIDDLEMIDDLE_OV_22_io_catch_config; // @[OverlayRocc.scala 369:49]
  wire  MIDDLEMIDDLE_OV_23_clock; // @[OverlayRocc.scala 369:49]
  wire  MIDDLEMIDDLE_OV_23_reset; // @[OverlayRocc.scala 369:49]
  wire [31:0] MIDDLEMIDDLE_OV_23_io_north_din; // @[OverlayRocc.scala 369:49]
  wire  MIDDLEMIDDLE_OV_23_io_north_din_v; // @[OverlayRocc.scala 369:49]
  wire  MIDDLEMIDDLE_OV_23_io_north_din_r; // @[OverlayRocc.scala 369:49]
  wire  MIDDLEMIDDLE_OV_23_io_east_din_r; // @[OverlayRocc.scala 369:49]
  wire  MIDDLEMIDDLE_OV_23_io_south_din_r; // @[OverlayRocc.scala 369:49]
  wire [31:0] MIDDLEMIDDLE_OV_23_io_west_din; // @[OverlayRocc.scala 369:49]
  wire  MIDDLEMIDDLE_OV_23_io_west_din_v; // @[OverlayRocc.scala 369:49]
  wire  MIDDLEMIDDLE_OV_23_io_north_dout_r; // @[OverlayRocc.scala 369:49]
  wire [31:0] MIDDLEMIDDLE_OV_23_io_east_dout; // @[OverlayRocc.scala 369:49]
  wire  MIDDLEMIDDLE_OV_23_io_east_dout_v; // @[OverlayRocc.scala 369:49]
  wire  MIDDLEMIDDLE_OV_23_io_east_dout_r; // @[OverlayRocc.scala 369:49]
  wire [31:0] MIDDLEMIDDLE_OV_23_io_south_dout; // @[OverlayRocc.scala 369:49]
  wire  MIDDLEMIDDLE_OV_23_io_south_dout_v; // @[OverlayRocc.scala 369:49]
  wire  MIDDLEMIDDLE_OV_23_io_west_dout_r; // @[OverlayRocc.scala 369:49]
  wire [181:0] MIDDLEMIDDLE_OV_23_io_config_bits; // @[OverlayRocc.scala 369:49]
  wire  MIDDLEMIDDLE_OV_23_io_catch_config; // @[OverlayRocc.scala 369:49]
  wire  MIDDLESOUTH_OV_3_clock; // @[OverlayRocc.scala 418:48]
  wire  MIDDLESOUTH_OV_3_reset; // @[OverlayRocc.scala 418:48]
  wire [31:0] MIDDLESOUTH_OV_3_io_north_din; // @[OverlayRocc.scala 418:48]
  wire  MIDDLESOUTH_OV_3_io_north_din_v; // @[OverlayRocc.scala 418:48]
  wire  MIDDLESOUTH_OV_3_io_north_din_r; // @[OverlayRocc.scala 418:48]
  wire  MIDDLESOUTH_OV_3_io_east_din_r; // @[OverlayRocc.scala 418:48]
  wire  MIDDLESOUTH_OV_3_io_south_din_r; // @[OverlayRocc.scala 418:48]
  wire [31:0] MIDDLESOUTH_OV_3_io_west_din; // @[OverlayRocc.scala 418:48]
  wire  MIDDLESOUTH_OV_3_io_west_din_v; // @[OverlayRocc.scala 418:48]
  wire  MIDDLESOUTH_OV_3_io_north_dout_r; // @[OverlayRocc.scala 418:48]
  wire [31:0] MIDDLESOUTH_OV_3_io_east_dout; // @[OverlayRocc.scala 418:48]
  wire  MIDDLESOUTH_OV_3_io_east_dout_v; // @[OverlayRocc.scala 418:48]
  wire  MIDDLESOUTH_OV_3_io_east_dout_r; // @[OverlayRocc.scala 418:48]
  wire [31:0] MIDDLESOUTH_OV_3_io_south_dout; // @[OverlayRocc.scala 418:48]
  wire  MIDDLESOUTH_OV_3_io_south_dout_v; // @[OverlayRocc.scala 418:48]
  wire  MIDDLESOUTH_OV_3_io_west_dout_r; // @[OverlayRocc.scala 418:48]
  wire [181:0] MIDDLESOUTH_OV_3_io_config_bits; // @[OverlayRocc.scala 418:48]
  wire  MIDDLESOUTH_OV_3_io_catch_config; // @[OverlayRocc.scala 418:48]
  wire  MIDDLENORTH_OV_4_clock; // @[OverlayRocc.scala 320:48]
  wire  MIDDLENORTH_OV_4_reset; // @[OverlayRocc.scala 320:48]
  wire [31:0] MIDDLENORTH_OV_4_io_north_din; // @[OverlayRocc.scala 320:48]
  wire  MIDDLENORTH_OV_4_io_north_din_v; // @[OverlayRocc.scala 320:48]
  wire  MIDDLENORTH_OV_4_io_north_din_r; // @[OverlayRocc.scala 320:48]
  wire  MIDDLENORTH_OV_4_io_east_din_r; // @[OverlayRocc.scala 320:48]
  wire  MIDDLENORTH_OV_4_io_south_din_r; // @[OverlayRocc.scala 320:48]
  wire [31:0] MIDDLENORTH_OV_4_io_west_din; // @[OverlayRocc.scala 320:48]
  wire  MIDDLENORTH_OV_4_io_west_din_v; // @[OverlayRocc.scala 320:48]
  wire  MIDDLENORTH_OV_4_io_north_dout_r; // @[OverlayRocc.scala 320:48]
  wire [31:0] MIDDLENORTH_OV_4_io_east_dout; // @[OverlayRocc.scala 320:48]
  wire  MIDDLENORTH_OV_4_io_east_dout_v; // @[OverlayRocc.scala 320:48]
  wire  MIDDLENORTH_OV_4_io_east_dout_r; // @[OverlayRocc.scala 320:48]
  wire [31:0] MIDDLENORTH_OV_4_io_south_dout; // @[OverlayRocc.scala 320:48]
  wire  MIDDLENORTH_OV_4_io_south_dout_v; // @[OverlayRocc.scala 320:48]
  wire  MIDDLENORTH_OV_4_io_west_dout_r; // @[OverlayRocc.scala 320:48]
  wire [181:0] MIDDLENORTH_OV_4_io_config_bits; // @[OverlayRocc.scala 320:48]
  wire  MIDDLENORTH_OV_4_io_catch_config; // @[OverlayRocc.scala 320:48]
  wire  MIDDLEMIDDLE_OV_24_clock; // @[OverlayRocc.scala 369:49]
  wire  MIDDLEMIDDLE_OV_24_reset; // @[OverlayRocc.scala 369:49]
  wire [31:0] MIDDLEMIDDLE_OV_24_io_north_din; // @[OverlayRocc.scala 369:49]
  wire  MIDDLEMIDDLE_OV_24_io_north_din_v; // @[OverlayRocc.scala 369:49]
  wire  MIDDLEMIDDLE_OV_24_io_north_din_r; // @[OverlayRocc.scala 369:49]
  wire  MIDDLEMIDDLE_OV_24_io_east_din_r; // @[OverlayRocc.scala 369:49]
  wire  MIDDLEMIDDLE_OV_24_io_south_din_r; // @[OverlayRocc.scala 369:49]
  wire [31:0] MIDDLEMIDDLE_OV_24_io_west_din; // @[OverlayRocc.scala 369:49]
  wire  MIDDLEMIDDLE_OV_24_io_west_din_v; // @[OverlayRocc.scala 369:49]
  wire  MIDDLEMIDDLE_OV_24_io_north_dout_r; // @[OverlayRocc.scala 369:49]
  wire [31:0] MIDDLEMIDDLE_OV_24_io_east_dout; // @[OverlayRocc.scala 369:49]
  wire  MIDDLEMIDDLE_OV_24_io_east_dout_v; // @[OverlayRocc.scala 369:49]
  wire  MIDDLEMIDDLE_OV_24_io_east_dout_r; // @[OverlayRocc.scala 369:49]
  wire [31:0] MIDDLEMIDDLE_OV_24_io_south_dout; // @[OverlayRocc.scala 369:49]
  wire  MIDDLEMIDDLE_OV_24_io_south_dout_v; // @[OverlayRocc.scala 369:49]
  wire  MIDDLEMIDDLE_OV_24_io_west_dout_r; // @[OverlayRocc.scala 369:49]
  wire [181:0] MIDDLEMIDDLE_OV_24_io_config_bits; // @[OverlayRocc.scala 369:49]
  wire  MIDDLEMIDDLE_OV_24_io_catch_config; // @[OverlayRocc.scala 369:49]
  wire  MIDDLEMIDDLE_OV_25_clock; // @[OverlayRocc.scala 369:49]
  wire  MIDDLEMIDDLE_OV_25_reset; // @[OverlayRocc.scala 369:49]
  wire [31:0] MIDDLEMIDDLE_OV_25_io_north_din; // @[OverlayRocc.scala 369:49]
  wire  MIDDLEMIDDLE_OV_25_io_north_din_v; // @[OverlayRocc.scala 369:49]
  wire  MIDDLEMIDDLE_OV_25_io_north_din_r; // @[OverlayRocc.scala 369:49]
  wire  MIDDLEMIDDLE_OV_25_io_east_din_r; // @[OverlayRocc.scala 369:49]
  wire  MIDDLEMIDDLE_OV_25_io_south_din_r; // @[OverlayRocc.scala 369:49]
  wire [31:0] MIDDLEMIDDLE_OV_25_io_west_din; // @[OverlayRocc.scala 369:49]
  wire  MIDDLEMIDDLE_OV_25_io_west_din_v; // @[OverlayRocc.scala 369:49]
  wire  MIDDLEMIDDLE_OV_25_io_north_dout_r; // @[OverlayRocc.scala 369:49]
  wire [31:0] MIDDLEMIDDLE_OV_25_io_east_dout; // @[OverlayRocc.scala 369:49]
  wire  MIDDLEMIDDLE_OV_25_io_east_dout_v; // @[OverlayRocc.scala 369:49]
  wire  MIDDLEMIDDLE_OV_25_io_east_dout_r; // @[OverlayRocc.scala 369:49]
  wire [31:0] MIDDLEMIDDLE_OV_25_io_south_dout; // @[OverlayRocc.scala 369:49]
  wire  MIDDLEMIDDLE_OV_25_io_south_dout_v; // @[OverlayRocc.scala 369:49]
  wire  MIDDLEMIDDLE_OV_25_io_west_dout_r; // @[OverlayRocc.scala 369:49]
  wire [181:0] MIDDLEMIDDLE_OV_25_io_config_bits; // @[OverlayRocc.scala 369:49]
  wire  MIDDLEMIDDLE_OV_25_io_catch_config; // @[OverlayRocc.scala 369:49]
  wire  MIDDLEMIDDLE_OV_26_clock; // @[OverlayRocc.scala 369:49]
  wire  MIDDLEMIDDLE_OV_26_reset; // @[OverlayRocc.scala 369:49]
  wire [31:0] MIDDLEMIDDLE_OV_26_io_north_din; // @[OverlayRocc.scala 369:49]
  wire  MIDDLEMIDDLE_OV_26_io_north_din_v; // @[OverlayRocc.scala 369:49]
  wire  MIDDLEMIDDLE_OV_26_io_north_din_r; // @[OverlayRocc.scala 369:49]
  wire  MIDDLEMIDDLE_OV_26_io_east_din_r; // @[OverlayRocc.scala 369:49]
  wire  MIDDLEMIDDLE_OV_26_io_south_din_r; // @[OverlayRocc.scala 369:49]
  wire [31:0] MIDDLEMIDDLE_OV_26_io_west_din; // @[OverlayRocc.scala 369:49]
  wire  MIDDLEMIDDLE_OV_26_io_west_din_v; // @[OverlayRocc.scala 369:49]
  wire  MIDDLEMIDDLE_OV_26_io_north_dout_r; // @[OverlayRocc.scala 369:49]
  wire [31:0] MIDDLEMIDDLE_OV_26_io_east_dout; // @[OverlayRocc.scala 369:49]
  wire  MIDDLEMIDDLE_OV_26_io_east_dout_v; // @[OverlayRocc.scala 369:49]
  wire  MIDDLEMIDDLE_OV_26_io_east_dout_r; // @[OverlayRocc.scala 369:49]
  wire [31:0] MIDDLEMIDDLE_OV_26_io_south_dout; // @[OverlayRocc.scala 369:49]
  wire  MIDDLEMIDDLE_OV_26_io_south_dout_v; // @[OverlayRocc.scala 369:49]
  wire  MIDDLEMIDDLE_OV_26_io_west_dout_r; // @[OverlayRocc.scala 369:49]
  wire [181:0] MIDDLEMIDDLE_OV_26_io_config_bits; // @[OverlayRocc.scala 369:49]
  wire  MIDDLEMIDDLE_OV_26_io_catch_config; // @[OverlayRocc.scala 369:49]
  wire  MIDDLEMIDDLE_OV_27_clock; // @[OverlayRocc.scala 369:49]
  wire  MIDDLEMIDDLE_OV_27_reset; // @[OverlayRocc.scala 369:49]
  wire [31:0] MIDDLEMIDDLE_OV_27_io_north_din; // @[OverlayRocc.scala 369:49]
  wire  MIDDLEMIDDLE_OV_27_io_north_din_v; // @[OverlayRocc.scala 369:49]
  wire  MIDDLEMIDDLE_OV_27_io_north_din_r; // @[OverlayRocc.scala 369:49]
  wire  MIDDLEMIDDLE_OV_27_io_east_din_r; // @[OverlayRocc.scala 369:49]
  wire  MIDDLEMIDDLE_OV_27_io_south_din_r; // @[OverlayRocc.scala 369:49]
  wire [31:0] MIDDLEMIDDLE_OV_27_io_west_din; // @[OverlayRocc.scala 369:49]
  wire  MIDDLEMIDDLE_OV_27_io_west_din_v; // @[OverlayRocc.scala 369:49]
  wire  MIDDLEMIDDLE_OV_27_io_north_dout_r; // @[OverlayRocc.scala 369:49]
  wire [31:0] MIDDLEMIDDLE_OV_27_io_east_dout; // @[OverlayRocc.scala 369:49]
  wire  MIDDLEMIDDLE_OV_27_io_east_dout_v; // @[OverlayRocc.scala 369:49]
  wire  MIDDLEMIDDLE_OV_27_io_east_dout_r; // @[OverlayRocc.scala 369:49]
  wire [31:0] MIDDLEMIDDLE_OV_27_io_south_dout; // @[OverlayRocc.scala 369:49]
  wire  MIDDLEMIDDLE_OV_27_io_south_dout_v; // @[OverlayRocc.scala 369:49]
  wire  MIDDLEMIDDLE_OV_27_io_west_dout_r; // @[OverlayRocc.scala 369:49]
  wire [181:0] MIDDLEMIDDLE_OV_27_io_config_bits; // @[OverlayRocc.scala 369:49]
  wire  MIDDLEMIDDLE_OV_27_io_catch_config; // @[OverlayRocc.scala 369:49]
  wire  MIDDLEMIDDLE_OV_28_clock; // @[OverlayRocc.scala 369:49]
  wire  MIDDLEMIDDLE_OV_28_reset; // @[OverlayRocc.scala 369:49]
  wire [31:0] MIDDLEMIDDLE_OV_28_io_north_din; // @[OverlayRocc.scala 369:49]
  wire  MIDDLEMIDDLE_OV_28_io_north_din_v; // @[OverlayRocc.scala 369:49]
  wire  MIDDLEMIDDLE_OV_28_io_north_din_r; // @[OverlayRocc.scala 369:49]
  wire  MIDDLEMIDDLE_OV_28_io_east_din_r; // @[OverlayRocc.scala 369:49]
  wire  MIDDLEMIDDLE_OV_28_io_south_din_r; // @[OverlayRocc.scala 369:49]
  wire [31:0] MIDDLEMIDDLE_OV_28_io_west_din; // @[OverlayRocc.scala 369:49]
  wire  MIDDLEMIDDLE_OV_28_io_west_din_v; // @[OverlayRocc.scala 369:49]
  wire  MIDDLEMIDDLE_OV_28_io_north_dout_r; // @[OverlayRocc.scala 369:49]
  wire [31:0] MIDDLEMIDDLE_OV_28_io_east_dout; // @[OverlayRocc.scala 369:49]
  wire  MIDDLEMIDDLE_OV_28_io_east_dout_v; // @[OverlayRocc.scala 369:49]
  wire  MIDDLEMIDDLE_OV_28_io_east_dout_r; // @[OverlayRocc.scala 369:49]
  wire [31:0] MIDDLEMIDDLE_OV_28_io_south_dout; // @[OverlayRocc.scala 369:49]
  wire  MIDDLEMIDDLE_OV_28_io_south_dout_v; // @[OverlayRocc.scala 369:49]
  wire  MIDDLEMIDDLE_OV_28_io_west_dout_r; // @[OverlayRocc.scala 369:49]
  wire [181:0] MIDDLEMIDDLE_OV_28_io_config_bits; // @[OverlayRocc.scala 369:49]
  wire  MIDDLEMIDDLE_OV_28_io_catch_config; // @[OverlayRocc.scala 369:49]
  wire  MIDDLEMIDDLE_OV_29_clock; // @[OverlayRocc.scala 369:49]
  wire  MIDDLEMIDDLE_OV_29_reset; // @[OverlayRocc.scala 369:49]
  wire [31:0] MIDDLEMIDDLE_OV_29_io_north_din; // @[OverlayRocc.scala 369:49]
  wire  MIDDLEMIDDLE_OV_29_io_north_din_v; // @[OverlayRocc.scala 369:49]
  wire  MIDDLEMIDDLE_OV_29_io_north_din_r; // @[OverlayRocc.scala 369:49]
  wire  MIDDLEMIDDLE_OV_29_io_east_din_r; // @[OverlayRocc.scala 369:49]
  wire  MIDDLEMIDDLE_OV_29_io_south_din_r; // @[OverlayRocc.scala 369:49]
  wire [31:0] MIDDLEMIDDLE_OV_29_io_west_din; // @[OverlayRocc.scala 369:49]
  wire  MIDDLEMIDDLE_OV_29_io_west_din_v; // @[OverlayRocc.scala 369:49]
  wire  MIDDLEMIDDLE_OV_29_io_north_dout_r; // @[OverlayRocc.scala 369:49]
  wire [31:0] MIDDLEMIDDLE_OV_29_io_east_dout; // @[OverlayRocc.scala 369:49]
  wire  MIDDLEMIDDLE_OV_29_io_east_dout_v; // @[OverlayRocc.scala 369:49]
  wire  MIDDLEMIDDLE_OV_29_io_east_dout_r; // @[OverlayRocc.scala 369:49]
  wire [31:0] MIDDLEMIDDLE_OV_29_io_south_dout; // @[OverlayRocc.scala 369:49]
  wire  MIDDLEMIDDLE_OV_29_io_south_dout_v; // @[OverlayRocc.scala 369:49]
  wire  MIDDLEMIDDLE_OV_29_io_west_dout_r; // @[OverlayRocc.scala 369:49]
  wire [181:0] MIDDLEMIDDLE_OV_29_io_config_bits; // @[OverlayRocc.scala 369:49]
  wire  MIDDLEMIDDLE_OV_29_io_catch_config; // @[OverlayRocc.scala 369:49]
  wire  MIDDLESOUTH_OV_4_clock; // @[OverlayRocc.scala 418:48]
  wire  MIDDLESOUTH_OV_4_reset; // @[OverlayRocc.scala 418:48]
  wire [31:0] MIDDLESOUTH_OV_4_io_north_din; // @[OverlayRocc.scala 418:48]
  wire  MIDDLESOUTH_OV_4_io_north_din_v; // @[OverlayRocc.scala 418:48]
  wire  MIDDLESOUTH_OV_4_io_north_din_r; // @[OverlayRocc.scala 418:48]
  wire  MIDDLESOUTH_OV_4_io_east_din_r; // @[OverlayRocc.scala 418:48]
  wire  MIDDLESOUTH_OV_4_io_south_din_r; // @[OverlayRocc.scala 418:48]
  wire [31:0] MIDDLESOUTH_OV_4_io_west_din; // @[OverlayRocc.scala 418:48]
  wire  MIDDLESOUTH_OV_4_io_west_din_v; // @[OverlayRocc.scala 418:48]
  wire  MIDDLESOUTH_OV_4_io_north_dout_r; // @[OverlayRocc.scala 418:48]
  wire [31:0] MIDDLESOUTH_OV_4_io_east_dout; // @[OverlayRocc.scala 418:48]
  wire  MIDDLESOUTH_OV_4_io_east_dout_v; // @[OverlayRocc.scala 418:48]
  wire  MIDDLESOUTH_OV_4_io_east_dout_r; // @[OverlayRocc.scala 418:48]
  wire [31:0] MIDDLESOUTH_OV_4_io_south_dout; // @[OverlayRocc.scala 418:48]
  wire  MIDDLESOUTH_OV_4_io_south_dout_v; // @[OverlayRocc.scala 418:48]
  wire  MIDDLESOUTH_OV_4_io_west_dout_r; // @[OverlayRocc.scala 418:48]
  wire [181:0] MIDDLESOUTH_OV_4_io_config_bits; // @[OverlayRocc.scala 418:48]
  wire  MIDDLESOUTH_OV_4_io_catch_config; // @[OverlayRocc.scala 418:48]
  wire  MIDDLENORTH_OV_5_clock; // @[OverlayRocc.scala 320:48]
  wire  MIDDLENORTH_OV_5_reset; // @[OverlayRocc.scala 320:48]
  wire [31:0] MIDDLENORTH_OV_5_io_north_din; // @[OverlayRocc.scala 320:48]
  wire  MIDDLENORTH_OV_5_io_north_din_v; // @[OverlayRocc.scala 320:48]
  wire  MIDDLENORTH_OV_5_io_north_din_r; // @[OverlayRocc.scala 320:48]
  wire  MIDDLENORTH_OV_5_io_east_din_r; // @[OverlayRocc.scala 320:48]
  wire  MIDDLENORTH_OV_5_io_south_din_r; // @[OverlayRocc.scala 320:48]
  wire [31:0] MIDDLENORTH_OV_5_io_west_din; // @[OverlayRocc.scala 320:48]
  wire  MIDDLENORTH_OV_5_io_west_din_v; // @[OverlayRocc.scala 320:48]
  wire  MIDDLENORTH_OV_5_io_north_dout_r; // @[OverlayRocc.scala 320:48]
  wire [31:0] MIDDLENORTH_OV_5_io_east_dout; // @[OverlayRocc.scala 320:48]
  wire  MIDDLENORTH_OV_5_io_east_dout_v; // @[OverlayRocc.scala 320:48]
  wire  MIDDLENORTH_OV_5_io_east_dout_r; // @[OverlayRocc.scala 320:48]
  wire [31:0] MIDDLENORTH_OV_5_io_south_dout; // @[OverlayRocc.scala 320:48]
  wire  MIDDLENORTH_OV_5_io_south_dout_v; // @[OverlayRocc.scala 320:48]
  wire  MIDDLENORTH_OV_5_io_west_dout_r; // @[OverlayRocc.scala 320:48]
  wire [181:0] MIDDLENORTH_OV_5_io_config_bits; // @[OverlayRocc.scala 320:48]
  wire  MIDDLENORTH_OV_5_io_catch_config; // @[OverlayRocc.scala 320:48]
  wire  MIDDLEMIDDLE_OV_30_clock; // @[OverlayRocc.scala 369:49]
  wire  MIDDLEMIDDLE_OV_30_reset; // @[OverlayRocc.scala 369:49]
  wire [31:0] MIDDLEMIDDLE_OV_30_io_north_din; // @[OverlayRocc.scala 369:49]
  wire  MIDDLEMIDDLE_OV_30_io_north_din_v; // @[OverlayRocc.scala 369:49]
  wire  MIDDLEMIDDLE_OV_30_io_north_din_r; // @[OverlayRocc.scala 369:49]
  wire  MIDDLEMIDDLE_OV_30_io_east_din_r; // @[OverlayRocc.scala 369:49]
  wire  MIDDLEMIDDLE_OV_30_io_south_din_r; // @[OverlayRocc.scala 369:49]
  wire [31:0] MIDDLEMIDDLE_OV_30_io_west_din; // @[OverlayRocc.scala 369:49]
  wire  MIDDLEMIDDLE_OV_30_io_west_din_v; // @[OverlayRocc.scala 369:49]
  wire  MIDDLEMIDDLE_OV_30_io_north_dout_r; // @[OverlayRocc.scala 369:49]
  wire [31:0] MIDDLEMIDDLE_OV_30_io_east_dout; // @[OverlayRocc.scala 369:49]
  wire  MIDDLEMIDDLE_OV_30_io_east_dout_v; // @[OverlayRocc.scala 369:49]
  wire  MIDDLEMIDDLE_OV_30_io_east_dout_r; // @[OverlayRocc.scala 369:49]
  wire [31:0] MIDDLEMIDDLE_OV_30_io_south_dout; // @[OverlayRocc.scala 369:49]
  wire  MIDDLEMIDDLE_OV_30_io_south_dout_v; // @[OverlayRocc.scala 369:49]
  wire  MIDDLEMIDDLE_OV_30_io_west_dout_r; // @[OverlayRocc.scala 369:49]
  wire [181:0] MIDDLEMIDDLE_OV_30_io_config_bits; // @[OverlayRocc.scala 369:49]
  wire  MIDDLEMIDDLE_OV_30_io_catch_config; // @[OverlayRocc.scala 369:49]
  wire  MIDDLEMIDDLE_OV_31_clock; // @[OverlayRocc.scala 369:49]
  wire  MIDDLEMIDDLE_OV_31_reset; // @[OverlayRocc.scala 369:49]
  wire [31:0] MIDDLEMIDDLE_OV_31_io_north_din; // @[OverlayRocc.scala 369:49]
  wire  MIDDLEMIDDLE_OV_31_io_north_din_v; // @[OverlayRocc.scala 369:49]
  wire  MIDDLEMIDDLE_OV_31_io_north_din_r; // @[OverlayRocc.scala 369:49]
  wire  MIDDLEMIDDLE_OV_31_io_east_din_r; // @[OverlayRocc.scala 369:49]
  wire  MIDDLEMIDDLE_OV_31_io_south_din_r; // @[OverlayRocc.scala 369:49]
  wire [31:0] MIDDLEMIDDLE_OV_31_io_west_din; // @[OverlayRocc.scala 369:49]
  wire  MIDDLEMIDDLE_OV_31_io_west_din_v; // @[OverlayRocc.scala 369:49]
  wire  MIDDLEMIDDLE_OV_31_io_north_dout_r; // @[OverlayRocc.scala 369:49]
  wire [31:0] MIDDLEMIDDLE_OV_31_io_east_dout; // @[OverlayRocc.scala 369:49]
  wire  MIDDLEMIDDLE_OV_31_io_east_dout_v; // @[OverlayRocc.scala 369:49]
  wire  MIDDLEMIDDLE_OV_31_io_east_dout_r; // @[OverlayRocc.scala 369:49]
  wire [31:0] MIDDLEMIDDLE_OV_31_io_south_dout; // @[OverlayRocc.scala 369:49]
  wire  MIDDLEMIDDLE_OV_31_io_south_dout_v; // @[OverlayRocc.scala 369:49]
  wire  MIDDLEMIDDLE_OV_31_io_west_dout_r; // @[OverlayRocc.scala 369:49]
  wire [181:0] MIDDLEMIDDLE_OV_31_io_config_bits; // @[OverlayRocc.scala 369:49]
  wire  MIDDLEMIDDLE_OV_31_io_catch_config; // @[OverlayRocc.scala 369:49]
  wire  MIDDLEMIDDLE_OV_32_clock; // @[OverlayRocc.scala 369:49]
  wire  MIDDLEMIDDLE_OV_32_reset; // @[OverlayRocc.scala 369:49]
  wire [31:0] MIDDLEMIDDLE_OV_32_io_north_din; // @[OverlayRocc.scala 369:49]
  wire  MIDDLEMIDDLE_OV_32_io_north_din_v; // @[OverlayRocc.scala 369:49]
  wire  MIDDLEMIDDLE_OV_32_io_north_din_r; // @[OverlayRocc.scala 369:49]
  wire  MIDDLEMIDDLE_OV_32_io_east_din_r; // @[OverlayRocc.scala 369:49]
  wire  MIDDLEMIDDLE_OV_32_io_south_din_r; // @[OverlayRocc.scala 369:49]
  wire [31:0] MIDDLEMIDDLE_OV_32_io_west_din; // @[OverlayRocc.scala 369:49]
  wire  MIDDLEMIDDLE_OV_32_io_west_din_v; // @[OverlayRocc.scala 369:49]
  wire  MIDDLEMIDDLE_OV_32_io_north_dout_r; // @[OverlayRocc.scala 369:49]
  wire [31:0] MIDDLEMIDDLE_OV_32_io_east_dout; // @[OverlayRocc.scala 369:49]
  wire  MIDDLEMIDDLE_OV_32_io_east_dout_v; // @[OverlayRocc.scala 369:49]
  wire  MIDDLEMIDDLE_OV_32_io_east_dout_r; // @[OverlayRocc.scala 369:49]
  wire [31:0] MIDDLEMIDDLE_OV_32_io_south_dout; // @[OverlayRocc.scala 369:49]
  wire  MIDDLEMIDDLE_OV_32_io_south_dout_v; // @[OverlayRocc.scala 369:49]
  wire  MIDDLEMIDDLE_OV_32_io_west_dout_r; // @[OverlayRocc.scala 369:49]
  wire [181:0] MIDDLEMIDDLE_OV_32_io_config_bits; // @[OverlayRocc.scala 369:49]
  wire  MIDDLEMIDDLE_OV_32_io_catch_config; // @[OverlayRocc.scala 369:49]
  wire  MIDDLEMIDDLE_OV_33_clock; // @[OverlayRocc.scala 369:49]
  wire  MIDDLEMIDDLE_OV_33_reset; // @[OverlayRocc.scala 369:49]
  wire [31:0] MIDDLEMIDDLE_OV_33_io_north_din; // @[OverlayRocc.scala 369:49]
  wire  MIDDLEMIDDLE_OV_33_io_north_din_v; // @[OverlayRocc.scala 369:49]
  wire  MIDDLEMIDDLE_OV_33_io_north_din_r; // @[OverlayRocc.scala 369:49]
  wire  MIDDLEMIDDLE_OV_33_io_east_din_r; // @[OverlayRocc.scala 369:49]
  wire  MIDDLEMIDDLE_OV_33_io_south_din_r; // @[OverlayRocc.scala 369:49]
  wire [31:0] MIDDLEMIDDLE_OV_33_io_west_din; // @[OverlayRocc.scala 369:49]
  wire  MIDDLEMIDDLE_OV_33_io_west_din_v; // @[OverlayRocc.scala 369:49]
  wire  MIDDLEMIDDLE_OV_33_io_north_dout_r; // @[OverlayRocc.scala 369:49]
  wire [31:0] MIDDLEMIDDLE_OV_33_io_east_dout; // @[OverlayRocc.scala 369:49]
  wire  MIDDLEMIDDLE_OV_33_io_east_dout_v; // @[OverlayRocc.scala 369:49]
  wire  MIDDLEMIDDLE_OV_33_io_east_dout_r; // @[OverlayRocc.scala 369:49]
  wire [31:0] MIDDLEMIDDLE_OV_33_io_south_dout; // @[OverlayRocc.scala 369:49]
  wire  MIDDLEMIDDLE_OV_33_io_south_dout_v; // @[OverlayRocc.scala 369:49]
  wire  MIDDLEMIDDLE_OV_33_io_west_dout_r; // @[OverlayRocc.scala 369:49]
  wire [181:0] MIDDLEMIDDLE_OV_33_io_config_bits; // @[OverlayRocc.scala 369:49]
  wire  MIDDLEMIDDLE_OV_33_io_catch_config; // @[OverlayRocc.scala 369:49]
  wire  MIDDLEMIDDLE_OV_34_clock; // @[OverlayRocc.scala 369:49]
  wire  MIDDLEMIDDLE_OV_34_reset; // @[OverlayRocc.scala 369:49]
  wire [31:0] MIDDLEMIDDLE_OV_34_io_north_din; // @[OverlayRocc.scala 369:49]
  wire  MIDDLEMIDDLE_OV_34_io_north_din_v; // @[OverlayRocc.scala 369:49]
  wire  MIDDLEMIDDLE_OV_34_io_north_din_r; // @[OverlayRocc.scala 369:49]
  wire  MIDDLEMIDDLE_OV_34_io_east_din_r; // @[OverlayRocc.scala 369:49]
  wire  MIDDLEMIDDLE_OV_34_io_south_din_r; // @[OverlayRocc.scala 369:49]
  wire [31:0] MIDDLEMIDDLE_OV_34_io_west_din; // @[OverlayRocc.scala 369:49]
  wire  MIDDLEMIDDLE_OV_34_io_west_din_v; // @[OverlayRocc.scala 369:49]
  wire  MIDDLEMIDDLE_OV_34_io_north_dout_r; // @[OverlayRocc.scala 369:49]
  wire [31:0] MIDDLEMIDDLE_OV_34_io_east_dout; // @[OverlayRocc.scala 369:49]
  wire  MIDDLEMIDDLE_OV_34_io_east_dout_v; // @[OverlayRocc.scala 369:49]
  wire  MIDDLEMIDDLE_OV_34_io_east_dout_r; // @[OverlayRocc.scala 369:49]
  wire [31:0] MIDDLEMIDDLE_OV_34_io_south_dout; // @[OverlayRocc.scala 369:49]
  wire  MIDDLEMIDDLE_OV_34_io_south_dout_v; // @[OverlayRocc.scala 369:49]
  wire  MIDDLEMIDDLE_OV_34_io_west_dout_r; // @[OverlayRocc.scala 369:49]
  wire [181:0] MIDDLEMIDDLE_OV_34_io_config_bits; // @[OverlayRocc.scala 369:49]
  wire  MIDDLEMIDDLE_OV_34_io_catch_config; // @[OverlayRocc.scala 369:49]
  wire  MIDDLEMIDDLE_OV_35_clock; // @[OverlayRocc.scala 369:49]
  wire  MIDDLEMIDDLE_OV_35_reset; // @[OverlayRocc.scala 369:49]
  wire [31:0] MIDDLEMIDDLE_OV_35_io_north_din; // @[OverlayRocc.scala 369:49]
  wire  MIDDLEMIDDLE_OV_35_io_north_din_v; // @[OverlayRocc.scala 369:49]
  wire  MIDDLEMIDDLE_OV_35_io_north_din_r; // @[OverlayRocc.scala 369:49]
  wire  MIDDLEMIDDLE_OV_35_io_east_din_r; // @[OverlayRocc.scala 369:49]
  wire  MIDDLEMIDDLE_OV_35_io_south_din_r; // @[OverlayRocc.scala 369:49]
  wire [31:0] MIDDLEMIDDLE_OV_35_io_west_din; // @[OverlayRocc.scala 369:49]
  wire  MIDDLEMIDDLE_OV_35_io_west_din_v; // @[OverlayRocc.scala 369:49]
  wire  MIDDLEMIDDLE_OV_35_io_north_dout_r; // @[OverlayRocc.scala 369:49]
  wire [31:0] MIDDLEMIDDLE_OV_35_io_east_dout; // @[OverlayRocc.scala 369:49]
  wire  MIDDLEMIDDLE_OV_35_io_east_dout_v; // @[OverlayRocc.scala 369:49]
  wire  MIDDLEMIDDLE_OV_35_io_east_dout_r; // @[OverlayRocc.scala 369:49]
  wire [31:0] MIDDLEMIDDLE_OV_35_io_south_dout; // @[OverlayRocc.scala 369:49]
  wire  MIDDLEMIDDLE_OV_35_io_south_dout_v; // @[OverlayRocc.scala 369:49]
  wire  MIDDLEMIDDLE_OV_35_io_west_dout_r; // @[OverlayRocc.scala 369:49]
  wire [181:0] MIDDLEMIDDLE_OV_35_io_config_bits; // @[OverlayRocc.scala 369:49]
  wire  MIDDLEMIDDLE_OV_35_io_catch_config; // @[OverlayRocc.scala 369:49]
  wire  MIDDLESOUTH_OV_5_clock; // @[OverlayRocc.scala 418:48]
  wire  MIDDLESOUTH_OV_5_reset; // @[OverlayRocc.scala 418:48]
  wire [31:0] MIDDLESOUTH_OV_5_io_north_din; // @[OverlayRocc.scala 418:48]
  wire  MIDDLESOUTH_OV_5_io_north_din_v; // @[OverlayRocc.scala 418:48]
  wire  MIDDLESOUTH_OV_5_io_north_din_r; // @[OverlayRocc.scala 418:48]
  wire  MIDDLESOUTH_OV_5_io_east_din_r; // @[OverlayRocc.scala 418:48]
  wire  MIDDLESOUTH_OV_5_io_south_din_r; // @[OverlayRocc.scala 418:48]
  wire [31:0] MIDDLESOUTH_OV_5_io_west_din; // @[OverlayRocc.scala 418:48]
  wire  MIDDLESOUTH_OV_5_io_west_din_v; // @[OverlayRocc.scala 418:48]
  wire  MIDDLESOUTH_OV_5_io_north_dout_r; // @[OverlayRocc.scala 418:48]
  wire [31:0] MIDDLESOUTH_OV_5_io_east_dout; // @[OverlayRocc.scala 418:48]
  wire  MIDDLESOUTH_OV_5_io_east_dout_v; // @[OverlayRocc.scala 418:48]
  wire  MIDDLESOUTH_OV_5_io_east_dout_r; // @[OverlayRocc.scala 418:48]
  wire [31:0] MIDDLESOUTH_OV_5_io_south_dout; // @[OverlayRocc.scala 418:48]
  wire  MIDDLESOUTH_OV_5_io_south_dout_v; // @[OverlayRocc.scala 418:48]
  wire  MIDDLESOUTH_OV_5_io_west_dout_r; // @[OverlayRocc.scala 418:48]
  wire [181:0] MIDDLESOUTH_OV_5_io_config_bits; // @[OverlayRocc.scala 418:48]
  wire  MIDDLESOUTH_OV_5_io_catch_config; // @[OverlayRocc.scala 418:48]
  wire  NORTHEAST_OV_clock; // @[OverlayRocc.scala 471:46]
  wire  NORTHEAST_OV_reset; // @[OverlayRocc.scala 471:46]
  wire [31:0] NORTHEAST_OV_io_north_din; // @[OverlayRocc.scala 471:46]
  wire  NORTHEAST_OV_io_north_din_v; // @[OverlayRocc.scala 471:46]
  wire  NORTHEAST_OV_io_north_din_r; // @[OverlayRocc.scala 471:46]
  wire  NORTHEAST_OV_io_east_din_r; // @[OverlayRocc.scala 471:46]
  wire  NORTHEAST_OV_io_south_din_r; // @[OverlayRocc.scala 471:46]
  wire [31:0] NORTHEAST_OV_io_west_din; // @[OverlayRocc.scala 471:46]
  wire  NORTHEAST_OV_io_west_din_v; // @[OverlayRocc.scala 471:46]
  wire  NORTHEAST_OV_io_north_dout_r; // @[OverlayRocc.scala 471:46]
  wire [31:0] NORTHEAST_OV_io_east_dout; // @[OverlayRocc.scala 471:46]
  wire  NORTHEAST_OV_io_east_dout_v; // @[OverlayRocc.scala 471:46]
  wire  NORTHEAST_OV_io_east_dout_r; // @[OverlayRocc.scala 471:46]
  wire [31:0] NORTHEAST_OV_io_south_dout; // @[OverlayRocc.scala 471:46]
  wire  NORTHEAST_OV_io_south_dout_v; // @[OverlayRocc.scala 471:46]
  wire  NORTHEAST_OV_io_west_dout_r; // @[OverlayRocc.scala 471:46]
  wire [181:0] NORTHEAST_OV_io_config_bits; // @[OverlayRocc.scala 471:46]
  wire  NORTHEAST_OV_io_catch_config; // @[OverlayRocc.scala 471:46]
  wire  MIDDLEEAST_OV_clock; // @[OverlayRocc.scala 520:47]
  wire  MIDDLEEAST_OV_reset; // @[OverlayRocc.scala 520:47]
  wire [31:0] MIDDLEEAST_OV_io_north_din; // @[OverlayRocc.scala 520:47]
  wire  MIDDLEEAST_OV_io_north_din_v; // @[OverlayRocc.scala 520:47]
  wire  MIDDLEEAST_OV_io_north_din_r; // @[OverlayRocc.scala 520:47]
  wire  MIDDLEEAST_OV_io_east_din_r; // @[OverlayRocc.scala 520:47]
  wire  MIDDLEEAST_OV_io_south_din_r; // @[OverlayRocc.scala 520:47]
  wire [31:0] MIDDLEEAST_OV_io_west_din; // @[OverlayRocc.scala 520:47]
  wire  MIDDLEEAST_OV_io_west_din_v; // @[OverlayRocc.scala 520:47]
  wire  MIDDLEEAST_OV_io_north_dout_r; // @[OverlayRocc.scala 520:47]
  wire [31:0] MIDDLEEAST_OV_io_east_dout; // @[OverlayRocc.scala 520:47]
  wire  MIDDLEEAST_OV_io_east_dout_v; // @[OverlayRocc.scala 520:47]
  wire  MIDDLEEAST_OV_io_east_dout_r; // @[OverlayRocc.scala 520:47]
  wire [31:0] MIDDLEEAST_OV_io_south_dout; // @[OverlayRocc.scala 520:47]
  wire  MIDDLEEAST_OV_io_south_dout_v; // @[OverlayRocc.scala 520:47]
  wire  MIDDLEEAST_OV_io_west_dout_r; // @[OverlayRocc.scala 520:47]
  wire [181:0] MIDDLEEAST_OV_io_config_bits; // @[OverlayRocc.scala 520:47]
  wire  MIDDLEEAST_OV_io_catch_config; // @[OverlayRocc.scala 520:47]
  wire  MIDDLEEAST_OV_1_clock; // @[OverlayRocc.scala 520:47]
  wire  MIDDLEEAST_OV_1_reset; // @[OverlayRocc.scala 520:47]
  wire [31:0] MIDDLEEAST_OV_1_io_north_din; // @[OverlayRocc.scala 520:47]
  wire  MIDDLEEAST_OV_1_io_north_din_v; // @[OverlayRocc.scala 520:47]
  wire  MIDDLEEAST_OV_1_io_north_din_r; // @[OverlayRocc.scala 520:47]
  wire  MIDDLEEAST_OV_1_io_east_din_r; // @[OverlayRocc.scala 520:47]
  wire  MIDDLEEAST_OV_1_io_south_din_r; // @[OverlayRocc.scala 520:47]
  wire [31:0] MIDDLEEAST_OV_1_io_west_din; // @[OverlayRocc.scala 520:47]
  wire  MIDDLEEAST_OV_1_io_west_din_v; // @[OverlayRocc.scala 520:47]
  wire  MIDDLEEAST_OV_1_io_north_dout_r; // @[OverlayRocc.scala 520:47]
  wire [31:0] MIDDLEEAST_OV_1_io_east_dout; // @[OverlayRocc.scala 520:47]
  wire  MIDDLEEAST_OV_1_io_east_dout_v; // @[OverlayRocc.scala 520:47]
  wire  MIDDLEEAST_OV_1_io_east_dout_r; // @[OverlayRocc.scala 520:47]
  wire [31:0] MIDDLEEAST_OV_1_io_south_dout; // @[OverlayRocc.scala 520:47]
  wire  MIDDLEEAST_OV_1_io_south_dout_v; // @[OverlayRocc.scala 520:47]
  wire  MIDDLEEAST_OV_1_io_west_dout_r; // @[OverlayRocc.scala 520:47]
  wire [181:0] MIDDLEEAST_OV_1_io_config_bits; // @[OverlayRocc.scala 520:47]
  wire  MIDDLEEAST_OV_1_io_catch_config; // @[OverlayRocc.scala 520:47]
  wire  MIDDLEEAST_OV_2_clock; // @[OverlayRocc.scala 520:47]
  wire  MIDDLEEAST_OV_2_reset; // @[OverlayRocc.scala 520:47]
  wire [31:0] MIDDLEEAST_OV_2_io_north_din; // @[OverlayRocc.scala 520:47]
  wire  MIDDLEEAST_OV_2_io_north_din_v; // @[OverlayRocc.scala 520:47]
  wire  MIDDLEEAST_OV_2_io_north_din_r; // @[OverlayRocc.scala 520:47]
  wire  MIDDLEEAST_OV_2_io_east_din_r; // @[OverlayRocc.scala 520:47]
  wire  MIDDLEEAST_OV_2_io_south_din_r; // @[OverlayRocc.scala 520:47]
  wire [31:0] MIDDLEEAST_OV_2_io_west_din; // @[OverlayRocc.scala 520:47]
  wire  MIDDLEEAST_OV_2_io_west_din_v; // @[OverlayRocc.scala 520:47]
  wire  MIDDLEEAST_OV_2_io_north_dout_r; // @[OverlayRocc.scala 520:47]
  wire [31:0] MIDDLEEAST_OV_2_io_east_dout; // @[OverlayRocc.scala 520:47]
  wire  MIDDLEEAST_OV_2_io_east_dout_v; // @[OverlayRocc.scala 520:47]
  wire  MIDDLEEAST_OV_2_io_east_dout_r; // @[OverlayRocc.scala 520:47]
  wire [31:0] MIDDLEEAST_OV_2_io_south_dout; // @[OverlayRocc.scala 520:47]
  wire  MIDDLEEAST_OV_2_io_south_dout_v; // @[OverlayRocc.scala 520:47]
  wire  MIDDLEEAST_OV_2_io_west_dout_r; // @[OverlayRocc.scala 520:47]
  wire [181:0] MIDDLEEAST_OV_2_io_config_bits; // @[OverlayRocc.scala 520:47]
  wire  MIDDLEEAST_OV_2_io_catch_config; // @[OverlayRocc.scala 520:47]
  wire  MIDDLEEAST_OV_3_clock; // @[OverlayRocc.scala 520:47]
  wire  MIDDLEEAST_OV_3_reset; // @[OverlayRocc.scala 520:47]
  wire [31:0] MIDDLEEAST_OV_3_io_north_din; // @[OverlayRocc.scala 520:47]
  wire  MIDDLEEAST_OV_3_io_north_din_v; // @[OverlayRocc.scala 520:47]
  wire  MIDDLEEAST_OV_3_io_north_din_r; // @[OverlayRocc.scala 520:47]
  wire  MIDDLEEAST_OV_3_io_east_din_r; // @[OverlayRocc.scala 520:47]
  wire  MIDDLEEAST_OV_3_io_south_din_r; // @[OverlayRocc.scala 520:47]
  wire [31:0] MIDDLEEAST_OV_3_io_west_din; // @[OverlayRocc.scala 520:47]
  wire  MIDDLEEAST_OV_3_io_west_din_v; // @[OverlayRocc.scala 520:47]
  wire  MIDDLEEAST_OV_3_io_north_dout_r; // @[OverlayRocc.scala 520:47]
  wire [31:0] MIDDLEEAST_OV_3_io_east_dout; // @[OverlayRocc.scala 520:47]
  wire  MIDDLEEAST_OV_3_io_east_dout_v; // @[OverlayRocc.scala 520:47]
  wire  MIDDLEEAST_OV_3_io_east_dout_r; // @[OverlayRocc.scala 520:47]
  wire [31:0] MIDDLEEAST_OV_3_io_south_dout; // @[OverlayRocc.scala 520:47]
  wire  MIDDLEEAST_OV_3_io_south_dout_v; // @[OverlayRocc.scala 520:47]
  wire  MIDDLEEAST_OV_3_io_west_dout_r; // @[OverlayRocc.scala 520:47]
  wire [181:0] MIDDLEEAST_OV_3_io_config_bits; // @[OverlayRocc.scala 520:47]
  wire  MIDDLEEAST_OV_3_io_catch_config; // @[OverlayRocc.scala 520:47]
  wire  MIDDLEEAST_OV_4_clock; // @[OverlayRocc.scala 520:47]
  wire  MIDDLEEAST_OV_4_reset; // @[OverlayRocc.scala 520:47]
  wire [31:0] MIDDLEEAST_OV_4_io_north_din; // @[OverlayRocc.scala 520:47]
  wire  MIDDLEEAST_OV_4_io_north_din_v; // @[OverlayRocc.scala 520:47]
  wire  MIDDLEEAST_OV_4_io_north_din_r; // @[OverlayRocc.scala 520:47]
  wire  MIDDLEEAST_OV_4_io_east_din_r; // @[OverlayRocc.scala 520:47]
  wire  MIDDLEEAST_OV_4_io_south_din_r; // @[OverlayRocc.scala 520:47]
  wire [31:0] MIDDLEEAST_OV_4_io_west_din; // @[OverlayRocc.scala 520:47]
  wire  MIDDLEEAST_OV_4_io_west_din_v; // @[OverlayRocc.scala 520:47]
  wire  MIDDLEEAST_OV_4_io_north_dout_r; // @[OverlayRocc.scala 520:47]
  wire [31:0] MIDDLEEAST_OV_4_io_east_dout; // @[OverlayRocc.scala 520:47]
  wire  MIDDLEEAST_OV_4_io_east_dout_v; // @[OverlayRocc.scala 520:47]
  wire  MIDDLEEAST_OV_4_io_east_dout_r; // @[OverlayRocc.scala 520:47]
  wire [31:0] MIDDLEEAST_OV_4_io_south_dout; // @[OverlayRocc.scala 520:47]
  wire  MIDDLEEAST_OV_4_io_south_dout_v; // @[OverlayRocc.scala 520:47]
  wire  MIDDLEEAST_OV_4_io_west_dout_r; // @[OverlayRocc.scala 520:47]
  wire [181:0] MIDDLEEAST_OV_4_io_config_bits; // @[OverlayRocc.scala 520:47]
  wire  MIDDLEEAST_OV_4_io_catch_config; // @[OverlayRocc.scala 520:47]
  wire  MIDDLEEAST_OV_5_clock; // @[OverlayRocc.scala 520:47]
  wire  MIDDLEEAST_OV_5_reset; // @[OverlayRocc.scala 520:47]
  wire [31:0] MIDDLEEAST_OV_5_io_north_din; // @[OverlayRocc.scala 520:47]
  wire  MIDDLEEAST_OV_5_io_north_din_v; // @[OverlayRocc.scala 520:47]
  wire  MIDDLEEAST_OV_5_io_north_din_r; // @[OverlayRocc.scala 520:47]
  wire  MIDDLEEAST_OV_5_io_east_din_r; // @[OverlayRocc.scala 520:47]
  wire  MIDDLEEAST_OV_5_io_south_din_r; // @[OverlayRocc.scala 520:47]
  wire [31:0] MIDDLEEAST_OV_5_io_west_din; // @[OverlayRocc.scala 520:47]
  wire  MIDDLEEAST_OV_5_io_west_din_v; // @[OverlayRocc.scala 520:47]
  wire  MIDDLEEAST_OV_5_io_north_dout_r; // @[OverlayRocc.scala 520:47]
  wire [31:0] MIDDLEEAST_OV_5_io_east_dout; // @[OverlayRocc.scala 520:47]
  wire  MIDDLEEAST_OV_5_io_east_dout_v; // @[OverlayRocc.scala 520:47]
  wire  MIDDLEEAST_OV_5_io_east_dout_r; // @[OverlayRocc.scala 520:47]
  wire [31:0] MIDDLEEAST_OV_5_io_south_dout; // @[OverlayRocc.scala 520:47]
  wire  MIDDLEEAST_OV_5_io_south_dout_v; // @[OverlayRocc.scala 520:47]
  wire  MIDDLEEAST_OV_5_io_west_dout_r; // @[OverlayRocc.scala 520:47]
  wire [181:0] MIDDLEEAST_OV_5_io_config_bits; // @[OverlayRocc.scala 520:47]
  wire  MIDDLEEAST_OV_5_io_catch_config; // @[OverlayRocc.scala 520:47]
  wire  MIDDLESOUTH_OV_6_clock; // @[OverlayRocc.scala 569:48]
  wire  MIDDLESOUTH_OV_6_reset; // @[OverlayRocc.scala 569:48]
  wire [31:0] MIDDLESOUTH_OV_6_io_north_din; // @[OverlayRocc.scala 569:48]
  wire  MIDDLESOUTH_OV_6_io_north_din_v; // @[OverlayRocc.scala 569:48]
  wire  MIDDLESOUTH_OV_6_io_north_din_r; // @[OverlayRocc.scala 569:48]
  wire  MIDDLESOUTH_OV_6_io_east_din_r; // @[OverlayRocc.scala 569:48]
  wire  MIDDLESOUTH_OV_6_io_south_din_r; // @[OverlayRocc.scala 569:48]
  wire [31:0] MIDDLESOUTH_OV_6_io_west_din; // @[OverlayRocc.scala 569:48]
  wire  MIDDLESOUTH_OV_6_io_west_din_v; // @[OverlayRocc.scala 569:48]
  wire  MIDDLESOUTH_OV_6_io_north_dout_r; // @[OverlayRocc.scala 569:48]
  wire [31:0] MIDDLESOUTH_OV_6_io_east_dout; // @[OverlayRocc.scala 569:48]
  wire  MIDDLESOUTH_OV_6_io_east_dout_v; // @[OverlayRocc.scala 569:48]
  wire  MIDDLESOUTH_OV_6_io_east_dout_r; // @[OverlayRocc.scala 569:48]
  wire [31:0] MIDDLESOUTH_OV_6_io_south_dout; // @[OverlayRocc.scala 569:48]
  wire  MIDDLESOUTH_OV_6_io_south_dout_v; // @[OverlayRocc.scala 569:48]
  wire  MIDDLESOUTH_OV_6_io_west_dout_r; // @[OverlayRocc.scala 569:48]
  wire [181:0] MIDDLESOUTH_OV_6_io_config_bits; // @[OverlayRocc.scala 569:48]
  wire  MIDDLESOUTH_OV_6_io_catch_config; // @[OverlayRocc.scala 569:48]
  reg [31:0] north_din_0; // @[OverlayRocc.scala 24:24]
  reg [31:0] north_din_1; // @[OverlayRocc.scala 24:24]
  reg [31:0] north_din_2; // @[OverlayRocc.scala 24:24]
  reg [31:0] north_din_3; // @[OverlayRocc.scala 24:24]
  reg [31:0] north_din_4; // @[OverlayRocc.scala 24:24]
  reg [31:0] north_din_5; // @[OverlayRocc.scala 24:24]
  reg [31:0] north_din_6; // @[OverlayRocc.scala 24:24]
  reg [31:0] north_din_7; // @[OverlayRocc.scala 24:24]
  reg [7:0] north_din_v; // @[OverlayRocc.scala 25:30]
  reg [31:0] east_dout_0; // @[OverlayRocc.scala 28:24]
  reg [31:0] east_dout_1; // @[OverlayRocc.scala 28:24]
  reg [31:0] east_dout_2; // @[OverlayRocc.scala 28:24]
  reg [31:0] east_dout_3; // @[OverlayRocc.scala 28:24]
  reg [31:0] east_dout_4; // @[OverlayRocc.scala 28:24]
  reg [31:0] east_dout_5; // @[OverlayRocc.scala 28:24]
  reg [31:0] east_dout_6; // @[OverlayRocc.scala 28:24]
  reg [31:0] east_dout_7; // @[OverlayRocc.scala 28:24]
  reg [7:0] east_dout_r; // @[OverlayRocc.scala 30:30]
  reg [181:0] config_bits_0; // @[OverlayRocc.scala 88:26]
  reg [181:0] config_bits_1; // @[OverlayRocc.scala 88:26]
  reg [181:0] config_bits_2; // @[OverlayRocc.scala 88:26]
  reg [181:0] config_bits_3; // @[OverlayRocc.scala 88:26]
  reg [181:0] config_bits_4; // @[OverlayRocc.scala 88:26]
  reg [181:0] config_bits_5; // @[OverlayRocc.scala 88:26]
  reg [181:0] config_bits_6; // @[OverlayRocc.scala 88:26]
  reg [181:0] config_bits_7; // @[OverlayRocc.scala 88:26]
  reg [181:0] config_bits_8; // @[OverlayRocc.scala 88:26]
  reg [181:0] config_bits_9; // @[OverlayRocc.scala 88:26]
  reg [181:0] config_bits_10; // @[OverlayRocc.scala 88:26]
  reg [181:0] config_bits_11; // @[OverlayRocc.scala 88:26]
  reg [181:0] config_bits_12; // @[OverlayRocc.scala 88:26]
  reg [181:0] config_bits_13; // @[OverlayRocc.scala 88:26]
  reg [181:0] config_bits_14; // @[OverlayRocc.scala 88:26]
  reg [181:0] config_bits_15; // @[OverlayRocc.scala 88:26]
  reg [181:0] config_bits_16; // @[OverlayRocc.scala 88:26]
  reg [181:0] config_bits_17; // @[OverlayRocc.scala 88:26]
  reg [181:0] config_bits_18; // @[OverlayRocc.scala 88:26]
  reg [181:0] config_bits_19; // @[OverlayRocc.scala 88:26]
  reg [181:0] config_bits_20; // @[OverlayRocc.scala 88:26]
  reg [181:0] config_bits_21; // @[OverlayRocc.scala 88:26]
  reg [181:0] config_bits_22; // @[OverlayRocc.scala 88:26]
  reg [181:0] config_bits_23; // @[OverlayRocc.scala 88:26]
  reg [181:0] config_bits_24; // @[OverlayRocc.scala 88:26]
  reg [181:0] config_bits_25; // @[OverlayRocc.scala 88:26]
  reg [181:0] config_bits_26; // @[OverlayRocc.scala 88:26]
  reg [181:0] config_bits_27; // @[OverlayRocc.scala 88:26]
  reg [181:0] config_bits_28; // @[OverlayRocc.scala 88:26]
  reg [181:0] config_bits_29; // @[OverlayRocc.scala 88:26]
  reg [181:0] config_bits_30; // @[OverlayRocc.scala 88:26]
  reg [181:0] config_bits_31; // @[OverlayRocc.scala 88:26]
  reg [181:0] config_bits_32; // @[OverlayRocc.scala 88:26]
  reg [181:0] config_bits_33; // @[OverlayRocc.scala 88:26]
  reg [181:0] config_bits_34; // @[OverlayRocc.scala 88:26]
  reg [181:0] config_bits_35; // @[OverlayRocc.scala 88:26]
  reg [181:0] config_bits_36; // @[OverlayRocc.scala 88:26]
  reg [181:0] config_bits_37; // @[OverlayRocc.scala 88:26]
  reg [181:0] config_bits_38; // @[OverlayRocc.scala 88:26]
  reg [181:0] config_bits_39; // @[OverlayRocc.scala 88:26]
  reg [181:0] config_bits_40; // @[OverlayRocc.scala 88:26]
  reg [181:0] config_bits_41; // @[OverlayRocc.scala 88:26]
  reg [181:0] config_bits_42; // @[OverlayRocc.scala 88:26]
  reg [181:0] config_bits_43; // @[OverlayRocc.scala 88:26]
  reg [181:0] config_bits_44; // @[OverlayRocc.scala 88:26]
  reg [181:0] config_bits_45; // @[OverlayRocc.scala 88:26]
  reg [181:0] config_bits_46; // @[OverlayRocc.scala 88:26]
  reg [181:0] config_bits_47; // @[OverlayRocc.scala 88:26]
  reg [181:0] config_bits_48; // @[OverlayRocc.scala 88:26]
  reg [181:0] config_bits_49; // @[OverlayRocc.scala 88:26]
  reg [181:0] config_bits_50; // @[OverlayRocc.scala 88:26]
  reg [181:0] config_bits_51; // @[OverlayRocc.scala 88:26]
  reg [181:0] config_bits_52; // @[OverlayRocc.scala 88:26]
  reg [181:0] config_bits_53; // @[OverlayRocc.scala 88:26]
  reg [181:0] config_bits_54; // @[OverlayRocc.scala 88:26]
  reg [181:0] config_bits_55; // @[OverlayRocc.scala 88:26]
  reg [181:0] config_bits_56; // @[OverlayRocc.scala 88:26]
  reg [181:0] config_bits_57; // @[OverlayRocc.scala 88:26]
  reg [181:0] config_bits_58; // @[OverlayRocc.scala 88:26]
  reg [181:0] config_bits_59; // @[OverlayRocc.scala 88:26]
  reg [181:0] config_bits_60; // @[OverlayRocc.scala 88:26]
  reg [181:0] config_bits_61; // @[OverlayRocc.scala 88:26]
  reg [181:0] config_bits_62; // @[OverlayRocc.scala 88:26]
  reg [181:0] config_bits_63; // @[OverlayRocc.scala 88:26]
  reg [181:0] catch_config_0; // @[OverlayRocc.scala 89:27]
  reg [181:0] catch_config_1; // @[OverlayRocc.scala 89:27]
  reg [181:0] catch_config_2; // @[OverlayRocc.scala 89:27]
  reg [181:0] catch_config_3; // @[OverlayRocc.scala 89:27]
  reg [181:0] catch_config_4; // @[OverlayRocc.scala 89:27]
  reg [181:0] catch_config_5; // @[OverlayRocc.scala 89:27]
  reg [181:0] catch_config_6; // @[OverlayRocc.scala 89:27]
  reg [181:0] catch_config_7; // @[OverlayRocc.scala 89:27]
  reg [181:0] catch_config_8; // @[OverlayRocc.scala 89:27]
  reg [181:0] catch_config_9; // @[OverlayRocc.scala 89:27]
  reg [181:0] catch_config_10; // @[OverlayRocc.scala 89:27]
  reg [181:0] catch_config_11; // @[OverlayRocc.scala 89:27]
  reg [181:0] catch_config_12; // @[OverlayRocc.scala 89:27]
  reg [181:0] catch_config_13; // @[OverlayRocc.scala 89:27]
  reg [181:0] catch_config_14; // @[OverlayRocc.scala 89:27]
  reg [181:0] catch_config_15; // @[OverlayRocc.scala 89:27]
  reg [181:0] catch_config_16; // @[OverlayRocc.scala 89:27]
  reg [181:0] catch_config_17; // @[OverlayRocc.scala 89:27]
  reg [181:0] catch_config_18; // @[OverlayRocc.scala 89:27]
  reg [181:0] catch_config_19; // @[OverlayRocc.scala 89:27]
  reg [181:0] catch_config_20; // @[OverlayRocc.scala 89:27]
  reg [181:0] catch_config_21; // @[OverlayRocc.scala 89:27]
  reg [181:0] catch_config_22; // @[OverlayRocc.scala 89:27]
  reg [181:0] catch_config_23; // @[OverlayRocc.scala 89:27]
  reg [181:0] catch_config_24; // @[OverlayRocc.scala 89:27]
  reg [181:0] catch_config_25; // @[OverlayRocc.scala 89:27]
  reg [181:0] catch_config_26; // @[OverlayRocc.scala 89:27]
  reg [181:0] catch_config_27; // @[OverlayRocc.scala 89:27]
  reg [181:0] catch_config_28; // @[OverlayRocc.scala 89:27]
  reg [181:0] catch_config_29; // @[OverlayRocc.scala 89:27]
  reg [181:0] catch_config_30; // @[OverlayRocc.scala 89:27]
  reg [181:0] catch_config_31; // @[OverlayRocc.scala 89:27]
  reg [181:0] catch_config_32; // @[OverlayRocc.scala 89:27]
  reg [181:0] catch_config_33; // @[OverlayRocc.scala 89:27]
  reg [181:0] catch_config_34; // @[OverlayRocc.scala 89:27]
  reg [181:0] catch_config_35; // @[OverlayRocc.scala 89:27]
  reg [181:0] catch_config_36; // @[OverlayRocc.scala 89:27]
  reg [181:0] catch_config_37; // @[OverlayRocc.scala 89:27]
  reg [181:0] catch_config_38; // @[OverlayRocc.scala 89:27]
  reg [181:0] catch_config_39; // @[OverlayRocc.scala 89:27]
  reg [181:0] catch_config_40; // @[OverlayRocc.scala 89:27]
  reg [181:0] catch_config_41; // @[OverlayRocc.scala 89:27]
  reg [181:0] catch_config_42; // @[OverlayRocc.scala 89:27]
  reg [181:0] catch_config_43; // @[OverlayRocc.scala 89:27]
  reg [181:0] catch_config_44; // @[OverlayRocc.scala 89:27]
  reg [181:0] catch_config_45; // @[OverlayRocc.scala 89:27]
  reg [181:0] catch_config_46; // @[OverlayRocc.scala 89:27]
  reg [181:0] catch_config_47; // @[OverlayRocc.scala 89:27]
  reg [181:0] catch_config_48; // @[OverlayRocc.scala 89:27]
  reg [181:0] catch_config_49; // @[OverlayRocc.scala 89:27]
  reg [181:0] catch_config_50; // @[OverlayRocc.scala 89:27]
  reg [181:0] catch_config_51; // @[OverlayRocc.scala 89:27]
  reg [181:0] catch_config_52; // @[OverlayRocc.scala 89:27]
  reg [181:0] catch_config_53; // @[OverlayRocc.scala 89:27]
  reg [181:0] catch_config_54; // @[OverlayRocc.scala 89:27]
  reg [181:0] catch_config_55; // @[OverlayRocc.scala 89:27]
  reg [181:0] catch_config_56; // @[OverlayRocc.scala 89:27]
  reg [181:0] catch_config_57; // @[OverlayRocc.scala 89:27]
  reg [181:0] catch_config_58; // @[OverlayRocc.scala 89:27]
  reg [181:0] catch_config_59; // @[OverlayRocc.scala 89:27]
  reg [181:0] catch_config_60; // @[OverlayRocc.scala 89:27]
  reg [181:0] catch_config_61; // @[OverlayRocc.scala 89:27]
  reg [181:0] catch_config_62; // @[OverlayRocc.scala 89:27]
  reg [181:0] catch_config_63; // @[OverlayRocc.scala 89:27]
  wire [5:0] unsigned_cell_config = io_cell_config[190:185]; // @[OverlayRocc.scala 123:46]
  wire  north_din_r_1 = MIDDLENORTH_OV_io_north_din_r; // @[OverlayRocc.scala 26:27 325:36]
  wire  north_din_r_0 = NORTHWEST_OV_io_north_din_r; // @[OverlayRocc.scala 174:67]
  wire  north_din_r_3 = MIDDLENORTH_OV_2_io_north_din_r; // @[OverlayRocc.scala 26:27 325:36]
  wire  north_din_r_2 = MIDDLENORTH_OV_1_io_north_din_r; // @[OverlayRocc.scala 26:27 325:36]
  wire [3:0] io_data_in_ready_lo = {north_din_r_3,north_din_r_2,north_din_r_1,north_din_r_0}; // @[OverlayRocc.scala 141:37]
  wire  north_din_r_5 = MIDDLENORTH_OV_4_io_north_din_r; // @[OverlayRocc.scala 26:27 325:36]
  wire  north_din_r_4 = MIDDLENORTH_OV_3_io_north_din_r; // @[OverlayRocc.scala 26:27 325:36]
  wire  north_din_r_7 = NORTHEAST_OV_io_north_din_r; // @[OverlayRocc.scala 26:27 476:36]
  wire  north_din_r_6 = MIDDLENORTH_OV_5_io_north_din_r; // @[OverlayRocc.scala 26:27 325:36]
  wire [3:0] io_data_in_ready_hi = {north_din_r_7,north_din_r_6,north_din_r_5,north_din_r_4}; // @[OverlayRocc.scala 141:37]
  reg [31:0] reg_data_out_0; // @[OverlayRocc.scala 144:27]
  reg [31:0] reg_data_out_1; // @[OverlayRocc.scala 144:27]
  reg [31:0] reg_data_out_2; // @[OverlayRocc.scala 144:27]
  reg [31:0] reg_data_out_3; // @[OverlayRocc.scala 144:27]
  reg [31:0] reg_data_out_4; // @[OverlayRocc.scala 144:27]
  reg [31:0] reg_data_out_5; // @[OverlayRocc.scala 144:27]
  reg [31:0] reg_data_out_6; // @[OverlayRocc.scala 144:27]
  reg [31:0] reg_data_out_7; // @[OverlayRocc.scala 144:27]
  wire  east_dout_v_1 = MIDDLEEAST_OV_io_east_dout_v; // @[OverlayRocc.scala 29:27 549:36]
  wire  east_dout_v_0 = NORTHEAST_OV_io_east_dout_v; // @[OverlayRocc.scala 29:27 500:36]
  wire  east_dout_v_3 = MIDDLEEAST_OV_2_io_east_dout_v; // @[OverlayRocc.scala 29:27 549:36]
  wire  east_dout_v_2 = MIDDLEEAST_OV_1_io_east_dout_v; // @[OverlayRocc.scala 29:27 549:36]
  wire [3:0] io_data_out_valid_lo = {east_dout_v_3,east_dout_v_2,east_dout_v_1,east_dout_v_0}; // @[OverlayRocc.scala 154:38]
  wire  east_dout_v_5 = MIDDLEEAST_OV_4_io_east_dout_v; // @[OverlayRocc.scala 29:27 549:36]
  wire  east_dout_v_4 = MIDDLEEAST_OV_3_io_east_dout_v; // @[OverlayRocc.scala 29:27 549:36]
  wire  east_dout_v_7 = MIDDLESOUTH_OV_6_io_east_dout_v; // @[OverlayRocc.scala 29:27 598:36]
  wire  east_dout_v_6 = MIDDLEEAST_OV_5_io_east_dout_v; // @[OverlayRocc.scala 29:27 549:36]
  wire [3:0] io_data_out_valid_hi = {east_dout_v_7,east_dout_v_6,east_dout_v_5,east_dout_v_4}; // @[OverlayRocc.scala 154:38]
  wire [127:0] io_data_out_lo = {reg_data_out_3,reg_data_out_2,reg_data_out_1,reg_data_out_0}; // @[OverlayRocc.scala 155:33]
  wire [127:0] io_data_out_hi = {reg_data_out_7,reg_data_out_6,reg_data_out_5,reg_data_out_4}; // @[OverlayRocc.scala 155:33]
  ProcessingElement NORTHWEST_OV ( // @[OverlayRocc.scala 169:46]
    .clock(NORTHWEST_OV_clock),
    .reset(NORTHWEST_OV_reset),
    .io_north_din(NORTHWEST_OV_io_north_din),
    .io_north_din_v(NORTHWEST_OV_io_north_din_v),
    .io_north_din_r(NORTHWEST_OV_io_north_din_r),
    .io_east_din_r(NORTHWEST_OV_io_east_din_r),
    .io_south_din_r(NORTHWEST_OV_io_south_din_r),
    .io_west_din(NORTHWEST_OV_io_west_din),
    .io_west_din_v(NORTHWEST_OV_io_west_din_v),
    .io_north_dout_r(NORTHWEST_OV_io_north_dout_r),
    .io_east_dout(NORTHWEST_OV_io_east_dout),
    .io_east_dout_v(NORTHWEST_OV_io_east_dout_v),
    .io_east_dout_r(NORTHWEST_OV_io_east_dout_r),
    .io_south_dout(NORTHWEST_OV_io_south_dout),
    .io_south_dout_v(NORTHWEST_OV_io_south_dout_v),
    .io_west_dout_r(NORTHWEST_OV_io_west_dout_r),
    .io_config_bits(NORTHWEST_OV_io_config_bits),
    .io_catch_config(NORTHWEST_OV_io_catch_config)
  );
  ProcessingElement MIDWEST_OV ( // @[OverlayRocc.scala 218:44]
    .clock(MIDWEST_OV_clock),
    .reset(MIDWEST_OV_reset),
    .io_north_din(MIDWEST_OV_io_north_din),
    .io_north_din_v(MIDWEST_OV_io_north_din_v),
    .io_north_din_r(MIDWEST_OV_io_north_din_r),
    .io_east_din_r(MIDWEST_OV_io_east_din_r),
    .io_south_din_r(MIDWEST_OV_io_south_din_r),
    .io_west_din(MIDWEST_OV_io_west_din),
    .io_west_din_v(MIDWEST_OV_io_west_din_v),
    .io_north_dout_r(MIDWEST_OV_io_north_dout_r),
    .io_east_dout(MIDWEST_OV_io_east_dout),
    .io_east_dout_v(MIDWEST_OV_io_east_dout_v),
    .io_east_dout_r(MIDWEST_OV_io_east_dout_r),
    .io_south_dout(MIDWEST_OV_io_south_dout),
    .io_south_dout_v(MIDWEST_OV_io_south_dout_v),
    .io_west_dout_r(MIDWEST_OV_io_west_dout_r),
    .io_config_bits(MIDWEST_OV_io_config_bits),
    .io_catch_config(MIDWEST_OV_io_catch_config)
  );
  ProcessingElement MIDWEST_OV_1 ( // @[OverlayRocc.scala 218:44]
    .clock(MIDWEST_OV_1_clock),
    .reset(MIDWEST_OV_1_reset),
    .io_north_din(MIDWEST_OV_1_io_north_din),
    .io_north_din_v(MIDWEST_OV_1_io_north_din_v),
    .io_north_din_r(MIDWEST_OV_1_io_north_din_r),
    .io_east_din_r(MIDWEST_OV_1_io_east_din_r),
    .io_south_din_r(MIDWEST_OV_1_io_south_din_r),
    .io_west_din(MIDWEST_OV_1_io_west_din),
    .io_west_din_v(MIDWEST_OV_1_io_west_din_v),
    .io_north_dout_r(MIDWEST_OV_1_io_north_dout_r),
    .io_east_dout(MIDWEST_OV_1_io_east_dout),
    .io_east_dout_v(MIDWEST_OV_1_io_east_dout_v),
    .io_east_dout_r(MIDWEST_OV_1_io_east_dout_r),
    .io_south_dout(MIDWEST_OV_1_io_south_dout),
    .io_south_dout_v(MIDWEST_OV_1_io_south_dout_v),
    .io_west_dout_r(MIDWEST_OV_1_io_west_dout_r),
    .io_config_bits(MIDWEST_OV_1_io_config_bits),
    .io_catch_config(MIDWEST_OV_1_io_catch_config)
  );
  ProcessingElement MIDWEST_OV_2 ( // @[OverlayRocc.scala 218:44]
    .clock(MIDWEST_OV_2_clock),
    .reset(MIDWEST_OV_2_reset),
    .io_north_din(MIDWEST_OV_2_io_north_din),
    .io_north_din_v(MIDWEST_OV_2_io_north_din_v),
    .io_north_din_r(MIDWEST_OV_2_io_north_din_r),
    .io_east_din_r(MIDWEST_OV_2_io_east_din_r),
    .io_south_din_r(MIDWEST_OV_2_io_south_din_r),
    .io_west_din(MIDWEST_OV_2_io_west_din),
    .io_west_din_v(MIDWEST_OV_2_io_west_din_v),
    .io_north_dout_r(MIDWEST_OV_2_io_north_dout_r),
    .io_east_dout(MIDWEST_OV_2_io_east_dout),
    .io_east_dout_v(MIDWEST_OV_2_io_east_dout_v),
    .io_east_dout_r(MIDWEST_OV_2_io_east_dout_r),
    .io_south_dout(MIDWEST_OV_2_io_south_dout),
    .io_south_dout_v(MIDWEST_OV_2_io_south_dout_v),
    .io_west_dout_r(MIDWEST_OV_2_io_west_dout_r),
    .io_config_bits(MIDWEST_OV_2_io_config_bits),
    .io_catch_config(MIDWEST_OV_2_io_catch_config)
  );
  ProcessingElement MIDWEST_OV_3 ( // @[OverlayRocc.scala 218:44]
    .clock(MIDWEST_OV_3_clock),
    .reset(MIDWEST_OV_3_reset),
    .io_north_din(MIDWEST_OV_3_io_north_din),
    .io_north_din_v(MIDWEST_OV_3_io_north_din_v),
    .io_north_din_r(MIDWEST_OV_3_io_north_din_r),
    .io_east_din_r(MIDWEST_OV_3_io_east_din_r),
    .io_south_din_r(MIDWEST_OV_3_io_south_din_r),
    .io_west_din(MIDWEST_OV_3_io_west_din),
    .io_west_din_v(MIDWEST_OV_3_io_west_din_v),
    .io_north_dout_r(MIDWEST_OV_3_io_north_dout_r),
    .io_east_dout(MIDWEST_OV_3_io_east_dout),
    .io_east_dout_v(MIDWEST_OV_3_io_east_dout_v),
    .io_east_dout_r(MIDWEST_OV_3_io_east_dout_r),
    .io_south_dout(MIDWEST_OV_3_io_south_dout),
    .io_south_dout_v(MIDWEST_OV_3_io_south_dout_v),
    .io_west_dout_r(MIDWEST_OV_3_io_west_dout_r),
    .io_config_bits(MIDWEST_OV_3_io_config_bits),
    .io_catch_config(MIDWEST_OV_3_io_catch_config)
  );
  ProcessingElement MIDWEST_OV_4 ( // @[OverlayRocc.scala 218:44]
    .clock(MIDWEST_OV_4_clock),
    .reset(MIDWEST_OV_4_reset),
    .io_north_din(MIDWEST_OV_4_io_north_din),
    .io_north_din_v(MIDWEST_OV_4_io_north_din_v),
    .io_north_din_r(MIDWEST_OV_4_io_north_din_r),
    .io_east_din_r(MIDWEST_OV_4_io_east_din_r),
    .io_south_din_r(MIDWEST_OV_4_io_south_din_r),
    .io_west_din(MIDWEST_OV_4_io_west_din),
    .io_west_din_v(MIDWEST_OV_4_io_west_din_v),
    .io_north_dout_r(MIDWEST_OV_4_io_north_dout_r),
    .io_east_dout(MIDWEST_OV_4_io_east_dout),
    .io_east_dout_v(MIDWEST_OV_4_io_east_dout_v),
    .io_east_dout_r(MIDWEST_OV_4_io_east_dout_r),
    .io_south_dout(MIDWEST_OV_4_io_south_dout),
    .io_south_dout_v(MIDWEST_OV_4_io_south_dout_v),
    .io_west_dout_r(MIDWEST_OV_4_io_west_dout_r),
    .io_config_bits(MIDWEST_OV_4_io_config_bits),
    .io_catch_config(MIDWEST_OV_4_io_catch_config)
  );
  ProcessingElement MIDWEST_OV_5 ( // @[OverlayRocc.scala 218:44]
    .clock(MIDWEST_OV_5_clock),
    .reset(MIDWEST_OV_5_reset),
    .io_north_din(MIDWEST_OV_5_io_north_din),
    .io_north_din_v(MIDWEST_OV_5_io_north_din_v),
    .io_north_din_r(MIDWEST_OV_5_io_north_din_r),
    .io_east_din_r(MIDWEST_OV_5_io_east_din_r),
    .io_south_din_r(MIDWEST_OV_5_io_south_din_r),
    .io_west_din(MIDWEST_OV_5_io_west_din),
    .io_west_din_v(MIDWEST_OV_5_io_west_din_v),
    .io_north_dout_r(MIDWEST_OV_5_io_north_dout_r),
    .io_east_dout(MIDWEST_OV_5_io_east_dout),
    .io_east_dout_v(MIDWEST_OV_5_io_east_dout_v),
    .io_east_dout_r(MIDWEST_OV_5_io_east_dout_r),
    .io_south_dout(MIDWEST_OV_5_io_south_dout),
    .io_south_dout_v(MIDWEST_OV_5_io_south_dout_v),
    .io_west_dout_r(MIDWEST_OV_5_io_west_dout_r),
    .io_config_bits(MIDWEST_OV_5_io_config_bits),
    .io_catch_config(MIDWEST_OV_5_io_catch_config)
  );
  ProcessingElement SOUTHWEST_OV ( // @[OverlayRocc.scala 267:46]
    .clock(SOUTHWEST_OV_clock),
    .reset(SOUTHWEST_OV_reset),
    .io_north_din(SOUTHWEST_OV_io_north_din),
    .io_north_din_v(SOUTHWEST_OV_io_north_din_v),
    .io_north_din_r(SOUTHWEST_OV_io_north_din_r),
    .io_east_din_r(SOUTHWEST_OV_io_east_din_r),
    .io_south_din_r(SOUTHWEST_OV_io_south_din_r),
    .io_west_din(SOUTHWEST_OV_io_west_din),
    .io_west_din_v(SOUTHWEST_OV_io_west_din_v),
    .io_north_dout_r(SOUTHWEST_OV_io_north_dout_r),
    .io_east_dout(SOUTHWEST_OV_io_east_dout),
    .io_east_dout_v(SOUTHWEST_OV_io_east_dout_v),
    .io_east_dout_r(SOUTHWEST_OV_io_east_dout_r),
    .io_south_dout(SOUTHWEST_OV_io_south_dout),
    .io_south_dout_v(SOUTHWEST_OV_io_south_dout_v),
    .io_west_dout_r(SOUTHWEST_OV_io_west_dout_r),
    .io_config_bits(SOUTHWEST_OV_io_config_bits),
    .io_catch_config(SOUTHWEST_OV_io_catch_config)
  );
  ProcessingElement MIDDLENORTH_OV ( // @[OverlayRocc.scala 320:48]
    .clock(MIDDLENORTH_OV_clock),
    .reset(MIDDLENORTH_OV_reset),
    .io_north_din(MIDDLENORTH_OV_io_north_din),
    .io_north_din_v(MIDDLENORTH_OV_io_north_din_v),
    .io_north_din_r(MIDDLENORTH_OV_io_north_din_r),
    .io_east_din_r(MIDDLENORTH_OV_io_east_din_r),
    .io_south_din_r(MIDDLENORTH_OV_io_south_din_r),
    .io_west_din(MIDDLENORTH_OV_io_west_din),
    .io_west_din_v(MIDDLENORTH_OV_io_west_din_v),
    .io_north_dout_r(MIDDLENORTH_OV_io_north_dout_r),
    .io_east_dout(MIDDLENORTH_OV_io_east_dout),
    .io_east_dout_v(MIDDLENORTH_OV_io_east_dout_v),
    .io_east_dout_r(MIDDLENORTH_OV_io_east_dout_r),
    .io_south_dout(MIDDLENORTH_OV_io_south_dout),
    .io_south_dout_v(MIDDLENORTH_OV_io_south_dout_v),
    .io_west_dout_r(MIDDLENORTH_OV_io_west_dout_r),
    .io_config_bits(MIDDLENORTH_OV_io_config_bits),
    .io_catch_config(MIDDLENORTH_OV_io_catch_config)
  );
  ProcessingElement MIDDLEMIDDLE_OV ( // @[OverlayRocc.scala 369:49]
    .clock(MIDDLEMIDDLE_OV_clock),
    .reset(MIDDLEMIDDLE_OV_reset),
    .io_north_din(MIDDLEMIDDLE_OV_io_north_din),
    .io_north_din_v(MIDDLEMIDDLE_OV_io_north_din_v),
    .io_north_din_r(MIDDLEMIDDLE_OV_io_north_din_r),
    .io_east_din_r(MIDDLEMIDDLE_OV_io_east_din_r),
    .io_south_din_r(MIDDLEMIDDLE_OV_io_south_din_r),
    .io_west_din(MIDDLEMIDDLE_OV_io_west_din),
    .io_west_din_v(MIDDLEMIDDLE_OV_io_west_din_v),
    .io_north_dout_r(MIDDLEMIDDLE_OV_io_north_dout_r),
    .io_east_dout(MIDDLEMIDDLE_OV_io_east_dout),
    .io_east_dout_v(MIDDLEMIDDLE_OV_io_east_dout_v),
    .io_east_dout_r(MIDDLEMIDDLE_OV_io_east_dout_r),
    .io_south_dout(MIDDLEMIDDLE_OV_io_south_dout),
    .io_south_dout_v(MIDDLEMIDDLE_OV_io_south_dout_v),
    .io_west_dout_r(MIDDLEMIDDLE_OV_io_west_dout_r),
    .io_config_bits(MIDDLEMIDDLE_OV_io_config_bits),
    .io_catch_config(MIDDLEMIDDLE_OV_io_catch_config)
  );
  ProcessingElement MIDDLEMIDDLE_OV_1 ( // @[OverlayRocc.scala 369:49]
    .clock(MIDDLEMIDDLE_OV_1_clock),
    .reset(MIDDLEMIDDLE_OV_1_reset),
    .io_north_din(MIDDLEMIDDLE_OV_1_io_north_din),
    .io_north_din_v(MIDDLEMIDDLE_OV_1_io_north_din_v),
    .io_north_din_r(MIDDLEMIDDLE_OV_1_io_north_din_r),
    .io_east_din_r(MIDDLEMIDDLE_OV_1_io_east_din_r),
    .io_south_din_r(MIDDLEMIDDLE_OV_1_io_south_din_r),
    .io_west_din(MIDDLEMIDDLE_OV_1_io_west_din),
    .io_west_din_v(MIDDLEMIDDLE_OV_1_io_west_din_v),
    .io_north_dout_r(MIDDLEMIDDLE_OV_1_io_north_dout_r),
    .io_east_dout(MIDDLEMIDDLE_OV_1_io_east_dout),
    .io_east_dout_v(MIDDLEMIDDLE_OV_1_io_east_dout_v),
    .io_east_dout_r(MIDDLEMIDDLE_OV_1_io_east_dout_r),
    .io_south_dout(MIDDLEMIDDLE_OV_1_io_south_dout),
    .io_south_dout_v(MIDDLEMIDDLE_OV_1_io_south_dout_v),
    .io_west_dout_r(MIDDLEMIDDLE_OV_1_io_west_dout_r),
    .io_config_bits(MIDDLEMIDDLE_OV_1_io_config_bits),
    .io_catch_config(MIDDLEMIDDLE_OV_1_io_catch_config)
  );
  ProcessingElement MIDDLEMIDDLE_OV_2 ( // @[OverlayRocc.scala 369:49]
    .clock(MIDDLEMIDDLE_OV_2_clock),
    .reset(MIDDLEMIDDLE_OV_2_reset),
    .io_north_din(MIDDLEMIDDLE_OV_2_io_north_din),
    .io_north_din_v(MIDDLEMIDDLE_OV_2_io_north_din_v),
    .io_north_din_r(MIDDLEMIDDLE_OV_2_io_north_din_r),
    .io_east_din_r(MIDDLEMIDDLE_OV_2_io_east_din_r),
    .io_south_din_r(MIDDLEMIDDLE_OV_2_io_south_din_r),
    .io_west_din(MIDDLEMIDDLE_OV_2_io_west_din),
    .io_west_din_v(MIDDLEMIDDLE_OV_2_io_west_din_v),
    .io_north_dout_r(MIDDLEMIDDLE_OV_2_io_north_dout_r),
    .io_east_dout(MIDDLEMIDDLE_OV_2_io_east_dout),
    .io_east_dout_v(MIDDLEMIDDLE_OV_2_io_east_dout_v),
    .io_east_dout_r(MIDDLEMIDDLE_OV_2_io_east_dout_r),
    .io_south_dout(MIDDLEMIDDLE_OV_2_io_south_dout),
    .io_south_dout_v(MIDDLEMIDDLE_OV_2_io_south_dout_v),
    .io_west_dout_r(MIDDLEMIDDLE_OV_2_io_west_dout_r),
    .io_config_bits(MIDDLEMIDDLE_OV_2_io_config_bits),
    .io_catch_config(MIDDLEMIDDLE_OV_2_io_catch_config)
  );
  ProcessingElement MIDDLEMIDDLE_OV_3 ( // @[OverlayRocc.scala 369:49]
    .clock(MIDDLEMIDDLE_OV_3_clock),
    .reset(MIDDLEMIDDLE_OV_3_reset),
    .io_north_din(MIDDLEMIDDLE_OV_3_io_north_din),
    .io_north_din_v(MIDDLEMIDDLE_OV_3_io_north_din_v),
    .io_north_din_r(MIDDLEMIDDLE_OV_3_io_north_din_r),
    .io_east_din_r(MIDDLEMIDDLE_OV_3_io_east_din_r),
    .io_south_din_r(MIDDLEMIDDLE_OV_3_io_south_din_r),
    .io_west_din(MIDDLEMIDDLE_OV_3_io_west_din),
    .io_west_din_v(MIDDLEMIDDLE_OV_3_io_west_din_v),
    .io_north_dout_r(MIDDLEMIDDLE_OV_3_io_north_dout_r),
    .io_east_dout(MIDDLEMIDDLE_OV_3_io_east_dout),
    .io_east_dout_v(MIDDLEMIDDLE_OV_3_io_east_dout_v),
    .io_east_dout_r(MIDDLEMIDDLE_OV_3_io_east_dout_r),
    .io_south_dout(MIDDLEMIDDLE_OV_3_io_south_dout),
    .io_south_dout_v(MIDDLEMIDDLE_OV_3_io_south_dout_v),
    .io_west_dout_r(MIDDLEMIDDLE_OV_3_io_west_dout_r),
    .io_config_bits(MIDDLEMIDDLE_OV_3_io_config_bits),
    .io_catch_config(MIDDLEMIDDLE_OV_3_io_catch_config)
  );
  ProcessingElement MIDDLEMIDDLE_OV_4 ( // @[OverlayRocc.scala 369:49]
    .clock(MIDDLEMIDDLE_OV_4_clock),
    .reset(MIDDLEMIDDLE_OV_4_reset),
    .io_north_din(MIDDLEMIDDLE_OV_4_io_north_din),
    .io_north_din_v(MIDDLEMIDDLE_OV_4_io_north_din_v),
    .io_north_din_r(MIDDLEMIDDLE_OV_4_io_north_din_r),
    .io_east_din_r(MIDDLEMIDDLE_OV_4_io_east_din_r),
    .io_south_din_r(MIDDLEMIDDLE_OV_4_io_south_din_r),
    .io_west_din(MIDDLEMIDDLE_OV_4_io_west_din),
    .io_west_din_v(MIDDLEMIDDLE_OV_4_io_west_din_v),
    .io_north_dout_r(MIDDLEMIDDLE_OV_4_io_north_dout_r),
    .io_east_dout(MIDDLEMIDDLE_OV_4_io_east_dout),
    .io_east_dout_v(MIDDLEMIDDLE_OV_4_io_east_dout_v),
    .io_east_dout_r(MIDDLEMIDDLE_OV_4_io_east_dout_r),
    .io_south_dout(MIDDLEMIDDLE_OV_4_io_south_dout),
    .io_south_dout_v(MIDDLEMIDDLE_OV_4_io_south_dout_v),
    .io_west_dout_r(MIDDLEMIDDLE_OV_4_io_west_dout_r),
    .io_config_bits(MIDDLEMIDDLE_OV_4_io_config_bits),
    .io_catch_config(MIDDLEMIDDLE_OV_4_io_catch_config)
  );
  ProcessingElement MIDDLEMIDDLE_OV_5 ( // @[OverlayRocc.scala 369:49]
    .clock(MIDDLEMIDDLE_OV_5_clock),
    .reset(MIDDLEMIDDLE_OV_5_reset),
    .io_north_din(MIDDLEMIDDLE_OV_5_io_north_din),
    .io_north_din_v(MIDDLEMIDDLE_OV_5_io_north_din_v),
    .io_north_din_r(MIDDLEMIDDLE_OV_5_io_north_din_r),
    .io_east_din_r(MIDDLEMIDDLE_OV_5_io_east_din_r),
    .io_south_din_r(MIDDLEMIDDLE_OV_5_io_south_din_r),
    .io_west_din(MIDDLEMIDDLE_OV_5_io_west_din),
    .io_west_din_v(MIDDLEMIDDLE_OV_5_io_west_din_v),
    .io_north_dout_r(MIDDLEMIDDLE_OV_5_io_north_dout_r),
    .io_east_dout(MIDDLEMIDDLE_OV_5_io_east_dout),
    .io_east_dout_v(MIDDLEMIDDLE_OV_5_io_east_dout_v),
    .io_east_dout_r(MIDDLEMIDDLE_OV_5_io_east_dout_r),
    .io_south_dout(MIDDLEMIDDLE_OV_5_io_south_dout),
    .io_south_dout_v(MIDDLEMIDDLE_OV_5_io_south_dout_v),
    .io_west_dout_r(MIDDLEMIDDLE_OV_5_io_west_dout_r),
    .io_config_bits(MIDDLEMIDDLE_OV_5_io_config_bits),
    .io_catch_config(MIDDLEMIDDLE_OV_5_io_catch_config)
  );
  ProcessingElement MIDDLESOUTH_OV ( // @[OverlayRocc.scala 418:48]
    .clock(MIDDLESOUTH_OV_clock),
    .reset(MIDDLESOUTH_OV_reset),
    .io_north_din(MIDDLESOUTH_OV_io_north_din),
    .io_north_din_v(MIDDLESOUTH_OV_io_north_din_v),
    .io_north_din_r(MIDDLESOUTH_OV_io_north_din_r),
    .io_east_din_r(MIDDLESOUTH_OV_io_east_din_r),
    .io_south_din_r(MIDDLESOUTH_OV_io_south_din_r),
    .io_west_din(MIDDLESOUTH_OV_io_west_din),
    .io_west_din_v(MIDDLESOUTH_OV_io_west_din_v),
    .io_north_dout_r(MIDDLESOUTH_OV_io_north_dout_r),
    .io_east_dout(MIDDLESOUTH_OV_io_east_dout),
    .io_east_dout_v(MIDDLESOUTH_OV_io_east_dout_v),
    .io_east_dout_r(MIDDLESOUTH_OV_io_east_dout_r),
    .io_south_dout(MIDDLESOUTH_OV_io_south_dout),
    .io_south_dout_v(MIDDLESOUTH_OV_io_south_dout_v),
    .io_west_dout_r(MIDDLESOUTH_OV_io_west_dout_r),
    .io_config_bits(MIDDLESOUTH_OV_io_config_bits),
    .io_catch_config(MIDDLESOUTH_OV_io_catch_config)
  );
  ProcessingElement MIDDLENORTH_OV_1 ( // @[OverlayRocc.scala 320:48]
    .clock(MIDDLENORTH_OV_1_clock),
    .reset(MIDDLENORTH_OV_1_reset),
    .io_north_din(MIDDLENORTH_OV_1_io_north_din),
    .io_north_din_v(MIDDLENORTH_OV_1_io_north_din_v),
    .io_north_din_r(MIDDLENORTH_OV_1_io_north_din_r),
    .io_east_din_r(MIDDLENORTH_OV_1_io_east_din_r),
    .io_south_din_r(MIDDLENORTH_OV_1_io_south_din_r),
    .io_west_din(MIDDLENORTH_OV_1_io_west_din),
    .io_west_din_v(MIDDLENORTH_OV_1_io_west_din_v),
    .io_north_dout_r(MIDDLENORTH_OV_1_io_north_dout_r),
    .io_east_dout(MIDDLENORTH_OV_1_io_east_dout),
    .io_east_dout_v(MIDDLENORTH_OV_1_io_east_dout_v),
    .io_east_dout_r(MIDDLENORTH_OV_1_io_east_dout_r),
    .io_south_dout(MIDDLENORTH_OV_1_io_south_dout),
    .io_south_dout_v(MIDDLENORTH_OV_1_io_south_dout_v),
    .io_west_dout_r(MIDDLENORTH_OV_1_io_west_dout_r),
    .io_config_bits(MIDDLENORTH_OV_1_io_config_bits),
    .io_catch_config(MIDDLENORTH_OV_1_io_catch_config)
  );
  ProcessingElement MIDDLEMIDDLE_OV_6 ( // @[OverlayRocc.scala 369:49]
    .clock(MIDDLEMIDDLE_OV_6_clock),
    .reset(MIDDLEMIDDLE_OV_6_reset),
    .io_north_din(MIDDLEMIDDLE_OV_6_io_north_din),
    .io_north_din_v(MIDDLEMIDDLE_OV_6_io_north_din_v),
    .io_north_din_r(MIDDLEMIDDLE_OV_6_io_north_din_r),
    .io_east_din_r(MIDDLEMIDDLE_OV_6_io_east_din_r),
    .io_south_din_r(MIDDLEMIDDLE_OV_6_io_south_din_r),
    .io_west_din(MIDDLEMIDDLE_OV_6_io_west_din),
    .io_west_din_v(MIDDLEMIDDLE_OV_6_io_west_din_v),
    .io_north_dout_r(MIDDLEMIDDLE_OV_6_io_north_dout_r),
    .io_east_dout(MIDDLEMIDDLE_OV_6_io_east_dout),
    .io_east_dout_v(MIDDLEMIDDLE_OV_6_io_east_dout_v),
    .io_east_dout_r(MIDDLEMIDDLE_OV_6_io_east_dout_r),
    .io_south_dout(MIDDLEMIDDLE_OV_6_io_south_dout),
    .io_south_dout_v(MIDDLEMIDDLE_OV_6_io_south_dout_v),
    .io_west_dout_r(MIDDLEMIDDLE_OV_6_io_west_dout_r),
    .io_config_bits(MIDDLEMIDDLE_OV_6_io_config_bits),
    .io_catch_config(MIDDLEMIDDLE_OV_6_io_catch_config)
  );
  ProcessingElement MIDDLEMIDDLE_OV_7 ( // @[OverlayRocc.scala 369:49]
    .clock(MIDDLEMIDDLE_OV_7_clock),
    .reset(MIDDLEMIDDLE_OV_7_reset),
    .io_north_din(MIDDLEMIDDLE_OV_7_io_north_din),
    .io_north_din_v(MIDDLEMIDDLE_OV_7_io_north_din_v),
    .io_north_din_r(MIDDLEMIDDLE_OV_7_io_north_din_r),
    .io_east_din_r(MIDDLEMIDDLE_OV_7_io_east_din_r),
    .io_south_din_r(MIDDLEMIDDLE_OV_7_io_south_din_r),
    .io_west_din(MIDDLEMIDDLE_OV_7_io_west_din),
    .io_west_din_v(MIDDLEMIDDLE_OV_7_io_west_din_v),
    .io_north_dout_r(MIDDLEMIDDLE_OV_7_io_north_dout_r),
    .io_east_dout(MIDDLEMIDDLE_OV_7_io_east_dout),
    .io_east_dout_v(MIDDLEMIDDLE_OV_7_io_east_dout_v),
    .io_east_dout_r(MIDDLEMIDDLE_OV_7_io_east_dout_r),
    .io_south_dout(MIDDLEMIDDLE_OV_7_io_south_dout),
    .io_south_dout_v(MIDDLEMIDDLE_OV_7_io_south_dout_v),
    .io_west_dout_r(MIDDLEMIDDLE_OV_7_io_west_dout_r),
    .io_config_bits(MIDDLEMIDDLE_OV_7_io_config_bits),
    .io_catch_config(MIDDLEMIDDLE_OV_7_io_catch_config)
  );
  ProcessingElement MIDDLEMIDDLE_OV_8 ( // @[OverlayRocc.scala 369:49]
    .clock(MIDDLEMIDDLE_OV_8_clock),
    .reset(MIDDLEMIDDLE_OV_8_reset),
    .io_north_din(MIDDLEMIDDLE_OV_8_io_north_din),
    .io_north_din_v(MIDDLEMIDDLE_OV_8_io_north_din_v),
    .io_north_din_r(MIDDLEMIDDLE_OV_8_io_north_din_r),
    .io_east_din_r(MIDDLEMIDDLE_OV_8_io_east_din_r),
    .io_south_din_r(MIDDLEMIDDLE_OV_8_io_south_din_r),
    .io_west_din(MIDDLEMIDDLE_OV_8_io_west_din),
    .io_west_din_v(MIDDLEMIDDLE_OV_8_io_west_din_v),
    .io_north_dout_r(MIDDLEMIDDLE_OV_8_io_north_dout_r),
    .io_east_dout(MIDDLEMIDDLE_OV_8_io_east_dout),
    .io_east_dout_v(MIDDLEMIDDLE_OV_8_io_east_dout_v),
    .io_east_dout_r(MIDDLEMIDDLE_OV_8_io_east_dout_r),
    .io_south_dout(MIDDLEMIDDLE_OV_8_io_south_dout),
    .io_south_dout_v(MIDDLEMIDDLE_OV_8_io_south_dout_v),
    .io_west_dout_r(MIDDLEMIDDLE_OV_8_io_west_dout_r),
    .io_config_bits(MIDDLEMIDDLE_OV_8_io_config_bits),
    .io_catch_config(MIDDLEMIDDLE_OV_8_io_catch_config)
  );
  ProcessingElement MIDDLEMIDDLE_OV_9 ( // @[OverlayRocc.scala 369:49]
    .clock(MIDDLEMIDDLE_OV_9_clock),
    .reset(MIDDLEMIDDLE_OV_9_reset),
    .io_north_din(MIDDLEMIDDLE_OV_9_io_north_din),
    .io_north_din_v(MIDDLEMIDDLE_OV_9_io_north_din_v),
    .io_north_din_r(MIDDLEMIDDLE_OV_9_io_north_din_r),
    .io_east_din_r(MIDDLEMIDDLE_OV_9_io_east_din_r),
    .io_south_din_r(MIDDLEMIDDLE_OV_9_io_south_din_r),
    .io_west_din(MIDDLEMIDDLE_OV_9_io_west_din),
    .io_west_din_v(MIDDLEMIDDLE_OV_9_io_west_din_v),
    .io_north_dout_r(MIDDLEMIDDLE_OV_9_io_north_dout_r),
    .io_east_dout(MIDDLEMIDDLE_OV_9_io_east_dout),
    .io_east_dout_v(MIDDLEMIDDLE_OV_9_io_east_dout_v),
    .io_east_dout_r(MIDDLEMIDDLE_OV_9_io_east_dout_r),
    .io_south_dout(MIDDLEMIDDLE_OV_9_io_south_dout),
    .io_south_dout_v(MIDDLEMIDDLE_OV_9_io_south_dout_v),
    .io_west_dout_r(MIDDLEMIDDLE_OV_9_io_west_dout_r),
    .io_config_bits(MIDDLEMIDDLE_OV_9_io_config_bits),
    .io_catch_config(MIDDLEMIDDLE_OV_9_io_catch_config)
  );
  ProcessingElement MIDDLEMIDDLE_OV_10 ( // @[OverlayRocc.scala 369:49]
    .clock(MIDDLEMIDDLE_OV_10_clock),
    .reset(MIDDLEMIDDLE_OV_10_reset),
    .io_north_din(MIDDLEMIDDLE_OV_10_io_north_din),
    .io_north_din_v(MIDDLEMIDDLE_OV_10_io_north_din_v),
    .io_north_din_r(MIDDLEMIDDLE_OV_10_io_north_din_r),
    .io_east_din_r(MIDDLEMIDDLE_OV_10_io_east_din_r),
    .io_south_din_r(MIDDLEMIDDLE_OV_10_io_south_din_r),
    .io_west_din(MIDDLEMIDDLE_OV_10_io_west_din),
    .io_west_din_v(MIDDLEMIDDLE_OV_10_io_west_din_v),
    .io_north_dout_r(MIDDLEMIDDLE_OV_10_io_north_dout_r),
    .io_east_dout(MIDDLEMIDDLE_OV_10_io_east_dout),
    .io_east_dout_v(MIDDLEMIDDLE_OV_10_io_east_dout_v),
    .io_east_dout_r(MIDDLEMIDDLE_OV_10_io_east_dout_r),
    .io_south_dout(MIDDLEMIDDLE_OV_10_io_south_dout),
    .io_south_dout_v(MIDDLEMIDDLE_OV_10_io_south_dout_v),
    .io_west_dout_r(MIDDLEMIDDLE_OV_10_io_west_dout_r),
    .io_config_bits(MIDDLEMIDDLE_OV_10_io_config_bits),
    .io_catch_config(MIDDLEMIDDLE_OV_10_io_catch_config)
  );
  ProcessingElement MIDDLEMIDDLE_OV_11 ( // @[OverlayRocc.scala 369:49]
    .clock(MIDDLEMIDDLE_OV_11_clock),
    .reset(MIDDLEMIDDLE_OV_11_reset),
    .io_north_din(MIDDLEMIDDLE_OV_11_io_north_din),
    .io_north_din_v(MIDDLEMIDDLE_OV_11_io_north_din_v),
    .io_north_din_r(MIDDLEMIDDLE_OV_11_io_north_din_r),
    .io_east_din_r(MIDDLEMIDDLE_OV_11_io_east_din_r),
    .io_south_din_r(MIDDLEMIDDLE_OV_11_io_south_din_r),
    .io_west_din(MIDDLEMIDDLE_OV_11_io_west_din),
    .io_west_din_v(MIDDLEMIDDLE_OV_11_io_west_din_v),
    .io_north_dout_r(MIDDLEMIDDLE_OV_11_io_north_dout_r),
    .io_east_dout(MIDDLEMIDDLE_OV_11_io_east_dout),
    .io_east_dout_v(MIDDLEMIDDLE_OV_11_io_east_dout_v),
    .io_east_dout_r(MIDDLEMIDDLE_OV_11_io_east_dout_r),
    .io_south_dout(MIDDLEMIDDLE_OV_11_io_south_dout),
    .io_south_dout_v(MIDDLEMIDDLE_OV_11_io_south_dout_v),
    .io_west_dout_r(MIDDLEMIDDLE_OV_11_io_west_dout_r),
    .io_config_bits(MIDDLEMIDDLE_OV_11_io_config_bits),
    .io_catch_config(MIDDLEMIDDLE_OV_11_io_catch_config)
  );
  ProcessingElement MIDDLESOUTH_OV_1 ( // @[OverlayRocc.scala 418:48]
    .clock(MIDDLESOUTH_OV_1_clock),
    .reset(MIDDLESOUTH_OV_1_reset),
    .io_north_din(MIDDLESOUTH_OV_1_io_north_din),
    .io_north_din_v(MIDDLESOUTH_OV_1_io_north_din_v),
    .io_north_din_r(MIDDLESOUTH_OV_1_io_north_din_r),
    .io_east_din_r(MIDDLESOUTH_OV_1_io_east_din_r),
    .io_south_din_r(MIDDLESOUTH_OV_1_io_south_din_r),
    .io_west_din(MIDDLESOUTH_OV_1_io_west_din),
    .io_west_din_v(MIDDLESOUTH_OV_1_io_west_din_v),
    .io_north_dout_r(MIDDLESOUTH_OV_1_io_north_dout_r),
    .io_east_dout(MIDDLESOUTH_OV_1_io_east_dout),
    .io_east_dout_v(MIDDLESOUTH_OV_1_io_east_dout_v),
    .io_east_dout_r(MIDDLESOUTH_OV_1_io_east_dout_r),
    .io_south_dout(MIDDLESOUTH_OV_1_io_south_dout),
    .io_south_dout_v(MIDDLESOUTH_OV_1_io_south_dout_v),
    .io_west_dout_r(MIDDLESOUTH_OV_1_io_west_dout_r),
    .io_config_bits(MIDDLESOUTH_OV_1_io_config_bits),
    .io_catch_config(MIDDLESOUTH_OV_1_io_catch_config)
  );
  ProcessingElement MIDDLENORTH_OV_2 ( // @[OverlayRocc.scala 320:48]
    .clock(MIDDLENORTH_OV_2_clock),
    .reset(MIDDLENORTH_OV_2_reset),
    .io_north_din(MIDDLENORTH_OV_2_io_north_din),
    .io_north_din_v(MIDDLENORTH_OV_2_io_north_din_v),
    .io_north_din_r(MIDDLENORTH_OV_2_io_north_din_r),
    .io_east_din_r(MIDDLENORTH_OV_2_io_east_din_r),
    .io_south_din_r(MIDDLENORTH_OV_2_io_south_din_r),
    .io_west_din(MIDDLENORTH_OV_2_io_west_din),
    .io_west_din_v(MIDDLENORTH_OV_2_io_west_din_v),
    .io_north_dout_r(MIDDLENORTH_OV_2_io_north_dout_r),
    .io_east_dout(MIDDLENORTH_OV_2_io_east_dout),
    .io_east_dout_v(MIDDLENORTH_OV_2_io_east_dout_v),
    .io_east_dout_r(MIDDLENORTH_OV_2_io_east_dout_r),
    .io_south_dout(MIDDLENORTH_OV_2_io_south_dout),
    .io_south_dout_v(MIDDLENORTH_OV_2_io_south_dout_v),
    .io_west_dout_r(MIDDLENORTH_OV_2_io_west_dout_r),
    .io_config_bits(MIDDLENORTH_OV_2_io_config_bits),
    .io_catch_config(MIDDLENORTH_OV_2_io_catch_config)
  );
  ProcessingElement MIDDLEMIDDLE_OV_12 ( // @[OverlayRocc.scala 369:49]
    .clock(MIDDLEMIDDLE_OV_12_clock),
    .reset(MIDDLEMIDDLE_OV_12_reset),
    .io_north_din(MIDDLEMIDDLE_OV_12_io_north_din),
    .io_north_din_v(MIDDLEMIDDLE_OV_12_io_north_din_v),
    .io_north_din_r(MIDDLEMIDDLE_OV_12_io_north_din_r),
    .io_east_din_r(MIDDLEMIDDLE_OV_12_io_east_din_r),
    .io_south_din_r(MIDDLEMIDDLE_OV_12_io_south_din_r),
    .io_west_din(MIDDLEMIDDLE_OV_12_io_west_din),
    .io_west_din_v(MIDDLEMIDDLE_OV_12_io_west_din_v),
    .io_north_dout_r(MIDDLEMIDDLE_OV_12_io_north_dout_r),
    .io_east_dout(MIDDLEMIDDLE_OV_12_io_east_dout),
    .io_east_dout_v(MIDDLEMIDDLE_OV_12_io_east_dout_v),
    .io_east_dout_r(MIDDLEMIDDLE_OV_12_io_east_dout_r),
    .io_south_dout(MIDDLEMIDDLE_OV_12_io_south_dout),
    .io_south_dout_v(MIDDLEMIDDLE_OV_12_io_south_dout_v),
    .io_west_dout_r(MIDDLEMIDDLE_OV_12_io_west_dout_r),
    .io_config_bits(MIDDLEMIDDLE_OV_12_io_config_bits),
    .io_catch_config(MIDDLEMIDDLE_OV_12_io_catch_config)
  );
  ProcessingElement MIDDLEMIDDLE_OV_13 ( // @[OverlayRocc.scala 369:49]
    .clock(MIDDLEMIDDLE_OV_13_clock),
    .reset(MIDDLEMIDDLE_OV_13_reset),
    .io_north_din(MIDDLEMIDDLE_OV_13_io_north_din),
    .io_north_din_v(MIDDLEMIDDLE_OV_13_io_north_din_v),
    .io_north_din_r(MIDDLEMIDDLE_OV_13_io_north_din_r),
    .io_east_din_r(MIDDLEMIDDLE_OV_13_io_east_din_r),
    .io_south_din_r(MIDDLEMIDDLE_OV_13_io_south_din_r),
    .io_west_din(MIDDLEMIDDLE_OV_13_io_west_din),
    .io_west_din_v(MIDDLEMIDDLE_OV_13_io_west_din_v),
    .io_north_dout_r(MIDDLEMIDDLE_OV_13_io_north_dout_r),
    .io_east_dout(MIDDLEMIDDLE_OV_13_io_east_dout),
    .io_east_dout_v(MIDDLEMIDDLE_OV_13_io_east_dout_v),
    .io_east_dout_r(MIDDLEMIDDLE_OV_13_io_east_dout_r),
    .io_south_dout(MIDDLEMIDDLE_OV_13_io_south_dout),
    .io_south_dout_v(MIDDLEMIDDLE_OV_13_io_south_dout_v),
    .io_west_dout_r(MIDDLEMIDDLE_OV_13_io_west_dout_r),
    .io_config_bits(MIDDLEMIDDLE_OV_13_io_config_bits),
    .io_catch_config(MIDDLEMIDDLE_OV_13_io_catch_config)
  );
  ProcessingElement MIDDLEMIDDLE_OV_14 ( // @[OverlayRocc.scala 369:49]
    .clock(MIDDLEMIDDLE_OV_14_clock),
    .reset(MIDDLEMIDDLE_OV_14_reset),
    .io_north_din(MIDDLEMIDDLE_OV_14_io_north_din),
    .io_north_din_v(MIDDLEMIDDLE_OV_14_io_north_din_v),
    .io_north_din_r(MIDDLEMIDDLE_OV_14_io_north_din_r),
    .io_east_din_r(MIDDLEMIDDLE_OV_14_io_east_din_r),
    .io_south_din_r(MIDDLEMIDDLE_OV_14_io_south_din_r),
    .io_west_din(MIDDLEMIDDLE_OV_14_io_west_din),
    .io_west_din_v(MIDDLEMIDDLE_OV_14_io_west_din_v),
    .io_north_dout_r(MIDDLEMIDDLE_OV_14_io_north_dout_r),
    .io_east_dout(MIDDLEMIDDLE_OV_14_io_east_dout),
    .io_east_dout_v(MIDDLEMIDDLE_OV_14_io_east_dout_v),
    .io_east_dout_r(MIDDLEMIDDLE_OV_14_io_east_dout_r),
    .io_south_dout(MIDDLEMIDDLE_OV_14_io_south_dout),
    .io_south_dout_v(MIDDLEMIDDLE_OV_14_io_south_dout_v),
    .io_west_dout_r(MIDDLEMIDDLE_OV_14_io_west_dout_r),
    .io_config_bits(MIDDLEMIDDLE_OV_14_io_config_bits),
    .io_catch_config(MIDDLEMIDDLE_OV_14_io_catch_config)
  );
  ProcessingElement MIDDLEMIDDLE_OV_15 ( // @[OverlayRocc.scala 369:49]
    .clock(MIDDLEMIDDLE_OV_15_clock),
    .reset(MIDDLEMIDDLE_OV_15_reset),
    .io_north_din(MIDDLEMIDDLE_OV_15_io_north_din),
    .io_north_din_v(MIDDLEMIDDLE_OV_15_io_north_din_v),
    .io_north_din_r(MIDDLEMIDDLE_OV_15_io_north_din_r),
    .io_east_din_r(MIDDLEMIDDLE_OV_15_io_east_din_r),
    .io_south_din_r(MIDDLEMIDDLE_OV_15_io_south_din_r),
    .io_west_din(MIDDLEMIDDLE_OV_15_io_west_din),
    .io_west_din_v(MIDDLEMIDDLE_OV_15_io_west_din_v),
    .io_north_dout_r(MIDDLEMIDDLE_OV_15_io_north_dout_r),
    .io_east_dout(MIDDLEMIDDLE_OV_15_io_east_dout),
    .io_east_dout_v(MIDDLEMIDDLE_OV_15_io_east_dout_v),
    .io_east_dout_r(MIDDLEMIDDLE_OV_15_io_east_dout_r),
    .io_south_dout(MIDDLEMIDDLE_OV_15_io_south_dout),
    .io_south_dout_v(MIDDLEMIDDLE_OV_15_io_south_dout_v),
    .io_west_dout_r(MIDDLEMIDDLE_OV_15_io_west_dout_r),
    .io_config_bits(MIDDLEMIDDLE_OV_15_io_config_bits),
    .io_catch_config(MIDDLEMIDDLE_OV_15_io_catch_config)
  );
  ProcessingElement MIDDLEMIDDLE_OV_16 ( // @[OverlayRocc.scala 369:49]
    .clock(MIDDLEMIDDLE_OV_16_clock),
    .reset(MIDDLEMIDDLE_OV_16_reset),
    .io_north_din(MIDDLEMIDDLE_OV_16_io_north_din),
    .io_north_din_v(MIDDLEMIDDLE_OV_16_io_north_din_v),
    .io_north_din_r(MIDDLEMIDDLE_OV_16_io_north_din_r),
    .io_east_din_r(MIDDLEMIDDLE_OV_16_io_east_din_r),
    .io_south_din_r(MIDDLEMIDDLE_OV_16_io_south_din_r),
    .io_west_din(MIDDLEMIDDLE_OV_16_io_west_din),
    .io_west_din_v(MIDDLEMIDDLE_OV_16_io_west_din_v),
    .io_north_dout_r(MIDDLEMIDDLE_OV_16_io_north_dout_r),
    .io_east_dout(MIDDLEMIDDLE_OV_16_io_east_dout),
    .io_east_dout_v(MIDDLEMIDDLE_OV_16_io_east_dout_v),
    .io_east_dout_r(MIDDLEMIDDLE_OV_16_io_east_dout_r),
    .io_south_dout(MIDDLEMIDDLE_OV_16_io_south_dout),
    .io_south_dout_v(MIDDLEMIDDLE_OV_16_io_south_dout_v),
    .io_west_dout_r(MIDDLEMIDDLE_OV_16_io_west_dout_r),
    .io_config_bits(MIDDLEMIDDLE_OV_16_io_config_bits),
    .io_catch_config(MIDDLEMIDDLE_OV_16_io_catch_config)
  );
  ProcessingElement MIDDLEMIDDLE_OV_17 ( // @[OverlayRocc.scala 369:49]
    .clock(MIDDLEMIDDLE_OV_17_clock),
    .reset(MIDDLEMIDDLE_OV_17_reset),
    .io_north_din(MIDDLEMIDDLE_OV_17_io_north_din),
    .io_north_din_v(MIDDLEMIDDLE_OV_17_io_north_din_v),
    .io_north_din_r(MIDDLEMIDDLE_OV_17_io_north_din_r),
    .io_east_din_r(MIDDLEMIDDLE_OV_17_io_east_din_r),
    .io_south_din_r(MIDDLEMIDDLE_OV_17_io_south_din_r),
    .io_west_din(MIDDLEMIDDLE_OV_17_io_west_din),
    .io_west_din_v(MIDDLEMIDDLE_OV_17_io_west_din_v),
    .io_north_dout_r(MIDDLEMIDDLE_OV_17_io_north_dout_r),
    .io_east_dout(MIDDLEMIDDLE_OV_17_io_east_dout),
    .io_east_dout_v(MIDDLEMIDDLE_OV_17_io_east_dout_v),
    .io_east_dout_r(MIDDLEMIDDLE_OV_17_io_east_dout_r),
    .io_south_dout(MIDDLEMIDDLE_OV_17_io_south_dout),
    .io_south_dout_v(MIDDLEMIDDLE_OV_17_io_south_dout_v),
    .io_west_dout_r(MIDDLEMIDDLE_OV_17_io_west_dout_r),
    .io_config_bits(MIDDLEMIDDLE_OV_17_io_config_bits),
    .io_catch_config(MIDDLEMIDDLE_OV_17_io_catch_config)
  );
  ProcessingElement MIDDLESOUTH_OV_2 ( // @[OverlayRocc.scala 418:48]
    .clock(MIDDLESOUTH_OV_2_clock),
    .reset(MIDDLESOUTH_OV_2_reset),
    .io_north_din(MIDDLESOUTH_OV_2_io_north_din),
    .io_north_din_v(MIDDLESOUTH_OV_2_io_north_din_v),
    .io_north_din_r(MIDDLESOUTH_OV_2_io_north_din_r),
    .io_east_din_r(MIDDLESOUTH_OV_2_io_east_din_r),
    .io_south_din_r(MIDDLESOUTH_OV_2_io_south_din_r),
    .io_west_din(MIDDLESOUTH_OV_2_io_west_din),
    .io_west_din_v(MIDDLESOUTH_OV_2_io_west_din_v),
    .io_north_dout_r(MIDDLESOUTH_OV_2_io_north_dout_r),
    .io_east_dout(MIDDLESOUTH_OV_2_io_east_dout),
    .io_east_dout_v(MIDDLESOUTH_OV_2_io_east_dout_v),
    .io_east_dout_r(MIDDLESOUTH_OV_2_io_east_dout_r),
    .io_south_dout(MIDDLESOUTH_OV_2_io_south_dout),
    .io_south_dout_v(MIDDLESOUTH_OV_2_io_south_dout_v),
    .io_west_dout_r(MIDDLESOUTH_OV_2_io_west_dout_r),
    .io_config_bits(MIDDLESOUTH_OV_2_io_config_bits),
    .io_catch_config(MIDDLESOUTH_OV_2_io_catch_config)
  );
  ProcessingElement MIDDLENORTH_OV_3 ( // @[OverlayRocc.scala 320:48]
    .clock(MIDDLENORTH_OV_3_clock),
    .reset(MIDDLENORTH_OV_3_reset),
    .io_north_din(MIDDLENORTH_OV_3_io_north_din),
    .io_north_din_v(MIDDLENORTH_OV_3_io_north_din_v),
    .io_north_din_r(MIDDLENORTH_OV_3_io_north_din_r),
    .io_east_din_r(MIDDLENORTH_OV_3_io_east_din_r),
    .io_south_din_r(MIDDLENORTH_OV_3_io_south_din_r),
    .io_west_din(MIDDLENORTH_OV_3_io_west_din),
    .io_west_din_v(MIDDLENORTH_OV_3_io_west_din_v),
    .io_north_dout_r(MIDDLENORTH_OV_3_io_north_dout_r),
    .io_east_dout(MIDDLENORTH_OV_3_io_east_dout),
    .io_east_dout_v(MIDDLENORTH_OV_3_io_east_dout_v),
    .io_east_dout_r(MIDDLENORTH_OV_3_io_east_dout_r),
    .io_south_dout(MIDDLENORTH_OV_3_io_south_dout),
    .io_south_dout_v(MIDDLENORTH_OV_3_io_south_dout_v),
    .io_west_dout_r(MIDDLENORTH_OV_3_io_west_dout_r),
    .io_config_bits(MIDDLENORTH_OV_3_io_config_bits),
    .io_catch_config(MIDDLENORTH_OV_3_io_catch_config)
  );
  ProcessingElement MIDDLEMIDDLE_OV_18 ( // @[OverlayRocc.scala 369:49]
    .clock(MIDDLEMIDDLE_OV_18_clock),
    .reset(MIDDLEMIDDLE_OV_18_reset),
    .io_north_din(MIDDLEMIDDLE_OV_18_io_north_din),
    .io_north_din_v(MIDDLEMIDDLE_OV_18_io_north_din_v),
    .io_north_din_r(MIDDLEMIDDLE_OV_18_io_north_din_r),
    .io_east_din_r(MIDDLEMIDDLE_OV_18_io_east_din_r),
    .io_south_din_r(MIDDLEMIDDLE_OV_18_io_south_din_r),
    .io_west_din(MIDDLEMIDDLE_OV_18_io_west_din),
    .io_west_din_v(MIDDLEMIDDLE_OV_18_io_west_din_v),
    .io_north_dout_r(MIDDLEMIDDLE_OV_18_io_north_dout_r),
    .io_east_dout(MIDDLEMIDDLE_OV_18_io_east_dout),
    .io_east_dout_v(MIDDLEMIDDLE_OV_18_io_east_dout_v),
    .io_east_dout_r(MIDDLEMIDDLE_OV_18_io_east_dout_r),
    .io_south_dout(MIDDLEMIDDLE_OV_18_io_south_dout),
    .io_south_dout_v(MIDDLEMIDDLE_OV_18_io_south_dout_v),
    .io_west_dout_r(MIDDLEMIDDLE_OV_18_io_west_dout_r),
    .io_config_bits(MIDDLEMIDDLE_OV_18_io_config_bits),
    .io_catch_config(MIDDLEMIDDLE_OV_18_io_catch_config)
  );
  ProcessingElement MIDDLEMIDDLE_OV_19 ( // @[OverlayRocc.scala 369:49]
    .clock(MIDDLEMIDDLE_OV_19_clock),
    .reset(MIDDLEMIDDLE_OV_19_reset),
    .io_north_din(MIDDLEMIDDLE_OV_19_io_north_din),
    .io_north_din_v(MIDDLEMIDDLE_OV_19_io_north_din_v),
    .io_north_din_r(MIDDLEMIDDLE_OV_19_io_north_din_r),
    .io_east_din_r(MIDDLEMIDDLE_OV_19_io_east_din_r),
    .io_south_din_r(MIDDLEMIDDLE_OV_19_io_south_din_r),
    .io_west_din(MIDDLEMIDDLE_OV_19_io_west_din),
    .io_west_din_v(MIDDLEMIDDLE_OV_19_io_west_din_v),
    .io_north_dout_r(MIDDLEMIDDLE_OV_19_io_north_dout_r),
    .io_east_dout(MIDDLEMIDDLE_OV_19_io_east_dout),
    .io_east_dout_v(MIDDLEMIDDLE_OV_19_io_east_dout_v),
    .io_east_dout_r(MIDDLEMIDDLE_OV_19_io_east_dout_r),
    .io_south_dout(MIDDLEMIDDLE_OV_19_io_south_dout),
    .io_south_dout_v(MIDDLEMIDDLE_OV_19_io_south_dout_v),
    .io_west_dout_r(MIDDLEMIDDLE_OV_19_io_west_dout_r),
    .io_config_bits(MIDDLEMIDDLE_OV_19_io_config_bits),
    .io_catch_config(MIDDLEMIDDLE_OV_19_io_catch_config)
  );
  ProcessingElement MIDDLEMIDDLE_OV_20 ( // @[OverlayRocc.scala 369:49]
    .clock(MIDDLEMIDDLE_OV_20_clock),
    .reset(MIDDLEMIDDLE_OV_20_reset),
    .io_north_din(MIDDLEMIDDLE_OV_20_io_north_din),
    .io_north_din_v(MIDDLEMIDDLE_OV_20_io_north_din_v),
    .io_north_din_r(MIDDLEMIDDLE_OV_20_io_north_din_r),
    .io_east_din_r(MIDDLEMIDDLE_OV_20_io_east_din_r),
    .io_south_din_r(MIDDLEMIDDLE_OV_20_io_south_din_r),
    .io_west_din(MIDDLEMIDDLE_OV_20_io_west_din),
    .io_west_din_v(MIDDLEMIDDLE_OV_20_io_west_din_v),
    .io_north_dout_r(MIDDLEMIDDLE_OV_20_io_north_dout_r),
    .io_east_dout(MIDDLEMIDDLE_OV_20_io_east_dout),
    .io_east_dout_v(MIDDLEMIDDLE_OV_20_io_east_dout_v),
    .io_east_dout_r(MIDDLEMIDDLE_OV_20_io_east_dout_r),
    .io_south_dout(MIDDLEMIDDLE_OV_20_io_south_dout),
    .io_south_dout_v(MIDDLEMIDDLE_OV_20_io_south_dout_v),
    .io_west_dout_r(MIDDLEMIDDLE_OV_20_io_west_dout_r),
    .io_config_bits(MIDDLEMIDDLE_OV_20_io_config_bits),
    .io_catch_config(MIDDLEMIDDLE_OV_20_io_catch_config)
  );
  ProcessingElement MIDDLEMIDDLE_OV_21 ( // @[OverlayRocc.scala 369:49]
    .clock(MIDDLEMIDDLE_OV_21_clock),
    .reset(MIDDLEMIDDLE_OV_21_reset),
    .io_north_din(MIDDLEMIDDLE_OV_21_io_north_din),
    .io_north_din_v(MIDDLEMIDDLE_OV_21_io_north_din_v),
    .io_north_din_r(MIDDLEMIDDLE_OV_21_io_north_din_r),
    .io_east_din_r(MIDDLEMIDDLE_OV_21_io_east_din_r),
    .io_south_din_r(MIDDLEMIDDLE_OV_21_io_south_din_r),
    .io_west_din(MIDDLEMIDDLE_OV_21_io_west_din),
    .io_west_din_v(MIDDLEMIDDLE_OV_21_io_west_din_v),
    .io_north_dout_r(MIDDLEMIDDLE_OV_21_io_north_dout_r),
    .io_east_dout(MIDDLEMIDDLE_OV_21_io_east_dout),
    .io_east_dout_v(MIDDLEMIDDLE_OV_21_io_east_dout_v),
    .io_east_dout_r(MIDDLEMIDDLE_OV_21_io_east_dout_r),
    .io_south_dout(MIDDLEMIDDLE_OV_21_io_south_dout),
    .io_south_dout_v(MIDDLEMIDDLE_OV_21_io_south_dout_v),
    .io_west_dout_r(MIDDLEMIDDLE_OV_21_io_west_dout_r),
    .io_config_bits(MIDDLEMIDDLE_OV_21_io_config_bits),
    .io_catch_config(MIDDLEMIDDLE_OV_21_io_catch_config)
  );
  ProcessingElement MIDDLEMIDDLE_OV_22 ( // @[OverlayRocc.scala 369:49]
    .clock(MIDDLEMIDDLE_OV_22_clock),
    .reset(MIDDLEMIDDLE_OV_22_reset),
    .io_north_din(MIDDLEMIDDLE_OV_22_io_north_din),
    .io_north_din_v(MIDDLEMIDDLE_OV_22_io_north_din_v),
    .io_north_din_r(MIDDLEMIDDLE_OV_22_io_north_din_r),
    .io_east_din_r(MIDDLEMIDDLE_OV_22_io_east_din_r),
    .io_south_din_r(MIDDLEMIDDLE_OV_22_io_south_din_r),
    .io_west_din(MIDDLEMIDDLE_OV_22_io_west_din),
    .io_west_din_v(MIDDLEMIDDLE_OV_22_io_west_din_v),
    .io_north_dout_r(MIDDLEMIDDLE_OV_22_io_north_dout_r),
    .io_east_dout(MIDDLEMIDDLE_OV_22_io_east_dout),
    .io_east_dout_v(MIDDLEMIDDLE_OV_22_io_east_dout_v),
    .io_east_dout_r(MIDDLEMIDDLE_OV_22_io_east_dout_r),
    .io_south_dout(MIDDLEMIDDLE_OV_22_io_south_dout),
    .io_south_dout_v(MIDDLEMIDDLE_OV_22_io_south_dout_v),
    .io_west_dout_r(MIDDLEMIDDLE_OV_22_io_west_dout_r),
    .io_config_bits(MIDDLEMIDDLE_OV_22_io_config_bits),
    .io_catch_config(MIDDLEMIDDLE_OV_22_io_catch_config)
  );
  ProcessingElement MIDDLEMIDDLE_OV_23 ( // @[OverlayRocc.scala 369:49]
    .clock(MIDDLEMIDDLE_OV_23_clock),
    .reset(MIDDLEMIDDLE_OV_23_reset),
    .io_north_din(MIDDLEMIDDLE_OV_23_io_north_din),
    .io_north_din_v(MIDDLEMIDDLE_OV_23_io_north_din_v),
    .io_north_din_r(MIDDLEMIDDLE_OV_23_io_north_din_r),
    .io_east_din_r(MIDDLEMIDDLE_OV_23_io_east_din_r),
    .io_south_din_r(MIDDLEMIDDLE_OV_23_io_south_din_r),
    .io_west_din(MIDDLEMIDDLE_OV_23_io_west_din),
    .io_west_din_v(MIDDLEMIDDLE_OV_23_io_west_din_v),
    .io_north_dout_r(MIDDLEMIDDLE_OV_23_io_north_dout_r),
    .io_east_dout(MIDDLEMIDDLE_OV_23_io_east_dout),
    .io_east_dout_v(MIDDLEMIDDLE_OV_23_io_east_dout_v),
    .io_east_dout_r(MIDDLEMIDDLE_OV_23_io_east_dout_r),
    .io_south_dout(MIDDLEMIDDLE_OV_23_io_south_dout),
    .io_south_dout_v(MIDDLEMIDDLE_OV_23_io_south_dout_v),
    .io_west_dout_r(MIDDLEMIDDLE_OV_23_io_west_dout_r),
    .io_config_bits(MIDDLEMIDDLE_OV_23_io_config_bits),
    .io_catch_config(MIDDLEMIDDLE_OV_23_io_catch_config)
  );
  ProcessingElement MIDDLESOUTH_OV_3 ( // @[OverlayRocc.scala 418:48]
    .clock(MIDDLESOUTH_OV_3_clock),
    .reset(MIDDLESOUTH_OV_3_reset),
    .io_north_din(MIDDLESOUTH_OV_3_io_north_din),
    .io_north_din_v(MIDDLESOUTH_OV_3_io_north_din_v),
    .io_north_din_r(MIDDLESOUTH_OV_3_io_north_din_r),
    .io_east_din_r(MIDDLESOUTH_OV_3_io_east_din_r),
    .io_south_din_r(MIDDLESOUTH_OV_3_io_south_din_r),
    .io_west_din(MIDDLESOUTH_OV_3_io_west_din),
    .io_west_din_v(MIDDLESOUTH_OV_3_io_west_din_v),
    .io_north_dout_r(MIDDLESOUTH_OV_3_io_north_dout_r),
    .io_east_dout(MIDDLESOUTH_OV_3_io_east_dout),
    .io_east_dout_v(MIDDLESOUTH_OV_3_io_east_dout_v),
    .io_east_dout_r(MIDDLESOUTH_OV_3_io_east_dout_r),
    .io_south_dout(MIDDLESOUTH_OV_3_io_south_dout),
    .io_south_dout_v(MIDDLESOUTH_OV_3_io_south_dout_v),
    .io_west_dout_r(MIDDLESOUTH_OV_3_io_west_dout_r),
    .io_config_bits(MIDDLESOUTH_OV_3_io_config_bits),
    .io_catch_config(MIDDLESOUTH_OV_3_io_catch_config)
  );
  ProcessingElement MIDDLENORTH_OV_4 ( // @[OverlayRocc.scala 320:48]
    .clock(MIDDLENORTH_OV_4_clock),
    .reset(MIDDLENORTH_OV_4_reset),
    .io_north_din(MIDDLENORTH_OV_4_io_north_din),
    .io_north_din_v(MIDDLENORTH_OV_4_io_north_din_v),
    .io_north_din_r(MIDDLENORTH_OV_4_io_north_din_r),
    .io_east_din_r(MIDDLENORTH_OV_4_io_east_din_r),
    .io_south_din_r(MIDDLENORTH_OV_4_io_south_din_r),
    .io_west_din(MIDDLENORTH_OV_4_io_west_din),
    .io_west_din_v(MIDDLENORTH_OV_4_io_west_din_v),
    .io_north_dout_r(MIDDLENORTH_OV_4_io_north_dout_r),
    .io_east_dout(MIDDLENORTH_OV_4_io_east_dout),
    .io_east_dout_v(MIDDLENORTH_OV_4_io_east_dout_v),
    .io_east_dout_r(MIDDLENORTH_OV_4_io_east_dout_r),
    .io_south_dout(MIDDLENORTH_OV_4_io_south_dout),
    .io_south_dout_v(MIDDLENORTH_OV_4_io_south_dout_v),
    .io_west_dout_r(MIDDLENORTH_OV_4_io_west_dout_r),
    .io_config_bits(MIDDLENORTH_OV_4_io_config_bits),
    .io_catch_config(MIDDLENORTH_OV_4_io_catch_config)
  );
  ProcessingElement MIDDLEMIDDLE_OV_24 ( // @[OverlayRocc.scala 369:49]
    .clock(MIDDLEMIDDLE_OV_24_clock),
    .reset(MIDDLEMIDDLE_OV_24_reset),
    .io_north_din(MIDDLEMIDDLE_OV_24_io_north_din),
    .io_north_din_v(MIDDLEMIDDLE_OV_24_io_north_din_v),
    .io_north_din_r(MIDDLEMIDDLE_OV_24_io_north_din_r),
    .io_east_din_r(MIDDLEMIDDLE_OV_24_io_east_din_r),
    .io_south_din_r(MIDDLEMIDDLE_OV_24_io_south_din_r),
    .io_west_din(MIDDLEMIDDLE_OV_24_io_west_din),
    .io_west_din_v(MIDDLEMIDDLE_OV_24_io_west_din_v),
    .io_north_dout_r(MIDDLEMIDDLE_OV_24_io_north_dout_r),
    .io_east_dout(MIDDLEMIDDLE_OV_24_io_east_dout),
    .io_east_dout_v(MIDDLEMIDDLE_OV_24_io_east_dout_v),
    .io_east_dout_r(MIDDLEMIDDLE_OV_24_io_east_dout_r),
    .io_south_dout(MIDDLEMIDDLE_OV_24_io_south_dout),
    .io_south_dout_v(MIDDLEMIDDLE_OV_24_io_south_dout_v),
    .io_west_dout_r(MIDDLEMIDDLE_OV_24_io_west_dout_r),
    .io_config_bits(MIDDLEMIDDLE_OV_24_io_config_bits),
    .io_catch_config(MIDDLEMIDDLE_OV_24_io_catch_config)
  );
  ProcessingElement MIDDLEMIDDLE_OV_25 ( // @[OverlayRocc.scala 369:49]
    .clock(MIDDLEMIDDLE_OV_25_clock),
    .reset(MIDDLEMIDDLE_OV_25_reset),
    .io_north_din(MIDDLEMIDDLE_OV_25_io_north_din),
    .io_north_din_v(MIDDLEMIDDLE_OV_25_io_north_din_v),
    .io_north_din_r(MIDDLEMIDDLE_OV_25_io_north_din_r),
    .io_east_din_r(MIDDLEMIDDLE_OV_25_io_east_din_r),
    .io_south_din_r(MIDDLEMIDDLE_OV_25_io_south_din_r),
    .io_west_din(MIDDLEMIDDLE_OV_25_io_west_din),
    .io_west_din_v(MIDDLEMIDDLE_OV_25_io_west_din_v),
    .io_north_dout_r(MIDDLEMIDDLE_OV_25_io_north_dout_r),
    .io_east_dout(MIDDLEMIDDLE_OV_25_io_east_dout),
    .io_east_dout_v(MIDDLEMIDDLE_OV_25_io_east_dout_v),
    .io_east_dout_r(MIDDLEMIDDLE_OV_25_io_east_dout_r),
    .io_south_dout(MIDDLEMIDDLE_OV_25_io_south_dout),
    .io_south_dout_v(MIDDLEMIDDLE_OV_25_io_south_dout_v),
    .io_west_dout_r(MIDDLEMIDDLE_OV_25_io_west_dout_r),
    .io_config_bits(MIDDLEMIDDLE_OV_25_io_config_bits),
    .io_catch_config(MIDDLEMIDDLE_OV_25_io_catch_config)
  );
  ProcessingElement MIDDLEMIDDLE_OV_26 ( // @[OverlayRocc.scala 369:49]
    .clock(MIDDLEMIDDLE_OV_26_clock),
    .reset(MIDDLEMIDDLE_OV_26_reset),
    .io_north_din(MIDDLEMIDDLE_OV_26_io_north_din),
    .io_north_din_v(MIDDLEMIDDLE_OV_26_io_north_din_v),
    .io_north_din_r(MIDDLEMIDDLE_OV_26_io_north_din_r),
    .io_east_din_r(MIDDLEMIDDLE_OV_26_io_east_din_r),
    .io_south_din_r(MIDDLEMIDDLE_OV_26_io_south_din_r),
    .io_west_din(MIDDLEMIDDLE_OV_26_io_west_din),
    .io_west_din_v(MIDDLEMIDDLE_OV_26_io_west_din_v),
    .io_north_dout_r(MIDDLEMIDDLE_OV_26_io_north_dout_r),
    .io_east_dout(MIDDLEMIDDLE_OV_26_io_east_dout),
    .io_east_dout_v(MIDDLEMIDDLE_OV_26_io_east_dout_v),
    .io_east_dout_r(MIDDLEMIDDLE_OV_26_io_east_dout_r),
    .io_south_dout(MIDDLEMIDDLE_OV_26_io_south_dout),
    .io_south_dout_v(MIDDLEMIDDLE_OV_26_io_south_dout_v),
    .io_west_dout_r(MIDDLEMIDDLE_OV_26_io_west_dout_r),
    .io_config_bits(MIDDLEMIDDLE_OV_26_io_config_bits),
    .io_catch_config(MIDDLEMIDDLE_OV_26_io_catch_config)
  );
  ProcessingElement MIDDLEMIDDLE_OV_27 ( // @[OverlayRocc.scala 369:49]
    .clock(MIDDLEMIDDLE_OV_27_clock),
    .reset(MIDDLEMIDDLE_OV_27_reset),
    .io_north_din(MIDDLEMIDDLE_OV_27_io_north_din),
    .io_north_din_v(MIDDLEMIDDLE_OV_27_io_north_din_v),
    .io_north_din_r(MIDDLEMIDDLE_OV_27_io_north_din_r),
    .io_east_din_r(MIDDLEMIDDLE_OV_27_io_east_din_r),
    .io_south_din_r(MIDDLEMIDDLE_OV_27_io_south_din_r),
    .io_west_din(MIDDLEMIDDLE_OV_27_io_west_din),
    .io_west_din_v(MIDDLEMIDDLE_OV_27_io_west_din_v),
    .io_north_dout_r(MIDDLEMIDDLE_OV_27_io_north_dout_r),
    .io_east_dout(MIDDLEMIDDLE_OV_27_io_east_dout),
    .io_east_dout_v(MIDDLEMIDDLE_OV_27_io_east_dout_v),
    .io_east_dout_r(MIDDLEMIDDLE_OV_27_io_east_dout_r),
    .io_south_dout(MIDDLEMIDDLE_OV_27_io_south_dout),
    .io_south_dout_v(MIDDLEMIDDLE_OV_27_io_south_dout_v),
    .io_west_dout_r(MIDDLEMIDDLE_OV_27_io_west_dout_r),
    .io_config_bits(MIDDLEMIDDLE_OV_27_io_config_bits),
    .io_catch_config(MIDDLEMIDDLE_OV_27_io_catch_config)
  );
  ProcessingElement MIDDLEMIDDLE_OV_28 ( // @[OverlayRocc.scala 369:49]
    .clock(MIDDLEMIDDLE_OV_28_clock),
    .reset(MIDDLEMIDDLE_OV_28_reset),
    .io_north_din(MIDDLEMIDDLE_OV_28_io_north_din),
    .io_north_din_v(MIDDLEMIDDLE_OV_28_io_north_din_v),
    .io_north_din_r(MIDDLEMIDDLE_OV_28_io_north_din_r),
    .io_east_din_r(MIDDLEMIDDLE_OV_28_io_east_din_r),
    .io_south_din_r(MIDDLEMIDDLE_OV_28_io_south_din_r),
    .io_west_din(MIDDLEMIDDLE_OV_28_io_west_din),
    .io_west_din_v(MIDDLEMIDDLE_OV_28_io_west_din_v),
    .io_north_dout_r(MIDDLEMIDDLE_OV_28_io_north_dout_r),
    .io_east_dout(MIDDLEMIDDLE_OV_28_io_east_dout),
    .io_east_dout_v(MIDDLEMIDDLE_OV_28_io_east_dout_v),
    .io_east_dout_r(MIDDLEMIDDLE_OV_28_io_east_dout_r),
    .io_south_dout(MIDDLEMIDDLE_OV_28_io_south_dout),
    .io_south_dout_v(MIDDLEMIDDLE_OV_28_io_south_dout_v),
    .io_west_dout_r(MIDDLEMIDDLE_OV_28_io_west_dout_r),
    .io_config_bits(MIDDLEMIDDLE_OV_28_io_config_bits),
    .io_catch_config(MIDDLEMIDDLE_OV_28_io_catch_config)
  );
  ProcessingElement MIDDLEMIDDLE_OV_29 ( // @[OverlayRocc.scala 369:49]
    .clock(MIDDLEMIDDLE_OV_29_clock),
    .reset(MIDDLEMIDDLE_OV_29_reset),
    .io_north_din(MIDDLEMIDDLE_OV_29_io_north_din),
    .io_north_din_v(MIDDLEMIDDLE_OV_29_io_north_din_v),
    .io_north_din_r(MIDDLEMIDDLE_OV_29_io_north_din_r),
    .io_east_din_r(MIDDLEMIDDLE_OV_29_io_east_din_r),
    .io_south_din_r(MIDDLEMIDDLE_OV_29_io_south_din_r),
    .io_west_din(MIDDLEMIDDLE_OV_29_io_west_din),
    .io_west_din_v(MIDDLEMIDDLE_OV_29_io_west_din_v),
    .io_north_dout_r(MIDDLEMIDDLE_OV_29_io_north_dout_r),
    .io_east_dout(MIDDLEMIDDLE_OV_29_io_east_dout),
    .io_east_dout_v(MIDDLEMIDDLE_OV_29_io_east_dout_v),
    .io_east_dout_r(MIDDLEMIDDLE_OV_29_io_east_dout_r),
    .io_south_dout(MIDDLEMIDDLE_OV_29_io_south_dout),
    .io_south_dout_v(MIDDLEMIDDLE_OV_29_io_south_dout_v),
    .io_west_dout_r(MIDDLEMIDDLE_OV_29_io_west_dout_r),
    .io_config_bits(MIDDLEMIDDLE_OV_29_io_config_bits),
    .io_catch_config(MIDDLEMIDDLE_OV_29_io_catch_config)
  );
  ProcessingElement MIDDLESOUTH_OV_4 ( // @[OverlayRocc.scala 418:48]
    .clock(MIDDLESOUTH_OV_4_clock),
    .reset(MIDDLESOUTH_OV_4_reset),
    .io_north_din(MIDDLESOUTH_OV_4_io_north_din),
    .io_north_din_v(MIDDLESOUTH_OV_4_io_north_din_v),
    .io_north_din_r(MIDDLESOUTH_OV_4_io_north_din_r),
    .io_east_din_r(MIDDLESOUTH_OV_4_io_east_din_r),
    .io_south_din_r(MIDDLESOUTH_OV_4_io_south_din_r),
    .io_west_din(MIDDLESOUTH_OV_4_io_west_din),
    .io_west_din_v(MIDDLESOUTH_OV_4_io_west_din_v),
    .io_north_dout_r(MIDDLESOUTH_OV_4_io_north_dout_r),
    .io_east_dout(MIDDLESOUTH_OV_4_io_east_dout),
    .io_east_dout_v(MIDDLESOUTH_OV_4_io_east_dout_v),
    .io_east_dout_r(MIDDLESOUTH_OV_4_io_east_dout_r),
    .io_south_dout(MIDDLESOUTH_OV_4_io_south_dout),
    .io_south_dout_v(MIDDLESOUTH_OV_4_io_south_dout_v),
    .io_west_dout_r(MIDDLESOUTH_OV_4_io_west_dout_r),
    .io_config_bits(MIDDLESOUTH_OV_4_io_config_bits),
    .io_catch_config(MIDDLESOUTH_OV_4_io_catch_config)
  );
  ProcessingElement MIDDLENORTH_OV_5 ( // @[OverlayRocc.scala 320:48]
    .clock(MIDDLENORTH_OV_5_clock),
    .reset(MIDDLENORTH_OV_5_reset),
    .io_north_din(MIDDLENORTH_OV_5_io_north_din),
    .io_north_din_v(MIDDLENORTH_OV_5_io_north_din_v),
    .io_north_din_r(MIDDLENORTH_OV_5_io_north_din_r),
    .io_east_din_r(MIDDLENORTH_OV_5_io_east_din_r),
    .io_south_din_r(MIDDLENORTH_OV_5_io_south_din_r),
    .io_west_din(MIDDLENORTH_OV_5_io_west_din),
    .io_west_din_v(MIDDLENORTH_OV_5_io_west_din_v),
    .io_north_dout_r(MIDDLENORTH_OV_5_io_north_dout_r),
    .io_east_dout(MIDDLENORTH_OV_5_io_east_dout),
    .io_east_dout_v(MIDDLENORTH_OV_5_io_east_dout_v),
    .io_east_dout_r(MIDDLENORTH_OV_5_io_east_dout_r),
    .io_south_dout(MIDDLENORTH_OV_5_io_south_dout),
    .io_south_dout_v(MIDDLENORTH_OV_5_io_south_dout_v),
    .io_west_dout_r(MIDDLENORTH_OV_5_io_west_dout_r),
    .io_config_bits(MIDDLENORTH_OV_5_io_config_bits),
    .io_catch_config(MIDDLENORTH_OV_5_io_catch_config)
  );
  ProcessingElement MIDDLEMIDDLE_OV_30 ( // @[OverlayRocc.scala 369:49]
    .clock(MIDDLEMIDDLE_OV_30_clock),
    .reset(MIDDLEMIDDLE_OV_30_reset),
    .io_north_din(MIDDLEMIDDLE_OV_30_io_north_din),
    .io_north_din_v(MIDDLEMIDDLE_OV_30_io_north_din_v),
    .io_north_din_r(MIDDLEMIDDLE_OV_30_io_north_din_r),
    .io_east_din_r(MIDDLEMIDDLE_OV_30_io_east_din_r),
    .io_south_din_r(MIDDLEMIDDLE_OV_30_io_south_din_r),
    .io_west_din(MIDDLEMIDDLE_OV_30_io_west_din),
    .io_west_din_v(MIDDLEMIDDLE_OV_30_io_west_din_v),
    .io_north_dout_r(MIDDLEMIDDLE_OV_30_io_north_dout_r),
    .io_east_dout(MIDDLEMIDDLE_OV_30_io_east_dout),
    .io_east_dout_v(MIDDLEMIDDLE_OV_30_io_east_dout_v),
    .io_east_dout_r(MIDDLEMIDDLE_OV_30_io_east_dout_r),
    .io_south_dout(MIDDLEMIDDLE_OV_30_io_south_dout),
    .io_south_dout_v(MIDDLEMIDDLE_OV_30_io_south_dout_v),
    .io_west_dout_r(MIDDLEMIDDLE_OV_30_io_west_dout_r),
    .io_config_bits(MIDDLEMIDDLE_OV_30_io_config_bits),
    .io_catch_config(MIDDLEMIDDLE_OV_30_io_catch_config)
  );
  ProcessingElement MIDDLEMIDDLE_OV_31 ( // @[OverlayRocc.scala 369:49]
    .clock(MIDDLEMIDDLE_OV_31_clock),
    .reset(MIDDLEMIDDLE_OV_31_reset),
    .io_north_din(MIDDLEMIDDLE_OV_31_io_north_din),
    .io_north_din_v(MIDDLEMIDDLE_OV_31_io_north_din_v),
    .io_north_din_r(MIDDLEMIDDLE_OV_31_io_north_din_r),
    .io_east_din_r(MIDDLEMIDDLE_OV_31_io_east_din_r),
    .io_south_din_r(MIDDLEMIDDLE_OV_31_io_south_din_r),
    .io_west_din(MIDDLEMIDDLE_OV_31_io_west_din),
    .io_west_din_v(MIDDLEMIDDLE_OV_31_io_west_din_v),
    .io_north_dout_r(MIDDLEMIDDLE_OV_31_io_north_dout_r),
    .io_east_dout(MIDDLEMIDDLE_OV_31_io_east_dout),
    .io_east_dout_v(MIDDLEMIDDLE_OV_31_io_east_dout_v),
    .io_east_dout_r(MIDDLEMIDDLE_OV_31_io_east_dout_r),
    .io_south_dout(MIDDLEMIDDLE_OV_31_io_south_dout),
    .io_south_dout_v(MIDDLEMIDDLE_OV_31_io_south_dout_v),
    .io_west_dout_r(MIDDLEMIDDLE_OV_31_io_west_dout_r),
    .io_config_bits(MIDDLEMIDDLE_OV_31_io_config_bits),
    .io_catch_config(MIDDLEMIDDLE_OV_31_io_catch_config)
  );
  ProcessingElement MIDDLEMIDDLE_OV_32 ( // @[OverlayRocc.scala 369:49]
    .clock(MIDDLEMIDDLE_OV_32_clock),
    .reset(MIDDLEMIDDLE_OV_32_reset),
    .io_north_din(MIDDLEMIDDLE_OV_32_io_north_din),
    .io_north_din_v(MIDDLEMIDDLE_OV_32_io_north_din_v),
    .io_north_din_r(MIDDLEMIDDLE_OV_32_io_north_din_r),
    .io_east_din_r(MIDDLEMIDDLE_OV_32_io_east_din_r),
    .io_south_din_r(MIDDLEMIDDLE_OV_32_io_south_din_r),
    .io_west_din(MIDDLEMIDDLE_OV_32_io_west_din),
    .io_west_din_v(MIDDLEMIDDLE_OV_32_io_west_din_v),
    .io_north_dout_r(MIDDLEMIDDLE_OV_32_io_north_dout_r),
    .io_east_dout(MIDDLEMIDDLE_OV_32_io_east_dout),
    .io_east_dout_v(MIDDLEMIDDLE_OV_32_io_east_dout_v),
    .io_east_dout_r(MIDDLEMIDDLE_OV_32_io_east_dout_r),
    .io_south_dout(MIDDLEMIDDLE_OV_32_io_south_dout),
    .io_south_dout_v(MIDDLEMIDDLE_OV_32_io_south_dout_v),
    .io_west_dout_r(MIDDLEMIDDLE_OV_32_io_west_dout_r),
    .io_config_bits(MIDDLEMIDDLE_OV_32_io_config_bits),
    .io_catch_config(MIDDLEMIDDLE_OV_32_io_catch_config)
  );
  ProcessingElement MIDDLEMIDDLE_OV_33 ( // @[OverlayRocc.scala 369:49]
    .clock(MIDDLEMIDDLE_OV_33_clock),
    .reset(MIDDLEMIDDLE_OV_33_reset),
    .io_north_din(MIDDLEMIDDLE_OV_33_io_north_din),
    .io_north_din_v(MIDDLEMIDDLE_OV_33_io_north_din_v),
    .io_north_din_r(MIDDLEMIDDLE_OV_33_io_north_din_r),
    .io_east_din_r(MIDDLEMIDDLE_OV_33_io_east_din_r),
    .io_south_din_r(MIDDLEMIDDLE_OV_33_io_south_din_r),
    .io_west_din(MIDDLEMIDDLE_OV_33_io_west_din),
    .io_west_din_v(MIDDLEMIDDLE_OV_33_io_west_din_v),
    .io_north_dout_r(MIDDLEMIDDLE_OV_33_io_north_dout_r),
    .io_east_dout(MIDDLEMIDDLE_OV_33_io_east_dout),
    .io_east_dout_v(MIDDLEMIDDLE_OV_33_io_east_dout_v),
    .io_east_dout_r(MIDDLEMIDDLE_OV_33_io_east_dout_r),
    .io_south_dout(MIDDLEMIDDLE_OV_33_io_south_dout),
    .io_south_dout_v(MIDDLEMIDDLE_OV_33_io_south_dout_v),
    .io_west_dout_r(MIDDLEMIDDLE_OV_33_io_west_dout_r),
    .io_config_bits(MIDDLEMIDDLE_OV_33_io_config_bits),
    .io_catch_config(MIDDLEMIDDLE_OV_33_io_catch_config)
  );
  ProcessingElement MIDDLEMIDDLE_OV_34 ( // @[OverlayRocc.scala 369:49]
    .clock(MIDDLEMIDDLE_OV_34_clock),
    .reset(MIDDLEMIDDLE_OV_34_reset),
    .io_north_din(MIDDLEMIDDLE_OV_34_io_north_din),
    .io_north_din_v(MIDDLEMIDDLE_OV_34_io_north_din_v),
    .io_north_din_r(MIDDLEMIDDLE_OV_34_io_north_din_r),
    .io_east_din_r(MIDDLEMIDDLE_OV_34_io_east_din_r),
    .io_south_din_r(MIDDLEMIDDLE_OV_34_io_south_din_r),
    .io_west_din(MIDDLEMIDDLE_OV_34_io_west_din),
    .io_west_din_v(MIDDLEMIDDLE_OV_34_io_west_din_v),
    .io_north_dout_r(MIDDLEMIDDLE_OV_34_io_north_dout_r),
    .io_east_dout(MIDDLEMIDDLE_OV_34_io_east_dout),
    .io_east_dout_v(MIDDLEMIDDLE_OV_34_io_east_dout_v),
    .io_east_dout_r(MIDDLEMIDDLE_OV_34_io_east_dout_r),
    .io_south_dout(MIDDLEMIDDLE_OV_34_io_south_dout),
    .io_south_dout_v(MIDDLEMIDDLE_OV_34_io_south_dout_v),
    .io_west_dout_r(MIDDLEMIDDLE_OV_34_io_west_dout_r),
    .io_config_bits(MIDDLEMIDDLE_OV_34_io_config_bits),
    .io_catch_config(MIDDLEMIDDLE_OV_34_io_catch_config)
  );
  ProcessingElement MIDDLEMIDDLE_OV_35 ( // @[OverlayRocc.scala 369:49]
    .clock(MIDDLEMIDDLE_OV_35_clock),
    .reset(MIDDLEMIDDLE_OV_35_reset),
    .io_north_din(MIDDLEMIDDLE_OV_35_io_north_din),
    .io_north_din_v(MIDDLEMIDDLE_OV_35_io_north_din_v),
    .io_north_din_r(MIDDLEMIDDLE_OV_35_io_north_din_r),
    .io_east_din_r(MIDDLEMIDDLE_OV_35_io_east_din_r),
    .io_south_din_r(MIDDLEMIDDLE_OV_35_io_south_din_r),
    .io_west_din(MIDDLEMIDDLE_OV_35_io_west_din),
    .io_west_din_v(MIDDLEMIDDLE_OV_35_io_west_din_v),
    .io_north_dout_r(MIDDLEMIDDLE_OV_35_io_north_dout_r),
    .io_east_dout(MIDDLEMIDDLE_OV_35_io_east_dout),
    .io_east_dout_v(MIDDLEMIDDLE_OV_35_io_east_dout_v),
    .io_east_dout_r(MIDDLEMIDDLE_OV_35_io_east_dout_r),
    .io_south_dout(MIDDLEMIDDLE_OV_35_io_south_dout),
    .io_south_dout_v(MIDDLEMIDDLE_OV_35_io_south_dout_v),
    .io_west_dout_r(MIDDLEMIDDLE_OV_35_io_west_dout_r),
    .io_config_bits(MIDDLEMIDDLE_OV_35_io_config_bits),
    .io_catch_config(MIDDLEMIDDLE_OV_35_io_catch_config)
  );
  ProcessingElement MIDDLESOUTH_OV_5 ( // @[OverlayRocc.scala 418:48]
    .clock(MIDDLESOUTH_OV_5_clock),
    .reset(MIDDLESOUTH_OV_5_reset),
    .io_north_din(MIDDLESOUTH_OV_5_io_north_din),
    .io_north_din_v(MIDDLESOUTH_OV_5_io_north_din_v),
    .io_north_din_r(MIDDLESOUTH_OV_5_io_north_din_r),
    .io_east_din_r(MIDDLESOUTH_OV_5_io_east_din_r),
    .io_south_din_r(MIDDLESOUTH_OV_5_io_south_din_r),
    .io_west_din(MIDDLESOUTH_OV_5_io_west_din),
    .io_west_din_v(MIDDLESOUTH_OV_5_io_west_din_v),
    .io_north_dout_r(MIDDLESOUTH_OV_5_io_north_dout_r),
    .io_east_dout(MIDDLESOUTH_OV_5_io_east_dout),
    .io_east_dout_v(MIDDLESOUTH_OV_5_io_east_dout_v),
    .io_east_dout_r(MIDDLESOUTH_OV_5_io_east_dout_r),
    .io_south_dout(MIDDLESOUTH_OV_5_io_south_dout),
    .io_south_dout_v(MIDDLESOUTH_OV_5_io_south_dout_v),
    .io_west_dout_r(MIDDLESOUTH_OV_5_io_west_dout_r),
    .io_config_bits(MIDDLESOUTH_OV_5_io_config_bits),
    .io_catch_config(MIDDLESOUTH_OV_5_io_catch_config)
  );
  ProcessingElement NORTHEAST_OV ( // @[OverlayRocc.scala 471:46]
    .clock(NORTHEAST_OV_clock),
    .reset(NORTHEAST_OV_reset),
    .io_north_din(NORTHEAST_OV_io_north_din),
    .io_north_din_v(NORTHEAST_OV_io_north_din_v),
    .io_north_din_r(NORTHEAST_OV_io_north_din_r),
    .io_east_din_r(NORTHEAST_OV_io_east_din_r),
    .io_south_din_r(NORTHEAST_OV_io_south_din_r),
    .io_west_din(NORTHEAST_OV_io_west_din),
    .io_west_din_v(NORTHEAST_OV_io_west_din_v),
    .io_north_dout_r(NORTHEAST_OV_io_north_dout_r),
    .io_east_dout(NORTHEAST_OV_io_east_dout),
    .io_east_dout_v(NORTHEAST_OV_io_east_dout_v),
    .io_east_dout_r(NORTHEAST_OV_io_east_dout_r),
    .io_south_dout(NORTHEAST_OV_io_south_dout),
    .io_south_dout_v(NORTHEAST_OV_io_south_dout_v),
    .io_west_dout_r(NORTHEAST_OV_io_west_dout_r),
    .io_config_bits(NORTHEAST_OV_io_config_bits),
    .io_catch_config(NORTHEAST_OV_io_catch_config)
  );
  ProcessingElement MIDDLEEAST_OV ( // @[OverlayRocc.scala 520:47]
    .clock(MIDDLEEAST_OV_clock),
    .reset(MIDDLEEAST_OV_reset),
    .io_north_din(MIDDLEEAST_OV_io_north_din),
    .io_north_din_v(MIDDLEEAST_OV_io_north_din_v),
    .io_north_din_r(MIDDLEEAST_OV_io_north_din_r),
    .io_east_din_r(MIDDLEEAST_OV_io_east_din_r),
    .io_south_din_r(MIDDLEEAST_OV_io_south_din_r),
    .io_west_din(MIDDLEEAST_OV_io_west_din),
    .io_west_din_v(MIDDLEEAST_OV_io_west_din_v),
    .io_north_dout_r(MIDDLEEAST_OV_io_north_dout_r),
    .io_east_dout(MIDDLEEAST_OV_io_east_dout),
    .io_east_dout_v(MIDDLEEAST_OV_io_east_dout_v),
    .io_east_dout_r(MIDDLEEAST_OV_io_east_dout_r),
    .io_south_dout(MIDDLEEAST_OV_io_south_dout),
    .io_south_dout_v(MIDDLEEAST_OV_io_south_dout_v),
    .io_west_dout_r(MIDDLEEAST_OV_io_west_dout_r),
    .io_config_bits(MIDDLEEAST_OV_io_config_bits),
    .io_catch_config(MIDDLEEAST_OV_io_catch_config)
  );
  ProcessingElement MIDDLEEAST_OV_1 ( // @[OverlayRocc.scala 520:47]
    .clock(MIDDLEEAST_OV_1_clock),
    .reset(MIDDLEEAST_OV_1_reset),
    .io_north_din(MIDDLEEAST_OV_1_io_north_din),
    .io_north_din_v(MIDDLEEAST_OV_1_io_north_din_v),
    .io_north_din_r(MIDDLEEAST_OV_1_io_north_din_r),
    .io_east_din_r(MIDDLEEAST_OV_1_io_east_din_r),
    .io_south_din_r(MIDDLEEAST_OV_1_io_south_din_r),
    .io_west_din(MIDDLEEAST_OV_1_io_west_din),
    .io_west_din_v(MIDDLEEAST_OV_1_io_west_din_v),
    .io_north_dout_r(MIDDLEEAST_OV_1_io_north_dout_r),
    .io_east_dout(MIDDLEEAST_OV_1_io_east_dout),
    .io_east_dout_v(MIDDLEEAST_OV_1_io_east_dout_v),
    .io_east_dout_r(MIDDLEEAST_OV_1_io_east_dout_r),
    .io_south_dout(MIDDLEEAST_OV_1_io_south_dout),
    .io_south_dout_v(MIDDLEEAST_OV_1_io_south_dout_v),
    .io_west_dout_r(MIDDLEEAST_OV_1_io_west_dout_r),
    .io_config_bits(MIDDLEEAST_OV_1_io_config_bits),
    .io_catch_config(MIDDLEEAST_OV_1_io_catch_config)
  );
  ProcessingElement MIDDLEEAST_OV_2 ( // @[OverlayRocc.scala 520:47]
    .clock(MIDDLEEAST_OV_2_clock),
    .reset(MIDDLEEAST_OV_2_reset),
    .io_north_din(MIDDLEEAST_OV_2_io_north_din),
    .io_north_din_v(MIDDLEEAST_OV_2_io_north_din_v),
    .io_north_din_r(MIDDLEEAST_OV_2_io_north_din_r),
    .io_east_din_r(MIDDLEEAST_OV_2_io_east_din_r),
    .io_south_din_r(MIDDLEEAST_OV_2_io_south_din_r),
    .io_west_din(MIDDLEEAST_OV_2_io_west_din),
    .io_west_din_v(MIDDLEEAST_OV_2_io_west_din_v),
    .io_north_dout_r(MIDDLEEAST_OV_2_io_north_dout_r),
    .io_east_dout(MIDDLEEAST_OV_2_io_east_dout),
    .io_east_dout_v(MIDDLEEAST_OV_2_io_east_dout_v),
    .io_east_dout_r(MIDDLEEAST_OV_2_io_east_dout_r),
    .io_south_dout(MIDDLEEAST_OV_2_io_south_dout),
    .io_south_dout_v(MIDDLEEAST_OV_2_io_south_dout_v),
    .io_west_dout_r(MIDDLEEAST_OV_2_io_west_dout_r),
    .io_config_bits(MIDDLEEAST_OV_2_io_config_bits),
    .io_catch_config(MIDDLEEAST_OV_2_io_catch_config)
  );
  ProcessingElement MIDDLEEAST_OV_3 ( // @[OverlayRocc.scala 520:47]
    .clock(MIDDLEEAST_OV_3_clock),
    .reset(MIDDLEEAST_OV_3_reset),
    .io_north_din(MIDDLEEAST_OV_3_io_north_din),
    .io_north_din_v(MIDDLEEAST_OV_3_io_north_din_v),
    .io_north_din_r(MIDDLEEAST_OV_3_io_north_din_r),
    .io_east_din_r(MIDDLEEAST_OV_3_io_east_din_r),
    .io_south_din_r(MIDDLEEAST_OV_3_io_south_din_r),
    .io_west_din(MIDDLEEAST_OV_3_io_west_din),
    .io_west_din_v(MIDDLEEAST_OV_3_io_west_din_v),
    .io_north_dout_r(MIDDLEEAST_OV_3_io_north_dout_r),
    .io_east_dout(MIDDLEEAST_OV_3_io_east_dout),
    .io_east_dout_v(MIDDLEEAST_OV_3_io_east_dout_v),
    .io_east_dout_r(MIDDLEEAST_OV_3_io_east_dout_r),
    .io_south_dout(MIDDLEEAST_OV_3_io_south_dout),
    .io_south_dout_v(MIDDLEEAST_OV_3_io_south_dout_v),
    .io_west_dout_r(MIDDLEEAST_OV_3_io_west_dout_r),
    .io_config_bits(MIDDLEEAST_OV_3_io_config_bits),
    .io_catch_config(MIDDLEEAST_OV_3_io_catch_config)
  );
  ProcessingElement MIDDLEEAST_OV_4 ( // @[OverlayRocc.scala 520:47]
    .clock(MIDDLEEAST_OV_4_clock),
    .reset(MIDDLEEAST_OV_4_reset),
    .io_north_din(MIDDLEEAST_OV_4_io_north_din),
    .io_north_din_v(MIDDLEEAST_OV_4_io_north_din_v),
    .io_north_din_r(MIDDLEEAST_OV_4_io_north_din_r),
    .io_east_din_r(MIDDLEEAST_OV_4_io_east_din_r),
    .io_south_din_r(MIDDLEEAST_OV_4_io_south_din_r),
    .io_west_din(MIDDLEEAST_OV_4_io_west_din),
    .io_west_din_v(MIDDLEEAST_OV_4_io_west_din_v),
    .io_north_dout_r(MIDDLEEAST_OV_4_io_north_dout_r),
    .io_east_dout(MIDDLEEAST_OV_4_io_east_dout),
    .io_east_dout_v(MIDDLEEAST_OV_4_io_east_dout_v),
    .io_east_dout_r(MIDDLEEAST_OV_4_io_east_dout_r),
    .io_south_dout(MIDDLEEAST_OV_4_io_south_dout),
    .io_south_dout_v(MIDDLEEAST_OV_4_io_south_dout_v),
    .io_west_dout_r(MIDDLEEAST_OV_4_io_west_dout_r),
    .io_config_bits(MIDDLEEAST_OV_4_io_config_bits),
    .io_catch_config(MIDDLEEAST_OV_4_io_catch_config)
  );
  ProcessingElement MIDDLEEAST_OV_5 ( // @[OverlayRocc.scala 520:47]
    .clock(MIDDLEEAST_OV_5_clock),
    .reset(MIDDLEEAST_OV_5_reset),
    .io_north_din(MIDDLEEAST_OV_5_io_north_din),
    .io_north_din_v(MIDDLEEAST_OV_5_io_north_din_v),
    .io_north_din_r(MIDDLEEAST_OV_5_io_north_din_r),
    .io_east_din_r(MIDDLEEAST_OV_5_io_east_din_r),
    .io_south_din_r(MIDDLEEAST_OV_5_io_south_din_r),
    .io_west_din(MIDDLEEAST_OV_5_io_west_din),
    .io_west_din_v(MIDDLEEAST_OV_5_io_west_din_v),
    .io_north_dout_r(MIDDLEEAST_OV_5_io_north_dout_r),
    .io_east_dout(MIDDLEEAST_OV_5_io_east_dout),
    .io_east_dout_v(MIDDLEEAST_OV_5_io_east_dout_v),
    .io_east_dout_r(MIDDLEEAST_OV_5_io_east_dout_r),
    .io_south_dout(MIDDLEEAST_OV_5_io_south_dout),
    .io_south_dout_v(MIDDLEEAST_OV_5_io_south_dout_v),
    .io_west_dout_r(MIDDLEEAST_OV_5_io_west_dout_r),
    .io_config_bits(MIDDLEEAST_OV_5_io_config_bits),
    .io_catch_config(MIDDLEEAST_OV_5_io_catch_config)
  );
  ProcessingElement MIDDLESOUTH_OV_6 ( // @[OverlayRocc.scala 569:48]
    .clock(MIDDLESOUTH_OV_6_clock),
    .reset(MIDDLESOUTH_OV_6_reset),
    .io_north_din(MIDDLESOUTH_OV_6_io_north_din),
    .io_north_din_v(MIDDLESOUTH_OV_6_io_north_din_v),
    .io_north_din_r(MIDDLESOUTH_OV_6_io_north_din_r),
    .io_east_din_r(MIDDLESOUTH_OV_6_io_east_din_r),
    .io_south_din_r(MIDDLESOUTH_OV_6_io_south_din_r),
    .io_west_din(MIDDLESOUTH_OV_6_io_west_din),
    .io_west_din_v(MIDDLESOUTH_OV_6_io_west_din_v),
    .io_north_dout_r(MIDDLESOUTH_OV_6_io_north_dout_r),
    .io_east_dout(MIDDLESOUTH_OV_6_io_east_dout),
    .io_east_dout_v(MIDDLESOUTH_OV_6_io_east_dout_v),
    .io_east_dout_r(MIDDLESOUTH_OV_6_io_east_dout_r),
    .io_south_dout(MIDDLESOUTH_OV_6_io_south_dout),
    .io_south_dout_v(MIDDLESOUTH_OV_6_io_south_dout_v),
    .io_west_dout_r(MIDDLESOUTH_OV_6_io_west_dout_r),
    .io_config_bits(MIDDLESOUTH_OV_6_io_config_bits),
    .io_catch_config(MIDDLESOUTH_OV_6_io_catch_config)
  );
  assign io_data_in_ready = {io_data_in_ready_hi,io_data_in_ready_lo}; // @[OverlayRocc.scala 141:37]
  assign io_data_out = {io_data_out_hi,io_data_out_lo}; // @[OverlayRocc.scala 155:33]
  assign io_data_out_valid = {io_data_out_valid_hi,io_data_out_valid_lo}; // @[OverlayRocc.scala 154:38]
  assign NORTHWEST_OV_clock = clock;
  assign NORTHWEST_OV_reset = reset;
  assign NORTHWEST_OV_io_north_din = north_din_0; // @[OverlayRocc.scala 172:47]
  assign NORTHWEST_OV_io_north_din_v = north_din_v[0]; // @[OverlayRocc.scala 173:63]
  assign NORTHWEST_OV_io_west_din = 32'h0; // @[OverlayRocc.scala 187:46]
  assign NORTHWEST_OV_io_west_din_v = 1'h0; // @[OverlayRocc.scala 188:48]
  assign NORTHWEST_OV_io_north_dout_r = 1'h0; // @[OverlayRocc.scala 194:50]
  assign NORTHWEST_OV_io_east_dout_r = 1'h0; // @[OverlayRocc.scala 199:49]
  assign NORTHWEST_OV_io_west_dout_r = 1'h0; // @[OverlayRocc.scala 209:49]
  assign NORTHWEST_OV_io_config_bits = config_bits_0; // @[OverlayRocc.scala 212:49]
  assign NORTHWEST_OV_io_catch_config = catch_config_0[0]; // @[OverlayRocc.scala 213:50]
  assign MIDWEST_OV_clock = clock;
  assign MIDWEST_OV_reset = reset;
  assign MIDWEST_OV_io_north_din = NORTHWEST_OV_io_south_dout; // @[OverlayRocc.scala 221:45]
  assign MIDWEST_OV_io_north_din_v = NORTHWEST_OV_io_south_dout_v; // @[OverlayRocc.scala 222:47]
  assign MIDWEST_OV_io_west_din = 32'h0; // @[OverlayRocc.scala 236:44]
  assign MIDWEST_OV_io_west_din_v = 1'h0; // @[OverlayRocc.scala 237:46]
  assign MIDWEST_OV_io_north_dout_r = NORTHWEST_OV_io_south_din_r; // @[OverlayRocc.scala 243:48]
  assign MIDWEST_OV_io_east_dout_r = 1'h0; // @[OverlayRocc.scala 248:47]
  assign MIDWEST_OV_io_west_dout_r = 1'h0; // @[OverlayRocc.scala 258:47]
  assign MIDWEST_OV_io_config_bits = config_bits_8; // @[OverlayRocc.scala 261:47]
  assign MIDWEST_OV_io_catch_config = catch_config_8[0]; // @[OverlayRocc.scala 262:48]
  assign MIDWEST_OV_1_clock = clock;
  assign MIDWEST_OV_1_reset = reset;
  assign MIDWEST_OV_1_io_north_din = MIDWEST_OV_io_south_dout; // @[OverlayRocc.scala 221:45]
  assign MIDWEST_OV_1_io_north_din_v = MIDWEST_OV_io_south_dout_v; // @[OverlayRocc.scala 222:47]
  assign MIDWEST_OV_1_io_west_din = 32'h0; // @[OverlayRocc.scala 236:44]
  assign MIDWEST_OV_1_io_west_din_v = 1'h0; // @[OverlayRocc.scala 237:46]
  assign MIDWEST_OV_1_io_north_dout_r = MIDWEST_OV_io_south_din_r; // @[OverlayRocc.scala 243:48]
  assign MIDWEST_OV_1_io_east_dout_r = 1'h0; // @[OverlayRocc.scala 248:47]
  assign MIDWEST_OV_1_io_west_dout_r = 1'h0; // @[OverlayRocc.scala 258:47]
  assign MIDWEST_OV_1_io_config_bits = config_bits_16; // @[OverlayRocc.scala 261:47]
  assign MIDWEST_OV_1_io_catch_config = catch_config_16[0]; // @[OverlayRocc.scala 262:48]
  assign MIDWEST_OV_2_clock = clock;
  assign MIDWEST_OV_2_reset = reset;
  assign MIDWEST_OV_2_io_north_din = MIDWEST_OV_1_io_south_dout; // @[OverlayRocc.scala 221:45]
  assign MIDWEST_OV_2_io_north_din_v = MIDWEST_OV_1_io_south_dout_v; // @[OverlayRocc.scala 222:47]
  assign MIDWEST_OV_2_io_west_din = 32'h0; // @[OverlayRocc.scala 236:44]
  assign MIDWEST_OV_2_io_west_din_v = 1'h0; // @[OverlayRocc.scala 237:46]
  assign MIDWEST_OV_2_io_north_dout_r = MIDWEST_OV_1_io_south_din_r; // @[OverlayRocc.scala 243:48]
  assign MIDWEST_OV_2_io_east_dout_r = 1'h0; // @[OverlayRocc.scala 248:47]
  assign MIDWEST_OV_2_io_west_dout_r = 1'h0; // @[OverlayRocc.scala 258:47]
  assign MIDWEST_OV_2_io_config_bits = config_bits_24; // @[OverlayRocc.scala 261:47]
  assign MIDWEST_OV_2_io_catch_config = catch_config_24[0]; // @[OverlayRocc.scala 262:48]
  assign MIDWEST_OV_3_clock = clock;
  assign MIDWEST_OV_3_reset = reset;
  assign MIDWEST_OV_3_io_north_din = MIDWEST_OV_2_io_south_dout; // @[OverlayRocc.scala 221:45]
  assign MIDWEST_OV_3_io_north_din_v = MIDWEST_OV_2_io_south_dout_v; // @[OverlayRocc.scala 222:47]
  assign MIDWEST_OV_3_io_west_din = 32'h0; // @[OverlayRocc.scala 236:44]
  assign MIDWEST_OV_3_io_west_din_v = 1'h0; // @[OverlayRocc.scala 237:46]
  assign MIDWEST_OV_3_io_north_dout_r = MIDWEST_OV_2_io_south_din_r; // @[OverlayRocc.scala 243:48]
  assign MIDWEST_OV_3_io_east_dout_r = 1'h0; // @[OverlayRocc.scala 248:47]
  assign MIDWEST_OV_3_io_west_dout_r = 1'h0; // @[OverlayRocc.scala 258:47]
  assign MIDWEST_OV_3_io_config_bits = config_bits_32; // @[OverlayRocc.scala 261:47]
  assign MIDWEST_OV_3_io_catch_config = catch_config_32[0]; // @[OverlayRocc.scala 262:48]
  assign MIDWEST_OV_4_clock = clock;
  assign MIDWEST_OV_4_reset = reset;
  assign MIDWEST_OV_4_io_north_din = MIDWEST_OV_3_io_south_dout; // @[OverlayRocc.scala 221:45]
  assign MIDWEST_OV_4_io_north_din_v = MIDWEST_OV_3_io_south_dout_v; // @[OverlayRocc.scala 222:47]
  assign MIDWEST_OV_4_io_west_din = 32'h0; // @[OverlayRocc.scala 236:44]
  assign MIDWEST_OV_4_io_west_din_v = 1'h0; // @[OverlayRocc.scala 237:46]
  assign MIDWEST_OV_4_io_north_dout_r = MIDWEST_OV_3_io_south_din_r; // @[OverlayRocc.scala 243:48]
  assign MIDWEST_OV_4_io_east_dout_r = 1'h0; // @[OverlayRocc.scala 248:47]
  assign MIDWEST_OV_4_io_west_dout_r = 1'h0; // @[OverlayRocc.scala 258:47]
  assign MIDWEST_OV_4_io_config_bits = config_bits_40; // @[OverlayRocc.scala 261:47]
  assign MIDWEST_OV_4_io_catch_config = catch_config_40[0]; // @[OverlayRocc.scala 262:48]
  assign MIDWEST_OV_5_clock = clock;
  assign MIDWEST_OV_5_reset = reset;
  assign MIDWEST_OV_5_io_north_din = MIDWEST_OV_4_io_south_dout; // @[OverlayRocc.scala 221:45]
  assign MIDWEST_OV_5_io_north_din_v = MIDWEST_OV_4_io_south_dout_v; // @[OverlayRocc.scala 222:47]
  assign MIDWEST_OV_5_io_west_din = 32'h0; // @[OverlayRocc.scala 236:44]
  assign MIDWEST_OV_5_io_west_din_v = 1'h0; // @[OverlayRocc.scala 237:46]
  assign MIDWEST_OV_5_io_north_dout_r = MIDWEST_OV_4_io_south_din_r; // @[OverlayRocc.scala 243:48]
  assign MIDWEST_OV_5_io_east_dout_r = 1'h0; // @[OverlayRocc.scala 248:47]
  assign MIDWEST_OV_5_io_west_dout_r = 1'h0; // @[OverlayRocc.scala 258:47]
  assign MIDWEST_OV_5_io_config_bits = config_bits_48; // @[OverlayRocc.scala 261:47]
  assign MIDWEST_OV_5_io_catch_config = catch_config_48[0]; // @[OverlayRocc.scala 262:48]
  assign SOUTHWEST_OV_clock = clock;
  assign SOUTHWEST_OV_reset = reset;
  assign SOUTHWEST_OV_io_north_din = MIDWEST_OV_5_io_south_dout; // @[OverlayRocc.scala 270:47]
  assign SOUTHWEST_OV_io_north_din_v = MIDWEST_OV_5_io_south_dout_v; // @[OverlayRocc.scala 271:49]
  assign SOUTHWEST_OV_io_west_din = 32'h0; // @[OverlayRocc.scala 285:46]
  assign SOUTHWEST_OV_io_west_din_v = 1'h0; // @[OverlayRocc.scala 286:48]
  assign SOUTHWEST_OV_io_north_dout_r = MIDWEST_OV_5_io_south_din_r; // @[OverlayRocc.scala 292:50]
  assign SOUTHWEST_OV_io_east_dout_r = 1'h0; // @[OverlayRocc.scala 297:49]
  assign SOUTHWEST_OV_io_west_dout_r = 1'h0; // @[OverlayRocc.scala 307:49]
  assign SOUTHWEST_OV_io_config_bits = config_bits_56; // @[OverlayRocc.scala 310:49]
  assign SOUTHWEST_OV_io_catch_config = catch_config_56[0]; // @[OverlayRocc.scala 311:50]
  assign MIDDLENORTH_OV_clock = clock;
  assign MIDDLENORTH_OV_reset = reset;
  assign MIDDLENORTH_OV_io_north_din = north_din_1; // @[OverlayRocc.scala 323:49]
  assign MIDDLENORTH_OV_io_north_din_v = north_din_v[1]; // @[OverlayRocc.scala 324:65]
  assign MIDDLENORTH_OV_io_west_din = NORTHWEST_OV_io_east_dout; // @[OverlayRocc.scala 338:47]
  assign MIDDLENORTH_OV_io_west_din_v = NORTHWEST_OV_io_east_dout_v; // @[OverlayRocc.scala 339:50]
  assign MIDDLENORTH_OV_io_north_dout_r = 1'h0; // @[OverlayRocc.scala 345:52]
  assign MIDDLENORTH_OV_io_east_dout_r = 1'h0; // @[OverlayRocc.scala 350:51]
  assign MIDDLENORTH_OV_io_west_dout_r = NORTHWEST_OV_io_east_din_r; // @[OverlayRocc.scala 360:51]
  assign MIDDLENORTH_OV_io_config_bits = config_bits_1; // @[OverlayRocc.scala 363:51]
  assign MIDDLENORTH_OV_io_catch_config = catch_config_1[0]; // @[OverlayRocc.scala 364:52]
  assign MIDDLEMIDDLE_OV_clock = clock;
  assign MIDDLEMIDDLE_OV_reset = reset;
  assign MIDDLEMIDDLE_OV_io_north_din = MIDDLENORTH_OV_io_south_dout; // @[OverlayRocc.scala 372:50]
  assign MIDDLEMIDDLE_OV_io_north_din_v = MIDDLENORTH_OV_io_south_dout_v; // @[OverlayRocc.scala 373:52]
  assign MIDDLEMIDDLE_OV_io_west_din = MIDWEST_OV_io_east_dout; // @[OverlayRocc.scala 387:48]
  assign MIDDLEMIDDLE_OV_io_west_din_v = MIDWEST_OV_io_east_dout_v; // @[OverlayRocc.scala 388:51]
  assign MIDDLEMIDDLE_OV_io_north_dout_r = MIDDLENORTH_OV_io_south_din_r; // @[OverlayRocc.scala 394:52]
  assign MIDDLEMIDDLE_OV_io_east_dout_r = 1'h0; // @[OverlayRocc.scala 399:52]
  assign MIDDLEMIDDLE_OV_io_west_dout_r = MIDWEST_OV_io_east_din_r; // @[OverlayRocc.scala 409:52]
  assign MIDDLEMIDDLE_OV_io_config_bits = config_bits_9; // @[OverlayRocc.scala 412:52]
  assign MIDDLEMIDDLE_OV_io_catch_config = catch_config_9[0]; // @[OverlayRocc.scala 413:52]
  assign MIDDLEMIDDLE_OV_1_clock = clock;
  assign MIDDLEMIDDLE_OV_1_reset = reset;
  assign MIDDLEMIDDLE_OV_1_io_north_din = MIDDLEMIDDLE_OV_io_south_dout; // @[OverlayRocc.scala 372:50]
  assign MIDDLEMIDDLE_OV_1_io_north_din_v = MIDDLEMIDDLE_OV_io_south_dout_v; // @[OverlayRocc.scala 373:52]
  assign MIDDLEMIDDLE_OV_1_io_west_din = MIDWEST_OV_1_io_east_dout; // @[OverlayRocc.scala 387:48]
  assign MIDDLEMIDDLE_OV_1_io_west_din_v = MIDWEST_OV_1_io_east_dout_v; // @[OverlayRocc.scala 388:51]
  assign MIDDLEMIDDLE_OV_1_io_north_dout_r = MIDDLEMIDDLE_OV_io_south_din_r; // @[OverlayRocc.scala 394:52]
  assign MIDDLEMIDDLE_OV_1_io_east_dout_r = 1'h0; // @[OverlayRocc.scala 399:52]
  assign MIDDLEMIDDLE_OV_1_io_west_dout_r = MIDWEST_OV_1_io_east_din_r; // @[OverlayRocc.scala 409:52]
  assign MIDDLEMIDDLE_OV_1_io_config_bits = config_bits_17; // @[OverlayRocc.scala 412:52]
  assign MIDDLEMIDDLE_OV_1_io_catch_config = catch_config_17[0]; // @[OverlayRocc.scala 413:52]
  assign MIDDLEMIDDLE_OV_2_clock = clock;
  assign MIDDLEMIDDLE_OV_2_reset = reset;
  assign MIDDLEMIDDLE_OV_2_io_north_din = MIDDLEMIDDLE_OV_1_io_south_dout; // @[OverlayRocc.scala 372:50]
  assign MIDDLEMIDDLE_OV_2_io_north_din_v = MIDDLEMIDDLE_OV_1_io_south_dout_v; // @[OverlayRocc.scala 373:52]
  assign MIDDLEMIDDLE_OV_2_io_west_din = MIDWEST_OV_2_io_east_dout; // @[OverlayRocc.scala 387:48]
  assign MIDDLEMIDDLE_OV_2_io_west_din_v = MIDWEST_OV_2_io_east_dout_v; // @[OverlayRocc.scala 388:51]
  assign MIDDLEMIDDLE_OV_2_io_north_dout_r = MIDDLEMIDDLE_OV_1_io_south_din_r; // @[OverlayRocc.scala 394:52]
  assign MIDDLEMIDDLE_OV_2_io_east_dout_r = 1'h0; // @[OverlayRocc.scala 399:52]
  assign MIDDLEMIDDLE_OV_2_io_west_dout_r = MIDWEST_OV_2_io_east_din_r; // @[OverlayRocc.scala 409:52]
  assign MIDDLEMIDDLE_OV_2_io_config_bits = config_bits_25; // @[OverlayRocc.scala 412:52]
  assign MIDDLEMIDDLE_OV_2_io_catch_config = catch_config_25[0]; // @[OverlayRocc.scala 413:52]
  assign MIDDLEMIDDLE_OV_3_clock = clock;
  assign MIDDLEMIDDLE_OV_3_reset = reset;
  assign MIDDLEMIDDLE_OV_3_io_north_din = MIDDLEMIDDLE_OV_2_io_south_dout; // @[OverlayRocc.scala 372:50]
  assign MIDDLEMIDDLE_OV_3_io_north_din_v = MIDDLEMIDDLE_OV_2_io_south_dout_v; // @[OverlayRocc.scala 373:52]
  assign MIDDLEMIDDLE_OV_3_io_west_din = MIDWEST_OV_3_io_east_dout; // @[OverlayRocc.scala 387:48]
  assign MIDDLEMIDDLE_OV_3_io_west_din_v = MIDWEST_OV_3_io_east_dout_v; // @[OverlayRocc.scala 388:51]
  assign MIDDLEMIDDLE_OV_3_io_north_dout_r = MIDDLEMIDDLE_OV_2_io_south_din_r; // @[OverlayRocc.scala 394:52]
  assign MIDDLEMIDDLE_OV_3_io_east_dout_r = 1'h0; // @[OverlayRocc.scala 399:52]
  assign MIDDLEMIDDLE_OV_3_io_west_dout_r = MIDWEST_OV_3_io_east_din_r; // @[OverlayRocc.scala 409:52]
  assign MIDDLEMIDDLE_OV_3_io_config_bits = config_bits_33; // @[OverlayRocc.scala 412:52]
  assign MIDDLEMIDDLE_OV_3_io_catch_config = catch_config_33[0]; // @[OverlayRocc.scala 413:52]
  assign MIDDLEMIDDLE_OV_4_clock = clock;
  assign MIDDLEMIDDLE_OV_4_reset = reset;
  assign MIDDLEMIDDLE_OV_4_io_north_din = MIDDLEMIDDLE_OV_3_io_south_dout; // @[OverlayRocc.scala 372:50]
  assign MIDDLEMIDDLE_OV_4_io_north_din_v = MIDDLEMIDDLE_OV_3_io_south_dout_v; // @[OverlayRocc.scala 373:52]
  assign MIDDLEMIDDLE_OV_4_io_west_din = MIDWEST_OV_4_io_east_dout; // @[OverlayRocc.scala 387:48]
  assign MIDDLEMIDDLE_OV_4_io_west_din_v = MIDWEST_OV_4_io_east_dout_v; // @[OverlayRocc.scala 388:51]
  assign MIDDLEMIDDLE_OV_4_io_north_dout_r = MIDDLEMIDDLE_OV_3_io_south_din_r; // @[OverlayRocc.scala 394:52]
  assign MIDDLEMIDDLE_OV_4_io_east_dout_r = 1'h0; // @[OverlayRocc.scala 399:52]
  assign MIDDLEMIDDLE_OV_4_io_west_dout_r = MIDWEST_OV_4_io_east_din_r; // @[OverlayRocc.scala 409:52]
  assign MIDDLEMIDDLE_OV_4_io_config_bits = config_bits_41; // @[OverlayRocc.scala 412:52]
  assign MIDDLEMIDDLE_OV_4_io_catch_config = catch_config_41[0]; // @[OverlayRocc.scala 413:52]
  assign MIDDLEMIDDLE_OV_5_clock = clock;
  assign MIDDLEMIDDLE_OV_5_reset = reset;
  assign MIDDLEMIDDLE_OV_5_io_north_din = MIDDLEMIDDLE_OV_4_io_south_dout; // @[OverlayRocc.scala 372:50]
  assign MIDDLEMIDDLE_OV_5_io_north_din_v = MIDDLEMIDDLE_OV_4_io_south_dout_v; // @[OverlayRocc.scala 373:52]
  assign MIDDLEMIDDLE_OV_5_io_west_din = MIDWEST_OV_5_io_east_dout; // @[OverlayRocc.scala 387:48]
  assign MIDDLEMIDDLE_OV_5_io_west_din_v = MIDWEST_OV_5_io_east_dout_v; // @[OverlayRocc.scala 388:51]
  assign MIDDLEMIDDLE_OV_5_io_north_dout_r = MIDDLEMIDDLE_OV_4_io_south_din_r; // @[OverlayRocc.scala 394:52]
  assign MIDDLEMIDDLE_OV_5_io_east_dout_r = 1'h0; // @[OverlayRocc.scala 399:52]
  assign MIDDLEMIDDLE_OV_5_io_west_dout_r = MIDWEST_OV_5_io_east_din_r; // @[OverlayRocc.scala 409:52]
  assign MIDDLEMIDDLE_OV_5_io_config_bits = config_bits_49; // @[OverlayRocc.scala 412:52]
  assign MIDDLEMIDDLE_OV_5_io_catch_config = catch_config_49[0]; // @[OverlayRocc.scala 413:52]
  assign MIDDLESOUTH_OV_clock = clock;
  assign MIDDLESOUTH_OV_reset = reset;
  assign MIDDLESOUTH_OV_io_north_din = MIDDLEMIDDLE_OV_5_io_south_dout; // @[OverlayRocc.scala 421:49]
  assign MIDDLESOUTH_OV_io_north_din_v = MIDDLEMIDDLE_OV_5_io_south_dout_v; // @[OverlayRocc.scala 422:51]
  assign MIDDLESOUTH_OV_io_west_din = SOUTHWEST_OV_io_east_dout; // @[OverlayRocc.scala 436:48]
  assign MIDDLESOUTH_OV_io_west_din_v = SOUTHWEST_OV_io_east_dout_v; // @[OverlayRocc.scala 437:50]
  assign MIDDLESOUTH_OV_io_north_dout_r = MIDDLEMIDDLE_OV_5_io_south_din_r; // @[OverlayRocc.scala 443:52]
  assign MIDDLESOUTH_OV_io_east_dout_r = 1'h0; // @[OverlayRocc.scala 448:51]
  assign MIDDLESOUTH_OV_io_west_dout_r = SOUTHWEST_OV_io_east_din_r; // @[OverlayRocc.scala 458:51]
  assign MIDDLESOUTH_OV_io_config_bits = config_bits_57; // @[OverlayRocc.scala 461:51]
  assign MIDDLESOUTH_OV_io_catch_config = catch_config_57[0]; // @[OverlayRocc.scala 462:52]
  assign MIDDLENORTH_OV_1_clock = clock;
  assign MIDDLENORTH_OV_1_reset = reset;
  assign MIDDLENORTH_OV_1_io_north_din = north_din_2; // @[OverlayRocc.scala 323:49]
  assign MIDDLENORTH_OV_1_io_north_din_v = north_din_v[2]; // @[OverlayRocc.scala 324:65]
  assign MIDDLENORTH_OV_1_io_west_din = MIDDLENORTH_OV_io_east_dout; // @[OverlayRocc.scala 338:47]
  assign MIDDLENORTH_OV_1_io_west_din_v = MIDDLENORTH_OV_io_east_dout_v; // @[OverlayRocc.scala 339:50]
  assign MIDDLENORTH_OV_1_io_north_dout_r = 1'h0; // @[OverlayRocc.scala 345:52]
  assign MIDDLENORTH_OV_1_io_east_dout_r = 1'h0; // @[OverlayRocc.scala 350:51]
  assign MIDDLENORTH_OV_1_io_west_dout_r = MIDDLENORTH_OV_io_east_din_r; // @[OverlayRocc.scala 360:51]
  assign MIDDLENORTH_OV_1_io_config_bits = config_bits_2; // @[OverlayRocc.scala 363:51]
  assign MIDDLENORTH_OV_1_io_catch_config = catch_config_2[0]; // @[OverlayRocc.scala 364:52]
  assign MIDDLEMIDDLE_OV_6_clock = clock;
  assign MIDDLEMIDDLE_OV_6_reset = reset;
  assign MIDDLEMIDDLE_OV_6_io_north_din = MIDDLENORTH_OV_1_io_south_dout; // @[OverlayRocc.scala 372:50]
  assign MIDDLEMIDDLE_OV_6_io_north_din_v = MIDDLENORTH_OV_1_io_south_dout_v; // @[OverlayRocc.scala 373:52]
  assign MIDDLEMIDDLE_OV_6_io_west_din = MIDDLEMIDDLE_OV_io_east_dout; // @[OverlayRocc.scala 387:48]
  assign MIDDLEMIDDLE_OV_6_io_west_din_v = MIDDLEMIDDLE_OV_io_east_dout_v; // @[OverlayRocc.scala 388:51]
  assign MIDDLEMIDDLE_OV_6_io_north_dout_r = MIDDLENORTH_OV_1_io_south_din_r; // @[OverlayRocc.scala 394:52]
  assign MIDDLEMIDDLE_OV_6_io_east_dout_r = 1'h0; // @[OverlayRocc.scala 399:52]
  assign MIDDLEMIDDLE_OV_6_io_west_dout_r = MIDDLEMIDDLE_OV_io_east_din_r; // @[OverlayRocc.scala 409:52]
  assign MIDDLEMIDDLE_OV_6_io_config_bits = config_bits_10; // @[OverlayRocc.scala 412:52]
  assign MIDDLEMIDDLE_OV_6_io_catch_config = catch_config_10[0]; // @[OverlayRocc.scala 413:52]
  assign MIDDLEMIDDLE_OV_7_clock = clock;
  assign MIDDLEMIDDLE_OV_7_reset = reset;
  assign MIDDLEMIDDLE_OV_7_io_north_din = MIDDLEMIDDLE_OV_6_io_south_dout; // @[OverlayRocc.scala 372:50]
  assign MIDDLEMIDDLE_OV_7_io_north_din_v = MIDDLEMIDDLE_OV_6_io_south_dout_v; // @[OverlayRocc.scala 373:52]
  assign MIDDLEMIDDLE_OV_7_io_west_din = MIDDLEMIDDLE_OV_1_io_east_dout; // @[OverlayRocc.scala 387:48]
  assign MIDDLEMIDDLE_OV_7_io_west_din_v = MIDDLEMIDDLE_OV_1_io_east_dout_v; // @[OverlayRocc.scala 388:51]
  assign MIDDLEMIDDLE_OV_7_io_north_dout_r = MIDDLEMIDDLE_OV_6_io_south_din_r; // @[OverlayRocc.scala 394:52]
  assign MIDDLEMIDDLE_OV_7_io_east_dout_r = 1'h0; // @[OverlayRocc.scala 399:52]
  assign MIDDLEMIDDLE_OV_7_io_west_dout_r = MIDDLEMIDDLE_OV_1_io_east_din_r; // @[OverlayRocc.scala 409:52]
  assign MIDDLEMIDDLE_OV_7_io_config_bits = config_bits_18; // @[OverlayRocc.scala 412:52]
  assign MIDDLEMIDDLE_OV_7_io_catch_config = catch_config_18[0]; // @[OverlayRocc.scala 413:52]
  assign MIDDLEMIDDLE_OV_8_clock = clock;
  assign MIDDLEMIDDLE_OV_8_reset = reset;
  assign MIDDLEMIDDLE_OV_8_io_north_din = MIDDLEMIDDLE_OV_7_io_south_dout; // @[OverlayRocc.scala 372:50]
  assign MIDDLEMIDDLE_OV_8_io_north_din_v = MIDDLEMIDDLE_OV_7_io_south_dout_v; // @[OverlayRocc.scala 373:52]
  assign MIDDLEMIDDLE_OV_8_io_west_din = MIDDLEMIDDLE_OV_2_io_east_dout; // @[OverlayRocc.scala 387:48]
  assign MIDDLEMIDDLE_OV_8_io_west_din_v = MIDDLEMIDDLE_OV_2_io_east_dout_v; // @[OverlayRocc.scala 388:51]
  assign MIDDLEMIDDLE_OV_8_io_north_dout_r = MIDDLEMIDDLE_OV_7_io_south_din_r; // @[OverlayRocc.scala 394:52]
  assign MIDDLEMIDDLE_OV_8_io_east_dout_r = 1'h0; // @[OverlayRocc.scala 399:52]
  assign MIDDLEMIDDLE_OV_8_io_west_dout_r = MIDDLEMIDDLE_OV_2_io_east_din_r; // @[OverlayRocc.scala 409:52]
  assign MIDDLEMIDDLE_OV_8_io_config_bits = config_bits_26; // @[OverlayRocc.scala 412:52]
  assign MIDDLEMIDDLE_OV_8_io_catch_config = catch_config_26[0]; // @[OverlayRocc.scala 413:52]
  assign MIDDLEMIDDLE_OV_9_clock = clock;
  assign MIDDLEMIDDLE_OV_9_reset = reset;
  assign MIDDLEMIDDLE_OV_9_io_north_din = MIDDLEMIDDLE_OV_8_io_south_dout; // @[OverlayRocc.scala 372:50]
  assign MIDDLEMIDDLE_OV_9_io_north_din_v = MIDDLEMIDDLE_OV_8_io_south_dout_v; // @[OverlayRocc.scala 373:52]
  assign MIDDLEMIDDLE_OV_9_io_west_din = MIDDLEMIDDLE_OV_3_io_east_dout; // @[OverlayRocc.scala 387:48]
  assign MIDDLEMIDDLE_OV_9_io_west_din_v = MIDDLEMIDDLE_OV_3_io_east_dout_v; // @[OverlayRocc.scala 388:51]
  assign MIDDLEMIDDLE_OV_9_io_north_dout_r = MIDDLEMIDDLE_OV_8_io_south_din_r; // @[OverlayRocc.scala 394:52]
  assign MIDDLEMIDDLE_OV_9_io_east_dout_r = 1'h0; // @[OverlayRocc.scala 399:52]
  assign MIDDLEMIDDLE_OV_9_io_west_dout_r = MIDDLEMIDDLE_OV_3_io_east_din_r; // @[OverlayRocc.scala 409:52]
  assign MIDDLEMIDDLE_OV_9_io_config_bits = config_bits_34; // @[OverlayRocc.scala 412:52]
  assign MIDDLEMIDDLE_OV_9_io_catch_config = catch_config_34[0]; // @[OverlayRocc.scala 413:52]
  assign MIDDLEMIDDLE_OV_10_clock = clock;
  assign MIDDLEMIDDLE_OV_10_reset = reset;
  assign MIDDLEMIDDLE_OV_10_io_north_din = MIDDLEMIDDLE_OV_9_io_south_dout; // @[OverlayRocc.scala 372:50]
  assign MIDDLEMIDDLE_OV_10_io_north_din_v = MIDDLEMIDDLE_OV_9_io_south_dout_v; // @[OverlayRocc.scala 373:52]
  assign MIDDLEMIDDLE_OV_10_io_west_din = MIDDLEMIDDLE_OV_4_io_east_dout; // @[OverlayRocc.scala 387:48]
  assign MIDDLEMIDDLE_OV_10_io_west_din_v = MIDDLEMIDDLE_OV_4_io_east_dout_v; // @[OverlayRocc.scala 388:51]
  assign MIDDLEMIDDLE_OV_10_io_north_dout_r = MIDDLEMIDDLE_OV_9_io_south_din_r; // @[OverlayRocc.scala 394:52]
  assign MIDDLEMIDDLE_OV_10_io_east_dout_r = 1'h0; // @[OverlayRocc.scala 399:52]
  assign MIDDLEMIDDLE_OV_10_io_west_dout_r = MIDDLEMIDDLE_OV_4_io_east_din_r; // @[OverlayRocc.scala 409:52]
  assign MIDDLEMIDDLE_OV_10_io_config_bits = config_bits_42; // @[OverlayRocc.scala 412:52]
  assign MIDDLEMIDDLE_OV_10_io_catch_config = catch_config_42[0]; // @[OverlayRocc.scala 413:52]
  assign MIDDLEMIDDLE_OV_11_clock = clock;
  assign MIDDLEMIDDLE_OV_11_reset = reset;
  assign MIDDLEMIDDLE_OV_11_io_north_din = MIDDLEMIDDLE_OV_10_io_south_dout; // @[OverlayRocc.scala 372:50]
  assign MIDDLEMIDDLE_OV_11_io_north_din_v = MIDDLEMIDDLE_OV_10_io_south_dout_v; // @[OverlayRocc.scala 373:52]
  assign MIDDLEMIDDLE_OV_11_io_west_din = MIDDLEMIDDLE_OV_5_io_east_dout; // @[OverlayRocc.scala 387:48]
  assign MIDDLEMIDDLE_OV_11_io_west_din_v = MIDDLEMIDDLE_OV_5_io_east_dout_v; // @[OverlayRocc.scala 388:51]
  assign MIDDLEMIDDLE_OV_11_io_north_dout_r = MIDDLEMIDDLE_OV_10_io_south_din_r; // @[OverlayRocc.scala 394:52]
  assign MIDDLEMIDDLE_OV_11_io_east_dout_r = 1'h0; // @[OverlayRocc.scala 399:52]
  assign MIDDLEMIDDLE_OV_11_io_west_dout_r = MIDDLEMIDDLE_OV_5_io_east_din_r; // @[OverlayRocc.scala 409:52]
  assign MIDDLEMIDDLE_OV_11_io_config_bits = config_bits_50; // @[OverlayRocc.scala 412:52]
  assign MIDDLEMIDDLE_OV_11_io_catch_config = catch_config_50[0]; // @[OverlayRocc.scala 413:52]
  assign MIDDLESOUTH_OV_1_clock = clock;
  assign MIDDLESOUTH_OV_1_reset = reset;
  assign MIDDLESOUTH_OV_1_io_north_din = MIDDLEMIDDLE_OV_11_io_south_dout; // @[OverlayRocc.scala 421:49]
  assign MIDDLESOUTH_OV_1_io_north_din_v = MIDDLEMIDDLE_OV_11_io_south_dout_v; // @[OverlayRocc.scala 422:51]
  assign MIDDLESOUTH_OV_1_io_west_din = MIDDLESOUTH_OV_io_east_dout; // @[OverlayRocc.scala 436:48]
  assign MIDDLESOUTH_OV_1_io_west_din_v = MIDDLESOUTH_OV_io_east_dout_v; // @[OverlayRocc.scala 437:50]
  assign MIDDLESOUTH_OV_1_io_north_dout_r = MIDDLEMIDDLE_OV_11_io_south_din_r; // @[OverlayRocc.scala 443:52]
  assign MIDDLESOUTH_OV_1_io_east_dout_r = 1'h0; // @[OverlayRocc.scala 448:51]
  assign MIDDLESOUTH_OV_1_io_west_dout_r = MIDDLESOUTH_OV_io_east_din_r; // @[OverlayRocc.scala 458:51]
  assign MIDDLESOUTH_OV_1_io_config_bits = config_bits_58; // @[OverlayRocc.scala 461:51]
  assign MIDDLESOUTH_OV_1_io_catch_config = catch_config_58[0]; // @[OverlayRocc.scala 462:52]
  assign MIDDLENORTH_OV_2_clock = clock;
  assign MIDDLENORTH_OV_2_reset = reset;
  assign MIDDLENORTH_OV_2_io_north_din = north_din_3; // @[OverlayRocc.scala 323:49]
  assign MIDDLENORTH_OV_2_io_north_din_v = north_din_v[3]; // @[OverlayRocc.scala 324:65]
  assign MIDDLENORTH_OV_2_io_west_din = MIDDLENORTH_OV_1_io_east_dout; // @[OverlayRocc.scala 338:47]
  assign MIDDLENORTH_OV_2_io_west_din_v = MIDDLENORTH_OV_1_io_east_dout_v; // @[OverlayRocc.scala 339:50]
  assign MIDDLENORTH_OV_2_io_north_dout_r = 1'h0; // @[OverlayRocc.scala 345:52]
  assign MIDDLENORTH_OV_2_io_east_dout_r = 1'h0; // @[OverlayRocc.scala 350:51]
  assign MIDDLENORTH_OV_2_io_west_dout_r = MIDDLENORTH_OV_1_io_east_din_r; // @[OverlayRocc.scala 360:51]
  assign MIDDLENORTH_OV_2_io_config_bits = config_bits_3; // @[OverlayRocc.scala 363:51]
  assign MIDDLENORTH_OV_2_io_catch_config = catch_config_3[0]; // @[OverlayRocc.scala 364:52]
  assign MIDDLEMIDDLE_OV_12_clock = clock;
  assign MIDDLEMIDDLE_OV_12_reset = reset;
  assign MIDDLEMIDDLE_OV_12_io_north_din = MIDDLENORTH_OV_2_io_south_dout; // @[OverlayRocc.scala 372:50]
  assign MIDDLEMIDDLE_OV_12_io_north_din_v = MIDDLENORTH_OV_2_io_south_dout_v; // @[OverlayRocc.scala 373:52]
  assign MIDDLEMIDDLE_OV_12_io_west_din = MIDDLEMIDDLE_OV_6_io_east_dout; // @[OverlayRocc.scala 387:48]
  assign MIDDLEMIDDLE_OV_12_io_west_din_v = MIDDLEMIDDLE_OV_6_io_east_dout_v; // @[OverlayRocc.scala 388:51]
  assign MIDDLEMIDDLE_OV_12_io_north_dout_r = MIDDLENORTH_OV_2_io_south_din_r; // @[OverlayRocc.scala 394:52]
  assign MIDDLEMIDDLE_OV_12_io_east_dout_r = 1'h0; // @[OverlayRocc.scala 399:52]
  assign MIDDLEMIDDLE_OV_12_io_west_dout_r = MIDDLEMIDDLE_OV_6_io_east_din_r; // @[OverlayRocc.scala 409:52]
  assign MIDDLEMIDDLE_OV_12_io_config_bits = config_bits_11; // @[OverlayRocc.scala 412:52]
  assign MIDDLEMIDDLE_OV_12_io_catch_config = catch_config_11[0]; // @[OverlayRocc.scala 413:52]
  assign MIDDLEMIDDLE_OV_13_clock = clock;
  assign MIDDLEMIDDLE_OV_13_reset = reset;
  assign MIDDLEMIDDLE_OV_13_io_north_din = MIDDLEMIDDLE_OV_12_io_south_dout; // @[OverlayRocc.scala 372:50]
  assign MIDDLEMIDDLE_OV_13_io_north_din_v = MIDDLEMIDDLE_OV_12_io_south_dout_v; // @[OverlayRocc.scala 373:52]
  assign MIDDLEMIDDLE_OV_13_io_west_din = MIDDLEMIDDLE_OV_7_io_east_dout; // @[OverlayRocc.scala 387:48]
  assign MIDDLEMIDDLE_OV_13_io_west_din_v = MIDDLEMIDDLE_OV_7_io_east_dout_v; // @[OverlayRocc.scala 388:51]
  assign MIDDLEMIDDLE_OV_13_io_north_dout_r = MIDDLEMIDDLE_OV_12_io_south_din_r; // @[OverlayRocc.scala 394:52]
  assign MIDDLEMIDDLE_OV_13_io_east_dout_r = 1'h0; // @[OverlayRocc.scala 399:52]
  assign MIDDLEMIDDLE_OV_13_io_west_dout_r = MIDDLEMIDDLE_OV_7_io_east_din_r; // @[OverlayRocc.scala 409:52]
  assign MIDDLEMIDDLE_OV_13_io_config_bits = config_bits_19; // @[OverlayRocc.scala 412:52]
  assign MIDDLEMIDDLE_OV_13_io_catch_config = catch_config_19[0]; // @[OverlayRocc.scala 413:52]
  assign MIDDLEMIDDLE_OV_14_clock = clock;
  assign MIDDLEMIDDLE_OV_14_reset = reset;
  assign MIDDLEMIDDLE_OV_14_io_north_din = MIDDLEMIDDLE_OV_13_io_south_dout; // @[OverlayRocc.scala 372:50]
  assign MIDDLEMIDDLE_OV_14_io_north_din_v = MIDDLEMIDDLE_OV_13_io_south_dout_v; // @[OverlayRocc.scala 373:52]
  assign MIDDLEMIDDLE_OV_14_io_west_din = MIDDLEMIDDLE_OV_8_io_east_dout; // @[OverlayRocc.scala 387:48]
  assign MIDDLEMIDDLE_OV_14_io_west_din_v = MIDDLEMIDDLE_OV_8_io_east_dout_v; // @[OverlayRocc.scala 388:51]
  assign MIDDLEMIDDLE_OV_14_io_north_dout_r = MIDDLEMIDDLE_OV_13_io_south_din_r; // @[OverlayRocc.scala 394:52]
  assign MIDDLEMIDDLE_OV_14_io_east_dout_r = 1'h0; // @[OverlayRocc.scala 399:52]
  assign MIDDLEMIDDLE_OV_14_io_west_dout_r = MIDDLEMIDDLE_OV_8_io_east_din_r; // @[OverlayRocc.scala 409:52]
  assign MIDDLEMIDDLE_OV_14_io_config_bits = config_bits_27; // @[OverlayRocc.scala 412:52]
  assign MIDDLEMIDDLE_OV_14_io_catch_config = catch_config_27[0]; // @[OverlayRocc.scala 413:52]
  assign MIDDLEMIDDLE_OV_15_clock = clock;
  assign MIDDLEMIDDLE_OV_15_reset = reset;
  assign MIDDLEMIDDLE_OV_15_io_north_din = MIDDLEMIDDLE_OV_14_io_south_dout; // @[OverlayRocc.scala 372:50]
  assign MIDDLEMIDDLE_OV_15_io_north_din_v = MIDDLEMIDDLE_OV_14_io_south_dout_v; // @[OverlayRocc.scala 373:52]
  assign MIDDLEMIDDLE_OV_15_io_west_din = MIDDLEMIDDLE_OV_9_io_east_dout; // @[OverlayRocc.scala 387:48]
  assign MIDDLEMIDDLE_OV_15_io_west_din_v = MIDDLEMIDDLE_OV_9_io_east_dout_v; // @[OverlayRocc.scala 388:51]
  assign MIDDLEMIDDLE_OV_15_io_north_dout_r = MIDDLEMIDDLE_OV_14_io_south_din_r; // @[OverlayRocc.scala 394:52]
  assign MIDDLEMIDDLE_OV_15_io_east_dout_r = 1'h0; // @[OverlayRocc.scala 399:52]
  assign MIDDLEMIDDLE_OV_15_io_west_dout_r = MIDDLEMIDDLE_OV_9_io_east_din_r; // @[OverlayRocc.scala 409:52]
  assign MIDDLEMIDDLE_OV_15_io_config_bits = config_bits_35; // @[OverlayRocc.scala 412:52]
  assign MIDDLEMIDDLE_OV_15_io_catch_config = catch_config_35[0]; // @[OverlayRocc.scala 413:52]
  assign MIDDLEMIDDLE_OV_16_clock = clock;
  assign MIDDLEMIDDLE_OV_16_reset = reset;
  assign MIDDLEMIDDLE_OV_16_io_north_din = MIDDLEMIDDLE_OV_15_io_south_dout; // @[OverlayRocc.scala 372:50]
  assign MIDDLEMIDDLE_OV_16_io_north_din_v = MIDDLEMIDDLE_OV_15_io_south_dout_v; // @[OverlayRocc.scala 373:52]
  assign MIDDLEMIDDLE_OV_16_io_west_din = MIDDLEMIDDLE_OV_10_io_east_dout; // @[OverlayRocc.scala 387:48]
  assign MIDDLEMIDDLE_OV_16_io_west_din_v = MIDDLEMIDDLE_OV_10_io_east_dout_v; // @[OverlayRocc.scala 388:51]
  assign MIDDLEMIDDLE_OV_16_io_north_dout_r = MIDDLEMIDDLE_OV_15_io_south_din_r; // @[OverlayRocc.scala 394:52]
  assign MIDDLEMIDDLE_OV_16_io_east_dout_r = 1'h0; // @[OverlayRocc.scala 399:52]
  assign MIDDLEMIDDLE_OV_16_io_west_dout_r = MIDDLEMIDDLE_OV_10_io_east_din_r; // @[OverlayRocc.scala 409:52]
  assign MIDDLEMIDDLE_OV_16_io_config_bits = config_bits_43; // @[OverlayRocc.scala 412:52]
  assign MIDDLEMIDDLE_OV_16_io_catch_config = catch_config_43[0]; // @[OverlayRocc.scala 413:52]
  assign MIDDLEMIDDLE_OV_17_clock = clock;
  assign MIDDLEMIDDLE_OV_17_reset = reset;
  assign MIDDLEMIDDLE_OV_17_io_north_din = MIDDLEMIDDLE_OV_16_io_south_dout; // @[OverlayRocc.scala 372:50]
  assign MIDDLEMIDDLE_OV_17_io_north_din_v = MIDDLEMIDDLE_OV_16_io_south_dout_v; // @[OverlayRocc.scala 373:52]
  assign MIDDLEMIDDLE_OV_17_io_west_din = MIDDLEMIDDLE_OV_11_io_east_dout; // @[OverlayRocc.scala 387:48]
  assign MIDDLEMIDDLE_OV_17_io_west_din_v = MIDDLEMIDDLE_OV_11_io_east_dout_v; // @[OverlayRocc.scala 388:51]
  assign MIDDLEMIDDLE_OV_17_io_north_dout_r = MIDDLEMIDDLE_OV_16_io_south_din_r; // @[OverlayRocc.scala 394:52]
  assign MIDDLEMIDDLE_OV_17_io_east_dout_r = 1'h0; // @[OverlayRocc.scala 399:52]
  assign MIDDLEMIDDLE_OV_17_io_west_dout_r = MIDDLEMIDDLE_OV_11_io_east_din_r; // @[OverlayRocc.scala 409:52]
  assign MIDDLEMIDDLE_OV_17_io_config_bits = config_bits_51; // @[OverlayRocc.scala 412:52]
  assign MIDDLEMIDDLE_OV_17_io_catch_config = catch_config_51[0]; // @[OverlayRocc.scala 413:52]
  assign MIDDLESOUTH_OV_2_clock = clock;
  assign MIDDLESOUTH_OV_2_reset = reset;
  assign MIDDLESOUTH_OV_2_io_north_din = MIDDLEMIDDLE_OV_17_io_south_dout; // @[OverlayRocc.scala 421:49]
  assign MIDDLESOUTH_OV_2_io_north_din_v = MIDDLEMIDDLE_OV_17_io_south_dout_v; // @[OverlayRocc.scala 422:51]
  assign MIDDLESOUTH_OV_2_io_west_din = MIDDLESOUTH_OV_1_io_east_dout; // @[OverlayRocc.scala 436:48]
  assign MIDDLESOUTH_OV_2_io_west_din_v = MIDDLESOUTH_OV_1_io_east_dout_v; // @[OverlayRocc.scala 437:50]
  assign MIDDLESOUTH_OV_2_io_north_dout_r = MIDDLEMIDDLE_OV_17_io_south_din_r; // @[OverlayRocc.scala 443:52]
  assign MIDDLESOUTH_OV_2_io_east_dout_r = 1'h0; // @[OverlayRocc.scala 448:51]
  assign MIDDLESOUTH_OV_2_io_west_dout_r = MIDDLESOUTH_OV_1_io_east_din_r; // @[OverlayRocc.scala 458:51]
  assign MIDDLESOUTH_OV_2_io_config_bits = config_bits_59; // @[OverlayRocc.scala 461:51]
  assign MIDDLESOUTH_OV_2_io_catch_config = catch_config_59[0]; // @[OverlayRocc.scala 462:52]
  assign MIDDLENORTH_OV_3_clock = clock;
  assign MIDDLENORTH_OV_3_reset = reset;
  assign MIDDLENORTH_OV_3_io_north_din = north_din_4; // @[OverlayRocc.scala 323:49]
  assign MIDDLENORTH_OV_3_io_north_din_v = north_din_v[4]; // @[OverlayRocc.scala 324:65]
  assign MIDDLENORTH_OV_3_io_west_din = MIDDLENORTH_OV_2_io_east_dout; // @[OverlayRocc.scala 338:47]
  assign MIDDLENORTH_OV_3_io_west_din_v = MIDDLENORTH_OV_2_io_east_dout_v; // @[OverlayRocc.scala 339:50]
  assign MIDDLENORTH_OV_3_io_north_dout_r = 1'h0; // @[OverlayRocc.scala 345:52]
  assign MIDDLENORTH_OV_3_io_east_dout_r = 1'h0; // @[OverlayRocc.scala 350:51]
  assign MIDDLENORTH_OV_3_io_west_dout_r = MIDDLENORTH_OV_2_io_east_din_r; // @[OverlayRocc.scala 360:51]
  assign MIDDLENORTH_OV_3_io_config_bits = config_bits_4; // @[OverlayRocc.scala 363:51]
  assign MIDDLENORTH_OV_3_io_catch_config = catch_config_4[0]; // @[OverlayRocc.scala 364:52]
  assign MIDDLEMIDDLE_OV_18_clock = clock;
  assign MIDDLEMIDDLE_OV_18_reset = reset;
  assign MIDDLEMIDDLE_OV_18_io_north_din = MIDDLENORTH_OV_3_io_south_dout; // @[OverlayRocc.scala 372:50]
  assign MIDDLEMIDDLE_OV_18_io_north_din_v = MIDDLENORTH_OV_3_io_south_dout_v; // @[OverlayRocc.scala 373:52]
  assign MIDDLEMIDDLE_OV_18_io_west_din = MIDDLEMIDDLE_OV_12_io_east_dout; // @[OverlayRocc.scala 387:48]
  assign MIDDLEMIDDLE_OV_18_io_west_din_v = MIDDLEMIDDLE_OV_12_io_east_dout_v; // @[OverlayRocc.scala 388:51]
  assign MIDDLEMIDDLE_OV_18_io_north_dout_r = MIDDLENORTH_OV_3_io_south_din_r; // @[OverlayRocc.scala 394:52]
  assign MIDDLEMIDDLE_OV_18_io_east_dout_r = 1'h0; // @[OverlayRocc.scala 399:52]
  assign MIDDLEMIDDLE_OV_18_io_west_dout_r = MIDDLEMIDDLE_OV_12_io_east_din_r; // @[OverlayRocc.scala 409:52]
  assign MIDDLEMIDDLE_OV_18_io_config_bits = config_bits_12; // @[OverlayRocc.scala 412:52]
  assign MIDDLEMIDDLE_OV_18_io_catch_config = catch_config_12[0]; // @[OverlayRocc.scala 413:52]
  assign MIDDLEMIDDLE_OV_19_clock = clock;
  assign MIDDLEMIDDLE_OV_19_reset = reset;
  assign MIDDLEMIDDLE_OV_19_io_north_din = MIDDLEMIDDLE_OV_18_io_south_dout; // @[OverlayRocc.scala 372:50]
  assign MIDDLEMIDDLE_OV_19_io_north_din_v = MIDDLEMIDDLE_OV_18_io_south_dout_v; // @[OverlayRocc.scala 373:52]
  assign MIDDLEMIDDLE_OV_19_io_west_din = MIDDLEMIDDLE_OV_13_io_east_dout; // @[OverlayRocc.scala 387:48]
  assign MIDDLEMIDDLE_OV_19_io_west_din_v = MIDDLEMIDDLE_OV_13_io_east_dout_v; // @[OverlayRocc.scala 388:51]
  assign MIDDLEMIDDLE_OV_19_io_north_dout_r = MIDDLEMIDDLE_OV_18_io_south_din_r; // @[OverlayRocc.scala 394:52]
  assign MIDDLEMIDDLE_OV_19_io_east_dout_r = 1'h0; // @[OverlayRocc.scala 399:52]
  assign MIDDLEMIDDLE_OV_19_io_west_dout_r = MIDDLEMIDDLE_OV_13_io_east_din_r; // @[OverlayRocc.scala 409:52]
  assign MIDDLEMIDDLE_OV_19_io_config_bits = config_bits_20; // @[OverlayRocc.scala 412:52]
  assign MIDDLEMIDDLE_OV_19_io_catch_config = catch_config_20[0]; // @[OverlayRocc.scala 413:52]
  assign MIDDLEMIDDLE_OV_20_clock = clock;
  assign MIDDLEMIDDLE_OV_20_reset = reset;
  assign MIDDLEMIDDLE_OV_20_io_north_din = MIDDLEMIDDLE_OV_19_io_south_dout; // @[OverlayRocc.scala 372:50]
  assign MIDDLEMIDDLE_OV_20_io_north_din_v = MIDDLEMIDDLE_OV_19_io_south_dout_v; // @[OverlayRocc.scala 373:52]
  assign MIDDLEMIDDLE_OV_20_io_west_din = MIDDLEMIDDLE_OV_14_io_east_dout; // @[OverlayRocc.scala 387:48]
  assign MIDDLEMIDDLE_OV_20_io_west_din_v = MIDDLEMIDDLE_OV_14_io_east_dout_v; // @[OverlayRocc.scala 388:51]
  assign MIDDLEMIDDLE_OV_20_io_north_dout_r = MIDDLEMIDDLE_OV_19_io_south_din_r; // @[OverlayRocc.scala 394:52]
  assign MIDDLEMIDDLE_OV_20_io_east_dout_r = 1'h0; // @[OverlayRocc.scala 399:52]
  assign MIDDLEMIDDLE_OV_20_io_west_dout_r = MIDDLEMIDDLE_OV_14_io_east_din_r; // @[OverlayRocc.scala 409:52]
  assign MIDDLEMIDDLE_OV_20_io_config_bits = config_bits_28; // @[OverlayRocc.scala 412:52]
  assign MIDDLEMIDDLE_OV_20_io_catch_config = catch_config_28[0]; // @[OverlayRocc.scala 413:52]
  assign MIDDLEMIDDLE_OV_21_clock = clock;
  assign MIDDLEMIDDLE_OV_21_reset = reset;
  assign MIDDLEMIDDLE_OV_21_io_north_din = MIDDLEMIDDLE_OV_20_io_south_dout; // @[OverlayRocc.scala 372:50]
  assign MIDDLEMIDDLE_OV_21_io_north_din_v = MIDDLEMIDDLE_OV_20_io_south_dout_v; // @[OverlayRocc.scala 373:52]
  assign MIDDLEMIDDLE_OV_21_io_west_din = MIDDLEMIDDLE_OV_15_io_east_dout; // @[OverlayRocc.scala 387:48]
  assign MIDDLEMIDDLE_OV_21_io_west_din_v = MIDDLEMIDDLE_OV_15_io_east_dout_v; // @[OverlayRocc.scala 388:51]
  assign MIDDLEMIDDLE_OV_21_io_north_dout_r = MIDDLEMIDDLE_OV_20_io_south_din_r; // @[OverlayRocc.scala 394:52]
  assign MIDDLEMIDDLE_OV_21_io_east_dout_r = 1'h0; // @[OverlayRocc.scala 399:52]
  assign MIDDLEMIDDLE_OV_21_io_west_dout_r = MIDDLEMIDDLE_OV_15_io_east_din_r; // @[OverlayRocc.scala 409:52]
  assign MIDDLEMIDDLE_OV_21_io_config_bits = config_bits_36; // @[OverlayRocc.scala 412:52]
  assign MIDDLEMIDDLE_OV_21_io_catch_config = catch_config_36[0]; // @[OverlayRocc.scala 413:52]
  assign MIDDLEMIDDLE_OV_22_clock = clock;
  assign MIDDLEMIDDLE_OV_22_reset = reset;
  assign MIDDLEMIDDLE_OV_22_io_north_din = MIDDLEMIDDLE_OV_21_io_south_dout; // @[OverlayRocc.scala 372:50]
  assign MIDDLEMIDDLE_OV_22_io_north_din_v = MIDDLEMIDDLE_OV_21_io_south_dout_v; // @[OverlayRocc.scala 373:52]
  assign MIDDLEMIDDLE_OV_22_io_west_din = MIDDLEMIDDLE_OV_16_io_east_dout; // @[OverlayRocc.scala 387:48]
  assign MIDDLEMIDDLE_OV_22_io_west_din_v = MIDDLEMIDDLE_OV_16_io_east_dout_v; // @[OverlayRocc.scala 388:51]
  assign MIDDLEMIDDLE_OV_22_io_north_dout_r = MIDDLEMIDDLE_OV_21_io_south_din_r; // @[OverlayRocc.scala 394:52]
  assign MIDDLEMIDDLE_OV_22_io_east_dout_r = 1'h0; // @[OverlayRocc.scala 399:52]
  assign MIDDLEMIDDLE_OV_22_io_west_dout_r = MIDDLEMIDDLE_OV_16_io_east_din_r; // @[OverlayRocc.scala 409:52]
  assign MIDDLEMIDDLE_OV_22_io_config_bits = config_bits_44; // @[OverlayRocc.scala 412:52]
  assign MIDDLEMIDDLE_OV_22_io_catch_config = catch_config_44[0]; // @[OverlayRocc.scala 413:52]
  assign MIDDLEMIDDLE_OV_23_clock = clock;
  assign MIDDLEMIDDLE_OV_23_reset = reset;
  assign MIDDLEMIDDLE_OV_23_io_north_din = MIDDLEMIDDLE_OV_22_io_south_dout; // @[OverlayRocc.scala 372:50]
  assign MIDDLEMIDDLE_OV_23_io_north_din_v = MIDDLEMIDDLE_OV_22_io_south_dout_v; // @[OverlayRocc.scala 373:52]
  assign MIDDLEMIDDLE_OV_23_io_west_din = MIDDLEMIDDLE_OV_17_io_east_dout; // @[OverlayRocc.scala 387:48]
  assign MIDDLEMIDDLE_OV_23_io_west_din_v = MIDDLEMIDDLE_OV_17_io_east_dout_v; // @[OverlayRocc.scala 388:51]
  assign MIDDLEMIDDLE_OV_23_io_north_dout_r = MIDDLEMIDDLE_OV_22_io_south_din_r; // @[OverlayRocc.scala 394:52]
  assign MIDDLEMIDDLE_OV_23_io_east_dout_r = 1'h0; // @[OverlayRocc.scala 399:52]
  assign MIDDLEMIDDLE_OV_23_io_west_dout_r = MIDDLEMIDDLE_OV_17_io_east_din_r; // @[OverlayRocc.scala 409:52]
  assign MIDDLEMIDDLE_OV_23_io_config_bits = config_bits_52; // @[OverlayRocc.scala 412:52]
  assign MIDDLEMIDDLE_OV_23_io_catch_config = catch_config_52[0]; // @[OverlayRocc.scala 413:52]
  assign MIDDLESOUTH_OV_3_clock = clock;
  assign MIDDLESOUTH_OV_3_reset = reset;
  assign MIDDLESOUTH_OV_3_io_north_din = MIDDLEMIDDLE_OV_23_io_south_dout; // @[OverlayRocc.scala 421:49]
  assign MIDDLESOUTH_OV_3_io_north_din_v = MIDDLEMIDDLE_OV_23_io_south_dout_v; // @[OverlayRocc.scala 422:51]
  assign MIDDLESOUTH_OV_3_io_west_din = MIDDLESOUTH_OV_2_io_east_dout; // @[OverlayRocc.scala 436:48]
  assign MIDDLESOUTH_OV_3_io_west_din_v = MIDDLESOUTH_OV_2_io_east_dout_v; // @[OverlayRocc.scala 437:50]
  assign MIDDLESOUTH_OV_3_io_north_dout_r = MIDDLEMIDDLE_OV_23_io_south_din_r; // @[OverlayRocc.scala 443:52]
  assign MIDDLESOUTH_OV_3_io_east_dout_r = 1'h0; // @[OverlayRocc.scala 448:51]
  assign MIDDLESOUTH_OV_3_io_west_dout_r = MIDDLESOUTH_OV_2_io_east_din_r; // @[OverlayRocc.scala 458:51]
  assign MIDDLESOUTH_OV_3_io_config_bits = config_bits_60; // @[OverlayRocc.scala 461:51]
  assign MIDDLESOUTH_OV_3_io_catch_config = catch_config_60[0]; // @[OverlayRocc.scala 462:52]
  assign MIDDLENORTH_OV_4_clock = clock;
  assign MIDDLENORTH_OV_4_reset = reset;
  assign MIDDLENORTH_OV_4_io_north_din = north_din_5; // @[OverlayRocc.scala 323:49]
  assign MIDDLENORTH_OV_4_io_north_din_v = north_din_v[5]; // @[OverlayRocc.scala 324:65]
  assign MIDDLENORTH_OV_4_io_west_din = MIDDLENORTH_OV_3_io_east_dout; // @[OverlayRocc.scala 338:47]
  assign MIDDLENORTH_OV_4_io_west_din_v = MIDDLENORTH_OV_3_io_east_dout_v; // @[OverlayRocc.scala 339:50]
  assign MIDDLENORTH_OV_4_io_north_dout_r = 1'h0; // @[OverlayRocc.scala 345:52]
  assign MIDDLENORTH_OV_4_io_east_dout_r = 1'h0; // @[OverlayRocc.scala 350:51]
  assign MIDDLENORTH_OV_4_io_west_dout_r = MIDDLENORTH_OV_3_io_east_din_r; // @[OverlayRocc.scala 360:51]
  assign MIDDLENORTH_OV_4_io_config_bits = config_bits_5; // @[OverlayRocc.scala 363:51]
  assign MIDDLENORTH_OV_4_io_catch_config = catch_config_5[0]; // @[OverlayRocc.scala 364:52]
  assign MIDDLEMIDDLE_OV_24_clock = clock;
  assign MIDDLEMIDDLE_OV_24_reset = reset;
  assign MIDDLEMIDDLE_OV_24_io_north_din = MIDDLENORTH_OV_4_io_south_dout; // @[OverlayRocc.scala 372:50]
  assign MIDDLEMIDDLE_OV_24_io_north_din_v = MIDDLENORTH_OV_4_io_south_dout_v; // @[OverlayRocc.scala 373:52]
  assign MIDDLEMIDDLE_OV_24_io_west_din = MIDDLEMIDDLE_OV_18_io_east_dout; // @[OverlayRocc.scala 387:48]
  assign MIDDLEMIDDLE_OV_24_io_west_din_v = MIDDLEMIDDLE_OV_18_io_east_dout_v; // @[OverlayRocc.scala 388:51]
  assign MIDDLEMIDDLE_OV_24_io_north_dout_r = MIDDLENORTH_OV_4_io_south_din_r; // @[OverlayRocc.scala 394:52]
  assign MIDDLEMIDDLE_OV_24_io_east_dout_r = 1'h0; // @[OverlayRocc.scala 399:52]
  assign MIDDLEMIDDLE_OV_24_io_west_dout_r = MIDDLEMIDDLE_OV_18_io_east_din_r; // @[OverlayRocc.scala 409:52]
  assign MIDDLEMIDDLE_OV_24_io_config_bits = config_bits_13; // @[OverlayRocc.scala 412:52]
  assign MIDDLEMIDDLE_OV_24_io_catch_config = catch_config_13[0]; // @[OverlayRocc.scala 413:52]
  assign MIDDLEMIDDLE_OV_25_clock = clock;
  assign MIDDLEMIDDLE_OV_25_reset = reset;
  assign MIDDLEMIDDLE_OV_25_io_north_din = MIDDLEMIDDLE_OV_24_io_south_dout; // @[OverlayRocc.scala 372:50]
  assign MIDDLEMIDDLE_OV_25_io_north_din_v = MIDDLEMIDDLE_OV_24_io_south_dout_v; // @[OverlayRocc.scala 373:52]
  assign MIDDLEMIDDLE_OV_25_io_west_din = MIDDLEMIDDLE_OV_19_io_east_dout; // @[OverlayRocc.scala 387:48]
  assign MIDDLEMIDDLE_OV_25_io_west_din_v = MIDDLEMIDDLE_OV_19_io_east_dout_v; // @[OverlayRocc.scala 388:51]
  assign MIDDLEMIDDLE_OV_25_io_north_dout_r = MIDDLEMIDDLE_OV_24_io_south_din_r; // @[OverlayRocc.scala 394:52]
  assign MIDDLEMIDDLE_OV_25_io_east_dout_r = 1'h0; // @[OverlayRocc.scala 399:52]
  assign MIDDLEMIDDLE_OV_25_io_west_dout_r = MIDDLEMIDDLE_OV_19_io_east_din_r; // @[OverlayRocc.scala 409:52]
  assign MIDDLEMIDDLE_OV_25_io_config_bits = config_bits_21; // @[OverlayRocc.scala 412:52]
  assign MIDDLEMIDDLE_OV_25_io_catch_config = catch_config_21[0]; // @[OverlayRocc.scala 413:52]
  assign MIDDLEMIDDLE_OV_26_clock = clock;
  assign MIDDLEMIDDLE_OV_26_reset = reset;
  assign MIDDLEMIDDLE_OV_26_io_north_din = MIDDLEMIDDLE_OV_25_io_south_dout; // @[OverlayRocc.scala 372:50]
  assign MIDDLEMIDDLE_OV_26_io_north_din_v = MIDDLEMIDDLE_OV_25_io_south_dout_v; // @[OverlayRocc.scala 373:52]
  assign MIDDLEMIDDLE_OV_26_io_west_din = MIDDLEMIDDLE_OV_20_io_east_dout; // @[OverlayRocc.scala 387:48]
  assign MIDDLEMIDDLE_OV_26_io_west_din_v = MIDDLEMIDDLE_OV_20_io_east_dout_v; // @[OverlayRocc.scala 388:51]
  assign MIDDLEMIDDLE_OV_26_io_north_dout_r = MIDDLEMIDDLE_OV_25_io_south_din_r; // @[OverlayRocc.scala 394:52]
  assign MIDDLEMIDDLE_OV_26_io_east_dout_r = 1'h0; // @[OverlayRocc.scala 399:52]
  assign MIDDLEMIDDLE_OV_26_io_west_dout_r = MIDDLEMIDDLE_OV_20_io_east_din_r; // @[OverlayRocc.scala 409:52]
  assign MIDDLEMIDDLE_OV_26_io_config_bits = config_bits_29; // @[OverlayRocc.scala 412:52]
  assign MIDDLEMIDDLE_OV_26_io_catch_config = catch_config_29[0]; // @[OverlayRocc.scala 413:52]
  assign MIDDLEMIDDLE_OV_27_clock = clock;
  assign MIDDLEMIDDLE_OV_27_reset = reset;
  assign MIDDLEMIDDLE_OV_27_io_north_din = MIDDLEMIDDLE_OV_26_io_south_dout; // @[OverlayRocc.scala 372:50]
  assign MIDDLEMIDDLE_OV_27_io_north_din_v = MIDDLEMIDDLE_OV_26_io_south_dout_v; // @[OverlayRocc.scala 373:52]
  assign MIDDLEMIDDLE_OV_27_io_west_din = MIDDLEMIDDLE_OV_21_io_east_dout; // @[OverlayRocc.scala 387:48]
  assign MIDDLEMIDDLE_OV_27_io_west_din_v = MIDDLEMIDDLE_OV_21_io_east_dout_v; // @[OverlayRocc.scala 388:51]
  assign MIDDLEMIDDLE_OV_27_io_north_dout_r = MIDDLEMIDDLE_OV_26_io_south_din_r; // @[OverlayRocc.scala 394:52]
  assign MIDDLEMIDDLE_OV_27_io_east_dout_r = 1'h0; // @[OverlayRocc.scala 399:52]
  assign MIDDLEMIDDLE_OV_27_io_west_dout_r = MIDDLEMIDDLE_OV_21_io_east_din_r; // @[OverlayRocc.scala 409:52]
  assign MIDDLEMIDDLE_OV_27_io_config_bits = config_bits_37; // @[OverlayRocc.scala 412:52]
  assign MIDDLEMIDDLE_OV_27_io_catch_config = catch_config_37[0]; // @[OverlayRocc.scala 413:52]
  assign MIDDLEMIDDLE_OV_28_clock = clock;
  assign MIDDLEMIDDLE_OV_28_reset = reset;
  assign MIDDLEMIDDLE_OV_28_io_north_din = MIDDLEMIDDLE_OV_27_io_south_dout; // @[OverlayRocc.scala 372:50]
  assign MIDDLEMIDDLE_OV_28_io_north_din_v = MIDDLEMIDDLE_OV_27_io_south_dout_v; // @[OverlayRocc.scala 373:52]
  assign MIDDLEMIDDLE_OV_28_io_west_din = MIDDLEMIDDLE_OV_22_io_east_dout; // @[OverlayRocc.scala 387:48]
  assign MIDDLEMIDDLE_OV_28_io_west_din_v = MIDDLEMIDDLE_OV_22_io_east_dout_v; // @[OverlayRocc.scala 388:51]
  assign MIDDLEMIDDLE_OV_28_io_north_dout_r = MIDDLEMIDDLE_OV_27_io_south_din_r; // @[OverlayRocc.scala 394:52]
  assign MIDDLEMIDDLE_OV_28_io_east_dout_r = 1'h0; // @[OverlayRocc.scala 399:52]
  assign MIDDLEMIDDLE_OV_28_io_west_dout_r = MIDDLEMIDDLE_OV_22_io_east_din_r; // @[OverlayRocc.scala 409:52]
  assign MIDDLEMIDDLE_OV_28_io_config_bits = config_bits_45; // @[OverlayRocc.scala 412:52]
  assign MIDDLEMIDDLE_OV_28_io_catch_config = catch_config_45[0]; // @[OverlayRocc.scala 413:52]
  assign MIDDLEMIDDLE_OV_29_clock = clock;
  assign MIDDLEMIDDLE_OV_29_reset = reset;
  assign MIDDLEMIDDLE_OV_29_io_north_din = MIDDLEMIDDLE_OV_28_io_south_dout; // @[OverlayRocc.scala 372:50]
  assign MIDDLEMIDDLE_OV_29_io_north_din_v = MIDDLEMIDDLE_OV_28_io_south_dout_v; // @[OverlayRocc.scala 373:52]
  assign MIDDLEMIDDLE_OV_29_io_west_din = MIDDLEMIDDLE_OV_23_io_east_dout; // @[OverlayRocc.scala 387:48]
  assign MIDDLEMIDDLE_OV_29_io_west_din_v = MIDDLEMIDDLE_OV_23_io_east_dout_v; // @[OverlayRocc.scala 388:51]
  assign MIDDLEMIDDLE_OV_29_io_north_dout_r = MIDDLEMIDDLE_OV_28_io_south_din_r; // @[OverlayRocc.scala 394:52]
  assign MIDDLEMIDDLE_OV_29_io_east_dout_r = 1'h0; // @[OverlayRocc.scala 399:52]
  assign MIDDLEMIDDLE_OV_29_io_west_dout_r = MIDDLEMIDDLE_OV_23_io_east_din_r; // @[OverlayRocc.scala 409:52]
  assign MIDDLEMIDDLE_OV_29_io_config_bits = config_bits_53; // @[OverlayRocc.scala 412:52]
  assign MIDDLEMIDDLE_OV_29_io_catch_config = catch_config_53[0]; // @[OverlayRocc.scala 413:52]
  assign MIDDLESOUTH_OV_4_clock = clock;
  assign MIDDLESOUTH_OV_4_reset = reset;
  assign MIDDLESOUTH_OV_4_io_north_din = MIDDLEMIDDLE_OV_29_io_south_dout; // @[OverlayRocc.scala 421:49]
  assign MIDDLESOUTH_OV_4_io_north_din_v = MIDDLEMIDDLE_OV_29_io_south_dout_v; // @[OverlayRocc.scala 422:51]
  assign MIDDLESOUTH_OV_4_io_west_din = MIDDLESOUTH_OV_3_io_east_dout; // @[OverlayRocc.scala 436:48]
  assign MIDDLESOUTH_OV_4_io_west_din_v = MIDDLESOUTH_OV_3_io_east_dout_v; // @[OverlayRocc.scala 437:50]
  assign MIDDLESOUTH_OV_4_io_north_dout_r = MIDDLEMIDDLE_OV_29_io_south_din_r; // @[OverlayRocc.scala 443:52]
  assign MIDDLESOUTH_OV_4_io_east_dout_r = 1'h0; // @[OverlayRocc.scala 448:51]
  assign MIDDLESOUTH_OV_4_io_west_dout_r = MIDDLESOUTH_OV_3_io_east_din_r; // @[OverlayRocc.scala 458:51]
  assign MIDDLESOUTH_OV_4_io_config_bits = config_bits_61; // @[OverlayRocc.scala 461:51]
  assign MIDDLESOUTH_OV_4_io_catch_config = catch_config_61[0]; // @[OverlayRocc.scala 462:52]
  assign MIDDLENORTH_OV_5_clock = clock;
  assign MIDDLENORTH_OV_5_reset = reset;
  assign MIDDLENORTH_OV_5_io_north_din = north_din_6; // @[OverlayRocc.scala 323:49]
  assign MIDDLENORTH_OV_5_io_north_din_v = north_din_v[6]; // @[OverlayRocc.scala 324:65]
  assign MIDDLENORTH_OV_5_io_west_din = MIDDLENORTH_OV_4_io_east_dout; // @[OverlayRocc.scala 338:47]
  assign MIDDLENORTH_OV_5_io_west_din_v = MIDDLENORTH_OV_4_io_east_dout_v; // @[OverlayRocc.scala 339:50]
  assign MIDDLENORTH_OV_5_io_north_dout_r = 1'h0; // @[OverlayRocc.scala 345:52]
  assign MIDDLENORTH_OV_5_io_east_dout_r = 1'h0; // @[OverlayRocc.scala 350:51]
  assign MIDDLENORTH_OV_5_io_west_dout_r = MIDDLENORTH_OV_4_io_east_din_r; // @[OverlayRocc.scala 360:51]
  assign MIDDLENORTH_OV_5_io_config_bits = config_bits_6; // @[OverlayRocc.scala 363:51]
  assign MIDDLENORTH_OV_5_io_catch_config = catch_config_6[0]; // @[OverlayRocc.scala 364:52]
  assign MIDDLEMIDDLE_OV_30_clock = clock;
  assign MIDDLEMIDDLE_OV_30_reset = reset;
  assign MIDDLEMIDDLE_OV_30_io_north_din = MIDDLENORTH_OV_5_io_south_dout; // @[OverlayRocc.scala 372:50]
  assign MIDDLEMIDDLE_OV_30_io_north_din_v = MIDDLENORTH_OV_5_io_south_dout_v; // @[OverlayRocc.scala 373:52]
  assign MIDDLEMIDDLE_OV_30_io_west_din = MIDDLEMIDDLE_OV_24_io_east_dout; // @[OverlayRocc.scala 387:48]
  assign MIDDLEMIDDLE_OV_30_io_west_din_v = MIDDLEMIDDLE_OV_24_io_east_dout_v; // @[OverlayRocc.scala 388:51]
  assign MIDDLEMIDDLE_OV_30_io_north_dout_r = MIDDLENORTH_OV_5_io_south_din_r; // @[OverlayRocc.scala 394:52]
  assign MIDDLEMIDDLE_OV_30_io_east_dout_r = 1'h0; // @[OverlayRocc.scala 399:52]
  assign MIDDLEMIDDLE_OV_30_io_west_dout_r = MIDDLEMIDDLE_OV_24_io_east_din_r; // @[OverlayRocc.scala 409:52]
  assign MIDDLEMIDDLE_OV_30_io_config_bits = config_bits_14; // @[OverlayRocc.scala 412:52]
  assign MIDDLEMIDDLE_OV_30_io_catch_config = catch_config_14[0]; // @[OverlayRocc.scala 413:52]
  assign MIDDLEMIDDLE_OV_31_clock = clock;
  assign MIDDLEMIDDLE_OV_31_reset = reset;
  assign MIDDLEMIDDLE_OV_31_io_north_din = MIDDLEMIDDLE_OV_30_io_south_dout; // @[OverlayRocc.scala 372:50]
  assign MIDDLEMIDDLE_OV_31_io_north_din_v = MIDDLEMIDDLE_OV_30_io_south_dout_v; // @[OverlayRocc.scala 373:52]
  assign MIDDLEMIDDLE_OV_31_io_west_din = MIDDLEMIDDLE_OV_25_io_east_dout; // @[OverlayRocc.scala 387:48]
  assign MIDDLEMIDDLE_OV_31_io_west_din_v = MIDDLEMIDDLE_OV_25_io_east_dout_v; // @[OverlayRocc.scala 388:51]
  assign MIDDLEMIDDLE_OV_31_io_north_dout_r = MIDDLEMIDDLE_OV_30_io_south_din_r; // @[OverlayRocc.scala 394:52]
  assign MIDDLEMIDDLE_OV_31_io_east_dout_r = 1'h0; // @[OverlayRocc.scala 399:52]
  assign MIDDLEMIDDLE_OV_31_io_west_dout_r = MIDDLEMIDDLE_OV_25_io_east_din_r; // @[OverlayRocc.scala 409:52]
  assign MIDDLEMIDDLE_OV_31_io_config_bits = config_bits_22; // @[OverlayRocc.scala 412:52]
  assign MIDDLEMIDDLE_OV_31_io_catch_config = catch_config_22[0]; // @[OverlayRocc.scala 413:52]
  assign MIDDLEMIDDLE_OV_32_clock = clock;
  assign MIDDLEMIDDLE_OV_32_reset = reset;
  assign MIDDLEMIDDLE_OV_32_io_north_din = MIDDLEMIDDLE_OV_31_io_south_dout; // @[OverlayRocc.scala 372:50]
  assign MIDDLEMIDDLE_OV_32_io_north_din_v = MIDDLEMIDDLE_OV_31_io_south_dout_v; // @[OverlayRocc.scala 373:52]
  assign MIDDLEMIDDLE_OV_32_io_west_din = MIDDLEMIDDLE_OV_26_io_east_dout; // @[OverlayRocc.scala 387:48]
  assign MIDDLEMIDDLE_OV_32_io_west_din_v = MIDDLEMIDDLE_OV_26_io_east_dout_v; // @[OverlayRocc.scala 388:51]
  assign MIDDLEMIDDLE_OV_32_io_north_dout_r = MIDDLEMIDDLE_OV_31_io_south_din_r; // @[OverlayRocc.scala 394:52]
  assign MIDDLEMIDDLE_OV_32_io_east_dout_r = 1'h0; // @[OverlayRocc.scala 399:52]
  assign MIDDLEMIDDLE_OV_32_io_west_dout_r = MIDDLEMIDDLE_OV_26_io_east_din_r; // @[OverlayRocc.scala 409:52]
  assign MIDDLEMIDDLE_OV_32_io_config_bits = config_bits_30; // @[OverlayRocc.scala 412:52]
  assign MIDDLEMIDDLE_OV_32_io_catch_config = catch_config_30[0]; // @[OverlayRocc.scala 413:52]
  assign MIDDLEMIDDLE_OV_33_clock = clock;
  assign MIDDLEMIDDLE_OV_33_reset = reset;
  assign MIDDLEMIDDLE_OV_33_io_north_din = MIDDLEMIDDLE_OV_32_io_south_dout; // @[OverlayRocc.scala 372:50]
  assign MIDDLEMIDDLE_OV_33_io_north_din_v = MIDDLEMIDDLE_OV_32_io_south_dout_v; // @[OverlayRocc.scala 373:52]
  assign MIDDLEMIDDLE_OV_33_io_west_din = MIDDLEMIDDLE_OV_27_io_east_dout; // @[OverlayRocc.scala 387:48]
  assign MIDDLEMIDDLE_OV_33_io_west_din_v = MIDDLEMIDDLE_OV_27_io_east_dout_v; // @[OverlayRocc.scala 388:51]
  assign MIDDLEMIDDLE_OV_33_io_north_dout_r = MIDDLEMIDDLE_OV_32_io_south_din_r; // @[OverlayRocc.scala 394:52]
  assign MIDDLEMIDDLE_OV_33_io_east_dout_r = 1'h0; // @[OverlayRocc.scala 399:52]
  assign MIDDLEMIDDLE_OV_33_io_west_dout_r = MIDDLEMIDDLE_OV_27_io_east_din_r; // @[OverlayRocc.scala 409:52]
  assign MIDDLEMIDDLE_OV_33_io_config_bits = config_bits_38; // @[OverlayRocc.scala 412:52]
  assign MIDDLEMIDDLE_OV_33_io_catch_config = catch_config_38[0]; // @[OverlayRocc.scala 413:52]
  assign MIDDLEMIDDLE_OV_34_clock = clock;
  assign MIDDLEMIDDLE_OV_34_reset = reset;
  assign MIDDLEMIDDLE_OV_34_io_north_din = MIDDLEMIDDLE_OV_33_io_south_dout; // @[OverlayRocc.scala 372:50]
  assign MIDDLEMIDDLE_OV_34_io_north_din_v = MIDDLEMIDDLE_OV_33_io_south_dout_v; // @[OverlayRocc.scala 373:52]
  assign MIDDLEMIDDLE_OV_34_io_west_din = MIDDLEMIDDLE_OV_28_io_east_dout; // @[OverlayRocc.scala 387:48]
  assign MIDDLEMIDDLE_OV_34_io_west_din_v = MIDDLEMIDDLE_OV_28_io_east_dout_v; // @[OverlayRocc.scala 388:51]
  assign MIDDLEMIDDLE_OV_34_io_north_dout_r = MIDDLEMIDDLE_OV_33_io_south_din_r; // @[OverlayRocc.scala 394:52]
  assign MIDDLEMIDDLE_OV_34_io_east_dout_r = 1'h0; // @[OverlayRocc.scala 399:52]
  assign MIDDLEMIDDLE_OV_34_io_west_dout_r = MIDDLEMIDDLE_OV_28_io_east_din_r; // @[OverlayRocc.scala 409:52]
  assign MIDDLEMIDDLE_OV_34_io_config_bits = config_bits_46; // @[OverlayRocc.scala 412:52]
  assign MIDDLEMIDDLE_OV_34_io_catch_config = catch_config_46[0]; // @[OverlayRocc.scala 413:52]
  assign MIDDLEMIDDLE_OV_35_clock = clock;
  assign MIDDLEMIDDLE_OV_35_reset = reset;
  assign MIDDLEMIDDLE_OV_35_io_north_din = MIDDLEMIDDLE_OV_34_io_south_dout; // @[OverlayRocc.scala 372:50]
  assign MIDDLEMIDDLE_OV_35_io_north_din_v = MIDDLEMIDDLE_OV_34_io_south_dout_v; // @[OverlayRocc.scala 373:52]
  assign MIDDLEMIDDLE_OV_35_io_west_din = MIDDLEMIDDLE_OV_29_io_east_dout; // @[OverlayRocc.scala 387:48]
  assign MIDDLEMIDDLE_OV_35_io_west_din_v = MIDDLEMIDDLE_OV_29_io_east_dout_v; // @[OverlayRocc.scala 388:51]
  assign MIDDLEMIDDLE_OV_35_io_north_dout_r = MIDDLEMIDDLE_OV_34_io_south_din_r; // @[OverlayRocc.scala 394:52]
  assign MIDDLEMIDDLE_OV_35_io_east_dout_r = 1'h0; // @[OverlayRocc.scala 399:52]
  assign MIDDLEMIDDLE_OV_35_io_west_dout_r = MIDDLEMIDDLE_OV_29_io_east_din_r; // @[OverlayRocc.scala 409:52]
  assign MIDDLEMIDDLE_OV_35_io_config_bits = config_bits_54; // @[OverlayRocc.scala 412:52]
  assign MIDDLEMIDDLE_OV_35_io_catch_config = catch_config_54[0]; // @[OverlayRocc.scala 413:52]
  assign MIDDLESOUTH_OV_5_clock = clock;
  assign MIDDLESOUTH_OV_5_reset = reset;
  assign MIDDLESOUTH_OV_5_io_north_din = MIDDLEMIDDLE_OV_35_io_south_dout; // @[OverlayRocc.scala 421:49]
  assign MIDDLESOUTH_OV_5_io_north_din_v = MIDDLEMIDDLE_OV_35_io_south_dout_v; // @[OverlayRocc.scala 422:51]
  assign MIDDLESOUTH_OV_5_io_west_din = MIDDLESOUTH_OV_4_io_east_dout; // @[OverlayRocc.scala 436:48]
  assign MIDDLESOUTH_OV_5_io_west_din_v = MIDDLESOUTH_OV_4_io_east_dout_v; // @[OverlayRocc.scala 437:50]
  assign MIDDLESOUTH_OV_5_io_north_dout_r = MIDDLEMIDDLE_OV_35_io_south_din_r; // @[OverlayRocc.scala 443:52]
  assign MIDDLESOUTH_OV_5_io_east_dout_r = 1'h0; // @[OverlayRocc.scala 448:51]
  assign MIDDLESOUTH_OV_5_io_west_dout_r = MIDDLESOUTH_OV_4_io_east_din_r; // @[OverlayRocc.scala 458:51]
  assign MIDDLESOUTH_OV_5_io_config_bits = config_bits_62; // @[OverlayRocc.scala 461:51]
  assign MIDDLESOUTH_OV_5_io_catch_config = catch_config_62[0]; // @[OverlayRocc.scala 462:52]
  assign NORTHEAST_OV_clock = clock;
  assign NORTHEAST_OV_reset = reset;
  assign NORTHEAST_OV_io_north_din = north_din_7; // @[OverlayRocc.scala 474:47]
  assign NORTHEAST_OV_io_north_din_v = north_din_v[7]; // @[OverlayRocc.scala 475:63]
  assign NORTHEAST_OV_io_west_din = MIDDLENORTH_OV_5_io_east_dout; // @[OverlayRocc.scala 489:46]
  assign NORTHEAST_OV_io_west_din_v = MIDDLENORTH_OV_5_io_east_dout_v; // @[OverlayRocc.scala 490:48]
  assign NORTHEAST_OV_io_north_dout_r = 1'h0; // @[OverlayRocc.scala 496:50]
  assign NORTHEAST_OV_io_east_dout_r = east_dout_r[0]; // @[OverlayRocc.scala 501:63]
  assign NORTHEAST_OV_io_west_dout_r = MIDDLENORTH_OV_5_io_east_din_r; // @[OverlayRocc.scala 511:49]
  assign NORTHEAST_OV_io_config_bits = config_bits_7; // @[OverlayRocc.scala 514:49]
  assign NORTHEAST_OV_io_catch_config = catch_config_7[0]; // @[OverlayRocc.scala 515:50]
  assign MIDDLEEAST_OV_clock = clock;
  assign MIDDLEEAST_OV_reset = reset;
  assign MIDDLEEAST_OV_io_north_din = NORTHEAST_OV_io_south_dout; // @[OverlayRocc.scala 523:48]
  assign MIDDLEEAST_OV_io_north_din_v = NORTHEAST_OV_io_south_dout_v; // @[OverlayRocc.scala 524:50]
  assign MIDDLEEAST_OV_io_west_din = MIDDLEMIDDLE_OV_30_io_east_dout; // @[OverlayRocc.scala 538:47]
  assign MIDDLEEAST_OV_io_west_din_v = MIDDLEMIDDLE_OV_30_io_east_dout_v; // @[OverlayRocc.scala 539:49]
  assign MIDDLEEAST_OV_io_north_dout_r = NORTHEAST_OV_io_south_din_r; // @[OverlayRocc.scala 545:51]
  assign MIDDLEEAST_OV_io_east_dout_r = east_dout_r[1]; // @[OverlayRocc.scala 550:64]
  assign MIDDLEEAST_OV_io_west_dout_r = MIDDLEMIDDLE_OV_30_io_east_din_r; // @[OverlayRocc.scala 560:50]
  assign MIDDLEEAST_OV_io_config_bits = config_bits_15; // @[OverlayRocc.scala 563:50]
  assign MIDDLEEAST_OV_io_catch_config = catch_config_15[0]; // @[OverlayRocc.scala 564:51]
  assign MIDDLEEAST_OV_1_clock = clock;
  assign MIDDLEEAST_OV_1_reset = reset;
  assign MIDDLEEAST_OV_1_io_north_din = MIDDLEEAST_OV_io_south_dout; // @[OverlayRocc.scala 523:48]
  assign MIDDLEEAST_OV_1_io_north_din_v = MIDDLEEAST_OV_io_south_dout_v; // @[OverlayRocc.scala 524:50]
  assign MIDDLEEAST_OV_1_io_west_din = MIDDLEMIDDLE_OV_31_io_east_dout; // @[OverlayRocc.scala 538:47]
  assign MIDDLEEAST_OV_1_io_west_din_v = MIDDLEMIDDLE_OV_31_io_east_dout_v; // @[OverlayRocc.scala 539:49]
  assign MIDDLEEAST_OV_1_io_north_dout_r = MIDDLEEAST_OV_io_south_din_r; // @[OverlayRocc.scala 545:51]
  assign MIDDLEEAST_OV_1_io_east_dout_r = east_dout_r[2]; // @[OverlayRocc.scala 550:64]
  assign MIDDLEEAST_OV_1_io_west_dout_r = MIDDLEMIDDLE_OV_31_io_east_din_r; // @[OverlayRocc.scala 560:50]
  assign MIDDLEEAST_OV_1_io_config_bits = config_bits_23; // @[OverlayRocc.scala 563:50]
  assign MIDDLEEAST_OV_1_io_catch_config = catch_config_23[0]; // @[OverlayRocc.scala 564:51]
  assign MIDDLEEAST_OV_2_clock = clock;
  assign MIDDLEEAST_OV_2_reset = reset;
  assign MIDDLEEAST_OV_2_io_north_din = MIDDLEEAST_OV_1_io_south_dout; // @[OverlayRocc.scala 523:48]
  assign MIDDLEEAST_OV_2_io_north_din_v = MIDDLEEAST_OV_1_io_south_dout_v; // @[OverlayRocc.scala 524:50]
  assign MIDDLEEAST_OV_2_io_west_din = MIDDLEMIDDLE_OV_32_io_east_dout; // @[OverlayRocc.scala 538:47]
  assign MIDDLEEAST_OV_2_io_west_din_v = MIDDLEMIDDLE_OV_32_io_east_dout_v; // @[OverlayRocc.scala 539:49]
  assign MIDDLEEAST_OV_2_io_north_dout_r = MIDDLEEAST_OV_1_io_south_din_r; // @[OverlayRocc.scala 545:51]
  assign MIDDLEEAST_OV_2_io_east_dout_r = east_dout_r[3]; // @[OverlayRocc.scala 550:64]
  assign MIDDLEEAST_OV_2_io_west_dout_r = MIDDLEMIDDLE_OV_32_io_east_din_r; // @[OverlayRocc.scala 560:50]
  assign MIDDLEEAST_OV_2_io_config_bits = config_bits_31; // @[OverlayRocc.scala 563:50]
  assign MIDDLEEAST_OV_2_io_catch_config = catch_config_31[0]; // @[OverlayRocc.scala 564:51]
  assign MIDDLEEAST_OV_3_clock = clock;
  assign MIDDLEEAST_OV_3_reset = reset;
  assign MIDDLEEAST_OV_3_io_north_din = MIDDLEEAST_OV_2_io_south_dout; // @[OverlayRocc.scala 523:48]
  assign MIDDLEEAST_OV_3_io_north_din_v = MIDDLEEAST_OV_2_io_south_dout_v; // @[OverlayRocc.scala 524:50]
  assign MIDDLEEAST_OV_3_io_west_din = MIDDLEMIDDLE_OV_33_io_east_dout; // @[OverlayRocc.scala 538:47]
  assign MIDDLEEAST_OV_3_io_west_din_v = MIDDLEMIDDLE_OV_33_io_east_dout_v; // @[OverlayRocc.scala 539:49]
  assign MIDDLEEAST_OV_3_io_north_dout_r = MIDDLEEAST_OV_2_io_south_din_r; // @[OverlayRocc.scala 545:51]
  assign MIDDLEEAST_OV_3_io_east_dout_r = east_dout_r[4]; // @[OverlayRocc.scala 550:64]
  assign MIDDLEEAST_OV_3_io_west_dout_r = MIDDLEMIDDLE_OV_33_io_east_din_r; // @[OverlayRocc.scala 560:50]
  assign MIDDLEEAST_OV_3_io_config_bits = config_bits_39; // @[OverlayRocc.scala 563:50]
  assign MIDDLEEAST_OV_3_io_catch_config = catch_config_39[0]; // @[OverlayRocc.scala 564:51]
  assign MIDDLEEAST_OV_4_clock = clock;
  assign MIDDLEEAST_OV_4_reset = reset;
  assign MIDDLEEAST_OV_4_io_north_din = MIDDLEEAST_OV_3_io_south_dout; // @[OverlayRocc.scala 523:48]
  assign MIDDLEEAST_OV_4_io_north_din_v = MIDDLEEAST_OV_3_io_south_dout_v; // @[OverlayRocc.scala 524:50]
  assign MIDDLEEAST_OV_4_io_west_din = MIDDLEMIDDLE_OV_34_io_east_dout; // @[OverlayRocc.scala 538:47]
  assign MIDDLEEAST_OV_4_io_west_din_v = MIDDLEMIDDLE_OV_34_io_east_dout_v; // @[OverlayRocc.scala 539:49]
  assign MIDDLEEAST_OV_4_io_north_dout_r = MIDDLEEAST_OV_3_io_south_din_r; // @[OverlayRocc.scala 545:51]
  assign MIDDLEEAST_OV_4_io_east_dout_r = east_dout_r[5]; // @[OverlayRocc.scala 550:64]
  assign MIDDLEEAST_OV_4_io_west_dout_r = MIDDLEMIDDLE_OV_34_io_east_din_r; // @[OverlayRocc.scala 560:50]
  assign MIDDLEEAST_OV_4_io_config_bits = config_bits_47; // @[OverlayRocc.scala 563:50]
  assign MIDDLEEAST_OV_4_io_catch_config = catch_config_47[0]; // @[OverlayRocc.scala 564:51]
  assign MIDDLEEAST_OV_5_clock = clock;
  assign MIDDLEEAST_OV_5_reset = reset;
  assign MIDDLEEAST_OV_5_io_north_din = MIDDLEEAST_OV_4_io_south_dout; // @[OverlayRocc.scala 523:48]
  assign MIDDLEEAST_OV_5_io_north_din_v = MIDDLEEAST_OV_4_io_south_dout_v; // @[OverlayRocc.scala 524:50]
  assign MIDDLEEAST_OV_5_io_west_din = MIDDLEMIDDLE_OV_35_io_east_dout; // @[OverlayRocc.scala 538:47]
  assign MIDDLEEAST_OV_5_io_west_din_v = MIDDLEMIDDLE_OV_35_io_east_dout_v; // @[OverlayRocc.scala 539:49]
  assign MIDDLEEAST_OV_5_io_north_dout_r = MIDDLEEAST_OV_4_io_south_din_r; // @[OverlayRocc.scala 545:51]
  assign MIDDLEEAST_OV_5_io_east_dout_r = east_dout_r[6]; // @[OverlayRocc.scala 550:64]
  assign MIDDLEEAST_OV_5_io_west_dout_r = MIDDLEMIDDLE_OV_35_io_east_din_r; // @[OverlayRocc.scala 560:50]
  assign MIDDLEEAST_OV_5_io_config_bits = config_bits_55; // @[OverlayRocc.scala 563:50]
  assign MIDDLEEAST_OV_5_io_catch_config = catch_config_55[0]; // @[OverlayRocc.scala 564:51]
  assign MIDDLESOUTH_OV_6_clock = clock;
  assign MIDDLESOUTH_OV_6_reset = reset;
  assign MIDDLESOUTH_OV_6_io_north_din = MIDDLEEAST_OV_5_io_south_dout; // @[OverlayRocc.scala 572:49]
  assign MIDDLESOUTH_OV_6_io_north_din_v = MIDDLEEAST_OV_5_io_south_dout_v; // @[OverlayRocc.scala 573:51]
  assign MIDDLESOUTH_OV_6_io_west_din = MIDDLESOUTH_OV_5_io_east_dout; // @[OverlayRocc.scala 587:48]
  assign MIDDLESOUTH_OV_6_io_west_din_v = MIDDLESOUTH_OV_5_io_east_dout_v; // @[OverlayRocc.scala 588:50]
  assign MIDDLESOUTH_OV_6_io_north_dout_r = MIDDLEEAST_OV_5_io_south_din_r; // @[OverlayRocc.scala 594:52]
  assign MIDDLESOUTH_OV_6_io_east_dout_r = east_dout_r[7]; // @[OverlayRocc.scala 599:65]
  assign MIDDLESOUTH_OV_6_io_west_dout_r = MIDDLESOUTH_OV_5_io_east_din_r; // @[OverlayRocc.scala 609:51]
  assign MIDDLESOUTH_OV_6_io_config_bits = config_bits_63; // @[OverlayRocc.scala 612:51]
  assign MIDDLESOUTH_OV_6_io_catch_config = catch_config_63[0]; // @[OverlayRocc.scala 613:52]
  always @(posedge clock) begin
    north_din_0 <= io_data_in[31:0]; // @[OverlayRocc.scala 135:35]
    north_din_1 <= io_data_in[63:32]; // @[OverlayRocc.scala 135:35]
    north_din_2 <= io_data_in[95:64]; // @[OverlayRocc.scala 135:35]
    north_din_3 <= io_data_in[127:96]; // @[OverlayRocc.scala 135:35]
    north_din_4 <= io_data_in[159:128]; // @[OverlayRocc.scala 135:35]
    north_din_5 <= io_data_in[191:160]; // @[OverlayRocc.scala 135:35]
    north_din_6 <= io_data_in[223:192]; // @[OverlayRocc.scala 135:35]
    north_din_7 <= io_data_in[255:224]; // @[OverlayRocc.scala 135:35]
    if (reset) begin // @[OverlayRocc.scala 25:30]
      north_din_v <= 8'h0; // @[OverlayRocc.scala 25:30]
    end else begin
      north_din_v <= io_data_in_valid; // @[OverlayRocc.scala 140:17]
    end
    east_dout_0 <= NORTHEAST_OV_io_east_dout; // @[OverlayRocc.scala 499:34]
    east_dout_1 <= MIDDLEEAST_OV_io_east_dout; // @[OverlayRocc.scala 548:34]
    east_dout_2 <= MIDDLEEAST_OV_1_io_east_dout; // @[OverlayRocc.scala 548:34]
    east_dout_3 <= MIDDLEEAST_OV_2_io_east_dout; // @[OverlayRocc.scala 548:34]
    east_dout_4 <= MIDDLEEAST_OV_3_io_east_dout; // @[OverlayRocc.scala 548:34]
    east_dout_5 <= MIDDLEEAST_OV_4_io_east_dout; // @[OverlayRocc.scala 548:34]
    east_dout_6 <= MIDDLEEAST_OV_5_io_east_dout; // @[OverlayRocc.scala 548:34]
    east_dout_7 <= MIDDLESOUTH_OV_6_io_east_dout; // @[OverlayRocc.scala 597:34]
    if (reset) begin // @[OverlayRocc.scala 30:30]
      east_dout_r <= 8'h0; // @[OverlayRocc.scala 30:30]
    end else begin
      east_dout_r <= io_data_out_ready; // @[OverlayRocc.scala 156:17]
    end
    if (6'h0 == unsigned_cell_config) begin // @[OverlayRocc.scala 124:39]
      config_bits_0 <= io_cell_config[181:0]; // @[OverlayRocc.scala 124:39]
    end
    if (6'h1 == unsigned_cell_config) begin // @[OverlayRocc.scala 124:39]
      config_bits_1 <= io_cell_config[181:0]; // @[OverlayRocc.scala 124:39]
    end
    if (6'h2 == unsigned_cell_config) begin // @[OverlayRocc.scala 124:39]
      config_bits_2 <= io_cell_config[181:0]; // @[OverlayRocc.scala 124:39]
    end
    if (6'h3 == unsigned_cell_config) begin // @[OverlayRocc.scala 124:39]
      config_bits_3 <= io_cell_config[181:0]; // @[OverlayRocc.scala 124:39]
    end
    if (6'h4 == unsigned_cell_config) begin // @[OverlayRocc.scala 124:39]
      config_bits_4 <= io_cell_config[181:0]; // @[OverlayRocc.scala 124:39]
    end
    if (6'h5 == unsigned_cell_config) begin // @[OverlayRocc.scala 124:39]
      config_bits_5 <= io_cell_config[181:0]; // @[OverlayRocc.scala 124:39]
    end
    if (6'h6 == unsigned_cell_config) begin // @[OverlayRocc.scala 124:39]
      config_bits_6 <= io_cell_config[181:0]; // @[OverlayRocc.scala 124:39]
    end
    if (6'h7 == unsigned_cell_config) begin // @[OverlayRocc.scala 124:39]
      config_bits_7 <= io_cell_config[181:0]; // @[OverlayRocc.scala 124:39]
    end
    if (6'h8 == unsigned_cell_config) begin // @[OverlayRocc.scala 124:39]
      config_bits_8 <= io_cell_config[181:0]; // @[OverlayRocc.scala 124:39]
    end
    if (6'h9 == unsigned_cell_config) begin // @[OverlayRocc.scala 124:39]
      config_bits_9 <= io_cell_config[181:0]; // @[OverlayRocc.scala 124:39]
    end
    if (6'ha == unsigned_cell_config) begin // @[OverlayRocc.scala 124:39]
      config_bits_10 <= io_cell_config[181:0]; // @[OverlayRocc.scala 124:39]
    end
    if (6'hb == unsigned_cell_config) begin // @[OverlayRocc.scala 124:39]
      config_bits_11 <= io_cell_config[181:0]; // @[OverlayRocc.scala 124:39]
    end
    if (6'hc == unsigned_cell_config) begin // @[OverlayRocc.scala 124:39]
      config_bits_12 <= io_cell_config[181:0]; // @[OverlayRocc.scala 124:39]
    end
    if (6'hd == unsigned_cell_config) begin // @[OverlayRocc.scala 124:39]
      config_bits_13 <= io_cell_config[181:0]; // @[OverlayRocc.scala 124:39]
    end
    if (6'he == unsigned_cell_config) begin // @[OverlayRocc.scala 124:39]
      config_bits_14 <= io_cell_config[181:0]; // @[OverlayRocc.scala 124:39]
    end
    if (6'hf == unsigned_cell_config) begin // @[OverlayRocc.scala 124:39]
      config_bits_15 <= io_cell_config[181:0]; // @[OverlayRocc.scala 124:39]
    end
    if (6'h10 == unsigned_cell_config) begin // @[OverlayRocc.scala 124:39]
      config_bits_16 <= io_cell_config[181:0]; // @[OverlayRocc.scala 124:39]
    end
    if (6'h11 == unsigned_cell_config) begin // @[OverlayRocc.scala 124:39]
      config_bits_17 <= io_cell_config[181:0]; // @[OverlayRocc.scala 124:39]
    end
    if (6'h12 == unsigned_cell_config) begin // @[OverlayRocc.scala 124:39]
      config_bits_18 <= io_cell_config[181:0]; // @[OverlayRocc.scala 124:39]
    end
    if (6'h13 == unsigned_cell_config) begin // @[OverlayRocc.scala 124:39]
      config_bits_19 <= io_cell_config[181:0]; // @[OverlayRocc.scala 124:39]
    end
    if (6'h14 == unsigned_cell_config) begin // @[OverlayRocc.scala 124:39]
      config_bits_20 <= io_cell_config[181:0]; // @[OverlayRocc.scala 124:39]
    end
    if (6'h15 == unsigned_cell_config) begin // @[OverlayRocc.scala 124:39]
      config_bits_21 <= io_cell_config[181:0]; // @[OverlayRocc.scala 124:39]
    end
    if (6'h16 == unsigned_cell_config) begin // @[OverlayRocc.scala 124:39]
      config_bits_22 <= io_cell_config[181:0]; // @[OverlayRocc.scala 124:39]
    end
    if (6'h17 == unsigned_cell_config) begin // @[OverlayRocc.scala 124:39]
      config_bits_23 <= io_cell_config[181:0]; // @[OverlayRocc.scala 124:39]
    end
    if (6'h18 == unsigned_cell_config) begin // @[OverlayRocc.scala 124:39]
      config_bits_24 <= io_cell_config[181:0]; // @[OverlayRocc.scala 124:39]
    end
    if (6'h19 == unsigned_cell_config) begin // @[OverlayRocc.scala 124:39]
      config_bits_25 <= io_cell_config[181:0]; // @[OverlayRocc.scala 124:39]
    end
    if (6'h1a == unsigned_cell_config) begin // @[OverlayRocc.scala 124:39]
      config_bits_26 <= io_cell_config[181:0]; // @[OverlayRocc.scala 124:39]
    end
    if (6'h1b == unsigned_cell_config) begin // @[OverlayRocc.scala 124:39]
      config_bits_27 <= io_cell_config[181:0]; // @[OverlayRocc.scala 124:39]
    end
    if (6'h1c == unsigned_cell_config) begin // @[OverlayRocc.scala 124:39]
      config_bits_28 <= io_cell_config[181:0]; // @[OverlayRocc.scala 124:39]
    end
    if (6'h1d == unsigned_cell_config) begin // @[OverlayRocc.scala 124:39]
      config_bits_29 <= io_cell_config[181:0]; // @[OverlayRocc.scala 124:39]
    end
    if (6'h1e == unsigned_cell_config) begin // @[OverlayRocc.scala 124:39]
      config_bits_30 <= io_cell_config[181:0]; // @[OverlayRocc.scala 124:39]
    end
    if (6'h1f == unsigned_cell_config) begin // @[OverlayRocc.scala 124:39]
      config_bits_31 <= io_cell_config[181:0]; // @[OverlayRocc.scala 124:39]
    end
    if (6'h20 == unsigned_cell_config) begin // @[OverlayRocc.scala 124:39]
      config_bits_32 <= io_cell_config[181:0]; // @[OverlayRocc.scala 124:39]
    end
    if (6'h21 == unsigned_cell_config) begin // @[OverlayRocc.scala 124:39]
      config_bits_33 <= io_cell_config[181:0]; // @[OverlayRocc.scala 124:39]
    end
    if (6'h22 == unsigned_cell_config) begin // @[OverlayRocc.scala 124:39]
      config_bits_34 <= io_cell_config[181:0]; // @[OverlayRocc.scala 124:39]
    end
    if (6'h23 == unsigned_cell_config) begin // @[OverlayRocc.scala 124:39]
      config_bits_35 <= io_cell_config[181:0]; // @[OverlayRocc.scala 124:39]
    end
    if (6'h24 == unsigned_cell_config) begin // @[OverlayRocc.scala 124:39]
      config_bits_36 <= io_cell_config[181:0]; // @[OverlayRocc.scala 124:39]
    end
    if (6'h25 == unsigned_cell_config) begin // @[OverlayRocc.scala 124:39]
      config_bits_37 <= io_cell_config[181:0]; // @[OverlayRocc.scala 124:39]
    end
    if (6'h26 == unsigned_cell_config) begin // @[OverlayRocc.scala 124:39]
      config_bits_38 <= io_cell_config[181:0]; // @[OverlayRocc.scala 124:39]
    end
    if (6'h27 == unsigned_cell_config) begin // @[OverlayRocc.scala 124:39]
      config_bits_39 <= io_cell_config[181:0]; // @[OverlayRocc.scala 124:39]
    end
    if (6'h28 == unsigned_cell_config) begin // @[OverlayRocc.scala 124:39]
      config_bits_40 <= io_cell_config[181:0]; // @[OverlayRocc.scala 124:39]
    end
    if (6'h29 == unsigned_cell_config) begin // @[OverlayRocc.scala 124:39]
      config_bits_41 <= io_cell_config[181:0]; // @[OverlayRocc.scala 124:39]
    end
    if (6'h2a == unsigned_cell_config) begin // @[OverlayRocc.scala 124:39]
      config_bits_42 <= io_cell_config[181:0]; // @[OverlayRocc.scala 124:39]
    end
    if (6'h2b == unsigned_cell_config) begin // @[OverlayRocc.scala 124:39]
      config_bits_43 <= io_cell_config[181:0]; // @[OverlayRocc.scala 124:39]
    end
    if (6'h2c == unsigned_cell_config) begin // @[OverlayRocc.scala 124:39]
      config_bits_44 <= io_cell_config[181:0]; // @[OverlayRocc.scala 124:39]
    end
    if (6'h2d == unsigned_cell_config) begin // @[OverlayRocc.scala 124:39]
      config_bits_45 <= io_cell_config[181:0]; // @[OverlayRocc.scala 124:39]
    end
    if (6'h2e == unsigned_cell_config) begin // @[OverlayRocc.scala 124:39]
      config_bits_46 <= io_cell_config[181:0]; // @[OverlayRocc.scala 124:39]
    end
    if (6'h2f == unsigned_cell_config) begin // @[OverlayRocc.scala 124:39]
      config_bits_47 <= io_cell_config[181:0]; // @[OverlayRocc.scala 124:39]
    end
    if (6'h30 == unsigned_cell_config) begin // @[OverlayRocc.scala 124:39]
      config_bits_48 <= io_cell_config[181:0]; // @[OverlayRocc.scala 124:39]
    end
    if (6'h31 == unsigned_cell_config) begin // @[OverlayRocc.scala 124:39]
      config_bits_49 <= io_cell_config[181:0]; // @[OverlayRocc.scala 124:39]
    end
    if (6'h32 == unsigned_cell_config) begin // @[OverlayRocc.scala 124:39]
      config_bits_50 <= io_cell_config[181:0]; // @[OverlayRocc.scala 124:39]
    end
    if (6'h33 == unsigned_cell_config) begin // @[OverlayRocc.scala 124:39]
      config_bits_51 <= io_cell_config[181:0]; // @[OverlayRocc.scala 124:39]
    end
    if (6'h34 == unsigned_cell_config) begin // @[OverlayRocc.scala 124:39]
      config_bits_52 <= io_cell_config[181:0]; // @[OverlayRocc.scala 124:39]
    end
    if (6'h35 == unsigned_cell_config) begin // @[OverlayRocc.scala 124:39]
      config_bits_53 <= io_cell_config[181:0]; // @[OverlayRocc.scala 124:39]
    end
    if (6'h36 == unsigned_cell_config) begin // @[OverlayRocc.scala 124:39]
      config_bits_54 <= io_cell_config[181:0]; // @[OverlayRocc.scala 124:39]
    end
    if (6'h37 == unsigned_cell_config) begin // @[OverlayRocc.scala 124:39]
      config_bits_55 <= io_cell_config[181:0]; // @[OverlayRocc.scala 124:39]
    end
    if (6'h38 == unsigned_cell_config) begin // @[OverlayRocc.scala 124:39]
      config_bits_56 <= io_cell_config[181:0]; // @[OverlayRocc.scala 124:39]
    end
    if (6'h39 == unsigned_cell_config) begin // @[OverlayRocc.scala 124:39]
      config_bits_57 <= io_cell_config[181:0]; // @[OverlayRocc.scala 124:39]
    end
    if (6'h3a == unsigned_cell_config) begin // @[OverlayRocc.scala 124:39]
      config_bits_58 <= io_cell_config[181:0]; // @[OverlayRocc.scala 124:39]
    end
    if (6'h3b == unsigned_cell_config) begin // @[OverlayRocc.scala 124:39]
      config_bits_59 <= io_cell_config[181:0]; // @[OverlayRocc.scala 124:39]
    end
    if (6'h3c == unsigned_cell_config) begin // @[OverlayRocc.scala 124:39]
      config_bits_60 <= io_cell_config[181:0]; // @[OverlayRocc.scala 124:39]
    end
    if (6'h3d == unsigned_cell_config) begin // @[OverlayRocc.scala 124:39]
      config_bits_61 <= io_cell_config[181:0]; // @[OverlayRocc.scala 124:39]
    end
    if (6'h3e == unsigned_cell_config) begin // @[OverlayRocc.scala 124:39]
      config_bits_62 <= io_cell_config[181:0]; // @[OverlayRocc.scala 124:39]
    end
    if (6'h3f == unsigned_cell_config) begin // @[OverlayRocc.scala 124:39]
      config_bits_63 <= io_cell_config[181:0]; // @[OverlayRocc.scala 124:39]
    end
    if (io_cell_config[191]) begin // @[OverlayRocc.scala 130:39]
      if (6'h0 == unsigned_cell_config) begin // @[OverlayRocc.scala 131:44]
        catch_config_0 <= 182'h1; // @[OverlayRocc.scala 131:44]
      end else begin
        catch_config_0 <= 182'h0; // @[OverlayRocc.scala 127:25]
      end
    end else begin
      catch_config_0 <= 182'h0; // @[OverlayRocc.scala 127:25]
    end
    if (io_cell_config[191]) begin // @[OverlayRocc.scala 130:39]
      if (6'h1 == unsigned_cell_config) begin // @[OverlayRocc.scala 131:44]
        catch_config_1 <= 182'h1; // @[OverlayRocc.scala 131:44]
      end else begin
        catch_config_1 <= 182'h0; // @[OverlayRocc.scala 127:25]
      end
    end else begin
      catch_config_1 <= 182'h0; // @[OverlayRocc.scala 127:25]
    end
    if (io_cell_config[191]) begin // @[OverlayRocc.scala 130:39]
      if (6'h2 == unsigned_cell_config) begin // @[OverlayRocc.scala 131:44]
        catch_config_2 <= 182'h1; // @[OverlayRocc.scala 131:44]
      end else begin
        catch_config_2 <= 182'h0; // @[OverlayRocc.scala 127:25]
      end
    end else begin
      catch_config_2 <= 182'h0; // @[OverlayRocc.scala 127:25]
    end
    if (io_cell_config[191]) begin // @[OverlayRocc.scala 130:39]
      if (6'h3 == unsigned_cell_config) begin // @[OverlayRocc.scala 131:44]
        catch_config_3 <= 182'h1; // @[OverlayRocc.scala 131:44]
      end else begin
        catch_config_3 <= 182'h0; // @[OverlayRocc.scala 127:25]
      end
    end else begin
      catch_config_3 <= 182'h0; // @[OverlayRocc.scala 127:25]
    end
    if (io_cell_config[191]) begin // @[OverlayRocc.scala 130:39]
      if (6'h4 == unsigned_cell_config) begin // @[OverlayRocc.scala 131:44]
        catch_config_4 <= 182'h1; // @[OverlayRocc.scala 131:44]
      end else begin
        catch_config_4 <= 182'h0; // @[OverlayRocc.scala 127:25]
      end
    end else begin
      catch_config_4 <= 182'h0; // @[OverlayRocc.scala 127:25]
    end
    if (io_cell_config[191]) begin // @[OverlayRocc.scala 130:39]
      if (6'h5 == unsigned_cell_config) begin // @[OverlayRocc.scala 131:44]
        catch_config_5 <= 182'h1; // @[OverlayRocc.scala 131:44]
      end else begin
        catch_config_5 <= 182'h0; // @[OverlayRocc.scala 127:25]
      end
    end else begin
      catch_config_5 <= 182'h0; // @[OverlayRocc.scala 127:25]
    end
    if (io_cell_config[191]) begin // @[OverlayRocc.scala 130:39]
      if (6'h6 == unsigned_cell_config) begin // @[OverlayRocc.scala 131:44]
        catch_config_6 <= 182'h1; // @[OverlayRocc.scala 131:44]
      end else begin
        catch_config_6 <= 182'h0; // @[OverlayRocc.scala 127:25]
      end
    end else begin
      catch_config_6 <= 182'h0; // @[OverlayRocc.scala 127:25]
    end
    if (io_cell_config[191]) begin // @[OverlayRocc.scala 130:39]
      if (6'h7 == unsigned_cell_config) begin // @[OverlayRocc.scala 131:44]
        catch_config_7 <= 182'h1; // @[OverlayRocc.scala 131:44]
      end else begin
        catch_config_7 <= 182'h0; // @[OverlayRocc.scala 127:25]
      end
    end else begin
      catch_config_7 <= 182'h0; // @[OverlayRocc.scala 127:25]
    end
    if (io_cell_config[191]) begin // @[OverlayRocc.scala 130:39]
      if (6'h8 == unsigned_cell_config) begin // @[OverlayRocc.scala 131:44]
        catch_config_8 <= 182'h1; // @[OverlayRocc.scala 131:44]
      end else begin
        catch_config_8 <= 182'h0; // @[OverlayRocc.scala 127:25]
      end
    end else begin
      catch_config_8 <= 182'h0; // @[OverlayRocc.scala 127:25]
    end
    if (io_cell_config[191]) begin // @[OverlayRocc.scala 130:39]
      if (6'h9 == unsigned_cell_config) begin // @[OverlayRocc.scala 131:44]
        catch_config_9 <= 182'h1; // @[OverlayRocc.scala 131:44]
      end else begin
        catch_config_9 <= 182'h0; // @[OverlayRocc.scala 127:25]
      end
    end else begin
      catch_config_9 <= 182'h0; // @[OverlayRocc.scala 127:25]
    end
    if (io_cell_config[191]) begin // @[OverlayRocc.scala 130:39]
      if (6'ha == unsigned_cell_config) begin // @[OverlayRocc.scala 131:44]
        catch_config_10 <= 182'h1; // @[OverlayRocc.scala 131:44]
      end else begin
        catch_config_10 <= 182'h0; // @[OverlayRocc.scala 127:25]
      end
    end else begin
      catch_config_10 <= 182'h0; // @[OverlayRocc.scala 127:25]
    end
    if (io_cell_config[191]) begin // @[OverlayRocc.scala 130:39]
      if (6'hb == unsigned_cell_config) begin // @[OverlayRocc.scala 131:44]
        catch_config_11 <= 182'h1; // @[OverlayRocc.scala 131:44]
      end else begin
        catch_config_11 <= 182'h0; // @[OverlayRocc.scala 127:25]
      end
    end else begin
      catch_config_11 <= 182'h0; // @[OverlayRocc.scala 127:25]
    end
    if (io_cell_config[191]) begin // @[OverlayRocc.scala 130:39]
      if (6'hc == unsigned_cell_config) begin // @[OverlayRocc.scala 131:44]
        catch_config_12 <= 182'h1; // @[OverlayRocc.scala 131:44]
      end else begin
        catch_config_12 <= 182'h0; // @[OverlayRocc.scala 127:25]
      end
    end else begin
      catch_config_12 <= 182'h0; // @[OverlayRocc.scala 127:25]
    end
    if (io_cell_config[191]) begin // @[OverlayRocc.scala 130:39]
      if (6'hd == unsigned_cell_config) begin // @[OverlayRocc.scala 131:44]
        catch_config_13 <= 182'h1; // @[OverlayRocc.scala 131:44]
      end else begin
        catch_config_13 <= 182'h0; // @[OverlayRocc.scala 127:25]
      end
    end else begin
      catch_config_13 <= 182'h0; // @[OverlayRocc.scala 127:25]
    end
    if (io_cell_config[191]) begin // @[OverlayRocc.scala 130:39]
      if (6'he == unsigned_cell_config) begin // @[OverlayRocc.scala 131:44]
        catch_config_14 <= 182'h1; // @[OverlayRocc.scala 131:44]
      end else begin
        catch_config_14 <= 182'h0; // @[OverlayRocc.scala 127:25]
      end
    end else begin
      catch_config_14 <= 182'h0; // @[OverlayRocc.scala 127:25]
    end
    if (io_cell_config[191]) begin // @[OverlayRocc.scala 130:39]
      if (6'hf == unsigned_cell_config) begin // @[OverlayRocc.scala 131:44]
        catch_config_15 <= 182'h1; // @[OverlayRocc.scala 131:44]
      end else begin
        catch_config_15 <= 182'h0; // @[OverlayRocc.scala 127:25]
      end
    end else begin
      catch_config_15 <= 182'h0; // @[OverlayRocc.scala 127:25]
    end
    if (io_cell_config[191]) begin // @[OverlayRocc.scala 130:39]
      if (6'h10 == unsigned_cell_config) begin // @[OverlayRocc.scala 131:44]
        catch_config_16 <= 182'h1; // @[OverlayRocc.scala 131:44]
      end else begin
        catch_config_16 <= 182'h0; // @[OverlayRocc.scala 127:25]
      end
    end else begin
      catch_config_16 <= 182'h0; // @[OverlayRocc.scala 127:25]
    end
    if (io_cell_config[191]) begin // @[OverlayRocc.scala 130:39]
      if (6'h11 == unsigned_cell_config) begin // @[OverlayRocc.scala 131:44]
        catch_config_17 <= 182'h1; // @[OverlayRocc.scala 131:44]
      end else begin
        catch_config_17 <= 182'h0; // @[OverlayRocc.scala 127:25]
      end
    end else begin
      catch_config_17 <= 182'h0; // @[OverlayRocc.scala 127:25]
    end
    if (io_cell_config[191]) begin // @[OverlayRocc.scala 130:39]
      if (6'h12 == unsigned_cell_config) begin // @[OverlayRocc.scala 131:44]
        catch_config_18 <= 182'h1; // @[OverlayRocc.scala 131:44]
      end else begin
        catch_config_18 <= 182'h0; // @[OverlayRocc.scala 127:25]
      end
    end else begin
      catch_config_18 <= 182'h0; // @[OverlayRocc.scala 127:25]
    end
    if (io_cell_config[191]) begin // @[OverlayRocc.scala 130:39]
      if (6'h13 == unsigned_cell_config) begin // @[OverlayRocc.scala 131:44]
        catch_config_19 <= 182'h1; // @[OverlayRocc.scala 131:44]
      end else begin
        catch_config_19 <= 182'h0; // @[OverlayRocc.scala 127:25]
      end
    end else begin
      catch_config_19 <= 182'h0; // @[OverlayRocc.scala 127:25]
    end
    if (io_cell_config[191]) begin // @[OverlayRocc.scala 130:39]
      if (6'h14 == unsigned_cell_config) begin // @[OverlayRocc.scala 131:44]
        catch_config_20 <= 182'h1; // @[OverlayRocc.scala 131:44]
      end else begin
        catch_config_20 <= 182'h0; // @[OverlayRocc.scala 127:25]
      end
    end else begin
      catch_config_20 <= 182'h0; // @[OverlayRocc.scala 127:25]
    end
    if (io_cell_config[191]) begin // @[OverlayRocc.scala 130:39]
      if (6'h15 == unsigned_cell_config) begin // @[OverlayRocc.scala 131:44]
        catch_config_21 <= 182'h1; // @[OverlayRocc.scala 131:44]
      end else begin
        catch_config_21 <= 182'h0; // @[OverlayRocc.scala 127:25]
      end
    end else begin
      catch_config_21 <= 182'h0; // @[OverlayRocc.scala 127:25]
    end
    if (io_cell_config[191]) begin // @[OverlayRocc.scala 130:39]
      if (6'h16 == unsigned_cell_config) begin // @[OverlayRocc.scala 131:44]
        catch_config_22 <= 182'h1; // @[OverlayRocc.scala 131:44]
      end else begin
        catch_config_22 <= 182'h0; // @[OverlayRocc.scala 127:25]
      end
    end else begin
      catch_config_22 <= 182'h0; // @[OverlayRocc.scala 127:25]
    end
    if (io_cell_config[191]) begin // @[OverlayRocc.scala 130:39]
      if (6'h17 == unsigned_cell_config) begin // @[OverlayRocc.scala 131:44]
        catch_config_23 <= 182'h1; // @[OverlayRocc.scala 131:44]
      end else begin
        catch_config_23 <= 182'h0; // @[OverlayRocc.scala 127:25]
      end
    end else begin
      catch_config_23 <= 182'h0; // @[OverlayRocc.scala 127:25]
    end
    if (io_cell_config[191]) begin // @[OverlayRocc.scala 130:39]
      if (6'h18 == unsigned_cell_config) begin // @[OverlayRocc.scala 131:44]
        catch_config_24 <= 182'h1; // @[OverlayRocc.scala 131:44]
      end else begin
        catch_config_24 <= 182'h0; // @[OverlayRocc.scala 127:25]
      end
    end else begin
      catch_config_24 <= 182'h0; // @[OverlayRocc.scala 127:25]
    end
    if (io_cell_config[191]) begin // @[OverlayRocc.scala 130:39]
      if (6'h19 == unsigned_cell_config) begin // @[OverlayRocc.scala 131:44]
        catch_config_25 <= 182'h1; // @[OverlayRocc.scala 131:44]
      end else begin
        catch_config_25 <= 182'h0; // @[OverlayRocc.scala 127:25]
      end
    end else begin
      catch_config_25 <= 182'h0; // @[OverlayRocc.scala 127:25]
    end
    if (io_cell_config[191]) begin // @[OverlayRocc.scala 130:39]
      if (6'h1a == unsigned_cell_config) begin // @[OverlayRocc.scala 131:44]
        catch_config_26 <= 182'h1; // @[OverlayRocc.scala 131:44]
      end else begin
        catch_config_26 <= 182'h0; // @[OverlayRocc.scala 127:25]
      end
    end else begin
      catch_config_26 <= 182'h0; // @[OverlayRocc.scala 127:25]
    end
    if (io_cell_config[191]) begin // @[OverlayRocc.scala 130:39]
      if (6'h1b == unsigned_cell_config) begin // @[OverlayRocc.scala 131:44]
        catch_config_27 <= 182'h1; // @[OverlayRocc.scala 131:44]
      end else begin
        catch_config_27 <= 182'h0; // @[OverlayRocc.scala 127:25]
      end
    end else begin
      catch_config_27 <= 182'h0; // @[OverlayRocc.scala 127:25]
    end
    if (io_cell_config[191]) begin // @[OverlayRocc.scala 130:39]
      if (6'h1c == unsigned_cell_config) begin // @[OverlayRocc.scala 131:44]
        catch_config_28 <= 182'h1; // @[OverlayRocc.scala 131:44]
      end else begin
        catch_config_28 <= 182'h0; // @[OverlayRocc.scala 127:25]
      end
    end else begin
      catch_config_28 <= 182'h0; // @[OverlayRocc.scala 127:25]
    end
    if (io_cell_config[191]) begin // @[OverlayRocc.scala 130:39]
      if (6'h1d == unsigned_cell_config) begin // @[OverlayRocc.scala 131:44]
        catch_config_29 <= 182'h1; // @[OverlayRocc.scala 131:44]
      end else begin
        catch_config_29 <= 182'h0; // @[OverlayRocc.scala 127:25]
      end
    end else begin
      catch_config_29 <= 182'h0; // @[OverlayRocc.scala 127:25]
    end
    if (io_cell_config[191]) begin // @[OverlayRocc.scala 130:39]
      if (6'h1e == unsigned_cell_config) begin // @[OverlayRocc.scala 131:44]
        catch_config_30 <= 182'h1; // @[OverlayRocc.scala 131:44]
      end else begin
        catch_config_30 <= 182'h0; // @[OverlayRocc.scala 127:25]
      end
    end else begin
      catch_config_30 <= 182'h0; // @[OverlayRocc.scala 127:25]
    end
    if (io_cell_config[191]) begin // @[OverlayRocc.scala 130:39]
      if (6'h1f == unsigned_cell_config) begin // @[OverlayRocc.scala 131:44]
        catch_config_31 <= 182'h1; // @[OverlayRocc.scala 131:44]
      end else begin
        catch_config_31 <= 182'h0; // @[OverlayRocc.scala 127:25]
      end
    end else begin
      catch_config_31 <= 182'h0; // @[OverlayRocc.scala 127:25]
    end
    if (io_cell_config[191]) begin // @[OverlayRocc.scala 130:39]
      if (6'h20 == unsigned_cell_config) begin // @[OverlayRocc.scala 131:44]
        catch_config_32 <= 182'h1; // @[OverlayRocc.scala 131:44]
      end else begin
        catch_config_32 <= 182'h0; // @[OverlayRocc.scala 127:25]
      end
    end else begin
      catch_config_32 <= 182'h0; // @[OverlayRocc.scala 127:25]
    end
    if (io_cell_config[191]) begin // @[OverlayRocc.scala 130:39]
      if (6'h21 == unsigned_cell_config) begin // @[OverlayRocc.scala 131:44]
        catch_config_33 <= 182'h1; // @[OverlayRocc.scala 131:44]
      end else begin
        catch_config_33 <= 182'h0; // @[OverlayRocc.scala 127:25]
      end
    end else begin
      catch_config_33 <= 182'h0; // @[OverlayRocc.scala 127:25]
    end
    if (io_cell_config[191]) begin // @[OverlayRocc.scala 130:39]
      if (6'h22 == unsigned_cell_config) begin // @[OverlayRocc.scala 131:44]
        catch_config_34 <= 182'h1; // @[OverlayRocc.scala 131:44]
      end else begin
        catch_config_34 <= 182'h0; // @[OverlayRocc.scala 127:25]
      end
    end else begin
      catch_config_34 <= 182'h0; // @[OverlayRocc.scala 127:25]
    end
    if (io_cell_config[191]) begin // @[OverlayRocc.scala 130:39]
      if (6'h23 == unsigned_cell_config) begin // @[OverlayRocc.scala 131:44]
        catch_config_35 <= 182'h1; // @[OverlayRocc.scala 131:44]
      end else begin
        catch_config_35 <= 182'h0; // @[OverlayRocc.scala 127:25]
      end
    end else begin
      catch_config_35 <= 182'h0; // @[OverlayRocc.scala 127:25]
    end
    if (io_cell_config[191]) begin // @[OverlayRocc.scala 130:39]
      if (6'h24 == unsigned_cell_config) begin // @[OverlayRocc.scala 131:44]
        catch_config_36 <= 182'h1; // @[OverlayRocc.scala 131:44]
      end else begin
        catch_config_36 <= 182'h0; // @[OverlayRocc.scala 127:25]
      end
    end else begin
      catch_config_36 <= 182'h0; // @[OverlayRocc.scala 127:25]
    end
    if (io_cell_config[191]) begin // @[OverlayRocc.scala 130:39]
      if (6'h25 == unsigned_cell_config) begin // @[OverlayRocc.scala 131:44]
        catch_config_37 <= 182'h1; // @[OverlayRocc.scala 131:44]
      end else begin
        catch_config_37 <= 182'h0; // @[OverlayRocc.scala 127:25]
      end
    end else begin
      catch_config_37 <= 182'h0; // @[OverlayRocc.scala 127:25]
    end
    if (io_cell_config[191]) begin // @[OverlayRocc.scala 130:39]
      if (6'h26 == unsigned_cell_config) begin // @[OverlayRocc.scala 131:44]
        catch_config_38 <= 182'h1; // @[OverlayRocc.scala 131:44]
      end else begin
        catch_config_38 <= 182'h0; // @[OverlayRocc.scala 127:25]
      end
    end else begin
      catch_config_38 <= 182'h0; // @[OverlayRocc.scala 127:25]
    end
    if (io_cell_config[191]) begin // @[OverlayRocc.scala 130:39]
      if (6'h27 == unsigned_cell_config) begin // @[OverlayRocc.scala 131:44]
        catch_config_39 <= 182'h1; // @[OverlayRocc.scala 131:44]
      end else begin
        catch_config_39 <= 182'h0; // @[OverlayRocc.scala 127:25]
      end
    end else begin
      catch_config_39 <= 182'h0; // @[OverlayRocc.scala 127:25]
    end
    if (io_cell_config[191]) begin // @[OverlayRocc.scala 130:39]
      if (6'h28 == unsigned_cell_config) begin // @[OverlayRocc.scala 131:44]
        catch_config_40 <= 182'h1; // @[OverlayRocc.scala 131:44]
      end else begin
        catch_config_40 <= 182'h0; // @[OverlayRocc.scala 127:25]
      end
    end else begin
      catch_config_40 <= 182'h0; // @[OverlayRocc.scala 127:25]
    end
    if (io_cell_config[191]) begin // @[OverlayRocc.scala 130:39]
      if (6'h29 == unsigned_cell_config) begin // @[OverlayRocc.scala 131:44]
        catch_config_41 <= 182'h1; // @[OverlayRocc.scala 131:44]
      end else begin
        catch_config_41 <= 182'h0; // @[OverlayRocc.scala 127:25]
      end
    end else begin
      catch_config_41 <= 182'h0; // @[OverlayRocc.scala 127:25]
    end
    if (io_cell_config[191]) begin // @[OverlayRocc.scala 130:39]
      if (6'h2a == unsigned_cell_config) begin // @[OverlayRocc.scala 131:44]
        catch_config_42 <= 182'h1; // @[OverlayRocc.scala 131:44]
      end else begin
        catch_config_42 <= 182'h0; // @[OverlayRocc.scala 127:25]
      end
    end else begin
      catch_config_42 <= 182'h0; // @[OverlayRocc.scala 127:25]
    end
    if (io_cell_config[191]) begin // @[OverlayRocc.scala 130:39]
      if (6'h2b == unsigned_cell_config) begin // @[OverlayRocc.scala 131:44]
        catch_config_43 <= 182'h1; // @[OverlayRocc.scala 131:44]
      end else begin
        catch_config_43 <= 182'h0; // @[OverlayRocc.scala 127:25]
      end
    end else begin
      catch_config_43 <= 182'h0; // @[OverlayRocc.scala 127:25]
    end
    if (io_cell_config[191]) begin // @[OverlayRocc.scala 130:39]
      if (6'h2c == unsigned_cell_config) begin // @[OverlayRocc.scala 131:44]
        catch_config_44 <= 182'h1; // @[OverlayRocc.scala 131:44]
      end else begin
        catch_config_44 <= 182'h0; // @[OverlayRocc.scala 127:25]
      end
    end else begin
      catch_config_44 <= 182'h0; // @[OverlayRocc.scala 127:25]
    end
    if (io_cell_config[191]) begin // @[OverlayRocc.scala 130:39]
      if (6'h2d == unsigned_cell_config) begin // @[OverlayRocc.scala 131:44]
        catch_config_45 <= 182'h1; // @[OverlayRocc.scala 131:44]
      end else begin
        catch_config_45 <= 182'h0; // @[OverlayRocc.scala 127:25]
      end
    end else begin
      catch_config_45 <= 182'h0; // @[OverlayRocc.scala 127:25]
    end
    if (io_cell_config[191]) begin // @[OverlayRocc.scala 130:39]
      if (6'h2e == unsigned_cell_config) begin // @[OverlayRocc.scala 131:44]
        catch_config_46 <= 182'h1; // @[OverlayRocc.scala 131:44]
      end else begin
        catch_config_46 <= 182'h0; // @[OverlayRocc.scala 127:25]
      end
    end else begin
      catch_config_46 <= 182'h0; // @[OverlayRocc.scala 127:25]
    end
    if (io_cell_config[191]) begin // @[OverlayRocc.scala 130:39]
      if (6'h2f == unsigned_cell_config) begin // @[OverlayRocc.scala 131:44]
        catch_config_47 <= 182'h1; // @[OverlayRocc.scala 131:44]
      end else begin
        catch_config_47 <= 182'h0; // @[OverlayRocc.scala 127:25]
      end
    end else begin
      catch_config_47 <= 182'h0; // @[OverlayRocc.scala 127:25]
    end
    if (io_cell_config[191]) begin // @[OverlayRocc.scala 130:39]
      if (6'h30 == unsigned_cell_config) begin // @[OverlayRocc.scala 131:44]
        catch_config_48 <= 182'h1; // @[OverlayRocc.scala 131:44]
      end else begin
        catch_config_48 <= 182'h0; // @[OverlayRocc.scala 127:25]
      end
    end else begin
      catch_config_48 <= 182'h0; // @[OverlayRocc.scala 127:25]
    end
    if (io_cell_config[191]) begin // @[OverlayRocc.scala 130:39]
      if (6'h31 == unsigned_cell_config) begin // @[OverlayRocc.scala 131:44]
        catch_config_49 <= 182'h1; // @[OverlayRocc.scala 131:44]
      end else begin
        catch_config_49 <= 182'h0; // @[OverlayRocc.scala 127:25]
      end
    end else begin
      catch_config_49 <= 182'h0; // @[OverlayRocc.scala 127:25]
    end
    if (io_cell_config[191]) begin // @[OverlayRocc.scala 130:39]
      if (6'h32 == unsigned_cell_config) begin // @[OverlayRocc.scala 131:44]
        catch_config_50 <= 182'h1; // @[OverlayRocc.scala 131:44]
      end else begin
        catch_config_50 <= 182'h0; // @[OverlayRocc.scala 127:25]
      end
    end else begin
      catch_config_50 <= 182'h0; // @[OverlayRocc.scala 127:25]
    end
    if (io_cell_config[191]) begin // @[OverlayRocc.scala 130:39]
      if (6'h33 == unsigned_cell_config) begin // @[OverlayRocc.scala 131:44]
        catch_config_51 <= 182'h1; // @[OverlayRocc.scala 131:44]
      end else begin
        catch_config_51 <= 182'h0; // @[OverlayRocc.scala 127:25]
      end
    end else begin
      catch_config_51 <= 182'h0; // @[OverlayRocc.scala 127:25]
    end
    if (io_cell_config[191]) begin // @[OverlayRocc.scala 130:39]
      if (6'h34 == unsigned_cell_config) begin // @[OverlayRocc.scala 131:44]
        catch_config_52 <= 182'h1; // @[OverlayRocc.scala 131:44]
      end else begin
        catch_config_52 <= 182'h0; // @[OverlayRocc.scala 127:25]
      end
    end else begin
      catch_config_52 <= 182'h0; // @[OverlayRocc.scala 127:25]
    end
    if (io_cell_config[191]) begin // @[OverlayRocc.scala 130:39]
      if (6'h35 == unsigned_cell_config) begin // @[OverlayRocc.scala 131:44]
        catch_config_53 <= 182'h1; // @[OverlayRocc.scala 131:44]
      end else begin
        catch_config_53 <= 182'h0; // @[OverlayRocc.scala 127:25]
      end
    end else begin
      catch_config_53 <= 182'h0; // @[OverlayRocc.scala 127:25]
    end
    if (io_cell_config[191]) begin // @[OverlayRocc.scala 130:39]
      if (6'h36 == unsigned_cell_config) begin // @[OverlayRocc.scala 131:44]
        catch_config_54 <= 182'h1; // @[OverlayRocc.scala 131:44]
      end else begin
        catch_config_54 <= 182'h0; // @[OverlayRocc.scala 127:25]
      end
    end else begin
      catch_config_54 <= 182'h0; // @[OverlayRocc.scala 127:25]
    end
    if (io_cell_config[191]) begin // @[OverlayRocc.scala 130:39]
      if (6'h37 == unsigned_cell_config) begin // @[OverlayRocc.scala 131:44]
        catch_config_55 <= 182'h1; // @[OverlayRocc.scala 131:44]
      end else begin
        catch_config_55 <= 182'h0; // @[OverlayRocc.scala 127:25]
      end
    end else begin
      catch_config_55 <= 182'h0; // @[OverlayRocc.scala 127:25]
    end
    if (io_cell_config[191]) begin // @[OverlayRocc.scala 130:39]
      if (6'h38 == unsigned_cell_config) begin // @[OverlayRocc.scala 131:44]
        catch_config_56 <= 182'h1; // @[OverlayRocc.scala 131:44]
      end else begin
        catch_config_56 <= 182'h0; // @[OverlayRocc.scala 127:25]
      end
    end else begin
      catch_config_56 <= 182'h0; // @[OverlayRocc.scala 127:25]
    end
    if (io_cell_config[191]) begin // @[OverlayRocc.scala 130:39]
      if (6'h39 == unsigned_cell_config) begin // @[OverlayRocc.scala 131:44]
        catch_config_57 <= 182'h1; // @[OverlayRocc.scala 131:44]
      end else begin
        catch_config_57 <= 182'h0; // @[OverlayRocc.scala 127:25]
      end
    end else begin
      catch_config_57 <= 182'h0; // @[OverlayRocc.scala 127:25]
    end
    if (io_cell_config[191]) begin // @[OverlayRocc.scala 130:39]
      if (6'h3a == unsigned_cell_config) begin // @[OverlayRocc.scala 131:44]
        catch_config_58 <= 182'h1; // @[OverlayRocc.scala 131:44]
      end else begin
        catch_config_58 <= 182'h0; // @[OverlayRocc.scala 127:25]
      end
    end else begin
      catch_config_58 <= 182'h0; // @[OverlayRocc.scala 127:25]
    end
    if (io_cell_config[191]) begin // @[OverlayRocc.scala 130:39]
      if (6'h3b == unsigned_cell_config) begin // @[OverlayRocc.scala 131:44]
        catch_config_59 <= 182'h1; // @[OverlayRocc.scala 131:44]
      end else begin
        catch_config_59 <= 182'h0; // @[OverlayRocc.scala 127:25]
      end
    end else begin
      catch_config_59 <= 182'h0; // @[OverlayRocc.scala 127:25]
    end
    if (io_cell_config[191]) begin // @[OverlayRocc.scala 130:39]
      if (6'h3c == unsigned_cell_config) begin // @[OverlayRocc.scala 131:44]
        catch_config_60 <= 182'h1; // @[OverlayRocc.scala 131:44]
      end else begin
        catch_config_60 <= 182'h0; // @[OverlayRocc.scala 127:25]
      end
    end else begin
      catch_config_60 <= 182'h0; // @[OverlayRocc.scala 127:25]
    end
    if (io_cell_config[191]) begin // @[OverlayRocc.scala 130:39]
      if (6'h3d == unsigned_cell_config) begin // @[OverlayRocc.scala 131:44]
        catch_config_61 <= 182'h1; // @[OverlayRocc.scala 131:44]
      end else begin
        catch_config_61 <= 182'h0; // @[OverlayRocc.scala 127:25]
      end
    end else begin
      catch_config_61 <= 182'h0; // @[OverlayRocc.scala 127:25]
    end
    if (io_cell_config[191]) begin // @[OverlayRocc.scala 130:39]
      if (6'h3e == unsigned_cell_config) begin // @[OverlayRocc.scala 131:44]
        catch_config_62 <= 182'h1; // @[OverlayRocc.scala 131:44]
      end else begin
        catch_config_62 <= 182'h0; // @[OverlayRocc.scala 127:25]
      end
    end else begin
      catch_config_62 <= 182'h0; // @[OverlayRocc.scala 127:25]
    end
    if (io_cell_config[191]) begin // @[OverlayRocc.scala 130:39]
      if (6'h3f == unsigned_cell_config) begin // @[OverlayRocc.scala 131:44]
        catch_config_63 <= 182'h1; // @[OverlayRocc.scala 131:44]
      end else begin
        catch_config_63 <= 182'h0; // @[OverlayRocc.scala 127:25]
      end
    end else begin
      catch_config_63 <= 182'h0; // @[OverlayRocc.scala 127:25]
    end
    reg_data_out_0 <= east_dout_0; // @[OverlayRocc.scala 147:25]
    reg_data_out_1 <= east_dout_1; // @[OverlayRocc.scala 147:25]
    reg_data_out_2 <= east_dout_2; // @[OverlayRocc.scala 147:25]
    reg_data_out_3 <= east_dout_3; // @[OverlayRocc.scala 147:25]
    reg_data_out_4 <= east_dout_4; // @[OverlayRocc.scala 147:25]
    reg_data_out_5 <= east_dout_5; // @[OverlayRocc.scala 147:25]
    reg_data_out_6 <= east_dout_6; // @[OverlayRocc.scala 147:25]
    reg_data_out_7 <= east_dout_7; // @[OverlayRocc.scala 147:25]
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
  north_din_0 = _RAND_0[31:0];
  _RAND_1 = {1{`RANDOM}};
  north_din_1 = _RAND_1[31:0];
  _RAND_2 = {1{`RANDOM}};
  north_din_2 = _RAND_2[31:0];
  _RAND_3 = {1{`RANDOM}};
  north_din_3 = _RAND_3[31:0];
  _RAND_4 = {1{`RANDOM}};
  north_din_4 = _RAND_4[31:0];
  _RAND_5 = {1{`RANDOM}};
  north_din_5 = _RAND_5[31:0];
  _RAND_6 = {1{`RANDOM}};
  north_din_6 = _RAND_6[31:0];
  _RAND_7 = {1{`RANDOM}};
  north_din_7 = _RAND_7[31:0];
  _RAND_8 = {1{`RANDOM}};
  north_din_v = _RAND_8[7:0];
  _RAND_9 = {1{`RANDOM}};
  east_dout_0 = _RAND_9[31:0];
  _RAND_10 = {1{`RANDOM}};
  east_dout_1 = _RAND_10[31:0];
  _RAND_11 = {1{`RANDOM}};
  east_dout_2 = _RAND_11[31:0];
  _RAND_12 = {1{`RANDOM}};
  east_dout_3 = _RAND_12[31:0];
  _RAND_13 = {1{`RANDOM}};
  east_dout_4 = _RAND_13[31:0];
  _RAND_14 = {1{`RANDOM}};
  east_dout_5 = _RAND_14[31:0];
  _RAND_15 = {1{`RANDOM}};
  east_dout_6 = _RAND_15[31:0];
  _RAND_16 = {1{`RANDOM}};
  east_dout_7 = _RAND_16[31:0];
  _RAND_17 = {1{`RANDOM}};
  east_dout_r = _RAND_17[7:0];
  _RAND_18 = {6{`RANDOM}};
  config_bits_0 = _RAND_18[181:0];
  _RAND_19 = {6{`RANDOM}};
  config_bits_1 = _RAND_19[181:0];
  _RAND_20 = {6{`RANDOM}};
  config_bits_2 = _RAND_20[181:0];
  _RAND_21 = {6{`RANDOM}};
  config_bits_3 = _RAND_21[181:0];
  _RAND_22 = {6{`RANDOM}};
  config_bits_4 = _RAND_22[181:0];
  _RAND_23 = {6{`RANDOM}};
  config_bits_5 = _RAND_23[181:0];
  _RAND_24 = {6{`RANDOM}};
  config_bits_6 = _RAND_24[181:0];
  _RAND_25 = {6{`RANDOM}};
  config_bits_7 = _RAND_25[181:0];
  _RAND_26 = {6{`RANDOM}};
  config_bits_8 = _RAND_26[181:0];
  _RAND_27 = {6{`RANDOM}};
  config_bits_9 = _RAND_27[181:0];
  _RAND_28 = {6{`RANDOM}};
  config_bits_10 = _RAND_28[181:0];
  _RAND_29 = {6{`RANDOM}};
  config_bits_11 = _RAND_29[181:0];
  _RAND_30 = {6{`RANDOM}};
  config_bits_12 = _RAND_30[181:0];
  _RAND_31 = {6{`RANDOM}};
  config_bits_13 = _RAND_31[181:0];
  _RAND_32 = {6{`RANDOM}};
  config_bits_14 = _RAND_32[181:0];
  _RAND_33 = {6{`RANDOM}};
  config_bits_15 = _RAND_33[181:0];
  _RAND_34 = {6{`RANDOM}};
  config_bits_16 = _RAND_34[181:0];
  _RAND_35 = {6{`RANDOM}};
  config_bits_17 = _RAND_35[181:0];
  _RAND_36 = {6{`RANDOM}};
  config_bits_18 = _RAND_36[181:0];
  _RAND_37 = {6{`RANDOM}};
  config_bits_19 = _RAND_37[181:0];
  _RAND_38 = {6{`RANDOM}};
  config_bits_20 = _RAND_38[181:0];
  _RAND_39 = {6{`RANDOM}};
  config_bits_21 = _RAND_39[181:0];
  _RAND_40 = {6{`RANDOM}};
  config_bits_22 = _RAND_40[181:0];
  _RAND_41 = {6{`RANDOM}};
  config_bits_23 = _RAND_41[181:0];
  _RAND_42 = {6{`RANDOM}};
  config_bits_24 = _RAND_42[181:0];
  _RAND_43 = {6{`RANDOM}};
  config_bits_25 = _RAND_43[181:0];
  _RAND_44 = {6{`RANDOM}};
  config_bits_26 = _RAND_44[181:0];
  _RAND_45 = {6{`RANDOM}};
  config_bits_27 = _RAND_45[181:0];
  _RAND_46 = {6{`RANDOM}};
  config_bits_28 = _RAND_46[181:0];
  _RAND_47 = {6{`RANDOM}};
  config_bits_29 = _RAND_47[181:0];
  _RAND_48 = {6{`RANDOM}};
  config_bits_30 = _RAND_48[181:0];
  _RAND_49 = {6{`RANDOM}};
  config_bits_31 = _RAND_49[181:0];
  _RAND_50 = {6{`RANDOM}};
  config_bits_32 = _RAND_50[181:0];
  _RAND_51 = {6{`RANDOM}};
  config_bits_33 = _RAND_51[181:0];
  _RAND_52 = {6{`RANDOM}};
  config_bits_34 = _RAND_52[181:0];
  _RAND_53 = {6{`RANDOM}};
  config_bits_35 = _RAND_53[181:0];
  _RAND_54 = {6{`RANDOM}};
  config_bits_36 = _RAND_54[181:0];
  _RAND_55 = {6{`RANDOM}};
  config_bits_37 = _RAND_55[181:0];
  _RAND_56 = {6{`RANDOM}};
  config_bits_38 = _RAND_56[181:0];
  _RAND_57 = {6{`RANDOM}};
  config_bits_39 = _RAND_57[181:0];
  _RAND_58 = {6{`RANDOM}};
  config_bits_40 = _RAND_58[181:0];
  _RAND_59 = {6{`RANDOM}};
  config_bits_41 = _RAND_59[181:0];
  _RAND_60 = {6{`RANDOM}};
  config_bits_42 = _RAND_60[181:0];
  _RAND_61 = {6{`RANDOM}};
  config_bits_43 = _RAND_61[181:0];
  _RAND_62 = {6{`RANDOM}};
  config_bits_44 = _RAND_62[181:0];
  _RAND_63 = {6{`RANDOM}};
  config_bits_45 = _RAND_63[181:0];
  _RAND_64 = {6{`RANDOM}};
  config_bits_46 = _RAND_64[181:0];
  _RAND_65 = {6{`RANDOM}};
  config_bits_47 = _RAND_65[181:0];
  _RAND_66 = {6{`RANDOM}};
  config_bits_48 = _RAND_66[181:0];
  _RAND_67 = {6{`RANDOM}};
  config_bits_49 = _RAND_67[181:0];
  _RAND_68 = {6{`RANDOM}};
  config_bits_50 = _RAND_68[181:0];
  _RAND_69 = {6{`RANDOM}};
  config_bits_51 = _RAND_69[181:0];
  _RAND_70 = {6{`RANDOM}};
  config_bits_52 = _RAND_70[181:0];
  _RAND_71 = {6{`RANDOM}};
  config_bits_53 = _RAND_71[181:0];
  _RAND_72 = {6{`RANDOM}};
  config_bits_54 = _RAND_72[181:0];
  _RAND_73 = {6{`RANDOM}};
  config_bits_55 = _RAND_73[181:0];
  _RAND_74 = {6{`RANDOM}};
  config_bits_56 = _RAND_74[181:0];
  _RAND_75 = {6{`RANDOM}};
  config_bits_57 = _RAND_75[181:0];
  _RAND_76 = {6{`RANDOM}};
  config_bits_58 = _RAND_76[181:0];
  _RAND_77 = {6{`RANDOM}};
  config_bits_59 = _RAND_77[181:0];
  _RAND_78 = {6{`RANDOM}};
  config_bits_60 = _RAND_78[181:0];
  _RAND_79 = {6{`RANDOM}};
  config_bits_61 = _RAND_79[181:0];
  _RAND_80 = {6{`RANDOM}};
  config_bits_62 = _RAND_80[181:0];
  _RAND_81 = {6{`RANDOM}};
  config_bits_63 = _RAND_81[181:0];
  _RAND_82 = {6{`RANDOM}};
  catch_config_0 = _RAND_82[181:0];
  _RAND_83 = {6{`RANDOM}};
  catch_config_1 = _RAND_83[181:0];
  _RAND_84 = {6{`RANDOM}};
  catch_config_2 = _RAND_84[181:0];
  _RAND_85 = {6{`RANDOM}};
  catch_config_3 = _RAND_85[181:0];
  _RAND_86 = {6{`RANDOM}};
  catch_config_4 = _RAND_86[181:0];
  _RAND_87 = {6{`RANDOM}};
  catch_config_5 = _RAND_87[181:0];
  _RAND_88 = {6{`RANDOM}};
  catch_config_6 = _RAND_88[181:0];
  _RAND_89 = {6{`RANDOM}};
  catch_config_7 = _RAND_89[181:0];
  _RAND_90 = {6{`RANDOM}};
  catch_config_8 = _RAND_90[181:0];
  _RAND_91 = {6{`RANDOM}};
  catch_config_9 = _RAND_91[181:0];
  _RAND_92 = {6{`RANDOM}};
  catch_config_10 = _RAND_92[181:0];
  _RAND_93 = {6{`RANDOM}};
  catch_config_11 = _RAND_93[181:0];
  _RAND_94 = {6{`RANDOM}};
  catch_config_12 = _RAND_94[181:0];
  _RAND_95 = {6{`RANDOM}};
  catch_config_13 = _RAND_95[181:0];
  _RAND_96 = {6{`RANDOM}};
  catch_config_14 = _RAND_96[181:0];
  _RAND_97 = {6{`RANDOM}};
  catch_config_15 = _RAND_97[181:0];
  _RAND_98 = {6{`RANDOM}};
  catch_config_16 = _RAND_98[181:0];
  _RAND_99 = {6{`RANDOM}};
  catch_config_17 = _RAND_99[181:0];
  _RAND_100 = {6{`RANDOM}};
  catch_config_18 = _RAND_100[181:0];
  _RAND_101 = {6{`RANDOM}};
  catch_config_19 = _RAND_101[181:0];
  _RAND_102 = {6{`RANDOM}};
  catch_config_20 = _RAND_102[181:0];
  _RAND_103 = {6{`RANDOM}};
  catch_config_21 = _RAND_103[181:0];
  _RAND_104 = {6{`RANDOM}};
  catch_config_22 = _RAND_104[181:0];
  _RAND_105 = {6{`RANDOM}};
  catch_config_23 = _RAND_105[181:0];
  _RAND_106 = {6{`RANDOM}};
  catch_config_24 = _RAND_106[181:0];
  _RAND_107 = {6{`RANDOM}};
  catch_config_25 = _RAND_107[181:0];
  _RAND_108 = {6{`RANDOM}};
  catch_config_26 = _RAND_108[181:0];
  _RAND_109 = {6{`RANDOM}};
  catch_config_27 = _RAND_109[181:0];
  _RAND_110 = {6{`RANDOM}};
  catch_config_28 = _RAND_110[181:0];
  _RAND_111 = {6{`RANDOM}};
  catch_config_29 = _RAND_111[181:0];
  _RAND_112 = {6{`RANDOM}};
  catch_config_30 = _RAND_112[181:0];
  _RAND_113 = {6{`RANDOM}};
  catch_config_31 = _RAND_113[181:0];
  _RAND_114 = {6{`RANDOM}};
  catch_config_32 = _RAND_114[181:0];
  _RAND_115 = {6{`RANDOM}};
  catch_config_33 = _RAND_115[181:0];
  _RAND_116 = {6{`RANDOM}};
  catch_config_34 = _RAND_116[181:0];
  _RAND_117 = {6{`RANDOM}};
  catch_config_35 = _RAND_117[181:0];
  _RAND_118 = {6{`RANDOM}};
  catch_config_36 = _RAND_118[181:0];
  _RAND_119 = {6{`RANDOM}};
  catch_config_37 = _RAND_119[181:0];
  _RAND_120 = {6{`RANDOM}};
  catch_config_38 = _RAND_120[181:0];
  _RAND_121 = {6{`RANDOM}};
  catch_config_39 = _RAND_121[181:0];
  _RAND_122 = {6{`RANDOM}};
  catch_config_40 = _RAND_122[181:0];
  _RAND_123 = {6{`RANDOM}};
  catch_config_41 = _RAND_123[181:0];
  _RAND_124 = {6{`RANDOM}};
  catch_config_42 = _RAND_124[181:0];
  _RAND_125 = {6{`RANDOM}};
  catch_config_43 = _RAND_125[181:0];
  _RAND_126 = {6{`RANDOM}};
  catch_config_44 = _RAND_126[181:0];
  _RAND_127 = {6{`RANDOM}};
  catch_config_45 = _RAND_127[181:0];
  _RAND_128 = {6{`RANDOM}};
  catch_config_46 = _RAND_128[181:0];
  _RAND_129 = {6{`RANDOM}};
  catch_config_47 = _RAND_129[181:0];
  _RAND_130 = {6{`RANDOM}};
  catch_config_48 = _RAND_130[181:0];
  _RAND_131 = {6{`RANDOM}};
  catch_config_49 = _RAND_131[181:0];
  _RAND_132 = {6{`RANDOM}};
  catch_config_50 = _RAND_132[181:0];
  _RAND_133 = {6{`RANDOM}};
  catch_config_51 = _RAND_133[181:0];
  _RAND_134 = {6{`RANDOM}};
  catch_config_52 = _RAND_134[181:0];
  _RAND_135 = {6{`RANDOM}};
  catch_config_53 = _RAND_135[181:0];
  _RAND_136 = {6{`RANDOM}};
  catch_config_54 = _RAND_136[181:0];
  _RAND_137 = {6{`RANDOM}};
  catch_config_55 = _RAND_137[181:0];
  _RAND_138 = {6{`RANDOM}};
  catch_config_56 = _RAND_138[181:0];
  _RAND_139 = {6{`RANDOM}};
  catch_config_57 = _RAND_139[181:0];
  _RAND_140 = {6{`RANDOM}};
  catch_config_58 = _RAND_140[181:0];
  _RAND_141 = {6{`RANDOM}};
  catch_config_59 = _RAND_141[181:0];
  _RAND_142 = {6{`RANDOM}};
  catch_config_60 = _RAND_142[181:0];
  _RAND_143 = {6{`RANDOM}};
  catch_config_61 = _RAND_143[181:0];
  _RAND_144 = {6{`RANDOM}};
  catch_config_62 = _RAND_144[181:0];
  _RAND_145 = {6{`RANDOM}};
  catch_config_63 = _RAND_145[181:0];
  _RAND_146 = {1{`RANDOM}};
  reg_data_out_0 = _RAND_146[31:0];
  _RAND_147 = {1{`RANDOM}};
  reg_data_out_1 = _RAND_147[31:0];
  _RAND_148 = {1{`RANDOM}};
  reg_data_out_2 = _RAND_148[31:0];
  _RAND_149 = {1{`RANDOM}};
  reg_data_out_3 = _RAND_149[31:0];
  _RAND_150 = {1{`RANDOM}};
  reg_data_out_4 = _RAND_150[31:0];
  _RAND_151 = {1{`RANDOM}};
  reg_data_out_5 = _RAND_151[31:0];
  _RAND_152 = {1{`RANDOM}};
  reg_data_out_6 = _RAND_152[31:0];
  _RAND_153 = {1{`RANDOM}};
  reg_data_out_7 = _RAND_153[31:0];
`endif // RANDOMIZE_REG_INIT
  `endif // RANDOMIZE
end // initial
`ifdef FIRRTL_AFTER_INITIAL
`FIRRTL_AFTER_INITIAL
`endif
`endif // SYNTHESIS
endmodule
