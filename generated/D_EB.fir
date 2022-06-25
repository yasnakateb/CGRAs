circuit D_EB :
  module RegEnable :
    input clock : Clock
    input reset : Reset
    output io : { flip in : UInt<8>, flip en : UInt<1>, out : UInt<8>}

    reg reg : UInt, clock with :
      reset => (reset, UInt<1>("h0")) @[RegEnable.scala 11:22]
    when io.en : @[RegEnable.scala 12:17]
      reg <= io.in @[RegEnable.scala 13:13]
    io.out <= reg @[RegEnable.scala 15:12]

  module RegEnable_1 :
    input clock : Clock
    input reset : Reset
    output io : { flip in : UInt<8>, flip en : UInt<1>, out : UInt<8>}

    reg reg : UInt, clock with :
      reset => (reset, UInt<1>("h0")) @[RegEnable.scala 11:22]
    when io.en : @[RegEnable.scala 12:17]
      reg <= io.in @[RegEnable.scala 13:13]
    io.out <= reg @[RegEnable.scala 15:12]

  module RegEnable_2 :
    input clock : Clock
    input reset : Reset
    output io : { flip in : UInt<1>, flip en : UInt<1>, out : UInt<1>}

    reg reg : UInt, clock with :
      reset => (reset, UInt<1>("h0")) @[RegEnable.scala 11:22]
    when io.en : @[RegEnable.scala 12:17]
      reg <= io.in @[RegEnable.scala 13:13]
    io.out <= reg @[RegEnable.scala 15:12]

  module RegEnable_3 :
    input clock : Clock
    input reset : Reset
    output io : { flip in : UInt<1>, flip en : UInt<1>, out : UInt<1>}

    reg reg : UInt, clock with :
      reset => (reset, UInt<1>("h0")) @[RegEnable.scala 11:22]
    when io.en : @[RegEnable.scala 12:17]
      reg <= io.in @[RegEnable.scala 13:13]
    io.out <= reg @[RegEnable.scala 15:12]

  module D_EB :
    input clock : Clock
    input reset : UInt<1>
    output io : { flip d_p : UInt<8>, flip v_p : UInt<1>, flip a_n : UInt<1>, d_n : UInt<8>, v_n : UInt<1>, a_p : UInt<1>}

    inst reg_1 of RegEnable @[D_EB.scala 19:25]
    reg_1.clock <= clock
    reg_1.reset <= reset
    inst reg_2 of RegEnable_1 @[D_EB.scala 20:25]
    reg_2.clock <= clock
    reg_2.reset <= reset
    inst reg_3 of RegEnable_2 @[D_EB.scala 21:25]
    reg_3.clock <= clock
    reg_3.reset <= reset
    inst reg_4 of RegEnable_3 @[D_EB.scala 22:25]
    reg_4.clock <= clock
    reg_4.reset <= reset
    reg reg : UInt<1>, clock with :
      reset => (reset, UInt<1>("h0")) @[D_EB.scala 24:22]
    wire areg : UInt<1> @[D_EB.scala 26:20]
    node _areg_T = bits(reg, 0, 0) @[D_EB.scala 27:17]
    areg <= _areg_T @[D_EB.scala 27:10]
    node mux2_out = mux(areg, reg_4.io.out, reg_3.io.out) @[D_EB.scala 28:23]
    node _reg_T = not(mux2_out) @[D_EB.scala 29:29]
    node _reg_T_1 = and(io.a_n, _reg_T) @[D_EB.scala 29:26]
    reg <= _reg_T_1 @[D_EB.scala 29:9]
    node _io_v_n_T = bits(mux2_out, 0, 0) @[D_EB.scala 31:24]
    io.v_n <= _io_v_n_T @[D_EB.scala 31:12]
    io.a_p <= areg @[D_EB.scala 32:12]
    reg_1.io.in <= io.d_p @[D_EB.scala 34:17]
    reg_2.io.in <= reg_1.io.out @[D_EB.scala 35:17]
    reg_3.io.in <= io.v_p @[D_EB.scala 36:17]
    reg_4.io.in <= reg_3.io.out @[D_EB.scala 37:17]
    reg_1.io.en <= areg @[D_EB.scala 39:17]
    reg_2.io.en <= areg @[D_EB.scala 40:17]
    reg_3.io.en <= areg @[D_EB.scala 41:17]
    reg_4.io.en <= areg @[D_EB.scala 42:17]
    node _io_d_n_T = mux(areg, reg_2.io.out, reg_1.io.out) @[D_EB.scala 44:18]
    io.d_n <= _io_d_n_T @[D_EB.scala 44:12]

