circuit ProcessingElement :
  module D_FIFO :
    input clock : Clock
    input reset : Reset
    output io : { flip din : UInt<32>, flip din_v : UInt<1>, flip dout_r : UInt<1>, din_r : UInt<1>, dout : UInt<32>, dout_v : UInt<1>}

    smem memory : UInt<32> [32] @[D_FIFO.scala 17:29]
    reg write_pointer : UInt<32>, clock with :
      reset => (reset, UInt<32>("h0")) @[D_FIFO.scala 19:36]
    reg read_pointer : UInt<32>, clock with :
      reset => (reset, UInt<32>("h0")) @[D_FIFO.scala 20:31]
    reg num_data : UInt<32>, clock with :
      reset => (reset, UInt<32>("h0")) @[D_FIFO.scala 21:27]
    wire full : UInt<1> @[D_FIFO.scala 24:20]
    wire empty : UInt<1> @[D_FIFO.scala 25:21]
    wire rd_en : UInt<1> @[D_FIFO.scala 26:21]
    wire wr_en : UInt<1> @[D_FIFO.scala 27:21]
    empty <= UInt<1>("h1") @[D_FIFO.scala 29:11]
    full <= UInt<1>("h0") @[D_FIFO.scala 30:14]
    write_pointer <= UInt<1>("h0") @[D_FIFO.scala 31:23]
    read_pointer <= UInt<1>("h0") @[D_FIFO.scala 32:18]
    num_data <= UInt<1>("h0") @[D_FIFO.scala 33:18]
    io.dout <= UInt<1>("h0") @[D_FIFO.scala 34:13]
    io.dout_v <= UInt<1>("h0") @[D_FIFO.scala 35:19]
    when io.dout_r : @[D_FIFO.scala 37:22]
      io.dout_v <= UInt<1>("h0") @[D_FIFO.scala 38:19]
    node _T = eq(full, UInt<1>("h0")) @[D_FIFO.scala 41:16]
    node _T_1 = eq(wr_en, UInt<1>("h1")) @[D_FIFO.scala 41:38]
    node _T_2 = and(_T, _T_1) @[D_FIFO.scala 41:29]
    when _T_2 : @[D_FIFO.scala 41:50]
      node _T_3 = bits(write_pointer, 4, 0) @[D_FIFO.scala 42:15]
      infer mport MPORT = memory[_T_3], clock @[D_FIFO.scala 42:15]
      MPORT <= io.din @[D_FIFO.scala 42:31]
      node _num_data_T = add(num_data, UInt<1>("h1")) @[D_FIFO.scala 43:30]
      node _num_data_T_1 = tail(_num_data_T, 1) @[D_FIFO.scala 43:30]
      num_data <= _num_data_T_1 @[D_FIFO.scala 43:18]
      node _T_4 = sub(UInt<6>("h20"), UInt<1>("h1")) @[D_FIFO.scala 45:46]
      node _T_5 = tail(_T_4, 1) @[D_FIFO.scala 45:46]
      node _T_6 = eq(write_pointer, _T_5) @[D_FIFO.scala 45:29]
      when _T_6 : @[D_FIFO.scala 45:54]
        write_pointer <= UInt<1>("h0") @[D_FIFO.scala 46:27]
      else :
        node _write_pointer_T = add(write_pointer, UInt<1>("h1")) @[D_FIFO.scala 48:44]
        node _write_pointer_T_1 = tail(_write_pointer_T, 1) @[D_FIFO.scala 48:44]
        write_pointer <= _write_pointer_T_1 @[D_FIFO.scala 48:27]
    node _T_7 = eq(empty, UInt<1>("h0")) @[D_FIFO.scala 52:17]
    node _T_8 = eq(rd_en, UInt<1>("h1")) @[D_FIFO.scala 52:39]
    node _T_9 = and(_T_7, _T_8) @[D_FIFO.scala 52:30]
    when _T_9 : @[D_FIFO.scala 52:51]
      node _io_dout_T = bits(read_pointer, 4, 0) @[D_FIFO.scala 53:26]
      infer mport io_dout_MPORT = memory[_io_dout_T], clock @[D_FIFO.scala 53:26]
      io.dout <= io_dout_MPORT @[D_FIFO.scala 53:17]
      io.dout_v <= UInt<1>("h1") @[D_FIFO.scala 54:19]
      node _num_data_T_2 = sub(num_data, UInt<1>("h1")) @[D_FIFO.scala 55:30]
      node _num_data_T_3 = tail(_num_data_T_2, 1) @[D_FIFO.scala 55:30]
      num_data <= _num_data_T_3 @[D_FIFO.scala 55:18]
      node _T_10 = sub(UInt<6>("h20"), UInt<1>("h1")) @[D_FIFO.scala 57:45]
      node _T_11 = tail(_T_10, 1) @[D_FIFO.scala 57:45]
      node _T_12 = eq(read_pointer, _T_11) @[D_FIFO.scala 57:28]
      when _T_12 : @[D_FIFO.scala 57:53]
        read_pointer <= UInt<1>("h0") @[D_FIFO.scala 58:26]
      else :
        node _read_pointer_T = add(read_pointer, UInt<1>("h1")) @[D_FIFO.scala 60:42]
        node _read_pointer_T_1 = tail(_read_pointer_T, 1) @[D_FIFO.scala 60:42]
        read_pointer <= _read_pointer_T_1 @[D_FIFO.scala 60:26]
    node _T_13 = eq(num_data, UInt<6>("h20")) @[D_FIFO.scala 64:20]
    when _T_13 : @[D_FIFO.scala 64:39]
      full <= UInt<1>("h1") @[D_FIFO.scala 65:14]
    else :
      full <= UInt<1>("h0") @[D_FIFO.scala 67:14]
    node _T_14 = eq(num_data, UInt<1>("h0")) @[D_FIFO.scala 70:20]
    when _T_14 : @[D_FIFO.scala 70:30]
      empty <= UInt<1>("h1") @[D_FIFO.scala 71:15]
    else :
      empty <= UInt<1>("h0") @[D_FIFO.scala 73:15]
    node _wr_en_T = not(full) @[D_FIFO.scala 76:26]
    node _wr_en_T_1 = and(io.din_v, _wr_en_T) @[D_FIFO.scala 76:23]
    wr_en <= _wr_en_T_1 @[D_FIFO.scala 76:11]
    node _rd_en_T = not(empty) @[D_FIFO.scala 77:31]
    node _rd_en_T_1 = and(io.dout_r, _rd_en_T) @[D_FIFO.scala 77:28]
    rd_en <= _rd_en_T_1 @[D_FIFO.scala 77:15]
    node _io_din_r_T = not(full) @[D_FIFO.scala 78:22]
    io.din_r <= _io_din_r_T @[D_FIFO.scala 78:18]

  module FS :
    input clock : Clock
    input reset : Reset
    output io : { flip ready_out : UInt<5>, flip fork_mask : UInt<5>, ready_in : UInt<1>}

    wire aux : UInt<1>[5] @[FS.scala 20:19]
    wire temp : UInt<1>[5] @[FS.scala 21:20]
    node _aux_0_T = bits(io.fork_mask, 0, 0) @[FS.scala 24:34]
    node _aux_0_T_1 = not(_aux_0_T) @[FS.scala 24:21]
    node _aux_0_T_2 = bits(io.ready_out, 0, 0) @[FS.scala 24:53]
    node _aux_0_T_3 = or(_aux_0_T_1, _aux_0_T_2) @[FS.scala 24:39]
    node _aux_0_T_4 = bits(_aux_0_T_3, 0, 0) @[FS.scala 24:58]
    aux[0] <= _aux_0_T_4 @[FS.scala 24:16]
    node _aux_1_T = bits(io.fork_mask, 1, 1) @[FS.scala 24:34]
    node _aux_1_T_1 = not(_aux_1_T) @[FS.scala 24:21]
    node _aux_1_T_2 = bits(io.ready_out, 1, 1) @[FS.scala 24:53]
    node _aux_1_T_3 = or(_aux_1_T_1, _aux_1_T_2) @[FS.scala 24:39]
    node _aux_1_T_4 = bits(_aux_1_T_3, 0, 0) @[FS.scala 24:58]
    aux[1] <= _aux_1_T_4 @[FS.scala 24:16]
    node _aux_2_T = bits(io.fork_mask, 2, 2) @[FS.scala 24:34]
    node _aux_2_T_1 = not(_aux_2_T) @[FS.scala 24:21]
    node _aux_2_T_2 = bits(io.ready_out, 2, 2) @[FS.scala 24:53]
    node _aux_2_T_3 = or(_aux_2_T_1, _aux_2_T_2) @[FS.scala 24:39]
    node _aux_2_T_4 = bits(_aux_2_T_3, 0, 0) @[FS.scala 24:58]
    aux[2] <= _aux_2_T_4 @[FS.scala 24:16]
    node _aux_3_T = bits(io.fork_mask, 3, 3) @[FS.scala 24:34]
    node _aux_3_T_1 = not(_aux_3_T) @[FS.scala 24:21]
    node _aux_3_T_2 = bits(io.ready_out, 3, 3) @[FS.scala 24:53]
    node _aux_3_T_3 = or(_aux_3_T_1, _aux_3_T_2) @[FS.scala 24:39]
    node _aux_3_T_4 = bits(_aux_3_T_3, 0, 0) @[FS.scala 24:58]
    aux[3] <= _aux_3_T_4 @[FS.scala 24:16]
    node _aux_4_T = bits(io.fork_mask, 4, 4) @[FS.scala 24:34]
    node _aux_4_T_1 = not(_aux_4_T) @[FS.scala 24:21]
    node _aux_4_T_2 = bits(io.ready_out, 4, 4) @[FS.scala 24:53]
    node _aux_4_T_3 = or(_aux_4_T_1, _aux_4_T_2) @[FS.scala 24:39]
    node _aux_4_T_4 = bits(_aux_4_T_3, 0, 0) @[FS.scala 24:58]
    aux[4] <= _aux_4_T_4 @[FS.scala 24:16]
    temp[0] <= aux[0] @[FS.scala 27:13]
    node _temp_1_T = and(temp[0], aux[1]) @[FS.scala 30:30]
    temp[1] <= _temp_1_T @[FS.scala 30:17]
    node _temp_2_T = and(temp[1], aux[2]) @[FS.scala 30:30]
    temp[2] <= _temp_2_T @[FS.scala 30:17]
    node _temp_3_T = and(temp[2], aux[3]) @[FS.scala 30:30]
    temp[3] <= _temp_3_T @[FS.scala 30:17]
    node _temp_4_T = and(temp[3], aux[4]) @[FS.scala 30:30]
    temp[4] <= _temp_4_T @[FS.scala 30:17]
    io.ready_in <= temp[4] @[FS.scala 33:17]

  module ConfMux :
    input clock : Clock
    input reset : Reset
    output io : { flip selector : UInt<2>, flip mux_input : UInt<128>, mux_output : UInt<32>}

    wire inputs : UInt<32>[4] @[ConfMux.scala 25:22]
    node _inputs_0_T = bits(io.mux_input, 31, 0) @[ConfMux.scala 27:34]
    inputs[0] <= _inputs_0_T @[ConfMux.scala 27:19]
    node _inputs_1_T = bits(io.mux_input, 63, 32) @[ConfMux.scala 27:34]
    inputs[1] <= _inputs_1_T @[ConfMux.scala 27:19]
    node _inputs_2_T = bits(io.mux_input, 95, 64) @[ConfMux.scala 27:34]
    inputs[2] <= _inputs_2_T @[ConfMux.scala 27:19]
    node _inputs_3_T = bits(io.mux_input, 127, 96) @[ConfMux.scala 27:34]
    inputs[3] <= _inputs_3_T @[ConfMux.scala 27:19]
    io.mux_output <= inputs[io.selector] @[ConfMux.scala 30:19]

  module ConfMux_1 :
    input clock : Clock
    input reset : Reset
    output io : { flip selector : UInt<2>, flip mux_input : UInt<4>, mux_output : UInt<1>}

    wire inputs : UInt<1>[4] @[ConfMux.scala 25:22]
    node _inputs_0_T = bits(io.mux_input, 0, 0) @[ConfMux.scala 27:34]
    inputs[0] <= _inputs_0_T @[ConfMux.scala 27:19]
    node _inputs_1_T = bits(io.mux_input, 1, 1) @[ConfMux.scala 27:34]
    inputs[1] <= _inputs_1_T @[ConfMux.scala 27:19]
    node _inputs_2_T = bits(io.mux_input, 2, 2) @[ConfMux.scala 27:34]
    inputs[2] <= _inputs_2_T @[ConfMux.scala 27:19]
    node _inputs_3_T = bits(io.mux_input, 3, 3) @[ConfMux.scala 27:34]
    inputs[3] <= _inputs_3_T @[ConfMux.scala 27:19]
    io.mux_output <= inputs[io.selector] @[ConfMux.scala 30:19]

  module FR :
    input clock : Clock
    input reset : Reset
    output io : { flip valid_in : UInt<4>, flip ready_out : UInt<5>, flip valid_mux_sel : UInt<2>, flip fork_mask : UInt<5>, valid_out : UInt<1>}

    wire aux : UInt<1>[6] @[FR.scala 22:19]
    wire temp : UInt<1>[6] @[FR.scala 23:20]
    wire Vaux : UInt<1> @[FR.scala 24:20]
    node _aux_0_T = bits(io.fork_mask, 0, 0) @[FR.scala 27:34]
    node _aux_0_T_1 = not(_aux_0_T) @[FR.scala 27:21]
    node _aux_0_T_2 = bits(io.ready_out, 0, 0) @[FR.scala 27:53]
    node _aux_0_T_3 = or(_aux_0_T_1, _aux_0_T_2) @[FR.scala 27:39]
    node _aux_0_T_4 = bits(_aux_0_T_3, 0, 0) @[FR.scala 27:58]
    aux[0] <= _aux_0_T_4 @[FR.scala 27:16]
    node _aux_1_T = bits(io.fork_mask, 1, 1) @[FR.scala 27:34]
    node _aux_1_T_1 = not(_aux_1_T) @[FR.scala 27:21]
    node _aux_1_T_2 = bits(io.ready_out, 1, 1) @[FR.scala 27:53]
    node _aux_1_T_3 = or(_aux_1_T_1, _aux_1_T_2) @[FR.scala 27:39]
    node _aux_1_T_4 = bits(_aux_1_T_3, 0, 0) @[FR.scala 27:58]
    aux[1] <= _aux_1_T_4 @[FR.scala 27:16]
    node _aux_2_T = bits(io.fork_mask, 2, 2) @[FR.scala 27:34]
    node _aux_2_T_1 = not(_aux_2_T) @[FR.scala 27:21]
    node _aux_2_T_2 = bits(io.ready_out, 2, 2) @[FR.scala 27:53]
    node _aux_2_T_3 = or(_aux_2_T_1, _aux_2_T_2) @[FR.scala 27:39]
    node _aux_2_T_4 = bits(_aux_2_T_3, 0, 0) @[FR.scala 27:58]
    aux[2] <= _aux_2_T_4 @[FR.scala 27:16]
    node _aux_3_T = bits(io.fork_mask, 3, 3) @[FR.scala 27:34]
    node _aux_3_T_1 = not(_aux_3_T) @[FR.scala 27:21]
    node _aux_3_T_2 = bits(io.ready_out, 3, 3) @[FR.scala 27:53]
    node _aux_3_T_3 = or(_aux_3_T_1, _aux_3_T_2) @[FR.scala 27:39]
    node _aux_3_T_4 = bits(_aux_3_T_3, 0, 0) @[FR.scala 27:58]
    aux[3] <= _aux_3_T_4 @[FR.scala 27:16]
    node _aux_4_T = bits(io.fork_mask, 4, 4) @[FR.scala 27:34]
    node _aux_4_T_1 = not(_aux_4_T) @[FR.scala 27:21]
    node _aux_4_T_2 = bits(io.ready_out, 4, 4) @[FR.scala 27:53]
    node _aux_4_T_3 = or(_aux_4_T_1, _aux_4_T_2) @[FR.scala 27:39]
    node _aux_4_T_4 = bits(_aux_4_T_3, 0, 0) @[FR.scala 27:58]
    aux[4] <= _aux_4_T_4 @[FR.scala 27:16]
    inst conf_mux of ConfMux_1 @[FR.scala 29:28]
    conf_mux.clock <= clock
    conf_mux.reset <= reset
    conf_mux.io.selector <= io.valid_mux_sel @[FR.scala 30:26]
    conf_mux.io.mux_input <= io.valid_in @[FR.scala 31:27]
    Vaux <= conf_mux.io.mux_output @[FR.scala 32:28]
    node _aux_5_T = bits(Vaux, 0, 0) @[FR.scala 34:34]
    aux[5] <= _aux_5_T @[FR.scala 34:27]
    temp[0] <= aux[0] @[FR.scala 35:13]
    node _temp_1_T = and(temp[0], aux[1]) @[FR.scala 38:30]
    temp[1] <= _temp_1_T @[FR.scala 38:17]
    node _temp_2_T = and(temp[1], aux[2]) @[FR.scala 38:30]
    temp[2] <= _temp_2_T @[FR.scala 38:17]
    node _temp_3_T = and(temp[2], aux[3]) @[FR.scala 38:30]
    temp[3] <= _temp_3_T @[FR.scala 38:17]
    node _temp_4_T = and(temp[3], aux[4]) @[FR.scala 38:30]
    temp[4] <= _temp_4_T @[FR.scala 38:17]
    node _temp_5_T = and(temp[4], aux[5]) @[FR.scala 38:30]
    temp[5] <= _temp_5_T @[FR.scala 38:17]
    io.valid_out <= temp[5] @[FR.scala 40:18]

  module RegEnable :
    input clock : Clock
    input reset : Reset
    output io : { flip in : UInt<32>, flip en : UInt<1>, out : UInt<32>}

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
    input reset : Reset
    output io : { flip din : UInt<32>, flip din_v : UInt<1>, flip dout_r : UInt<1>, dout : UInt<32>, dout_v : UInt<1>, din_r : UInt<1>}

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

  module D_FIFO_1 :
    input clock : Clock
    input reset : Reset
    output io : { flip din : UInt<32>, flip din_v : UInt<1>, flip dout_r : UInt<1>, din_r : UInt<1>, dout : UInt<32>, dout_v : UInt<1>}

    smem memory : UInt<32> [32] @[D_FIFO.scala 17:29]
    reg write_pointer : UInt<32>, clock with :
      reset => (reset, UInt<32>("h0")) @[D_FIFO.scala 19:36]
    reg read_pointer : UInt<32>, clock with :
      reset => (reset, UInt<32>("h0")) @[D_FIFO.scala 20:31]
    reg num_data : UInt<32>, clock with :
      reset => (reset, UInt<32>("h0")) @[D_FIFO.scala 21:27]
    wire full : UInt<1> @[D_FIFO.scala 24:20]
    wire empty : UInt<1> @[D_FIFO.scala 25:21]
    wire rd_en : UInt<1> @[D_FIFO.scala 26:21]
    wire wr_en : UInt<1> @[D_FIFO.scala 27:21]
    empty <= UInt<1>("h1") @[D_FIFO.scala 29:11]
    full <= UInt<1>("h0") @[D_FIFO.scala 30:14]
    write_pointer <= UInt<1>("h0") @[D_FIFO.scala 31:23]
    read_pointer <= UInt<1>("h0") @[D_FIFO.scala 32:18]
    num_data <= UInt<1>("h0") @[D_FIFO.scala 33:18]
    io.dout <= UInt<1>("h0") @[D_FIFO.scala 34:13]
    io.dout_v <= UInt<1>("h0") @[D_FIFO.scala 35:19]
    when io.dout_r : @[D_FIFO.scala 37:22]
      io.dout_v <= UInt<1>("h0") @[D_FIFO.scala 38:19]
    node _T = eq(full, UInt<1>("h0")) @[D_FIFO.scala 41:16]
    node _T_1 = eq(wr_en, UInt<1>("h1")) @[D_FIFO.scala 41:38]
    node _T_2 = and(_T, _T_1) @[D_FIFO.scala 41:29]
    when _T_2 : @[D_FIFO.scala 41:50]
      node _T_3 = bits(write_pointer, 4, 0) @[D_FIFO.scala 42:15]
      infer mport MPORT = memory[_T_3], clock @[D_FIFO.scala 42:15]
      MPORT <= io.din @[D_FIFO.scala 42:31]
      node _num_data_T = add(num_data, UInt<1>("h1")) @[D_FIFO.scala 43:30]
      node _num_data_T_1 = tail(_num_data_T, 1) @[D_FIFO.scala 43:30]
      num_data <= _num_data_T_1 @[D_FIFO.scala 43:18]
      node _T_4 = sub(UInt<6>("h20"), UInt<1>("h1")) @[D_FIFO.scala 45:46]
      node _T_5 = tail(_T_4, 1) @[D_FIFO.scala 45:46]
      node _T_6 = eq(write_pointer, _T_5) @[D_FIFO.scala 45:29]
      when _T_6 : @[D_FIFO.scala 45:54]
        write_pointer <= UInt<1>("h0") @[D_FIFO.scala 46:27]
      else :
        node _write_pointer_T = add(write_pointer, UInt<1>("h1")) @[D_FIFO.scala 48:44]
        node _write_pointer_T_1 = tail(_write_pointer_T, 1) @[D_FIFO.scala 48:44]
        write_pointer <= _write_pointer_T_1 @[D_FIFO.scala 48:27]
    node _T_7 = eq(empty, UInt<1>("h0")) @[D_FIFO.scala 52:17]
    node _T_8 = eq(rd_en, UInt<1>("h1")) @[D_FIFO.scala 52:39]
    node _T_9 = and(_T_7, _T_8) @[D_FIFO.scala 52:30]
    when _T_9 : @[D_FIFO.scala 52:51]
      node _io_dout_T = bits(read_pointer, 4, 0) @[D_FIFO.scala 53:26]
      infer mport io_dout_MPORT = memory[_io_dout_T], clock @[D_FIFO.scala 53:26]
      io.dout <= io_dout_MPORT @[D_FIFO.scala 53:17]
      io.dout_v <= UInt<1>("h1") @[D_FIFO.scala 54:19]
      node _num_data_T_2 = sub(num_data, UInt<1>("h1")) @[D_FIFO.scala 55:30]
      node _num_data_T_3 = tail(_num_data_T_2, 1) @[D_FIFO.scala 55:30]
      num_data <= _num_data_T_3 @[D_FIFO.scala 55:18]
      node _T_10 = sub(UInt<6>("h20"), UInt<1>("h1")) @[D_FIFO.scala 57:45]
      node _T_11 = tail(_T_10, 1) @[D_FIFO.scala 57:45]
      node _T_12 = eq(read_pointer, _T_11) @[D_FIFO.scala 57:28]
      when _T_12 : @[D_FIFO.scala 57:53]
        read_pointer <= UInt<1>("h0") @[D_FIFO.scala 58:26]
      else :
        node _read_pointer_T = add(read_pointer, UInt<1>("h1")) @[D_FIFO.scala 60:42]
        node _read_pointer_T_1 = tail(_read_pointer_T, 1) @[D_FIFO.scala 60:42]
        read_pointer <= _read_pointer_T_1 @[D_FIFO.scala 60:26]
    node _T_13 = eq(num_data, UInt<6>("h20")) @[D_FIFO.scala 64:20]
    when _T_13 : @[D_FIFO.scala 64:39]
      full <= UInt<1>("h1") @[D_FIFO.scala 65:14]
    else :
      full <= UInt<1>("h0") @[D_FIFO.scala 67:14]
    node _T_14 = eq(num_data, UInt<1>("h0")) @[D_FIFO.scala 70:20]
    when _T_14 : @[D_FIFO.scala 70:30]
      empty <= UInt<1>("h1") @[D_FIFO.scala 71:15]
    else :
      empty <= UInt<1>("h0") @[D_FIFO.scala 73:15]
    node _wr_en_T = not(full) @[D_FIFO.scala 76:26]
    node _wr_en_T_1 = and(io.din_v, _wr_en_T) @[D_FIFO.scala 76:23]
    wr_en <= _wr_en_T_1 @[D_FIFO.scala 76:11]
    node _rd_en_T = not(empty) @[D_FIFO.scala 77:31]
    node _rd_en_T_1 = and(io.dout_r, _rd_en_T) @[D_FIFO.scala 77:28]
    rd_en <= _rd_en_T_1 @[D_FIFO.scala 77:15]
    node _io_din_r_T = not(full) @[D_FIFO.scala 78:22]
    io.din_r <= _io_din_r_T @[D_FIFO.scala 78:18]

  module FS_1 :
    input clock : Clock
    input reset : Reset
    output io : { flip ready_out : UInt<5>, flip fork_mask : UInt<5>, ready_in : UInt<1>}

    wire aux : UInt<1>[5] @[FS.scala 20:19]
    wire temp : UInt<1>[5] @[FS.scala 21:20]
    node _aux_0_T = bits(io.fork_mask, 0, 0) @[FS.scala 24:34]
    node _aux_0_T_1 = not(_aux_0_T) @[FS.scala 24:21]
    node _aux_0_T_2 = bits(io.ready_out, 0, 0) @[FS.scala 24:53]
    node _aux_0_T_3 = or(_aux_0_T_1, _aux_0_T_2) @[FS.scala 24:39]
    node _aux_0_T_4 = bits(_aux_0_T_3, 0, 0) @[FS.scala 24:58]
    aux[0] <= _aux_0_T_4 @[FS.scala 24:16]
    node _aux_1_T = bits(io.fork_mask, 1, 1) @[FS.scala 24:34]
    node _aux_1_T_1 = not(_aux_1_T) @[FS.scala 24:21]
    node _aux_1_T_2 = bits(io.ready_out, 1, 1) @[FS.scala 24:53]
    node _aux_1_T_3 = or(_aux_1_T_1, _aux_1_T_2) @[FS.scala 24:39]
    node _aux_1_T_4 = bits(_aux_1_T_3, 0, 0) @[FS.scala 24:58]
    aux[1] <= _aux_1_T_4 @[FS.scala 24:16]
    node _aux_2_T = bits(io.fork_mask, 2, 2) @[FS.scala 24:34]
    node _aux_2_T_1 = not(_aux_2_T) @[FS.scala 24:21]
    node _aux_2_T_2 = bits(io.ready_out, 2, 2) @[FS.scala 24:53]
    node _aux_2_T_3 = or(_aux_2_T_1, _aux_2_T_2) @[FS.scala 24:39]
    node _aux_2_T_4 = bits(_aux_2_T_3, 0, 0) @[FS.scala 24:58]
    aux[2] <= _aux_2_T_4 @[FS.scala 24:16]
    node _aux_3_T = bits(io.fork_mask, 3, 3) @[FS.scala 24:34]
    node _aux_3_T_1 = not(_aux_3_T) @[FS.scala 24:21]
    node _aux_3_T_2 = bits(io.ready_out, 3, 3) @[FS.scala 24:53]
    node _aux_3_T_3 = or(_aux_3_T_1, _aux_3_T_2) @[FS.scala 24:39]
    node _aux_3_T_4 = bits(_aux_3_T_3, 0, 0) @[FS.scala 24:58]
    aux[3] <= _aux_3_T_4 @[FS.scala 24:16]
    node _aux_4_T = bits(io.fork_mask, 4, 4) @[FS.scala 24:34]
    node _aux_4_T_1 = not(_aux_4_T) @[FS.scala 24:21]
    node _aux_4_T_2 = bits(io.ready_out, 4, 4) @[FS.scala 24:53]
    node _aux_4_T_3 = or(_aux_4_T_1, _aux_4_T_2) @[FS.scala 24:39]
    node _aux_4_T_4 = bits(_aux_4_T_3, 0, 0) @[FS.scala 24:58]
    aux[4] <= _aux_4_T_4 @[FS.scala 24:16]
    temp[0] <= aux[0] @[FS.scala 27:13]
    node _temp_1_T = and(temp[0], aux[1]) @[FS.scala 30:30]
    temp[1] <= _temp_1_T @[FS.scala 30:17]
    node _temp_2_T = and(temp[1], aux[2]) @[FS.scala 30:30]
    temp[2] <= _temp_2_T @[FS.scala 30:17]
    node _temp_3_T = and(temp[2], aux[3]) @[FS.scala 30:30]
    temp[3] <= _temp_3_T @[FS.scala 30:17]
    node _temp_4_T = and(temp[3], aux[4]) @[FS.scala 30:30]
    temp[4] <= _temp_4_T @[FS.scala 30:17]
    io.ready_in <= temp[4] @[FS.scala 33:17]

  module ConfMux_2 :
    input clock : Clock
    input reset : Reset
    output io : { flip selector : UInt<2>, flip mux_input : UInt<128>, mux_output : UInt<32>}

    wire inputs : UInt<32>[4] @[ConfMux.scala 25:22]
    node _inputs_0_T = bits(io.mux_input, 31, 0) @[ConfMux.scala 27:34]
    inputs[0] <= _inputs_0_T @[ConfMux.scala 27:19]
    node _inputs_1_T = bits(io.mux_input, 63, 32) @[ConfMux.scala 27:34]
    inputs[1] <= _inputs_1_T @[ConfMux.scala 27:19]
    node _inputs_2_T = bits(io.mux_input, 95, 64) @[ConfMux.scala 27:34]
    inputs[2] <= _inputs_2_T @[ConfMux.scala 27:19]
    node _inputs_3_T = bits(io.mux_input, 127, 96) @[ConfMux.scala 27:34]
    inputs[3] <= _inputs_3_T @[ConfMux.scala 27:19]
    io.mux_output <= inputs[io.selector] @[ConfMux.scala 30:19]

  module ConfMux_3 :
    input clock : Clock
    input reset : Reset
    output io : { flip selector : UInt<2>, flip mux_input : UInt<4>, mux_output : UInt<1>}

    wire inputs : UInt<1>[4] @[ConfMux.scala 25:22]
    node _inputs_0_T = bits(io.mux_input, 0, 0) @[ConfMux.scala 27:34]
    inputs[0] <= _inputs_0_T @[ConfMux.scala 27:19]
    node _inputs_1_T = bits(io.mux_input, 1, 1) @[ConfMux.scala 27:34]
    inputs[1] <= _inputs_1_T @[ConfMux.scala 27:19]
    node _inputs_2_T = bits(io.mux_input, 2, 2) @[ConfMux.scala 27:34]
    inputs[2] <= _inputs_2_T @[ConfMux.scala 27:19]
    node _inputs_3_T = bits(io.mux_input, 3, 3) @[ConfMux.scala 27:34]
    inputs[3] <= _inputs_3_T @[ConfMux.scala 27:19]
    io.mux_output <= inputs[io.selector] @[ConfMux.scala 30:19]

  module FR_1 :
    input clock : Clock
    input reset : Reset
    output io : { flip valid_in : UInt<4>, flip ready_out : UInt<5>, flip valid_mux_sel : UInt<2>, flip fork_mask : UInt<5>, valid_out : UInt<1>}

    wire aux : UInt<1>[6] @[FR.scala 22:19]
    wire temp : UInt<1>[6] @[FR.scala 23:20]
    wire Vaux : UInt<1> @[FR.scala 24:20]
    node _aux_0_T = bits(io.fork_mask, 0, 0) @[FR.scala 27:34]
    node _aux_0_T_1 = not(_aux_0_T) @[FR.scala 27:21]
    node _aux_0_T_2 = bits(io.ready_out, 0, 0) @[FR.scala 27:53]
    node _aux_0_T_3 = or(_aux_0_T_1, _aux_0_T_2) @[FR.scala 27:39]
    node _aux_0_T_4 = bits(_aux_0_T_3, 0, 0) @[FR.scala 27:58]
    aux[0] <= _aux_0_T_4 @[FR.scala 27:16]
    node _aux_1_T = bits(io.fork_mask, 1, 1) @[FR.scala 27:34]
    node _aux_1_T_1 = not(_aux_1_T) @[FR.scala 27:21]
    node _aux_1_T_2 = bits(io.ready_out, 1, 1) @[FR.scala 27:53]
    node _aux_1_T_3 = or(_aux_1_T_1, _aux_1_T_2) @[FR.scala 27:39]
    node _aux_1_T_4 = bits(_aux_1_T_3, 0, 0) @[FR.scala 27:58]
    aux[1] <= _aux_1_T_4 @[FR.scala 27:16]
    node _aux_2_T = bits(io.fork_mask, 2, 2) @[FR.scala 27:34]
    node _aux_2_T_1 = not(_aux_2_T) @[FR.scala 27:21]
    node _aux_2_T_2 = bits(io.ready_out, 2, 2) @[FR.scala 27:53]
    node _aux_2_T_3 = or(_aux_2_T_1, _aux_2_T_2) @[FR.scala 27:39]
    node _aux_2_T_4 = bits(_aux_2_T_3, 0, 0) @[FR.scala 27:58]
    aux[2] <= _aux_2_T_4 @[FR.scala 27:16]
    node _aux_3_T = bits(io.fork_mask, 3, 3) @[FR.scala 27:34]
    node _aux_3_T_1 = not(_aux_3_T) @[FR.scala 27:21]
    node _aux_3_T_2 = bits(io.ready_out, 3, 3) @[FR.scala 27:53]
    node _aux_3_T_3 = or(_aux_3_T_1, _aux_3_T_2) @[FR.scala 27:39]
    node _aux_3_T_4 = bits(_aux_3_T_3, 0, 0) @[FR.scala 27:58]
    aux[3] <= _aux_3_T_4 @[FR.scala 27:16]
    node _aux_4_T = bits(io.fork_mask, 4, 4) @[FR.scala 27:34]
    node _aux_4_T_1 = not(_aux_4_T) @[FR.scala 27:21]
    node _aux_4_T_2 = bits(io.ready_out, 4, 4) @[FR.scala 27:53]
    node _aux_4_T_3 = or(_aux_4_T_1, _aux_4_T_2) @[FR.scala 27:39]
    node _aux_4_T_4 = bits(_aux_4_T_3, 0, 0) @[FR.scala 27:58]
    aux[4] <= _aux_4_T_4 @[FR.scala 27:16]
    inst conf_mux of ConfMux_3 @[FR.scala 29:28]
    conf_mux.clock <= clock
    conf_mux.reset <= reset
    conf_mux.io.selector <= io.valid_mux_sel @[FR.scala 30:26]
    conf_mux.io.mux_input <= io.valid_in @[FR.scala 31:27]
    Vaux <= conf_mux.io.mux_output @[FR.scala 32:28]
    node _aux_5_T = bits(Vaux, 0, 0) @[FR.scala 34:34]
    aux[5] <= _aux_5_T @[FR.scala 34:27]
    temp[0] <= aux[0] @[FR.scala 35:13]
    node _temp_1_T = and(temp[0], aux[1]) @[FR.scala 38:30]
    temp[1] <= _temp_1_T @[FR.scala 38:17]
    node _temp_2_T = and(temp[1], aux[2]) @[FR.scala 38:30]
    temp[2] <= _temp_2_T @[FR.scala 38:17]
    node _temp_3_T = and(temp[2], aux[3]) @[FR.scala 38:30]
    temp[3] <= _temp_3_T @[FR.scala 38:17]
    node _temp_4_T = and(temp[3], aux[4]) @[FR.scala 38:30]
    temp[4] <= _temp_4_T @[FR.scala 38:17]
    node _temp_5_T = and(temp[4], aux[5]) @[FR.scala 38:30]
    temp[5] <= _temp_5_T @[FR.scala 38:17]
    io.valid_out <= temp[5] @[FR.scala 40:18]

  module RegEnable_2 :
    input clock : Clock
    input reset : Reset
    output io : { flip in : UInt<32>, flip en : UInt<1>, out : UInt<32>}

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

  module D_REG_1 :
    input clock : Clock
    input reset : Reset
    output io : { flip din : UInt<32>, flip din_v : UInt<1>, flip dout_r : UInt<1>, dout : UInt<32>, dout_v : UInt<1>, din_r : UInt<1>}

    inst reg_1 of RegEnable_2 @[D_REG.scala 19:25]
    reg_1.clock <= clock
    reg_1.reset <= reset
    inst reg_2 of RegEnable_3 @[D_REG.scala 20:25]
    reg_2.clock <= clock
    reg_2.reset <= reset
    reg_1.io.in <= io.din @[D_REG.scala 22:17]
    reg_2.io.in <= io.din_v @[D_REG.scala 23:17]
    reg_1.io.en <= io.dout_r @[D_REG.scala 24:17]
    reg_2.io.en <= io.dout_r @[D_REG.scala 25:17]
    io.dout <= reg_1.io.out @[D_REG.scala 26:13]
    io.dout_v <= reg_2.io.out @[D_REG.scala 27:15]
    io.din_r <= io.dout_r @[D_REG.scala 28:14]

  module D_FIFO_2 :
    input clock : Clock
    input reset : Reset
    output io : { flip din : UInt<32>, flip din_v : UInt<1>, flip dout_r : UInt<1>, din_r : UInt<1>, dout : UInt<32>, dout_v : UInt<1>}

    smem memory : UInt<32> [32] @[D_FIFO.scala 17:29]
    reg write_pointer : UInt<32>, clock with :
      reset => (reset, UInt<32>("h0")) @[D_FIFO.scala 19:36]
    reg read_pointer : UInt<32>, clock with :
      reset => (reset, UInt<32>("h0")) @[D_FIFO.scala 20:31]
    reg num_data : UInt<32>, clock with :
      reset => (reset, UInt<32>("h0")) @[D_FIFO.scala 21:27]
    wire full : UInt<1> @[D_FIFO.scala 24:20]
    wire empty : UInt<1> @[D_FIFO.scala 25:21]
    wire rd_en : UInt<1> @[D_FIFO.scala 26:21]
    wire wr_en : UInt<1> @[D_FIFO.scala 27:21]
    empty <= UInt<1>("h1") @[D_FIFO.scala 29:11]
    full <= UInt<1>("h0") @[D_FIFO.scala 30:14]
    write_pointer <= UInt<1>("h0") @[D_FIFO.scala 31:23]
    read_pointer <= UInt<1>("h0") @[D_FIFO.scala 32:18]
    num_data <= UInt<1>("h0") @[D_FIFO.scala 33:18]
    io.dout <= UInt<1>("h0") @[D_FIFO.scala 34:13]
    io.dout_v <= UInt<1>("h0") @[D_FIFO.scala 35:19]
    when io.dout_r : @[D_FIFO.scala 37:22]
      io.dout_v <= UInt<1>("h0") @[D_FIFO.scala 38:19]
    node _T = eq(full, UInt<1>("h0")) @[D_FIFO.scala 41:16]
    node _T_1 = eq(wr_en, UInt<1>("h1")) @[D_FIFO.scala 41:38]
    node _T_2 = and(_T, _T_1) @[D_FIFO.scala 41:29]
    when _T_2 : @[D_FIFO.scala 41:50]
      node _T_3 = bits(write_pointer, 4, 0) @[D_FIFO.scala 42:15]
      infer mport MPORT = memory[_T_3], clock @[D_FIFO.scala 42:15]
      MPORT <= io.din @[D_FIFO.scala 42:31]
      node _num_data_T = add(num_data, UInt<1>("h1")) @[D_FIFO.scala 43:30]
      node _num_data_T_1 = tail(_num_data_T, 1) @[D_FIFO.scala 43:30]
      num_data <= _num_data_T_1 @[D_FIFO.scala 43:18]
      node _T_4 = sub(UInt<6>("h20"), UInt<1>("h1")) @[D_FIFO.scala 45:46]
      node _T_5 = tail(_T_4, 1) @[D_FIFO.scala 45:46]
      node _T_6 = eq(write_pointer, _T_5) @[D_FIFO.scala 45:29]
      when _T_6 : @[D_FIFO.scala 45:54]
        write_pointer <= UInt<1>("h0") @[D_FIFO.scala 46:27]
      else :
        node _write_pointer_T = add(write_pointer, UInt<1>("h1")) @[D_FIFO.scala 48:44]
        node _write_pointer_T_1 = tail(_write_pointer_T, 1) @[D_FIFO.scala 48:44]
        write_pointer <= _write_pointer_T_1 @[D_FIFO.scala 48:27]
    node _T_7 = eq(empty, UInt<1>("h0")) @[D_FIFO.scala 52:17]
    node _T_8 = eq(rd_en, UInt<1>("h1")) @[D_FIFO.scala 52:39]
    node _T_9 = and(_T_7, _T_8) @[D_FIFO.scala 52:30]
    when _T_9 : @[D_FIFO.scala 52:51]
      node _io_dout_T = bits(read_pointer, 4, 0) @[D_FIFO.scala 53:26]
      infer mport io_dout_MPORT = memory[_io_dout_T], clock @[D_FIFO.scala 53:26]
      io.dout <= io_dout_MPORT @[D_FIFO.scala 53:17]
      io.dout_v <= UInt<1>("h1") @[D_FIFO.scala 54:19]
      node _num_data_T_2 = sub(num_data, UInt<1>("h1")) @[D_FIFO.scala 55:30]
      node _num_data_T_3 = tail(_num_data_T_2, 1) @[D_FIFO.scala 55:30]
      num_data <= _num_data_T_3 @[D_FIFO.scala 55:18]
      node _T_10 = sub(UInt<6>("h20"), UInt<1>("h1")) @[D_FIFO.scala 57:45]
      node _T_11 = tail(_T_10, 1) @[D_FIFO.scala 57:45]
      node _T_12 = eq(read_pointer, _T_11) @[D_FIFO.scala 57:28]
      when _T_12 : @[D_FIFO.scala 57:53]
        read_pointer <= UInt<1>("h0") @[D_FIFO.scala 58:26]
      else :
        node _read_pointer_T = add(read_pointer, UInt<1>("h1")) @[D_FIFO.scala 60:42]
        node _read_pointer_T_1 = tail(_read_pointer_T, 1) @[D_FIFO.scala 60:42]
        read_pointer <= _read_pointer_T_1 @[D_FIFO.scala 60:26]
    node _T_13 = eq(num_data, UInt<6>("h20")) @[D_FIFO.scala 64:20]
    when _T_13 : @[D_FIFO.scala 64:39]
      full <= UInt<1>("h1") @[D_FIFO.scala 65:14]
    else :
      full <= UInt<1>("h0") @[D_FIFO.scala 67:14]
    node _T_14 = eq(num_data, UInt<1>("h0")) @[D_FIFO.scala 70:20]
    when _T_14 : @[D_FIFO.scala 70:30]
      empty <= UInt<1>("h1") @[D_FIFO.scala 71:15]
    else :
      empty <= UInt<1>("h0") @[D_FIFO.scala 73:15]
    node _wr_en_T = not(full) @[D_FIFO.scala 76:26]
    node _wr_en_T_1 = and(io.din_v, _wr_en_T) @[D_FIFO.scala 76:23]
    wr_en <= _wr_en_T_1 @[D_FIFO.scala 76:11]
    node _rd_en_T = not(empty) @[D_FIFO.scala 77:31]
    node _rd_en_T_1 = and(io.dout_r, _rd_en_T) @[D_FIFO.scala 77:28]
    rd_en <= _rd_en_T_1 @[D_FIFO.scala 77:15]
    node _io_din_r_T = not(full) @[D_FIFO.scala 78:22]
    io.din_r <= _io_din_r_T @[D_FIFO.scala 78:18]

  module FS_2 :
    input clock : Clock
    input reset : Reset
    output io : { flip ready_out : UInt<5>, flip fork_mask : UInt<5>, ready_in : UInt<1>}

    wire aux : UInt<1>[5] @[FS.scala 20:19]
    wire temp : UInt<1>[5] @[FS.scala 21:20]
    node _aux_0_T = bits(io.fork_mask, 0, 0) @[FS.scala 24:34]
    node _aux_0_T_1 = not(_aux_0_T) @[FS.scala 24:21]
    node _aux_0_T_2 = bits(io.ready_out, 0, 0) @[FS.scala 24:53]
    node _aux_0_T_3 = or(_aux_0_T_1, _aux_0_T_2) @[FS.scala 24:39]
    node _aux_0_T_4 = bits(_aux_0_T_3, 0, 0) @[FS.scala 24:58]
    aux[0] <= _aux_0_T_4 @[FS.scala 24:16]
    node _aux_1_T = bits(io.fork_mask, 1, 1) @[FS.scala 24:34]
    node _aux_1_T_1 = not(_aux_1_T) @[FS.scala 24:21]
    node _aux_1_T_2 = bits(io.ready_out, 1, 1) @[FS.scala 24:53]
    node _aux_1_T_3 = or(_aux_1_T_1, _aux_1_T_2) @[FS.scala 24:39]
    node _aux_1_T_4 = bits(_aux_1_T_3, 0, 0) @[FS.scala 24:58]
    aux[1] <= _aux_1_T_4 @[FS.scala 24:16]
    node _aux_2_T = bits(io.fork_mask, 2, 2) @[FS.scala 24:34]
    node _aux_2_T_1 = not(_aux_2_T) @[FS.scala 24:21]
    node _aux_2_T_2 = bits(io.ready_out, 2, 2) @[FS.scala 24:53]
    node _aux_2_T_3 = or(_aux_2_T_1, _aux_2_T_2) @[FS.scala 24:39]
    node _aux_2_T_4 = bits(_aux_2_T_3, 0, 0) @[FS.scala 24:58]
    aux[2] <= _aux_2_T_4 @[FS.scala 24:16]
    node _aux_3_T = bits(io.fork_mask, 3, 3) @[FS.scala 24:34]
    node _aux_3_T_1 = not(_aux_3_T) @[FS.scala 24:21]
    node _aux_3_T_2 = bits(io.ready_out, 3, 3) @[FS.scala 24:53]
    node _aux_3_T_3 = or(_aux_3_T_1, _aux_3_T_2) @[FS.scala 24:39]
    node _aux_3_T_4 = bits(_aux_3_T_3, 0, 0) @[FS.scala 24:58]
    aux[3] <= _aux_3_T_4 @[FS.scala 24:16]
    node _aux_4_T = bits(io.fork_mask, 4, 4) @[FS.scala 24:34]
    node _aux_4_T_1 = not(_aux_4_T) @[FS.scala 24:21]
    node _aux_4_T_2 = bits(io.ready_out, 4, 4) @[FS.scala 24:53]
    node _aux_4_T_3 = or(_aux_4_T_1, _aux_4_T_2) @[FS.scala 24:39]
    node _aux_4_T_4 = bits(_aux_4_T_3, 0, 0) @[FS.scala 24:58]
    aux[4] <= _aux_4_T_4 @[FS.scala 24:16]
    temp[0] <= aux[0] @[FS.scala 27:13]
    node _temp_1_T = and(temp[0], aux[1]) @[FS.scala 30:30]
    temp[1] <= _temp_1_T @[FS.scala 30:17]
    node _temp_2_T = and(temp[1], aux[2]) @[FS.scala 30:30]
    temp[2] <= _temp_2_T @[FS.scala 30:17]
    node _temp_3_T = and(temp[2], aux[3]) @[FS.scala 30:30]
    temp[3] <= _temp_3_T @[FS.scala 30:17]
    node _temp_4_T = and(temp[3], aux[4]) @[FS.scala 30:30]
    temp[4] <= _temp_4_T @[FS.scala 30:17]
    io.ready_in <= temp[4] @[FS.scala 33:17]

  module ConfMux_4 :
    input clock : Clock
    input reset : Reset
    output io : { flip selector : UInt<2>, flip mux_input : UInt<128>, mux_output : UInt<32>}

    wire inputs : UInt<32>[4] @[ConfMux.scala 25:22]
    node _inputs_0_T = bits(io.mux_input, 31, 0) @[ConfMux.scala 27:34]
    inputs[0] <= _inputs_0_T @[ConfMux.scala 27:19]
    node _inputs_1_T = bits(io.mux_input, 63, 32) @[ConfMux.scala 27:34]
    inputs[1] <= _inputs_1_T @[ConfMux.scala 27:19]
    node _inputs_2_T = bits(io.mux_input, 95, 64) @[ConfMux.scala 27:34]
    inputs[2] <= _inputs_2_T @[ConfMux.scala 27:19]
    node _inputs_3_T = bits(io.mux_input, 127, 96) @[ConfMux.scala 27:34]
    inputs[3] <= _inputs_3_T @[ConfMux.scala 27:19]
    io.mux_output <= inputs[io.selector] @[ConfMux.scala 30:19]

  module ConfMux_5 :
    input clock : Clock
    input reset : Reset
    output io : { flip selector : UInt<2>, flip mux_input : UInt<4>, mux_output : UInt<1>}

    wire inputs : UInt<1>[4] @[ConfMux.scala 25:22]
    node _inputs_0_T = bits(io.mux_input, 0, 0) @[ConfMux.scala 27:34]
    inputs[0] <= _inputs_0_T @[ConfMux.scala 27:19]
    node _inputs_1_T = bits(io.mux_input, 1, 1) @[ConfMux.scala 27:34]
    inputs[1] <= _inputs_1_T @[ConfMux.scala 27:19]
    node _inputs_2_T = bits(io.mux_input, 2, 2) @[ConfMux.scala 27:34]
    inputs[2] <= _inputs_2_T @[ConfMux.scala 27:19]
    node _inputs_3_T = bits(io.mux_input, 3, 3) @[ConfMux.scala 27:34]
    inputs[3] <= _inputs_3_T @[ConfMux.scala 27:19]
    io.mux_output <= inputs[io.selector] @[ConfMux.scala 30:19]

  module FR_2 :
    input clock : Clock
    input reset : Reset
    output io : { flip valid_in : UInt<4>, flip ready_out : UInt<5>, flip valid_mux_sel : UInt<2>, flip fork_mask : UInt<5>, valid_out : UInt<1>}

    wire aux : UInt<1>[6] @[FR.scala 22:19]
    wire temp : UInt<1>[6] @[FR.scala 23:20]
    wire Vaux : UInt<1> @[FR.scala 24:20]
    node _aux_0_T = bits(io.fork_mask, 0, 0) @[FR.scala 27:34]
    node _aux_0_T_1 = not(_aux_0_T) @[FR.scala 27:21]
    node _aux_0_T_2 = bits(io.ready_out, 0, 0) @[FR.scala 27:53]
    node _aux_0_T_3 = or(_aux_0_T_1, _aux_0_T_2) @[FR.scala 27:39]
    node _aux_0_T_4 = bits(_aux_0_T_3, 0, 0) @[FR.scala 27:58]
    aux[0] <= _aux_0_T_4 @[FR.scala 27:16]
    node _aux_1_T = bits(io.fork_mask, 1, 1) @[FR.scala 27:34]
    node _aux_1_T_1 = not(_aux_1_T) @[FR.scala 27:21]
    node _aux_1_T_2 = bits(io.ready_out, 1, 1) @[FR.scala 27:53]
    node _aux_1_T_3 = or(_aux_1_T_1, _aux_1_T_2) @[FR.scala 27:39]
    node _aux_1_T_4 = bits(_aux_1_T_3, 0, 0) @[FR.scala 27:58]
    aux[1] <= _aux_1_T_4 @[FR.scala 27:16]
    node _aux_2_T = bits(io.fork_mask, 2, 2) @[FR.scala 27:34]
    node _aux_2_T_1 = not(_aux_2_T) @[FR.scala 27:21]
    node _aux_2_T_2 = bits(io.ready_out, 2, 2) @[FR.scala 27:53]
    node _aux_2_T_3 = or(_aux_2_T_1, _aux_2_T_2) @[FR.scala 27:39]
    node _aux_2_T_4 = bits(_aux_2_T_3, 0, 0) @[FR.scala 27:58]
    aux[2] <= _aux_2_T_4 @[FR.scala 27:16]
    node _aux_3_T = bits(io.fork_mask, 3, 3) @[FR.scala 27:34]
    node _aux_3_T_1 = not(_aux_3_T) @[FR.scala 27:21]
    node _aux_3_T_2 = bits(io.ready_out, 3, 3) @[FR.scala 27:53]
    node _aux_3_T_3 = or(_aux_3_T_1, _aux_3_T_2) @[FR.scala 27:39]
    node _aux_3_T_4 = bits(_aux_3_T_3, 0, 0) @[FR.scala 27:58]
    aux[3] <= _aux_3_T_4 @[FR.scala 27:16]
    node _aux_4_T = bits(io.fork_mask, 4, 4) @[FR.scala 27:34]
    node _aux_4_T_1 = not(_aux_4_T) @[FR.scala 27:21]
    node _aux_4_T_2 = bits(io.ready_out, 4, 4) @[FR.scala 27:53]
    node _aux_4_T_3 = or(_aux_4_T_1, _aux_4_T_2) @[FR.scala 27:39]
    node _aux_4_T_4 = bits(_aux_4_T_3, 0, 0) @[FR.scala 27:58]
    aux[4] <= _aux_4_T_4 @[FR.scala 27:16]
    inst conf_mux of ConfMux_5 @[FR.scala 29:28]
    conf_mux.clock <= clock
    conf_mux.reset <= reset
    conf_mux.io.selector <= io.valid_mux_sel @[FR.scala 30:26]
    conf_mux.io.mux_input <= io.valid_in @[FR.scala 31:27]
    Vaux <= conf_mux.io.mux_output @[FR.scala 32:28]
    node _aux_5_T = bits(Vaux, 0, 0) @[FR.scala 34:34]
    aux[5] <= _aux_5_T @[FR.scala 34:27]
    temp[0] <= aux[0] @[FR.scala 35:13]
    node _temp_1_T = and(temp[0], aux[1]) @[FR.scala 38:30]
    temp[1] <= _temp_1_T @[FR.scala 38:17]
    node _temp_2_T = and(temp[1], aux[2]) @[FR.scala 38:30]
    temp[2] <= _temp_2_T @[FR.scala 38:17]
    node _temp_3_T = and(temp[2], aux[3]) @[FR.scala 38:30]
    temp[3] <= _temp_3_T @[FR.scala 38:17]
    node _temp_4_T = and(temp[3], aux[4]) @[FR.scala 38:30]
    temp[4] <= _temp_4_T @[FR.scala 38:17]
    node _temp_5_T = and(temp[4], aux[5]) @[FR.scala 38:30]
    temp[5] <= _temp_5_T @[FR.scala 38:17]
    io.valid_out <= temp[5] @[FR.scala 40:18]

  module RegEnable_4 :
    input clock : Clock
    input reset : Reset
    output io : { flip in : UInt<32>, flip en : UInt<1>, out : UInt<32>}

    reg reg : UInt, clock with :
      reset => (reset, UInt<1>("h0")) @[RegEnable.scala 11:22]
    when io.en : @[RegEnable.scala 12:17]
      reg <= io.in @[RegEnable.scala 13:13]
    io.out <= reg @[RegEnable.scala 15:12]

  module RegEnable_5 :
    input clock : Clock
    input reset : Reset
    output io : { flip in : UInt<1>, flip en : UInt<1>, out : UInt<1>}

    reg reg : UInt, clock with :
      reset => (reset, UInt<1>("h0")) @[RegEnable.scala 11:22]
    when io.en : @[RegEnable.scala 12:17]
      reg <= io.in @[RegEnable.scala 13:13]
    io.out <= reg @[RegEnable.scala 15:12]

  module D_REG_2 :
    input clock : Clock
    input reset : Reset
    output io : { flip din : UInt<32>, flip din_v : UInt<1>, flip dout_r : UInt<1>, dout : UInt<32>, dout_v : UInt<1>, din_r : UInt<1>}

    inst reg_1 of RegEnable_4 @[D_REG.scala 19:25]
    reg_1.clock <= clock
    reg_1.reset <= reset
    inst reg_2 of RegEnable_5 @[D_REG.scala 20:25]
    reg_2.clock <= clock
    reg_2.reset <= reset
    reg_1.io.in <= io.din @[D_REG.scala 22:17]
    reg_2.io.in <= io.din_v @[D_REG.scala 23:17]
    reg_1.io.en <= io.dout_r @[D_REG.scala 24:17]
    reg_2.io.en <= io.dout_r @[D_REG.scala 25:17]
    io.dout <= reg_1.io.out @[D_REG.scala 26:13]
    io.dout_v <= reg_2.io.out @[D_REG.scala 27:15]
    io.din_r <= io.dout_r @[D_REG.scala 28:14]

  module D_FIFO_3 :
    input clock : Clock
    input reset : Reset
    output io : { flip din : UInt<32>, flip din_v : UInt<1>, flip dout_r : UInt<1>, din_r : UInt<1>, dout : UInt<32>, dout_v : UInt<1>}

    smem memory : UInt<32> [32] @[D_FIFO.scala 17:29]
    reg write_pointer : UInt<32>, clock with :
      reset => (reset, UInt<32>("h0")) @[D_FIFO.scala 19:36]
    reg read_pointer : UInt<32>, clock with :
      reset => (reset, UInt<32>("h0")) @[D_FIFO.scala 20:31]
    reg num_data : UInt<32>, clock with :
      reset => (reset, UInt<32>("h0")) @[D_FIFO.scala 21:27]
    wire full : UInt<1> @[D_FIFO.scala 24:20]
    wire empty : UInt<1> @[D_FIFO.scala 25:21]
    wire rd_en : UInt<1> @[D_FIFO.scala 26:21]
    wire wr_en : UInt<1> @[D_FIFO.scala 27:21]
    empty <= UInt<1>("h1") @[D_FIFO.scala 29:11]
    full <= UInt<1>("h0") @[D_FIFO.scala 30:14]
    write_pointer <= UInt<1>("h0") @[D_FIFO.scala 31:23]
    read_pointer <= UInt<1>("h0") @[D_FIFO.scala 32:18]
    num_data <= UInt<1>("h0") @[D_FIFO.scala 33:18]
    io.dout <= UInt<1>("h0") @[D_FIFO.scala 34:13]
    io.dout_v <= UInt<1>("h0") @[D_FIFO.scala 35:19]
    when io.dout_r : @[D_FIFO.scala 37:22]
      io.dout_v <= UInt<1>("h0") @[D_FIFO.scala 38:19]
    node _T = eq(full, UInt<1>("h0")) @[D_FIFO.scala 41:16]
    node _T_1 = eq(wr_en, UInt<1>("h1")) @[D_FIFO.scala 41:38]
    node _T_2 = and(_T, _T_1) @[D_FIFO.scala 41:29]
    when _T_2 : @[D_FIFO.scala 41:50]
      node _T_3 = bits(write_pointer, 4, 0) @[D_FIFO.scala 42:15]
      infer mport MPORT = memory[_T_3], clock @[D_FIFO.scala 42:15]
      MPORT <= io.din @[D_FIFO.scala 42:31]
      node _num_data_T = add(num_data, UInt<1>("h1")) @[D_FIFO.scala 43:30]
      node _num_data_T_1 = tail(_num_data_T, 1) @[D_FIFO.scala 43:30]
      num_data <= _num_data_T_1 @[D_FIFO.scala 43:18]
      node _T_4 = sub(UInt<6>("h20"), UInt<1>("h1")) @[D_FIFO.scala 45:46]
      node _T_5 = tail(_T_4, 1) @[D_FIFO.scala 45:46]
      node _T_6 = eq(write_pointer, _T_5) @[D_FIFO.scala 45:29]
      when _T_6 : @[D_FIFO.scala 45:54]
        write_pointer <= UInt<1>("h0") @[D_FIFO.scala 46:27]
      else :
        node _write_pointer_T = add(write_pointer, UInt<1>("h1")) @[D_FIFO.scala 48:44]
        node _write_pointer_T_1 = tail(_write_pointer_T, 1) @[D_FIFO.scala 48:44]
        write_pointer <= _write_pointer_T_1 @[D_FIFO.scala 48:27]
    node _T_7 = eq(empty, UInt<1>("h0")) @[D_FIFO.scala 52:17]
    node _T_8 = eq(rd_en, UInt<1>("h1")) @[D_FIFO.scala 52:39]
    node _T_9 = and(_T_7, _T_8) @[D_FIFO.scala 52:30]
    when _T_9 : @[D_FIFO.scala 52:51]
      node _io_dout_T = bits(read_pointer, 4, 0) @[D_FIFO.scala 53:26]
      infer mport io_dout_MPORT = memory[_io_dout_T], clock @[D_FIFO.scala 53:26]
      io.dout <= io_dout_MPORT @[D_FIFO.scala 53:17]
      io.dout_v <= UInt<1>("h1") @[D_FIFO.scala 54:19]
      node _num_data_T_2 = sub(num_data, UInt<1>("h1")) @[D_FIFO.scala 55:30]
      node _num_data_T_3 = tail(_num_data_T_2, 1) @[D_FIFO.scala 55:30]
      num_data <= _num_data_T_3 @[D_FIFO.scala 55:18]
      node _T_10 = sub(UInt<6>("h20"), UInt<1>("h1")) @[D_FIFO.scala 57:45]
      node _T_11 = tail(_T_10, 1) @[D_FIFO.scala 57:45]
      node _T_12 = eq(read_pointer, _T_11) @[D_FIFO.scala 57:28]
      when _T_12 : @[D_FIFO.scala 57:53]
        read_pointer <= UInt<1>("h0") @[D_FIFO.scala 58:26]
      else :
        node _read_pointer_T = add(read_pointer, UInt<1>("h1")) @[D_FIFO.scala 60:42]
        node _read_pointer_T_1 = tail(_read_pointer_T, 1) @[D_FIFO.scala 60:42]
        read_pointer <= _read_pointer_T_1 @[D_FIFO.scala 60:26]
    node _T_13 = eq(num_data, UInt<6>("h20")) @[D_FIFO.scala 64:20]
    when _T_13 : @[D_FIFO.scala 64:39]
      full <= UInt<1>("h1") @[D_FIFO.scala 65:14]
    else :
      full <= UInt<1>("h0") @[D_FIFO.scala 67:14]
    node _T_14 = eq(num_data, UInt<1>("h0")) @[D_FIFO.scala 70:20]
    when _T_14 : @[D_FIFO.scala 70:30]
      empty <= UInt<1>("h1") @[D_FIFO.scala 71:15]
    else :
      empty <= UInt<1>("h0") @[D_FIFO.scala 73:15]
    node _wr_en_T = not(full) @[D_FIFO.scala 76:26]
    node _wr_en_T_1 = and(io.din_v, _wr_en_T) @[D_FIFO.scala 76:23]
    wr_en <= _wr_en_T_1 @[D_FIFO.scala 76:11]
    node _rd_en_T = not(empty) @[D_FIFO.scala 77:31]
    node _rd_en_T_1 = and(io.dout_r, _rd_en_T) @[D_FIFO.scala 77:28]
    rd_en <= _rd_en_T_1 @[D_FIFO.scala 77:15]
    node _io_din_r_T = not(full) @[D_FIFO.scala 78:22]
    io.din_r <= _io_din_r_T @[D_FIFO.scala 78:18]

  module FS_3 :
    input clock : Clock
    input reset : Reset
    output io : { flip ready_out : UInt<5>, flip fork_mask : UInt<5>, ready_in : UInt<1>}

    wire aux : UInt<1>[5] @[FS.scala 20:19]
    wire temp : UInt<1>[5] @[FS.scala 21:20]
    node _aux_0_T = bits(io.fork_mask, 0, 0) @[FS.scala 24:34]
    node _aux_0_T_1 = not(_aux_0_T) @[FS.scala 24:21]
    node _aux_0_T_2 = bits(io.ready_out, 0, 0) @[FS.scala 24:53]
    node _aux_0_T_3 = or(_aux_0_T_1, _aux_0_T_2) @[FS.scala 24:39]
    node _aux_0_T_4 = bits(_aux_0_T_3, 0, 0) @[FS.scala 24:58]
    aux[0] <= _aux_0_T_4 @[FS.scala 24:16]
    node _aux_1_T = bits(io.fork_mask, 1, 1) @[FS.scala 24:34]
    node _aux_1_T_1 = not(_aux_1_T) @[FS.scala 24:21]
    node _aux_1_T_2 = bits(io.ready_out, 1, 1) @[FS.scala 24:53]
    node _aux_1_T_3 = or(_aux_1_T_1, _aux_1_T_2) @[FS.scala 24:39]
    node _aux_1_T_4 = bits(_aux_1_T_3, 0, 0) @[FS.scala 24:58]
    aux[1] <= _aux_1_T_4 @[FS.scala 24:16]
    node _aux_2_T = bits(io.fork_mask, 2, 2) @[FS.scala 24:34]
    node _aux_2_T_1 = not(_aux_2_T) @[FS.scala 24:21]
    node _aux_2_T_2 = bits(io.ready_out, 2, 2) @[FS.scala 24:53]
    node _aux_2_T_3 = or(_aux_2_T_1, _aux_2_T_2) @[FS.scala 24:39]
    node _aux_2_T_4 = bits(_aux_2_T_3, 0, 0) @[FS.scala 24:58]
    aux[2] <= _aux_2_T_4 @[FS.scala 24:16]
    node _aux_3_T = bits(io.fork_mask, 3, 3) @[FS.scala 24:34]
    node _aux_3_T_1 = not(_aux_3_T) @[FS.scala 24:21]
    node _aux_3_T_2 = bits(io.ready_out, 3, 3) @[FS.scala 24:53]
    node _aux_3_T_3 = or(_aux_3_T_1, _aux_3_T_2) @[FS.scala 24:39]
    node _aux_3_T_4 = bits(_aux_3_T_3, 0, 0) @[FS.scala 24:58]
    aux[3] <= _aux_3_T_4 @[FS.scala 24:16]
    node _aux_4_T = bits(io.fork_mask, 4, 4) @[FS.scala 24:34]
    node _aux_4_T_1 = not(_aux_4_T) @[FS.scala 24:21]
    node _aux_4_T_2 = bits(io.ready_out, 4, 4) @[FS.scala 24:53]
    node _aux_4_T_3 = or(_aux_4_T_1, _aux_4_T_2) @[FS.scala 24:39]
    node _aux_4_T_4 = bits(_aux_4_T_3, 0, 0) @[FS.scala 24:58]
    aux[4] <= _aux_4_T_4 @[FS.scala 24:16]
    temp[0] <= aux[0] @[FS.scala 27:13]
    node _temp_1_T = and(temp[0], aux[1]) @[FS.scala 30:30]
    temp[1] <= _temp_1_T @[FS.scala 30:17]
    node _temp_2_T = and(temp[1], aux[2]) @[FS.scala 30:30]
    temp[2] <= _temp_2_T @[FS.scala 30:17]
    node _temp_3_T = and(temp[2], aux[3]) @[FS.scala 30:30]
    temp[3] <= _temp_3_T @[FS.scala 30:17]
    node _temp_4_T = and(temp[3], aux[4]) @[FS.scala 30:30]
    temp[4] <= _temp_4_T @[FS.scala 30:17]
    io.ready_in <= temp[4] @[FS.scala 33:17]

  module ConfMux_6 :
    input clock : Clock
    input reset : Reset
    output io : { flip selector : UInt<2>, flip mux_input : UInt<128>, mux_output : UInt<32>}

    wire inputs : UInt<32>[4] @[ConfMux.scala 25:22]
    node _inputs_0_T = bits(io.mux_input, 31, 0) @[ConfMux.scala 27:34]
    inputs[0] <= _inputs_0_T @[ConfMux.scala 27:19]
    node _inputs_1_T = bits(io.mux_input, 63, 32) @[ConfMux.scala 27:34]
    inputs[1] <= _inputs_1_T @[ConfMux.scala 27:19]
    node _inputs_2_T = bits(io.mux_input, 95, 64) @[ConfMux.scala 27:34]
    inputs[2] <= _inputs_2_T @[ConfMux.scala 27:19]
    node _inputs_3_T = bits(io.mux_input, 127, 96) @[ConfMux.scala 27:34]
    inputs[3] <= _inputs_3_T @[ConfMux.scala 27:19]
    io.mux_output <= inputs[io.selector] @[ConfMux.scala 30:19]

  module ConfMux_7 :
    input clock : Clock
    input reset : Reset
    output io : { flip selector : UInt<2>, flip mux_input : UInt<4>, mux_output : UInt<1>}

    wire inputs : UInt<1>[4] @[ConfMux.scala 25:22]
    node _inputs_0_T = bits(io.mux_input, 0, 0) @[ConfMux.scala 27:34]
    inputs[0] <= _inputs_0_T @[ConfMux.scala 27:19]
    node _inputs_1_T = bits(io.mux_input, 1, 1) @[ConfMux.scala 27:34]
    inputs[1] <= _inputs_1_T @[ConfMux.scala 27:19]
    node _inputs_2_T = bits(io.mux_input, 2, 2) @[ConfMux.scala 27:34]
    inputs[2] <= _inputs_2_T @[ConfMux.scala 27:19]
    node _inputs_3_T = bits(io.mux_input, 3, 3) @[ConfMux.scala 27:34]
    inputs[3] <= _inputs_3_T @[ConfMux.scala 27:19]
    io.mux_output <= inputs[io.selector] @[ConfMux.scala 30:19]

  module FR_3 :
    input clock : Clock
    input reset : Reset
    output io : { flip valid_in : UInt<4>, flip ready_out : UInt<5>, flip valid_mux_sel : UInt<2>, flip fork_mask : UInt<5>, valid_out : UInt<1>}

    wire aux : UInt<1>[6] @[FR.scala 22:19]
    wire temp : UInt<1>[6] @[FR.scala 23:20]
    wire Vaux : UInt<1> @[FR.scala 24:20]
    node _aux_0_T = bits(io.fork_mask, 0, 0) @[FR.scala 27:34]
    node _aux_0_T_1 = not(_aux_0_T) @[FR.scala 27:21]
    node _aux_0_T_2 = bits(io.ready_out, 0, 0) @[FR.scala 27:53]
    node _aux_0_T_3 = or(_aux_0_T_1, _aux_0_T_2) @[FR.scala 27:39]
    node _aux_0_T_4 = bits(_aux_0_T_3, 0, 0) @[FR.scala 27:58]
    aux[0] <= _aux_0_T_4 @[FR.scala 27:16]
    node _aux_1_T = bits(io.fork_mask, 1, 1) @[FR.scala 27:34]
    node _aux_1_T_1 = not(_aux_1_T) @[FR.scala 27:21]
    node _aux_1_T_2 = bits(io.ready_out, 1, 1) @[FR.scala 27:53]
    node _aux_1_T_3 = or(_aux_1_T_1, _aux_1_T_2) @[FR.scala 27:39]
    node _aux_1_T_4 = bits(_aux_1_T_3, 0, 0) @[FR.scala 27:58]
    aux[1] <= _aux_1_T_4 @[FR.scala 27:16]
    node _aux_2_T = bits(io.fork_mask, 2, 2) @[FR.scala 27:34]
    node _aux_2_T_1 = not(_aux_2_T) @[FR.scala 27:21]
    node _aux_2_T_2 = bits(io.ready_out, 2, 2) @[FR.scala 27:53]
    node _aux_2_T_3 = or(_aux_2_T_1, _aux_2_T_2) @[FR.scala 27:39]
    node _aux_2_T_4 = bits(_aux_2_T_3, 0, 0) @[FR.scala 27:58]
    aux[2] <= _aux_2_T_4 @[FR.scala 27:16]
    node _aux_3_T = bits(io.fork_mask, 3, 3) @[FR.scala 27:34]
    node _aux_3_T_1 = not(_aux_3_T) @[FR.scala 27:21]
    node _aux_3_T_2 = bits(io.ready_out, 3, 3) @[FR.scala 27:53]
    node _aux_3_T_3 = or(_aux_3_T_1, _aux_3_T_2) @[FR.scala 27:39]
    node _aux_3_T_4 = bits(_aux_3_T_3, 0, 0) @[FR.scala 27:58]
    aux[3] <= _aux_3_T_4 @[FR.scala 27:16]
    node _aux_4_T = bits(io.fork_mask, 4, 4) @[FR.scala 27:34]
    node _aux_4_T_1 = not(_aux_4_T) @[FR.scala 27:21]
    node _aux_4_T_2 = bits(io.ready_out, 4, 4) @[FR.scala 27:53]
    node _aux_4_T_3 = or(_aux_4_T_1, _aux_4_T_2) @[FR.scala 27:39]
    node _aux_4_T_4 = bits(_aux_4_T_3, 0, 0) @[FR.scala 27:58]
    aux[4] <= _aux_4_T_4 @[FR.scala 27:16]
    inst conf_mux of ConfMux_7 @[FR.scala 29:28]
    conf_mux.clock <= clock
    conf_mux.reset <= reset
    conf_mux.io.selector <= io.valid_mux_sel @[FR.scala 30:26]
    conf_mux.io.mux_input <= io.valid_in @[FR.scala 31:27]
    Vaux <= conf_mux.io.mux_output @[FR.scala 32:28]
    node _aux_5_T = bits(Vaux, 0, 0) @[FR.scala 34:34]
    aux[5] <= _aux_5_T @[FR.scala 34:27]
    temp[0] <= aux[0] @[FR.scala 35:13]
    node _temp_1_T = and(temp[0], aux[1]) @[FR.scala 38:30]
    temp[1] <= _temp_1_T @[FR.scala 38:17]
    node _temp_2_T = and(temp[1], aux[2]) @[FR.scala 38:30]
    temp[2] <= _temp_2_T @[FR.scala 38:17]
    node _temp_3_T = and(temp[2], aux[3]) @[FR.scala 38:30]
    temp[3] <= _temp_3_T @[FR.scala 38:17]
    node _temp_4_T = and(temp[3], aux[4]) @[FR.scala 38:30]
    temp[4] <= _temp_4_T @[FR.scala 38:17]
    node _temp_5_T = and(temp[4], aux[5]) @[FR.scala 38:30]
    temp[5] <= _temp_5_T @[FR.scala 38:17]
    io.valid_out <= temp[5] @[FR.scala 40:18]

  module RegEnable_6 :
    input clock : Clock
    input reset : Reset
    output io : { flip in : UInt<32>, flip en : UInt<1>, out : UInt<32>}

    reg reg : UInt, clock with :
      reset => (reset, UInt<1>("h0")) @[RegEnable.scala 11:22]
    when io.en : @[RegEnable.scala 12:17]
      reg <= io.in @[RegEnable.scala 13:13]
    io.out <= reg @[RegEnable.scala 15:12]

  module RegEnable_7 :
    input clock : Clock
    input reset : Reset
    output io : { flip in : UInt<1>, flip en : UInt<1>, out : UInt<1>}

    reg reg : UInt, clock with :
      reset => (reset, UInt<1>("h0")) @[RegEnable.scala 11:22]
    when io.en : @[RegEnable.scala 12:17]
      reg <= io.in @[RegEnable.scala 13:13]
    io.out <= reg @[RegEnable.scala 15:12]

  module D_REG_3 :
    input clock : Clock
    input reset : Reset
    output io : { flip din : UInt<32>, flip din_v : UInt<1>, flip dout_r : UInt<1>, dout : UInt<32>, dout_v : UInt<1>, din_r : UInt<1>}

    inst reg_1 of RegEnable_6 @[D_REG.scala 19:25]
    reg_1.clock <= clock
    reg_1.reset <= reset
    inst reg_2 of RegEnable_7 @[D_REG.scala 20:25]
    reg_2.clock <= clock
    reg_2.reset <= reset
    reg_1.io.in <= io.din @[D_REG.scala 22:17]
    reg_2.io.in <= io.din_v @[D_REG.scala 23:17]
    reg_1.io.en <= io.dout_r @[D_REG.scala 24:17]
    reg_2.io.en <= io.dout_r @[D_REG.scala 25:17]
    io.dout <= reg_1.io.out @[D_REG.scala 26:13]
    io.dout_v <= reg_2.io.out @[D_REG.scala 27:15]
    io.din_r <= io.dout_r @[D_REG.scala 28:14]

  module ConfMux_8 :
    input clock : Clock
    input reset : Reset
    output io : { flip selector : UInt<3>, flip mux_input : UInt<6>, mux_output : UInt<1>}

    wire inputs : UInt<1>[6] @[ConfMux.scala 25:22]
    node _inputs_0_T = bits(io.mux_input, 0, 0) @[ConfMux.scala 27:34]
    inputs[0] <= _inputs_0_T @[ConfMux.scala 27:19]
    node _inputs_1_T = bits(io.mux_input, 1, 1) @[ConfMux.scala 27:34]
    inputs[1] <= _inputs_1_T @[ConfMux.scala 27:19]
    node _inputs_2_T = bits(io.mux_input, 2, 2) @[ConfMux.scala 27:34]
    inputs[2] <= _inputs_2_T @[ConfMux.scala 27:19]
    node _inputs_3_T = bits(io.mux_input, 3, 3) @[ConfMux.scala 27:34]
    inputs[3] <= _inputs_3_T @[ConfMux.scala 27:19]
    node _inputs_4_T = bits(io.mux_input, 4, 4) @[ConfMux.scala 27:34]
    inputs[4] <= _inputs_4_T @[ConfMux.scala 27:19]
    node _inputs_5_T = bits(io.mux_input, 5, 5) @[ConfMux.scala 27:34]
    inputs[5] <= _inputs_5_T @[ConfMux.scala 27:19]
    io.mux_output <= inputs[io.selector] @[ConfMux.scala 30:19]

  module FR_4 :
    input clock : Clock
    input reset : Reset
    output io : { flip valid_in : UInt<6>, flip ready_out : UInt<4>, flip valid_mux_sel : UInt<3>, flip fork_mask : UInt<4>, valid_out : UInt<1>}

    wire aux : UInt<1>[5] @[FR.scala 22:19]
    wire temp : UInt<1>[5] @[FR.scala 23:20]
    wire Vaux : UInt<1> @[FR.scala 24:20]
    node _aux_0_T = bits(io.fork_mask, 0, 0) @[FR.scala 27:34]
    node _aux_0_T_1 = not(_aux_0_T) @[FR.scala 27:21]
    node _aux_0_T_2 = bits(io.ready_out, 0, 0) @[FR.scala 27:53]
    node _aux_0_T_3 = or(_aux_0_T_1, _aux_0_T_2) @[FR.scala 27:39]
    node _aux_0_T_4 = bits(_aux_0_T_3, 0, 0) @[FR.scala 27:58]
    aux[0] <= _aux_0_T_4 @[FR.scala 27:16]
    node _aux_1_T = bits(io.fork_mask, 1, 1) @[FR.scala 27:34]
    node _aux_1_T_1 = not(_aux_1_T) @[FR.scala 27:21]
    node _aux_1_T_2 = bits(io.ready_out, 1, 1) @[FR.scala 27:53]
    node _aux_1_T_3 = or(_aux_1_T_1, _aux_1_T_2) @[FR.scala 27:39]
    node _aux_1_T_4 = bits(_aux_1_T_3, 0, 0) @[FR.scala 27:58]
    aux[1] <= _aux_1_T_4 @[FR.scala 27:16]
    node _aux_2_T = bits(io.fork_mask, 2, 2) @[FR.scala 27:34]
    node _aux_2_T_1 = not(_aux_2_T) @[FR.scala 27:21]
    node _aux_2_T_2 = bits(io.ready_out, 2, 2) @[FR.scala 27:53]
    node _aux_2_T_3 = or(_aux_2_T_1, _aux_2_T_2) @[FR.scala 27:39]
    node _aux_2_T_4 = bits(_aux_2_T_3, 0, 0) @[FR.scala 27:58]
    aux[2] <= _aux_2_T_4 @[FR.scala 27:16]
    node _aux_3_T = bits(io.fork_mask, 3, 3) @[FR.scala 27:34]
    node _aux_3_T_1 = not(_aux_3_T) @[FR.scala 27:21]
    node _aux_3_T_2 = bits(io.ready_out, 3, 3) @[FR.scala 27:53]
    node _aux_3_T_3 = or(_aux_3_T_1, _aux_3_T_2) @[FR.scala 27:39]
    node _aux_3_T_4 = bits(_aux_3_T_3, 0, 0) @[FR.scala 27:58]
    aux[3] <= _aux_3_T_4 @[FR.scala 27:16]
    inst conf_mux of ConfMux_8 @[FR.scala 29:28]
    conf_mux.clock <= clock
    conf_mux.reset <= reset
    conf_mux.io.selector <= io.valid_mux_sel @[FR.scala 30:26]
    conf_mux.io.mux_input <= io.valid_in @[FR.scala 31:27]
    Vaux <= conf_mux.io.mux_output @[FR.scala 32:28]
    node _aux_4_T = bits(Vaux, 0, 0) @[FR.scala 34:34]
    aux[4] <= _aux_4_T @[FR.scala 34:27]
    temp[0] <= aux[0] @[FR.scala 35:13]
    node _temp_1_T = and(temp[0], aux[1]) @[FR.scala 38:30]
    temp[1] <= _temp_1_T @[FR.scala 38:17]
    node _temp_2_T = and(temp[1], aux[2]) @[FR.scala 38:30]
    temp[2] <= _temp_2_T @[FR.scala 38:17]
    node _temp_3_T = and(temp[2], aux[3]) @[FR.scala 38:30]
    temp[3] <= _temp_3_T @[FR.scala 38:17]
    node _temp_4_T = and(temp[3], aux[4]) @[FR.scala 38:30]
    temp[4] <= _temp_4_T @[FR.scala 38:17]
    io.valid_out <= temp[4] @[FR.scala 40:18]

  module ConfMux_9 :
    input clock : Clock
    input reset : Reset
    output io : { flip selector : UInt<3>, flip mux_input : UInt<192>, mux_output : UInt<32>}

    wire inputs : UInt<32>[6] @[ConfMux.scala 25:22]
    node _inputs_0_T = bits(io.mux_input, 31, 0) @[ConfMux.scala 27:34]
    inputs[0] <= _inputs_0_T @[ConfMux.scala 27:19]
    node _inputs_1_T = bits(io.mux_input, 63, 32) @[ConfMux.scala 27:34]
    inputs[1] <= _inputs_1_T @[ConfMux.scala 27:19]
    node _inputs_2_T = bits(io.mux_input, 95, 64) @[ConfMux.scala 27:34]
    inputs[2] <= _inputs_2_T @[ConfMux.scala 27:19]
    node _inputs_3_T = bits(io.mux_input, 127, 96) @[ConfMux.scala 27:34]
    inputs[3] <= _inputs_3_T @[ConfMux.scala 27:19]
    node _inputs_4_T = bits(io.mux_input, 159, 128) @[ConfMux.scala 27:34]
    inputs[4] <= _inputs_4_T @[ConfMux.scala 27:19]
    node _inputs_5_T = bits(io.mux_input, 191, 160) @[ConfMux.scala 27:34]
    inputs[5] <= _inputs_5_T @[ConfMux.scala 27:19]
    io.mux_output <= inputs[io.selector] @[ConfMux.scala 30:19]

  module RegEnable_8 :
    input clock : Clock
    input reset : Reset
    output io : { flip in : UInt<32>, flip en : UInt<1>, out : UInt<32>}

    reg reg : UInt, clock with :
      reset => (reset, UInt<1>("h0")) @[RegEnable.scala 11:22]
    when io.en : @[RegEnable.scala 12:17]
      reg <= io.in @[RegEnable.scala 13:13]
    io.out <= reg @[RegEnable.scala 15:12]

  module RegEnable_9 :
    input clock : Clock
    input reset : Reset
    output io : { flip in : UInt<32>, flip en : UInt<1>, out : UInt<32>}

    reg reg : UInt, clock with :
      reset => (reset, UInt<1>("h0")) @[RegEnable.scala 11:22]
    when io.en : @[RegEnable.scala 12:17]
      reg <= io.in @[RegEnable.scala 13:13]
    io.out <= reg @[RegEnable.scala 15:12]

  module RegEnable_10 :
    input clock : Clock
    input reset : Reset
    output io : { flip in : UInt<1>, flip en : UInt<1>, out : UInt<1>}

    reg reg : UInt, clock with :
      reset => (reset, UInt<1>("h0")) @[RegEnable.scala 11:22]
    when io.en : @[RegEnable.scala 12:17]
      reg <= io.in @[RegEnable.scala 13:13]
    io.out <= reg @[RegEnable.scala 15:12]

  module RegEnable_11 :
    input clock : Clock
    input reset : Reset
    output io : { flip in : UInt<1>, flip en : UInt<1>, out : UInt<1>}

    reg reg : UInt, clock with :
      reset => (reset, UInt<1>("h0")) @[RegEnable.scala 11:22]
    when io.en : @[RegEnable.scala 12:17]
      reg <= io.in @[RegEnable.scala 13:13]
    io.out <= reg @[RegEnable.scala 15:12]

  module D_SEB :
    input clock : Clock
    input reset : Reset
    output io : { flip din : UInt<32>, flip din_v : UInt<1>, din_r : UInt<1>, dout : UInt<32>, dout_v : UInt<1>, flip dout_r : UInt<1>}

    inst main of RegEnable_8 @[D_SEB.scala 19:24]
    main.clock <= clock
    main.reset <= reset
    inst aux of RegEnable_9 @[D_SEB.scala 20:23]
    aux.clock <= clock
    aux.reset <= reset
    inst reg_1 of RegEnable_10 @[D_SEB.scala 21:25]
    reg_1.clock <= clock
    reg_1.reset <= reset
    inst reg_2 of RegEnable_11 @[D_SEB.scala 22:25]
    reg_2.clock <= clock
    reg_2.reset <= reset
    reg reg : UInt<1>, clock with :
      reset => (reset, UInt<1>("h0")) @[D_SEB.scala 24:22]
    wire S_EA_EM : UInt<1> @[D_SEB.scala 25:23]
    node _mux2_out_T = bits(reg, 0, 0) @[D_SEB.scala 28:28]
    node mux2_out = mux(_mux2_out_T, reg_1.io.out, reg_2.io.out) @[D_SEB.scala 28:23]
    node _reg_T = not(mux2_out) @[D_SEB.scala 29:32]
    node _reg_T_1 = or(io.dout_r, _reg_T) @[D_SEB.scala 29:29]
    reg <= _reg_T_1 @[D_SEB.scala 29:9]
    node _S_EA_EM_T = bits(reg, 0, 0) @[D_SEB.scala 30:20]
    S_EA_EM <= _S_EA_EM_T @[D_SEB.scala 30:13]
    node _io_dout_v_T = bits(mux2_out, 0, 0) @[D_SEB.scala 31:27]
    io.dout_v <= _io_dout_v_T @[D_SEB.scala 31:15]
    io.din_r <= S_EA_EM @[D_SEB.scala 34:14]
    main.io.in <= io.din @[D_SEB.scala 36:16]
    aux.io.in <= main.io.out @[D_SEB.scala 37:15]
    reg_1.io.in <= io.din_v @[D_SEB.scala 38:17]
    reg_2.io.in <= reg_1.io.out @[D_SEB.scala 39:17]
    main.io.en <= S_EA_EM @[D_SEB.scala 41:16]
    aux.io.en <= S_EA_EM @[D_SEB.scala 42:15]
    reg_1.io.en <= S_EA_EM @[D_SEB.scala 43:17]
    reg_2.io.en <= S_EA_EM @[D_SEB.scala 44:17]
    node _io_dout_T = mux(S_EA_EM, main.io.out, aux.io.out) @[D_SEB.scala 46:19]
    io.dout <= _io_dout_T @[D_SEB.scala 46:13]

  module ConfMux_10 :
    input clock : Clock
    input reset : Reset
    output io : { flip selector : UInt<3>, flip mux_input : UInt<6>, mux_output : UInt<1>}

    wire inputs : UInt<1>[6] @[ConfMux.scala 25:22]
    node _inputs_0_T = bits(io.mux_input, 0, 0) @[ConfMux.scala 27:34]
    inputs[0] <= _inputs_0_T @[ConfMux.scala 27:19]
    node _inputs_1_T = bits(io.mux_input, 1, 1) @[ConfMux.scala 27:34]
    inputs[1] <= _inputs_1_T @[ConfMux.scala 27:19]
    node _inputs_2_T = bits(io.mux_input, 2, 2) @[ConfMux.scala 27:34]
    inputs[2] <= _inputs_2_T @[ConfMux.scala 27:19]
    node _inputs_3_T = bits(io.mux_input, 3, 3) @[ConfMux.scala 27:34]
    inputs[3] <= _inputs_3_T @[ConfMux.scala 27:19]
    node _inputs_4_T = bits(io.mux_input, 4, 4) @[ConfMux.scala 27:34]
    inputs[4] <= _inputs_4_T @[ConfMux.scala 27:19]
    node _inputs_5_T = bits(io.mux_input, 5, 5) @[ConfMux.scala 27:34]
    inputs[5] <= _inputs_5_T @[ConfMux.scala 27:19]
    io.mux_output <= inputs[io.selector] @[ConfMux.scala 30:19]

  module FR_5 :
    input clock : Clock
    input reset : Reset
    output io : { flip valid_in : UInt<6>, flip ready_out : UInt<4>, flip valid_mux_sel : UInt<3>, flip fork_mask : UInt<4>, valid_out : UInt<1>}

    wire aux : UInt<1>[5] @[FR.scala 22:19]
    wire temp : UInt<1>[5] @[FR.scala 23:20]
    wire Vaux : UInt<1> @[FR.scala 24:20]
    node _aux_0_T = bits(io.fork_mask, 0, 0) @[FR.scala 27:34]
    node _aux_0_T_1 = not(_aux_0_T) @[FR.scala 27:21]
    node _aux_0_T_2 = bits(io.ready_out, 0, 0) @[FR.scala 27:53]
    node _aux_0_T_3 = or(_aux_0_T_1, _aux_0_T_2) @[FR.scala 27:39]
    node _aux_0_T_4 = bits(_aux_0_T_3, 0, 0) @[FR.scala 27:58]
    aux[0] <= _aux_0_T_4 @[FR.scala 27:16]
    node _aux_1_T = bits(io.fork_mask, 1, 1) @[FR.scala 27:34]
    node _aux_1_T_1 = not(_aux_1_T) @[FR.scala 27:21]
    node _aux_1_T_2 = bits(io.ready_out, 1, 1) @[FR.scala 27:53]
    node _aux_1_T_3 = or(_aux_1_T_1, _aux_1_T_2) @[FR.scala 27:39]
    node _aux_1_T_4 = bits(_aux_1_T_3, 0, 0) @[FR.scala 27:58]
    aux[1] <= _aux_1_T_4 @[FR.scala 27:16]
    node _aux_2_T = bits(io.fork_mask, 2, 2) @[FR.scala 27:34]
    node _aux_2_T_1 = not(_aux_2_T) @[FR.scala 27:21]
    node _aux_2_T_2 = bits(io.ready_out, 2, 2) @[FR.scala 27:53]
    node _aux_2_T_3 = or(_aux_2_T_1, _aux_2_T_2) @[FR.scala 27:39]
    node _aux_2_T_4 = bits(_aux_2_T_3, 0, 0) @[FR.scala 27:58]
    aux[2] <= _aux_2_T_4 @[FR.scala 27:16]
    node _aux_3_T = bits(io.fork_mask, 3, 3) @[FR.scala 27:34]
    node _aux_3_T_1 = not(_aux_3_T) @[FR.scala 27:21]
    node _aux_3_T_2 = bits(io.ready_out, 3, 3) @[FR.scala 27:53]
    node _aux_3_T_3 = or(_aux_3_T_1, _aux_3_T_2) @[FR.scala 27:39]
    node _aux_3_T_4 = bits(_aux_3_T_3, 0, 0) @[FR.scala 27:58]
    aux[3] <= _aux_3_T_4 @[FR.scala 27:16]
    inst conf_mux of ConfMux_10 @[FR.scala 29:28]
    conf_mux.clock <= clock
    conf_mux.reset <= reset
    conf_mux.io.selector <= io.valid_mux_sel @[FR.scala 30:26]
    conf_mux.io.mux_input <= io.valid_in @[FR.scala 31:27]
    Vaux <= conf_mux.io.mux_output @[FR.scala 32:28]
    node _aux_4_T = bits(Vaux, 0, 0) @[FR.scala 34:34]
    aux[4] <= _aux_4_T @[FR.scala 34:27]
    temp[0] <= aux[0] @[FR.scala 35:13]
    node _temp_1_T = and(temp[0], aux[1]) @[FR.scala 38:30]
    temp[1] <= _temp_1_T @[FR.scala 38:17]
    node _temp_2_T = and(temp[1], aux[2]) @[FR.scala 38:30]
    temp[2] <= _temp_2_T @[FR.scala 38:17]
    node _temp_3_T = and(temp[2], aux[3]) @[FR.scala 38:30]
    temp[3] <= _temp_3_T @[FR.scala 38:17]
    node _temp_4_T = and(temp[3], aux[4]) @[FR.scala 38:30]
    temp[4] <= _temp_4_T @[FR.scala 38:17]
    io.valid_out <= temp[4] @[FR.scala 40:18]

  module ConfMux_11 :
    input clock : Clock
    input reset : Reset
    output io : { flip selector : UInt<3>, flip mux_input : UInt<192>, mux_output : UInt<32>}

    wire inputs : UInt<32>[6] @[ConfMux.scala 25:22]
    node _inputs_0_T = bits(io.mux_input, 31, 0) @[ConfMux.scala 27:34]
    inputs[0] <= _inputs_0_T @[ConfMux.scala 27:19]
    node _inputs_1_T = bits(io.mux_input, 63, 32) @[ConfMux.scala 27:34]
    inputs[1] <= _inputs_1_T @[ConfMux.scala 27:19]
    node _inputs_2_T = bits(io.mux_input, 95, 64) @[ConfMux.scala 27:34]
    inputs[2] <= _inputs_2_T @[ConfMux.scala 27:19]
    node _inputs_3_T = bits(io.mux_input, 127, 96) @[ConfMux.scala 27:34]
    inputs[3] <= _inputs_3_T @[ConfMux.scala 27:19]
    node _inputs_4_T = bits(io.mux_input, 159, 128) @[ConfMux.scala 27:34]
    inputs[4] <= _inputs_4_T @[ConfMux.scala 27:19]
    node _inputs_5_T = bits(io.mux_input, 191, 160) @[ConfMux.scala 27:34]
    inputs[5] <= _inputs_5_T @[ConfMux.scala 27:19]
    io.mux_output <= inputs[io.selector] @[ConfMux.scala 30:19]

  module RegEnable_12 :
    input clock : Clock
    input reset : Reset
    output io : { flip in : UInt<32>, flip en : UInt<1>, out : UInt<32>}

    reg reg : UInt, clock with :
      reset => (reset, UInt<1>("h0")) @[RegEnable.scala 11:22]
    when io.en : @[RegEnable.scala 12:17]
      reg <= io.in @[RegEnable.scala 13:13]
    io.out <= reg @[RegEnable.scala 15:12]

  module RegEnable_13 :
    input clock : Clock
    input reset : Reset
    output io : { flip in : UInt<32>, flip en : UInt<1>, out : UInt<32>}

    reg reg : UInt, clock with :
      reset => (reset, UInt<1>("h0")) @[RegEnable.scala 11:22]
    when io.en : @[RegEnable.scala 12:17]
      reg <= io.in @[RegEnable.scala 13:13]
    io.out <= reg @[RegEnable.scala 15:12]

  module RegEnable_14 :
    input clock : Clock
    input reset : Reset
    output io : { flip in : UInt<1>, flip en : UInt<1>, out : UInt<1>}

    reg reg : UInt, clock with :
      reset => (reset, UInt<1>("h0")) @[RegEnable.scala 11:22]
    when io.en : @[RegEnable.scala 12:17]
      reg <= io.in @[RegEnable.scala 13:13]
    io.out <= reg @[RegEnable.scala 15:12]

  module RegEnable_15 :
    input clock : Clock
    input reset : Reset
    output io : { flip in : UInt<1>, flip en : UInt<1>, out : UInt<1>}

    reg reg : UInt, clock with :
      reset => (reset, UInt<1>("h0")) @[RegEnable.scala 11:22]
    when io.en : @[RegEnable.scala 12:17]
      reg <= io.in @[RegEnable.scala 13:13]
    io.out <= reg @[RegEnable.scala 15:12]

  module D_SEB_1 :
    input clock : Clock
    input reset : Reset
    output io : { flip din : UInt<32>, flip din_v : UInt<1>, din_r : UInt<1>, dout : UInt<32>, dout_v : UInt<1>, flip dout_r : UInt<1>}

    inst main of RegEnable_12 @[D_SEB.scala 19:24]
    main.clock <= clock
    main.reset <= reset
    inst aux of RegEnable_13 @[D_SEB.scala 20:23]
    aux.clock <= clock
    aux.reset <= reset
    inst reg_1 of RegEnable_14 @[D_SEB.scala 21:25]
    reg_1.clock <= clock
    reg_1.reset <= reset
    inst reg_2 of RegEnable_15 @[D_SEB.scala 22:25]
    reg_2.clock <= clock
    reg_2.reset <= reset
    reg reg : UInt<1>, clock with :
      reset => (reset, UInt<1>("h0")) @[D_SEB.scala 24:22]
    wire S_EA_EM : UInt<1> @[D_SEB.scala 25:23]
    node _mux2_out_T = bits(reg, 0, 0) @[D_SEB.scala 28:28]
    node mux2_out = mux(_mux2_out_T, reg_1.io.out, reg_2.io.out) @[D_SEB.scala 28:23]
    node _reg_T = not(mux2_out) @[D_SEB.scala 29:32]
    node _reg_T_1 = or(io.dout_r, _reg_T) @[D_SEB.scala 29:29]
    reg <= _reg_T_1 @[D_SEB.scala 29:9]
    node _S_EA_EM_T = bits(reg, 0, 0) @[D_SEB.scala 30:20]
    S_EA_EM <= _S_EA_EM_T @[D_SEB.scala 30:13]
    node _io_dout_v_T = bits(mux2_out, 0, 0) @[D_SEB.scala 31:27]
    io.dout_v <= _io_dout_v_T @[D_SEB.scala 31:15]
    io.din_r <= S_EA_EM @[D_SEB.scala 34:14]
    main.io.in <= io.din @[D_SEB.scala 36:16]
    aux.io.in <= main.io.out @[D_SEB.scala 37:15]
    reg_1.io.in <= io.din_v @[D_SEB.scala 38:17]
    reg_2.io.in <= reg_1.io.out @[D_SEB.scala 39:17]
    main.io.en <= S_EA_EM @[D_SEB.scala 41:16]
    aux.io.en <= S_EA_EM @[D_SEB.scala 42:15]
    reg_1.io.en <= S_EA_EM @[D_SEB.scala 43:17]
    reg_2.io.en <= S_EA_EM @[D_SEB.scala 44:17]
    node _io_dout_T = mux(S_EA_EM, main.io.out, aux.io.out) @[D_SEB.scala 46:19]
    io.dout <= _io_dout_T @[D_SEB.scala 46:13]

  module Join :
    input clock : Clock
    input reset : Reset
    output io : { flip din_1 : UInt<32>, flip din_2 : UInt<32>, flip dout_r : UInt<1>, flip din_1_v : UInt<1>, flip din_2_v : UInt<1>, dout_v : UInt<1>, din_1_r : UInt<1>, din_2_r : UInt<1>, dout_1 : UInt<32>, dout_2 : UInt<32>}

    io.dout_1 <= io.din_1 @[Join.scala 23:15]
    io.dout_2 <= io.din_2 @[Join.scala 24:15]
    node _io_dout_v_T = and(io.din_1_v, io.din_2_v) @[Join.scala 26:29]
    io.dout_v <= _io_dout_v_T @[Join.scala 26:15]
    node _io_din_1_r_T = and(io.din_2_v, io.dout_r) @[Join.scala 28:30]
    io.din_1_r <= _io_din_1_r_T @[Join.scala 28:16]
    node _io_din_2_r_T = and(io.din_1_v, io.dout_r) @[Join.scala 29:30]
    io.din_2_r <= _io_din_2_r_T @[Join.scala 29:16]

  module ALU :
    input clock : Clock
    input reset : Reset
    output io : { flip din_1 : UInt<32>, flip din_2 : UInt<32>, flip op_config : UInt<4>, dout : UInt<32>}

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
            io.dout <= UInt<1>("h1") @[ALU.scala 40:15]
          else :
            node _T_4 = eq(io.op_config, UInt<3>("h4")) @[ALU.scala 42:29]
            when _T_4 : @[ALU.scala 42:38]
              node _io_dout_T_5 = dshr(io.din_1, io.din_2) @[ALU.scala 43:27]
              io.dout <= _io_dout_T_5 @[ALU.scala 43:15]
            else :
              node _T_5 = eq(io.op_config, UInt<3>("h5")) @[ALU.scala 45:29]
              when _T_5 : @[ALU.scala 45:38]
                node _io_dout_T_6 = and(io.din_1, io.din_2) @[ALU.scala 46:27]
                io.dout <= _io_dout_T_6 @[ALU.scala 46:15]
              else :
                node _T_6 = eq(io.op_config, UInt<3>("h6")) @[ALU.scala 48:29]
                when _T_6 : @[ALU.scala 48:37]
                  node _io_dout_T_7 = or(io.din_1, io.din_2) @[ALU.scala 49:27]
                  io.dout <= _io_dout_T_7 @[ALU.scala 49:15]
                else :
                  node _T_7 = eq(io.op_config, UInt<3>("h7")) @[ALU.scala 51:29]
                  when _T_7 : @[ALU.scala 51:38]
                    node _io_dout_T_8 = xor(io.din_1, io.din_2) @[ALU.scala 52:27]
                    io.dout <= _io_dout_T_8 @[ALU.scala 52:15]
                  else :
                    node _T_8 = eq(io.op_config, UInt<4>("h8")) @[ALU.scala 54:29]
                    when _T_8 : @[ALU.scala 54:38]
                      node _T_9 = leq(io.din_1, io.din_2) @[ALU.scala 55:22]
                      when _T_9 : @[ALU.scala 55:35]
                        io.dout <= io.din_1 @[ALU.scala 56:17]
                      else :
                        node _T_10 = gt(io.din_1, io.din_2) @[ALU.scala 58:26]
                        when _T_10 : @[ALU.scala 58:38]
                          io.dout <= io.din_2 @[ALU.scala 59:17]
                    else :
                      node _T_11 = eq(io.op_config, UInt<4>("h9")) @[ALU.scala 62:29]
                      when _T_11 : @[ALU.scala 62:38]
                        node _T_12 = geq(io.din_1, io.din_2) @[ALU.scala 63:22]
                        when _T_12 : @[ALU.scala 63:35]
                          io.dout <= io.din_1 @[ALU.scala 64:17]
                        else :
                          node _T_13 = lt(io.din_1, io.din_2) @[ALU.scala 66:26]
                          when _T_13 : @[ALU.scala 66:38]
                            io.dout <= io.din_2 @[ALU.scala 67:17]
                      else :
                        io.dout <= UInt<1>("h0") @[ALU.scala 71:15]

  module FU :
    input clock : Clock
    input reset : Reset
    output io : { flip din_1 : UInt<32>, flip din_2 : UInt<32>, flip din_v : UInt<1>, flip dout_r : UInt<1>, flip loop_source : UInt<2>, flip iterations_reset : UInt<16>, flip op_config : UInt<4>, din_r : UInt<1>, dout : UInt<32>, dout_v : UInt<1>}

    reg alu_din_1 : UInt<32>, clock with :
      reset => (reset, UInt<32>("h0")) @[FU.scala 38:28]
    reg alu_din_2 : UInt<32>, clock with :
      reset => (reset, UInt<32>("h0")) @[FU.scala 39:28]
    reg alu_dout : UInt<32>, clock with :
      reset => (reset, UInt<32>("h0")) @[FU.scala 40:27]
    reg dout_Reg : UInt<32>, clock with :
      reset => (reset, UInt<32>("h0")) @[FU.scala 41:27]
    reg count : UInt<16>, clock with :
      reset => (reset, UInt<16>("hffff")) @[FU.scala 45:24]
    reg loaded : UInt<1>, clock with :
      reset => (reset, UInt<1>("h0")) @[FU.scala 46:25]
    reg valid : UInt<1>, clock with :
      reset => (reset, UInt<1>("h0")) @[FU.scala 47:24]
    inst ALU of ALU @[FU.scala 49:22]
    ALU.clock <= clock
    ALU.reset <= reset
    ALU.io.din_1 <= alu_din_1 @[FU.scala 50:18]
    ALU.io.din_2 <= alu_din_2 @[FU.scala 51:18]
    alu_dout <= ALU.io.dout @[FU.scala 52:14]
    ALU.io.op_config <= io.op_config @[FU.scala 53:22]
    node _T = eq(io.loop_source, UInt<2>("h0")) @[FU.scala 56:26]
    when _T : @[FU.scala 56:39]
      alu_din_1 <= io.din_1 @[FU.scala 57:19]
      alu_din_2 <= io.din_2 @[FU.scala 58:19]
    else :
      node _T_1 = eq(io.loop_source, UInt<2>("h1")) @[FU.scala 60:31]
      when _T_1 : @[FU.scala 60:44]
        node _T_2 = eq(loaded, UInt<1>("h0")) @[FU.scala 61:22]
        when _T_2 : @[FU.scala 61:31]
          alu_din_1 <= io.din_1 @[FU.scala 62:23]
          alu_din_2 <= io.din_2 @[FU.scala 63:23]
        else :
          alu_din_1 <= dout_Reg @[FU.scala 66:23]
          alu_din_2 <= io.din_2 @[FU.scala 67:23]
      else :
        node _T_3 = eq(io.loop_source, UInt<2>("h2")) @[FU.scala 70:31]
        when _T_3 : @[FU.scala 70:44]
          node _T_4 = eq(loaded, UInt<1>("h0")) @[FU.scala 71:22]
          when _T_4 : @[FU.scala 71:31]
            alu_din_1 <= io.din_1 @[FU.scala 72:23]
            alu_din_2 <= io.din_2 @[FU.scala 73:23]
          else :
            alu_din_1 <= io.din_1 @[FU.scala 76:23]
            alu_din_2 <= dout_Reg @[FU.scala 77:23]
        else :
          alu_din_1 <= UInt<5>("h1f") @[FU.scala 81:19]
          alu_din_2 <= UInt<5>("h1f") @[FU.scala 82:19]
    node _T_5 = asUInt(reset) @[FU.scala 86:22]
    loaded <= UInt<1>("h0") @[FU.scala 87:16]
    count <= UInt<1>("h0") @[FU.scala 88:15]
    dout_Reg <= UInt<1>("h0") @[FU.scala 89:18]
    node _T_6 = leq(valid, UInt<1>("h0")) @[FU.scala 90:15]
    node _T_7 = eq(io.dout_r, UInt<1>("h1")) @[FU.scala 95:25]
    when _T_7 : @[FU.scala 95:34]
      valid <= UInt<1>("h0") @[FU.scala 96:19]
    node _T_8 = eq(io.din_v, UInt<1>("h1")) @[FU.scala 98:24]
    node _T_9 = eq(io.dout_r, UInt<1>("h1")) @[FU.scala 98:45]
    node _T_10 = and(_T_8, _T_9) @[FU.scala 98:32]
    node _T_11 = eq(io.loop_source, UInt<2>("h1")) @[FU.scala 99:30]
    node _T_12 = eq(io.loop_source, UInt<2>("h2")) @[FU.scala 99:60]
    node _T_13 = or(_T_11, _T_12) @[FU.scala 99:42]
    node _T_14 = and(_T_10, _T_13) @[FU.scala 98:53]
    when _T_14 : @[FU.scala 100:13]
      loaded <= UInt<1>("h1") @[FU.scala 101:20]
      node _count_T = add(count, UInt<1>("h1")) @[FU.scala 102:29]
      node _count_T_1 = tail(_count_T, 1) @[FU.scala 102:29]
      count <= _count_T_1 @[FU.scala 102:20]
    node _T_15 = eq(count, io.iterations_reset) @[FU.scala 104:21]
    node _T_16 = eq(io.loop_source, UInt<2>("h1")) @[FU.scala 105:30]
    node _T_17 = eq(io.loop_source, UInt<2>("h2")) @[FU.scala 105:60]
    node _T_18 = or(_T_16, _T_17) @[FU.scala 105:42]
    node _T_19 = and(_T_15, _T_18) @[FU.scala 104:45]
    node _T_20 = eq(io.dout_r, UInt<1>("h1")) @[FU.scala 106:25]
    node _T_21 = and(_T_19, _T_20) @[FU.scala 105:73]
    when _T_21 : @[FU.scala 107:13]
      count <= UInt<1>("h0") @[FU.scala 108:22]
      loaded <= UInt<1>("h0") @[FU.scala 109:22]
      valid <= UInt<1>("h1") @[FU.scala 110:22]
      dout_Reg <= alu_dout @[FU.scala 111:22]
    else :
      node _T_22 = eq(io.loop_source, UInt<2>("h1")) @[FU.scala 113:36]
      node _T_23 = eq(io.loop_source, UInt<2>("h2")) @[FU.scala 113:66]
      node _T_24 = or(_T_22, _T_23) @[FU.scala 113:48]
      node _T_25 = eq(io.din_v, UInt<1>("h1")) @[FU.scala 114:29]
      node _T_26 = and(_T_24, _T_25) @[FU.scala 113:79]
      node _T_27 = eq(io.dout_r, UInt<1>("h1")) @[FU.scala 115:30]
      node _T_28 = and(_T_26, _T_27) @[FU.scala 114:37]
      when _T_28 : @[FU.scala 116:13]
        dout_Reg <= alu_dout @[FU.scala 117:22]
    node _T_29 = eq(io.loop_source, UInt<2>("h0")) @[FU.scala 121:26]
    when _T_29 : @[FU.scala 121:38]
      io.dout_v <= io.din_v @[FU.scala 122:19]
    else :
      io.dout_v <= valid @[FU.scala 125:19]
    io.din_r <= io.dout_r @[FU.scala 128:14]
    node _T_30 = eq(io.loop_source, UInt<2>("h0")) @[FU.scala 130:26]
    when _T_30 : @[FU.scala 130:38]
      io.dout <= alu_dout @[FU.scala 131:17]
    else :
      io.dout <= dout_Reg @[FU.scala 134:17]

  module RegEnable_16 :
    input clock : Clock
    input reset : Reset
    output io : { flip in : UInt<32>, flip en : UInt<1>, out : UInt<32>}

    reg reg : UInt, clock with :
      reset => (reset, UInt<1>("h0")) @[RegEnable.scala 11:22]
    when io.en : @[RegEnable.scala 12:17]
      reg <= io.in @[RegEnable.scala 13:13]
    io.out <= reg @[RegEnable.scala 15:12]

  module RegEnable_17 :
    input clock : Clock
    input reset : Reset
    output io : { flip in : UInt<32>, flip en : UInt<1>, out : UInt<32>}

    reg reg : UInt, clock with :
      reset => (reset, UInt<1>("h0")) @[RegEnable.scala 11:22]
    when io.en : @[RegEnable.scala 12:17]
      reg <= io.in @[RegEnable.scala 13:13]
    io.out <= reg @[RegEnable.scala 15:12]

  module RegEnable_18 :
    input clock : Clock
    input reset : Reset
    output io : { flip in : UInt<1>, flip en : UInt<1>, out : UInt<1>}

    reg reg : UInt, clock with :
      reset => (reset, UInt<1>("h0")) @[RegEnable.scala 11:22]
    when io.en : @[RegEnable.scala 12:17]
      reg <= io.in @[RegEnable.scala 13:13]
    io.out <= reg @[RegEnable.scala 15:12]

  module RegEnable_19 :
    input clock : Clock
    input reset : Reset
    output io : { flip in : UInt<1>, flip en : UInt<1>, out : UInt<1>}

    reg reg : UInt, clock with :
      reset => (reset, UInt<1>("h0")) @[RegEnable.scala 11:22]
    when io.en : @[RegEnable.scala 12:17]
      reg <= io.in @[RegEnable.scala 13:13]
    io.out <= reg @[RegEnable.scala 15:12]

  module D_SEB_2 :
    input clock : Clock
    input reset : Reset
    output io : { flip din : UInt<32>, flip din_v : UInt<1>, din_r : UInt<1>, dout : UInt<32>, dout_v : UInt<1>, flip dout_r : UInt<1>}

    inst main of RegEnable_16 @[D_SEB.scala 19:24]
    main.clock <= clock
    main.reset <= reset
    inst aux of RegEnable_17 @[D_SEB.scala 20:23]
    aux.clock <= clock
    aux.reset <= reset
    inst reg_1 of RegEnable_18 @[D_SEB.scala 21:25]
    reg_1.clock <= clock
    reg_1.reset <= reset
    inst reg_2 of RegEnable_19 @[D_SEB.scala 22:25]
    reg_2.clock <= clock
    reg_2.reset <= reset
    reg reg : UInt<1>, clock with :
      reset => (reset, UInt<1>("h0")) @[D_SEB.scala 24:22]
    wire S_EA_EM : UInt<1> @[D_SEB.scala 25:23]
    node _mux2_out_T = bits(reg, 0, 0) @[D_SEB.scala 28:28]
    node mux2_out = mux(_mux2_out_T, reg_1.io.out, reg_2.io.out) @[D_SEB.scala 28:23]
    node _reg_T = not(mux2_out) @[D_SEB.scala 29:32]
    node _reg_T_1 = or(io.dout_r, _reg_T) @[D_SEB.scala 29:29]
    reg <= _reg_T_1 @[D_SEB.scala 29:9]
    node _S_EA_EM_T = bits(reg, 0, 0) @[D_SEB.scala 30:20]
    S_EA_EM <= _S_EA_EM_T @[D_SEB.scala 30:13]
    node _io_dout_v_T = bits(mux2_out, 0, 0) @[D_SEB.scala 31:27]
    io.dout_v <= _io_dout_v_T @[D_SEB.scala 31:15]
    io.din_r <= S_EA_EM @[D_SEB.scala 34:14]
    main.io.in <= io.din @[D_SEB.scala 36:16]
    aux.io.in <= main.io.out @[D_SEB.scala 37:15]
    reg_1.io.in <= io.din_v @[D_SEB.scala 38:17]
    reg_2.io.in <= reg_1.io.out @[D_SEB.scala 39:17]
    main.io.en <= S_EA_EM @[D_SEB.scala 41:16]
    aux.io.en <= S_EA_EM @[D_SEB.scala 42:15]
    reg_1.io.en <= S_EA_EM @[D_SEB.scala 43:17]
    reg_2.io.en <= S_EA_EM @[D_SEB.scala 44:17]
    node _io_dout_T = mux(S_EA_EM, main.io.out, aux.io.out) @[D_SEB.scala 46:19]
    io.dout <= _io_dout_T @[D_SEB.scala 46:13]

  module FS_4 :
    input clock : Clock
    input reset : Reset
    output io : { flip ready_out : UInt<5>, flip fork_mask : UInt<5>, ready_in : UInt<1>}

    wire aux : UInt<1>[5] @[FS.scala 20:19]
    wire temp : UInt<1>[5] @[FS.scala 21:20]
    node _aux_0_T = bits(io.fork_mask, 0, 0) @[FS.scala 24:34]
    node _aux_0_T_1 = not(_aux_0_T) @[FS.scala 24:21]
    node _aux_0_T_2 = bits(io.ready_out, 0, 0) @[FS.scala 24:53]
    node _aux_0_T_3 = or(_aux_0_T_1, _aux_0_T_2) @[FS.scala 24:39]
    node _aux_0_T_4 = bits(_aux_0_T_3, 0, 0) @[FS.scala 24:58]
    aux[0] <= _aux_0_T_4 @[FS.scala 24:16]
    node _aux_1_T = bits(io.fork_mask, 1, 1) @[FS.scala 24:34]
    node _aux_1_T_1 = not(_aux_1_T) @[FS.scala 24:21]
    node _aux_1_T_2 = bits(io.ready_out, 1, 1) @[FS.scala 24:53]
    node _aux_1_T_3 = or(_aux_1_T_1, _aux_1_T_2) @[FS.scala 24:39]
    node _aux_1_T_4 = bits(_aux_1_T_3, 0, 0) @[FS.scala 24:58]
    aux[1] <= _aux_1_T_4 @[FS.scala 24:16]
    node _aux_2_T = bits(io.fork_mask, 2, 2) @[FS.scala 24:34]
    node _aux_2_T_1 = not(_aux_2_T) @[FS.scala 24:21]
    node _aux_2_T_2 = bits(io.ready_out, 2, 2) @[FS.scala 24:53]
    node _aux_2_T_3 = or(_aux_2_T_1, _aux_2_T_2) @[FS.scala 24:39]
    node _aux_2_T_4 = bits(_aux_2_T_3, 0, 0) @[FS.scala 24:58]
    aux[2] <= _aux_2_T_4 @[FS.scala 24:16]
    node _aux_3_T = bits(io.fork_mask, 3, 3) @[FS.scala 24:34]
    node _aux_3_T_1 = not(_aux_3_T) @[FS.scala 24:21]
    node _aux_3_T_2 = bits(io.ready_out, 3, 3) @[FS.scala 24:53]
    node _aux_3_T_3 = or(_aux_3_T_1, _aux_3_T_2) @[FS.scala 24:39]
    node _aux_3_T_4 = bits(_aux_3_T_3, 0, 0) @[FS.scala 24:58]
    aux[3] <= _aux_3_T_4 @[FS.scala 24:16]
    node _aux_4_T = bits(io.fork_mask, 4, 4) @[FS.scala 24:34]
    node _aux_4_T_1 = not(_aux_4_T) @[FS.scala 24:21]
    node _aux_4_T_2 = bits(io.ready_out, 4, 4) @[FS.scala 24:53]
    node _aux_4_T_3 = or(_aux_4_T_1, _aux_4_T_2) @[FS.scala 24:39]
    node _aux_4_T_4 = bits(_aux_4_T_3, 0, 0) @[FS.scala 24:58]
    aux[4] <= _aux_4_T_4 @[FS.scala 24:16]
    temp[0] <= aux[0] @[FS.scala 27:13]
    node _temp_1_T = and(temp[0], aux[1]) @[FS.scala 30:30]
    temp[1] <= _temp_1_T @[FS.scala 30:17]
    node _temp_2_T = and(temp[1], aux[2]) @[FS.scala 30:30]
    temp[2] <= _temp_2_T @[FS.scala 30:17]
    node _temp_3_T = and(temp[2], aux[3]) @[FS.scala 30:30]
    temp[3] <= _temp_3_T @[FS.scala 30:17]
    node _temp_4_T = and(temp[3], aux[4]) @[FS.scala 30:30]
    temp[4] <= _temp_4_T @[FS.scala 30:17]
    io.ready_in <= temp[4] @[FS.scala 33:17]

  module CellProcessing :
    input clock : Clock
    input reset : Reset
    output io : { flip north_din : UInt<32>, flip north_din_v : UInt<1>, flip east_din : UInt<32>, flip east_din_v : UInt<1>, flip south_din : UInt<32>, flip south_din_v : UInt<1>, flip west_din : UInt<32>, flip west_din_v : UInt<1>, FU_din_1_r : UInt<1>, FU_din_2_r : UInt<1>, dout : UInt<32>, dout_v : UInt<1>, flip north_dout_r : UInt<1>, flip east_dout_r : UInt<1>, flip south_dout_r : UInt<1>, flip west_dout_r : UInt<1>, flip config_bits : UInt<182>}

    reg selector_mux_1 : UInt<3>, clock with :
      reset => (reset, UInt<3>("h0")) @[CellProcessing.scala 32:33]
    reg selector_mux_2 : UInt<3>, clock with :
      reset => (reset, UInt<3>("h0")) @[CellProcessing.scala 33:33]
    reg fork_receiver_mask_1 : UInt<4>, clock with :
      reset => (reset, UInt<4>("h0")) @[CellProcessing.scala 34:39]
    reg fork_receiver_mask_2 : UInt<4>, clock with :
      reset => (reset, UInt<4>("h0")) @[CellProcessing.scala 35:39]
    reg op_config : UInt<5>, clock with :
      reset => (reset, UInt<5>("h0")) @[CellProcessing.scala 36:28]
    reg fork_sender_mask : UInt<5>, clock with :
      reset => (reset, UInt<5>("h0")) @[CellProcessing.scala 37:35]
    reg I1_const : UInt<32>, clock with :
      reset => (reset, UInt<32>("h0")) @[CellProcessing.scala 38:27]
    reg initial_value_load : UInt<32>, clock with :
      reset => (reset, UInt<32>("h0")) @[CellProcessing.scala 39:37]
    reg iterations_reset_load : UInt<16>, clock with :
      reset => (reset, UInt<16>("h0")) @[CellProcessing.scala 40:40]
    reg fifo_length_load : UInt<16>, clock with :
      reset => (reset, UInt<16>("h0")) @[CellProcessing.scala 41:35]
    reg load_initial_value : UInt<2>, clock with :
      reset => (reset, UInt<2>("h0")) @[CellProcessing.scala 42:37]
    reg FU_dout : UInt<32>, clock with :
      reset => (reset, UInt<32>("h0")) @[CellProcessing.scala 45:26]
    reg EB_din_1 : UInt<32>, clock with :
      reset => (reset, UInt<32>("h0")) @[CellProcessing.scala 46:27]
    reg EB_din_2 : UInt<32>, clock with :
      reset => (reset, UInt<32>("h0")) @[CellProcessing.scala 47:27]
    reg join_din_1 : UInt<32>, clock with :
      reset => (reset, UInt<32>("h0")) @[CellProcessing.scala 48:29]
    reg join_din_2 : UInt<32>, clock with :
      reset => (reset, UInt<32>("h0")) @[CellProcessing.scala 49:29]
    reg join_dout_1 : UInt<32>, clock with :
      reset => (reset, UInt<32>("h0")) @[CellProcessing.scala 50:30]
    reg join_dout_2 : UInt<32>, clock with :
      reset => (reset, UInt<32>("h0")) @[CellProcessing.scala 51:30]
    wire FU_dout_v : UInt<1> @[CellProcessing.scala 53:25]
    wire FU_dout_r : UInt<1> @[CellProcessing.scala 54:25]
    wire EB_din_1_v : UInt<1> @[CellProcessing.scala 55:26]
    wire EB_din_2_v : UInt<1> @[CellProcessing.scala 56:26]
    wire join_din_1_v : UInt<1> @[CellProcessing.scala 57:28]
    wire join_din_1_r : UInt<1> @[CellProcessing.scala 58:28]
    wire join_din_2_v : UInt<1> @[CellProcessing.scala 59:28]
    wire join_din_2_r : UInt<1> @[CellProcessing.scala 60:28]
    wire join_dout_v : UInt<1> @[CellProcessing.scala 61:27]
    wire join_dout_r : UInt<1> @[CellProcessing.scala 62:27]
    wire forked_dout_r : UInt<1> @[CellProcessing.scala 63:29]
    node _selector_mux_1_T = bits(io.config_bits, 2, 0) @[CellProcessing.scala 66:37]
    selector_mux_1 <= _selector_mux_1_T @[CellProcessing.scala 66:20]
    node _selector_mux_2_T = bits(io.config_bits, 5, 3) @[CellProcessing.scala 67:37]
    selector_mux_2 <= _selector_mux_2_T @[CellProcessing.scala 67:20]
    node _fork_receiver_mask_1_T = bits(io.config_bits, 17, 14) @[CellProcessing.scala 68:43]
    fork_receiver_mask_1 <= _fork_receiver_mask_1_T @[CellProcessing.scala 68:26]
    node _fork_receiver_mask_2_T = bits(io.config_bits, 23, 20) @[CellProcessing.scala 70:43]
    fork_receiver_mask_2 <= _fork_receiver_mask_2_T @[CellProcessing.scala 70:26]
    node _op_config_T = bits(io.config_bits, 48, 44) @[CellProcessing.scala 72:32]
    op_config <= _op_config_T @[CellProcessing.scala 72:15]
    node _fork_sender_mask_T = bits(io.config_bits, 56, 52) @[CellProcessing.scala 74:39]
    fork_sender_mask <= _fork_sender_mask_T @[CellProcessing.scala 74:22]
    node _I1_const_T = bits(io.config_bits, 115, 84) @[CellProcessing.scala 76:32]
    I1_const <= _I1_const_T @[CellProcessing.scala 76:15]
    node _initial_value_load_T = bits(io.config_bits, 147, 116) @[CellProcessing.scala 77:41]
    initial_value_load <= _initial_value_load_T @[CellProcessing.scala 77:24]
    node _fifo_length_load_T = bits(io.config_bits, 163, 148) @[CellProcessing.scala 79:39]
    fifo_length_load <= _fifo_length_load_T @[CellProcessing.scala 79:22]
    node _iterations_reset_load_T = bits(io.config_bits, 179, 164) @[CellProcessing.scala 80:44]
    iterations_reset_load <= _iterations_reset_load_T @[CellProcessing.scala 80:27]
    node _load_initial_value_T = bits(io.config_bits, 181, 180) @[CellProcessing.scala 81:41]
    load_initial_value <= _load_initial_value_T @[CellProcessing.scala 81:24]
    inst FR_1 of FR_4 @[CellProcessing.scala 83:23]
    FR_1.clock <= clock
    FR_1.reset <= reset
    node ready_FR1_lo = cat(io.south_dout_r, io.west_dout_r) @[Cat.scala 31:58]
    node ready_FR1_hi = cat(io.north_dout_r, io.east_dout_r) @[Cat.scala 31:58]
    node ready_FR1 = cat(ready_FR1_hi, ready_FR1_lo) @[Cat.scala 31:58]
    node valid_in_FR1_lo_hi = cat(io.south_din_v, io.east_din_v) @[Cat.scala 31:58]
    node valid_in_FR1_lo = cat(valid_in_FR1_lo_hi, io.north_din_v) @[Cat.scala 31:58]
    node valid_in_FR1_hi_hi = cat(FU_dout_v, UInt<1>("h1")) @[Cat.scala 31:58]
    node valid_in_FR1_hi = cat(valid_in_FR1_hi_hi, io.west_din_v) @[Cat.scala 31:58]
    node valid_in_FR1 = cat(valid_in_FR1_hi, valid_in_FR1_lo) @[Cat.scala 31:58]
    FR_1.io.ready_out <= ready_FR1 @[CellProcessing.scala 86:23]
    FR_1.io.valid_in <= valid_in_FR1 @[CellProcessing.scala 87:22]
    FR_1.io.valid_mux_sel <= selector_mux_1 @[CellProcessing.scala 88:27]
    FR_1.io.fork_mask <= fork_receiver_mask_1 @[CellProcessing.scala 89:23]
    EB_din_1_v <= FR_1.io.valid_out @[CellProcessing.scala 90:16]
    inst MUX_1 of ConfMux_9 @[CellProcessing.scala 92:25]
    MUX_1.clock <= clock
    MUX_1.reset <= reset
    MUX_1.io.selector <= selector_mux_1 @[CellProcessing.scala 93:23]
    node _MUX_1_io_mux_input_T = and(FU_dout, I1_const) @[CellProcessing.scala 94:35]
    node _MUX_1_io_mux_input_T_1 = and(_MUX_1_io_mux_input_T, io.west_din) @[CellProcessing.scala 94:46]
    node _MUX_1_io_mux_input_T_2 = and(_MUX_1_io_mux_input_T_1, io.south_din) @[CellProcessing.scala 94:60]
    node _MUX_1_io_mux_input_T_3 = and(_MUX_1_io_mux_input_T_2, io.east_din) @[CellProcessing.scala 94:75]
    node _MUX_1_io_mux_input_T_4 = and(_MUX_1_io_mux_input_T_3, io.north_din) @[CellProcessing.scala 94:89]
    MUX_1.io.mux_input <= _MUX_1_io_mux_input_T_4 @[CellProcessing.scala 94:24]
    EB_din_1 <= MUX_1.io.mux_output @[CellProcessing.scala 95:14]
    inst SEB_1 of D_SEB @[CellProcessing.scala 97:24]
    SEB_1.clock <= clock
    SEB_1.reset <= reset
    SEB_1.io.din <= EB_din_1 @[CellProcessing.scala 98:18]
    SEB_1.io.din_v <= EB_din_1_v @[CellProcessing.scala 99:20]
    io.FU_din_1_r <= SEB_1.io.din_r @[CellProcessing.scala 100:20]
    join_din_1 <= SEB_1.io.dout @[CellProcessing.scala 101:16]
    join_din_1_v <= SEB_1.io.dout_v @[CellProcessing.scala 102:18]
    SEB_1.io.dout_r <= join_din_1_r @[CellProcessing.scala 103:21]
    inst FR_2 of FR_5 @[CellProcessing.scala 105:23]
    FR_2.clock <= clock
    FR_2.reset <= reset
    node ready_FR2_lo = cat(io.south_dout_r, io.west_dout_r) @[Cat.scala 31:58]
    node ready_FR2_hi = cat(io.north_dout_r, io.east_dout_r) @[Cat.scala 31:58]
    node ready_FR2 = cat(ready_FR2_hi, ready_FR2_lo) @[Cat.scala 31:58]
    node valid_in_FR2_lo_hi = cat(io.south_din_v, io.east_din_v) @[Cat.scala 31:58]
    node valid_in_FR2_lo = cat(valid_in_FR2_lo_hi, io.north_din_v) @[Cat.scala 31:58]
    node valid_in_FR2_hi_hi = cat(FU_dout_v, UInt<1>("h1")) @[Cat.scala 31:58]
    node valid_in_FR2_hi = cat(valid_in_FR2_hi_hi, io.west_din_v) @[Cat.scala 31:58]
    node valid_in_FR2 = cat(valid_in_FR2_hi, valid_in_FR2_lo) @[Cat.scala 31:58]
    FR_2.io.ready_out <= ready_FR1 @[CellProcessing.scala 108:23]
    FR_2.io.valid_in <= valid_in_FR1 @[CellProcessing.scala 109:22]
    FR_2.io.valid_mux_sel <= selector_mux_2 @[CellProcessing.scala 110:27]
    FR_2.io.fork_mask <= fork_receiver_mask_2 @[CellProcessing.scala 111:23]
    EB_din_2_v <= FR_2.io.valid_out @[CellProcessing.scala 112:16]
    inst MUX_2 of ConfMux_11 @[CellProcessing.scala 114:25]
    MUX_2.clock <= clock
    MUX_2.reset <= reset
    MUX_2.io.selector <= selector_mux_2 @[CellProcessing.scala 115:23]
    node _MUX_2_io_mux_input_T = and(FU_dout, I1_const) @[CellProcessing.scala 116:35]
    node _MUX_2_io_mux_input_T_1 = and(_MUX_2_io_mux_input_T, io.west_din) @[CellProcessing.scala 116:46]
    node _MUX_2_io_mux_input_T_2 = and(_MUX_2_io_mux_input_T_1, io.south_din) @[CellProcessing.scala 116:60]
    node _MUX_2_io_mux_input_T_3 = and(_MUX_2_io_mux_input_T_2, io.east_din) @[CellProcessing.scala 116:75]
    node _MUX_2_io_mux_input_T_4 = and(_MUX_2_io_mux_input_T_3, io.north_din) @[CellProcessing.scala 116:89]
    MUX_2.io.mux_input <= _MUX_2_io_mux_input_T_4 @[CellProcessing.scala 116:24]
    EB_din_2 <= MUX_2.io.mux_output @[CellProcessing.scala 117:14]
    inst SEB_2 of D_SEB_1 @[CellProcessing.scala 119:24]
    SEB_2.clock <= clock
    SEB_2.reset <= reset
    SEB_2.io.din <= EB_din_2 @[CellProcessing.scala 120:18]
    SEB_2.io.din_v <= EB_din_2_v @[CellProcessing.scala 121:20]
    io.FU_din_2_r <= SEB_2.io.din_r @[CellProcessing.scala 122:19]
    join_din_2 <= SEB_1.io.dout @[CellProcessing.scala 123:16]
    join_din_2_v <= SEB_1.io.dout_v @[CellProcessing.scala 124:18]
    SEB_2.io.dout_r <= join_din_2_r @[CellProcessing.scala 125:21]
    inst JOIN_INST of Join @[CellProcessing.scala 127:28]
    JOIN_INST.clock <= clock
    JOIN_INST.reset <= reset
    JOIN_INST.io.din_1 <= join_din_1 @[CellProcessing.scala 128:24]
    JOIN_INST.io.din_2 <= join_din_1_v @[CellProcessing.scala 129:24]
    JOIN_INST.io.dout_r <= join_dout_r @[CellProcessing.scala 130:25]
    JOIN_INST.io.din_1_v <= join_din_1_v @[CellProcessing.scala 131:26]
    JOIN_INST.io.din_2_v <= join_din_2_v @[CellProcessing.scala 132:26]
    join_dout_v <= JOIN_INST.io.dout_v @[CellProcessing.scala 134:17]
    join_din_1_r <= JOIN_INST.io.din_1_r @[CellProcessing.scala 135:18]
    join_din_2_r <= JOIN_INST.io.din_2_r @[CellProcessing.scala 136:18]
    join_dout_1 <= JOIN_INST.io.dout_1 @[CellProcessing.scala 137:17]
    join_dout_2 <= JOIN_INST.io.dout_2 @[CellProcessing.scala 138:17]
    inst FU_INST of FU @[CellProcessing.scala 140:26]
    FU_INST.clock <= clock
    FU_INST.reset <= reset
    FU_INST.io.din_1 <= join_dout_1 @[CellProcessing.scala 141:22]
    FU_INST.io.din_2 <= join_dout_2 @[CellProcessing.scala 142:22]
    FU_INST.io.din_v <= join_dout_v @[CellProcessing.scala 143:22]
    join_dout_r <= FU_INST.io.din_r @[CellProcessing.scala 144:17]
    FU_INST.io.loop_source <= load_initial_value @[CellProcessing.scala 145:28]
    FU_INST.io.iterations_reset <= iterations_reset_load @[CellProcessing.scala 146:33]
    FU_INST.io.op_config <= op_config @[CellProcessing.scala 147:26]
    FU_dout <= FU_INST.io.dout @[CellProcessing.scala 149:13]
    FU_dout_v <= FU_INST.io.dout_v @[CellProcessing.scala 150:15]
    FU_INST.io.dout_r <= FU_dout_r @[CellProcessing.scala 151:23]
    inst SEB_OUT of D_SEB_2 @[CellProcessing.scala 153:26]
    SEB_OUT.clock <= clock
    SEB_OUT.reset <= reset
    SEB_OUT.io.din <= FU_dout @[CellProcessing.scala 154:20]
    SEB_OUT.io.din_v <= FU_dout_v @[CellProcessing.scala 155:22]
    FU_dout_r <= SEB_OUT.io.din_r @[CellProcessing.scala 156:15]
    io.dout <= SEB_OUT.io.dout @[CellProcessing.scala 157:13]
    io.dout_v <= SEB_OUT.io.dout_v @[CellProcessing.scala 158:15]
    SEB_OUT.io.dout_r <= forked_dout_r @[CellProcessing.scala 159:23]
    inst FS of FS_4 @[CellProcessing.scala 161:21]
    FS.clock <= clock
    FS.reset <= reset
    node ready_out_FS_lo = cat(io.south_dout_r, io.west_dout_r) @[Cat.scala 31:58]
    node ready_out_FS_hi_hi = cat(UInt<1>("h1"), io.north_dout_r) @[Cat.scala 31:58]
    node ready_out_FS_hi = cat(ready_out_FS_hi_hi, io.east_dout_r) @[Cat.scala 31:58]
    node ready_out_FS = cat(ready_out_FS_hi, ready_out_FS_lo) @[Cat.scala 31:58]
    FS.io.ready_out <= ready_out_FS @[CellProcessing.scala 163:21]
    forked_dout_r <= FS.io.ready_in @[CellProcessing.scala 164:19]
    FS.io.fork_mask <= fork_sender_mask @[CellProcessing.scala 165:21]

  module ProcessingElement :
    input clock : Clock
    input reset : UInt<1>
    output io : { flip north_din : UInt<32>, flip north_din_v : UInt<1>, north_din_r : UInt<1>, flip east_din : UInt<32>, flip east_din_v : UInt<1>, east_din_r : UInt<1>, flip south_din : UInt<32>, flip south_din_v : UInt<1>, south_din_r : UInt<1>, flip west_din : UInt<32>, flip west_din_v : UInt<1>, west_din_r : UInt<1>, north_dout : UInt<32>, north_dout_v : UInt<1>, flip north_dout_r : UInt<1>, east_dout : UInt<32>, east_dout_v : UInt<1>, flip east_dout_r : UInt<1>, south_dout : UInt<32>, south_dout_v : UInt<1>, flip south_dout_r : UInt<1>, west_dout : UInt<32>, west_dout_v : UInt<1>, flip west_dout_r : UInt<1>, flip config_bits : UInt<182>, flip catch_config : UInt<1>}

    reg mux_N_sel : UInt<2>, clock with :
      reset => (reset, UInt<2>("h0")) @[ProcessingElement.scala 47:28]
    reg mux_E_sel : UInt<2>, clock with :
      reset => (reset, UInt<2>("h0")) @[ProcessingElement.scala 48:28]
    reg mux_S_sel : UInt<2>, clock with :
      reset => (reset, UInt<2>("h0")) @[ProcessingElement.scala 49:28]
    reg mux_W_sel : UInt<2>, clock with :
      reset => (reset, UInt<2>("h0")) @[ProcessingElement.scala 50:28]
    reg accept_mask_frN : UInt<5>, clock with :
      reset => (reset, UInt<5>("h0")) @[ProcessingElement.scala 51:34]
    reg accept_mask_frE : UInt<5>, clock with :
      reset => (reset, UInt<5>("h0")) @[ProcessingElement.scala 52:34]
    reg accept_mask_frS : UInt<5>, clock with :
      reset => (reset, UInt<5>("h0")) @[ProcessingElement.scala 53:34]
    reg accept_mask_frW : UInt<5>, clock with :
      reset => (reset, UInt<5>("h0")) @[ProcessingElement.scala 54:34]
    reg accept_mask_fsiN : UInt<5>, clock with :
      reset => (reset, UInt<5>("h0")) @[ProcessingElement.scala 55:35]
    reg accept_mask_fsiE : UInt<5>, clock with :
      reset => (reset, UInt<5>("h0")) @[ProcessingElement.scala 56:35]
    reg accept_mask_fsiS : UInt<5>, clock with :
      reset => (reset, UInt<5>("h0")) @[ProcessingElement.scala 57:35]
    reg accept_mask_fsiW : UInt<5>, clock with :
      reset => (reset, UInt<5>("h0")) @[ProcessingElement.scala 58:35]
    reg config_bits_reg : UInt<182>, clock with :
      reset => (reset, UInt<182>("h0")) @[ProcessingElement.scala 59:34]
    reg north_buffer : UInt<32>, clock with :
      reset => (reset, UInt<32>("h0")) @[ProcessingElement.scala 63:31]
    reg east_buffer : UInt<32>, clock with :
      reset => (reset, UInt<32>("h0")) @[ProcessingElement.scala 64:30]
    reg south_buffer : UInt<32>, clock with :
      reset => (reset, UInt<32>("h0")) @[ProcessingElement.scala 65:31]
    reg west_buffer : UInt<32>, clock with :
      reset => (reset, UInt<32>("h0")) @[ProcessingElement.scala 66:30]
    reg north_buffer_v : UInt<1>, clock with :
      reset => (reset, UInt<1>("h0")) @[ProcessingElement.scala 68:33]
    reg east_buffer_v : UInt<1>, clock with :
      reset => (reset, UInt<1>("h0")) @[ProcessingElement.scala 69:32]
    reg south_buffer_v : UInt<1>, clock with :
      reset => (reset, UInt<1>("h0")) @[ProcessingElement.scala 70:33]
    reg west_buffer_v : UInt<1>, clock with :
      reset => (reset, UInt<1>("h0")) @[ProcessingElement.scala 71:32]
    reg north_buffer_r : UInt<1>, clock with :
      reset => (reset, UInt<1>("h0")) @[ProcessingElement.scala 73:33]
    reg east_buffer_r : UInt<1>, clock with :
      reset => (reset, UInt<1>("h0")) @[ProcessingElement.scala 74:32]
    reg south_buffer_r : UInt<1>, clock with :
      reset => (reset, UInt<1>("h0")) @[ProcessingElement.scala 75:33]
    reg west_buffer_r : UInt<1>, clock with :
      reset => (reset, UInt<1>("h0")) @[ProcessingElement.scala 76:32]
    reg north_REG_din : UInt<32>, clock with :
      reset => (reset, UInt<32>("h0")) @[ProcessingElement.scala 78:32]
    reg east_REG_din : UInt<32>, clock with :
      reset => (reset, UInt<32>("h0")) @[ProcessingElement.scala 79:31]
    reg south_REG_din : UInt<32>, clock with :
      reset => (reset, UInt<32>("h0")) @[ProcessingElement.scala 80:32]
    reg west_REG_din : UInt<32>, clock with :
      reset => (reset, UInt<32>("h0")) @[ProcessingElement.scala 81:31]
    reg north_REG_din_v : UInt<1>, clock with :
      reset => (reset, UInt<1>("h0")) @[ProcessingElement.scala 83:34]
    reg east_REG_din_v : UInt<1>, clock with :
      reset => (reset, UInt<1>("h0")) @[ProcessingElement.scala 84:33]
    reg south_REG_din_v : UInt<1>, clock with :
      reset => (reset, UInt<1>("h0")) @[ProcessingElement.scala 85:34]
    reg west_REG_din_v : UInt<1>, clock with :
      reset => (reset, UInt<1>("h0")) @[ProcessingElement.scala 86:33]
    reg north_REG_din_r : UInt<1>, clock with :
      reset => (reset, UInt<1>("h0")) @[ProcessingElement.scala 87:34]
    reg east_REG_din_r : UInt<1>, clock with :
      reset => (reset, UInt<1>("h0")) @[ProcessingElement.scala 88:33]
    reg south_REG_din_r : UInt<1>, clock with :
      reset => (reset, UInt<1>("h0")) @[ProcessingElement.scala 89:34]
    reg west_REG_din_r : UInt<1>, clock with :
      reset => (reset, UInt<1>("h0")) @[ProcessingElement.scala 90:33]
    reg FU_din_1_r : UInt<1>, clock with :
      reset => (reset, UInt<1>("h0")) @[ProcessingElement.scala 92:29]
    reg FU_din_2_r : UInt<1>, clock with :
      reset => (reset, UInt<1>("h0")) @[ProcessingElement.scala 93:29]
    reg FU_dout : UInt<32>, clock with :
      reset => (reset, UInt<32>("h0")) @[ProcessingElement.scala 94:26]
    reg FU_dout_v : UInt<1>, clock with :
      reset => (reset, UInt<1>("h0")) @[ProcessingElement.scala 95:28]
    reg FU_dout_r : UInt<1>, clock with :
      reset => (reset, UInt<1>("h0")) @[ProcessingElement.scala 96:28]
    when io.catch_config : @[ProcessingElement.scala 98:28]
      config_bits_reg <= io.config_bits @[ProcessingElement.scala 99:25]
    node _mux_N_sel_T = bits(config_bits_reg, 7, 6) @[ProcessingElement.scala 103:33]
    mux_N_sel <= _mux_N_sel_T @[ProcessingElement.scala 103:15]
    node _mux_E_sel_T = bits(config_bits_reg, 9, 8) @[ProcessingElement.scala 104:33]
    mux_E_sel <= _mux_E_sel_T @[ProcessingElement.scala 104:15]
    node _mux_S_sel_T = bits(config_bits_reg, 11, 10) @[ProcessingElement.scala 105:33]
    mux_S_sel <= _mux_S_sel_T @[ProcessingElement.scala 105:15]
    node _mux_W_sel_T = bits(config_bits_reg, 13, 12) @[ProcessingElement.scala 106:33]
    mux_W_sel <= _mux_W_sel_T @[ProcessingElement.scala 106:15]
    node _accept_mask_fsiN_T = bits(config_bits_reg, 28, 24) @[ProcessingElement.scala 108:40]
    accept_mask_fsiN <= _accept_mask_fsiN_T @[ProcessingElement.scala 108:22]
    node _accept_mask_fsiE_T = bits(config_bits_reg, 33, 29) @[ProcessingElement.scala 109:40]
    accept_mask_fsiE <= _accept_mask_fsiE_T @[ProcessingElement.scala 109:22]
    node _accept_mask_fsiS_T = bits(config_bits_reg, 38, 34) @[ProcessingElement.scala 110:40]
    accept_mask_fsiS <= _accept_mask_fsiS_T @[ProcessingElement.scala 110:22]
    node _accept_mask_fsiW_T = bits(config_bits_reg, 43, 39) @[ProcessingElement.scala 111:40]
    accept_mask_fsiW <= _accept_mask_fsiW_T @[ProcessingElement.scala 111:22]
    node _accept_mask_frN_T = bits(config_bits_reg, 61, 57) @[ProcessingElement.scala 113:39]
    accept_mask_frN <= _accept_mask_frN_T @[ProcessingElement.scala 113:21]
    node _accept_mask_frE_T = bits(config_bits_reg, 66, 62) @[ProcessingElement.scala 114:39]
    accept_mask_frE <= _accept_mask_frE_T @[ProcessingElement.scala 114:21]
    node _accept_mask_frS_T = bits(config_bits_reg, 71, 67) @[ProcessingElement.scala 115:39]
    accept_mask_frS <= _accept_mask_frS_T @[ProcessingElement.scala 115:21]
    node _accept_mask_frW_T = bits(config_bits_reg, 76, 72) @[ProcessingElement.scala 116:39]
    accept_mask_frW <= _accept_mask_frW_T @[ProcessingElement.scala 116:21]
    inst FIFO_Nin of D_FIFO @[ProcessingElement.scala 120:27]
    FIFO_Nin.clock <= clock
    FIFO_Nin.reset <= reset
    FIFO_Nin.io.din <= io.north_din @[ProcessingElement.scala 121:21]
    FIFO_Nin.io.din_v <= io.north_din_v @[ProcessingElement.scala 122:23]
    FIFO_Nin.io.dout_r <= north_buffer_r @[ProcessingElement.scala 123:24]
    io.north_din_r <= FIFO_Nin.io.din_r @[ProcessingElement.scala 124:20]
    north_buffer <= FIFO_Nin.io.dout @[ProcessingElement.scala 125:18]
    north_buffer_v <= FIFO_Nin.io.dout_v @[ProcessingElement.scala 126:20]
    inst FS_Nin of FS @[ProcessingElement.scala 128:25]
    FS_Nin.clock <= clock
    FS_Nin.reset <= reset
    node ready_out_FS_Nin_lo = cat(south_REG_din_r, west_REG_din_r) @[Cat.scala 31:58]
    node ready_out_FS_Nin_hi_hi = cat(FU_din_1_r, FU_din_2_r) @[Cat.scala 31:58]
    node ready_out_FS_Nin_hi = cat(ready_out_FS_Nin_hi_hi, east_REG_din_r) @[Cat.scala 31:58]
    node ready_out_FS_Nin = cat(ready_out_FS_Nin_hi, ready_out_FS_Nin_lo) @[Cat.scala 31:58]
    FS_Nin.io.ready_out <= ready_out_FS_Nin @[ProcessingElement.scala 130:25]
    north_buffer_r <= FS_Nin.io.ready_in @[ProcessingElement.scala 131:20]
    FS_Nin.io.fork_mask <= accept_mask_fsiN @[ProcessingElement.scala 132:25]
    inst MUX_Nout of ConfMux @[ProcessingElement.scala 134:28]
    MUX_Nout.clock <= clock
    MUX_Nout.reset <= reset
    MUX_Nout.io.selector <= mux_N_sel @[ProcessingElement.scala 135:26]
    node _MUX_Nout_io_mux_input_T = and(west_buffer, south_buffer) @[ProcessingElement.scala 136:42]
    node _MUX_Nout_io_mux_input_T_1 = and(_MUX_Nout_io_mux_input_T, east_buffer) @[ProcessingElement.scala 136:57]
    node _MUX_Nout_io_mux_input_T_2 = and(_MUX_Nout_io_mux_input_T_1, FU_dout) @[ProcessingElement.scala 136:71]
    MUX_Nout.io.mux_input <= _MUX_Nout_io_mux_input_T_2 @[ProcessingElement.scala 136:27]
    north_REG_din <= MUX_Nout.io.mux_output @[ProcessingElement.scala 137:19]
    inst FR_Nout of FR @[ProcessingElement.scala 139:26]
    FR_Nout.clock <= clock
    FR_Nout.reset <= reset
    node ready_FR_Nout_lo = cat(south_REG_din_r, west_REG_din_r) @[Cat.scala 31:58]
    node ready_FR_Nout_hi_hi = cat(FU_din_1_r, FU_din_2_r) @[Cat.scala 31:58]
    node ready_FR_Nout_hi = cat(ready_FR_Nout_hi_hi, east_REG_din_r) @[Cat.scala 31:58]
    node ready_FR_Nout = cat(ready_FR_Nout_hi, ready_FR_Nout_lo) @[Cat.scala 31:58]
    node valid_in_FR_Nout_lo = cat(east_buffer_v, FU_dout_v) @[Cat.scala 31:58]
    node valid_in_FR_Nout_hi = cat(west_buffer_v, south_buffer_v) @[Cat.scala 31:58]
    node valid_in_FR_Nout = cat(valid_in_FR_Nout_hi, valid_in_FR_Nout_lo) @[Cat.scala 31:58]
    FR_Nout.io.ready_out <= ready_FR_Nout @[ProcessingElement.scala 142:26]
    FR_Nout.io.valid_in <= valid_in_FR_Nout @[ProcessingElement.scala 143:25]
    FR_Nout.io.valid_mux_sel <= mux_N_sel @[ProcessingElement.scala 144:30]
    FR_Nout.io.fork_mask <= accept_mask_frN @[ProcessingElement.scala 145:26]
    north_REG_din_v <= FR_Nout.io.valid_out @[ProcessingElement.scala 146:21]
    inst REG_Nout of D_REG @[ProcessingElement.scala 148:27]
    REG_Nout.clock <= clock
    REG_Nout.reset <= reset
    REG_Nout.io.din <= north_REG_din @[ProcessingElement.scala 150:21]
    REG_Nout.io.din_v <= north_REG_din_v @[ProcessingElement.scala 151:23]
    REG_Nout.io.dout_r <= io.north_dout_r @[ProcessingElement.scala 152:24]
    north_REG_din_r <= REG_Nout.io.din_r @[ProcessingElement.scala 154:21]
    io.north_dout <= REG_Nout.io.dout @[ProcessingElement.scala 155:19]
    io.north_dout_v <= REG_Nout.io.dout_v @[ProcessingElement.scala 156:21]
    inst FIFO_Ein of D_FIFO_1 @[ProcessingElement.scala 162:27]
    FIFO_Ein.clock <= clock
    FIFO_Ein.reset <= reset
    FIFO_Ein.io.din <= io.east_din @[ProcessingElement.scala 163:21]
    FIFO_Ein.io.din_v <= io.east_din_v @[ProcessingElement.scala 164:23]
    FIFO_Ein.io.dout_r <= east_buffer_r @[ProcessingElement.scala 165:24]
    io.east_din_r <= FIFO_Ein.io.din_r @[ProcessingElement.scala 166:19]
    east_buffer <= FIFO_Ein.io.dout @[ProcessingElement.scala 167:17]
    east_buffer_v <= FIFO_Ein.io.dout_v @[ProcessingElement.scala 168:19]
    inst FS_Ein of FS_1 @[ProcessingElement.scala 170:25]
    FS_Ein.clock <= clock
    FS_Ein.reset <= reset
    node ready_out_FS_Ein_lo = cat(south_REG_din_r, west_REG_din_r) @[Cat.scala 31:58]
    node ready_out_FS_Ein_hi_hi = cat(FU_din_1_r, FU_din_2_r) @[Cat.scala 31:58]
    node ready_out_FS_Ein_hi = cat(ready_out_FS_Ein_hi_hi, north_REG_din_r) @[Cat.scala 31:58]
    node ready_out_FS_Ein = cat(ready_out_FS_Ein_hi, ready_out_FS_Ein_lo) @[Cat.scala 31:58]
    FS_Ein.io.ready_out <= ready_out_FS_Ein @[ProcessingElement.scala 172:25]
    east_buffer_r <= FS_Ein.io.ready_in @[ProcessingElement.scala 173:19]
    FS_Ein.io.fork_mask <= accept_mask_fsiE @[ProcessingElement.scala 174:25]
    inst MUX_Eout of ConfMux_2 @[ProcessingElement.scala 176:28]
    MUX_Eout.clock <= clock
    MUX_Eout.reset <= reset
    MUX_Eout.io.selector <= mux_E_sel @[ProcessingElement.scala 177:26]
    node _MUX_Eout_io_mux_input_T = and(west_buffer, south_buffer) @[ProcessingElement.scala 178:42]
    node _MUX_Eout_io_mux_input_T_1 = and(_MUX_Eout_io_mux_input_T, north_buffer) @[ProcessingElement.scala 178:57]
    node _MUX_Eout_io_mux_input_T_2 = and(_MUX_Eout_io_mux_input_T_1, FU_dout) @[ProcessingElement.scala 178:72]
    MUX_Eout.io.mux_input <= _MUX_Eout_io_mux_input_T_2 @[ProcessingElement.scala 178:27]
    east_REG_din <= MUX_Eout.io.mux_output @[ProcessingElement.scala 179:18]
    inst FR_Eout of FR_1 @[ProcessingElement.scala 181:26]
    FR_Eout.clock <= clock
    FR_Eout.reset <= reset
    node ready_FR_Eout_lo = cat(south_REG_din_r, west_REG_din_r) @[Cat.scala 31:58]
    node ready_FR_Eout_hi_hi = cat(FU_din_1_r, FU_din_2_r) @[Cat.scala 31:58]
    node ready_FR_Eout_hi = cat(ready_FR_Eout_hi_hi, north_REG_din_r) @[Cat.scala 31:58]
    node ready_FR_Eout = cat(ready_FR_Eout_hi, ready_FR_Eout_lo) @[Cat.scala 31:58]
    node valid_in_FR_Eout_lo = cat(north_buffer_v, FU_dout_v) @[Cat.scala 31:58]
    node valid_in_FR_Eout_hi = cat(west_buffer_v, south_buffer_v) @[Cat.scala 31:58]
    node valid_in_FR_Eout = cat(valid_in_FR_Eout_hi, valid_in_FR_Eout_lo) @[Cat.scala 31:58]
    FR_Eout.io.ready_out <= ready_FR_Eout @[ProcessingElement.scala 184:26]
    FR_Eout.io.valid_in <= valid_in_FR_Eout @[ProcessingElement.scala 185:25]
    FR_Eout.io.valid_mux_sel <= mux_E_sel @[ProcessingElement.scala 186:30]
    FR_Eout.io.fork_mask <= accept_mask_frE @[ProcessingElement.scala 187:26]
    east_REG_din_v <= FR_Eout.io.valid_out @[ProcessingElement.scala 188:20]
    inst REG_Eout of D_REG_1 @[ProcessingElement.scala 190:27]
    REG_Eout.clock <= clock
    REG_Eout.reset <= reset
    REG_Eout.io.din <= east_REG_din @[ProcessingElement.scala 192:21]
    REG_Eout.io.din_v <= east_REG_din_v @[ProcessingElement.scala 193:23]
    REG_Eout.io.dout_r <= io.east_dout_r @[ProcessingElement.scala 194:24]
    east_REG_din_r <= REG_Eout.io.din_r @[ProcessingElement.scala 196:20]
    io.east_dout <= REG_Eout.io.dout @[ProcessingElement.scala 197:18]
    io.east_dout_v <= REG_Eout.io.dout_v @[ProcessingElement.scala 198:20]
    inst FIFO_Sin of D_FIFO_2 @[ProcessingElement.scala 203:27]
    FIFO_Sin.clock <= clock
    FIFO_Sin.reset <= reset
    FIFO_Sin.io.din <= io.south_din @[ProcessingElement.scala 204:21]
    FIFO_Sin.io.din_v <= io.south_din_v @[ProcessingElement.scala 205:23]
    FIFO_Sin.io.dout_r <= south_buffer_r @[ProcessingElement.scala 206:24]
    io.south_din_r <= FIFO_Sin.io.din_r @[ProcessingElement.scala 207:20]
    south_buffer <= FIFO_Sin.io.dout @[ProcessingElement.scala 208:18]
    south_buffer_v <= FIFO_Sin.io.dout_v @[ProcessingElement.scala 209:20]
    inst FS_Sin of FS_2 @[ProcessingElement.scala 211:25]
    FS_Sin.clock <= clock
    FS_Sin.reset <= reset
    node ready_out_FS_Sin_lo = cat(east_REG_din_r, west_REG_din_r) @[Cat.scala 31:58]
    node ready_out_FS_Sin_hi_hi = cat(FU_din_1_r, FU_din_2_r) @[Cat.scala 31:58]
    node ready_out_FS_Sin_hi = cat(ready_out_FS_Sin_hi_hi, north_REG_din_r) @[Cat.scala 31:58]
    node ready_out_FS_Sin = cat(ready_out_FS_Sin_hi, ready_out_FS_Sin_lo) @[Cat.scala 31:58]
    FS_Sin.io.ready_out <= ready_out_FS_Sin @[ProcessingElement.scala 213:25]
    south_buffer_r <= FS_Sin.io.ready_in @[ProcessingElement.scala 214:20]
    FS_Sin.io.fork_mask <= accept_mask_fsiS @[ProcessingElement.scala 215:25]
    inst MUX_Sout of ConfMux_4 @[ProcessingElement.scala 217:28]
    MUX_Sout.clock <= clock
    MUX_Sout.reset <= reset
    MUX_Sout.io.selector <= mux_S_sel @[ProcessingElement.scala 218:26]
    node _MUX_Sout_io_mux_input_T = and(west_buffer, east_buffer) @[ProcessingElement.scala 219:42]
    node _MUX_Sout_io_mux_input_T_1 = and(_MUX_Sout_io_mux_input_T, north_buffer) @[ProcessingElement.scala 219:56]
    node _MUX_Sout_io_mux_input_T_2 = and(_MUX_Sout_io_mux_input_T_1, FU_dout) @[ProcessingElement.scala 219:71]
    MUX_Sout.io.mux_input <= _MUX_Sout_io_mux_input_T_2 @[ProcessingElement.scala 219:27]
    south_REG_din <= MUX_Sout.io.mux_output @[ProcessingElement.scala 220:19]
    inst FR_Sout of FR_2 @[ProcessingElement.scala 222:26]
    FR_Sout.clock <= clock
    FR_Sout.reset <= reset
    node ready_FR_Sout_lo = cat(east_REG_din_r, west_REG_din_r) @[Cat.scala 31:58]
    node ready_FR_Sout_hi_hi = cat(FU_din_1_r, FU_din_2_r) @[Cat.scala 31:58]
    node ready_FR_Sout_hi = cat(ready_FR_Sout_hi_hi, north_REG_din_r) @[Cat.scala 31:58]
    node ready_FR_Sout = cat(ready_FR_Sout_hi, ready_FR_Sout_lo) @[Cat.scala 31:58]
    node valid_in_FR_Sout_lo = cat(north_buffer_v, FU_dout_v) @[Cat.scala 31:58]
    node valid_in_FR_Sout_hi = cat(west_buffer_v, east_buffer_v) @[Cat.scala 31:58]
    node valid_in_FR_Sout = cat(valid_in_FR_Sout_hi, valid_in_FR_Sout_lo) @[Cat.scala 31:58]
    FR_Sout.io.ready_out <= ready_FR_Sout @[ProcessingElement.scala 225:26]
    FR_Sout.io.valid_in <= valid_in_FR_Sout @[ProcessingElement.scala 226:25]
    FR_Sout.io.valid_mux_sel <= mux_S_sel @[ProcessingElement.scala 227:30]
    FR_Sout.io.fork_mask <= accept_mask_frS @[ProcessingElement.scala 228:26]
    south_REG_din_v <= FR_Sout.io.valid_out @[ProcessingElement.scala 229:21]
    inst REG_Sout of D_REG_2 @[ProcessingElement.scala 231:27]
    REG_Sout.clock <= clock
    REG_Sout.reset <= reset
    REG_Sout.io.din <= south_REG_din @[ProcessingElement.scala 233:21]
    REG_Sout.io.din_v <= south_REG_din_v @[ProcessingElement.scala 234:23]
    REG_Sout.io.dout_r <= io.south_dout_r @[ProcessingElement.scala 235:24]
    south_REG_din_r <= REG_Sout.io.din_r @[ProcessingElement.scala 237:21]
    io.south_dout <= REG_Sout.io.dout @[ProcessingElement.scala 238:19]
    io.south_dout_v <= REG_Sout.io.dout_v @[ProcessingElement.scala 239:21]
    inst FIFO_Win of D_FIFO_3 @[ProcessingElement.scala 244:27]
    FIFO_Win.clock <= clock
    FIFO_Win.reset <= reset
    FIFO_Win.io.din <= io.west_din @[ProcessingElement.scala 245:21]
    FIFO_Win.io.din_v <= io.west_din_v @[ProcessingElement.scala 246:23]
    FIFO_Win.io.dout_r <= west_buffer_r @[ProcessingElement.scala 247:24]
    io.west_din_r <= FIFO_Win.io.din_r @[ProcessingElement.scala 248:19]
    west_buffer <= FIFO_Win.io.dout @[ProcessingElement.scala 249:17]
    west_buffer_v <= FIFO_Win.io.dout_v @[ProcessingElement.scala 250:19]
    inst FS_Win of FS_3 @[ProcessingElement.scala 252:25]
    FS_Win.clock <= clock
    FS_Win.reset <= reset
    node ready_out_FS_Win_lo = cat(east_REG_din_r, south_REG_din_r) @[Cat.scala 31:58]
    node ready_out_FS_Win_hi_hi = cat(FU_din_1_r, FU_din_2_r) @[Cat.scala 31:58]
    node ready_out_FS_Win_hi = cat(ready_out_FS_Win_hi_hi, north_REG_din_r) @[Cat.scala 31:58]
    node ready_out_FS_Win = cat(ready_out_FS_Win_hi, ready_out_FS_Win_lo) @[Cat.scala 31:58]
    FS_Win.io.ready_out <= ready_out_FS_Win @[ProcessingElement.scala 254:25]
    west_buffer_r <= FS_Win.io.ready_in @[ProcessingElement.scala 255:19]
    FS_Win.io.fork_mask <= accept_mask_fsiW @[ProcessingElement.scala 256:25]
    inst MUX_Wout of ConfMux_6 @[ProcessingElement.scala 258:28]
    MUX_Wout.clock <= clock
    MUX_Wout.reset <= reset
    MUX_Wout.io.selector <= mux_W_sel @[ProcessingElement.scala 259:26]
    node _MUX_Wout_io_mux_input_T = and(south_buffer, east_buffer) @[ProcessingElement.scala 260:43]
    node _MUX_Wout_io_mux_input_T_1 = and(_MUX_Wout_io_mux_input_T, north_buffer) @[ProcessingElement.scala 260:57]
    node _MUX_Wout_io_mux_input_T_2 = and(_MUX_Wout_io_mux_input_T_1, FU_dout) @[ProcessingElement.scala 260:72]
    MUX_Wout.io.mux_input <= _MUX_Wout_io_mux_input_T_2 @[ProcessingElement.scala 260:27]
    west_REG_din <= MUX_Wout.io.mux_output @[ProcessingElement.scala 261:18]
    inst FR_Wout of FR_3 @[ProcessingElement.scala 263:26]
    FR_Wout.clock <= clock
    FR_Wout.reset <= reset
    node ready_FR_Wout_lo = cat(east_REG_din_r, south_REG_din_r) @[Cat.scala 31:58]
    node ready_FR_Wout_hi_hi = cat(FU_din_1_r, FU_din_2_r) @[Cat.scala 31:58]
    node ready_FR_Wout_hi = cat(ready_FR_Wout_hi_hi, north_REG_din_r) @[Cat.scala 31:58]
    node ready_FR_Wout = cat(ready_FR_Wout_hi, ready_FR_Wout_lo) @[Cat.scala 31:58]
    node valid_in_FR_Wout_lo = cat(north_buffer_v, FU_dout_v) @[Cat.scala 31:58]
    node valid_in_FR_Wout_hi = cat(south_buffer_v, east_buffer_v) @[Cat.scala 31:58]
    node valid_in_FR_Wout = cat(valid_in_FR_Wout_hi, valid_in_FR_Wout_lo) @[Cat.scala 31:58]
    FR_Wout.io.ready_out <= ready_FR_Wout @[ProcessingElement.scala 266:26]
    FR_Wout.io.valid_in <= valid_in_FR_Wout @[ProcessingElement.scala 267:25]
    FR_Wout.io.valid_mux_sel <= mux_W_sel @[ProcessingElement.scala 268:30]
    FR_Wout.io.fork_mask <= accept_mask_frW @[ProcessingElement.scala 269:26]
    west_REG_din_v <= FR_Wout.io.valid_out @[ProcessingElement.scala 270:20]
    inst REG_Wout of D_REG_3 @[ProcessingElement.scala 272:27]
    REG_Wout.clock <= clock
    REG_Wout.reset <= reset
    REG_Wout.io.din <= west_REG_din @[ProcessingElement.scala 274:21]
    REG_Wout.io.din_v <= west_REG_din_v @[ProcessingElement.scala 275:23]
    REG_Wout.io.dout_r <= io.west_dout_r @[ProcessingElement.scala 276:24]
    west_REG_din_r <= REG_Wout.io.din_r @[ProcessingElement.scala 278:20]
    io.west_dout <= REG_Wout.io.dout @[ProcessingElement.scala 279:18]
    io.west_dout_v <= REG_Wout.io.dout_v @[ProcessingElement.scala 280:20]
    inst CELL of CellProcessing @[ProcessingElement.scala 284:23]
    CELL.clock <= clock
    CELL.reset <= reset
    CELL.io.north_din <= north_buffer @[ProcessingElement.scala 285:23]
    CELL.io.north_din_v <= north_buffer_v @[ProcessingElement.scala 286:25]
    CELL.io.east_din <= east_buffer @[ProcessingElement.scala 287:22]
    CELL.io.east_din_v <= east_buffer_v @[ProcessingElement.scala 288:24]
    CELL.io.south_din <= south_buffer @[ProcessingElement.scala 289:23]
    CELL.io.south_din_v <= south_buffer_v @[ProcessingElement.scala 290:25]
    CELL.io.west_din <= west_buffer @[ProcessingElement.scala 291:22]
    CELL.io.west_din_v <= west_buffer_v @[ProcessingElement.scala 292:24]
    CELL.io.north_dout_r <= north_REG_din_r @[ProcessingElement.scala 293:26]
    CELL.io.east_dout_r <= east_REG_din_r @[ProcessingElement.scala 294:25]
    CELL.io.south_dout_r <= south_REG_din_r @[ProcessingElement.scala 295:26]
    CELL.io.west_dout_r <= west_REG_din_r @[ProcessingElement.scala 296:25]
    CELL.io.config_bits <= config_bits_reg @[ProcessingElement.scala 297:25]
    FU_din_1_r <= CELL.io.FU_din_1_r @[ProcessingElement.scala 299:16]
    FU_din_2_r <= CELL.io.FU_din_2_r @[ProcessingElement.scala 300:16]
    FU_dout <= CELL.io.dout @[ProcessingElement.scala 301:13]
    FU_dout_v <= CELL.io.dout_v @[ProcessingElement.scala 302:15]

