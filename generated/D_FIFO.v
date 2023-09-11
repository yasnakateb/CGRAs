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
  reg [31:0] memory [0:31]; // @[D_FIFO.scala 55:29]
  wire  memory_io_dout_MPORT_en; // @[D_FIFO.scala 55:29]
  wire [4:0] memory_io_dout_MPORT_addr; // @[D_FIFO.scala 55:29]
  wire [31:0] memory_io_dout_MPORT_data; // @[D_FIFO.scala 55:29]
  wire [31:0] memory_MPORT_data; // @[D_FIFO.scala 55:29]
  wire [4:0] memory_MPORT_addr; // @[D_FIFO.scala 55:29]
  wire  memory_MPORT_mask; // @[D_FIFO.scala 55:29]
  wire  memory_MPORT_en; // @[D_FIFO.scala 55:29]
  reg  memory_io_dout_MPORT_en_pipe_0;
  reg [4:0] memory_io_dout_MPORT_addr_pipe_0;
  reg [4:0] write_pointer; // @[D_FIFO.scala 58:32]
  reg [4:0] read_pointer; // @[D_FIFO.scala 59:31]
  reg [4:0] num_data; // @[D_FIFO.scala 60:27]
  wire  empty = num_data == 5'h0; // @[D_FIFO.scala 108:20]
  wire  _T = ~empty; // @[D_FIFO.scala 78:16]
  wire  rd_en = io_dout_r & _T; // @[D_FIFO.scala 115:24]
  wire [4:0] _num_data_T_1 = num_data - 5'h1; // @[D_FIFO.scala 81:30]
  wire [5:0] _T_4 = 6'h20 - 6'h1; // @[D_FIFO.scala 83:45]
  wire [5:0] _GEN_20 = {{1'd0}, read_pointer}; // @[D_FIFO.scala 83:28]
  wire [4:0] _read_pointer_T_1 = read_pointer + 5'h1; // @[D_FIFO.scala 86:42]
  wire [5:0] _GEN_21 = {{1'd0}, num_data}; // @[D_FIFO.scala 102:20]
  wire  full = _GEN_21 == 6'h20; // @[D_FIFO.scala 102:20]
  wire  _T_6 = ~full; // @[D_FIFO.scala 90:15]
  wire  wr_en = io_din_v & _T_6; // @[D_FIFO.scala 114:23]
  wire [4:0] _num_data_T_3 = num_data + 5'h1; // @[D_FIFO.scala 93:30]
  wire [5:0] _GEN_22 = {{1'd0}, write_pointer}; // @[D_FIFO.scala 95:29]
  wire [4:0] _write_pointer_T_1 = write_pointer + 5'h1; // @[D_FIFO.scala 98:44]
  assign memory_io_dout_MPORT_en = memory_io_dout_MPORT_en_pipe_0;
  assign memory_io_dout_MPORT_addr = memory_io_dout_MPORT_addr_pipe_0;
  assign memory_io_dout_MPORT_data = memory[memory_io_dout_MPORT_addr]; // @[D_FIFO.scala 55:29]
  assign memory_MPORT_data = io_din;
  assign memory_MPORT_addr = write_pointer;
  assign memory_MPORT_mask = 1'h1;
  assign memory_MPORT_en = _T_6 & wr_en;
  assign io_din_r = ~full; // @[D_FIFO.scala 116:18]

  //////////////////////////////////////////// Reg?
  assign io_dout = ~empty & rd_en ? memory_io_dout_MPORT_data : 32'h0; // @[D_FIFO.scala 70:13 78:49 79:17]
  assign io_dout_v = ~empty & rd_en; // @[D_FIFO.scala 78:29]

  ////////////////////////////////////////////////////////////////
  always @(posedge clock) begin
    if (memory_MPORT_en & memory_MPORT_mask) begin
      memory[memory_MPORT_addr] <= memory_MPORT_data; // @[D_FIFO.scala 55:29]
    end
    memory_io_dout_MPORT_en_pipe_0 <= _T & rd_en;
    if (_T & rd_en) begin
      memory_io_dout_MPORT_addr_pipe_0 <= read_pointer;
    end
    if (reset) begin // @[D_FIFO.scala 58:32]
      write_pointer <= 5'h0; // @[D_FIFO.scala 58:32]
    end else if (~full & wr_en) begin // @[D_FIFO.scala 90:48]
      if (_GEN_22 == _T_4) begin // @[D_FIFO.scala 95:54]
        write_pointer <= 5'h0; // @[D_FIFO.scala 96:27]
      end else begin
        write_pointer <= _write_pointer_T_1; // @[D_FIFO.scala 98:27]
      end
    end
    if (reset) begin // @[D_FIFO.scala 59:31]
      read_pointer <= 5'h0; // @[D_FIFO.scala 59:31]
    end else if (~empty & rd_en) begin // @[D_FIFO.scala 78:49]
      if (_GEN_20 == _T_4) begin // @[D_FIFO.scala 83:53]
        read_pointer <= 5'h0; // @[D_FIFO.scala 84:26]
      end else begin
        read_pointer <= _read_pointer_T_1; // @[D_FIFO.scala 86:26]
      end
    end
    if (reset) begin // @[D_FIFO.scala 60:27]
      num_data <= 5'h0; // @[D_FIFO.scala 60:27]
    end else if (~full & wr_en) begin // @[D_FIFO.scala 90:48]
      num_data <= _num_data_T_3; // @[D_FIFO.scala 93:18]
    end else if (~empty & rd_en) begin // @[D_FIFO.scala 78:49]
      num_data <= _num_data_T_1; // @[D_FIFO.scala 81:18]
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
  write_pointer = _RAND_3[4:0];
  _RAND_4 = {1{`RANDOM}};
  read_pointer = _RAND_4[4:0];
  _RAND_5 = {1{`RANDOM}};
  num_data = _RAND_5[4:0];
`endif // RANDOMIZE_REG_INIT
  `endif // RANDOMIZE
end // initial
`ifdef FIRRTL_AFTER_INITIAL
`FIRRTL_AFTER_INITIAL
`endif
`endif // SYNTHESIS
endmodule
