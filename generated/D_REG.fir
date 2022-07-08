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
    output io : { flip din : UInt<8>, flip din_v : UInt<1>, flip dout_r : UInt<1>, dout : UInt<8>, dout_v : UInt<1>, din_r : UInt<1>}

    inst reg_1 of RegEnable @[D_REG.scala 19:25]
    reg_1.clock <= clock
    reg_1.reset <= reset
    inst reg_2 of RegEnable_1 @[D_REG.scala 20:25]
    reg_2.clock <= clock
    reg_2.reset <= reset
    reg_1.io.in <= io.din @[D_REG.scala 22:17]
    reg_2.io.in <= io.din_v @[D_REG.scala 23:17]
    reg_1.io.en <= io.dout_r @[D_REG.scala 24:17]
    reg_2.io.en <= io.dout_r @[D_REG.scala 25:17]
    io.dout <= reg_1.io.out @[D_REG.scala 26:13]
    io.dout_v <= reg_2.io.out @[D_REG.scala 27:15]
    io.din_r <= io.dout_r @[D_REG.scala 28:14]

