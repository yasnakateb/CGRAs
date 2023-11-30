circuit ALU :
  module ALU :
    input clock : Clock
    input reset : UInt<1>
    output io : { flip din_1 : SInt<32>, flip din_2 : SInt<32>, flip op_config : UInt<5>, dout : SInt<32>}

    wire out_aux : SInt<32> @[ALU.scala 68:23]
    node _T = eq(io.op_config, UInt<1>("h0")) @[ALU.scala 70:24]
    when _T : @[ALU.scala 70:33]
      node _out_aux_T = add(io.din_1, io.din_2) @[ALU.scala 71:27]
      node _out_aux_T_1 = tail(_out_aux_T, 1) @[ALU.scala 71:27]
      node _out_aux_T_2 = asSInt(_out_aux_T_1) @[ALU.scala 71:27]
      out_aux <= _out_aux_T_2 @[ALU.scala 71:15]
    else :
      node _T_1 = eq(io.op_config, UInt<1>("h1")) @[ALU.scala 73:29]
      when _T_1 : @[ALU.scala 73:38]
        node _out_aux_T_3 = mul(io.din_1, io.din_2) @[ALU.scala 74:27]
        out_aux <= _out_aux_T_3 @[ALU.scala 74:15]
      else :
        node _T_2 = eq(io.op_config, UInt<2>("h2")) @[ALU.scala 76:29]
        when _T_2 : @[ALU.scala 76:38]
          node _out_aux_T_4 = sub(io.din_1, io.din_2) @[ALU.scala 77:27]
          node _out_aux_T_5 = tail(_out_aux_T_4, 1) @[ALU.scala 77:27]
          node _out_aux_T_6 = asSInt(_out_aux_T_5) @[ALU.scala 77:27]
          out_aux <= _out_aux_T_6 @[ALU.scala 77:15]
        else :
          node _T_3 = eq(io.op_config, UInt<2>("h3")) @[ALU.scala 79:29]
          when _T_3 : @[ALU.scala 79:38]
            node _out_aux_T_7 = bits(io.din_2, 18, 0) @[ALU.scala 81:39]
            node _out_aux_T_8 = dshl(io.din_1, _out_aux_T_7) @[ALU.scala 81:27]
            out_aux <= _out_aux_T_8 @[ALU.scala 81:15]
          else :
            node _T_4 = eq(io.op_config, UInt<3>("h4")) @[ALU.scala 83:29]
            when _T_4 : @[ALU.scala 83:38]
              node _out_aux_T_9 = asUInt(io.din_2) @[ALU.scala 84:39]
              node _out_aux_T_10 = dshr(io.din_1, _out_aux_T_9) @[ALU.scala 84:27]
              out_aux <= _out_aux_T_10 @[ALU.scala 84:15]
            else :
              node _T_5 = eq(io.op_config, UInt<3>("h5")) @[ALU.scala 86:29]
              when _T_5 : @[ALU.scala 86:38]
                node _out_aux_T_11 = asUInt(io.din_1) @[ALU.scala 87:28]
                node _out_aux_T_12 = asUInt(io.din_2) @[ALU.scala 87:47]
                node _out_aux_T_13 = dshr(_out_aux_T_11, _out_aux_T_12) @[ALU.scala 87:35]
                node _out_aux_T_14 = asSInt(_out_aux_T_13) @[ALU.scala 87:55]
                out_aux <= _out_aux_T_14 @[ALU.scala 87:15]
              else :
                node _T_6 = eq(io.op_config, UInt<3>("h6")) @[ALU.scala 89:29]
                when _T_6 : @[ALU.scala 89:38]
                  node _out_aux_T_15 = and(io.din_1, io.din_2) @[ALU.scala 90:27]
                  node _out_aux_T_16 = asSInt(_out_aux_T_15) @[ALU.scala 90:27]
                  out_aux <= _out_aux_T_16 @[ALU.scala 90:15]
                else :
                  node _T_7 = eq(io.op_config, UInt<3>("h7")) @[ALU.scala 92:29]
                  when _T_7 : @[ALU.scala 92:37]
                    node _out_aux_T_17 = or(io.din_1, io.din_2) @[ALU.scala 93:27]
                    node _out_aux_T_18 = asSInt(_out_aux_T_17) @[ALU.scala 93:27]
                    out_aux <= _out_aux_T_18 @[ALU.scala 93:15]
                  else :
                    node _T_8 = eq(io.op_config, UInt<4>("h8")) @[ALU.scala 95:29]
                    when _T_8 : @[ALU.scala 95:38]
                      node _out_aux_T_19 = xor(io.din_1, io.din_2) @[ALU.scala 96:27]
                      node _out_aux_T_20 = asSInt(_out_aux_T_19) @[ALU.scala 96:27]
                      out_aux <= _out_aux_T_20 @[ALU.scala 96:15]
                    else :
                      out_aux <= asSInt(UInt<1>("h0")) @[ALU.scala 99:15]
    io.dout <= out_aux @[ALU.scala 102:11]

