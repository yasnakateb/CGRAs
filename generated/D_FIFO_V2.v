module D_FIFO_V2(
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
  reg [31:0] memory [0:31]; // @[D_FIFO_V2.scala 55:21]
  wire  memory_mem_dout_MPORT_en; // @[D_FIFO_V2.scala 55:21]
  wire [4:0] memory_mem_dout_MPORT_addr; // @[D_FIFO_V2.scala 55:21]
  wire [31:0] memory_mem_dout_MPORT_data; // @[D_FIFO_V2.scala 55:21]
  wire [31:0] memory_MPORT_data; // @[D_FIFO_V2.scala 55:21]
  wire [4:0] memory_MPORT_addr; // @[D_FIFO_V2.scala 55:21]
  wire  memory_MPORT_mask; // @[D_FIFO_V2.scala 55:21]
  wire  memory_MPORT_en; // @[D_FIFO_V2.scala 55:21]
  reg  dout_v; // @[D_FIFO_V2.scala 65:25]
  reg [31:0] cnt_w; // @[D_FIFO_V2.scala 73:24]
  reg [31:0] cnt_r; // @[D_FIFO_V2.scala 74:24]
  reg [31:0] cnt_data; // @[D_FIFO_V2.scala 75:27]
  wire  full = cnt_data == 32'h20; // @[D_FIFO_V2.scala 142:20]
  wire  _mem_w_en_T = ~full; // @[D_FIFO_V2.scala 78:29]
  wire  mem_w_en = io_din_v & ~full; // @[D_FIFO_V2.scala 78:26]
  wire  empty = cnt_data == 32'h0; // @[D_FIFO_V2.scala 148:20]
  wire  _mem_r_en_T = ~empty; // @[D_FIFO_V2.scala 80:30]
  wire  mem_r_en = io_dout_r & ~empty; // @[D_FIFO_V2.scala 80:27]
  reg [31:0] mem_dout; // @[D_FIFO_V2.scala 92:27]
  wire [5:0] _T_2 = 6'h20 - 6'h1; // @[D_FIFO_V2.scala 96:38]
  wire [31:0] _GEN_17 = {{26'd0}, _T_2}; // @[D_FIFO_V2.scala 96:21]
  wire [31:0] _cnt_w_T_1 = cnt_w + 32'h1; // @[D_FIFO_V2.scala 99:28]
  wire [31:0] _cnt_r_T_1 = cnt_r + 32'h1; // @[D_FIFO_V2.scala 108:28]
  wire [31:0] _cnt_data_T_1 = cnt_data + 32'h1; // @[D_FIFO_V2.scala 116:30]
  wire [31:0] _cnt_data_T_3 = cnt_data - 32'h1; // @[D_FIFO_V2.scala 121:30]
  assign memory_mem_dout_MPORT_en = io_dout_r & _mem_r_en_T;
  assign memory_mem_dout_MPORT_addr = cnt_r[4:0];
  assign memory_mem_dout_MPORT_data = memory[memory_mem_dout_MPORT_addr]; // @[D_FIFO_V2.scala 55:21]
  assign memory_MPORT_data = io_din;
  assign memory_MPORT_addr = cnt_w[4:0];
  assign memory_MPORT_mask = 1'h1;
  assign memory_MPORT_en = io_din_v & _mem_w_en_T;
  assign io_din_r = ~full; // @[D_FIFO_V2.scala 161:18]
  assign io_dout = mem_dout; // @[D_FIFO_V2.scala 158:13]
  assign io_dout_v = dout_v; // @[D_FIFO_V2.scala 155:15]
  always @(posedge clock) begin
    if (memory_MPORT_en & memory_MPORT_mask) begin
      memory[memory_MPORT_addr] <= memory_MPORT_data; // @[D_FIFO_V2.scala 55:21]
    end
    dout_v <= io_dout_r & ~empty; // @[D_FIFO_V2.scala 80:27]
    if (reset) begin // @[D_FIFO_V2.scala 73:24]
      cnt_w <= 32'h0; // @[D_FIFO_V2.scala 73:24]
    end else if (mem_r_en) begin // @[D_FIFO_V2.scala 95:33]
      if (cnt_w == _GEN_17) begin // @[D_FIFO_V2.scala 96:46]
        cnt_w <= 32'h0; // @[D_FIFO_V2.scala 97:19]
      end else begin
        cnt_w <= _cnt_w_T_1; // @[D_FIFO_V2.scala 99:19]
      end
    end
    if (reset) begin // @[D_FIFO_V2.scala 74:24]
      cnt_r <= 32'h0; // @[D_FIFO_V2.scala 74:24]
    end else if (mem_w_en) begin // @[D_FIFO_V2.scala 104:33]
      if (cnt_r == _GEN_17) begin // @[D_FIFO_V2.scala 105:46]
        cnt_r <= 32'h0; // @[D_FIFO_V2.scala 106:19]
      end else begin
        cnt_r <= _cnt_r_T_1; // @[D_FIFO_V2.scala 108:19]
      end
    end
    if (reset) begin // @[D_FIFO_V2.scala 75:27]
      cnt_data <= 32'h0; // @[D_FIFO_V2.scala 75:27]
    end else if (~mem_w_en & mem_r_en) begin // @[D_FIFO_V2.scala 120:57]
      cnt_data <= _cnt_data_T_3; // @[D_FIFO_V2.scala 121:18]
    end else if (mem_w_en & ~mem_r_en) begin // @[D_FIFO_V2.scala 115:57]
      cnt_data <= _cnt_data_T_1; // @[D_FIFO_V2.scala 116:18]
    end
    if (reset) begin // @[D_FIFO_V2.scala 92:27]
      mem_dout <= 32'h0; // @[D_FIFO_V2.scala 92:27]
    end else if (mem_r_en) begin // @[D_FIFO_V2.scala 127:30]
      mem_dout <= memory_mem_dout_MPORT_data; // @[D_FIFO_V2.scala 129:18]
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
  dout_v = _RAND_1[0:0];
  _RAND_2 = {1{`RANDOM}};
  cnt_w = _RAND_2[31:0];
  _RAND_3 = {1{`RANDOM}};
  cnt_r = _RAND_3[31:0];
  _RAND_4 = {1{`RANDOM}};
  cnt_data = _RAND_4[31:0];
  _RAND_5 = {1{`RANDOM}};
  mem_dout = _RAND_5[31:0];
`endif // RANDOMIZE_REG_INIT
  `endif // RANDOMIZE
end // initial
`ifdef FIRRTL_AFTER_INITIAL
`FIRRTL_AFTER_INITIAL
`endif
`endif // SYNTHESIS
endmodule
