module ALU(
  input         clock,
  input         reset,
  input  [31:0] io_din_1,
  input  [31:0] io_din_2,
  input  [4:0]  io_op_config,
  output [31:0] io_dout
);
`ifdef RANDOMIZE_REG_INIT
  reg [31:0] _RAND_0;
  reg [31:0] _RAND_1;
  reg [31:0] _RAND_2;
`endif // RANDOMIZE_REG_INIT
  reg [31:0] din_1_signed; // @[ALU.scala 42:31]
  reg [31:0] reg_out; // @[ALU.scala 45:26]
  reg  reg_inbit; // @[ALU.scala 47:28]
  wire [31:0] _io_dout_T_1 = io_din_1 + io_din_2; // @[ALU.scala 54:27]
  wire [63:0] _io_dout_T_2 = io_din_1 * io_din_2; // @[ALU.scala 57:27]
  wire [31:0] _io_dout_T_4 = io_din_1 - io_din_2; // @[ALU.scala 60:27]
  wire [31:0] _io_dout_T_6 = {reg_out[30:0],reg_inbit}; // @[Cat.scala 31:58]
  wire [1:0] _io_dout_T_9 = reg_inbit ? 2'h3 : 2'h0; // @[Bitwise.scala 74:12]
  wire [31:0] _io_dout_T_10 = {reg_out[29:0],_io_dout_T_9}; // @[Cat.scala 31:58]
  wire [2:0] _io_dout_T_13 = reg_inbit ? 3'h7 : 3'h0; // @[Bitwise.scala 74:12]
  wire [31:0] _io_dout_T_14 = {reg_out[28:0],_io_dout_T_13}; // @[Cat.scala 31:58]
  wire [3:0] _io_dout_T_17 = reg_inbit ? 4'hf : 4'h0; // @[Bitwise.scala 74:12]
  wire [31:0] _io_dout_T_18 = {reg_out[27:0],_io_dout_T_17}; // @[Cat.scala 31:58]
  wire [4:0] _io_dout_T_21 = reg_inbit ? 5'h1f : 5'h0; // @[Bitwise.scala 74:12]
  wire [31:0] _io_dout_T_22 = {reg_out[26:0],_io_dout_T_21}; // @[Cat.scala 31:58]
  wire [5:0] _io_dout_T_25 = reg_inbit ? 6'h3f : 6'h0; // @[Bitwise.scala 74:12]
  wire [31:0] _io_dout_T_26 = {reg_out[25:0],_io_dout_T_25}; // @[Cat.scala 31:58]
  wire [6:0] _io_dout_T_29 = reg_inbit ? 7'h7f : 7'h0; // @[Bitwise.scala 74:12]
  wire [31:0] _io_dout_T_30 = {reg_out[24:0],_io_dout_T_29}; // @[Cat.scala 31:58]
  wire [7:0] _io_dout_T_33 = reg_inbit ? 8'hff : 8'h0; // @[Bitwise.scala 74:12]
  wire [31:0] _io_dout_T_34 = {reg_out[23:0],_io_dout_T_33}; // @[Cat.scala 31:58]
  wire [8:0] _io_dout_T_37 = reg_inbit ? 9'h1ff : 9'h0; // @[Bitwise.scala 74:12]
  wire [31:0] _io_dout_T_38 = {reg_out[22:0],_io_dout_T_37}; // @[Cat.scala 31:58]
  wire [9:0] _io_dout_T_41 = reg_inbit ? 10'h3ff : 10'h0; // @[Bitwise.scala 74:12]
  wire [31:0] _io_dout_T_42 = {reg_out[21:0],_io_dout_T_41}; // @[Cat.scala 31:58]
  wire [10:0] _io_dout_T_45 = reg_inbit ? 11'h7ff : 11'h0; // @[Bitwise.scala 74:12]
  wire [31:0] _io_dout_T_46 = {reg_out[20:0],_io_dout_T_45}; // @[Cat.scala 31:58]
  wire [11:0] _io_dout_T_49 = reg_inbit ? 12'hfff : 12'h0; // @[Bitwise.scala 74:12]
  wire [31:0] _io_dout_T_50 = {reg_out[19:0],_io_dout_T_49}; // @[Cat.scala 31:58]
  wire [12:0] _io_dout_T_53 = reg_inbit ? 13'h1fff : 13'h0; // @[Bitwise.scala 74:12]
  wire [31:0] _io_dout_T_54 = {reg_out[18:0],_io_dout_T_53}; // @[Cat.scala 31:58]
  wire [13:0] _io_dout_T_57 = reg_inbit ? 14'h3fff : 14'h0; // @[Bitwise.scala 74:12]
  wire [31:0] _io_dout_T_58 = {reg_out[17:0],_io_dout_T_57}; // @[Cat.scala 31:58]
  wire [14:0] _io_dout_T_61 = reg_inbit ? 15'h7fff : 15'h0; // @[Bitwise.scala 74:12]
  wire [31:0] _io_dout_T_62 = {reg_out[16:0],_io_dout_T_61}; // @[Cat.scala 31:58]
  wire [15:0] _io_dout_T_65 = reg_inbit ? 16'hffff : 16'h0; // @[Bitwise.scala 74:12]
  wire [31:0] _io_dout_T_66 = {reg_out[15:0],_io_dout_T_65}; // @[Cat.scala 31:58]
  wire [16:0] _io_dout_T_69 = reg_inbit ? 17'h1ffff : 17'h0; // @[Bitwise.scala 74:12]
  wire [31:0] _io_dout_T_70 = {reg_out[14:0],_io_dout_T_69}; // @[Cat.scala 31:58]
  wire [17:0] _io_dout_T_73 = reg_inbit ? 18'h3ffff : 18'h0; // @[Bitwise.scala 74:12]
  wire [31:0] _io_dout_T_74 = {reg_out[13:0],_io_dout_T_73}; // @[Cat.scala 31:58]
  wire [18:0] _io_dout_T_77 = reg_inbit ? 19'h7ffff : 19'h0; // @[Bitwise.scala 74:12]
  wire [31:0] _io_dout_T_78 = {reg_out[12:0],_io_dout_T_77}; // @[Cat.scala 31:58]
  wire [19:0] _io_dout_T_81 = reg_inbit ? 20'hfffff : 20'h0; // @[Bitwise.scala 74:12]
  wire [31:0] _io_dout_T_82 = {reg_out[11:0],_io_dout_T_81}; // @[Cat.scala 31:58]
  wire [20:0] _io_dout_T_85 = reg_inbit ? 21'h1fffff : 21'h0; // @[Bitwise.scala 74:12]
  wire [31:0] _io_dout_T_86 = {reg_out[10:0],_io_dout_T_85}; // @[Cat.scala 31:58]
  wire [21:0] _io_dout_T_89 = reg_inbit ? 22'h3fffff : 22'h0; // @[Bitwise.scala 74:12]
  wire [31:0] _io_dout_T_90 = {reg_out[9:0],_io_dout_T_89}; // @[Cat.scala 31:58]
  wire [22:0] _io_dout_T_93 = reg_inbit ? 23'h7fffff : 23'h0; // @[Bitwise.scala 74:12]
  wire [31:0] _io_dout_T_94 = {reg_out[8:0],_io_dout_T_93}; // @[Cat.scala 31:58]
  wire [23:0] _io_dout_T_97 = reg_inbit ? 24'hffffff : 24'h0; // @[Bitwise.scala 74:12]
  wire [31:0] _io_dout_T_98 = {reg_out[7:0],_io_dout_T_97}; // @[Cat.scala 31:58]
  wire [24:0] _io_dout_T_101 = reg_inbit ? 25'h1ffffff : 25'h0; // @[Bitwise.scala 74:12]
  wire [31:0] _io_dout_T_102 = {reg_out[6:0],_io_dout_T_101}; // @[Cat.scala 31:58]
  wire [25:0] _io_dout_T_105 = reg_inbit ? 26'h3ffffff : 26'h0; // @[Bitwise.scala 74:12]
  wire [31:0] _io_dout_T_106 = {reg_out[5:0],_io_dout_T_105}; // @[Cat.scala 31:58]
  wire [26:0] _reg_out_T_2 = reg_inbit ? 27'h7ffffff : 27'h0; // @[Bitwise.scala 74:12]
  wire [31:0] _reg_out_T_3 = {reg_out[4:0],_reg_out_T_2}; // @[Cat.scala 31:58]
  wire [27:0] _io_dout_T_109 = reg_inbit ? 28'hfffffff : 28'h0; // @[Bitwise.scala 74:12]
  wire [31:0] _io_dout_T_110 = {reg_out[3:0],_io_dout_T_109}; // @[Cat.scala 31:58]
  wire [28:0] _io_dout_T_113 = reg_inbit ? 29'h1fffffff : 29'h0; // @[Bitwise.scala 74:12]
  wire [31:0] _io_dout_T_114 = {reg_out[2:0],_io_dout_T_113}; // @[Cat.scala 31:58]
  wire [29:0] _io_dout_T_117 = reg_inbit ? 30'h3fffffff : 30'h0; // @[Bitwise.scala 74:12]
  wire [31:0] _io_dout_T_118 = {reg_out[1:0],_io_dout_T_117}; // @[Cat.scala 31:58]
  wire [30:0] _io_dout_T_121 = reg_inbit ? 31'h7fffffff : 31'h0; // @[Bitwise.scala 74:12]
  wire [31:0] _io_dout_T_122 = {reg_out[0],_io_dout_T_121}; // @[Cat.scala 31:58]
  wire [31:0] _GEN_0 = 32'h1f == io_din_2 ? _io_dout_T_122 : 32'h0; // @[ALU.scala 165:19 51:13 70:24]
  wire [31:0] _GEN_1 = 32'h1e == io_din_2 ? _io_dout_T_118 : _GEN_0; // @[ALU.scala 162:19 70:24]
  wire [31:0] _GEN_2 = 32'h1d == io_din_2 ? _io_dout_T_114 : _GEN_1; // @[ALU.scala 159:19 70:24]
  wire [31:0] _GEN_3 = 32'h1c == io_din_2 ? _io_dout_T_110 : _GEN_2; // @[ALU.scala 156:19 70:24]
  wire [31:0] _GEN_4 = 32'h1b == io_din_2 ? _reg_out_T_3 : io_din_1; // @[ALU.scala 153:19 46:13 70:24]
  wire [31:0] _GEN_5 = 32'h1b == io_din_2 ? 32'h0 : _GEN_3; // @[ALU.scala 51:13 70:24]
  wire [31:0] _GEN_6 = 32'h1a == io_din_2 ? _io_dout_T_106 : _GEN_5; // @[ALU.scala 150:19 70:24]
  wire [31:0] _GEN_7 = 32'h1a == io_din_2 ? io_din_1 : _GEN_4; // @[ALU.scala 46:13 70:24]
  wire [31:0] _GEN_8 = 32'h19 == io_din_2 ? _io_dout_T_102 : _GEN_6; // @[ALU.scala 147:19 70:24]
  wire [31:0] _GEN_9 = 32'h19 == io_din_2 ? io_din_1 : _GEN_7; // @[ALU.scala 46:13 70:24]
  wire [31:0] _GEN_10 = 32'h18 == io_din_2 ? _io_dout_T_98 : _GEN_8; // @[ALU.scala 144:19 70:24]
  wire [31:0] _GEN_11 = 32'h18 == io_din_2 ? io_din_1 : _GEN_9; // @[ALU.scala 46:13 70:24]
  wire [31:0] _GEN_12 = 32'h17 == io_din_2 ? _io_dout_T_94 : _GEN_10; // @[ALU.scala 141:19 70:24]
  wire [31:0] _GEN_13 = 32'h17 == io_din_2 ? io_din_1 : _GEN_11; // @[ALU.scala 46:13 70:24]
  wire [31:0] _GEN_14 = 32'h16 == io_din_2 ? _io_dout_T_90 : _GEN_12; // @[ALU.scala 138:19 70:24]
  wire [31:0] _GEN_15 = 32'h16 == io_din_2 ? io_din_1 : _GEN_13; // @[ALU.scala 46:13 70:24]
  wire [31:0] _GEN_16 = 32'h15 == io_din_2 ? _io_dout_T_86 : _GEN_14; // @[ALU.scala 135:19 70:24]
  wire [31:0] _GEN_17 = 32'h15 == io_din_2 ? io_din_1 : _GEN_15; // @[ALU.scala 46:13 70:24]
  wire [31:0] _GEN_18 = 32'h14 == io_din_2 ? _io_dout_T_82 : _GEN_16; // @[ALU.scala 132:19 70:24]
  wire [31:0] _GEN_19 = 32'h14 == io_din_2 ? io_din_1 : _GEN_17; // @[ALU.scala 46:13 70:24]
  wire [31:0] _GEN_20 = 32'h13 == io_din_2 ? _io_dout_T_78 : _GEN_18; // @[ALU.scala 129:19 70:24]
  wire [31:0] _GEN_21 = 32'h13 == io_din_2 ? io_din_1 : _GEN_19; // @[ALU.scala 46:13 70:24]
  wire [31:0] _GEN_22 = 32'h12 == io_din_2 ? _io_dout_T_74 : _GEN_20; // @[ALU.scala 126:19 70:24]
  wire [31:0] _GEN_23 = 32'h12 == io_din_2 ? io_din_1 : _GEN_21; // @[ALU.scala 46:13 70:24]
  wire [31:0] _GEN_24 = 32'h11 == io_din_2 ? _io_dout_T_70 : _GEN_22; // @[ALU.scala 123:19 70:24]
  wire [31:0] _GEN_25 = 32'h11 == io_din_2 ? io_din_1 : _GEN_23; // @[ALU.scala 46:13 70:24]
  wire [31:0] _GEN_26 = 32'h10 == io_din_2 ? _io_dout_T_66 : _GEN_24; // @[ALU.scala 120:19 70:24]
  wire [31:0] _GEN_27 = 32'h10 == io_din_2 ? io_din_1 : _GEN_25; // @[ALU.scala 46:13 70:24]
  wire [31:0] _GEN_28 = 32'hf == io_din_2 ? _io_dout_T_62 : _GEN_26; // @[ALU.scala 117:19 70:24]
  wire [31:0] _GEN_29 = 32'hf == io_din_2 ? io_din_1 : _GEN_27; // @[ALU.scala 46:13 70:24]
  wire [31:0] _GEN_30 = 32'he == io_din_2 ? _io_dout_T_58 : _GEN_28; // @[ALU.scala 114:19 70:24]
  wire [31:0] _GEN_31 = 32'he == io_din_2 ? io_din_1 : _GEN_29; // @[ALU.scala 46:13 70:24]
  wire [31:0] _GEN_32 = 32'hd == io_din_2 ? _io_dout_T_54 : _GEN_30; // @[ALU.scala 111:19 70:24]
  wire [31:0] _GEN_33 = 32'hd == io_din_2 ? io_din_1 : _GEN_31; // @[ALU.scala 46:13 70:24]
  wire [31:0] _GEN_34 = 32'hc == io_din_2 ? _io_dout_T_50 : _GEN_32; // @[ALU.scala 108:19 70:24]
  wire [31:0] _GEN_35 = 32'hc == io_din_2 ? io_din_1 : _GEN_33; // @[ALU.scala 46:13 70:24]
  wire [31:0] _GEN_36 = 32'hb == io_din_2 ? _io_dout_T_46 : _GEN_34; // @[ALU.scala 105:19 70:24]
  wire [31:0] _GEN_37 = 32'hb == io_din_2 ? io_din_1 : _GEN_35; // @[ALU.scala 46:13 70:24]
  wire [31:0] _GEN_38 = 32'ha == io_din_2 ? _io_dout_T_42 : _GEN_36; // @[ALU.scala 102:19 70:24]
  wire [31:0] _GEN_39 = 32'ha == io_din_2 ? io_din_1 : _GEN_37; // @[ALU.scala 46:13 70:24]
  wire [31:0] _GEN_40 = 32'h9 == io_din_2 ? _io_dout_T_38 : _GEN_38; // @[ALU.scala 70:24 99:19]
  wire [31:0] _GEN_41 = 32'h9 == io_din_2 ? io_din_1 : _GEN_39; // @[ALU.scala 46:13 70:24]
  wire [31:0] _GEN_42 = 32'h8 == io_din_2 ? _io_dout_T_34 : _GEN_40; // @[ALU.scala 70:24 96:19]
  wire [31:0] _GEN_43 = 32'h8 == io_din_2 ? io_din_1 : _GEN_41; // @[ALU.scala 46:13 70:24]
  wire [31:0] _GEN_44 = 32'h7 == io_din_2 ? _io_dout_T_30 : _GEN_42; // @[ALU.scala 70:24 93:19]
  wire [31:0] _GEN_45 = 32'h7 == io_din_2 ? io_din_1 : _GEN_43; // @[ALU.scala 46:13 70:24]
  wire [31:0] _GEN_46 = 32'h6 == io_din_2 ? _io_dout_T_26 : _GEN_44; // @[ALU.scala 70:24 90:19]
  wire [31:0] _GEN_47 = 32'h6 == io_din_2 ? io_din_1 : _GEN_45; // @[ALU.scala 46:13 70:24]
  wire [31:0] _GEN_48 = 32'h5 == io_din_2 ? _io_dout_T_22 : _GEN_46; // @[ALU.scala 70:24 87:19]
  wire [31:0] _GEN_49 = 32'h5 == io_din_2 ? io_din_1 : _GEN_47; // @[ALU.scala 46:13 70:24]
  wire [31:0] _GEN_50 = 32'h4 == io_din_2 ? _io_dout_T_18 : _GEN_48; // @[ALU.scala 70:24 84:19]
  wire [31:0] _GEN_51 = 32'h4 == io_din_2 ? io_din_1 : _GEN_49; // @[ALU.scala 46:13 70:24]
  wire [31:0] _GEN_52 = 32'h3 == io_din_2 ? _io_dout_T_14 : _GEN_50; // @[ALU.scala 70:24 81:19]
  wire [31:0] _GEN_53 = 32'h3 == io_din_2 ? io_din_1 : _GEN_51; // @[ALU.scala 46:13 70:24]
  wire [31:0] _GEN_54 = 32'h2 == io_din_2 ? _io_dout_T_10 : _GEN_52; // @[ALU.scala 70:24 78:19]
  wire [31:0] _GEN_55 = 32'h2 == io_din_2 ? io_din_1 : _GEN_53; // @[ALU.scala 46:13 70:24]
  wire [31:0] _GEN_56 = 32'h1 == io_din_2 ? _io_dout_T_6 : _GEN_54; // @[ALU.scala 70:24 75:19]
  wire [31:0] _GEN_57 = 32'h1 == io_din_2 ? io_din_1 : _GEN_55; // @[ALU.scala 46:13 70:24]
  wire [31:0] _GEN_58 = 32'h0 == io_din_2 ? reg_out : _GEN_56; // @[ALU.scala 70:24 72:19]
  wire [31:0] _GEN_59 = 32'h0 == io_din_2 ? io_din_1 : _GEN_57; // @[ALU.scala 46:13 70:24]
  wire [31:0] _io_dout_T_124 = $signed(din_1_signed) >>> io_din_2; // @[ALU.scala 178:45]
  wire [31:0] _io_dout_T_125 = io_din_1 >> io_din_2; // @[ALU.scala 187:27]
  wire [31:0] _io_dout_T_126 = io_din_1 & io_din_2; // @[ALU.scala 190:27]
  wire [31:0] _io_dout_T_127 = io_din_1 | io_din_2; // @[ALU.scala 193:27]
  wire [31:0] _io_dout_T_128 = io_din_1 ^ io_din_2; // @[ALU.scala 196:27]
  wire [31:0] _GEN_60 = io_din_1 > io_din_2 ? io_din_2 : 32'h0; // @[ALU.scala 202:38 203:17 51:13]
  wire [31:0] _GEN_61 = io_din_1 <= io_din_2 ? io_din_1 : _GEN_60; // @[ALU.scala 199:35 200:17]
  wire [31:0] _GEN_62 = io_din_1 < io_din_2 ? io_din_2 : 32'h0; // @[ALU.scala 210:38 211:17 51:13]
  wire [31:0] _GEN_63 = io_din_1 >= io_din_2 ? io_din_1 : _GEN_62; // @[ALU.scala 207:35 208:17]
  wire [31:0] _GEN_64 = io_op_config == 5'hb ? _GEN_63 : 32'h0; // @[ALU.scala 206:38 215:15]
  wire [31:0] _GEN_65 = io_op_config == 5'ha ? _GEN_61 : _GEN_64; // @[ALU.scala 198:38]
  wire [31:0] _GEN_66 = io_op_config == 5'h8 ? _io_dout_T_128 : _GEN_65; // @[ALU.scala 195:38 196:15]
  wire [31:0] _GEN_67 = io_op_config == 5'h7 ? _io_dout_T_127 : _GEN_66; // @[ALU.scala 192:37 193:15]
  wire [31:0] _GEN_68 = io_op_config == 5'h6 ? _io_dout_T_126 : _GEN_67; // @[ALU.scala 189:38 190:15]
  wire [31:0] _GEN_69 = io_op_config == 5'h5 ? _io_dout_T_125 : _GEN_68; // @[ALU.scala 186:38 187:15]
  wire [31:0] _GEN_70 = io_op_config == 5'h4 ? $signed(io_din_1) : $signed(din_1_signed); // @[ALU.scala 176:38 177:20 42:31]
  wire [31:0] _GEN_71 = io_op_config == 5'h4 ? _io_dout_T_124 : _GEN_69; // @[ALU.scala 176:38 178:15]
  wire [31:0] _GEN_72 = io_op_config == 5'h3 ? _GEN_58 : _GEN_71; // @[ALU.scala 69:38]
  wire [31:0] _GEN_73 = io_op_config == 5'h3 ? _GEN_59 : io_din_1; // @[ALU.scala 46:13 69:38]
  wire [31:0] _GEN_74 = io_op_config == 5'h3 ? $signed(din_1_signed) : $signed(_GEN_70); // @[ALU.scala 42:31 69:38]
  wire [31:0] _GEN_75 = io_op_config == 5'h2 ? _io_dout_T_4 : _GEN_72; // @[ALU.scala 59:38 60:15]
  wire [63:0] _GEN_78 = io_op_config == 5'h1 ? _io_dout_T_2 : {{32'd0}, _GEN_75}; // @[ALU.scala 56:38 57:15]
  wire [63:0] _GEN_81 = io_op_config == 5'h0 ? {{32'd0}, _io_dout_T_1} : _GEN_78; // @[ALU.scala 53:33 54:15]
  assign io_dout = _GEN_81[31:0];
  always @(posedge clock) begin
    if (reset) begin // @[ALU.scala 42:31]
      din_1_signed <= 32'sh0; // @[ALU.scala 42:31]
    end else if (!(io_op_config == 5'h0)) begin // @[ALU.scala 53:33]
      if (!(io_op_config == 5'h1)) begin // @[ALU.scala 56:38]
        if (!(io_op_config == 5'h2)) begin // @[ALU.scala 59:38]
          din_1_signed <= _GEN_74;
        end
      end
    end
    if (reset) begin // @[ALU.scala 45:26]
      reg_out <= 32'h0; // @[ALU.scala 45:26]
    end else if (io_op_config == 5'h0) begin // @[ALU.scala 53:33]
      reg_out <= io_din_1; // @[ALU.scala 46:13]
    end else if (io_op_config == 5'h1) begin // @[ALU.scala 56:38]
      reg_out <= io_din_1; // @[ALU.scala 46:13]
    end else if (io_op_config == 5'h2) begin // @[ALU.scala 59:38]
      reg_out <= io_din_1; // @[ALU.scala 46:13]
    end else begin
      reg_out <= _GEN_73;
    end
    if (reset) begin // @[ALU.scala 47:28]
      reg_inbit <= 1'h0; // @[ALU.scala 47:28]
    end else begin
      reg_inbit <= io_din_1[31]; // @[ALU.scala 48:15]
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
  din_1_signed = _RAND_0[31:0];
  _RAND_1 = {1{`RANDOM}};
  reg_out = _RAND_1[31:0];
  _RAND_2 = {1{`RANDOM}};
  reg_inbit = _RAND_2[0:0];
`endif // RANDOMIZE_REG_INIT
  `endif // RANDOMIZE
end // initial
`ifdef FIRRTL_AFTER_INITIAL
`FIRRTL_AFTER_INITIAL
`endif
`endif // SYNTHESIS
endmodule
