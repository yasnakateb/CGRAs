circuit ALU :
  module ALU :
    input clock : Clock
    input reset : UInt<1>
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

