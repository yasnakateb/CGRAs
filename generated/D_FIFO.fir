circuit D_FIFO :
  module D_FIFO :
    input clock : Clock
    input reset : UInt<1>
    output io : { flip din : UInt<32>, flip din_v : UInt<1>, flip dout_r : UInt<1>, din_r : UInt<1>, dout : UInt<32>, dout_v : UInt<1>}

    cmem memory : UInt<32> [32] @[D_FIFO.scala 55:21]
    reg write_pointer : UInt<32>, clock with :
      reset => (reset, UInt<32>("h0")) @[D_FIFO.scala 57:32]
    reg read_pointer : UInt<32>, clock with :
      reset => (reset, UInt<32>("h0")) @[D_FIFO.scala 58:31]
    reg num_data : UInt<32>, clock with :
      reset => (reset, UInt<32>("h0")) @[D_FIFO.scala 59:27]
    reg full : UInt, clock with :
      reset => (reset, UInt<1>("h0")) @[D_FIFO.scala 61:23]
    reg empty : UInt, clock with :
      reset => (reset, UInt<1>("h0")) @[D_FIFO.scala 62:24]
    wire rd_en : UInt<1> @[D_FIFO.scala 63:21]
    wire wr_en : UInt<1> @[D_FIFO.scala 64:21]
    reg dout_v : UInt, clock with :
      reset => (reset, UInt<1>("h0")) @[D_FIFO.scala 66:25]
    reg dout : UInt<32>, clock with :
      reset => (reset, UInt<32>("h0")) @[D_FIFO.scala 67:23]
    empty <= UInt<1>("h1") @[D_FIFO.scala 69:11]
    full <= UInt<1>("h0") @[D_FIFO.scala 70:10]
    dout <= UInt<1>("h0") @[D_FIFO.scala 71:10]
    dout_v <= UInt<1>("h0") @[D_FIFO.scala 72:12]
    node _wr_en_T = not(full) @[D_FIFO.scala 74:26]
    node _wr_en_T_1 = and(io.din_v, _wr_en_T) @[D_FIFO.scala 74:23]
    wr_en <= _wr_en_T_1 @[D_FIFO.scala 74:11]
    node _rd_en_T = not(empty) @[D_FIFO.scala 75:27]
    node _rd_en_T_1 = and(io.dout_r, _rd_en_T) @[D_FIFO.scala 75:24]
    rd_en <= _rd_en_T_1 @[D_FIFO.scala 75:11]
    node _io_din_r_T = not(full) @[D_FIFO.scala 77:18]
    io.din_r <= _io_din_r_T @[D_FIFO.scala 77:14]
    when io.dout_r : @[D_FIFO.scala 80:22]
      dout_v <= UInt<1>("h0") @[D_FIFO.scala 81:16]
    node _T = eq(full, UInt<1>("h0")) @[D_FIFO.scala 84:15]
    node _T_1 = eq(wr_en, UInt<1>("h1")) @[D_FIFO.scala 84:37]
    node _T_2 = and(_T, _T_1) @[D_FIFO.scala 84:28]
    when _T_2 : @[D_FIFO.scala 84:48]
      node _T_3 = bits(write_pointer, 4, 0) @[D_FIFO.scala 85:15]
      infer mport MPORT = memory[_T_3], clock @[D_FIFO.scala 85:15]
      MPORT <= io.din @[D_FIFO.scala 85:31]
      node _num_data_T = add(num_data, UInt<1>("h1")) @[D_FIFO.scala 86:30]
      node _num_data_T_1 = tail(_num_data_T, 1) @[D_FIFO.scala 86:30]
      num_data <= _num_data_T_1 @[D_FIFO.scala 86:18]
      node _T_4 = sub(UInt<6>("h20"), UInt<1>("h1")) @[D_FIFO.scala 88:46]
      node _T_5 = tail(_T_4, 1) @[D_FIFO.scala 88:46]
      node _T_6 = eq(write_pointer, _T_5) @[D_FIFO.scala 88:29]
      when _T_6 : @[D_FIFO.scala 88:54]
        write_pointer <= UInt<1>("h0") @[D_FIFO.scala 89:27]
      else :
        node _write_pointer_T = add(write_pointer, UInt<1>("h1")) @[D_FIFO.scala 91:44]
        node _write_pointer_T_1 = tail(_write_pointer_T, 1) @[D_FIFO.scala 91:44]
        write_pointer <= _write_pointer_T_1 @[D_FIFO.scala 91:27]
    node _T_7 = eq(empty, UInt<1>("h0")) @[D_FIFO.scala 96:16]
    node _T_8 = eq(rd_en, UInt<1>("h1")) @[D_FIFO.scala 96:38]
    node _T_9 = and(_T_7, _T_8) @[D_FIFO.scala 96:29]
    when _T_9 : @[D_FIFO.scala 96:49]
      node _dout_T = bits(read_pointer, 4, 0) @[D_FIFO.scala 97:23]
      infer mport dout_MPORT = memory[_dout_T], clock @[D_FIFO.scala 97:23]
      dout <= dout_MPORT @[D_FIFO.scala 97:14]
      dout_v <= UInt<1>("h1") @[D_FIFO.scala 98:16]
      node _num_data_T_2 = sub(num_data, UInt<1>("h1")) @[D_FIFO.scala 99:30]
      node _num_data_T_3 = tail(_num_data_T_2, 1) @[D_FIFO.scala 99:30]
      num_data <= _num_data_T_3 @[D_FIFO.scala 99:18]
      node _T_10 = sub(UInt<6>("h20"), UInt<1>("h1")) @[D_FIFO.scala 101:45]
      node _T_11 = tail(_T_10, 1) @[D_FIFO.scala 101:45]
      node _T_12 = eq(read_pointer, _T_11) @[D_FIFO.scala 101:28]
      when _T_12 : @[D_FIFO.scala 101:53]
        read_pointer <= UInt<1>("h0") @[D_FIFO.scala 102:26]
      else :
        node _read_pointer_T = add(read_pointer, UInt<1>("h1")) @[D_FIFO.scala 104:42]
        node _read_pointer_T_1 = tail(_read_pointer_T, 1) @[D_FIFO.scala 104:42]
        read_pointer <= _read_pointer_T_1 @[D_FIFO.scala 104:26]
    node _T_13 = eq(num_data, UInt<6>("h20")) @[D_FIFO.scala 108:20]
    when _T_13 : @[D_FIFO.scala 108:39]
      full <= UInt<1>("h1") @[D_FIFO.scala 109:14]
    else :
      full <= UInt<1>("h0") @[D_FIFO.scala 111:14]
    node _T_14 = eq(num_data, UInt<1>("h0")) @[D_FIFO.scala 114:20]
    when _T_14 : @[D_FIFO.scala 114:30]
      empty <= UInt<1>("h1") @[D_FIFO.scala 115:15]
    else :
      empty <= UInt<1>("h0") @[D_FIFO.scala 117:15]
    io.dout_v <= dout_v @[D_FIFO.scala 120:15]
    io.dout <= dout @[D_FIFO.scala 121:13]

