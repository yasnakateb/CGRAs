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
  wire  FIFO_Nin_clock; // @[ProcessingElement.scala 129:27]
  wire  FIFO_Nin_reset; // @[ProcessingElement.scala 129:27]
  wire [31:0] FIFO_Nin_io_din; // @[ProcessingElement.scala 129:27]
  wire  FIFO_Nin_io_din_v; // @[ProcessingElement.scala 129:27]
  wire  FIFO_Nin_io_dout_r; // @[ProcessingElement.scala 129:27]
  wire  FIFO_Nin_io_din_r; // @[ProcessingElement.scala 129:27]
  wire [31:0] FIFO_Nin_io_dout; // @[ProcessingElement.scala 129:27]
  wire  FIFO_Nin_io_dout_v; // @[ProcessingElement.scala 129:27]
  wire [4:0] FS_Nin_io_ready_out; // @[ProcessingElement.scala 137:25]
  wire [4:0] FS_Nin_io_fork_mask; // @[ProcessingElement.scala 137:25]
  wire  FS_Nin_io_ready_in; // @[ProcessingElement.scala 137:25]
  wire [1:0] MUX_Nout_io_selector; // @[ProcessingElement.scala 143:28]
  wire [127:0] MUX_Nout_io_mux_input; // @[ProcessingElement.scala 143:28]
  wire [31:0] MUX_Nout_io_mux_output; // @[ProcessingElement.scala 143:28]
  wire [3:0] FR_Nout_io_valid_in; // @[ProcessingElement.scala 148:26]
  wire [4:0] FR_Nout_io_ready_out; // @[ProcessingElement.scala 148:26]
  wire [1:0] FR_Nout_io_valid_mux_sel; // @[ProcessingElement.scala 148:26]
  wire [4:0] FR_Nout_io_fork_mask; // @[ProcessingElement.scala 148:26]
  wire  FR_Nout_io_valid_out; // @[ProcessingElement.scala 148:26]
  wire  REG_Nout_clock; // @[ProcessingElement.scala 157:27]
  wire  REG_Nout_reset; // @[ProcessingElement.scala 157:27]
  wire [31:0] REG_Nout_io_din; // @[ProcessingElement.scala 157:27]
  wire  REG_Nout_io_din_v; // @[ProcessingElement.scala 157:27]
  wire  REG_Nout_io_dout_r; // @[ProcessingElement.scala 157:27]
  wire [31:0] REG_Nout_io_dout; // @[ProcessingElement.scala 157:27]
  wire  REG_Nout_io_dout_v; // @[ProcessingElement.scala 157:27]
  wire  REG_Nout_io_din_r; // @[ProcessingElement.scala 157:27]
  wire  FIFO_Ein_clock; // @[ProcessingElement.scala 171:27]
  wire  FIFO_Ein_reset; // @[ProcessingElement.scala 171:27]
  wire [31:0] FIFO_Ein_io_din; // @[ProcessingElement.scala 171:27]
  wire  FIFO_Ein_io_din_v; // @[ProcessingElement.scala 171:27]
  wire  FIFO_Ein_io_dout_r; // @[ProcessingElement.scala 171:27]
  wire  FIFO_Ein_io_din_r; // @[ProcessingElement.scala 171:27]
  wire [31:0] FIFO_Ein_io_dout; // @[ProcessingElement.scala 171:27]
  wire  FIFO_Ein_io_dout_v; // @[ProcessingElement.scala 171:27]
  wire [4:0] FS_Ein_io_ready_out; // @[ProcessingElement.scala 179:25]
  wire [4:0] FS_Ein_io_fork_mask; // @[ProcessingElement.scala 179:25]
  wire  FS_Ein_io_ready_in; // @[ProcessingElement.scala 179:25]
  wire [1:0] MUX_Eout_io_selector; // @[ProcessingElement.scala 185:28]
  wire [127:0] MUX_Eout_io_mux_input; // @[ProcessingElement.scala 185:28]
  wire [31:0] MUX_Eout_io_mux_output; // @[ProcessingElement.scala 185:28]
  wire [3:0] FR_Eout_io_valid_in; // @[ProcessingElement.scala 190:26]
  wire [4:0] FR_Eout_io_ready_out; // @[ProcessingElement.scala 190:26]
  wire [1:0] FR_Eout_io_valid_mux_sel; // @[ProcessingElement.scala 190:26]
  wire [4:0] FR_Eout_io_fork_mask; // @[ProcessingElement.scala 190:26]
  wire  FR_Eout_io_valid_out; // @[ProcessingElement.scala 190:26]
  wire  REG_Eout_clock; // @[ProcessingElement.scala 199:27]
  wire  REG_Eout_reset; // @[ProcessingElement.scala 199:27]
  wire [31:0] REG_Eout_io_din; // @[ProcessingElement.scala 199:27]
  wire  REG_Eout_io_din_v; // @[ProcessingElement.scala 199:27]
  wire  REG_Eout_io_dout_r; // @[ProcessingElement.scala 199:27]
  wire [31:0] REG_Eout_io_dout; // @[ProcessingElement.scala 199:27]
  wire  REG_Eout_io_dout_v; // @[ProcessingElement.scala 199:27]
  wire  REG_Eout_io_din_r; // @[ProcessingElement.scala 199:27]
  wire  FIFO_Sin_clock; // @[ProcessingElement.scala 212:27]
  wire  FIFO_Sin_reset; // @[ProcessingElement.scala 212:27]
  wire [31:0] FIFO_Sin_io_din; // @[ProcessingElement.scala 212:27]
  wire  FIFO_Sin_io_din_v; // @[ProcessingElement.scala 212:27]
  wire  FIFO_Sin_io_dout_r; // @[ProcessingElement.scala 212:27]
  wire  FIFO_Sin_io_din_r; // @[ProcessingElement.scala 212:27]
  wire [31:0] FIFO_Sin_io_dout; // @[ProcessingElement.scala 212:27]
  wire  FIFO_Sin_io_dout_v; // @[ProcessingElement.scala 212:27]
  wire [4:0] FS_Sin_io_ready_out; // @[ProcessingElement.scala 220:25]
  wire [4:0] FS_Sin_io_fork_mask; // @[ProcessingElement.scala 220:25]
  wire  FS_Sin_io_ready_in; // @[ProcessingElement.scala 220:25]
  wire [1:0] MUX_Sout_io_selector; // @[ProcessingElement.scala 226:28]
  wire [127:0] MUX_Sout_io_mux_input; // @[ProcessingElement.scala 226:28]
  wire [31:0] MUX_Sout_io_mux_output; // @[ProcessingElement.scala 226:28]
  wire [3:0] FR_Sout_io_valid_in; // @[ProcessingElement.scala 231:26]
  wire [4:0] FR_Sout_io_ready_out; // @[ProcessingElement.scala 231:26]
  wire [1:0] FR_Sout_io_valid_mux_sel; // @[ProcessingElement.scala 231:26]
  wire [4:0] FR_Sout_io_fork_mask; // @[ProcessingElement.scala 231:26]
  wire  FR_Sout_io_valid_out; // @[ProcessingElement.scala 231:26]
  wire  REG_Sout_clock; // @[ProcessingElement.scala 240:27]
  wire  REG_Sout_reset; // @[ProcessingElement.scala 240:27]
  wire [31:0] REG_Sout_io_din; // @[ProcessingElement.scala 240:27]
  wire  REG_Sout_io_din_v; // @[ProcessingElement.scala 240:27]
  wire  REG_Sout_io_dout_r; // @[ProcessingElement.scala 240:27]
  wire [31:0] REG_Sout_io_dout; // @[ProcessingElement.scala 240:27]
  wire  REG_Sout_io_dout_v; // @[ProcessingElement.scala 240:27]
  wire  REG_Sout_io_din_r; // @[ProcessingElement.scala 240:27]
  wire  FIFO_Win_clock; // @[ProcessingElement.scala 253:27]
  wire  FIFO_Win_reset; // @[ProcessingElement.scala 253:27]
  wire [31:0] FIFO_Win_io_din; // @[ProcessingElement.scala 253:27]
  wire  FIFO_Win_io_din_v; // @[ProcessingElement.scala 253:27]
  wire  FIFO_Win_io_dout_r; // @[ProcessingElement.scala 253:27]
  wire  FIFO_Win_io_din_r; // @[ProcessingElement.scala 253:27]
  wire [31:0] FIFO_Win_io_dout; // @[ProcessingElement.scala 253:27]
  wire  FIFO_Win_io_dout_v; // @[ProcessingElement.scala 253:27]
  wire [4:0] FS_Win_io_ready_out; // @[ProcessingElement.scala 261:25]
  wire [4:0] FS_Win_io_fork_mask; // @[ProcessingElement.scala 261:25]
  wire  FS_Win_io_ready_in; // @[ProcessingElement.scala 261:25]
  wire [1:0] MUX_Wout_io_selector; // @[ProcessingElement.scala 267:28]
  wire [127:0] MUX_Wout_io_mux_input; // @[ProcessingElement.scala 267:28]
  wire [31:0] MUX_Wout_io_mux_output; // @[ProcessingElement.scala 267:28]
  wire [3:0] FR_Wout_io_valid_in; // @[ProcessingElement.scala 272:26]
  wire [4:0] FR_Wout_io_ready_out; // @[ProcessingElement.scala 272:26]
  wire [1:0] FR_Wout_io_valid_mux_sel; // @[ProcessingElement.scala 272:26]
  wire [4:0] FR_Wout_io_fork_mask; // @[ProcessingElement.scala 272:26]
  wire  FR_Wout_io_valid_out; // @[ProcessingElement.scala 272:26]
  wire  REG_Wout_clock; // @[ProcessingElement.scala 281:27]
  wire  REG_Wout_reset; // @[ProcessingElement.scala 281:27]
  wire [31:0] REG_Wout_io_din; // @[ProcessingElement.scala 281:27]
  wire  REG_Wout_io_din_v; // @[ProcessingElement.scala 281:27]
  wire  REG_Wout_io_dout_r; // @[ProcessingElement.scala 281:27]
  wire [31:0] REG_Wout_io_dout; // @[ProcessingElement.scala 281:27]
  wire  REG_Wout_io_dout_v; // @[ProcessingElement.scala 281:27]
  wire  REG_Wout_io_din_r; // @[ProcessingElement.scala 281:27]
  wire  CELL_clock; // @[ProcessingElement.scala 293:23]
  wire  CELL_reset; // @[ProcessingElement.scala 293:23]
  wire [31:0] CELL_io_north_din; // @[ProcessingElement.scala 293:23]
  wire  CELL_io_north_din_v; // @[ProcessingElement.scala 293:23]
  wire [31:0] CELL_io_east_din; // @[ProcessingElement.scala 293:23]
  wire  CELL_io_east_din_v; // @[ProcessingElement.scala 293:23]
  wire [31:0] CELL_io_south_din; // @[ProcessingElement.scala 293:23]
  wire  CELL_io_south_din_v; // @[ProcessingElement.scala 293:23]
  wire [31:0] CELL_io_west_din; // @[ProcessingElement.scala 293:23]
  wire  CELL_io_west_din_v; // @[ProcessingElement.scala 293:23]
  wire  CELL_io_FU_din_1_r; // @[ProcessingElement.scala 293:23]
  wire  CELL_io_FU_din_2_r; // @[ProcessingElement.scala 293:23]
  wire [31:0] CELL_io_dout; // @[ProcessingElement.scala 293:23]
  wire  CELL_io_dout_v; // @[ProcessingElement.scala 293:23]
  wire  CELL_io_north_dout_r; // @[ProcessingElement.scala 293:23]
  wire  CELL_io_east_dout_r; // @[ProcessingElement.scala 293:23]
  wire  CELL_io_south_dout_r; // @[ProcessingElement.scala 293:23]
  wire  CELL_io_west_dout_r; // @[ProcessingElement.scala 293:23]
  wire [181:0] CELL_io_config_bits; // @[ProcessingElement.scala 293:23]
  reg [1:0] mux_N_sel; // @[ProcessingElement.scala 57:28]
  reg [1:0] mux_E_sel; // @[ProcessingElement.scala 58:28]
  reg [1:0] mux_S_sel; // @[ProcessingElement.scala 59:28]
  reg [1:0] mux_W_sel; // @[ProcessingElement.scala 60:28]
  reg [4:0] accept_mask_frN; // @[ProcessingElement.scala 61:34]
  reg [4:0] accept_mask_frE; // @[ProcessingElement.scala 62:34]
  reg [4:0] accept_mask_frS; // @[ProcessingElement.scala 63:34]
  reg [4:0] accept_mask_frW; // @[ProcessingElement.scala 64:34]
  reg [4:0] accept_mask_fsiN; // @[ProcessingElement.scala 65:35]
  reg [4:0] accept_mask_fsiE; // @[ProcessingElement.scala 66:35]
  reg [4:0] accept_mask_fsiS; // @[ProcessingElement.scala 67:35]
  reg [4:0] accept_mask_fsiW; // @[ProcessingElement.scala 68:35]
  reg [181:0] config_bits_reg; // @[ProcessingElement.scala 69:34]
  reg [31:0] north_buffer; // @[ProcessingElement.scala 73:31]
  reg [31:0] east_buffer; // @[ProcessingElement.scala 74:30]
  reg [31:0] south_buffer; // @[ProcessingElement.scala 75:31]
  reg [31:0] west_buffer; // @[ProcessingElement.scala 76:30]
  reg  north_buffer_v; // @[ProcessingElement.scala 78:33]
  reg  east_buffer_v; // @[ProcessingElement.scala 79:32]
  reg  south_buffer_v; // @[ProcessingElement.scala 80:33]
  reg  west_buffer_v; // @[ProcessingElement.scala 81:32]
  reg  north_buffer_r; // @[ProcessingElement.scala 83:33]
  reg  east_buffer_r; // @[ProcessingElement.scala 84:32]
  reg  south_buffer_r; // @[ProcessingElement.scala 85:33]
  reg  west_buffer_r; // @[ProcessingElement.scala 86:32]
  reg [31:0] north_REG_din; // @[ProcessingElement.scala 88:32]
  reg [31:0] east_REG_din; // @[ProcessingElement.scala 89:31]
  reg [31:0] south_REG_din; // @[ProcessingElement.scala 90:32]
  reg [31:0] west_REG_din; // @[ProcessingElement.scala 91:31]
  reg  north_REG_din_v; // @[ProcessingElement.scala 92:34]
  reg  east_REG_din_v; // @[ProcessingElement.scala 93:33]
  reg  south_REG_din_v; // @[ProcessingElement.scala 94:34]
  reg  west_REG_din_v; // @[ProcessingElement.scala 95:33]
  reg  north_REG_din_r; // @[ProcessingElement.scala 96:34]
  reg  east_REG_din_r; // @[ProcessingElement.scala 97:33]
  reg  south_REG_din_r; // @[ProcessingElement.scala 98:34]
  reg  west_REG_din_r; // @[ProcessingElement.scala 99:33]
  reg  FU_din_1_r; // @[ProcessingElement.scala 101:29]
  reg  FU_din_2_r; // @[ProcessingElement.scala 102:29]
  reg [31:0] FU_dout; // @[ProcessingElement.scala 103:26]
  reg  FU_dout_v; // @[ProcessingElement.scala 104:28]
  wire [1:0] ready_out_FS_Nin_lo = {south_REG_din_r,west_REG_din_r}; // @[Cat.scala 31:58]
  wire [2:0] ready_out_FS_Nin_hi = {FU_din_1_r,FU_din_2_r,east_REG_din_r}; // @[Cat.scala 31:58]
  wire [31:0] _MUX_Nout_io_mux_input_T = west_buffer & south_buffer; // @[ProcessingElement.scala 145:42]
  wire [31:0] _MUX_Nout_io_mux_input_T_1 = _MUX_Nout_io_mux_input_T & east_buffer; // @[ProcessingElement.scala 145:57]
  wire [31:0] _MUX_Nout_io_mux_input_T_2 = _MUX_Nout_io_mux_input_T_1 & FU_dout; // @[ProcessingElement.scala 145:71]
  wire [1:0] valid_in_FR_Nout_lo = {east_buffer_v,FU_dout_v}; // @[Cat.scala 31:58]
  wire [1:0] valid_in_FR_Nout_hi = {west_buffer_v,south_buffer_v}; // @[Cat.scala 31:58]
  wire [2:0] ready_out_FS_Ein_hi = {FU_din_1_r,FU_din_2_r,north_REG_din_r}; // @[Cat.scala 31:58]
  wire [31:0] _MUX_Eout_io_mux_input_T_1 = _MUX_Nout_io_mux_input_T & north_buffer; // @[ProcessingElement.scala 187:57]
  wire [31:0] _MUX_Eout_io_mux_input_T_2 = _MUX_Eout_io_mux_input_T_1 & FU_dout; // @[ProcessingElement.scala 187:72]
  wire [1:0] valid_in_FR_Eout_lo = {north_buffer_v,FU_dout_v}; // @[Cat.scala 31:58]
  wire [1:0] ready_out_FS_Sin_lo = {east_REG_din_r,west_REG_din_r}; // @[Cat.scala 31:58]
  wire [31:0] _MUX_Sout_io_mux_input_T = west_buffer & east_buffer; // @[ProcessingElement.scala 228:42]
  wire [31:0] _MUX_Sout_io_mux_input_T_1 = _MUX_Sout_io_mux_input_T & north_buffer; // @[ProcessingElement.scala 228:56]
  wire [31:0] _MUX_Sout_io_mux_input_T_2 = _MUX_Sout_io_mux_input_T_1 & FU_dout; // @[ProcessingElement.scala 228:71]
  wire [1:0] valid_in_FR_Sout_hi = {west_buffer_v,east_buffer_v}; // @[Cat.scala 31:58]
  wire [1:0] ready_out_FS_Win_lo = {east_REG_din_r,south_REG_din_r}; // @[Cat.scala 31:58]
  wire [31:0] _MUX_Wout_io_mux_input_T = south_buffer & east_buffer; // @[ProcessingElement.scala 269:43]
  wire [31:0] _MUX_Wout_io_mux_input_T_1 = _MUX_Wout_io_mux_input_T & north_buffer; // @[ProcessingElement.scala 269:57]
  wire [31:0] _MUX_Wout_io_mux_input_T_2 = _MUX_Wout_io_mux_input_T_1 & FU_dout; // @[ProcessingElement.scala 269:72]
  wire [1:0] valid_in_FR_Wout_hi = {south_buffer_v,east_buffer_v}; // @[Cat.scala 31:58]
  D_FIFO FIFO_Nin ( // @[ProcessingElement.scala 129:27]
    .clock(FIFO_Nin_clock),
    .reset(FIFO_Nin_reset),
    .io_din(FIFO_Nin_io_din),
    .io_din_v(FIFO_Nin_io_din_v),
    .io_dout_r(FIFO_Nin_io_dout_r),
    .io_din_r(FIFO_Nin_io_din_r),
    .io_dout(FIFO_Nin_io_dout),
    .io_dout_v(FIFO_Nin_io_dout_v)
  );
  FS FS_Nin ( // @[ProcessingElement.scala 137:25]
    .io_ready_out(FS_Nin_io_ready_out),
    .io_fork_mask(FS_Nin_io_fork_mask),
    .io_ready_in(FS_Nin_io_ready_in)
  );
  ConfMux MUX_Nout ( // @[ProcessingElement.scala 143:28]
    .io_selector(MUX_Nout_io_selector),
    .io_mux_input(MUX_Nout_io_mux_input),
    .io_mux_output(MUX_Nout_io_mux_output)
  );
  FR FR_Nout ( // @[ProcessingElement.scala 148:26]
    .io_valid_in(FR_Nout_io_valid_in),
    .io_ready_out(FR_Nout_io_ready_out),
    .io_valid_mux_sel(FR_Nout_io_valid_mux_sel),
    .io_fork_mask(FR_Nout_io_fork_mask),
    .io_valid_out(FR_Nout_io_valid_out)
  );
  D_REG REG_Nout ( // @[ProcessingElement.scala 157:27]
    .clock(REG_Nout_clock),
    .reset(REG_Nout_reset),
    .io_din(REG_Nout_io_din),
    .io_din_v(REG_Nout_io_din_v),
    .io_dout_r(REG_Nout_io_dout_r),
    .io_dout(REG_Nout_io_dout),
    .io_dout_v(REG_Nout_io_dout_v),
    .io_din_r(REG_Nout_io_din_r)
  );
  D_FIFO FIFO_Ein ( // @[ProcessingElement.scala 171:27]
    .clock(FIFO_Ein_clock),
    .reset(FIFO_Ein_reset),
    .io_din(FIFO_Ein_io_din),
    .io_din_v(FIFO_Ein_io_din_v),
    .io_dout_r(FIFO_Ein_io_dout_r),
    .io_din_r(FIFO_Ein_io_din_r),
    .io_dout(FIFO_Ein_io_dout),
    .io_dout_v(FIFO_Ein_io_dout_v)
  );
  FS FS_Ein ( // @[ProcessingElement.scala 179:25]
    .io_ready_out(FS_Ein_io_ready_out),
    .io_fork_mask(FS_Ein_io_fork_mask),
    .io_ready_in(FS_Ein_io_ready_in)
  );
  ConfMux MUX_Eout ( // @[ProcessingElement.scala 185:28]
    .io_selector(MUX_Eout_io_selector),
    .io_mux_input(MUX_Eout_io_mux_input),
    .io_mux_output(MUX_Eout_io_mux_output)
  );
  FR FR_Eout ( // @[ProcessingElement.scala 190:26]
    .io_valid_in(FR_Eout_io_valid_in),
    .io_ready_out(FR_Eout_io_ready_out),
    .io_valid_mux_sel(FR_Eout_io_valid_mux_sel),
    .io_fork_mask(FR_Eout_io_fork_mask),
    .io_valid_out(FR_Eout_io_valid_out)
  );
  D_REG REG_Eout ( // @[ProcessingElement.scala 199:27]
    .clock(REG_Eout_clock),
    .reset(REG_Eout_reset),
    .io_din(REG_Eout_io_din),
    .io_din_v(REG_Eout_io_din_v),
    .io_dout_r(REG_Eout_io_dout_r),
    .io_dout(REG_Eout_io_dout),
    .io_dout_v(REG_Eout_io_dout_v),
    .io_din_r(REG_Eout_io_din_r)
  );
  D_FIFO FIFO_Sin ( // @[ProcessingElement.scala 212:27]
    .clock(FIFO_Sin_clock),
    .reset(FIFO_Sin_reset),
    .io_din(FIFO_Sin_io_din),
    .io_din_v(FIFO_Sin_io_din_v),
    .io_dout_r(FIFO_Sin_io_dout_r),
    .io_din_r(FIFO_Sin_io_din_r),
    .io_dout(FIFO_Sin_io_dout),
    .io_dout_v(FIFO_Sin_io_dout_v)
  );
  FS FS_Sin ( // @[ProcessingElement.scala 220:25]
    .io_ready_out(FS_Sin_io_ready_out),
    .io_fork_mask(FS_Sin_io_fork_mask),
    .io_ready_in(FS_Sin_io_ready_in)
  );
  ConfMux MUX_Sout ( // @[ProcessingElement.scala 226:28]
    .io_selector(MUX_Sout_io_selector),
    .io_mux_input(MUX_Sout_io_mux_input),
    .io_mux_output(MUX_Sout_io_mux_output)
  );
  FR FR_Sout ( // @[ProcessingElement.scala 231:26]
    .io_valid_in(FR_Sout_io_valid_in),
    .io_ready_out(FR_Sout_io_ready_out),
    .io_valid_mux_sel(FR_Sout_io_valid_mux_sel),
    .io_fork_mask(FR_Sout_io_fork_mask),
    .io_valid_out(FR_Sout_io_valid_out)
  );
  D_REG REG_Sout ( // @[ProcessingElement.scala 240:27]
    .clock(REG_Sout_clock),
    .reset(REG_Sout_reset),
    .io_din(REG_Sout_io_din),
    .io_din_v(REG_Sout_io_din_v),
    .io_dout_r(REG_Sout_io_dout_r),
    .io_dout(REG_Sout_io_dout),
    .io_dout_v(REG_Sout_io_dout_v),
    .io_din_r(REG_Sout_io_din_r)
  );
  D_FIFO FIFO_Win ( // @[ProcessingElement.scala 253:27]
    .clock(FIFO_Win_clock),
    .reset(FIFO_Win_reset),
    .io_din(FIFO_Win_io_din),
    .io_din_v(FIFO_Win_io_din_v),
    .io_dout_r(FIFO_Win_io_dout_r),
    .io_din_r(FIFO_Win_io_din_r),
    .io_dout(FIFO_Win_io_dout),
    .io_dout_v(FIFO_Win_io_dout_v)
  );
  FS FS_Win ( // @[ProcessingElement.scala 261:25]
    .io_ready_out(FS_Win_io_ready_out),
    .io_fork_mask(FS_Win_io_fork_mask),
    .io_ready_in(FS_Win_io_ready_in)
  );
  ConfMux MUX_Wout ( // @[ProcessingElement.scala 267:28]
    .io_selector(MUX_Wout_io_selector),
    .io_mux_input(MUX_Wout_io_mux_input),
    .io_mux_output(MUX_Wout_io_mux_output)
  );
  FR FR_Wout ( // @[ProcessingElement.scala 272:26]
    .io_valid_in(FR_Wout_io_valid_in),
    .io_ready_out(FR_Wout_io_ready_out),
    .io_valid_mux_sel(FR_Wout_io_valid_mux_sel),
    .io_fork_mask(FR_Wout_io_fork_mask),
    .io_valid_out(FR_Wout_io_valid_out)
  );
  D_REG REG_Wout ( // @[ProcessingElement.scala 281:27]
    .clock(REG_Wout_clock),
    .reset(REG_Wout_reset),
    .io_din(REG_Wout_io_din),
    .io_din_v(REG_Wout_io_din_v),
    .io_dout_r(REG_Wout_io_dout_r),
    .io_dout(REG_Wout_io_dout),
    .io_dout_v(REG_Wout_io_dout_v),
    .io_din_r(REG_Wout_io_din_r)
  );
  CellProcessing CELL ( // @[ProcessingElement.scala 293:23]
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
  assign io_north_din_r = FIFO_Nin_io_din_r; // @[ProcessingElement.scala 133:20]
  assign io_east_din_r = FIFO_Ein_io_din_r; // @[ProcessingElement.scala 175:19]
  assign io_south_din_r = FIFO_Sin_io_din_r; // @[ProcessingElement.scala 216:20]
  assign io_west_din_r = FIFO_Win_io_din_r; // @[ProcessingElement.scala 257:19]
  assign io_north_dout = REG_Nout_io_dout; // @[ProcessingElement.scala 164:19]
  assign io_north_dout_v = REG_Nout_io_dout_v; // @[ProcessingElement.scala 165:21]
  assign io_east_dout = REG_Eout_io_dout; // @[ProcessingElement.scala 206:18]
  assign io_east_dout_v = REG_Eout_io_dout_v; // @[ProcessingElement.scala 207:20]
  assign io_south_dout = REG_Sout_io_dout; // @[ProcessingElement.scala 247:19]
  assign io_south_dout_v = REG_Sout_io_dout_v; // @[ProcessingElement.scala 248:21]
  assign io_west_dout = REG_Wout_io_dout; // @[ProcessingElement.scala 288:18]
  assign io_west_dout_v = REG_Wout_io_dout_v; // @[ProcessingElement.scala 289:20]
  assign FIFO_Nin_clock = clock;
  assign FIFO_Nin_reset = reset;
  assign FIFO_Nin_io_din = io_north_din; // @[ProcessingElement.scala 130:21]
  assign FIFO_Nin_io_din_v = io_north_din_v; // @[ProcessingElement.scala 131:23]
  assign FIFO_Nin_io_dout_r = north_buffer_r; // @[ProcessingElement.scala 132:24]
  assign FS_Nin_io_ready_out = {ready_out_FS_Nin_hi,ready_out_FS_Nin_lo}; // @[Cat.scala 31:58]
  assign FS_Nin_io_fork_mask = accept_mask_fsiN; // @[ProcessingElement.scala 141:25]
  assign MUX_Nout_io_selector = mux_N_sel; // @[ProcessingElement.scala 144:26]
  assign MUX_Nout_io_mux_input = {{96'd0}, _MUX_Nout_io_mux_input_T_2}; // @[ProcessingElement.scala 145:27]
  assign FR_Nout_io_valid_in = {valid_in_FR_Nout_hi,valid_in_FR_Nout_lo}; // @[Cat.scala 31:58]
  assign FR_Nout_io_ready_out = {ready_out_FS_Nin_hi,ready_out_FS_Nin_lo}; // @[Cat.scala 31:58]
  assign FR_Nout_io_valid_mux_sel = mux_N_sel; // @[ProcessingElement.scala 153:30]
  assign FR_Nout_io_fork_mask = accept_mask_frN; // @[ProcessingElement.scala 154:26]
  assign REG_Nout_clock = clock;
  assign REG_Nout_reset = reset;
  assign REG_Nout_io_din = north_REG_din; // @[ProcessingElement.scala 159:21]
  assign REG_Nout_io_din_v = north_REG_din_v; // @[ProcessingElement.scala 160:23]
  assign REG_Nout_io_dout_r = io_north_dout_r; // @[ProcessingElement.scala 161:24]
  assign FIFO_Ein_clock = clock;
  assign FIFO_Ein_reset = reset;
  assign FIFO_Ein_io_din = io_east_din; // @[ProcessingElement.scala 172:21]
  assign FIFO_Ein_io_din_v = io_east_din_v; // @[ProcessingElement.scala 173:23]
  assign FIFO_Ein_io_dout_r = east_buffer_r; // @[ProcessingElement.scala 174:24]
  assign FS_Ein_io_ready_out = {ready_out_FS_Ein_hi,ready_out_FS_Nin_lo}; // @[Cat.scala 31:58]
  assign FS_Ein_io_fork_mask = accept_mask_fsiE; // @[ProcessingElement.scala 183:25]
  assign MUX_Eout_io_selector = mux_E_sel; // @[ProcessingElement.scala 186:26]
  assign MUX_Eout_io_mux_input = {{96'd0}, _MUX_Eout_io_mux_input_T_2}; // @[ProcessingElement.scala 187:27]
  assign FR_Eout_io_valid_in = {valid_in_FR_Nout_hi,valid_in_FR_Eout_lo}; // @[Cat.scala 31:58]
  assign FR_Eout_io_ready_out = {ready_out_FS_Ein_hi,ready_out_FS_Nin_lo}; // @[Cat.scala 31:58]
  assign FR_Eout_io_valid_mux_sel = mux_E_sel; // @[ProcessingElement.scala 195:30]
  assign FR_Eout_io_fork_mask = accept_mask_frE; // @[ProcessingElement.scala 196:26]
  assign REG_Eout_clock = clock;
  assign REG_Eout_reset = reset;
  assign REG_Eout_io_din = east_REG_din; // @[ProcessingElement.scala 201:21]
  assign REG_Eout_io_din_v = east_REG_din_v; // @[ProcessingElement.scala 202:23]
  assign REG_Eout_io_dout_r = io_east_dout_r; // @[ProcessingElement.scala 203:24]
  assign FIFO_Sin_clock = clock;
  assign FIFO_Sin_reset = reset;
  assign FIFO_Sin_io_din = io_south_din; // @[ProcessingElement.scala 213:21]
  assign FIFO_Sin_io_din_v = io_south_din_v; // @[ProcessingElement.scala 214:23]
  assign FIFO_Sin_io_dout_r = south_buffer_r; // @[ProcessingElement.scala 215:24]
  assign FS_Sin_io_ready_out = {ready_out_FS_Ein_hi,ready_out_FS_Sin_lo}; // @[Cat.scala 31:58]
  assign FS_Sin_io_fork_mask = accept_mask_fsiS; // @[ProcessingElement.scala 224:25]
  assign MUX_Sout_io_selector = mux_S_sel; // @[ProcessingElement.scala 227:26]
  assign MUX_Sout_io_mux_input = {{96'd0}, _MUX_Sout_io_mux_input_T_2}; // @[ProcessingElement.scala 228:27]
  assign FR_Sout_io_valid_in = {valid_in_FR_Sout_hi,valid_in_FR_Eout_lo}; // @[Cat.scala 31:58]
  assign FR_Sout_io_ready_out = {ready_out_FS_Ein_hi,ready_out_FS_Sin_lo}; // @[Cat.scala 31:58]
  assign FR_Sout_io_valid_mux_sel = mux_S_sel; // @[ProcessingElement.scala 236:30]
  assign FR_Sout_io_fork_mask = accept_mask_frS; // @[ProcessingElement.scala 237:26]
  assign REG_Sout_clock = clock;
  assign REG_Sout_reset = reset;
  assign REG_Sout_io_din = south_REG_din; // @[ProcessingElement.scala 242:21]
  assign REG_Sout_io_din_v = south_REG_din_v; // @[ProcessingElement.scala 243:23]
  assign REG_Sout_io_dout_r = io_south_dout_r; // @[ProcessingElement.scala 244:24]
  assign FIFO_Win_clock = clock;
  assign FIFO_Win_reset = reset;
  assign FIFO_Win_io_din = io_west_din; // @[ProcessingElement.scala 254:21]
  assign FIFO_Win_io_din_v = io_west_din_v; // @[ProcessingElement.scala 255:23]
  assign FIFO_Win_io_dout_r = west_buffer_r; // @[ProcessingElement.scala 256:24]
  assign FS_Win_io_ready_out = {ready_out_FS_Ein_hi,ready_out_FS_Win_lo}; // @[Cat.scala 31:58]
  assign FS_Win_io_fork_mask = accept_mask_fsiW; // @[ProcessingElement.scala 265:25]
  assign MUX_Wout_io_selector = mux_W_sel; // @[ProcessingElement.scala 268:26]
  assign MUX_Wout_io_mux_input = {{96'd0}, _MUX_Wout_io_mux_input_T_2}; // @[ProcessingElement.scala 269:27]
  assign FR_Wout_io_valid_in = {valid_in_FR_Wout_hi,valid_in_FR_Eout_lo}; // @[Cat.scala 31:58]
  assign FR_Wout_io_ready_out = {ready_out_FS_Ein_hi,ready_out_FS_Win_lo}; // @[Cat.scala 31:58]
  assign FR_Wout_io_valid_mux_sel = mux_W_sel; // @[ProcessingElement.scala 277:30]
  assign FR_Wout_io_fork_mask = accept_mask_frW; // @[ProcessingElement.scala 278:26]
  assign REG_Wout_clock = clock;
  assign REG_Wout_reset = reset;
  assign REG_Wout_io_din = west_REG_din; // @[ProcessingElement.scala 283:21]
  assign REG_Wout_io_din_v = west_REG_din_v; // @[ProcessingElement.scala 284:23]
  assign REG_Wout_io_dout_r = io_west_dout_r; // @[ProcessingElement.scala 285:24]
  assign CELL_clock = clock;
  assign CELL_reset = reset;
  assign CELL_io_north_din = north_buffer; // @[ProcessingElement.scala 294:23]
  assign CELL_io_north_din_v = north_buffer_v; // @[ProcessingElement.scala 295:25]
  assign CELL_io_east_din = east_buffer; // @[ProcessingElement.scala 296:22]
  assign CELL_io_east_din_v = east_buffer_v; // @[ProcessingElement.scala 297:24]
  assign CELL_io_south_din = south_buffer; // @[ProcessingElement.scala 298:23]
  assign CELL_io_south_din_v = south_buffer_v; // @[ProcessingElement.scala 299:25]
  assign CELL_io_west_din = west_buffer; // @[ProcessingElement.scala 300:22]
  assign CELL_io_west_din_v = west_buffer_v; // @[ProcessingElement.scala 301:24]
  assign CELL_io_north_dout_r = north_REG_din_r; // @[ProcessingElement.scala 302:26]
  assign CELL_io_east_dout_r = east_REG_din_r; // @[ProcessingElement.scala 303:25]
  assign CELL_io_south_dout_r = south_REG_din_r; // @[ProcessingElement.scala 304:26]
  assign CELL_io_west_dout_r = west_REG_din_r; // @[ProcessingElement.scala 305:25]
  assign CELL_io_config_bits = config_bits_reg; // @[ProcessingElement.scala 306:25]
  always @(posedge clock) begin
    if (reset) begin // @[ProcessingElement.scala 57:28]
      mux_N_sel <= 2'h0; // @[ProcessingElement.scala 57:28]
    end else begin
      mux_N_sel <= config_bits_reg[7:6]; // @[ProcessingElement.scala 112:15]
    end
    if (reset) begin // @[ProcessingElement.scala 58:28]
      mux_E_sel <= 2'h0; // @[ProcessingElement.scala 58:28]
    end else begin
      mux_E_sel <= config_bits_reg[9:8]; // @[ProcessingElement.scala 113:15]
    end
    if (reset) begin // @[ProcessingElement.scala 59:28]
      mux_S_sel <= 2'h0; // @[ProcessingElement.scala 59:28]
    end else begin
      mux_S_sel <= config_bits_reg[11:10]; // @[ProcessingElement.scala 114:15]
    end
    if (reset) begin // @[ProcessingElement.scala 60:28]
      mux_W_sel <= 2'h0; // @[ProcessingElement.scala 60:28]
    end else begin
      mux_W_sel <= config_bits_reg[13:12]; // @[ProcessingElement.scala 115:15]
    end
    if (reset) begin // @[ProcessingElement.scala 61:34]
      accept_mask_frN <= 5'h0; // @[ProcessingElement.scala 61:34]
    end else begin
      accept_mask_frN <= config_bits_reg[61:57]; // @[ProcessingElement.scala 122:21]
    end
    if (reset) begin // @[ProcessingElement.scala 62:34]
      accept_mask_frE <= 5'h0; // @[ProcessingElement.scala 62:34]
    end else begin
      accept_mask_frE <= config_bits_reg[66:62]; // @[ProcessingElement.scala 123:21]
    end
    if (reset) begin // @[ProcessingElement.scala 63:34]
      accept_mask_frS <= 5'h0; // @[ProcessingElement.scala 63:34]
    end else begin
      accept_mask_frS <= config_bits_reg[71:67]; // @[ProcessingElement.scala 124:21]
    end
    if (reset) begin // @[ProcessingElement.scala 64:34]
      accept_mask_frW <= 5'h0; // @[ProcessingElement.scala 64:34]
    end else begin
      accept_mask_frW <= config_bits_reg[76:72]; // @[ProcessingElement.scala 125:21]
    end
    if (reset) begin // @[ProcessingElement.scala 65:35]
      accept_mask_fsiN <= 5'h0; // @[ProcessingElement.scala 65:35]
    end else begin
      accept_mask_fsiN <= config_bits_reg[28:24]; // @[ProcessingElement.scala 117:22]
    end
    if (reset) begin // @[ProcessingElement.scala 66:35]
      accept_mask_fsiE <= 5'h0; // @[ProcessingElement.scala 66:35]
    end else begin
      accept_mask_fsiE <= config_bits_reg[33:29]; // @[ProcessingElement.scala 118:22]
    end
    if (reset) begin // @[ProcessingElement.scala 67:35]
      accept_mask_fsiS <= 5'h0; // @[ProcessingElement.scala 67:35]
    end else begin
      accept_mask_fsiS <= config_bits_reg[38:34]; // @[ProcessingElement.scala 119:22]
    end
    if (reset) begin // @[ProcessingElement.scala 68:35]
      accept_mask_fsiW <= 5'h0; // @[ProcessingElement.scala 68:35]
    end else begin
      accept_mask_fsiW <= config_bits_reg[43:39]; // @[ProcessingElement.scala 120:22]
    end
    if (reset) begin // @[ProcessingElement.scala 69:34]
      config_bits_reg <= 182'h0; // @[ProcessingElement.scala 69:34]
    end else if (io_catch_config) begin // @[ProcessingElement.scala 107:28]
      config_bits_reg <= io_config_bits; // @[ProcessingElement.scala 108:25]
    end
    if (reset) begin // @[ProcessingElement.scala 73:31]
      north_buffer <= 32'h0; // @[ProcessingElement.scala 73:31]
    end else begin
      north_buffer <= FIFO_Nin_io_dout; // @[ProcessingElement.scala 134:18]
    end
    if (reset) begin // @[ProcessingElement.scala 74:30]
      east_buffer <= 32'h0; // @[ProcessingElement.scala 74:30]
    end else begin
      east_buffer <= FIFO_Ein_io_dout; // @[ProcessingElement.scala 176:17]
    end
    if (reset) begin // @[ProcessingElement.scala 75:31]
      south_buffer <= 32'h0; // @[ProcessingElement.scala 75:31]
    end else begin
      south_buffer <= FIFO_Sin_io_dout; // @[ProcessingElement.scala 217:18]
    end
    if (reset) begin // @[ProcessingElement.scala 76:30]
      west_buffer <= 32'h0; // @[ProcessingElement.scala 76:30]
    end else begin
      west_buffer <= FIFO_Win_io_dout; // @[ProcessingElement.scala 258:17]
    end
    if (reset) begin // @[ProcessingElement.scala 78:33]
      north_buffer_v <= 1'h0; // @[ProcessingElement.scala 78:33]
    end else begin
      north_buffer_v <= FIFO_Nin_io_dout_v; // @[ProcessingElement.scala 135:20]
    end
    if (reset) begin // @[ProcessingElement.scala 79:32]
      east_buffer_v <= 1'h0; // @[ProcessingElement.scala 79:32]
    end else begin
      east_buffer_v <= FIFO_Ein_io_dout_v; // @[ProcessingElement.scala 177:19]
    end
    if (reset) begin // @[ProcessingElement.scala 80:33]
      south_buffer_v <= 1'h0; // @[ProcessingElement.scala 80:33]
    end else begin
      south_buffer_v <= FIFO_Sin_io_dout_v; // @[ProcessingElement.scala 218:20]
    end
    if (reset) begin // @[ProcessingElement.scala 81:32]
      west_buffer_v <= 1'h0; // @[ProcessingElement.scala 81:32]
    end else begin
      west_buffer_v <= FIFO_Win_io_dout_v; // @[ProcessingElement.scala 259:19]
    end
    if (reset) begin // @[ProcessingElement.scala 83:33]
      north_buffer_r <= 1'h0; // @[ProcessingElement.scala 83:33]
    end else begin
      north_buffer_r <= FS_Nin_io_ready_in; // @[ProcessingElement.scala 140:20]
    end
    if (reset) begin // @[ProcessingElement.scala 84:32]
      east_buffer_r <= 1'h0; // @[ProcessingElement.scala 84:32]
    end else begin
      east_buffer_r <= FS_Ein_io_ready_in; // @[ProcessingElement.scala 182:19]
    end
    if (reset) begin // @[ProcessingElement.scala 85:33]
      south_buffer_r <= 1'h0; // @[ProcessingElement.scala 85:33]
    end else begin
      south_buffer_r <= FS_Sin_io_ready_in; // @[ProcessingElement.scala 223:20]
    end
    if (reset) begin // @[ProcessingElement.scala 86:32]
      west_buffer_r <= 1'h0; // @[ProcessingElement.scala 86:32]
    end else begin
      west_buffer_r <= FS_Win_io_ready_in; // @[ProcessingElement.scala 264:19]
    end
    if (reset) begin // @[ProcessingElement.scala 88:32]
      north_REG_din <= 32'h0; // @[ProcessingElement.scala 88:32]
    end else begin
      north_REG_din <= MUX_Nout_io_mux_output; // @[ProcessingElement.scala 146:19]
    end
    if (reset) begin // @[ProcessingElement.scala 89:31]
      east_REG_din <= 32'h0; // @[ProcessingElement.scala 89:31]
    end else begin
      east_REG_din <= MUX_Eout_io_mux_output; // @[ProcessingElement.scala 188:18]
    end
    if (reset) begin // @[ProcessingElement.scala 90:32]
      south_REG_din <= 32'h0; // @[ProcessingElement.scala 90:32]
    end else begin
      south_REG_din <= MUX_Sout_io_mux_output; // @[ProcessingElement.scala 229:19]
    end
    if (reset) begin // @[ProcessingElement.scala 91:31]
      west_REG_din <= 32'h0; // @[ProcessingElement.scala 91:31]
    end else begin
      west_REG_din <= MUX_Wout_io_mux_output; // @[ProcessingElement.scala 270:18]
    end
    if (reset) begin // @[ProcessingElement.scala 92:34]
      north_REG_din_v <= 1'h0; // @[ProcessingElement.scala 92:34]
    end else begin
      north_REG_din_v <= FR_Nout_io_valid_out; // @[ProcessingElement.scala 155:21]
    end
    if (reset) begin // @[ProcessingElement.scala 93:33]
      east_REG_din_v <= 1'h0; // @[ProcessingElement.scala 93:33]
    end else begin
      east_REG_din_v <= FR_Eout_io_valid_out; // @[ProcessingElement.scala 197:20]
    end
    if (reset) begin // @[ProcessingElement.scala 94:34]
      south_REG_din_v <= 1'h0; // @[ProcessingElement.scala 94:34]
    end else begin
      south_REG_din_v <= FR_Sout_io_valid_out; // @[ProcessingElement.scala 238:21]
    end
    if (reset) begin // @[ProcessingElement.scala 95:33]
      west_REG_din_v <= 1'h0; // @[ProcessingElement.scala 95:33]
    end else begin
      west_REG_din_v <= FR_Wout_io_valid_out; // @[ProcessingElement.scala 279:20]
    end
    if (reset) begin // @[ProcessingElement.scala 96:34]
      north_REG_din_r <= 1'h0; // @[ProcessingElement.scala 96:34]
    end else begin
      north_REG_din_r <= REG_Nout_io_din_r; // @[ProcessingElement.scala 163:21]
    end
    if (reset) begin // @[ProcessingElement.scala 97:33]
      east_REG_din_r <= 1'h0; // @[ProcessingElement.scala 97:33]
    end else begin
      east_REG_din_r <= REG_Eout_io_din_r; // @[ProcessingElement.scala 205:20]
    end
    if (reset) begin // @[ProcessingElement.scala 98:34]
      south_REG_din_r <= 1'h0; // @[ProcessingElement.scala 98:34]
    end else begin
      south_REG_din_r <= REG_Sout_io_din_r; // @[ProcessingElement.scala 246:21]
    end
    if (reset) begin // @[ProcessingElement.scala 99:33]
      west_REG_din_r <= 1'h0; // @[ProcessingElement.scala 99:33]
    end else begin
      west_REG_din_r <= REG_Wout_io_din_r; // @[ProcessingElement.scala 287:20]
    end
    if (reset) begin // @[ProcessingElement.scala 101:29]
      FU_din_1_r <= 1'h0; // @[ProcessingElement.scala 101:29]
    end else begin
      FU_din_1_r <= CELL_io_FU_din_1_r; // @[ProcessingElement.scala 308:16]
    end
    if (reset) begin // @[ProcessingElement.scala 102:29]
      FU_din_2_r <= 1'h0; // @[ProcessingElement.scala 102:29]
    end else begin
      FU_din_2_r <= CELL_io_FU_din_2_r; // @[ProcessingElement.scala 309:16]
    end
    if (reset) begin // @[ProcessingElement.scala 103:26]
      FU_dout <= 32'h0; // @[ProcessingElement.scala 103:26]
    end else begin
      FU_dout <= CELL_io_dout; // @[ProcessingElement.scala 310:13]
    end
    if (reset) begin // @[ProcessingElement.scala 104:28]
      FU_dout_v <= 1'h0; // @[ProcessingElement.scala 104:28]
    end else begin
      FU_dout_v <= CELL_io_dout_v; // @[ProcessingElement.scala 311:15]
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
