circuit ALU :
  module ALU :
    input clock : Clock
    input reset : UInt<1>
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

