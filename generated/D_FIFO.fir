circuit D_FIFO :
  module D_FIFO :
    input clock : Clock
    input reset : UInt<1>
    output io : { flip din : UInt<32>, flip din_v : UInt<1>, flip dout_r : UInt<1>, din_r : UInt<1>, dout : UInt<32>, dout_v : UInt<1>}

    smem memory : UInt<32> [4] @[D_FIFO.scala 23:29]
    reg write_pointer : UInt<4>, clock with :
      reset => (reset, UInt<4>("h0")) @[D_FIFO.scala 25:36]
    reg read_pointer : UInt<4>, clock with :
      reset => (reset, UInt<4>("h0")) @[D_FIFO.scala 26:31]
    reg num_data : UInt<4>, clock with :
      reset => (reset, UInt<4>("h0")) @[D_FIFO.scala 27:27]
    wire full : UInt<1> @[D_FIFO.scala 30:20]
    wire empty : UInt<1> @[D_FIFO.scala 31:21]
    wire rd_en : UInt<1> @[D_FIFO.scala 32:21]
    wire wr_en : UInt<1> @[D_FIFO.scala 33:21]
    empty <= UInt<1>("h1") @[D_FIFO.scala 35:11]
    full <= UInt<1>("h0") @[D_FIFO.scala 36:14]
    write_pointer <= UInt<1>("h0") @[D_FIFO.scala 37:23]
    read_pointer <= UInt<1>("h0") @[D_FIFO.scala 38:18]
    num_data <= UInt<1>("h0") @[D_FIFO.scala 39:18]
    io.dout <= UInt<1>("h0") @[D_FIFO.scala 40:13]
    io.dout_v <= UInt<1>("h0") @[D_FIFO.scala 41:19]
    when io.dout_r : @[D_FIFO.scala 43:22]
      io.dout_v <= UInt<1>("h0") @[D_FIFO.scala 44:19]
    node _T = eq(full, UInt<1>("h0")) @[D_FIFO.scala 47:16]
    node _T_1 = eq(wr_en, UInt<1>("h1")) @[D_FIFO.scala 47:38]
    node _T_2 = and(_T, _T_1) @[D_FIFO.scala 47:29]
    when _T_2 : @[D_FIFO.scala 47:50]
      node _T_3 = bits(write_pointer, 1, 0) @[D_FIFO.scala 48:15]
      infer mport MPORT = memory[_T_3], clock @[D_FIFO.scala 48:15]
      MPORT <= io.din @[D_FIFO.scala 48:31]
      node _num_data_T = add(num_data, UInt<1>("h1")) @[D_FIFO.scala 49:30]
      node _num_data_T_1 = tail(_num_data_T, 1) @[D_FIFO.scala 49:30]
      num_data <= _num_data_T_1 @[D_FIFO.scala 49:18]
      node _T_4 = sub(UInt<3>("h4"), UInt<1>("h1")) @[D_FIFO.scala 51:46]
      node _T_5 = tail(_T_4, 1) @[D_FIFO.scala 51:46]
      node _T_6 = eq(write_pointer, _T_5) @[D_FIFO.scala 51:29]
      when _T_6 : @[D_FIFO.scala 51:54]
        write_pointer <= UInt<1>("h0") @[D_FIFO.scala 52:27]
      else :
        node _write_pointer_T = add(write_pointer, UInt<1>("h1")) @[D_FIFO.scala 54:44]
        node _write_pointer_T_1 = tail(_write_pointer_T, 1) @[D_FIFO.scala 54:44]
        write_pointer <= _write_pointer_T_1 @[D_FIFO.scala 54:27]
    node _T_7 = eq(empty, UInt<1>("h0")) @[D_FIFO.scala 58:17]
    node _T_8 = eq(rd_en, UInt<1>("h1")) @[D_FIFO.scala 58:39]
    node _T_9 = and(_T_7, _T_8) @[D_FIFO.scala 58:30]
    when _T_9 : @[D_FIFO.scala 58:51]
      node _io_dout_T = bits(read_pointer, 1, 0) @[D_FIFO.scala 59:26]
      infer mport io_dout_MPORT = memory[_io_dout_T], clock @[D_FIFO.scala 59:26]
      io.dout <= io_dout_MPORT @[D_FIFO.scala 59:17]
      io.dout_v <= UInt<1>("h1") @[D_FIFO.scala 60:19]
      node _num_data_T_2 = sub(num_data, UInt<1>("h1")) @[D_FIFO.scala 61:30]
      node _num_data_T_3 = tail(_num_data_T_2, 1) @[D_FIFO.scala 61:30]
      num_data <= _num_data_T_3 @[D_FIFO.scala 61:18]
      node _T_10 = sub(UInt<3>("h4"), UInt<1>("h1")) @[D_FIFO.scala 63:45]
      node _T_11 = tail(_T_10, 1) @[D_FIFO.scala 63:45]
      node _T_12 = eq(read_pointer, _T_11) @[D_FIFO.scala 63:28]
      when _T_12 : @[D_FIFO.scala 63:53]
        read_pointer <= UInt<1>("h0") @[D_FIFO.scala 64:26]
      else :
        node _read_pointer_T = add(read_pointer, UInt<1>("h1")) @[D_FIFO.scala 66:42]
        node _read_pointer_T_1 = tail(_read_pointer_T, 1) @[D_FIFO.scala 66:42]
        read_pointer <= _read_pointer_T_1 @[D_FIFO.scala 66:26]
    node _T_13 = eq(num_data, UInt<3>("h4")) @[D_FIFO.scala 70:20]
    when _T_13 : @[D_FIFO.scala 70:39]
      full <= UInt<1>("h1") @[D_FIFO.scala 71:14]
    else :
      full <= UInt<1>("h0") @[D_FIFO.scala 73:14]
    node _T_14 = eq(num_data, UInt<1>("h0")) @[D_FIFO.scala 76:20]
    when _T_14 : @[D_FIFO.scala 76:30]
      empty <= UInt<1>("h1") @[D_FIFO.scala 77:15]
    else :
      empty <= UInt<1>("h0") @[D_FIFO.scala 79:15]
    node _wr_en_T = not(full) @[D_FIFO.scala 82:26]
    node _wr_en_T_1 = and(io.din_v, _wr_en_T) @[D_FIFO.scala 82:23]
    wr_en <= _wr_en_T_1 @[D_FIFO.scala 82:11]
    node _rd_en_T = not(empty) @[D_FIFO.scala 83:31]
    node _rd_en_T_1 = and(io.dout_r, _rd_en_T) @[D_FIFO.scala 83:28]
    rd_en <= _rd_en_T_1 @[D_FIFO.scala 83:15]
    node _io_din_r_T = not(full) @[D_FIFO.scala 84:22]
    io.din_r <= _io_din_r_T @[D_FIFO.scala 84:18]

