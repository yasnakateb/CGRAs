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
  reg [31:0] memory [0:3]; // @[D_FIFO.scala 17:29]
  wire  memory_io_dout_MPORT_en; // @[D_FIFO.scala 17:29]
  wire [1:0] memory_io_dout_MPORT_addr; // @[D_FIFO.scala 17:29]
  wire [31:0] memory_io_dout_MPORT_data; // @[D_FIFO.scala 17:29]
  wire [31:0] memory_MPORT_data; // @[D_FIFO.scala 17:29]
  wire [1:0] memory_MPORT_addr; // @[D_FIFO.scala 17:29]
  wire  memory_MPORT_mask; // @[D_FIFO.scala 17:29]
  wire  memory_MPORT_en; // @[D_FIFO.scala 17:29]
  reg  memory_io_dout_MPORT_en_pipe_0;
  reg [1:0] memory_io_dout_MPORT_addr_pipe_0;
  reg [3:0] write_pointer; // @[D_FIFO.scala 19:36]
  reg [3:0] read_pointer; // @[D_FIFO.scala 20:31]
  reg [3:0] num_data; // @[D_FIFO.scala 21:27]
  wire  full = num_data == 4'h4; // @[D_FIFO.scala 64:20]
  wire  _T = ~full; // @[D_FIFO.scala 41:16]
  wire  wr_en = io_din_v & _T; // @[D_FIFO.scala 76:23]
  wire [3:0] _num_data_T_1 = num_data + 4'h1; // @[D_FIFO.scala 43:30]
  wire [2:0] _T_5 = 3'h4 - 3'h1; // @[D_FIFO.scala 45:46]
  wire [3:0] _GEN_19 = {{1'd0}, _T_5}; // @[D_FIFO.scala 45:29]
  wire [3:0] _write_pointer_T_1 = write_pointer + 4'h1; // @[D_FIFO.scala 48:44]
  wire  empty = num_data == 4'h0; // @[D_FIFO.scala 70:20]
  wire  _T_7 = ~empty; // @[D_FIFO.scala 52:17]
  wire  rd_en = io_dout_r & _T_7; // @[D_FIFO.scala 77:28]
  wire [3:0] _num_data_T_3 = num_data - 4'h1; // @[D_FIFO.scala 55:30]
  wire [3:0] _read_pointer_T_1 = read_pointer + 4'h1; // @[D_FIFO.scala 60:42]
  assign memory_io_dout_MPORT_en = memory_io_dout_MPORT_en_pipe_0;
  assign memory_io_dout_MPORT_addr = memory_io_dout_MPORT_addr_pipe_0;
  assign memory_io_dout_MPORT_data = memory[memory_io_dout_MPORT_addr]; // @[D_FIFO.scala 17:29]
  assign memory_MPORT_data = io_din;
  assign memory_MPORT_addr = write_pointer[1:0];
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
      memory_io_dout_MPORT_addr_pipe_0 <= read_pointer[1:0];
    end
    if (reset) begin // @[D_FIFO.scala 19:36]
      write_pointer <= 4'h0; // @[D_FIFO.scala 19:36]
    end else if (~full & wr_en) begin // @[D_FIFO.scala 41:50]
      if (write_pointer == _GEN_19) begin // @[D_FIFO.scala 45:54]
        write_pointer <= 4'h0; // @[D_FIFO.scala 46:27]
      end else begin
        write_pointer <= _write_pointer_T_1; // @[D_FIFO.scala 48:27]
      end
    end else begin
      write_pointer <= 4'h0; // @[D_FIFO.scala 31:23]
    end
    if (reset) begin // @[D_FIFO.scala 20:31]
      read_pointer <= 4'h0; // @[D_FIFO.scala 20:31]
    end else if (~empty & rd_en) begin // @[D_FIFO.scala 52:51]
      if (read_pointer == _GEN_19) begin // @[D_FIFO.scala 57:53]
        read_pointer <= 4'h0; // @[D_FIFO.scala 58:26]
      end else begin
        read_pointer <= _read_pointer_T_1; // @[D_FIFO.scala 60:26]
      end
    end else begin
      read_pointer <= 4'h0; // @[D_FIFO.scala 32:18]
    end
    if (reset) begin // @[D_FIFO.scala 21:27]
      num_data <= 4'h0; // @[D_FIFO.scala 21:27]
    end else if (~empty & rd_en) begin // @[D_FIFO.scala 52:51]
      num_data <= _num_data_T_3; // @[D_FIFO.scala 55:18]
    end else if (~full & wr_en) begin // @[D_FIFO.scala 41:50]
      num_data <= _num_data_T_1; // @[D_FIFO.scala 43:18]
    end else begin
      num_data <= 4'h0; // @[D_FIFO.scala 33:18]
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
  for (initvar = 0; initvar < 4; initvar = initvar+1)
    memory[initvar] = _RAND_0[31:0];
`endif // RANDOMIZE_MEM_INIT
`ifdef RANDOMIZE_REG_INIT
  _RAND_1 = {1{`RANDOM}};
  memory_io_dout_MPORT_en_pipe_0 = _RAND_1[0:0];
  _RAND_2 = {1{`RANDOM}};
  memory_io_dout_MPORT_addr_pipe_0 = _RAND_2[1:0];
  _RAND_3 = {1{`RANDOM}};
  write_pointer = _RAND_3[3:0];
  _RAND_4 = {1{`RANDOM}};
  read_pointer = _RAND_4[3:0];
  _RAND_5 = {1{`RANDOM}};
  num_data = _RAND_5[3:0];
`endif // RANDOMIZE_REG_INIT
  `endif // RANDOMIZE
end // initial
`ifdef FIRRTL_AFTER_INITIAL
`FIRRTL_AFTER_INITIAL
`endif
`endif // SYNTHESIS
endmodule
