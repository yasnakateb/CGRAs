module FIFO(
  input         clock,
  input         reset,
  input         io_clk,
  input         io_reset,
  input  [31:0] io_din,
  input         io_din_v,
  output        io_din_r,
  output [31:0] io_dout,
  output        io_dout_v,
  input         io_dout_r
);
`ifdef RANDOMIZE_MEM_INIT
  reg [31:0] _RAND_0;
`endif // RANDOMIZE_MEM_INIT
`ifdef RANDOMIZE_REG_INIT
  reg [31:0] _RAND_1;
  reg [31:0] _RAND_2;
  reg [31:0] _RAND_3;
`endif // RANDOMIZE_REG_INIT
  reg [31:0] memory [0:31]; // @[FIFO.scala 20:19]
  wire  memory_io_dout_MPORT_en; // @[FIFO.scala 20:19]
  wire [4:0] memory_io_dout_MPORT_addr; // @[FIFO.scala 20:19]
  wire [31:0] memory_io_dout_MPORT_data; // @[FIFO.scala 20:19]
  wire [31:0] memory_MPORT_data; // @[FIFO.scala 20:19]
  wire [4:0] memory_MPORT_addr; // @[FIFO.scala 20:19]
  wire  memory_MPORT_mask; // @[FIFO.scala 20:19]
  wire  memory_MPORT_en; // @[FIFO.scala 20:19]
  reg [4:0] write_pointer; // @[FIFO.scala 21:30]
  reg [4:0] read_pointer; // @[FIFO.scala 22:29]
  reg [5:0] num_data; // @[FIFO.scala 23:25]
  wire  empty = num_data == 6'h0; // @[FIFO.scala 25:24]
  wire  full = num_data == 6'h20; // @[FIFO.scala 26:23]
  wire  _io_din_r_T = ~full; // @[FIFO.scala 28:15]
  wire  _io_dout_v_T = ~empty; // @[FIFO.scala 30:16]
  wire  _T = ~io_reset; // @[FIFO.scala 32:17]
  wire  _GEN_0 = io_dout_r ? 1'h0 : ~empty; // @[FIFO.scala 30:13 39:21 40:17]
  wire  _T_2 = _io_din_r_T & io_din_v; // @[FIFO.scala 43:16]
  wire [5:0] _num_data_T_1 = num_data + 6'h1; // @[FIFO.scala 45:28]
  wire [4:0] _write_pointer_T_2 = write_pointer + 5'h1; // @[FIFO.scala 46:87]
  wire [5:0] _num_data_T_3 = num_data - 6'h1; // @[FIFO.scala 50:28]
  wire [4:0] _read_pointer_T_2 = read_pointer + 5'h1; // @[FIFO.scala 51:84]
  assign memory_io_dout_MPORT_en = 1'h1;
  assign memory_io_dout_MPORT_addr = read_pointer;
  assign memory_io_dout_MPORT_data = memory[memory_io_dout_MPORT_addr]; // @[FIFO.scala 20:19]
  assign memory_MPORT_data = io_din;
  assign memory_MPORT_addr = write_pointer;
  assign memory_MPORT_mask = 1'h1;
  assign memory_MPORT_en = _T ? 1'h0 : _T_2;
  assign io_din_r = ~full; // @[FIFO.scala 28:15]
  assign io_dout = memory_io_dout_MPORT_data; // @[FIFO.scala 29:11]
  assign io_dout_v = ~io_reset ? 1'h0 : _GEN_0; // @[FIFO.scala 32:34 36:15]
  always @(posedge clock) begin
    if (memory_MPORT_en & memory_MPORT_mask) begin
      memory[memory_MPORT_addr] <= memory_MPORT_data; // @[FIFO.scala 20:19]
    end
    if (reset) begin // @[FIFO.scala 21:30]
      write_pointer <= 5'h0; // @[FIFO.scala 21:30]
    end else if (~io_reset) begin // @[FIFO.scala 32:34]
      write_pointer <= 5'h0; // @[FIFO.scala 34:19]
    end else if (_io_din_r_T & io_din_v) begin // @[FIFO.scala 43:29]
      if (write_pointer == 5'h1f) begin // @[FIFO.scala 46:27]
        write_pointer <= 5'h0;
      end else begin
        write_pointer <= _write_pointer_T_2;
      end
    end
    if (reset) begin // @[FIFO.scala 22:29]
      read_pointer <= 5'h0; // @[FIFO.scala 22:29]
    end else if (~io_reset) begin // @[FIFO.scala 32:34]
      read_pointer <= 5'h0; // @[FIFO.scala 35:18]
    end else if (io_dout_r & _io_dout_v_T) begin // @[FIFO.scala 49:31]
      if (read_pointer == 5'h1f) begin // @[FIFO.scala 51:26]
        read_pointer <= 5'h0;
      end else begin
        read_pointer <= _read_pointer_T_2;
      end
    end
    if (reset) begin // @[FIFO.scala 23:25]
      num_data <= 6'h0; // @[FIFO.scala 23:25]
    end else if (~io_reset) begin // @[FIFO.scala 32:34]
      num_data <= 6'h0; // @[FIFO.scala 33:14]
    end else if (io_dout_r & _io_dout_v_T) begin // @[FIFO.scala 49:31]
      num_data <= _num_data_T_3; // @[FIFO.scala 50:16]
    end else if (_io_din_r_T & io_din_v) begin // @[FIFO.scala 43:29]
      num_data <= _num_data_T_1; // @[FIFO.scala 45:16]
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
  write_pointer = _RAND_1[4:0];
  _RAND_2 = {1{`RANDOM}};
  read_pointer = _RAND_2[4:0];
  _RAND_3 = {1{`RANDOM}};
  num_data = _RAND_3[5:0];
`endif // RANDOMIZE_REG_INIT
  `endif // RANDOMIZE
end // initial
`ifdef FIRRTL_AFTER_INITIAL
`FIRRTL_AFTER_INITIAL
`endif
`endif // SYNTHESIS
endmodule
