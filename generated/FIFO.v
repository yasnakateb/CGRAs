module FIFO(
  input         clock,
  input         reset,
  input  [31:0] io_din,
  input         io_wen,
  output        io_full,
  output [31:0] io_dout,
  input         io_ren,
  output        io_empty
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
  reg [31:0] mem [0:31]; // @[FIFO.scala 18:24]
  wire  mem_io_dout_MPORT_en; // @[FIFO.scala 18:24]
  wire [4:0] mem_io_dout_MPORT_addr; // @[FIFO.scala 18:24]
  wire [31:0] mem_io_dout_MPORT_data; // @[FIFO.scala 18:24]
  wire [31:0] mem_MPORT_data; // @[FIFO.scala 18:24]
  wire [4:0] mem_MPORT_addr; // @[FIFO.scala 18:24]
  wire  mem_MPORT_mask; // @[FIFO.scala 18:24]
  wire  mem_MPORT_en; // @[FIFO.scala 18:24]
  reg  mem_io_dout_MPORT_en_pipe_0;
  reg [4:0] mem_io_dout_MPORT_addr_pipe_0;
  reg [4:0] cntWrite; // @[FIFO.scala 14:25]
  reg [4:0] cntRead; // @[FIFO.scala 15:24]
  reg [5:0] cntData; // @[FIFO.scala 16:24]
  wire  _T = ~io_full; // @[FIFO.scala 21:17]
  wire  _T_1 = io_wen & ~io_full; // @[FIFO.scala 21:15]
  wire [5:0] _T_3 = 6'h20 - 6'h1; // @[FIFO.scala 22:31]
  wire [5:0] _GEN_17 = {{1'd0}, cntWrite}; // @[FIFO.scala 22:19]
  wire [4:0] _cntWrite_T_1 = cntWrite + 5'h1; // @[FIFO.scala 25:28]
  wire  _T_6 = io_ren & ~io_empty; // @[FIFO.scala 30:15]
  wire [5:0] _GEN_18 = {{1'd0}, cntRead}; // @[FIFO.scala 31:18]
  wire [4:0] _cntRead_T_1 = cntRead + 5'h1; // @[FIFO.scala 34:26]
  wire [5:0] _cntData_T_1 = cntData + 6'h1; // @[FIFO.scala 40:24]
  wire [5:0] _cntData_T_3 = cntData - 6'h1; // @[FIFO.scala 42:24]
  assign mem_io_dout_MPORT_en = mem_io_dout_MPORT_en_pipe_0;
  assign mem_io_dout_MPORT_addr = mem_io_dout_MPORT_addr_pipe_0;
  assign mem_io_dout_MPORT_data = mem[mem_io_dout_MPORT_addr]; // @[FIFO.scala 18:24]
  assign mem_MPORT_data = io_din;
  assign mem_MPORT_addr = cntWrite;
  assign mem_MPORT_mask = 1'h1;
  assign mem_MPORT_en = io_wen & _T;
  assign io_full = cntData == 6'h20; // @[FIFO.scala 52:16]
  assign io_dout = mem_io_dout_MPORT_data; // @[FIFO.scala 49:11]
  assign io_empty = cntData == 6'h0; // @[FIFO.scala 57:16]
  always @(posedge clock) begin
    if (mem_MPORT_en & mem_MPORT_mask) begin
      mem[mem_MPORT_addr] <= mem_MPORT_data; // @[FIFO.scala 18:24]
    end
    mem_io_dout_MPORT_en_pipe_0 <= 1'h1;
    if (1'h1) begin
      mem_io_dout_MPORT_addr_pipe_0 <= cntRead;
    end
    if (reset) begin // @[FIFO.scala 14:25]
      cntWrite <= 5'h0; // @[FIFO.scala 14:25]
    end else if (io_wen & ~io_full) begin // @[FIFO.scala 21:27]
      if (_GEN_17 == _T_3) begin // @[FIFO.scala 22:38]
        cntWrite <= 5'h0; // @[FIFO.scala 23:16]
      end else begin
        cntWrite <= _cntWrite_T_1; // @[FIFO.scala 25:16]
      end
    end
    if (reset) begin // @[FIFO.scala 15:24]
      cntRead <= 5'h0; // @[FIFO.scala 15:24]
    end else if (io_ren & ~io_empty) begin // @[FIFO.scala 30:28]
      if (_GEN_18 == _T_3) begin // @[FIFO.scala 31:37]
        cntRead <= 5'h0; // @[FIFO.scala 32:15]
      end else begin
        cntRead <= _cntRead_T_1; // @[FIFO.scala 34:15]
      end
    end
    if (reset) begin // @[FIFO.scala 16:24]
      cntData <= 6'h0; // @[FIFO.scala 16:24]
    end else if (_T_1 & ~_T_6) begin // @[FIFO.scala 39:53]
      cntData <= _cntData_T_1; // @[FIFO.scala 40:13]
    end else if (~_T_1 & _T_6) begin // @[FIFO.scala 41:59]
      cntData <= _cntData_T_3; // @[FIFO.scala 42:13]
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
`endif // RANDOMIZE_REG_INIT
  `endif // RANDOMIZE
end // initial
`ifdef FIRRTL_AFTER_INITIAL
`FIRRTL_AFTER_INITIAL
`endif
`endif // SYNTHESIS
endmodule
