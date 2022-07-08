circuit Join :
  module Join :
    input clock : Clock
    input reset : UInt<1>
    output io : { flip din_1 : UInt<8>, flip din_2 : UInt<8>, din_1_r : UInt<1>, din_2_r : UInt<1>, dout_1 : UInt<8>, dout_2 : UInt<8>, flip din_1_v : UInt<1>, flip din_2_v : UInt<1>, dout_v : UInt<1>, flip dout_r : UInt<1>}

    io.dout_1 <= io.din_1 @[Join.scala 20:15]
    io.dout_2 <= io.din_2 @[Join.scala 21:15]
    node _io_dout_v_T = and(io.din_1_v, io.din_2_v) @[Join.scala 23:29]
    io.dout_v <= _io_dout_v_T @[Join.scala 23:15]
    node _io_din_1_r_T = and(io.din_2_v, io.dout_r) @[Join.scala 25:30]
    io.din_1_r <= _io_din_1_r_T @[Join.scala 25:16]
    node _io_din_2_r_T = and(io.din_1_v, io.dout_r) @[Join.scala 26:30]
    io.din_2_r <= _io_din_2_r_T @[Join.scala 26:16]

