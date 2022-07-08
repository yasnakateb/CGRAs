circuit FU :
  module ALU :
    input clock : Clock
    input reset : Reset
    output io : { flip din_1 : UInt<8>, flip din_2 : UInt<8>, flip op_config : UInt<8>, dout : UInt<8>}

    io.dout <= UInt<1>("h0") @[ALU.scala 28:13]
    node _T = eq(io.op_config, UInt<1>("h0")) @[ALU.scala 29:24]
    when _T : @[ALU.scala 29:33]
      node _io_dout_T = add(io.din_1, io.din_2) @[ALU.scala 30:27]
      node _io_dout_T_1 = tail(_io_dout_T, 1) @[ALU.scala 30:27]
      io.dout <= _io_dout_T_1 @[ALU.scala 30:15]
    else :
      node _T_1 = eq(io.op_config, UInt<1>("h1")) @[ALU.scala 32:29]
      when _T_1 : @[ALU.scala 32:38]
        node _io_dout_T_2 = mul(io.din_1, io.din_2) @[ALU.scala 33:27]
        io.dout <= _io_dout_T_2 @[ALU.scala 33:15]
      else :
        node _T_2 = eq(io.op_config, UInt<2>("h2")) @[ALU.scala 35:29]
        when _T_2 : @[ALU.scala 35:38]
          node _io_dout_T_3 = sub(io.din_1, io.din_2) @[ALU.scala 36:27]
          node _io_dout_T_4 = tail(_io_dout_T_3, 1) @[ALU.scala 36:27]
          io.dout <= _io_dout_T_4 @[ALU.scala 36:15]
        else :
          node _T_3 = eq(io.op_config, UInt<2>("h3")) @[ALU.scala 38:29]
          when _T_3 : @[ALU.scala 38:38]
            node _io_dout_T_5 = dshl(io.din_1, io.din_2) @[ALU.scala 39:27]
            io.dout <= _io_dout_T_5 @[ALU.scala 39:15]
          else :
            node _T_4 = eq(io.op_config, UInt<3>("h4")) @[ALU.scala 41:29]
            when _T_4 : @[ALU.scala 41:38]
              node _io_dout_T_6 = dshr(io.din_1, io.din_2) @[ALU.scala 42:27]
              io.dout <= _io_dout_T_6 @[ALU.scala 42:15]
            else :
              node _T_5 = eq(io.op_config, UInt<3>("h5")) @[ALU.scala 44:29]
              when _T_5 : @[ALU.scala 44:38]
                node _io_dout_T_7 = and(io.din_1, io.din_2) @[ALU.scala 45:27]
                io.dout <= _io_dout_T_7 @[ALU.scala 45:15]
              else :
                node _T_6 = eq(io.op_config, UInt<3>("h6")) @[ALU.scala 47:29]
                when _T_6 : @[ALU.scala 47:37]
                  node _io_dout_T_8 = or(io.din_1, io.din_2) @[ALU.scala 48:27]
                  io.dout <= _io_dout_T_8 @[ALU.scala 48:15]
                else :
                  node _T_7 = eq(io.op_config, UInt<3>("h7")) @[ALU.scala 50:29]
                  when _T_7 : @[ALU.scala 50:38]
                    node _io_dout_T_9 = xor(io.din_1, io.din_2) @[ALU.scala 51:27]
                    io.dout <= _io_dout_T_9 @[ALU.scala 51:15]
                  else :
                    node _T_8 = eq(io.op_config, UInt<4>("h8")) @[ALU.scala 53:29]
                    when _T_8 : @[ALU.scala 53:38]
                      node _T_9 = leq(io.din_1, io.din_2) @[ALU.scala 54:22]
                      when _T_9 : @[ALU.scala 54:35]
                        io.dout <= io.din_1 @[ALU.scala 55:17]
                      else :
                        node _T_10 = gt(io.din_1, io.din_2) @[ALU.scala 57:26]
                        when _T_10 : @[ALU.scala 57:38]
                          io.dout <= io.din_2 @[ALU.scala 58:17]
                    else :
                      node _T_11 = eq(io.op_config, UInt<4>("h9")) @[ALU.scala 61:29]
                      when _T_11 : @[ALU.scala 61:38]
                        node _T_12 = geq(io.din_1, io.din_2) @[ALU.scala 62:22]
                        when _T_12 : @[ALU.scala 62:35]
                          io.dout <= io.din_1 @[ALU.scala 63:17]
                        else :
                          node _T_13 = lt(io.din_1, io.din_2) @[ALU.scala 65:26]
                          when _T_13 : @[ALU.scala 65:38]
                            io.dout <= io.din_2 @[ALU.scala 66:17]
                      else :
                        io.dout <= UInt<1>("h0") @[ALU.scala 70:15]

  module FU :
    input clock : Clock
    input reset : UInt<1>
    output io : { flip din_1 : UInt<8>, flip din_2 : UInt<8>, flip din_v : UInt<1>, din_r : UInt<1>, dout : UInt<8>, dout_v : UInt<1>, flip dout_r : UInt<1>, flip loop_source : UInt<2>, flip iterations_reset : UInt<16>, flip op_config : UInt<8>}

    reg alu_din_1 : UInt<8>, clock with :
      reset => (reset, UInt<8>("h0")) @[FU.scala 33:28]
    reg alu_din_2 : UInt<8>, clock with :
      reset => (reset, UInt<8>("h0")) @[FU.scala 34:28]
    reg alu_dout : UInt<8>, clock with :
      reset => (reset, UInt<8>("h0")) @[FU.scala 35:27]
    reg dout_Reg : UInt<8>, clock with :
      reset => (reset, UInt<8>("h0")) @[FU.scala 36:27]
    reg count : UInt<16>, clock with :
      reset => (reset, UInt<16>("hffff")) @[FU.scala 40:24]
    reg loaded : UInt<1>, clock with :
      reset => (reset, UInt<1>("h0")) @[FU.scala 41:25]
    reg valid : UInt<1>, clock with :
      reset => (reset, UInt<1>("h0")) @[FU.scala 42:24]
    inst ALU of ALU @[FU.scala 44:22]
    ALU.clock <= clock
    ALU.reset <= reset
    ALU.io.din_1 <= alu_din_1 @[FU.scala 45:18]
    ALU.io.din_2 <= alu_din_2 @[FU.scala 46:18]
    alu_dout <= ALU.io.dout @[FU.scala 47:14]
    ALU.io.op_config <= io.op_config @[FU.scala 48:22]
    node _T = eq(io.loop_source, UInt<2>("h0")) @[FU.scala 51:26]
    when _T : @[FU.scala 51:39]
      alu_din_1 <= io.din_1 @[FU.scala 52:19]
      alu_din_2 <= io.din_2 @[FU.scala 53:19]
    else :
      node _T_1 = eq(io.loop_source, UInt<2>("h1")) @[FU.scala 55:31]
      when _T_1 : @[FU.scala 55:44]
        node _T_2 = eq(loaded, UInt<1>("h0")) @[FU.scala 56:22]
        when _T_2 : @[FU.scala 56:31]
          alu_din_1 <= io.din_1 @[FU.scala 57:23]
          alu_din_2 <= io.din_2 @[FU.scala 58:23]
        else :
          alu_din_1 <= dout_Reg @[FU.scala 61:23]
          alu_din_2 <= io.din_2 @[FU.scala 62:23]
      else :
        node _T_3 = eq(io.loop_source, UInt<2>("h2")) @[FU.scala 65:31]
        when _T_3 : @[FU.scala 65:44]
          node _T_4 = eq(loaded, UInt<1>("h0")) @[FU.scala 66:22]
          when _T_4 : @[FU.scala 66:31]
            alu_din_1 <= io.din_1 @[FU.scala 67:23]
            alu_din_2 <= io.din_2 @[FU.scala 68:23]
          else :
            alu_din_1 <= io.din_1 @[FU.scala 71:23]
            alu_din_2 <= dout_Reg @[FU.scala 72:23]
        else :
          alu_din_1 <= UInt<3>("h7") @[FU.scala 76:19]
          alu_din_2 <= UInt<3>("h7") @[FU.scala 77:19]
    node _T_5 = bits(reset, 0, 0) @[FU.scala 81:22]
    loaded <= UInt<1>("h0") @[FU.scala 82:16]
    count <= UInt<1>("h0") @[FU.scala 83:15]
    dout_Reg <= UInt<1>("h0") @[FU.scala 84:18]
    node _T_6 = leq(valid, UInt<1>("h0")) @[FU.scala 85:15]
    node _T_7 = eq(io.dout_r, UInt<1>("h1")) @[FU.scala 90:25]
    when _T_7 : @[FU.scala 90:34]
      valid <= UInt<1>("h0") @[FU.scala 91:19]
    node _T_8 = eq(io.din_v, UInt<1>("h1")) @[FU.scala 93:24]
    node _T_9 = eq(io.dout_r, UInt<1>("h1")) @[FU.scala 93:45]
    node _T_10 = and(_T_8, _T_9) @[FU.scala 93:32]
    node _T_11 = eq(io.loop_source, UInt<2>("h1")) @[FU.scala 94:30]
    node _T_12 = eq(io.loop_source, UInt<2>("h2")) @[FU.scala 94:60]
    node _T_13 = or(_T_11, _T_12) @[FU.scala 94:42]
    node _T_14 = and(_T_10, _T_13) @[FU.scala 93:53]
    when _T_14 : @[FU.scala 95:13]
      loaded <= UInt<1>("h1") @[FU.scala 96:20]
      node _count_T = add(count, UInt<1>("h1")) @[FU.scala 97:29]
      node _count_T_1 = tail(_count_T, 1) @[FU.scala 97:29]
      count <= _count_T_1 @[FU.scala 97:20]
    node _T_15 = eq(count, io.iterations_reset) @[FU.scala 99:21]
    node _T_16 = eq(io.loop_source, UInt<2>("h1")) @[FU.scala 100:30]
    node _T_17 = eq(io.loop_source, UInt<2>("h2")) @[FU.scala 100:60]
    node _T_18 = or(_T_16, _T_17) @[FU.scala 100:42]
    node _T_19 = and(_T_15, _T_18) @[FU.scala 99:45]
    node _T_20 = eq(io.dout_r, UInt<1>("h1")) @[FU.scala 101:25]
    node _T_21 = and(_T_19, _T_20) @[FU.scala 100:73]
    when _T_21 : @[FU.scala 102:13]
      count <= UInt<1>("h0") @[FU.scala 103:22]
      loaded <= UInt<1>("h0") @[FU.scala 104:22]
      valid <= UInt<1>("h1") @[FU.scala 105:22]
      dout_Reg <= alu_dout @[FU.scala 106:22]
    else :
      node _T_22 = eq(io.loop_source, UInt<2>("h1")) @[FU.scala 108:36]
      node _T_23 = eq(io.loop_source, UInt<2>("h2")) @[FU.scala 108:66]
      node _T_24 = or(_T_22, _T_23) @[FU.scala 108:48]
      node _T_25 = eq(io.din_v, UInt<1>("h1")) @[FU.scala 109:29]
      node _T_26 = and(_T_24, _T_25) @[FU.scala 108:79]
      node _T_27 = eq(io.dout_r, UInt<1>("h1")) @[FU.scala 110:30]
      node _T_28 = and(_T_26, _T_27) @[FU.scala 109:37]
      when _T_28 : @[FU.scala 111:13]
        dout_Reg <= alu_dout @[FU.scala 112:22]
    node _T_29 = eq(io.loop_source, UInt<2>("h0")) @[FU.scala 116:26]
    when _T_29 : @[FU.scala 116:38]
      io.dout_v <= io.din_v @[FU.scala 117:19]
    else :
      io.dout_v <= valid @[FU.scala 120:19]
    io.din_r <= io.dout_r @[FU.scala 123:14]
    node _T_30 = eq(io.loop_source, UInt<2>("h0")) @[FU.scala 125:26]
    when _T_30 : @[FU.scala 125:38]
      io.dout <= alu_dout @[FU.scala 126:17]
    else :
      io.dout <= dout_Reg @[FU.scala 129:17]

