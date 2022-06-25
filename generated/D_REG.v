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
module RegEnable_1(
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
module D_REG(
  input        clock,
  input        reset,
  input  [7:0] io_d_p,
  input        io_v_p,
  input        io_a_n,
  output [7:0] io_d_n,
  output       io_v_n,
  output       io_a_p
);
  wire  reg_1_clock; // @[D_REG.scala 19:25]
  wire  reg_1_reset; // @[D_REG.scala 19:25]
  wire [7:0] reg_1_io_in; // @[D_REG.scala 19:25]
  wire  reg_1_io_en; // @[D_REG.scala 19:25]
  wire [7:0] reg_1_io_out; // @[D_REG.scala 19:25]
  wire  reg_2_clock; // @[D_REG.scala 20:25]
  wire  reg_2_reset; // @[D_REG.scala 20:25]
  wire  reg_2_io_in; // @[D_REG.scala 20:25]
  wire  reg_2_io_en; // @[D_REG.scala 20:25]
  wire  reg_2_io_out; // @[D_REG.scala 20:25]
  RegEnable reg_1 ( // @[D_REG.scala 19:25]
    .clock(reg_1_clock),
    .reset(reg_1_reset),
    .io_in(reg_1_io_in),
    .io_en(reg_1_io_en),
    .io_out(reg_1_io_out)
  );
  RegEnable_1 reg_2 ( // @[D_REG.scala 20:25]
    .clock(reg_2_clock),
    .reset(reg_2_reset),
    .io_in(reg_2_io_in),
    .io_en(reg_2_io_en),
    .io_out(reg_2_io_out)
  );
  assign io_d_n = reg_1_io_out; // @[D_REG.scala 26:12]
  assign io_v_n = reg_2_io_out; // @[D_REG.scala 27:12]
  assign io_a_p = io_a_n; // @[D_REG.scala 28:12]
  assign reg_1_clock = clock;
  assign reg_1_reset = reset;
  assign reg_1_io_in = io_d_p; // @[D_REG.scala 22:17]
  assign reg_1_io_en = io_a_n; // @[D_REG.scala 24:17]
  assign reg_2_clock = clock;
  assign reg_2_reset = reset;
  assign reg_2_io_in = io_v_p; // @[D_REG.scala 23:17]
  assign reg_2_io_en = io_a_n; // @[D_REG.scala 25:17]
endmodule
