circuit D_BUF :
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

  module D_BUF :
    input clock : Clock
    input reset : UInt<1>
    output io : { flip d_p : UInt<8>, flip v_p : UInt<1>, flip a_n : UInt<1>, d_n : UInt<8>, v_n : UInt<1>, a_p : UInt<1>}

    inst reg_1 of RegEnable @[D_BUF.scala 14:25]
    reg_1.clock <= clock
    reg_1.reset <= reset
    inst reg_2 of RegEnable_1 @[D_BUF.scala 15:25]
    reg_2.clock <= clock
    reg_2.reset <= reset
    inst reg_3 of RegEnable_2 @[D_BUF.scala 16:25]
    reg_3.clock <= clock
    reg_3.reset <= reset
    inst reg_4 of RegEnable_3 @[D_BUF.scala 17:25]
    reg_4.clock <= clock
    reg_4.reset <= reset
    reg reg : UInt<1>, clock with :
      reset => (reset, UInt<1>("h0")) @[D_BUF.scala 19:22]
    wire areg : UInt<1> @[D_BUF.scala 20:20]
    reg <= io.a_n @[D_BUF.scala 21:9]
    node _areg_T = bits(reg, 0, 0) @[D_BUF.scala 22:17]
    areg <= _areg_T @[D_BUF.scala 22:10]
    reg_1.io.in <= io.d_p @[D_BUF.scala 24:17]
    reg_3.io.in <= io.v_p @[D_BUF.scala 25:17]
    io.a_p <= areg @[D_BUF.scala 26:12]
    reg_1.io.en <= areg @[D_BUF.scala 28:17]
    reg_2.io.en <= io.a_n @[D_BUF.scala 29:17]
    reg_3.io.en <= areg @[D_BUF.scala 30:17]
    reg_4.io.en <= io.a_n @[D_BUF.scala 31:17]
    node mux1_out = mux(areg, reg_1.io.out, io.d_p) @[D_BUF.scala 33:23]
    io.d_n <= mux1_out @[D_BUF.scala 34:12]
    reg_2.io.in <= mux1_out @[D_BUF.scala 35:17]
    node mux2_out = mux(areg, reg_3.io.out, io.v_p) @[D_BUF.scala 37:23]
    reg_4.io.in <= mux2_out @[D_BUF.scala 38:17]
    io.v_n <= reg_4.io.out @[D_BUF.scala 39:12]

