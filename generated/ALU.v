module ALU(
  input         clock,
  input         reset,
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
