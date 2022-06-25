circuit FU :
  module ALU :
    input clock : Clock
    input reset : Reset
    output io : { flip d_in_1 : UInt<8>, flip d_in_2 : UInt<8>, flip op_config : UInt<8>, d_out : UInt<8>}

    io.d_out <= UInt<1>("h0") @[ALU.scala 28:14]
    node _T = eq(io.op_config, UInt<1>("h0")) @[ALU.scala 29:24]
    when _T : @[ALU.scala 29:33]
      node _io_d_out_T = add(io.d_in_1, io.d_in_2) @[ALU.scala 30:29]
      node _io_d_out_T_1 = tail(_io_d_out_T, 1) @[ALU.scala 30:29]
      io.d_out <= _io_d_out_T_1 @[ALU.scala 30:16]
    else :
      node _T_1 = eq(io.op_config, UInt<1>("h1")) @[ALU.scala 32:29]
      when _T_1 : @[ALU.scala 32:38]
        node _io_d_out_T_2 = mul(io.d_in_1, io.d_in_2) @[ALU.scala 33:29]
        io.d_out <= _io_d_out_T_2 @[ALU.scala 33:16]
      else :
        node _T_2 = eq(io.op_config, UInt<2>("h2")) @[ALU.scala 35:29]
        when _T_2 : @[ALU.scala 35:38]
          node _io_d_out_T_3 = sub(io.d_in_1, io.d_in_2) @[ALU.scala 36:29]
          node _io_d_out_T_4 = tail(_io_d_out_T_3, 1) @[ALU.scala 36:29]
          io.d_out <= _io_d_out_T_4 @[ALU.scala 36:16]
        else :
          node _T_3 = eq(io.op_config, UInt<2>("h3")) @[ALU.scala 38:29]
          when _T_3 : @[ALU.scala 38:38]
            node _io_d_out_T_5 = dshl(io.d_in_1, io.d_in_2) @[ALU.scala 39:29]
            io.d_out <= _io_d_out_T_5 @[ALU.scala 39:16]
          else :
            node _T_4 = eq(io.op_config, UInt<3>("h4")) @[ALU.scala 41:29]
            when _T_4 : @[ALU.scala 41:38]
              node _io_d_out_T_6 = dshr(io.d_in_1, io.d_in_2) @[ALU.scala 42:29]
              io.d_out <= _io_d_out_T_6 @[ALU.scala 42:16]
            else :
              node _T_5 = eq(io.op_config, UInt<3>("h5")) @[ALU.scala 44:29]
              when _T_5 : @[ALU.scala 44:38]
                node _io_d_out_T_7 = and(io.d_in_1, io.d_in_2) @[ALU.scala 45:29]
                io.d_out <= _io_d_out_T_7 @[ALU.scala 45:16]
              else :
                node _T_6 = eq(io.op_config, UInt<3>("h6")) @[ALU.scala 47:29]
                when _T_6 : @[ALU.scala 47:37]
                  node _io_d_out_T_8 = or(io.d_in_1, io.d_in_2) @[ALU.scala 48:29]
                  io.d_out <= _io_d_out_T_8 @[ALU.scala 48:16]
                else :
                  node _T_7 = eq(io.op_config, UInt<3>("h7")) @[ALU.scala 50:29]
                  when _T_7 : @[ALU.scala 50:38]
                    node _io_d_out_T_9 = xor(io.d_in_1, io.d_in_2) @[ALU.scala 51:29]
                    io.d_out <= _io_d_out_T_9 @[ALU.scala 51:16]
                  else :
                    node _T_8 = eq(io.op_config, UInt<4>("h8")) @[ALU.scala 53:29]
                    when _T_8 : @[ALU.scala 53:38]
                      node _T_9 = leq(io.d_in_1, io.d_in_2) @[ALU.scala 54:23]
                      when _T_9 : @[ALU.scala 54:37]
                        io.d_out <= io.d_in_1 @[ALU.scala 55:18]
                      else :
                        node _T_10 = gt(io.d_in_1, io.d_in_2) @[ALU.scala 57:27]
                        when _T_10 : @[ALU.scala 57:40]
                          io.d_out <= io.d_in_2 @[ALU.scala 58:18]
                    else :
                      node _T_11 = eq(io.op_config, UInt<4>("h9")) @[ALU.scala 61:29]
                      when _T_11 : @[ALU.scala 61:38]
                        node _T_12 = geq(io.d_in_1, io.d_in_2) @[ALU.scala 62:23]
                        when _T_12 : @[ALU.scala 62:37]
                          io.d_out <= io.d_in_1 @[ALU.scala 63:18]
                        else :
                          node _T_13 = lt(io.d_in_1, io.d_in_2) @[ALU.scala 65:27]
                          when _T_13 : @[ALU.scala 65:40]
                            io.d_out <= io.d_in_2 @[ALU.scala 66:18]
                      else :
                        io.d_out <= UInt<1>("h0") @[ALU.scala 70:16]

  module FU :
    input clock : Clock
    input reset : UInt<1>
    output io : { flip d_in_1 : UInt<8>, flip d_in_2 : UInt<8>, flip v_in : UInt<1>, r_in : UInt<1>, d_out : UInt<8>, v_out : UInt<1>, flip r_out : UInt<1>, flip loop_source : UInt<2>, flip iterations_reset : UInt<16>, flip op_config : UInt<8>}

    reg alu_d_in_1 : UInt<8>, clock with :
      reset => (reset, UInt<8>("h0")) @[FU.scala 33:29]
    reg alu_d_in_2 : UInt<8>, clock with :
      reset => (reset, UInt<8>("h0")) @[FU.scala 34:29]
    reg alu_d_out : UInt<8>, clock with :
      reset => (reset, UInt<8>("h0")) @[FU.scala 35:28]
    reg d_out_Reg : UInt<8>, clock with :
      reset => (reset, UInt<8>("h0")) @[FU.scala 36:28]
    reg count : UInt<16>, clock with :
      reset => (reset, UInt<16>("hffff")) @[FU.scala 40:24]
    reg loaded : UInt<1>, clock with :
      reset => (reset, UInt<1>("h0")) @[FU.scala 41:25]
    reg valid : UInt<1>, clock with :
      reset => (reset, UInt<1>("h0")) @[FU.scala 42:24]
    inst ALU of ALU @[FU.scala 44:22]
    ALU.clock <= clock
    ALU.reset <= reset
    ALU.io.d_in_1 <= alu_d_in_1 @[FU.scala 45:19]
    ALU.io.d_in_2 <= alu_d_in_2 @[FU.scala 46:19]
    alu_d_out <= ALU.io.d_out @[FU.scala 47:15]
    ALU.io.op_config <= io.op_config @[FU.scala 48:22]
    node _T = eq(io.loop_source, UInt<2>("h0")) @[FU.scala 51:26]
    when _T : @[FU.scala 51:39]
      alu_d_in_1 <= io.d_in_1 @[FU.scala 52:20]
      alu_d_in_2 <= io.d_in_2 @[FU.scala 53:20]
    else :
      node _T_1 = eq(io.loop_source, UInt<2>("h1")) @[FU.scala 55:31]
      when _T_1 : @[FU.scala 55:44]
        node _T_2 = eq(loaded, UInt<1>("h0")) @[FU.scala 56:22]
        when _T_2 : @[FU.scala 56:31]
          alu_d_in_1 <= io.d_in_1 @[FU.scala 57:24]
          alu_d_in_2 <= io.d_in_2 @[FU.scala 58:24]
        else :
          alu_d_in_1 <= d_out_Reg @[FU.scala 61:24]
          alu_d_in_2 <= io.d_in_2 @[FU.scala 62:24]
      else :
        node _T_3 = eq(io.loop_source, UInt<2>("h2")) @[FU.scala 65:31]
        when _T_3 : @[FU.scala 65:44]
          node _T_4 = eq(loaded, UInt<1>("h0")) @[FU.scala 66:22]
          when _T_4 : @[FU.scala 66:31]
            alu_d_in_1 <= io.d_in_1 @[FU.scala 67:24]
            alu_d_in_2 <= io.d_in_2 @[FU.scala 68:24]
          else :
            alu_d_in_1 <= io.d_in_1 @[FU.scala 71:24]
            alu_d_in_2 <= d_out_Reg @[FU.scala 72:24]
        else :
          alu_d_in_1 <= UInt<3>("h7") @[FU.scala 76:20]
          alu_d_in_2 <= UInt<3>("h7") @[FU.scala 77:20]
    node _T_5 = bits(reset, 0, 0) @[FU.scala 81:22]
    loaded <= UInt<1>("h0") @[FU.scala 82:16]
    count <= UInt<1>("h0") @[FU.scala 83:15]
    d_out_Reg <= UInt<1>("h0") @[FU.scala 84:19]
    node _T_6 = leq(valid, UInt<1>("h0")) @[FU.scala 85:15]
    node _T_7 = eq(io.r_out, UInt<1>("h1")) @[FU.scala 90:24]
    when _T_7 : @[FU.scala 90:33]
      valid <= UInt<1>("h0") @[FU.scala 91:19]
    node _T_8 = eq(io.v_in, UInt<1>("h1")) @[FU.scala 93:23]
    node _T_9 = eq(io.r_out, UInt<1>("h1")) @[FU.scala 93:43]
    node _T_10 = and(_T_8, _T_9) @[FU.scala 93:31]
    node _T_11 = eq(io.loop_source, UInt<2>("h1")) @[FU.scala 94:30]
    node _T_12 = eq(io.loop_source, UInt<2>("h2")) @[FU.scala 94:60]
    node _T_13 = or(_T_11, _T_12) @[FU.scala 94:42]
    node _T_14 = and(_T_10, _T_13) @[FU.scala 93:51]
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
    node _T_20 = eq(io.r_out, UInt<1>("h1")) @[FU.scala 101:24]
    node _T_21 = and(_T_19, _T_20) @[FU.scala 100:73]
    when _T_21 : @[FU.scala 102:13]
      count <= UInt<1>("h0") @[FU.scala 103:22]
      loaded <= UInt<1>("h0") @[FU.scala 104:22]
      valid <= UInt<1>("h1") @[FU.scala 105:22]
      d_out_Reg <= alu_d_out @[FU.scala 106:23]
    else :
      node _T_22 = eq(io.loop_source, UInt<2>("h1")) @[FU.scala 108:36]
      node _T_23 = eq(io.loop_source, UInt<2>("h2")) @[FU.scala 108:66]
      node _T_24 = or(_T_22, _T_23) @[FU.scala 108:48]
      node _T_25 = eq(io.v_in, UInt<1>("h1")) @[FU.scala 109:28]
      node _T_26 = and(_T_24, _T_25) @[FU.scala 108:79]
      node _T_27 = eq(io.r_out, UInt<1>("h1")) @[FU.scala 110:29]
      node _T_28 = and(_T_26, _T_27) @[FU.scala 109:36]
      when _T_28 : @[FU.scala 111:13]
        d_out_Reg <= alu_d_out @[FU.scala 112:23]
    node _T_29 = eq(io.loop_source, UInt<2>("h0")) @[FU.scala 116:26]
    when _T_29 : @[FU.scala 116:38]
      io.v_out <= io.v_in @[FU.scala 117:18]
    else :
      io.v_out <= valid @[FU.scala 120:18]
    io.r_in <= io.r_out @[FU.scala 123:13]
    node _T_30 = eq(io.loop_source, UInt<2>("h0")) @[FU.scala 125:26]
    when _T_30 : @[FU.scala 125:38]
      io.d_out <= alu_d_out @[FU.scala 126:18]
    else :
      io.d_out <= d_out_Reg @[FU.scala 129:18]

