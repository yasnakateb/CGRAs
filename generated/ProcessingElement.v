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
  reg [31:0] _RAND_6;
`endif // RANDOMIZE_REG_INIT
  reg [31:0] mem [0:31]; // @[D_FIFO.scala 59:26]
  wire  mem_io_dout_MPORT_en; // @[D_FIFO.scala 59:26]
  wire [4:0] mem_io_dout_MPORT_addr; // @[D_FIFO.scala 59:26]
  wire [31:0] mem_io_dout_MPORT_data; // @[D_FIFO.scala 59:26]
  wire [31:0] mem_MPORT_data; // @[D_FIFO.scala 59:26]
  wire [4:0] mem_MPORT_addr; // @[D_FIFO.scala 59:26]
  wire  mem_MPORT_mask; // @[D_FIFO.scala 59:26]
  wire  mem_MPORT_en; // @[D_FIFO.scala 59:26]
  reg  mem_io_dout_MPORT_en_pipe_0;
  reg [4:0] mem_io_dout_MPORT_addr_pipe_0;
  reg [4:0] cntWrite; // @[D_FIFO.scala 55:27]
  reg [4:0] cntRead; // @[D_FIFO.scala 56:26]
  reg [5:0] cntData; // @[D_FIFO.scala 57:26]
  reg  dout_v; // @[D_FIFO.scala 65:25]
  wire  full = cntData == 6'h20; // @[D_FIFO.scala 106:18]
  wire  _io_din_r_T = ~full; // @[D_FIFO.scala 67:17]
  wire  wen = io_din_v & _io_din_r_T; // @[D_FIFO.scala 68:21]
  wire  empty = cntData == 6'h0; // @[D_FIFO.scala 111:18]
  wire  _ren_T = ~empty; // @[D_FIFO.scala 69:24]
  wire  ren = io_dout_r & ~empty; // @[D_FIFO.scala 69:22]
  wire  _T_1 = wen & _io_din_r_T; // @[D_FIFO.scala 75:14]
  wire [5:0] _T_3 = 6'h20 - 6'h1; // @[D_FIFO.scala 76:40]
  wire [5:0] _GEN_17 = {{1'd0}, cntWrite}; // @[D_FIFO.scala 76:23]
  wire [4:0] _cntWrite_T_1 = cntWrite + 5'h1; // @[D_FIFO.scala 79:30]
  wire  _T_6 = ren & _ren_T; // @[D_FIFO.scala 84:14]
  wire [5:0] _GEN_18 = {{1'd0}, cntRead}; // @[D_FIFO.scala 85:22]
  wire [4:0] _cntRead_T_1 = cntRead + 5'h1; // @[D_FIFO.scala 88:32]
  wire [5:0] _cntData_T_1 = cntData + 6'h1; // @[D_FIFO.scala 94:28]
  wire [5:0] _cntData_T_3 = cntData - 6'h1; // @[D_FIFO.scala 96:28]
  assign mem_io_dout_MPORT_en = mem_io_dout_MPORT_en_pipe_0;
  assign mem_io_dout_MPORT_addr = mem_io_dout_MPORT_addr_pipe_0;
  assign mem_io_dout_MPORT_data = mem[mem_io_dout_MPORT_addr]; // @[D_FIFO.scala 59:26]
  assign mem_MPORT_data = io_din;
  assign mem_MPORT_addr = cntWrite;
  assign mem_MPORT_mask = 1'h1;
  assign mem_MPORT_en = wen & _io_din_r_T;
  assign io_din_r = ~full; // @[D_FIFO.scala 67:17]
  assign io_dout = mem_io_dout_MPORT_data; // @[D_FIFO.scala 103:13]
  assign io_dout_v = dout_v; // @[D_FIFO.scala 73:15]
  always @(posedge clock) begin
    if (mem_MPORT_en & mem_MPORT_mask) begin
      mem[mem_MPORT_addr] <= mem_MPORT_data; // @[D_FIFO.scala 59:26]
    end
    mem_io_dout_MPORT_en_pipe_0 <= 1'h1;
    if (1'h1) begin
      mem_io_dout_MPORT_addr_pipe_0 <= cntRead;
    end
    if (reset) begin // @[D_FIFO.scala 55:27]
      cntWrite <= 5'h0; // @[D_FIFO.scala 55:27]
    end else if (wen & _io_din_r_T) begin // @[D_FIFO.scala 75:23]
      if (_GEN_17 == _T_3) begin // @[D_FIFO.scala 76:47]
        cntWrite <= 5'h0; // @[D_FIFO.scala 77:18]
      end else begin
        cntWrite <= _cntWrite_T_1; // @[D_FIFO.scala 79:18]
      end
    end
    if (reset) begin // @[D_FIFO.scala 56:26]
      cntRead <= 5'h0; // @[D_FIFO.scala 56:26]
    end else if (ren & _ren_T) begin // @[D_FIFO.scala 84:24]
      if (_GEN_18 == _T_3) begin // @[D_FIFO.scala 85:46]
        cntRead <= 5'h0; // @[D_FIFO.scala 86:21]
      end else begin
        cntRead <= _cntRead_T_1; // @[D_FIFO.scala 88:21]
      end
    end
    if (reset) begin // @[D_FIFO.scala 57:26]
      cntData <= 6'h0; // @[D_FIFO.scala 57:26]
    end else if (_T_1 & ~_T_6) begin // @[D_FIFO.scala 93:44]
      cntData <= _cntData_T_1; // @[D_FIFO.scala 94:17]
    end else if (~_T_1 & _T_6) begin // @[D_FIFO.scala 95:53]
      cntData <= _cntData_T_3; // @[D_FIFO.scala 96:17]
    end
    dout_v <= io_dout_r & ~empty; // @[D_FIFO.scala 69:22]
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
    mem[initvar] = _RAND_0[31:0];
`endif // RANDOMIZE_MEM_INIT
`ifdef RANDOMIZE_REG_INIT
  _RAND_1 = {1{`RANDOM}};
  mem_io_dout_MPORT_en_pipe_0 = _RAND_1[0:0];
  _RAND_2 = {1{`RANDOM}};
  mem_io_dout_MPORT_addr_pipe_0 = _RAND_2[4:0];
  _RAND_3 = {1{`RANDOM}};
  cntWrite = _RAND_3[4:0];
  _RAND_4 = {1{`RANDOM}};
  cntRead = _RAND_4[4:0];
  _RAND_5 = {1{`RANDOM}};
  cntData = _RAND_5[5:0];
  _RAND_6 = {1{`RANDOM}};
  dout_v = _RAND_6[0:0];
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
  wire [31:0] inputs_0 = io_mux_input[31:0]; // @[ConfMux.scala 27:70]
  wire [31:0] inputs_1 = io_mux_input[63:32]; // @[ConfMux.scala 27:70]
  wire [31:0] inputs_2 = io_mux_input[95:64]; // @[ConfMux.scala 27:70]
  wire [31:0] inputs_3 = io_mux_input[127:96]; // @[ConfMux.scala 27:70]
  wire [31:0] _GEN_1 = 2'h1 == io_selector ? $signed(inputs_1) : $signed(inputs_0); // @[ConfMux.scala 29:{19,19}]
  wire [31:0] _GEN_2 = 2'h2 == io_selector ? $signed(inputs_2) : $signed(_GEN_1); // @[ConfMux.scala 29:{19,19}]
  assign io_mux_output = 2'h3 == io_selector ? $signed(inputs_3) : $signed(_GEN_2); // @[ConfMux.scala 29:{19,19}]
endmodule
module ConfMux_1(
  input  [1:0] io_selector,
  input  [3:0] io_mux_input,
  output       io_mux_output
);
  wire  inputs_0 = io_mux_input[0]; // @[ConfMux.scala 27:70]
  wire  inputs_1 = io_mux_input[1]; // @[ConfMux.scala 27:70]
  wire  inputs_2 = io_mux_input[2]; // @[ConfMux.scala 27:70]
  wire  inputs_3 = io_mux_input[3]; // @[ConfMux.scala 27:70]
  wire  _GEN_1 = 2'h1 == io_selector ? $signed(inputs_1) : $signed(inputs_0); // @[ConfMux.scala 29:{19,19}]
  wire  _GEN_2 = 2'h2 == io_selector ? $signed(inputs_2) : $signed(_GEN_1); // @[ConfMux.scala 29:{19,19}]
  assign io_mux_output = 2'h3 == io_selector ? $signed(inputs_3) : $signed(_GEN_2); // @[ConfMux.scala 29:{19,19}]
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
  wire  temp_1 = aux_0 & aux_1; // @[FR.scala 70:30]
  wire  temp_2 = temp_1 & aux_2; // @[FR.scala 70:30]
  wire  temp_3 = temp_2 & aux_3; // @[FR.scala 70:30]
  ConfMux_1 conf_mux ( // @[FR.scala 61:28]
    .io_selector(conf_mux_io_selector),
    .io_mux_input(conf_mux_io_mux_input),
    .io_mux_output(conf_mux_io_mux_output)
  );
  assign io_valid_out = temp_3 & conf_mux_io_mux_output; // @[FR.scala 70:30]
  assign conf_mux_io_selector = io_valid_mux_sel; // @[FR.scala 62:26]
  assign conf_mux_io_mux_input = io_valid_in; // @[FR.scala 63:44]
endmodule
module D_REG(
  input  [31:0] io_din,
  input         io_din_v,
  input         io_dout_r,
  output [31:0] io_dout,
  output        io_dout_v,
  output        io_din_r
);
  assign io_dout = io_dout_r ? $signed(io_din) : $signed(32'sh0); // @[D_REG.scala 55:10 58:33 59:14]
  assign io_dout_v = io_dout_r & io_din_v; // @[D_REG.scala 56:11 58:33 60:15]
  assign io_din_r = io_dout_r; // @[D_REG.scala 65:14]
endmodule
module ConfMux_8(
  input  [2:0] io_selector,
  input  [5:0] io_mux_input,
  output       io_mux_output
);
  wire  inputs_0 = io_mux_input[0]; // @[ConfMux.scala 27:70]
  wire  inputs_1 = io_mux_input[1]; // @[ConfMux.scala 27:70]
  wire  inputs_2 = io_mux_input[2]; // @[ConfMux.scala 27:70]
  wire  inputs_3 = io_mux_input[3]; // @[ConfMux.scala 27:70]
  wire  inputs_4 = io_mux_input[4]; // @[ConfMux.scala 27:70]
  wire  inputs_5 = io_mux_input[5]; // @[ConfMux.scala 27:70]
  wire  _GEN_1 = 3'h1 == io_selector ? $signed(inputs_1) : $signed(inputs_0); // @[ConfMux.scala 29:{19,19}]
  wire  _GEN_2 = 3'h2 == io_selector ? $signed(inputs_2) : $signed(_GEN_1); // @[ConfMux.scala 29:{19,19}]
  wire  _GEN_3 = 3'h3 == io_selector ? $signed(inputs_3) : $signed(_GEN_2); // @[ConfMux.scala 29:{19,19}]
  wire  _GEN_4 = 3'h4 == io_selector ? $signed(inputs_4) : $signed(_GEN_3); // @[ConfMux.scala 29:{19,19}]
  assign io_mux_output = 3'h5 == io_selector ? $signed(inputs_5) : $signed(_GEN_4); // @[ConfMux.scala 29:{19,19}]
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
  wire  temp_1 = aux_0 & aux_1; // @[FR.scala 70:30]
  wire  temp_2 = temp_1 & aux_2; // @[FR.scala 70:30]
  ConfMux_8 conf_mux ( // @[FR.scala 61:28]
    .io_selector(conf_mux_io_selector),
    .io_mux_input(conf_mux_io_mux_input),
    .io_mux_output(conf_mux_io_mux_output)
  );
  assign io_valid_out = temp_2 & conf_mux_io_mux_output; // @[FR.scala 70:30]
  assign conf_mux_io_selector = io_valid_mux_sel; // @[FR.scala 62:26]
  assign conf_mux_io_mux_input = io_valid_in; // @[FR.scala 63:44]
endmodule
module ConfMux_9(
  input  [2:0]   io_selector,
  input  [191:0] io_mux_input,
  output [31:0]  io_mux_output
);
  wire [31:0] inputs_0 = io_mux_input[31:0]; // @[ConfMux.scala 27:70]
  wire [31:0] inputs_1 = io_mux_input[63:32]; // @[ConfMux.scala 27:70]
  wire [31:0] inputs_2 = io_mux_input[95:64]; // @[ConfMux.scala 27:70]
  wire [31:0] inputs_3 = io_mux_input[127:96]; // @[ConfMux.scala 27:70]
  wire [31:0] inputs_4 = io_mux_input[159:128]; // @[ConfMux.scala 27:70]
  wire [31:0] inputs_5 = io_mux_input[191:160]; // @[ConfMux.scala 27:70]
  wire [31:0] _GEN_1 = 3'h1 == io_selector ? $signed(inputs_1) : $signed(inputs_0); // @[ConfMux.scala 29:{19,19}]
  wire [31:0] _GEN_2 = 3'h2 == io_selector ? $signed(inputs_2) : $signed(_GEN_1); // @[ConfMux.scala 29:{19,19}]
  wire [31:0] _GEN_3 = 3'h3 == io_selector ? $signed(inputs_3) : $signed(_GEN_2); // @[ConfMux.scala 29:{19,19}]
  wire [31:0] _GEN_4 = 3'h4 == io_selector ? $signed(inputs_4) : $signed(_GEN_3); // @[ConfMux.scala 29:{19,19}]
  assign io_mux_output = 3'h5 == io_selector ? $signed(inputs_5) : $signed(_GEN_4); // @[ConfMux.scala 29:{19,19}]
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
  wire [31:0] _out_aux_T_2 = $signed(io_din_1) + $signed(io_din_2); // @[ALU.scala 95:27]
  wire [63:0] _out_aux_T_3 = $signed(io_din_1) * $signed(io_din_2); // @[ALU.scala 98:27]
  wire [31:0] _out_aux_T_6 = $signed(io_din_1) - $signed(io_din_2); // @[ALU.scala 101:27]
  wire [524318:0] _GEN_10 = {{524287{io_din_1[31]}},io_din_1}; // @[ALU.scala 105:27]
  wire [524318:0] _out_aux_T_8 = $signed(_GEN_10) << io_din_2[18:0]; // @[ALU.scala 105:27]
  wire [31:0] _out_aux_T_10 = $signed(io_din_1) >>> io_din_2; // @[ALU.scala 108:27]
  wire [31:0] _out_aux_T_14 = io_din_1 >> io_din_2; // @[ALU.scala 111:55]
  wire [31:0] _out_aux_T_16 = $signed(io_din_1) & $signed(io_din_2); // @[ALU.scala 114:27]
  wire [31:0] _out_aux_T_18 = $signed(io_din_1) | $signed(io_din_2); // @[ALU.scala 117:27]
  wire [31:0] _out_aux_T_20 = $signed(io_din_1) ^ $signed(io_din_2); // @[ALU.scala 120:27]
  wire [31:0] _GEN_0 = io_op_config == 5'h8 ? $signed(_out_aux_T_20) : $signed(32'sh0); // @[ALU.scala 119:38 120:15 123:15]
  wire [31:0] _GEN_1 = io_op_config == 5'h7 ? $signed(_out_aux_T_18) : $signed(_GEN_0); // @[ALU.scala 116:37 117:15]
  wire [31:0] _GEN_2 = io_op_config == 5'h6 ? $signed(_out_aux_T_16) : $signed(_GEN_1); // @[ALU.scala 113:38 114:15]
  wire [31:0] _GEN_3 = io_op_config == 5'h5 ? $signed(_out_aux_T_14) : $signed(_GEN_2); // @[ALU.scala 110:38 111:15]
  wire [31:0] _GEN_4 = io_op_config == 5'h4 ? $signed(_out_aux_T_10) : $signed(_GEN_3); // @[ALU.scala 107:38 108:15]
  wire [524318:0] _GEN_5 = io_op_config == 5'h3 ? $signed(_out_aux_T_8) : $signed({{524287{_GEN_4[31]}},_GEN_4}); // @[ALU.scala 103:38 105:15]
  wire [524318:0] _GEN_6 = io_op_config == 5'h2 ? $signed({{524287{_out_aux_T_6[31]}},_out_aux_T_6}) : $signed(_GEN_5); // @[ALU.scala 100:38 101:15]
  wire [524318:0] _GEN_7 = io_op_config == 5'h1 ? $signed({{524255{_out_aux_T_3[63]}},_out_aux_T_3}) : $signed(_GEN_6); // @[ALU.scala 97:38 98:15]
  wire [524318:0] _GEN_8 = io_op_config == 5'h0 ? $signed({{524287{_out_aux_T_2[31]}},_out_aux_T_2}) : $signed(_GEN_7); // @[ALU.scala 94:33 95:15]
  assign io_dout = _GEN_8[31:0]; // @[ALU.scala 88:23]
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
  wire [31:0] ALU_io_din_1; // @[FU.scala 89:22]
  wire [31:0] ALU_io_din_2; // @[FU.scala 89:22]
  wire [4:0] ALU_io_op_config; // @[FU.scala 89:22]
  wire [31:0] ALU_io_dout; // @[FU.scala 89:22]
  reg [31:0] reg_dout; // @[FU.scala 75:27]
  reg [15:0] count; // @[FU.scala 78:24]
  reg  loaded; // @[FU.scala 84:25]
  reg  valid; // @[FU.scala 85:24]
  wire  _T = io_loop_source == 2'h0; // @[FU.scala 95:26]
  wire  _T_1 = io_loop_source == 2'h1; // @[FU.scala 99:31]
  wire  _T_2 = ~loaded; // @[FU.scala 100:22]
  wire [31:0] _GEN_0 = ~loaded ? $signed(io_din_1) : $signed(reg_dout); // @[FU.scala 100:31 101:23 106:23]
  wire  _T_3 = io_loop_source == 2'h2; // @[FU.scala 110:31]
  wire [31:0] _GEN_3 = _T_2 ? $signed(io_din_2) : $signed(reg_dout); // @[FU.scala 111:31 113:23 117:23]
  wire [31:0] _GEN_4 = io_loop_source == 2'h2 ? $signed(io_din_1) : $signed(32'sh1f); // @[FU.scala 110:44 121:19]
  wire [31:0] _GEN_5 = io_loop_source == 2'h2 ? $signed(_GEN_3) : $signed(32'sh1f); // @[FU.scala 110:44 122:19]
  wire [31:0] _GEN_6 = io_loop_source == 2'h1 ? $signed(_GEN_0) : $signed(_GEN_4); // @[FU.scala 99:44]
  wire [31:0] _GEN_7 = io_loop_source == 2'h1 ? $signed(io_din_2) : $signed(_GEN_5); // @[FU.scala 99:44]
  wire  _GEN_10 = io_dout_r ? 1'h0 : valid; // @[FU.scala 125:30 126:15 85:24]
  wire  _T_11 = _T_1 | _T_3; // @[FU.scala 130:41]
  wire  _T_12 = io_din_v & io_dout_r & _T_11; // @[FU.scala 129:49]
  wire [15:0] _count_T_1 = count + 16'h1; // @[FU.scala 133:24]
  wire  _GEN_11 = _T_12 | loaded; // @[FU.scala 131:9 132:16 84:25]
  wire [15:0] _T_14 = io_iterations_reset - 16'h1; // @[FU.scala 136:41]
  wire  _T_19 = count == _T_14 & _T_11; // @[FU.scala 136:47]
  wire  _T_21 = _T_19 & io_dout_r; // @[FU.scala 137:72]
  wire  _T_26 = _T_11 & io_din_v; // @[FU.scala 145:75]
  wire  _T_28 = _T_26 & io_dout_r; // @[FU.scala 146:34]
  wire [31:0] alu_dout = ALU_io_dout; // @[FU.scala 74:24 92:14]
  wire  _GEN_16 = _T_21 | _GEN_10; // @[FU.scala 139:9 142:15]
  ALU ALU ( // @[FU.scala 89:22]
    .io_din_1(ALU_io_din_1),
    .io_din_2(ALU_io_din_2),
    .io_op_config(ALU_io_op_config),
    .io_dout(ALU_io_dout)
  );
  assign io_din_r = io_dout_r; // @[FU.scala 152:14]
  assign io_dout = _T ? $signed(alu_dout) : $signed(reg_dout); // @[FU.scala 154:38 155:17 159:17]
  assign io_dout_v = _T ? io_din_v : valid; // @[FU.scala 154:38 156:19 160:19]
  assign ALU_io_din_1 = io_loop_source == 2'h0 ? $signed(io_din_1) : $signed(_GEN_6); // @[FU.scala 95:39 96:19]
  assign ALU_io_din_2 = io_loop_source == 2'h0 ? $signed(io_din_2) : $signed(_GEN_7); // @[FU.scala 95:39 97:19]
  assign ALU_io_op_config = io_op_config; // @[FU.scala 93:22]
  always @(posedge clock) begin
    if (reset) begin // @[FU.scala 75:27]
      reg_dout <= 32'sh0; // @[FU.scala 75:27]
    end else if (_T_21) begin // @[FU.scala 139:9]
      reg_dout <= alu_dout; // @[FU.scala 143:18]
    end else if (_T_28) begin // @[FU.scala 148:9]
      reg_dout <= alu_dout; // @[FU.scala 149:18]
    end
    if (reset) begin // @[FU.scala 78:24]
      count <= 16'h0; // @[FU.scala 78:24]
    end else if (_T_21) begin // @[FU.scala 139:9]
      count <= 16'h0; // @[FU.scala 140:15]
    end else if (_T_12) begin // @[FU.scala 131:9]
      count <= _count_T_1; // @[FU.scala 133:15]
    end
    if (reset) begin // @[FU.scala 84:25]
      loaded <= 1'h0; // @[FU.scala 84:25]
    end else if (_T_21) begin // @[FU.scala 139:9]
      loaded <= 1'h0; // @[FU.scala 141:16]
    end else begin
      loaded <= _GEN_11;
    end
    if (reset) begin // @[FU.scala 85:24]
      valid <= 1'h0; // @[FU.scala 85:24]
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
  reg_dout = _RAND_0[31:0];
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
  wire [5:0] FR_1_io_valid_in; // @[CellProcessing.scala 168:23]
  wire [3:0] FR_1_io_ready_out; // @[CellProcessing.scala 168:23]
  wire [2:0] FR_1_io_valid_mux_sel; // @[CellProcessing.scala 168:23]
  wire [3:0] FR_1_io_fork_mask; // @[CellProcessing.scala 168:23]
  wire  FR_1_io_valid_out; // @[CellProcessing.scala 168:23]
  wire [2:0] MUX_1_io_selector; // @[CellProcessing.scala 177:24]
  wire [191:0] MUX_1_io_mux_input; // @[CellProcessing.scala 177:24]
  wire [31:0] MUX_1_io_mux_output; // @[CellProcessing.scala 177:24]
  wire [5:0] FR_2_io_valid_in; // @[CellProcessing.scala 185:23]
  wire [3:0] FR_2_io_ready_out; // @[CellProcessing.scala 185:23]
  wire [2:0] FR_2_io_valid_mux_sel; // @[CellProcessing.scala 185:23]
  wire [3:0] FR_2_io_fork_mask; // @[CellProcessing.scala 185:23]
  wire  FR_2_io_valid_out; // @[CellProcessing.scala 185:23]
  wire [2:0] MUX_2_io_selector; // @[CellProcessing.scala 194:24]
  wire [191:0] MUX_2_io_mux_input; // @[CellProcessing.scala 194:24]
  wire [31:0] MUX_2_io_mux_output; // @[CellProcessing.scala 194:24]
  wire  EB_1_clock; // @[CellProcessing.scala 202:23]
  wire  EB_1_reset; // @[CellProcessing.scala 202:23]
  wire [31:0] EB_1_io_din; // @[CellProcessing.scala 202:23]
  wire  EB_1_io_din_v; // @[CellProcessing.scala 202:23]
  wire  EB_1_io_din_r; // @[CellProcessing.scala 202:23]
  wire [31:0] EB_1_io_dout; // @[CellProcessing.scala 202:23]
  wire  EB_1_io_dout_v; // @[CellProcessing.scala 202:23]
  wire  EB_1_io_dout_r; // @[CellProcessing.scala 202:23]
  wire  EB_2_clock; // @[CellProcessing.scala 218:23]
  wire  EB_2_reset; // @[CellProcessing.scala 218:23]
  wire [31:0] EB_2_io_din; // @[CellProcessing.scala 218:23]
  wire  EB_2_io_din_v; // @[CellProcessing.scala 218:23]
  wire  EB_2_io_din_r; // @[CellProcessing.scala 218:23]
  wire [31:0] EB_2_io_dout; // @[CellProcessing.scala 218:23]
  wire  EB_2_io_dout_v; // @[CellProcessing.scala 218:23]
  wire  EB_2_io_dout_r; // @[CellProcessing.scala 218:23]
  wire [31:0] JOIN_INST_io_din_1; // @[CellProcessing.scala 234:28]
  wire [31:0] JOIN_INST_io_din_2; // @[CellProcessing.scala 234:28]
  wire  JOIN_INST_io_dout_r; // @[CellProcessing.scala 234:28]
  wire  JOIN_INST_io_din_1_v; // @[CellProcessing.scala 234:28]
  wire  JOIN_INST_io_din_2_v; // @[CellProcessing.scala 234:28]
  wire  JOIN_INST_io_dout_v; // @[CellProcessing.scala 234:28]
  wire  JOIN_INST_io_din_1_r; // @[CellProcessing.scala 234:28]
  wire  JOIN_INST_io_din_2_r; // @[CellProcessing.scala 234:28]
  wire [31:0] JOIN_INST_io_dout_1; // @[CellProcessing.scala 234:28]
  wire [31:0] JOIN_INST_io_dout_2; // @[CellProcessing.scala 234:28]
  wire  FU_INST_clock; // @[CellProcessing.scala 264:26]
  wire  FU_INST_reset; // @[CellProcessing.scala 264:26]
  wire [31:0] FU_INST_io_din_1; // @[CellProcessing.scala 264:26]
  wire [31:0] FU_INST_io_din_2; // @[CellProcessing.scala 264:26]
  wire  FU_INST_io_din_v; // @[CellProcessing.scala 264:26]
  wire  FU_INST_io_dout_r; // @[CellProcessing.scala 264:26]
  wire [1:0] FU_INST_io_loop_source; // @[CellProcessing.scala 264:26]
  wire [15:0] FU_INST_io_iterations_reset; // @[CellProcessing.scala 264:26]
  wire [4:0] FU_INST_io_op_config; // @[CellProcessing.scala 264:26]
  wire  FU_INST_io_din_r; // @[CellProcessing.scala 264:26]
  wire [31:0] FU_INST_io_dout; // @[CellProcessing.scala 264:26]
  wire  FU_INST_io_dout_v; // @[CellProcessing.scala 264:26]
  wire  EB_OUT_clock; // @[CellProcessing.scala 284:25]
  wire  EB_OUT_reset; // @[CellProcessing.scala 284:25]
  wire [31:0] EB_OUT_io_din; // @[CellProcessing.scala 284:25]
  wire  EB_OUT_io_din_v; // @[CellProcessing.scala 284:25]
  wire  EB_OUT_io_din_r; // @[CellProcessing.scala 284:25]
  wire [31:0] EB_OUT_io_dout; // @[CellProcessing.scala 284:25]
  wire  EB_OUT_io_dout_v; // @[CellProcessing.scala 284:25]
  wire  EB_OUT_io_dout_r; // @[CellProcessing.scala 284:25]
  wire [4:0] FS_io_ready_out; // @[CellProcessing.scala 299:21]
  wire [4:0] FS_io_fork_mask; // @[CellProcessing.scala 299:21]
  wire  FS_io_ready_in; // @[CellProcessing.scala 299:21]
  wire [31:0] I1_const = io_config_bits[115:84]; // @[CellProcessing.scala 162:32]
  wire [1:0] ready_FR1_lo = {io_south_dout_r,io_west_dout_r}; // @[Cat.scala 31:58]
  wire [1:0] ready_FR1_hi = {io_north_dout_r,io_east_dout_r}; // @[Cat.scala 31:58]
  wire [2:0] valid_in_FR1_lo = {io_south_din_v,io_east_din_v,io_north_din_v}; // @[Cat.scala 31:58]
  wire  FU_dout_v = FU_INST_io_dout_v; // @[CellProcessing.scala 131:25 280:15]
  wire [2:0] valid_in_FR1_hi = {FU_dout_v,1'h1,io_west_din_v}; // @[Cat.scala 31:58]
  wire [2:0] ready_out_FS_hi = {1'h1,io_north_dout_r,io_east_dout_r}; // @[Cat.scala 31:58]
  FR_4 FR_1 ( // @[CellProcessing.scala 168:23]
    .io_valid_in(FR_1_io_valid_in),
    .io_ready_out(FR_1_io_ready_out),
    .io_valid_mux_sel(FR_1_io_valid_mux_sel),
    .io_fork_mask(FR_1_io_fork_mask),
    .io_valid_out(FR_1_io_valid_out)
  );
  ConfMux_9 MUX_1 ( // @[CellProcessing.scala 177:24]
    .io_selector(MUX_1_io_selector),
    .io_mux_input(MUX_1_io_mux_input),
    .io_mux_output(MUX_1_io_mux_output)
  );
  FR_4 FR_2 ( // @[CellProcessing.scala 185:23]
    .io_valid_in(FR_2_io_valid_in),
    .io_ready_out(FR_2_io_ready_out),
    .io_valid_mux_sel(FR_2_io_valid_mux_sel),
    .io_fork_mask(FR_2_io_fork_mask),
    .io_valid_out(FR_2_io_valid_out)
  );
  ConfMux_9 MUX_2 ( // @[CellProcessing.scala 194:24]
    .io_selector(MUX_2_io_selector),
    .io_mux_input(MUX_2_io_mux_input),
    .io_mux_output(MUX_2_io_mux_output)
  );
  D_EB EB_1 ( // @[CellProcessing.scala 202:23]
    .clock(EB_1_clock),
    .reset(EB_1_reset),
    .io_din(EB_1_io_din),
    .io_din_v(EB_1_io_din_v),
    .io_din_r(EB_1_io_din_r),
    .io_dout(EB_1_io_dout),
    .io_dout_v(EB_1_io_dout_v),
    .io_dout_r(EB_1_io_dout_r)
  );
  D_EB EB_2 ( // @[CellProcessing.scala 218:23]
    .clock(EB_2_clock),
    .reset(EB_2_reset),
    .io_din(EB_2_io_din),
    .io_din_v(EB_2_io_din_v),
    .io_din_r(EB_2_io_din_r),
    .io_dout(EB_2_io_dout),
    .io_dout_v(EB_2_io_dout_v),
    .io_dout_r(EB_2_io_dout_r)
  );
  Join JOIN_INST ( // @[CellProcessing.scala 234:28]
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
  FU FU_INST ( // @[CellProcessing.scala 264:26]
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
  D_EB EB_OUT ( // @[CellProcessing.scala 284:25]
    .clock(EB_OUT_clock),
    .reset(EB_OUT_reset),
    .io_din(EB_OUT_io_din),
    .io_din_v(EB_OUT_io_din_v),
    .io_din_r(EB_OUT_io_din_r),
    .io_dout(EB_OUT_io_dout),
    .io_dout_v(EB_OUT_io_dout_v),
    .io_dout_r(EB_OUT_io_dout_r)
  );
  FS FS ( // @[CellProcessing.scala 299:21]
    .io_ready_out(FS_io_ready_out),
    .io_fork_mask(FS_io_fork_mask),
    .io_ready_in(FS_io_ready_in)
  );
  assign io_FU_din_1_r = EB_1_io_din_r; // @[CellProcessing.scala 209:19]
  assign io_FU_din_2_r = EB_2_io_din_r; // @[CellProcessing.scala 225:19]
  assign io_dout = EB_OUT_io_dout; // @[CellProcessing.scala 295:13]
  assign io_dout_v = EB_OUT_io_dout_v; // @[CellProcessing.scala 296:15]
  assign FR_1_io_valid_in = {valid_in_FR1_hi,valid_in_FR1_lo}; // @[Cat.scala 31:58]
  assign FR_1_io_ready_out = {ready_FR1_hi,ready_FR1_lo}; // @[Cat.scala 31:58]
  assign FR_1_io_valid_mux_sel = io_config_bits[2:0]; // @[CellProcessing.scala 152:37]
  assign FR_1_io_fork_mask = io_config_bits[17:14]; // @[CellProcessing.scala 154:43]
  assign MUX_1_io_selector = io_config_bits[2:0]; // @[CellProcessing.scala 152:37]
  assign MUX_1_io_mux_input = {FU_INST_io_dout,I1_const,io_west_din,io_south_din,io_east_din,io_north_din}; // @[CellProcessing.scala 179:106]
  assign FR_2_io_valid_in = {valid_in_FR1_hi,valid_in_FR1_lo}; // @[Cat.scala 31:58]
  assign FR_2_io_ready_out = {ready_FR1_hi,ready_FR1_lo}; // @[Cat.scala 31:58]
  assign FR_2_io_valid_mux_sel = io_config_bits[5:3]; // @[CellProcessing.scala 153:37]
  assign FR_2_io_fork_mask = io_config_bits[23:20]; // @[CellProcessing.scala 156:43]
  assign MUX_2_io_selector = io_config_bits[5:3]; // @[CellProcessing.scala 153:37]
  assign MUX_2_io_mux_input = {FU_INST_io_dout,I1_const,io_west_din,io_south_din,io_east_din,io_north_din}; // @[CellProcessing.scala 196:106]
  assign EB_1_clock = clock;
  assign EB_1_reset = reset;
  assign EB_1_io_din = MUX_1_io_mux_output; // @[CellProcessing.scala 107:24 183:14]
  assign EB_1_io_din_v = FR_1_io_valid_out; // @[CellProcessing.scala 134:26 175:16]
  assign EB_1_io_dout_r = JOIN_INST_io_din_1_r; // @[CellProcessing.scala 141:28 255:18]
  assign EB_2_clock = clock;
  assign EB_2_reset = reset;
  assign EB_2_io_din = MUX_2_io_mux_output; // @[CellProcessing.scala 223:17]
  assign EB_2_io_din_v = FR_2_io_valid_out; // @[CellProcessing.scala 135:26 192:16]
  assign EB_2_io_dout_r = JOIN_INST_io_din_2_r; // @[CellProcessing.scala 146:28 256:18]
  assign JOIN_INST_io_din_1 = EB_1_io_dout; // @[CellProcessing.scala 241:24]
  assign JOIN_INST_io_din_2 = EB_2_io_dout; // @[CellProcessing.scala 242:24]
  assign JOIN_INST_io_dout_r = FU_INST_io_din_r; // @[CellProcessing.scala 148:27 274:17]
  assign JOIN_INST_io_din_1_v = EB_1_io_dout_v; // @[CellProcessing.scala 251:26]
  assign JOIN_INST_io_din_2_v = EB_2_io_dout_v; // @[CellProcessing.scala 252:26]
  assign FU_INST_clock = clock;
  assign FU_INST_reset = reset;
  assign FU_INST_io_din_1 = JOIN_INST_io_dout_1; // @[CellProcessing.scala 127:27 261:17]
  assign FU_INST_io_din_2 = JOIN_INST_io_dout_2; // @[CellProcessing.scala 128:27 262:17]
  assign FU_INST_io_din_v = JOIN_INST_io_dout_v; // @[CellProcessing.scala 147:27 254:17]
  assign FU_INST_io_dout_r = EB_OUT_io_din_r; // @[CellProcessing.scala 133:25 294:15]
  assign FU_INST_io_loop_source = io_config_bits[181:180]; // @[CellProcessing.scala 166:41]
  assign FU_INST_io_iterations_reset = io_config_bits[179:164]; // @[CellProcessing.scala 165:44]
  assign FU_INST_io_op_config = io_config_bits[48:44]; // @[CellProcessing.scala 158:32]
  assign EB_OUT_clock = clock;
  assign EB_OUT_reset = reset;
  assign EB_OUT_io_din = FU_INST_io_dout; // @[CellProcessing.scala 291:19]
  assign EB_OUT_io_din_v = FU_INST_io_dout_v; // @[CellProcessing.scala 292:21]
  assign EB_OUT_io_dout_r = FS_io_ready_in; // @[CellProcessing.scala 149:29 302:19]
  assign FS_io_ready_out = {ready_out_FS_hi,ready_FR1_lo}; // @[Cat.scala 31:58]
  assign FS_io_fork_mask = io_config_bits[56:52]; // @[CellProcessing.scala 160:39]
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
  wire  FIFO_Nin_clock; // @[ProcessingElement.scala 213:27]
  wire  FIFO_Nin_reset; // @[ProcessingElement.scala 213:27]
  wire [31:0] FIFO_Nin_io_din; // @[ProcessingElement.scala 213:27]
  wire  FIFO_Nin_io_din_v; // @[ProcessingElement.scala 213:27]
  wire  FIFO_Nin_io_dout_r; // @[ProcessingElement.scala 213:27]
  wire  FIFO_Nin_io_din_r; // @[ProcessingElement.scala 213:27]
  wire [31:0] FIFO_Nin_io_dout; // @[ProcessingElement.scala 213:27]
  wire  FIFO_Nin_io_dout_v; // @[ProcessingElement.scala 213:27]
  wire [4:0] FS_Nin_io_ready_out; // @[ProcessingElement.scala 221:25]
  wire [4:0] FS_Nin_io_fork_mask; // @[ProcessingElement.scala 221:25]
  wire  FS_Nin_io_ready_in; // @[ProcessingElement.scala 221:25]
  wire [1:0] MUX_Nout_io_selector; // @[ProcessingElement.scala 227:28]
  wire [127:0] MUX_Nout_io_mux_input; // @[ProcessingElement.scala 227:28]
  wire [31:0] MUX_Nout_io_mux_output; // @[ProcessingElement.scala 227:28]
  wire [3:0] FR_Nout_io_valid_in; // @[ProcessingElement.scala 232:26]
  wire [4:0] FR_Nout_io_ready_out; // @[ProcessingElement.scala 232:26]
  wire [1:0] FR_Nout_io_valid_mux_sel; // @[ProcessingElement.scala 232:26]
  wire [4:0] FR_Nout_io_fork_mask; // @[ProcessingElement.scala 232:26]
  wire  FR_Nout_io_valid_out; // @[ProcessingElement.scala 232:26]
  wire [31:0] REG_Nout_io_din; // @[ProcessingElement.scala 241:27]
  wire  REG_Nout_io_din_v; // @[ProcessingElement.scala 241:27]
  wire  REG_Nout_io_dout_r; // @[ProcessingElement.scala 241:27]
  wire [31:0] REG_Nout_io_dout; // @[ProcessingElement.scala 241:27]
  wire  REG_Nout_io_dout_v; // @[ProcessingElement.scala 241:27]
  wire  REG_Nout_io_din_r; // @[ProcessingElement.scala 241:27]
  wire  FIFO_Ein_clock; // @[ProcessingElement.scala 255:27]
  wire  FIFO_Ein_reset; // @[ProcessingElement.scala 255:27]
  wire [31:0] FIFO_Ein_io_din; // @[ProcessingElement.scala 255:27]
  wire  FIFO_Ein_io_din_v; // @[ProcessingElement.scala 255:27]
  wire  FIFO_Ein_io_dout_r; // @[ProcessingElement.scala 255:27]
  wire  FIFO_Ein_io_din_r; // @[ProcessingElement.scala 255:27]
  wire [31:0] FIFO_Ein_io_dout; // @[ProcessingElement.scala 255:27]
  wire  FIFO_Ein_io_dout_v; // @[ProcessingElement.scala 255:27]
  wire [4:0] FS_Ein_io_ready_out; // @[ProcessingElement.scala 263:25]
  wire [4:0] FS_Ein_io_fork_mask; // @[ProcessingElement.scala 263:25]
  wire  FS_Ein_io_ready_in; // @[ProcessingElement.scala 263:25]
  wire [1:0] MUX_Eout_io_selector; // @[ProcessingElement.scala 269:28]
  wire [127:0] MUX_Eout_io_mux_input; // @[ProcessingElement.scala 269:28]
  wire [31:0] MUX_Eout_io_mux_output; // @[ProcessingElement.scala 269:28]
  wire [3:0] FR_Eout_io_valid_in; // @[ProcessingElement.scala 274:26]
  wire [4:0] FR_Eout_io_ready_out; // @[ProcessingElement.scala 274:26]
  wire [1:0] FR_Eout_io_valid_mux_sel; // @[ProcessingElement.scala 274:26]
  wire [4:0] FR_Eout_io_fork_mask; // @[ProcessingElement.scala 274:26]
  wire  FR_Eout_io_valid_out; // @[ProcessingElement.scala 274:26]
  wire [31:0] REG_Eout_io_din; // @[ProcessingElement.scala 283:27]
  wire  REG_Eout_io_din_v; // @[ProcessingElement.scala 283:27]
  wire  REG_Eout_io_dout_r; // @[ProcessingElement.scala 283:27]
  wire [31:0] REG_Eout_io_dout; // @[ProcessingElement.scala 283:27]
  wire  REG_Eout_io_dout_v; // @[ProcessingElement.scala 283:27]
  wire  REG_Eout_io_din_r; // @[ProcessingElement.scala 283:27]
  wire  FIFO_Sin_clock; // @[ProcessingElement.scala 296:27]
  wire  FIFO_Sin_reset; // @[ProcessingElement.scala 296:27]
  wire [31:0] FIFO_Sin_io_din; // @[ProcessingElement.scala 296:27]
  wire  FIFO_Sin_io_din_v; // @[ProcessingElement.scala 296:27]
  wire  FIFO_Sin_io_dout_r; // @[ProcessingElement.scala 296:27]
  wire  FIFO_Sin_io_din_r; // @[ProcessingElement.scala 296:27]
  wire [31:0] FIFO_Sin_io_dout; // @[ProcessingElement.scala 296:27]
  wire  FIFO_Sin_io_dout_v; // @[ProcessingElement.scala 296:27]
  wire [4:0] FS_Sin_io_ready_out; // @[ProcessingElement.scala 304:25]
  wire [4:0] FS_Sin_io_fork_mask; // @[ProcessingElement.scala 304:25]
  wire  FS_Sin_io_ready_in; // @[ProcessingElement.scala 304:25]
  wire [1:0] MUX_Sout_io_selector; // @[ProcessingElement.scala 310:28]
  wire [127:0] MUX_Sout_io_mux_input; // @[ProcessingElement.scala 310:28]
  wire [31:0] MUX_Sout_io_mux_output; // @[ProcessingElement.scala 310:28]
  wire [3:0] FR_Sout_io_valid_in; // @[ProcessingElement.scala 315:26]
  wire [4:0] FR_Sout_io_ready_out; // @[ProcessingElement.scala 315:26]
  wire [1:0] FR_Sout_io_valid_mux_sel; // @[ProcessingElement.scala 315:26]
  wire [4:0] FR_Sout_io_fork_mask; // @[ProcessingElement.scala 315:26]
  wire  FR_Sout_io_valid_out; // @[ProcessingElement.scala 315:26]
  wire [31:0] REG_Sout_io_din; // @[ProcessingElement.scala 324:27]
  wire  REG_Sout_io_din_v; // @[ProcessingElement.scala 324:27]
  wire  REG_Sout_io_dout_r; // @[ProcessingElement.scala 324:27]
  wire [31:0] REG_Sout_io_dout; // @[ProcessingElement.scala 324:27]
  wire  REG_Sout_io_dout_v; // @[ProcessingElement.scala 324:27]
  wire  REG_Sout_io_din_r; // @[ProcessingElement.scala 324:27]
  wire  FIFO_Win_clock; // @[ProcessingElement.scala 337:27]
  wire  FIFO_Win_reset; // @[ProcessingElement.scala 337:27]
  wire [31:0] FIFO_Win_io_din; // @[ProcessingElement.scala 337:27]
  wire  FIFO_Win_io_din_v; // @[ProcessingElement.scala 337:27]
  wire  FIFO_Win_io_dout_r; // @[ProcessingElement.scala 337:27]
  wire  FIFO_Win_io_din_r; // @[ProcessingElement.scala 337:27]
  wire [31:0] FIFO_Win_io_dout; // @[ProcessingElement.scala 337:27]
  wire  FIFO_Win_io_dout_v; // @[ProcessingElement.scala 337:27]
  wire [4:0] FS_Win_io_ready_out; // @[ProcessingElement.scala 345:25]
  wire [4:0] FS_Win_io_fork_mask; // @[ProcessingElement.scala 345:25]
  wire  FS_Win_io_ready_in; // @[ProcessingElement.scala 345:25]
  wire [1:0] MUX_Wout_io_selector; // @[ProcessingElement.scala 352:28]
  wire [127:0] MUX_Wout_io_mux_input; // @[ProcessingElement.scala 352:28]
  wire [31:0] MUX_Wout_io_mux_output; // @[ProcessingElement.scala 352:28]
  wire [3:0] FR_Wout_io_valid_in; // @[ProcessingElement.scala 357:26]
  wire [4:0] FR_Wout_io_ready_out; // @[ProcessingElement.scala 357:26]
  wire [1:0] FR_Wout_io_valid_mux_sel; // @[ProcessingElement.scala 357:26]
  wire [4:0] FR_Wout_io_fork_mask; // @[ProcessingElement.scala 357:26]
  wire  FR_Wout_io_valid_out; // @[ProcessingElement.scala 357:26]
  wire [31:0] REG_Wout_io_din; // @[ProcessingElement.scala 366:27]
  wire  REG_Wout_io_din_v; // @[ProcessingElement.scala 366:27]
  wire  REG_Wout_io_dout_r; // @[ProcessingElement.scala 366:27]
  wire [31:0] REG_Wout_io_dout; // @[ProcessingElement.scala 366:27]
  wire  REG_Wout_io_dout_v; // @[ProcessingElement.scala 366:27]
  wire  REG_Wout_io_din_r; // @[ProcessingElement.scala 366:27]
  wire  CELL_clock; // @[ProcessingElement.scala 378:23]
  wire  CELL_reset; // @[ProcessingElement.scala 378:23]
  wire [31:0] CELL_io_north_din; // @[ProcessingElement.scala 378:23]
  wire  CELL_io_north_din_v; // @[ProcessingElement.scala 378:23]
  wire [31:0] CELL_io_east_din; // @[ProcessingElement.scala 378:23]
  wire  CELL_io_east_din_v; // @[ProcessingElement.scala 378:23]
  wire [31:0] CELL_io_south_din; // @[ProcessingElement.scala 378:23]
  wire  CELL_io_south_din_v; // @[ProcessingElement.scala 378:23]
  wire [31:0] CELL_io_west_din; // @[ProcessingElement.scala 378:23]
  wire  CELL_io_west_din_v; // @[ProcessingElement.scala 378:23]
  wire  CELL_io_FU_din_1_r; // @[ProcessingElement.scala 378:23]
  wire  CELL_io_FU_din_2_r; // @[ProcessingElement.scala 378:23]
  wire [31:0] CELL_io_dout; // @[ProcessingElement.scala 378:23]
  wire  CELL_io_dout_v; // @[ProcessingElement.scala 378:23]
  wire  CELL_io_north_dout_r; // @[ProcessingElement.scala 378:23]
  wire  CELL_io_east_dout_r; // @[ProcessingElement.scala 378:23]
  wire  CELL_io_south_dout_r; // @[ProcessingElement.scala 378:23]
  wire  CELL_io_west_dout_r; // @[ProcessingElement.scala 378:23]
  wire [181:0] CELL_io_config_bits; // @[ProcessingElement.scala 378:23]
  reg [181:0] config_bits_reg; // @[ProcessingElement.scala 99:34]
  wire  south_REG_din_r = REG_Sout_io_din_r; // @[ProcessingElement.scala 130:31 330:21]
  wire  west_REG_din_r = REG_Wout_io_din_r; // @[ProcessingElement.scala 131:30 372:20]
  wire [1:0] ready_out_FS_Nin_lo = {south_REG_din_r,west_REG_din_r}; // @[Cat.scala 31:58]
  wire  FU_din_1_r = CELL_io_FU_din_1_r; // @[ProcessingElement.scala 133:26 393:16]
  wire  FU_din_2_r = CELL_io_FU_din_2_r; // @[ProcessingElement.scala 134:26 394:16]
  wire  east_REG_din_r = REG_Eout_io_din_r; // @[ProcessingElement.scala 129:30 289:20]
  wire [2:0] ready_out_FS_Nin_hi = {FU_din_1_r,FU_din_2_r,east_REG_din_r}; // @[Cat.scala 31:58]
  wire  east_buffer_v = FIFO_Ein_io_dout_v; // @[ProcessingElement.scala 109:29 261:19]
  wire  FU_dout_v = CELL_io_dout_v; // @[ProcessingElement.scala 136:25 396:15]
  wire [1:0] valid_in_FR_Nout_lo = {east_buffer_v,FU_dout_v}; // @[Cat.scala 31:58]
  wire  west_buffer_v = FIFO_Win_io_dout_v; // @[ProcessingElement.scala 111:29 343:19]
  wire  south_buffer_v = FIFO_Sin_io_dout_v; // @[ProcessingElement.scala 110:30 302:20]
  wire [1:0] valid_in_FR_Nout_hi = {west_buffer_v,south_buffer_v}; // @[Cat.scala 31:58]
  wire  north_REG_din_r = REG_Nout_io_din_r; // @[ProcessingElement.scala 128:31 247:21]
  wire [2:0] ready_out_FS_Ein_hi = {FU_din_1_r,FU_din_2_r,north_REG_din_r}; // @[Cat.scala 31:58]
  wire  north_buffer_v = FIFO_Nin_io_dout_v; // @[ProcessingElement.scala 108:30 219:20]
  wire [1:0] valid_in_FR_Eout_lo = {north_buffer_v,FU_dout_v}; // @[Cat.scala 31:58]
  wire [1:0] ready_out_FS_Sin_lo = {east_REG_din_r,west_REG_din_r}; // @[Cat.scala 31:58]
  wire [1:0] valid_in_FR_Sout_hi = {west_buffer_v,east_buffer_v}; // @[Cat.scala 31:58]
  wire [1:0] ready_out_FS_Win_lo = {east_REG_din_r,south_REG_din_r}; // @[Cat.scala 31:58]
  wire [1:0] valid_in_FR_Wout_hi = {south_buffer_v,east_buffer_v}; // @[Cat.scala 31:58]
  D_FIFO FIFO_Nin ( // @[ProcessingElement.scala 213:27]
    .clock(FIFO_Nin_clock),
    .reset(FIFO_Nin_reset),
    .io_din(FIFO_Nin_io_din),
    .io_din_v(FIFO_Nin_io_din_v),
    .io_dout_r(FIFO_Nin_io_dout_r),
    .io_din_r(FIFO_Nin_io_din_r),
    .io_dout(FIFO_Nin_io_dout),
    .io_dout_v(FIFO_Nin_io_dout_v)
  );
  FS FS_Nin ( // @[ProcessingElement.scala 221:25]
    .io_ready_out(FS_Nin_io_ready_out),
    .io_fork_mask(FS_Nin_io_fork_mask),
    .io_ready_in(FS_Nin_io_ready_in)
  );
  ConfMux MUX_Nout ( // @[ProcessingElement.scala 227:28]
    .io_selector(MUX_Nout_io_selector),
    .io_mux_input(MUX_Nout_io_mux_input),
    .io_mux_output(MUX_Nout_io_mux_output)
  );
  FR FR_Nout ( // @[ProcessingElement.scala 232:26]
    .io_valid_in(FR_Nout_io_valid_in),
    .io_ready_out(FR_Nout_io_ready_out),
    .io_valid_mux_sel(FR_Nout_io_valid_mux_sel),
    .io_fork_mask(FR_Nout_io_fork_mask),
    .io_valid_out(FR_Nout_io_valid_out)
  );
  D_REG REG_Nout ( // @[ProcessingElement.scala 241:27]
    .io_din(REG_Nout_io_din),
    .io_din_v(REG_Nout_io_din_v),
    .io_dout_r(REG_Nout_io_dout_r),
    .io_dout(REG_Nout_io_dout),
    .io_dout_v(REG_Nout_io_dout_v),
    .io_din_r(REG_Nout_io_din_r)
  );
  D_FIFO FIFO_Ein ( // @[ProcessingElement.scala 255:27]
    .clock(FIFO_Ein_clock),
    .reset(FIFO_Ein_reset),
    .io_din(FIFO_Ein_io_din),
    .io_din_v(FIFO_Ein_io_din_v),
    .io_dout_r(FIFO_Ein_io_dout_r),
    .io_din_r(FIFO_Ein_io_din_r),
    .io_dout(FIFO_Ein_io_dout),
    .io_dout_v(FIFO_Ein_io_dout_v)
  );
  FS FS_Ein ( // @[ProcessingElement.scala 263:25]
    .io_ready_out(FS_Ein_io_ready_out),
    .io_fork_mask(FS_Ein_io_fork_mask),
    .io_ready_in(FS_Ein_io_ready_in)
  );
  ConfMux MUX_Eout ( // @[ProcessingElement.scala 269:28]
    .io_selector(MUX_Eout_io_selector),
    .io_mux_input(MUX_Eout_io_mux_input),
    .io_mux_output(MUX_Eout_io_mux_output)
  );
  FR FR_Eout ( // @[ProcessingElement.scala 274:26]
    .io_valid_in(FR_Eout_io_valid_in),
    .io_ready_out(FR_Eout_io_ready_out),
    .io_valid_mux_sel(FR_Eout_io_valid_mux_sel),
    .io_fork_mask(FR_Eout_io_fork_mask),
    .io_valid_out(FR_Eout_io_valid_out)
  );
  D_REG REG_Eout ( // @[ProcessingElement.scala 283:27]
    .io_din(REG_Eout_io_din),
    .io_din_v(REG_Eout_io_din_v),
    .io_dout_r(REG_Eout_io_dout_r),
    .io_dout(REG_Eout_io_dout),
    .io_dout_v(REG_Eout_io_dout_v),
    .io_din_r(REG_Eout_io_din_r)
  );
  D_FIFO FIFO_Sin ( // @[ProcessingElement.scala 296:27]
    .clock(FIFO_Sin_clock),
    .reset(FIFO_Sin_reset),
    .io_din(FIFO_Sin_io_din),
    .io_din_v(FIFO_Sin_io_din_v),
    .io_dout_r(FIFO_Sin_io_dout_r),
    .io_din_r(FIFO_Sin_io_din_r),
    .io_dout(FIFO_Sin_io_dout),
    .io_dout_v(FIFO_Sin_io_dout_v)
  );
  FS FS_Sin ( // @[ProcessingElement.scala 304:25]
    .io_ready_out(FS_Sin_io_ready_out),
    .io_fork_mask(FS_Sin_io_fork_mask),
    .io_ready_in(FS_Sin_io_ready_in)
  );
  ConfMux MUX_Sout ( // @[ProcessingElement.scala 310:28]
    .io_selector(MUX_Sout_io_selector),
    .io_mux_input(MUX_Sout_io_mux_input),
    .io_mux_output(MUX_Sout_io_mux_output)
  );
  FR FR_Sout ( // @[ProcessingElement.scala 315:26]
    .io_valid_in(FR_Sout_io_valid_in),
    .io_ready_out(FR_Sout_io_ready_out),
    .io_valid_mux_sel(FR_Sout_io_valid_mux_sel),
    .io_fork_mask(FR_Sout_io_fork_mask),
    .io_valid_out(FR_Sout_io_valid_out)
  );
  D_REG REG_Sout ( // @[ProcessingElement.scala 324:27]
    .io_din(REG_Sout_io_din),
    .io_din_v(REG_Sout_io_din_v),
    .io_dout_r(REG_Sout_io_dout_r),
    .io_dout(REG_Sout_io_dout),
    .io_dout_v(REG_Sout_io_dout_v),
    .io_din_r(REG_Sout_io_din_r)
  );
  D_FIFO FIFO_Win ( // @[ProcessingElement.scala 337:27]
    .clock(FIFO_Win_clock),
    .reset(FIFO_Win_reset),
    .io_din(FIFO_Win_io_din),
    .io_din_v(FIFO_Win_io_din_v),
    .io_dout_r(FIFO_Win_io_dout_r),
    .io_din_r(FIFO_Win_io_din_r),
    .io_dout(FIFO_Win_io_dout),
    .io_dout_v(FIFO_Win_io_dout_v)
  );
  FS FS_Win ( // @[ProcessingElement.scala 345:25]
    .io_ready_out(FS_Win_io_ready_out),
    .io_fork_mask(FS_Win_io_fork_mask),
    .io_ready_in(FS_Win_io_ready_in)
  );
  ConfMux MUX_Wout ( // @[ProcessingElement.scala 352:28]
    .io_selector(MUX_Wout_io_selector),
    .io_mux_input(MUX_Wout_io_mux_input),
    .io_mux_output(MUX_Wout_io_mux_output)
  );
  FR FR_Wout ( // @[ProcessingElement.scala 357:26]
    .io_valid_in(FR_Wout_io_valid_in),
    .io_ready_out(FR_Wout_io_ready_out),
    .io_valid_mux_sel(FR_Wout_io_valid_mux_sel),
    .io_fork_mask(FR_Wout_io_fork_mask),
    .io_valid_out(FR_Wout_io_valid_out)
  );
  D_REG REG_Wout ( // @[ProcessingElement.scala 366:27]
    .io_din(REG_Wout_io_din),
    .io_din_v(REG_Wout_io_din_v),
    .io_dout_r(REG_Wout_io_dout_r),
    .io_dout(REG_Wout_io_dout),
    .io_dout_v(REG_Wout_io_dout_v),
    .io_din_r(REG_Wout_io_din_r)
  );
  CellProcessing CELL ( // @[ProcessingElement.scala 378:23]
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
  assign io_north_din_r = FIFO_Nin_io_din_r; // @[ProcessingElement.scala 217:20]
  assign io_east_din_r = FIFO_Ein_io_din_r; // @[ProcessingElement.scala 259:19]
  assign io_south_din_r = FIFO_Sin_io_din_r; // @[ProcessingElement.scala 300:20]
  assign io_west_din_r = FIFO_Win_io_din_r; // @[ProcessingElement.scala 341:19]
  assign io_north_dout = REG_Nout_io_dout; // @[ProcessingElement.scala 248:19]
  assign io_north_dout_v = REG_Nout_io_dout_v; // @[ProcessingElement.scala 249:21]
  assign io_east_dout = REG_Eout_io_dout; // @[ProcessingElement.scala 290:18]
  assign io_east_dout_v = REG_Eout_io_dout_v; // @[ProcessingElement.scala 291:20]
  assign io_south_dout = REG_Sout_io_dout; // @[ProcessingElement.scala 331:19]
  assign io_south_dout_v = REG_Sout_io_dout_v; // @[ProcessingElement.scala 332:21]
  assign io_west_dout = REG_Wout_io_dout; // @[ProcessingElement.scala 373:18]
  assign io_west_dout_v = REG_Wout_io_dout_v; // @[ProcessingElement.scala 374:20]
  assign FIFO_Nin_clock = clock;
  assign FIFO_Nin_reset = reset;
  assign FIFO_Nin_io_din = io_north_din; // @[ProcessingElement.scala 214:21]
  assign FIFO_Nin_io_din_v = io_north_din_v; // @[ProcessingElement.scala 215:23]
  assign FIFO_Nin_io_dout_r = FS_Nin_io_ready_in; // @[ProcessingElement.scala 113:30 224:20]
  assign FS_Nin_io_ready_out = {ready_out_FS_Nin_hi,ready_out_FS_Nin_lo}; // @[Cat.scala 31:58]
  assign FS_Nin_io_fork_mask = config_bits_reg[28:24]; // @[ProcessingElement.scala 201:40]
  assign MUX_Nout_io_selector = config_bits_reg[7:6]; // @[ProcessingElement.scala 196:33]
  assign MUX_Nout_io_mux_input = {FIFO_Win_io_dout,FIFO_Sin_io_dout,FIFO_Ein_io_dout,CELL_io_dout}; // @[ProcessingElement.scala 229:85]
  assign FR_Nout_io_valid_in = {valid_in_FR_Nout_hi,valid_in_FR_Nout_lo}; // @[Cat.scala 31:58]
  assign FR_Nout_io_ready_out = {ready_out_FS_Nin_hi,ready_out_FS_Nin_lo}; // @[Cat.scala 31:58]
  assign FR_Nout_io_valid_mux_sel = config_bits_reg[7:6]; // @[ProcessingElement.scala 196:33]
  assign FR_Nout_io_fork_mask = config_bits_reg[61:57]; // @[ProcessingElement.scala 206:39]
  assign REG_Nout_io_din = MUX_Nout_io_mux_output; // @[ProcessingElement.scala 118:29 230:19]
  assign REG_Nout_io_din_v = FR_Nout_io_valid_out; // @[ProcessingElement.scala 123:31 239:21]
  assign REG_Nout_io_dout_r = io_north_dout_r; // @[ProcessingElement.scala 245:24]
  assign FIFO_Ein_clock = clock;
  assign FIFO_Ein_reset = reset;
  assign FIFO_Ein_io_din = io_east_din; // @[ProcessingElement.scala 256:21]
  assign FIFO_Ein_io_din_v = io_east_din_v; // @[ProcessingElement.scala 257:23]
  assign FIFO_Ein_io_dout_r = FS_Ein_io_ready_in; // @[ProcessingElement.scala 114:29 266:19]
  assign FS_Ein_io_ready_out = {ready_out_FS_Ein_hi,ready_out_FS_Nin_lo}; // @[Cat.scala 31:58]
  assign FS_Ein_io_fork_mask = config_bits_reg[33:29]; // @[ProcessingElement.scala 202:40]
  assign MUX_Eout_io_selector = config_bits_reg[9:8]; // @[ProcessingElement.scala 197:33]
  assign MUX_Eout_io_mux_input = {FIFO_Win_io_dout,FIFO_Sin_io_dout,FIFO_Nin_io_dout,CELL_io_dout}; // @[ProcessingElement.scala 271:86]
  assign FR_Eout_io_valid_in = {valid_in_FR_Nout_hi,valid_in_FR_Eout_lo}; // @[Cat.scala 31:58]
  assign FR_Eout_io_ready_out = {ready_out_FS_Ein_hi,ready_out_FS_Nin_lo}; // @[Cat.scala 31:58]
  assign FR_Eout_io_valid_mux_sel = config_bits_reg[9:8]; // @[ProcessingElement.scala 197:33]
  assign FR_Eout_io_fork_mask = config_bits_reg[66:62]; // @[ProcessingElement.scala 207:39]
  assign REG_Eout_io_din = MUX_Eout_io_mux_output; // @[ProcessingElement.scala 119:28 272:18]
  assign REG_Eout_io_din_v = FR_Eout_io_valid_out; // @[ProcessingElement.scala 124:30 281:20]
  assign REG_Eout_io_dout_r = io_east_dout_r; // @[ProcessingElement.scala 287:24]
  assign FIFO_Sin_clock = clock;
  assign FIFO_Sin_reset = reset;
  assign FIFO_Sin_io_din = io_south_din; // @[ProcessingElement.scala 297:21]
  assign FIFO_Sin_io_din_v = io_south_din_v; // @[ProcessingElement.scala 298:23]
  assign FIFO_Sin_io_dout_r = FS_Sin_io_ready_in; // @[ProcessingElement.scala 115:30 307:20]
  assign FS_Sin_io_ready_out = {ready_out_FS_Ein_hi,ready_out_FS_Sin_lo}; // @[Cat.scala 31:58]
  assign FS_Sin_io_fork_mask = config_bits_reg[38:34]; // @[ProcessingElement.scala 203:40]
  assign MUX_Sout_io_selector = config_bits_reg[11:10]; // @[ProcessingElement.scala 198:33]
  assign MUX_Sout_io_mux_input = {FIFO_Win_io_dout,FIFO_Ein_io_dout,FIFO_Nin_io_dout,CELL_io_dout}; // @[ProcessingElement.scala 312:85]
  assign FR_Sout_io_valid_in = {valid_in_FR_Sout_hi,valid_in_FR_Eout_lo}; // @[Cat.scala 31:58]
  assign FR_Sout_io_ready_out = {ready_out_FS_Ein_hi,ready_out_FS_Sin_lo}; // @[Cat.scala 31:58]
  assign FR_Sout_io_valid_mux_sel = config_bits_reg[11:10]; // @[ProcessingElement.scala 198:33]
  assign FR_Sout_io_fork_mask = config_bits_reg[71:67]; // @[ProcessingElement.scala 208:39]
  assign REG_Sout_io_din = MUX_Sout_io_mux_output; // @[ProcessingElement.scala 120:29 313:19]
  assign REG_Sout_io_din_v = FR_Sout_io_valid_out; // @[ProcessingElement.scala 125:31 322:21]
  assign REG_Sout_io_dout_r = io_south_dout_r; // @[ProcessingElement.scala 328:24]
  assign FIFO_Win_clock = clock;
  assign FIFO_Win_reset = reset;
  assign FIFO_Win_io_din = io_west_din; // @[ProcessingElement.scala 338:21]
  assign FIFO_Win_io_din_v = io_west_din_v; // @[ProcessingElement.scala 339:23]
  assign FIFO_Win_io_dout_r = FS_Win_io_ready_in; // @[ProcessingElement.scala 116:29 349:19]
  assign FS_Win_io_ready_out = {ready_out_FS_Ein_hi,ready_out_FS_Win_lo}; // @[Cat.scala 31:58]
  assign FS_Win_io_fork_mask = config_bits_reg[43:39]; // @[ProcessingElement.scala 204:40]
  assign MUX_Wout_io_selector = config_bits_reg[13:12]; // @[ProcessingElement.scala 199:33]
  assign MUX_Wout_io_mux_input = {FIFO_Sin_io_dout,FIFO_Ein_io_dout,FIFO_Nin_io_dout,CELL_io_dout}; // @[ProcessingElement.scala 354:86]
  assign FR_Wout_io_valid_in = {valid_in_FR_Wout_hi,valid_in_FR_Eout_lo}; // @[Cat.scala 31:58]
  assign FR_Wout_io_ready_out = {ready_out_FS_Ein_hi,ready_out_FS_Win_lo}; // @[Cat.scala 31:58]
  assign FR_Wout_io_valid_mux_sel = config_bits_reg[13:12]; // @[ProcessingElement.scala 199:33]
  assign FR_Wout_io_fork_mask = config_bits_reg[76:72]; // @[ProcessingElement.scala 209:39]
  assign REG_Wout_io_din = MUX_Wout_io_mux_output; // @[ProcessingElement.scala 121:28 355:18]
  assign REG_Wout_io_din_v = FR_Wout_io_valid_out; // @[ProcessingElement.scala 126:30 364:20]
  assign REG_Wout_io_dout_r = io_west_dout_r; // @[ProcessingElement.scala 370:24]
  assign CELL_clock = clock;
  assign CELL_reset = reset;
  assign CELL_io_north_din = FIFO_Nin_io_dout; // @[ProcessingElement.scala 103:28 218:18]
  assign CELL_io_north_din_v = FIFO_Nin_io_dout_v; // @[ProcessingElement.scala 108:30 219:20]
  assign CELL_io_east_din = FIFO_Ein_io_dout; // @[ProcessingElement.scala 104:27 260:17]
  assign CELL_io_east_din_v = FIFO_Ein_io_dout_v; // @[ProcessingElement.scala 109:29 261:19]
  assign CELL_io_south_din = FIFO_Sin_io_dout; // @[ProcessingElement.scala 105:28 301:18]
  assign CELL_io_south_din_v = FIFO_Sin_io_dout_v; // @[ProcessingElement.scala 110:30 302:20]
  assign CELL_io_west_din = FIFO_Win_io_dout; // @[ProcessingElement.scala 106:27 342:17]
  assign CELL_io_west_din_v = FIFO_Win_io_dout_v; // @[ProcessingElement.scala 111:29 343:19]
  assign CELL_io_north_dout_r = REG_Nout_io_din_r; // @[ProcessingElement.scala 128:31 247:21]
  assign CELL_io_east_dout_r = REG_Eout_io_din_r; // @[ProcessingElement.scala 129:30 289:20]
  assign CELL_io_south_dout_r = REG_Sout_io_din_r; // @[ProcessingElement.scala 130:31 330:21]
  assign CELL_io_west_dout_r = REG_Wout_io_din_r; // @[ProcessingElement.scala 131:30 372:20]
  assign CELL_io_config_bits = config_bits_reg; // @[ProcessingElement.scala 391:25]
  always @(posedge clock) begin
    if (reset) begin // @[ProcessingElement.scala 99:34]
      config_bits_reg <= 182'h0; // @[ProcessingElement.scala 99:34]
    end else if (io_catch_config) begin // @[ProcessingElement.scala 191:28]
      config_bits_reg <= io_config_bits; // @[ProcessingElement.scala 192:25]
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
