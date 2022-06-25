module RegEnable(
  input        clock,
  input        reset,
  input  [7:0] io_in,
  input        io_en,
  output [7:0] io_out
);
`ifdef RANDOMIZE_REG_INIT
  reg [31:0] _RAND_0;
`endif // RANDOMIZE_REG_INIT
  reg [7:0] reg_; // @[RegEnable.scala 11:22]
  assign io_out = reg_; // @[RegEnable.scala 15:12]
  always @(posedge clock) begin
    if (reset) begin // @[RegEnable.scala 11:22]
      reg_ <= 8'h0; // @[RegEnable.scala 11:22]
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
  reg_ = _RAND_0[7:0];
`endif // RANDOMIZE_REG_INIT
  `endif // RANDOMIZE
end // initial
`ifdef FIRRTL_AFTER_INITIAL
`FIRRTL_AFTER_INITIAL
`endif
`endif // SYNTHESIS
endmodule
module RegEnable_2(
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
module D_BUF(
  input        clock,
  input        reset,
  input  [7:0] io_d_p,
  input        io_v_p,
  input        io_a_n,
  output [7:0] io_d_n,
  output       io_v_n,
  output       io_a_p
);
`ifdef RANDOMIZE_REG_INIT
  reg [31:0] _RAND_0;
`endif // RANDOMIZE_REG_INIT
  wire  reg_1_clock; // @[D_BUF.scala 14:25]
  wire  reg_1_reset; // @[D_BUF.scala 14:25]
  wire [7:0] reg_1_io_in; // @[D_BUF.scala 14:25]
  wire  reg_1_io_en; // @[D_BUF.scala 14:25]
  wire [7:0] reg_1_io_out; // @[D_BUF.scala 14:25]
  wire  reg_2_clock; // @[D_BUF.scala 15:25]
  wire  reg_2_reset; // @[D_BUF.scala 15:25]
  wire [7:0] reg_2_io_in; // @[D_BUF.scala 15:25]
  wire  reg_2_io_en; // @[D_BUF.scala 15:25]
  wire [7:0] reg_2_io_out; // @[D_BUF.scala 15:25]
  wire  reg_3_clock; // @[D_BUF.scala 16:25]
  wire  reg_3_reset; // @[D_BUF.scala 16:25]
  wire  reg_3_io_in; // @[D_BUF.scala 16:25]
  wire  reg_3_io_en; // @[D_BUF.scala 16:25]
  wire  reg_3_io_out; // @[D_BUF.scala 16:25]
  wire  reg_4_clock; // @[D_BUF.scala 17:25]
  wire  reg_4_reset; // @[D_BUF.scala 17:25]
  wire  reg_4_io_in; // @[D_BUF.scala 17:25]
  wire  reg_4_io_en; // @[D_BUF.scala 17:25]
  wire  reg_4_io_out; // @[D_BUF.scala 17:25]
  reg  reg_; // @[D_BUF.scala 19:22]
  RegEnable reg_1 ( // @[D_BUF.scala 14:25]
    .clock(reg_1_clock),
    .reset(reg_1_reset),
    .io_in(reg_1_io_in),
    .io_en(reg_1_io_en),
    .io_out(reg_1_io_out)
  );
  RegEnable reg_2 ( // @[D_BUF.scala 15:25]
    .clock(reg_2_clock),
    .reset(reg_2_reset),
    .io_in(reg_2_io_in),
    .io_en(reg_2_io_en),
    .io_out(reg_2_io_out)
  );
  RegEnable_2 reg_3 ( // @[D_BUF.scala 16:25]
    .clock(reg_3_clock),
    .reset(reg_3_reset),
    .io_in(reg_3_io_in),
    .io_en(reg_3_io_en),
    .io_out(reg_3_io_out)
  );
  RegEnable_2 reg_4 ( // @[D_BUF.scala 17:25]
    .clock(reg_4_clock),
    .reset(reg_4_reset),
    .io_in(reg_4_io_in),
    .io_en(reg_4_io_en),
    .io_out(reg_4_io_out)
  );
  assign io_d_n = reg_ ? reg_1_io_out : io_d_p; // @[D_BUF.scala 33:23]
  assign io_v_n = reg_4_io_out; // @[D_BUF.scala 39:12]
  assign io_a_p = reg_; // @[D_BUF.scala 22:17]
  assign reg_1_clock = clock;
  assign reg_1_reset = reset;
  assign reg_1_io_in = io_d_p; // @[D_BUF.scala 24:17]
  assign reg_1_io_en = reg_; // @[D_BUF.scala 22:17]
  assign reg_2_clock = clock;
  assign reg_2_reset = reset;
  assign reg_2_io_in = reg_ ? reg_1_io_out : io_d_p; // @[D_BUF.scala 33:23]
  assign reg_2_io_en = io_a_n; // @[D_BUF.scala 29:17]
  assign reg_3_clock = clock;
  assign reg_3_reset = reset;
  assign reg_3_io_in = io_v_p; // @[D_BUF.scala 25:17]
  assign reg_3_io_en = reg_; // @[D_BUF.scala 22:17]
  assign reg_4_clock = clock;
  assign reg_4_reset = reset;
  assign reg_4_io_in = reg_ ? reg_3_io_out : io_v_p; // @[D_BUF.scala 37:23]
  assign reg_4_io_en = io_a_n; // @[D_BUF.scala 31:17]
  always @(posedge clock) begin
    if (reset) begin // @[D_BUF.scala 19:22]
      reg_ <= 1'h0; // @[D_BUF.scala 19:22]
    end else begin
      reg_ <= io_a_n; // @[D_BUF.scala 21:9]
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
