module D_FIFO_V3(
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
`endif // RANDOMIZE_REG_INIT
  reg [31:0] mem [0:31]; // @[D_FIFO_V3.scala 56:26]
  wire  mem_io_dout_MPORT_en; // @[D_FIFO_V3.scala 56:26]
  wire [4:0] mem_io_dout_MPORT_addr; // @[D_FIFO_V3.scala 56:26]
  wire [31:0] mem_io_dout_MPORT_data; // @[D_FIFO_V3.scala 56:26]
  wire [31:0] mem_MPORT_data; // @[D_FIFO_V3.scala 56:26]
  wire [4:0] mem_MPORT_addr; // @[D_FIFO_V3.scala 56:26]
  wire  mem_MPORT_mask; // @[D_FIFO_V3.scala 56:26]
  wire  mem_MPORT_en; // @[D_FIFO_V3.scala 56:26]
  reg  mem_io_dout_MPORT_en_pipe_0;
  reg [4:0] mem_io_dout_MPORT_addr_pipe_0;
  reg [4:0] readPtr; // @[D_FIFO_V3.scala 59:26]
  reg [4:0] writePtr; // @[D_FIFO_V3.scala 60:27]
  wire [4:0] _writePtr_T_2 = writePtr + 5'h1; // @[D_FIFO_V3.scala 65:72]
  wire [4:0] _readPtr_T_2 = readPtr + 5'h1; // @[D_FIFO_V3.scala 74:69]
  assign mem_io_dout_MPORT_en = mem_io_dout_MPORT_en_pipe_0;
  assign mem_io_dout_MPORT_addr = mem_io_dout_MPORT_addr_pipe_0;
  assign mem_io_dout_MPORT_data = mem[mem_io_dout_MPORT_addr]; // @[D_FIFO_V3.scala 56:26]
  assign mem_MPORT_data = io_din;
  assign mem_MPORT_addr = writePtr;
  assign mem_MPORT_mask = 1'h1;
  assign mem_MPORT_en = io_din_v;
  assign io_din_r = readPtr == writePtr & ~io_din_v; // @[D_FIFO_V3.scala 70:38]
  assign io_dout = mem_io_dout_MPORT_data; // @[D_FIFO_V3.scala 69:13]
  assign io_dout_v = io_dout_r; // @[D_FIFO_V3.scala 78:15]
  always @(posedge clock) begin
    if (mem_MPORT_en & mem_MPORT_mask) begin
      mem[mem_MPORT_addr] <= mem_MPORT_data; // @[D_FIFO_V3.scala 56:26]
    end
    mem_io_dout_MPORT_en_pipe_0 <= io_dout_r;
    if (io_dout_r) begin
      mem_io_dout_MPORT_addr_pipe_0 <= readPtr;
    end
    if (reset) begin // @[D_FIFO_V3.scala 59:26]
      readPtr <= 5'h0; // @[D_FIFO_V3.scala 59:26]
    end else if (io_dout_r & io_dout_v) begin // @[D_FIFO_V3.scala 73:34]
      if (readPtr == 5'h1f) begin // @[D_FIFO_V3.scala 74:23]
        readPtr <= 5'h0;
      end else begin
        readPtr <= _readPtr_T_2;
      end
    end
    if (reset) begin // @[D_FIFO_V3.scala 60:27]
      writePtr <= 5'h0; // @[D_FIFO_V3.scala 60:27]
    end else if (io_din_v) begin // @[D_FIFO_V3.scala 63:20]
      if (writePtr == 5'h1f) begin // @[D_FIFO_V3.scala 65:24]
        writePtr <= 5'h0;
      end else begin
        writePtr <= _writePtr_T_2;
      end
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
  readPtr = _RAND_3[4:0];
  _RAND_4 = {1{`RANDOM}};
  writePtr = _RAND_4[4:0];
`endif // RANDOMIZE_REG_INIT
  `endif // RANDOMIZE
end // initial
`ifdef FIRRTL_AFTER_INITIAL
`FIRRTL_AFTER_INITIAL
`endif
`endif // SYNTHESIS
endmodule
