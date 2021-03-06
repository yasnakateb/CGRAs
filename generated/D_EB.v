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
module D_EB(
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
  wire  main_clock; // @[D_EB.scala 19:24]
  wire  main_reset; // @[D_EB.scala 19:24]
  wire [7:0] main_io_in; // @[D_EB.scala 19:24]
  wire  main_io_en; // @[D_EB.scala 19:24]
  wire [7:0] main_io_out; // @[D_EB.scala 19:24]
  wire  aux_clock; // @[D_EB.scala 20:23]
  wire  aux_reset; // @[D_EB.scala 20:23]
  wire [7:0] aux_io_in; // @[D_EB.scala 20:23]
  wire  aux_io_en; // @[D_EB.scala 20:23]
  wire [7:0] aux_io_out; // @[D_EB.scala 20:23]
  wire  reg_1_clock; // @[D_EB.scala 21:25]
  wire  reg_1_reset; // @[D_EB.scala 21:25]
  wire  reg_1_io_in; // @[D_EB.scala 21:25]
  wire  reg_1_io_en; // @[D_EB.scala 21:25]
  wire  reg_1_io_out; // @[D_EB.scala 21:25]
  wire  reg_2_clock; // @[D_EB.scala 22:25]
  wire  reg_2_reset; // @[D_EB.scala 22:25]
  wire  reg_2_io_in; // @[D_EB.scala 22:25]
  wire  reg_2_io_en; // @[D_EB.scala 22:25]
  wire  reg_2_io_out; // @[D_EB.scala 22:25]
  reg  reg_; // @[D_EB.scala 24:22]
  wire  mux2_out = reg_ ? reg_1_io_out : reg_2_io_out; // @[D_EB.scala 28:23]
  RegEnable main ( // @[D_EB.scala 19:24]
    .clock(main_clock),
    .reset(main_reset),
    .io_in(main_io_in),
    .io_en(main_io_en),
    .io_out(main_io_out)
  );
  RegEnable aux ( // @[D_EB.scala 20:23]
    .clock(aux_clock),
    .reset(aux_reset),
    .io_in(aux_io_in),
    .io_en(aux_io_en),
    .io_out(aux_io_out)
  );
  RegEnable_2 reg_1 ( // @[D_EB.scala 21:25]
    .clock(reg_1_clock),
    .reset(reg_1_reset),
    .io_in(reg_1_io_in),
    .io_en(reg_1_io_en),
    .io_out(reg_1_io_out)
  );
  RegEnable_2 reg_2 ( // @[D_EB.scala 22:25]
    .clock(reg_2_clock),
    .reset(reg_2_reset),
    .io_in(reg_2_io_in),
    .io_en(reg_2_io_en),
    .io_out(reg_2_io_out)
  );
  assign io_d_n = reg_ ? main_io_out : aux_io_out; // @[D_EB.scala 48:18]
  assign io_v_n = reg_ ? reg_1_io_out : reg_2_io_out; // @[D_EB.scala 28:23]
  assign io_a_p = reg_ | ~io_v_p; // @[D_EB.scala 34:20]
  assign main_clock = clock;
  assign main_reset = reset;
  assign main_io_in = io_d_p; // @[D_EB.scala 38:16]
  assign main_io_en = io_a_p; // @[D_EB.scala 26:18 35:8]
  assign aux_clock = clock;
  assign aux_reset = reset;
  assign aux_io_in = main_io_out; // @[D_EB.scala 39:15]
  assign aux_io_en = reg_; // @[D_EB.scala 30:17]
  assign reg_1_clock = clock;
  assign reg_1_reset = reset;
  assign reg_1_io_in = io_v_p; // @[D_EB.scala 40:17]
  assign reg_1_io_en = io_a_p; // @[D_EB.scala 26:18 35:8]
  assign reg_2_clock = clock;
  assign reg_2_reset = reset;
  assign reg_2_io_in = reg_1_io_out; // @[D_EB.scala 41:17]
  assign reg_2_io_en = reg_; // @[D_EB.scala 30:17]
  always @(posedge clock) begin
    if (reset) begin // @[D_EB.scala 24:22]
      reg_ <= 1'h0; // @[D_EB.scala 24:22]
    end else begin
      reg_ <= io_a_n | ~mux2_out; // @[D_EB.scala 29:9]
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
