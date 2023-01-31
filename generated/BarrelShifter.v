module BarrelShifter(
  input         clock,
  input         reset,
  input         io_load,
  input         io_rshift,
  input         io_lshift,
  input  [4:0]  io_shiftnum,
  input         io_inbit,
  input  [31:0] io_in,
  output [31:0] io_out
);
`ifdef RANDOMIZE_REG_INIT
  reg [31:0] _RAND_0;
`endif // RANDOMIZE_REG_INIT
  reg [31:0] reg_out; // @[BarrelShifter.scala 17:24]
  wire [31:0] _reg_out_T_1 = {io_inbit,reg_out[31:1]}; // @[Cat.scala 31:58]
  wire [1:0] _reg_out_T_3 = io_inbit ? 2'h3 : 2'h0; // @[Bitwise.scala 74:12]
  wire [31:0] _reg_out_T_5 = {_reg_out_T_3,reg_out[31:2]}; // @[Cat.scala 31:58]
  wire [2:0] _reg_out_T_7 = io_inbit ? 3'h7 : 3'h0; // @[Bitwise.scala 74:12]
  wire [31:0] _reg_out_T_9 = {_reg_out_T_7,reg_out[31:3]}; // @[Cat.scala 31:58]
  wire [3:0] _reg_out_T_11 = io_inbit ? 4'hf : 4'h0; // @[Bitwise.scala 74:12]
  wire [31:0] _reg_out_T_13 = {_reg_out_T_11,reg_out[31:4]}; // @[Cat.scala 31:58]
  wire [4:0] _reg_out_T_15 = io_inbit ? 5'h1f : 5'h0; // @[Bitwise.scala 74:12]
  wire [31:0] _reg_out_T_17 = {_reg_out_T_15,reg_out[31:5]}; // @[Cat.scala 31:58]
  wire [5:0] _reg_out_T_19 = io_inbit ? 6'h3f : 6'h0; // @[Bitwise.scala 74:12]
  wire [31:0] _reg_out_T_21 = {_reg_out_T_19,reg_out[31:6]}; // @[Cat.scala 31:58]
  wire [6:0] _reg_out_T_23 = io_inbit ? 7'h7f : 7'h0; // @[Bitwise.scala 74:12]
  wire [31:0] _reg_out_T_25 = {_reg_out_T_23,reg_out[31:7]}; // @[Cat.scala 31:58]
  wire [7:0] _reg_out_T_27 = io_inbit ? 8'hff : 8'h0; // @[Bitwise.scala 74:12]
  wire [31:0] _reg_out_T_29 = {_reg_out_T_27,reg_out[31:8]}; // @[Cat.scala 31:58]
  wire [8:0] _reg_out_T_31 = io_inbit ? 9'h1ff : 9'h0; // @[Bitwise.scala 74:12]
  wire [31:0] _reg_out_T_33 = {_reg_out_T_31,reg_out[31:9]}; // @[Cat.scala 31:58]
  wire [9:0] _reg_out_T_35 = io_inbit ? 10'h3ff : 10'h0; // @[Bitwise.scala 74:12]
  wire [31:0] _reg_out_T_37 = {_reg_out_T_35,reg_out[31:10]}; // @[Cat.scala 31:58]
  wire [10:0] _reg_out_T_39 = io_inbit ? 11'h7ff : 11'h0; // @[Bitwise.scala 74:12]
  wire [31:0] _reg_out_T_41 = {_reg_out_T_39,reg_out[31:11]}; // @[Cat.scala 31:58]
  wire [11:0] _reg_out_T_43 = io_inbit ? 12'hfff : 12'h0; // @[Bitwise.scala 74:12]
  wire [31:0] _reg_out_T_45 = {_reg_out_T_43,reg_out[31:12]}; // @[Cat.scala 31:58]
  wire [12:0] _reg_out_T_47 = io_inbit ? 13'h1fff : 13'h0; // @[Bitwise.scala 74:12]
  wire [31:0] _reg_out_T_49 = {_reg_out_T_47,reg_out[31:13]}; // @[Cat.scala 31:58]
  wire [13:0] _reg_out_T_51 = io_inbit ? 14'h3fff : 14'h0; // @[Bitwise.scala 74:12]
  wire [31:0] _reg_out_T_53 = {_reg_out_T_51,reg_out[31:14]}; // @[Cat.scala 31:58]
  wire [14:0] _reg_out_T_55 = io_inbit ? 15'h7fff : 15'h0; // @[Bitwise.scala 74:12]
  wire [31:0] _reg_out_T_57 = {_reg_out_T_55,reg_out[31:15]}; // @[Cat.scala 31:58]
  wire [15:0] _reg_out_T_59 = io_inbit ? 16'hffff : 16'h0; // @[Bitwise.scala 74:12]
  wire [31:0] _reg_out_T_61 = {_reg_out_T_59,reg_out[31:16]}; // @[Cat.scala 31:58]
  wire [16:0] _reg_out_T_63 = io_inbit ? 17'h1ffff : 17'h0; // @[Bitwise.scala 74:12]
  wire [31:0] _reg_out_T_65 = {_reg_out_T_63,reg_out[31:17]}; // @[Cat.scala 31:58]
  wire [17:0] _reg_out_T_67 = io_inbit ? 18'h3ffff : 18'h0; // @[Bitwise.scala 74:12]
  wire [31:0] _reg_out_T_69 = {_reg_out_T_67,reg_out[31:18]}; // @[Cat.scala 31:58]
  wire [18:0] _reg_out_T_71 = io_inbit ? 19'h7ffff : 19'h0; // @[Bitwise.scala 74:12]
  wire [31:0] _reg_out_T_73 = {_reg_out_T_71,reg_out[31:19]}; // @[Cat.scala 31:58]
  wire [19:0] _reg_out_T_75 = io_inbit ? 20'hfffff : 20'h0; // @[Bitwise.scala 74:12]
  wire [31:0] _reg_out_T_77 = {_reg_out_T_75,reg_out[31:20]}; // @[Cat.scala 31:58]
  wire [20:0] _reg_out_T_79 = io_inbit ? 21'h1fffff : 21'h0; // @[Bitwise.scala 74:12]
  wire [31:0] _reg_out_T_81 = {_reg_out_T_79,reg_out[31:21]}; // @[Cat.scala 31:58]
  wire [21:0] _reg_out_T_83 = io_inbit ? 22'h3fffff : 22'h0; // @[Bitwise.scala 74:12]
  wire [31:0] _reg_out_T_85 = {_reg_out_T_83,reg_out[31:22]}; // @[Cat.scala 31:58]
  wire [22:0] _reg_out_T_87 = io_inbit ? 23'h7fffff : 23'h0; // @[Bitwise.scala 74:12]
  wire [31:0] _reg_out_T_89 = {_reg_out_T_87,reg_out[31:23]}; // @[Cat.scala 31:58]
  wire [23:0] _reg_out_T_91 = io_inbit ? 24'hffffff : 24'h0; // @[Bitwise.scala 74:12]
  wire [31:0] _reg_out_T_93 = {_reg_out_T_91,reg_out[31:24]}; // @[Cat.scala 31:58]
  wire [24:0] _reg_out_T_95 = io_inbit ? 25'h1ffffff : 25'h0; // @[Bitwise.scala 74:12]
  wire [31:0] _reg_out_T_97 = {_reg_out_T_95,reg_out[31:25]}; // @[Cat.scala 31:58]
  wire [25:0] _reg_out_T_99 = io_inbit ? 26'h3ffffff : 26'h0; // @[Bitwise.scala 74:12]
  wire [31:0] _reg_out_T_101 = {_reg_out_T_99,reg_out[31:26]}; // @[Cat.scala 31:58]
  wire [26:0] _reg_out_T_103 = io_inbit ? 27'h7ffffff : 27'h0; // @[Bitwise.scala 74:12]
  wire [31:0] _reg_out_T_105 = {_reg_out_T_103,reg_out[31:27]}; // @[Cat.scala 31:58]
  wire [27:0] _reg_out_T_107 = io_inbit ? 28'hfffffff : 28'h0; // @[Bitwise.scala 74:12]
  wire [31:0] _reg_out_T_109 = {_reg_out_T_107,reg_out[31:28]}; // @[Cat.scala 31:58]
  wire [28:0] _reg_out_T_111 = io_inbit ? 29'h1fffffff : 29'h0; // @[Bitwise.scala 74:12]
  wire [31:0] _reg_out_T_113 = {_reg_out_T_111,reg_out[31:29]}; // @[Cat.scala 31:58]
  wire [29:0] _reg_out_T_115 = io_inbit ? 30'h3fffffff : 30'h0; // @[Bitwise.scala 74:12]
  wire [31:0] _reg_out_T_117 = {_reg_out_T_115,reg_out[31:30]}; // @[Cat.scala 31:58]
  wire [30:0] _reg_out_T_119 = io_inbit ? 31'h7fffffff : 31'h0; // @[Bitwise.scala 74:12]
  wire [31:0] _reg_out_T_121 = {_reg_out_T_119,reg_out[31]}; // @[Cat.scala 31:58]
  wire [31:0] _GEN_0 = 5'h1f == io_shiftnum ? _reg_out_T_121 : reg_out; // @[BarrelShifter.scala 123:17 17:24 28:25]
  wire [31:0] _GEN_1 = 5'h1e == io_shiftnum ? _reg_out_T_117 : _GEN_0; // @[BarrelShifter.scala 120:17 28:25]
  wire [31:0] _GEN_2 = 5'h1d == io_shiftnum ? _reg_out_T_113 : _GEN_1; // @[BarrelShifter.scala 117:17 28:25]
  wire [31:0] _GEN_3 = 5'h1c == io_shiftnum ? _reg_out_T_109 : _GEN_2; // @[BarrelShifter.scala 114:17 28:25]
  wire [31:0] _GEN_4 = 5'h1b == io_shiftnum ? _reg_out_T_105 : _GEN_3; // @[BarrelShifter.scala 111:17 28:25]
  wire [31:0] _GEN_5 = 5'h1a == io_shiftnum ? _reg_out_T_101 : _GEN_4; // @[BarrelShifter.scala 108:17 28:25]
  wire [31:0] _GEN_6 = 5'h19 == io_shiftnum ? _reg_out_T_97 : _GEN_5; // @[BarrelShifter.scala 105:17 28:25]
  wire [31:0] _GEN_7 = 5'h18 == io_shiftnum ? _reg_out_T_93 : _GEN_6; // @[BarrelShifter.scala 102:17 28:25]
  wire [31:0] _GEN_8 = 5'h17 == io_shiftnum ? _reg_out_T_89 : _GEN_7; // @[BarrelShifter.scala 28:25 99:17]
  wire [31:0] _GEN_9 = 5'h16 == io_shiftnum ? _reg_out_T_85 : _GEN_8; // @[BarrelShifter.scala 28:25 96:17]
  wire [31:0] _GEN_10 = 5'h15 == io_shiftnum ? _reg_out_T_81 : _GEN_9; // @[BarrelShifter.scala 28:25 93:17]
  wire [31:0] _GEN_11 = 5'h14 == io_shiftnum ? _reg_out_T_77 : _GEN_10; // @[BarrelShifter.scala 28:25 90:17]
  wire [31:0] _GEN_12 = 5'h13 == io_shiftnum ? _reg_out_T_73 : _GEN_11; // @[BarrelShifter.scala 28:25 87:17]
  wire [31:0] _GEN_13 = 5'h12 == io_shiftnum ? _reg_out_T_69 : _GEN_12; // @[BarrelShifter.scala 28:25 84:17]
  wire [31:0] _GEN_14 = 5'h11 == io_shiftnum ? _reg_out_T_65 : _GEN_13; // @[BarrelShifter.scala 28:25 81:17]
  wire [31:0] _GEN_15 = 5'h10 == io_shiftnum ? _reg_out_T_61 : _GEN_14; // @[BarrelShifter.scala 28:25 78:17]
  wire [31:0] _GEN_16 = 5'hf == io_shiftnum ? _reg_out_T_57 : _GEN_15; // @[BarrelShifter.scala 28:25 75:17]
  wire [31:0] _GEN_17 = 5'he == io_shiftnum ? _reg_out_T_53 : _GEN_16; // @[BarrelShifter.scala 28:25 72:17]
  wire [31:0] _GEN_18 = 5'hd == io_shiftnum ? _reg_out_T_49 : _GEN_17; // @[BarrelShifter.scala 28:25 69:17]
  wire [31:0] _GEN_19 = 5'hc == io_shiftnum ? _reg_out_T_45 : _GEN_18; // @[BarrelShifter.scala 28:25 66:17]
  wire [31:0] _GEN_20 = 5'hb == io_shiftnum ? _reg_out_T_41 : _GEN_19; // @[BarrelShifter.scala 28:25 63:17]
  wire [31:0] _GEN_21 = 5'ha == io_shiftnum ? _reg_out_T_37 : _GEN_20; // @[BarrelShifter.scala 28:25 60:17]
  wire [31:0] _GEN_22 = 5'h9 == io_shiftnum ? _reg_out_T_33 : _GEN_21; // @[BarrelShifter.scala 28:25 57:17]
  wire [31:0] _GEN_23 = 5'h8 == io_shiftnum ? _reg_out_T_29 : _GEN_22; // @[BarrelShifter.scala 28:25 54:17]
  wire [31:0] _GEN_24 = 5'h7 == io_shiftnum ? _reg_out_T_25 : _GEN_23; // @[BarrelShifter.scala 28:25 51:17]
  wire [31:0] _GEN_25 = 5'h6 == io_shiftnum ? _reg_out_T_21 : _GEN_24; // @[BarrelShifter.scala 28:25 48:17]
  wire [31:0] _GEN_26 = 5'h5 == io_shiftnum ? _reg_out_T_17 : _GEN_25; // @[BarrelShifter.scala 28:25 45:17]
  wire [31:0] _GEN_27 = 5'h4 == io_shiftnum ? _reg_out_T_13 : _GEN_26; // @[BarrelShifter.scala 28:25 42:17]
  wire [31:0] _GEN_28 = 5'h3 == io_shiftnum ? _reg_out_T_9 : _GEN_27; // @[BarrelShifter.scala 28:25 39:17]
  wire [31:0] _GEN_29 = 5'h2 == io_shiftnum ? _reg_out_T_5 : _GEN_28; // @[BarrelShifter.scala 28:25 36:17]
  wire [31:0] _GEN_30 = 5'h1 == io_shiftnum ? _reg_out_T_1 : _GEN_29; // @[BarrelShifter.scala 28:25 33:17]
  wire [31:0] _GEN_31 = 5'h0 == io_shiftnum ? reg_out : _GEN_30; // @[BarrelShifter.scala 28:25 30:17]
  wire  _T_33 = io_shiftnum == 5'h1; // @[BarrelShifter.scala 134:29]
  wire [32:0] _reg_out_T_123 = {reg_out,io_inbit}; // @[Cat.scala 31:58]
  wire [32:0] _reg_out_T_127 = {reg_out[31:1],_reg_out_T_3}; // @[Cat.scala 31:58]
  wire [32:0] _reg_out_T_131 = {reg_out[31:2],_reg_out_T_7}; // @[Cat.scala 31:58]
  wire [32:0] _reg_out_T_135 = {reg_out[31:3],_reg_out_T_11}; // @[Cat.scala 31:58]
  wire [32:0] _reg_out_T_139 = {reg_out[31:4],_reg_out_T_15}; // @[Cat.scala 31:58]
  wire [32:0] _reg_out_T_143 = {reg_out[31:5],_reg_out_T_19}; // @[Cat.scala 31:58]
  wire [32:0] _reg_out_T_147 = {reg_out[31:6],_reg_out_T_23}; // @[Cat.scala 31:58]
  wire [32:0] _reg_out_T_151 = {reg_out[31:7],_reg_out_T_27}; // @[Cat.scala 31:58]
  wire [32:0] _reg_out_T_155 = {reg_out[31:8],_reg_out_T_31}; // @[Cat.scala 31:58]
  wire [32:0] _reg_out_T_159 = {reg_out[31:9],_reg_out_T_35}; // @[Cat.scala 31:58]
  wire [32:0] _reg_out_T_163 = {reg_out[31:10],_reg_out_T_39}; // @[Cat.scala 31:58]
  wire [32:0] _reg_out_T_167 = {reg_out[31:11],_reg_out_T_43}; // @[Cat.scala 31:58]
  wire [32:0] _reg_out_T_171 = {reg_out[31:12],_reg_out_T_47}; // @[Cat.scala 31:58]
  wire [32:0] _reg_out_T_175 = {reg_out[31:13],_reg_out_T_51}; // @[Cat.scala 31:58]
  wire [32:0] _reg_out_T_179 = {reg_out[31:14],_reg_out_T_55}; // @[Cat.scala 31:58]
  wire [32:0] _reg_out_T_183 = {reg_out[31:15],_reg_out_T_59}; // @[Cat.scala 31:58]
  wire [32:0] _reg_out_T_187 = {reg_out[31:16],_reg_out_T_63}; // @[Cat.scala 31:58]
  wire [32:0] _reg_out_T_191 = {reg_out[31:17],_reg_out_T_67}; // @[Cat.scala 31:58]
  wire [32:0] _reg_out_T_195 = {reg_out[31:18],_reg_out_T_71}; // @[Cat.scala 31:58]
  wire [32:0] _reg_out_T_199 = {reg_out[31:19],_reg_out_T_75}; // @[Cat.scala 31:58]
  wire [32:0] _reg_out_T_203 = {reg_out[31:20],_reg_out_T_79}; // @[Cat.scala 31:58]
  wire [32:0] _reg_out_T_207 = {reg_out[31:21],_reg_out_T_83}; // @[Cat.scala 31:58]
  wire [32:0] _reg_out_T_211 = {reg_out[31:22],_reg_out_T_87}; // @[Cat.scala 31:58]
  wire [32:0] _reg_out_T_215 = {reg_out[31:23],_reg_out_T_91}; // @[Cat.scala 31:58]
  wire [32:0] _reg_out_T_219 = {reg_out[31:24],_reg_out_T_95}; // @[Cat.scala 31:58]
  wire [32:0] _reg_out_T_223 = {reg_out[31:25],_reg_out_T_99}; // @[Cat.scala 31:58]
  wire [32:0] _reg_out_T_227 = {reg_out[31:26],_reg_out_T_103}; // @[Cat.scala 31:58]
  wire [32:0] _reg_out_T_231 = {reg_out[31:27],_reg_out_T_107}; // @[Cat.scala 31:58]
  wire [32:0] _reg_out_T_235 = {reg_out[31:28],_reg_out_T_111}; // @[Cat.scala 31:58]
  wire [32:0] _reg_out_T_239 = {reg_out[31:29],_reg_out_T_115}; // @[Cat.scala 31:58]
  wire [31:0] _reg_out_T_243 = {reg_out[31],_reg_out_T_119}; // @[Cat.scala 31:58]
  wire [31:0] _GEN_32 = io_shiftnum == 5'h1f ? _reg_out_T_243 : reg_out; // @[BarrelShifter.scala 228:39 229:17 17:24]
  wire [32:0] _GEN_33 = io_shiftnum == 5'h1e ? _reg_out_T_239 : {{1'd0}, _GEN_32}; // @[BarrelShifter.scala 225:39 226:17]
  wire [32:0] _GEN_34 = io_shiftnum == 5'h1d ? _reg_out_T_235 : _GEN_33; // @[BarrelShifter.scala 222:39 223:17]
  wire [32:0] _GEN_35 = io_shiftnum == 5'h1c ? _reg_out_T_231 : _GEN_34; // @[BarrelShifter.scala 219:39 220:17]
  wire [32:0] _GEN_36 = io_shiftnum == 5'h1b ? _reg_out_T_227 : _GEN_35; // @[BarrelShifter.scala 216:39 217:17]
  wire [32:0] _GEN_37 = io_shiftnum == 5'h1a ? _reg_out_T_223 : _GEN_36; // @[BarrelShifter.scala 213:39 214:17]
  wire [32:0] _GEN_38 = io_shiftnum == 5'h19 ? _reg_out_T_219 : _GEN_37; // @[BarrelShifter.scala 210:39 211:17]
  wire [32:0] _GEN_39 = io_shiftnum == 5'h18 ? _reg_out_T_215 : _GEN_38; // @[BarrelShifter.scala 207:39 208:17]
  wire [32:0] _GEN_40 = io_shiftnum == 5'h17 ? _reg_out_T_211 : _GEN_39; // @[BarrelShifter.scala 204:39 205:17]
  wire [32:0] _GEN_41 = io_shiftnum == 5'h16 ? _reg_out_T_207 : _GEN_40; // @[BarrelShifter.scala 201:39 202:17]
  wire [32:0] _GEN_42 = io_shiftnum == 5'h15 ? _reg_out_T_203 : _GEN_41; // @[BarrelShifter.scala 198:39 199:17]
  wire [32:0] _GEN_43 = io_shiftnum == 5'h14 ? _reg_out_T_199 : _GEN_42; // @[BarrelShifter.scala 195:39 196:17]
  wire [32:0] _GEN_44 = io_shiftnum == 5'h13 ? _reg_out_T_195 : _GEN_43; // @[BarrelShifter.scala 192:39 193:17]
  wire [32:0] _GEN_45 = io_shiftnum == 5'h12 ? _reg_out_T_191 : _GEN_44; // @[BarrelShifter.scala 189:39 190:17]
  wire [32:0] _GEN_46 = io_shiftnum == 5'h11 ? _reg_out_T_187 : _GEN_45; // @[BarrelShifter.scala 186:39 187:17]
  wire [32:0] _GEN_47 = io_shiftnum == 5'h10 ? _reg_out_T_183 : _GEN_46; // @[BarrelShifter.scala 183:39 184:17]
  wire [32:0] _GEN_48 = io_shiftnum == 5'hf ? _reg_out_T_179 : _GEN_47; // @[BarrelShifter.scala 180:39 181:17]
  wire [32:0] _GEN_49 = io_shiftnum == 5'he ? _reg_out_T_175 : _GEN_48; // @[BarrelShifter.scala 177:39 178:17]
  wire [32:0] _GEN_50 = io_shiftnum == 5'hd ? _reg_out_T_171 : _GEN_49; // @[BarrelShifter.scala 174:39 175:17]
  wire [32:0] _GEN_51 = io_shiftnum == 5'hc ? _reg_out_T_167 : _GEN_50; // @[BarrelShifter.scala 171:39 172:17]
  wire [32:0] _GEN_52 = io_shiftnum == 5'hb ? _reg_out_T_163 : _GEN_51; // @[BarrelShifter.scala 168:39 169:17]
  wire [32:0] _GEN_53 = io_shiftnum == 5'ha ? _reg_out_T_159 : _GEN_52; // @[BarrelShifter.scala 165:39 166:17]
  wire [32:0] _GEN_54 = io_shiftnum == 5'h9 ? _reg_out_T_155 : _GEN_53; // @[BarrelShifter.scala 161:38 163:17]
  wire [32:0] _GEN_55 = io_shiftnum == 5'h8 ? _reg_out_T_151 : _GEN_54; // @[BarrelShifter.scala 157:38 159:17]
  wire [32:0] _GEN_56 = io_shiftnum == 5'h7 ? _reg_out_T_147 : _GEN_55; // @[BarrelShifter.scala 154:38 155:17]
  wire [32:0] _GEN_57 = io_shiftnum == 5'h6 ? _reg_out_T_143 : _GEN_56; // @[BarrelShifter.scala 151:38 152:17]
  wire [32:0] _GEN_58 = io_shiftnum == 5'h5 ? _reg_out_T_139 : _GEN_57; // @[BarrelShifter.scala 148:38 149:17]
  wire [32:0] _GEN_59 = io_shiftnum == 5'h4 ? _reg_out_T_135 : _GEN_58; // @[BarrelShifter.scala 145:38 146:17]
  wire [32:0] _GEN_60 = io_shiftnum == 5'h3 ? _reg_out_T_131 : _GEN_59; // @[BarrelShifter.scala 142:38 143:17]
  wire [32:0] _GEN_61 = io_shiftnum == 5'h2 ? _reg_out_T_127 : _GEN_60; // @[BarrelShifter.scala 139:38 140:17]
  wire [32:0] _GEN_62 = _T_33 ? _reg_out_T_123 : _GEN_61; // @[BarrelShifter.scala 135:7 137:17]
  wire [32:0] _GEN_63 = io_shiftnum == 5'h0 ? {{1'd0}, reg_out} : _GEN_62; // @[BarrelShifter.scala 131:33 132:17]
  wire [32:0] _GEN_64 = io_lshift ? _GEN_63 : {{1'd0}, reg_out}; // @[BarrelShifter.scala 129:25 17:24]
  wire [32:0] _GEN_65 = io_rshift ? {{1'd0}, _GEN_31} : _GEN_64; // @[BarrelShifter.scala 26:25]
  wire [32:0] _GEN_66 = io_load ? {{1'd0}, io_in} : _GEN_65; // @[BarrelShifter.scala 23:17 24:13]
  wire [32:0] _GEN_67 = reset ? 33'h0 : _GEN_66; // @[BarrelShifter.scala 17:{24,24}]
  assign io_out = reg_out; // @[BarrelShifter.scala 233:10]
  always @(posedge clock) begin
    reg_out <= _GEN_67[31:0]; // @[BarrelShifter.scala 17:{24,24}]
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
  reg_out = _RAND_0[31:0];
`endif // RANDOMIZE_REG_INIT
  `endif // RANDOMIZE
end // initial
`ifdef FIRRTL_AFTER_INITIAL
`FIRRTL_AFTER_INITIAL
`endif
`endif // SYNTHESIS
endmodule
