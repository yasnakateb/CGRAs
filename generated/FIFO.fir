circuit FIFO :
  module FIFO :
    input clock : Clock
    input reset : UInt<1>
    output io : { flip clk : Clock, flip reset : UInt<1>, flip din : UInt<32>, flip din_v : UInt<1>, din_r : UInt<1>, dout : UInt<32>, dout_v : UInt<1>, flip dout_r : UInt<1>}

    cmem memory : UInt<32> [32] @[FIFO.scala 20:19]
    reg write_pointer : UInt<5>, clock with :
      reset => (reset, UInt<5>("h0")) @[FIFO.scala 21:30]
    reg read_pointer : UInt<5>, clock with :
      reset => (reset, UInt<5>("h0")) @[FIFO.scala 22:29]
    reg num_data : UInt<6>, clock with :
      reset => (reset, UInt<6>("h0")) @[FIFO.scala 23:25]
    node empty = eq(num_data, UInt<1>("h0")) @[FIFO.scala 25:24]
    node full = eq(num_data, UInt<6>("h20")) @[FIFO.scala 26:23]
    node _io_din_r_T = eq(full, UInt<1>("h0")) @[FIFO.scala 28:15]
    io.din_r <= _io_din_r_T @[FIFO.scala 28:12]
    infer mport io_dout_MPORT = memory[read_pointer], clock @[FIFO.scala 29:20]
    io.dout <= io_dout_MPORT @[FIFO.scala 29:11]
    node _io_dout_v_T = eq(empty, UInt<1>("h0")) @[FIFO.scala 30:16]
    io.dout_v <= _io_dout_v_T @[FIFO.scala 30:13]
    node _T = eq(io.reset, UInt<1>("h0")) @[FIFO.scala 32:17]
    when _T : @[FIFO.scala 32:34]
      num_data <= UInt<1>("h0") @[FIFO.scala 33:14]
      write_pointer <= UInt<1>("h0") @[FIFO.scala 34:19]
      read_pointer <= UInt<1>("h0") @[FIFO.scala 35:18]
      io.dout_v <= UInt<1>("h0") @[FIFO.scala 36:15]
    else :
      when io.dout_r : @[FIFO.scala 39:21]
        io.dout_v <= UInt<1>("h0") @[FIFO.scala 40:17]
      node _T_1 = eq(full, UInt<1>("h0")) @[FIFO.scala 43:10]
      node _T_2 = and(_T_1, io.din_v) @[FIFO.scala 43:16]
      when _T_2 : @[FIFO.scala 43:29]
        infer mport MPORT = memory[write_pointer], clock @[FIFO.scala 44:13]
        MPORT <= io.din @[FIFO.scala 44:29]
        node _num_data_T = add(num_data, UInt<1>("h1")) @[FIFO.scala 45:28]
        node _num_data_T_1 = tail(_num_data_T, 1) @[FIFO.scala 45:28]
        num_data <= _num_data_T_1 @[FIFO.scala 45:16]
        node _write_pointer_T = eq(write_pointer, UInt<5>("h1f")) @[FIFO.scala 46:42]
        node _write_pointer_T_1 = add(write_pointer, UInt<1>("h1")) @[FIFO.scala 46:87]
        node _write_pointer_T_2 = tail(_write_pointer_T_1, 1) @[FIFO.scala 46:87]
        node _write_pointer_T_3 = mux(_write_pointer_T, UInt<1>("h0"), _write_pointer_T_2) @[FIFO.scala 46:27]
        write_pointer <= _write_pointer_T_3 @[FIFO.scala 46:21]
      node _T_3 = eq(empty, UInt<1>("h0")) @[FIFO.scala 49:23]
      node _T_4 = and(io.dout_r, _T_3) @[FIFO.scala 49:20]
      when _T_4 : @[FIFO.scala 49:31]
        node _num_data_T_2 = sub(num_data, UInt<1>("h1")) @[FIFO.scala 50:28]
        node _num_data_T_3 = tail(_num_data_T_2, 1) @[FIFO.scala 50:28]
        num_data <= _num_data_T_3 @[FIFO.scala 50:16]
        node _read_pointer_T = eq(read_pointer, UInt<5>("h1f")) @[FIFO.scala 51:40]
        node _read_pointer_T_1 = add(read_pointer, UInt<1>("h1")) @[FIFO.scala 51:84]
        node _read_pointer_T_2 = tail(_read_pointer_T_1, 1) @[FIFO.scala 51:84]
        node _read_pointer_T_3 = mux(_read_pointer_T, UInt<1>("h0"), _read_pointer_T_2) @[FIFO.scala 51:26]
        read_pointer <= _read_pointer_T_3 @[FIFO.scala 51:20]

