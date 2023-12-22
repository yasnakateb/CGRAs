module ALU(
  input  [31:0] io_din_1,
  input  [31:0] io_din_2,
  input  [4:0]  io_op_config,
  output [31:0] io_dout
);
  wire [31:0] _out_aux_T_2 = $signed(io_din_1) + $signed(io_din_2); // @[ALU.scala 71:27]
  wire [63:0] _out_aux_T_3 = $signed(io_din_1) * $signed(io_din_2); // @[ALU.scala 74:27]
  wire [31:0] _out_aux_T_6 = $signed(io_din_1) - $signed(io_din_2); // @[ALU.scala 77:27]
  wire [524318:0] _GEN_10 = {{524287{io_din_1[31]}},io_din_1}; // @[ALU.scala 81:27]
  wire [524318:0] _out_aux_T_8 = $signed(_GEN_10) << io_din_2[18:0]; // @[ALU.scala 81:27]
  wire [31:0] _out_aux_T_10 = $signed(io_din_1) >>> io_din_2; // @[ALU.scala 84:27]
  wire [31:0] _out_aux_T_14 = io_din_1 >> io_din_2; // @[ALU.scala 87:55]
  wire [31:0] _out_aux_T_16 = $signed(io_din_1) & $signed(io_din_2); // @[ALU.scala 90:27]
  wire [31:0] _out_aux_T_18 = $signed(io_din_1) | $signed(io_din_2); // @[ALU.scala 93:27]
  wire [31:0] _out_aux_T_20 = $signed(io_din_1) ^ $signed(io_din_2); // @[ALU.scala 96:27]
  wire [31:0] _GEN_0 = io_op_config == 5'h8 ? $signed(_out_aux_T_20) : $signed(32'sh0); // @[ALU.scala 95:38 96:15 99:15]
  wire [31:0] _GEN_1 = io_op_config == 5'h7 ? $signed(_out_aux_T_18) : $signed(_GEN_0); // @[ALU.scala 92:37 93:15]
  wire [31:0] _GEN_2 = io_op_config == 5'h6 ? $signed(_out_aux_T_16) : $signed(_GEN_1); // @[ALU.scala 89:38 90:15]
  wire [31:0] _GEN_3 = io_op_config == 5'h5 ? $signed(_out_aux_T_14) : $signed(_GEN_2); // @[ALU.scala 86:38 87:15]
  wire [31:0] _GEN_4 = io_op_config == 5'h4 ? $signed(_out_aux_T_10) : $signed(_GEN_3); // @[ALU.scala 83:38 84:15]
  wire [524318:0] _GEN_5 = io_op_config == 5'h3 ? $signed(_out_aux_T_8) : $signed({{524287{_GEN_4[31]}},_GEN_4}); // @[ALU.scala 79:38 81:15]
  wire [524318:0] _GEN_6 = io_op_config == 5'h2 ? $signed({{524287{_out_aux_T_6[31]}},_out_aux_T_6}) : $signed(_GEN_5); // @[ALU.scala 76:38 77:15]
  wire [524318:0] _GEN_7 = io_op_config == 5'h1 ? $signed({{524255{_out_aux_T_3[63]}},_out_aux_T_3}) : $signed(_GEN_6); // @[ALU.scala 73:38 74:15]
  wire [524318:0] _GEN_8 = io_op_config == 5'h0 ? $signed({{524287{_out_aux_T_2[31]}},_out_aux_T_2}) : $signed(_GEN_7); // @[ALU.scala 70:33 71:15]
  assign io_dout = _GEN_8[31:0]; // @[ALU.scala 68:23]
