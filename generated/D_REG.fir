circuit D_REG :
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
    output io : { flip in : UInt<1>, flip en : UInt<1>, out : UInt<1>}

    reg reg : UInt, clock with :
      reset => (reset, UInt<1>("h0")) @[RegEnable.scala 11:22]
    when io.en : @[RegEnable.scala 12:17]
      reg <= io.in @[RegEnable.scala 13:13]
    io.out <= reg @[RegEnable.scala 15:12]

  module D_REG :
    input clock : Clock
    input reset : UInt<1>
    output io : { flip d_p : UInt<8>, flip v_p : UInt<1>, flip a_n : UInt<1>, d_n : UInt<8>, v_n : UInt<1>, a_p : UInt<1>}

    inst reg_1 of RegEnable @[D_REG.scala 19:25]
    reg_1.clock <= clock
    reg_1.reset <= reset
    inst reg_2 of RegEnable_1 @[D_REG.scala 20:25]
    reg_2.clock <= clock
    reg_2.reset <= reset
    reg_1.io.in <= io.d_p @[D_REG.scala 22:17]
    reg_2.io.in <= io.v_p @[D_REG.scala 23:17]
    reg_1.io.en <= io.a_n @[D_REG.scala 24:17]
    reg_2.io.en <= io.a_n @[D_REG.scala 25:17]
    io.d_n <= reg_1.io.out @[D_REG.scala 26:12]
    io.v_n <= reg_2.io.out @[D_REG.scala 27:12]
    io.a_p <= io.a_n @[D_REG.scala 28:12]

