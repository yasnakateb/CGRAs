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
  reg [31:0] mem [0:31]; // @[D_FIFO.scala 115:26]
  wire  mem_io_dout_MPORT_en; // @[D_FIFO.scala 115:26]
  wire [4:0] mem_io_dout_MPORT_addr; // @[D_FIFO.scala 115:26]
  wire [31:0] mem_io_dout_MPORT_data; // @[D_FIFO.scala 115:26]
  wire [31:0] mem_MPORT_data; // @[D_FIFO.scala 115:26]
  wire [4:0] mem_MPORT_addr; // @[D_FIFO.scala 115:26]
  wire  mem_MPORT_mask; // @[D_FIFO.scala 115:26]
  wire  mem_MPORT_en; // @[D_FIFO.scala 115:26]
  reg  mem_io_dout_MPORT_en_pipe_0;
  reg [4:0] mem_io_dout_MPORT_addr_pipe_0;
  reg [4:0] cntWrite; // @[D_FIFO.scala 111:27]
  reg [4:0] cntRead; // @[D_FIFO.scala 112:26]
  reg [5:0] cntData; // @[D_FIFO.scala 113:26]
  wire  full = cntData == 6'h20; // @[D_FIFO.scala 166:18]
  wire  _T = ~full; // @[D_FIFO.scala 125:16]
  wire  wen = io_din_v & _T; // @[D_FIFO.scala 178:21]
  wire  _T_1 = wen & ~full; // @[D_FIFO.scala 125:14]
  wire [5:0] _T_3 = 6'h20 - 6'h1; // @[D_FIFO.scala 126:40]
  wire [5:0] _GEN_17 = {{1'd0}, cntWrite}; // @[D_FIFO.scala 126:23]
  wire [4:0] _cntWrite_T_1 = cntWrite + 5'h1; // @[D_FIFO.scala 129:30]
  wire  empty = cntData == 6'h0; // @[D_FIFO.scala 171:18]
  wire  _T_5 = ~empty; // @[D_FIFO.scala 134:16]
  wire  ren = io_dout_r & _T_5; // @[D_FIFO.scala 179:22]
  wire  _T_6 = ren & ~empty; // @[D_FIFO.scala 134:14]
  wire [5:0] _GEN_18 = {{1'd0}, cntRead}; // @[D_FIFO.scala 135:22]
  wire [4:0] _cntRead_T_1 = cntRead + 5'h1; // @[D_FIFO.scala 138:32]
  wire [5:0] _cntData_T_1 = cntData + 6'h1; // @[D_FIFO.scala 144:28]
  wire [5:0] _cntData_T_3 = cntData - 6'h1; // @[D_FIFO.scala 146:28]
  assign mem_io_dout_MPORT_en = mem_io_dout_MPORT_en_pipe_0;
  assign mem_io_dout_MPORT_addr = mem_io_dout_MPORT_addr_pipe_0;
  assign mem_io_dout_MPORT_data = mem[mem_io_dout_MPORT_addr]; // @[D_FIFO.scala 115:26]
  assign mem_MPORT_data = io_din;
  assign mem_MPORT_addr = cntWrite;
  assign mem_MPORT_mask = 1'h1;
  assign mem_MPORT_en = wen & _T;
  assign io_din_r = ~full; // @[D_FIFO.scala 177:17]
  assign io_dout = mem_io_dout_MPORT_data; // @[D_FIFO.scala 153:13]
  assign io_dout_v = ~empty; // @[D_FIFO.scala 156:18]
  always @(posedge clock) begin
    if (mem_MPORT_en & mem_MPORT_mask) begin
      mem[mem_MPORT_addr] <= mem_MPORT_data; // @[D_FIFO.scala 115:26]
    end
    mem_io_dout_MPORT_en_pipe_0 <= 1'h1;
    if (1'h1) begin
      mem_io_dout_MPORT_addr_pipe_0 <= cntRead;
    end
    if (reset) begin // @[D_FIFO.scala 111:27]
      cntWrite <= 5'h0; // @[D_FIFO.scala 111:27]
    end else if (wen & ~full) begin // @[D_FIFO.scala 125:23]
      if (_GEN_17 == _T_3) begin // @[D_FIFO.scala 126:47]
        cntWrite <= 5'h0; // @[D_FIFO.scala 127:18]
      end else begin
        cntWrite <= _cntWrite_T_1; // @[D_FIFO.scala 129:18]
      end
    end
    if (reset) begin // @[D_FIFO.scala 112:26]
      cntRead <= 5'h0; // @[D_FIFO.scala 112:26]
    end else if (ren & ~empty) begin // @[D_FIFO.scala 134:24]
      if (_GEN_18 == _T_3) begin // @[D_FIFO.scala 135:46]
        cntRead <= 5'h0; // @[D_FIFO.scala 136:21]
      end else begin
        cntRead <= _cntRead_T_1; // @[D_FIFO.scala 138:21]
      end
    end
    if (reset) begin // @[D_FIFO.scala 113:26]
      cntData <= 6'h0; // @[D_FIFO.scala 113:26]
    end else if (_T_1 & ~_T_6) begin // @[D_FIFO.scala 143:43]
      cntData <= _cntData_T_1; // @[D_FIFO.scala 144:17]
    end else if (~_T_1 & _T_6) begin // @[D_FIFO.scala 145:53]
      cntData <= _cntData_T_3; // @[D_FIFO.scala 146:17]
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
