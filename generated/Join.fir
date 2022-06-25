circuit Join :
  module Join :
    input clock : Clock
    input reset : UInt<1>
    output io : { flip d_in_1 : UInt<8>, flip d_in_2 : UInt<8>, a_in_1 : UInt<1>, a_in_2 : UInt<1>, d_out_1 : UInt<8>, d_out_2 : UInt<8>, flip v_in_1 : UInt<1>, flip v_in_2 : UInt<1>, v_out : UInt<1>, flip a_out : UInt<1>}

    io.d_out_1 <= io.d_in_1 @[Join.scala 20:16]
    io.d_out_2 <= io.d_in_2 @[Join.scala 21:16]
    node _io_v_out_T = and(io.v_in_1, io.v_in_2) @[Join.scala 23:27]
    io.v_out <= _io_v_out_T @[Join.scala 23:14]
    node _io_a_in_1_T = and(io.v_in_2, io.a_out) @[Join.scala 25:28]
    io.a_in_1 <= _io_a_in_1_T @[Join.scala 25:15]
    node _io_a_in_2_T = and(io.v_in_1, io.a_out) @[Join.scala 26:28]
    io.a_in_2 <= _io_a_in_2_T @[Join.scala 26:15]

