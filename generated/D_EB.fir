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

    inst main of RegEnable @[D_EB.scala 19:24]
    main.clock <= clock
    main.reset <= reset
    inst aux of RegEnable_1 @[D_EB.scala 20:23]
    aux.clock <= clock
    aux.reset <= reset
    inst reg_1 of RegEnable_2 @[D_EB.scala 21:25]
    reg_1.clock <= clock
    reg_1.reset <= reset
    inst reg_2 of RegEnable_3 @[D_EB.scala 22:25]
    reg_2.clock <= clock
    reg_2.reset <= reset
    reg reg : UInt<1>, clock with :
      reset => (reset, UInt<1>("h0")) @[D_EB.scala 24:22]
    wire S_EA : UInt<1> @[D_EB.scala 25:20]
    wire EM : UInt<1> @[D_EB.scala 26:18]
    node _mux2_out_T = bits(reg, 0, 0) @[D_EB.scala 28:28]
    node mux2_out = mux(_mux2_out_T, reg_1.io.out, reg_2.io.out) @[D_EB.scala 28:23]
    node _reg_T = not(mux2_out) @[D_EB.scala 29:29]
    node _reg_T_1 = or(io.a_n, _reg_T) @[D_EB.scala 29:26]
    reg <= _reg_T_1 @[D_EB.scala 29:9]
    node _S_EA_T = bits(reg, 0, 0) @[D_EB.scala 30:17]
    S_EA <= _S_EA_T @[D_EB.scala 30:10]
    node _io_v_n_T = bits(mux2_out, 0, 0) @[D_EB.scala 31:24]
    io.v_n <= _io_v_n_T @[D_EB.scala 31:12]
    node _io_a_p_T = not(io.v_p) @[D_EB.scala 34:23]
    node _io_a_p_T_1 = or(S_EA, _io_a_p_T) @[D_EB.scala 34:20]
    io.a_p <= _io_a_p_T_1 @[D_EB.scala 34:12]
    EM <= io.a_p @[D_EB.scala 35:8]
    main.io.in <= io.d_p @[D_EB.scala 38:16]
    aux.io.in <= main.io.out @[D_EB.scala 39:15]
    reg_1.io.in <= io.v_p @[D_EB.scala 40:17]
    reg_2.io.in <= reg_1.io.out @[D_EB.scala 41:17]
    main.io.en <= EM @[D_EB.scala 43:16]
    aux.io.en <= S_EA @[D_EB.scala 44:15]
    reg_1.io.en <= EM @[D_EB.scala 45:17]
    reg_2.io.en <= S_EA @[D_EB.scala 46:17]
    node _io_d_n_T = mux(S_EA, main.io.out, aux.io.out) @[D_EB.scala 48:18]
    io.d_n <= _io_d_n_T @[D_EB.scala 48:12]

