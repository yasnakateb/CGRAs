module RegEnable(
  input         clock,
  input         reset,
  input  [31:0] io_in,
  input         io_en,
  output [31:0] io_out
);
`ifdef RANDOMIZE_REG_INIT
  reg [31:0] _RAND_0;
`endif // RANDOMIZE_REG_INIT
  reg [31:0] reg_; // @[RegEnable.scala 21:22]
  assign io_out = reg_; // @[RegEnable.scala 25:12]
  always @(posedge clock) begin
    if (reset) begin // @[RegEnable.scala 21:22]
      reg_ <= 32'h0; // @[RegEnable.scala 21:22]
    end else if (io_en) begin // @[RegEnable.scala 22:17]
      reg_ <= io_in; // @[RegEnable.scala 23:13]
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
  reg_ = _RAND_0[31:0];
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
  reg  reg_; // @[RegEnable.scala 21:22]
  assign io_out = reg_; // @[RegEnable.scala 25:12]
  always @(posedge clock) begin
    if (reset) begin // @[RegEnable.scala 21:22]
      reg_ <= 1'h0; // @[RegEnable.scala 21:22]
    end else if (io_en) begin // @[RegEnable.scala 22:17]
      reg_ <= io_in; // @[RegEnable.scala 23:13]
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
module D_SEB(
  input         clock,
  input         reset,
  input  [31:0] io_din,
  input         io_din_v,
  output        io_din_r,
  output [31:0] io_dout,
  output        io_dout_v,
  input         io_dout_r
);
`ifdef RANDOMIZE_REG_INIT
  reg [31:0] _RAND_0;
`endif // RANDOMIZE_REG_INIT
  wire  main_clock; // @[D_SEB.scala 24:24]
  wire  main_reset; // @[D_SEB.scala 24:24]
  wire [31:0] main_io_in; // @[D_SEB.scala 24:24]
  wire  main_io_en; // @[D_SEB.scala 24:24]
  wire [31:0] main_io_out; // @[D_SEB.scala 24:24]
  wire  aux_clock; // @[D_SEB.scala 25:23]
  wire  aux_reset; // @[D_SEB.scala 25:23]
  wire [31:0] aux_io_in; // @[D_SEB.scala 25:23]
  wire  aux_io_en; // @[D_SEB.scala 25:23]
  wire [31:0] aux_io_out; // @[D_SEB.scala 25:23]
  wire  reg_1_clock; // @[D_SEB.scala 26:25]
  wire  reg_1_reset; // @[D_SEB.scala 26:25]
  wire  reg_1_io_in; // @[D_SEB.scala 26:25]
  wire  reg_1_io_en; // @[D_SEB.scala 26:25]
  wire  reg_1_io_out; // @[D_SEB.scala 26:25]
  wire  reg_2_clock; // @[D_SEB.scala 27:25]
  wire  reg_2_reset; // @[D_SEB.scala 27:25]
  wire  reg_2_io_in; // @[D_SEB.scala 27:25]
  wire  reg_2_io_en; // @[D_SEB.scala 27:25]
  wire  reg_2_io_out; // @[D_SEB.scala 27:25]
  reg  reg_; // @[D_SEB.scala 29:22]
  wire  mux2_out = reg_ ? reg_1_io_out : reg_2_io_out; // @[D_SEB.scala 33:23]
  RegEnable main ( // @[D_SEB.scala 24:24]
    .clock(main_clock),
    .reset(main_reset),
    .io_in(main_io_in),
    .io_en(main_io_en),
    .io_out(main_io_out)
  );
  RegEnable aux ( // @[D_SEB.scala 25:23]
    .clock(aux_clock),
    .reset(aux_reset),
    .io_in(aux_io_in),
    .io_en(aux_io_en),
    .io_out(aux_io_out)
  );
  RegEnable_2 reg_1 ( // @[D_SEB.scala 26:25]
    .clock(reg_1_clock),
    .reset(reg_1_reset),
    .io_in(reg_1_io_in),
    .io_en(reg_1_io_en),
    .io_out(reg_1_io_out)
  );
  RegEnable_2 reg_2 ( // @[D_SEB.scala 27:25]
    .clock(reg_2_clock),
    .reset(reg_2_reset),
    .io_in(reg_2_io_in),
    .io_en(reg_2_io_en),
    .io_out(reg_2_io_out)
  );
  assign io_din_r = reg_; // @[D_SEB.scala 35:20]
  assign io_dout = reg_ ? main_io_out : aux_io_out; // @[D_SEB.scala 50:19]
  assign io_dout_v = reg_ ? reg_1_io_out : reg_2_io_out; // @[D_SEB.scala 33:23]
  assign main_clock = clock;
  assign main_reset = reset;
  assign main_io_in = io_din; // @[D_SEB.scala 40:16]
  assign main_io_en = reg_; // @[D_SEB.scala 35:20]
  assign aux_clock = clock;
  assign aux_reset = reset;
  assign aux_io_in = main_io_out; // @[D_SEB.scala 41:15]
  assign aux_io_en = reg_; // @[D_SEB.scala 35:20]
  assign reg_1_clock = clock;
  assign reg_1_reset = reset;
  assign reg_1_io_in = io_din_v; // @[D_SEB.scala 42:17]
  assign reg_1_io_en = reg_; // @[D_SEB.scala 35:20]
  assign reg_2_clock = clock;
  assign reg_2_reset = reset;
  assign reg_2_io_in = reg_1_io_out; // @[D_SEB.scala 43:17]
  assign reg_2_io_en = reg_; // @[D_SEB.scala 35:20]
  always @(posedge clock) begin
    if (reset) begin // @[D_SEB.scala 29:22]
      reg_ <= 1'h0; // @[D_SEB.scala 29:22]
    end else begin
      reg_ <= io_dout_r | ~mux2_out; // @[D_SEB.scala 34:9]
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
