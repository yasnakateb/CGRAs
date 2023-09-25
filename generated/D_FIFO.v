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
  reg [31:0] _RAND_7;
`endif // RANDOMIZE_REG_INIT
  reg [31:0] memory [0:31]; // @[D_FIFO.scala 55:21]
  wire  memory_dout_MPORT_en; // @[D_FIFO.scala 55:21]
  wire [4:0] memory_dout_MPORT_addr; // @[D_FIFO.scala 55:21]
  wire [31:0] memory_dout_MPORT_data; // @[D_FIFO.scala 55:21]
  wire [31:0] memory_MPORT_data; // @[D_FIFO.scala 55:21]
  wire [4:0] memory_MPORT_addr; // @[D_FIFO.scala 55:21]
  wire  memory_MPORT_mask; // @[D_FIFO.scala 55:21]
  wire  memory_MPORT_en; // @[D_FIFO.scala 55:21]
  reg [31:0] write_pointer; // @[D_FIFO.scala 57:32]
  reg [31:0] read_pointer; // @[D_FIFO.scala 58:31]
  reg [31:0] num_data; // @[D_FIFO.scala 59:27]
  reg  full; // @[D_FIFO.scala 61:23]
  reg  empty; // @[D_FIFO.scala 62:24]
  reg  dout_v; // @[D_FIFO.scala 66:25]
  reg [31:0] dout; // @[D_FIFO.scala 67:23]
  wire  _wr_en_T = ~full; // @[D_FIFO.scala 74:26]
  wire  wr_en = io_din_v & ~full; // @[D_FIFO.scala 74:23]
  wire  _rd_en_T = ~empty; // @[D_FIFO.scala 75:27]
  wire  rd_en = io_dout_r & ~empty; // @[D_FIFO.scala 75:24]
  wire [31:0] _num_data_T_1 = num_data + 32'h1; // @[D_FIFO.scala 86:30]
  wire [5:0] _T_5 = 6'h20 - 6'h1; // @[D_FIFO.scala 88:46]
  wire [31:0] _GEN_19 = {{26'd0}, _T_5}; // @[D_FIFO.scala 88:29]
  wire [31:0] _write_pointer_T_1 = write_pointer + 32'h1; // @[D_FIFO.scala 91:44]
  wire  _T_9 = _rd_en_T & rd_en; // @[D_FIFO.scala 96:29]
  wire [31:0] _num_data_T_3 = num_data - 32'h1; // @[D_FIFO.scala 99:30]
  wire [31:0] _read_pointer_T_1 = read_pointer + 32'h1; // @[D_FIFO.scala 104:42]
  wire  _T_13 = num_data == 32'h20; // @[D_FIFO.scala 108:20]
  wire  _T_14 = num_data == 32'h0; // @[D_FIFO.scala 114:20]
  assign memory_dout_MPORT_en = _rd_en_T & rd_en;
  assign memory_dout_MPORT_addr = read_pointer[4:0];
  assign memory_dout_MPORT_data = memory[memory_dout_MPORT_addr]; // @[D_FIFO.scala 55:21]
  assign memory_MPORT_data = io_din;
  assign memory_MPORT_addr = write_pointer[4:0];
  assign memory_MPORT_mask = 1'h1;
  assign memory_MPORT_en = _wr_en_T & wr_en;
  assign io_din_r = ~full; // @[D_FIFO.scala 77:18]
  assign io_dout = dout; // @[D_FIFO.scala 121:13]
  assign io_dout_v = dout_v; // @[D_FIFO.scala 120:15]
  always @(posedge clock) begin
    if (memory_MPORT_en & memory_MPORT_mask) begin
      memory[memory_MPORT_addr] <= memory_MPORT_data; // @[D_FIFO.scala 55:21]
    end
    if (reset) begin // @[D_FIFO.scala 57:32]
      write_pointer <= 32'h0; // @[D_FIFO.scala 57:32]
    end else if (_wr_en_T & wr_en) begin // @[D_FIFO.scala 84:48]
      if (write_pointer == _GEN_19) begin // @[D_FIFO.scala 88:54]
        write_pointer <= 32'h0; // @[D_FIFO.scala 89:27]
      end else begin
        write_pointer <= _write_pointer_T_1; // @[D_FIFO.scala 91:27]
      end
    end
    if (reset) begin // @[D_FIFO.scala 58:31]
      read_pointer <= 32'h0; // @[D_FIFO.scala 58:31]
    end else if (_rd_en_T & rd_en) begin // @[D_FIFO.scala 96:49]
      if (read_pointer == _GEN_19) begin // @[D_FIFO.scala 101:53]
        read_pointer <= 32'h0; // @[D_FIFO.scala 102:26]
      end else begin
        read_pointer <= _read_pointer_T_1; // @[D_FIFO.scala 104:26]
      end
    end
    if (reset) begin // @[D_FIFO.scala 59:27]
      num_data <= 32'h0; // @[D_FIFO.scala 59:27]
    end else if (_rd_en_T & rd_en) begin // @[D_FIFO.scala 96:49]
      num_data <= _num_data_T_3; // @[D_FIFO.scala 99:18]
    end else if (_wr_en_T & wr_en) begin // @[D_FIFO.scala 84:48]
      num_data <= _num_data_T_1; // @[D_FIFO.scala 86:18]
    end
    if (reset) begin // @[D_FIFO.scala 61:23]
      full <= 1'h0; // @[D_FIFO.scala 61:23]
    end else begin
      full <= _T_13;
    end
    if (reset) begin // @[D_FIFO.scala 62:24]
      empty <= 1'h0; // @[D_FIFO.scala 62:24]
    end else begin
      empty <= _T_14;
    end
    if (reset) begin // @[D_FIFO.scala 66:25]
      dout_v <= 1'h0; // @[D_FIFO.scala 66:25]
    end else begin
      dout_v <= _T_9;
    end
    if (reset) begin // @[D_FIFO.scala 67:23]
      dout <= 32'h0; // @[D_FIFO.scala 67:23]
    end else if (_rd_en_T & rd_en) begin // @[D_FIFO.scala 96:49]
      dout <= memory_dout_MPORT_data; // @[D_FIFO.scala 97:14]
    end else begin
      dout <= 32'h0; // @[D_FIFO.scala 71:10]
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
  write_pointer = _RAND_1[31:0];
  _RAND_2 = {1{`RANDOM}};
  read_pointer = _RAND_2[31:0];
  _RAND_3 = {1{`RANDOM}};
  num_data = _RAND_3[31:0];
  _RAND_4 = {1{`RANDOM}};
  full = _RAND_4[0:0];
  _RAND_5 = {1{`RANDOM}};
  empty = _RAND_5[0:0];
  _RAND_6 = {1{`RANDOM}};
  dout_v = _RAND_6[0:0];
  _RAND_7 = {1{`RANDOM}};
  dout = _RAND_7[31:0];
`endif // RANDOMIZE_REG_INIT
  `endif // RANDOMIZE
end // initial
`ifdef FIRRTL_AFTER_INITIAL
`FIRRTL_AFTER_INITIAL
`endif
`endif // SYNTHESIS
endmodule