endmodule
module FU(
  input         clock,
  input         reset,
  input  [31:0] io_din_1,
  input  [31:0] io_din_2,
  input         io_din_v,
  input         io_dout_r,
  input  [1:0]  io_loop_source,
  input  [15:0] io_iterations_reset,
  input  [4:0]  io_op_config,
  output        io_din_r,
  output [31:0] io_dout,
  output        io_dout_v
);
`ifdef RANDOMIZE_REG_INIT
  reg [31:0] _RAND_0;
  reg [31:0] _RAND_1;
  reg [31:0] _RAND_2;
  reg [31:0] _RAND_3;
`endif // RANDOMIZE_REG_INIT
  wire [31:0] ALU_io_din_1; // @[FU.scala 81:22]
  wire [31:0] ALU_io_din_2; // @[FU.scala 81:22]
  wire [4:0] ALU_io_op_config; // @[FU.scala 81:22]
  wire [31:0] ALU_io_dout; // @[FU.scala 81:22]
  reg [31:0] dout_reg; // @[FU.scala 76:27]
  reg [15:0] count; // @[FU.scala 77:24]
  reg  loaded; // @[FU.scala 78:25]
  reg  valid; // @[FU.scala 79:24]
  wire  _T = io_loop_source == 2'h0; // @[FU.scala 87:26]
  wire  _T_1 = io_loop_source == 2'h1; // @[FU.scala 91:31]
  wire  _T_2 = ~loaded; // @[FU.scala 92:22]
  wire [31:0] _GEN_0 = ~loaded ? $signed(io_din_1) : $signed(dout_reg); // @[FU.scala 92:31 93:23 98:23]
  wire  _T_3 = io_loop_source == 2'h2; // @[FU.scala 102:31]
  wire [31:0] _GEN_3 = _T_2 ? $signed(io_din_2) : $signed(dout_reg); // @[FU.scala 103:31 105:23 109:23]
  wire [31:0] _GEN_4 = io_loop_source == 2'h2 ? $signed(io_din_1) : $signed(32'sh1f); // @[FU.scala 102:44 113:19]
  wire [31:0] _GEN_5 = io_loop_source == 2'h2 ? $signed(_GEN_3) : $signed(32'sh1f); // @[FU.scala 102:44 114:19]
  wire [31:0] _GEN_6 = io_loop_source == 2'h1 ? $signed(_GEN_0) : $signed(_GEN_4); // @[FU.scala 91:44]
  wire [31:0] _GEN_7 = io_loop_source == 2'h1 ? $signed(io_din_2) : $signed(_GEN_5); // @[FU.scala 91:44]
  wire  _GEN_10 = io_dout_r ? 1'h0 : valid; // @[FU.scala 117:30 118:15 79:24]
  wire  _T_11 = _T_1 | _T_3; // @[FU.scala 122:41]
  wire  _T_12 = io_din_v & io_dout_r & _T_11; // @[FU.scala 121:49]
  wire [15:0] _count_T_1 = count + 16'h1; // @[FU.scala 125:24]
  wire  _GEN_11 = _T_12 | loaded; // @[FU.scala 123:9 124:16 78:25]
  wire [15:0] _T_14 = io_iterations_reset - 16'h1; // @[FU.scala 128:41]
  wire  _T_19 = count == _T_14 & _T_11; // @[FU.scala 128:47]
  wire  _T_21 = _T_19 & io_dout_r; // @[FU.scala 129:72]
  wire  _T_26 = _T_11 & io_din_v; // @[FU.scala 137:75]
  wire  _T_28 = _T_26 & io_dout_r; // @[FU.scala 138:34]
  wire [31:0] alu_dout = ALU_io_dout; // @[FU.scala 74:24 84:14]
  wire  _GEN_16 = _T_21 | _GEN_10; // @[FU.scala 131:9 134:15]
  ALU ALU ( // @[FU.scala 81:22]
    .io_din_1(ALU_io_din_1),
    .io_din_2(ALU_io_din_2),
    .io_op_config(ALU_io_op_config),
    .io_dout(ALU_io_dout)
  );
  assign io_din_r = io_dout_r; // @[FU.scala 144:14]
  assign io_dout = _T ? $signed(alu_dout) : $signed(dout_reg); // @[FU.scala 146:38 147:17 151:17]
  assign io_dout_v = _T ? io_din_v : valid; // @[FU.scala 146:38 148:19 152:19]
  assign ALU_io_din_1 = io_loop_source == 2'h0 ? $signed(io_din_1) : $signed(_GEN_6); // @[FU.scala 87:39 88:19]
  assign ALU_io_din_2 = io_loop_source == 2'h0 ? $signed(io_din_2) : $signed(_GEN_7); // @[FU.scala 87:39 89:19]
  assign ALU_io_op_config = io_op_config; // @[FU.scala 85:22]
  always @(posedge clock) begin
    if (reset) begin // @[FU.scala 76:27]
      dout_reg <= 32'sh0; // @[FU.scala 76:27]
    end else if (_T_21) begin // @[FU.scala 131:9]
      dout_reg <= alu_dout; // @[FU.scala 135:18]
    end else if (_T_28) begin // @[FU.scala 140:9]
      dout_reg <= alu_dout; // @[FU.scala 141:18]
    end
    if (reset) begin // @[FU.scala 77:24]
      count <= 16'h0; // @[FU.scala 77:24]
    end else if (_T_21) begin // @[FU.scala 131:9]
      count <= 16'h0; // @[FU.scala 132:15]
    end else if (_T_12) begin // @[FU.scala 123:9]
      count <= _count_T_1; // @[FU.scala 125:15]
    end
    if (reset) begin // @[FU.scala 78:25]
      loaded <= 1'h0; // @[FU.scala 78:25]
    end else if (_T_21) begin // @[FU.scala 131:9]
      loaded <= 1'h0; // @[FU.scala 133:16]
    end else begin
      loaded <= _GEN_11;
    end
    if (reset) begin // @[FU.scala 79:24]
      valid <= 1'h0; // @[FU.scala 79:24]
    end else begin
      valid <= _GEN_16;
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
  dout_reg = _RAND_0[31:0];
  _RAND_1 = {1{`RANDOM}};
  count = _RAND_1[15:0];
  _RAND_2 = {1{`RANDOM}};
  loaded = _RAND_2[0:0];
  _RAND_3 = {1{`RANDOM}};
  valid = _RAND_3[0:0];
`endif // RANDOMIZE_REG_INIT
  `endif // RANDOMIZE
end // initial
`ifdef FIRRTL_AFTER_INITIAL
`FIRRTL_AFTER_INITIAL
`endif
`endif // SYNTHESIS
endmodule
