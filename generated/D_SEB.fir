circuit D_SEB :
  module RegEnable :
    input clock : Clock
    input reset : Reset
    output io : { flip in : UInt<32>, flip en : UInt<1>, out : UInt<32>}

    reg reg : UInt, clock with :
      reset => (reset, UInt<1>("h0")) @[RegEnable.scala 21:22]
    when io.en : @[RegEnable.scala 22:17]
      reg <= io.in @[RegEnable.scala 23:13]
    io.out <= reg @[RegEnable.scala 25:12]

  module RegEnable_1 :
    input clock : Clock
    input reset : Reset
    output io : { flip in : UInt<32>, flip en : UInt<1>, out : UInt<32>}

    reg reg : UInt, clock with :
      reset => (reset, UInt<1>("h0")) @[RegEnable.scala 21:22]
    when io.en : @[RegEnable.scala 22:17]
      reg <= io.in @[RegEnable.scala 23:13]
    io.out <= reg @[RegEnable.scala 25:12]

  module RegEnable_2 :
    input clock : Clock
    input reset : Reset
    output io : { flip in : UInt<1>, flip en : UInt<1>, out : UInt<1>}

    reg reg : UInt, clock with :
      reset => (reset, UInt<1>("h0")) @[RegEnable.scala 21:22]
    when io.en : @[RegEnable.scala 22:17]
      reg <= io.in @[RegEnable.scala 23:13]
    io.out <= reg @[RegEnable.scala 25:12]

  module RegEnable_3 :
    input clock : Clock
    input reset : Reset
    output io : { flip in : UInt<1>, flip en : UInt<1>, out : UInt<1>}

    reg reg : UInt, clock with :
      reset => (reset, UInt<1>("h0")) @[RegEnable.scala 21:22]
    when io.en : @[RegEnable.scala 22:17]
      reg <= io.in @[RegEnable.scala 23:13]
    io.out <= reg @[RegEnable.scala 25:12]

  module D_SEB :
    input clock : Clock
    input reset : UInt<1>
    output io : { flip din : UInt<32>, flip din_v : UInt<1>, din_r : UInt<1>, dout : UInt<32>, dout_v : UInt<1>, flip dout_r : UInt<1>}

    inst main of RegEnable @[D_SEB.scala 24:24]
    main.clock <= clock
    main.reset <= reset
    inst aux of RegEnable_1 @[D_SEB.scala 25:23]
    aux.clock <= clock
    aux.reset <= reset
    inst reg_1 of RegEnable_2 @[D_SEB.scala 26:25]
    reg_1.clock <= clock
    reg_1.reset <= reset
    inst reg_2 of RegEnable_3 @[D_SEB.scala 27:25]
    reg_2.clock <= clock
    reg_2.reset <= reset
    reg reg : UInt<1>, clock with :
      reset => (reset, UInt<1>("h0")) @[D_SEB.scala 29:22]
    wire S_EA_EM : UInt<1> @[D_SEB.scala 30:23]
    node _mux2_out_T = bits(reg, 0, 0) @[D_SEB.scala 33:28]
    node mux2_out = mux(_mux2_out_T, reg_1.io.out, reg_2.io.out) @[D_SEB.scala 33:23]
    node _reg_T = not(mux2_out) @[D_SEB.scala 34:32]
    node _reg_T_1 = or(io.dout_r, _reg_T) @[D_SEB.scala 34:29]
    reg <= _reg_T_1 @[D_SEB.scala 34:9]
    node _S_EA_EM_T = bits(reg, 0, 0) @[D_SEB.scala 35:20]
    S_EA_EM <= _S_EA_EM_T @[D_SEB.scala 35:13]
    node _io_dout_v_T = bits(mux2_out, 0, 0) @[D_SEB.scala 36:27]
    io.dout_v <= _io_dout_v_T @[D_SEB.scala 36:15]
    io.din_r <= S_EA_EM @[D_SEB.scala 38:14]
    main.io.in <= io.din @[D_SEB.scala 40:16]
    aux.io.in <= main.io.out @[D_SEB.scala 41:15]
    reg_1.io.in <= io.din_v @[D_SEB.scala 42:17]
    reg_2.io.in <= reg_1.io.out @[D_SEB.scala 43:17]
    main.io.en <= S_EA_EM @[D_SEB.scala 45:16]
    aux.io.en <= S_EA_EM @[D_SEB.scala 46:15]
    reg_1.io.en <= S_EA_EM @[D_SEB.scala 47:17]
    reg_2.io.en <= S_EA_EM @[D_SEB.scala 48:17]
    node _io_dout_T = mux(S_EA_EM, main.io.out, aux.io.out) @[D_SEB.scala 50:19]
    io.dout <= _io_dout_T @[D_SEB.scala 50:13]

