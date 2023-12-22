circuit FU :
  module ALU :
    input clock : Clock
    input reset : Reset
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

  module FU :
    input clock : Clock
    input reset : UInt<1>
    output io : { flip din_1 : SInt<32>, flip din_2 : SInt<32>, flip din_v : UInt<1>, flip dout_r : UInt<1>, flip loop_source : UInt<2>, flip iterations_reset : UInt<16>, flip op_config : UInt<5>, din_r : UInt<1>, dout : SInt<32>, dout_v : UInt<1>}

    wire alu_din_1 : SInt<32> @[FU.scala 71:25]
    wire alu_din_2 : SInt<32> @[FU.scala 72:25]
    wire alu_dout : SInt<32> @[FU.scala 74:24]
    reg dout_reg : SInt<32>, clock with :
      reset => (reset, asSInt(UInt<32>("h0"))) @[FU.scala 76:27]
    reg count : UInt<16>, clock with :
      reset => (reset, UInt<16>("h0")) @[FU.scala 77:24]
    reg loaded : UInt<1>, clock with :
      reset => (reset, UInt<1>("h0")) @[FU.scala 78:25]
    reg valid : UInt<1>, clock with :
      reset => (reset, UInt<1>("h0")) @[FU.scala 79:24]
    inst ALU of ALU @[FU.scala 81:22]
    ALU.clock <= clock
    ALU.reset <= reset
    ALU.io.din_1 <= alu_din_1 @[FU.scala 82:18]
    ALU.io.din_2 <= alu_din_2 @[FU.scala 83:18]
    alu_dout <= ALU.io.dout @[FU.scala 84:14]
    ALU.io.op_config <= io.op_config @[FU.scala 85:22]
    node _T = eq(io.loop_source, UInt<2>("h0")) @[FU.scala 87:26]
    when _T : @[FU.scala 87:39]
      alu_din_1 <= io.din_1 @[FU.scala 88:19]
      alu_din_2 <= io.din_2 @[FU.scala 89:19]
    else :
      node _T_1 = eq(io.loop_source, UInt<2>("h1")) @[FU.scala 91:31]
      when _T_1 : @[FU.scala 91:44]
        node _T_2 = eq(loaded, UInt<1>("h0")) @[FU.scala 92:22]
        when _T_2 : @[FU.scala 92:31]
          alu_din_1 <= io.din_1 @[FU.scala 93:23]
          alu_din_2 <= io.din_2 @[FU.scala 94:23]
        else :
          alu_din_1 <= dout_reg @[FU.scala 98:23]
          alu_din_2 <= io.din_2 @[FU.scala 99:23]
      else :
        node _T_3 = eq(io.loop_source, UInt<2>("h2")) @[FU.scala 102:31]
        when _T_3 : @[FU.scala 102:44]
          node _T_4 = eq(loaded, UInt<1>("h0")) @[FU.scala 103:22]
          when _T_4 : @[FU.scala 103:31]
            alu_din_1 <= io.din_1 @[FU.scala 104:23]
            alu_din_2 <= io.din_2 @[FU.scala 105:23]
          else :
            alu_din_1 <= io.din_1 @[FU.scala 108:23]
            alu_din_2 <= dout_reg @[FU.scala 109:23]
        else :
          alu_din_1 <= asSInt(UInt<6>("h1f")) @[FU.scala 113:19]
          alu_din_2 <= asSInt(UInt<6>("h1f")) @[FU.scala 114:19]
    node _T_5 = eq(io.dout_r, UInt<1>("h1")) @[FU.scala 117:21]
    when _T_5 : @[FU.scala 117:30]
      valid <= UInt<1>("h0") @[FU.scala 118:15]
    node _T_6 = eq(io.din_v, UInt<1>("h1")) @[FU.scala 121:20]
    node _T_7 = eq(io.dout_r, UInt<1>("h1")) @[FU.scala 121:41]
    node _T_8 = and(_T_6, _T_7) @[FU.scala 121:28]
    node _T_9 = eq(io.loop_source, UInt<2>("h1")) @[FU.scala 122:29]
    node _T_10 = eq(io.loop_source, UInt<2>("h2")) @[FU.scala 122:59]
    node _T_11 = or(_T_9, _T_10) @[FU.scala 122:41]
    node _T_12 = and(_T_8, _T_11) @[FU.scala 121:49]
    when _T_12 : @[FU.scala 123:9]
      loaded <= UInt<1>("h1") @[FU.scala 124:16]
      node _count_T = add(count, UInt<1>("h1")) @[FU.scala 125:24]
      node _count_T_1 = tail(_count_T, 1) @[FU.scala 125:24]
      count <= _count_T_1 @[FU.scala 125:15]
    node _T_13 = sub(io.iterations_reset, UInt<1>("h1")) @[FU.scala 128:41]
    node _T_14 = tail(_T_13, 1) @[FU.scala 128:41]
    node _T_15 = eq(count, _T_14) @[FU.scala 128:17]
    node _T_16 = eq(io.loop_source, UInt<2>("h1")) @[FU.scala 129:29]
    node _T_17 = eq(io.loop_source, UInt<2>("h2")) @[FU.scala 129:59]
    node _T_18 = or(_T_16, _T_17) @[FU.scala 129:41]
    node _T_19 = and(_T_15, _T_18) @[FU.scala 128:47]
    node _T_20 = eq(io.dout_r, UInt<1>("h1")) @[FU.scala 130:23]
    node _T_21 = and(_T_19, _T_20) @[FU.scala 129:72]
    when _T_21 : @[FU.scala 131:9]
      count <= UInt<1>("h0") @[FU.scala 132:15]
      loaded <= UInt<1>("h0") @[FU.scala 133:16]
      valid <= UInt<1>("h1") @[FU.scala 134:15]
      dout_reg <= alu_dout @[FU.scala 135:18]
    else :
      node _T_22 = eq(io.loop_source, UInt<2>("h1")) @[FU.scala 137:32]
      node _T_23 = eq(io.loop_source, UInt<2>("h2")) @[FU.scala 137:62]
      node _T_24 = or(_T_22, _T_23) @[FU.scala 137:44]
      node _T_25 = eq(io.din_v, UInt<1>("h1")) @[FU.scala 138:26]
      node _T_26 = and(_T_24, _T_25) @[FU.scala 137:75]
      node _T_27 = eq(io.dout_r, UInt<1>("h1")) @[FU.scala 139:27]
      node _T_28 = and(_T_26, _T_27) @[FU.scala 138:34]
      when _T_28 : @[FU.scala 140:9]
        dout_reg <= alu_dout @[FU.scala 141:18]
    io.din_r <= io.dout_r @[FU.scala 144:14]
    node _T_29 = eq(io.loop_source, UInt<2>("h0")) @[FU.scala 146:26]
    when _T_29 : @[FU.scala 146:38]
      io.dout <= alu_dout @[FU.scala 147:17]
      io.dout_v <= io.din_v @[FU.scala 148:19]
    else :
      io.dout <= dout_reg @[FU.scala 151:17]
      io.dout_v <= valid @[FU.scala 152:19]

