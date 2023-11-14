circuit D_FIFO_V3 :
  module D_FIFO_V3 :
    input clock : Clock
    input reset : UInt<1>
    output io : { flip din : UInt<32>, flip din_v : UInt<1>, flip dout_r : UInt<1>, din_r : UInt<1>, dout : UInt<32>, dout_v : UInt<1>}

    smem mem : UInt<32> [32] @[D_FIFO_V3.scala 56:26]
    reg readPtr : UInt<5>, clock with :
      reset => (reset, UInt<5>("h0")) @[D_FIFO_V3.scala 59:26]
    reg writePtr : UInt<5>, clock with :
      reset => (reset, UInt<5>("h0")) @[D_FIFO_V3.scala 60:27]
    when io.din_v : @[D_FIFO_V3.scala 63:20]
      write mport MPORT = mem[writePtr], clock
      MPORT <= io.din
      node _writePtr_T = eq(writePtr, UInt<5>("h1f")) @[D_FIFO_V3.scala 65:34]
      node _writePtr_T_1 = add(writePtr, UInt<1>("h1")) @[D_FIFO_V3.scala 65:72]
      node _writePtr_T_2 = tail(_writePtr_T_1, 1) @[D_FIFO_V3.scala 65:72]
      node _writePtr_T_3 = mux(_writePtr_T, UInt<1>("h0"), _writePtr_T_2) @[D_FIFO_V3.scala 65:24]
      writePtr <= _writePtr_T_3 @[D_FIFO_V3.scala 65:18]
    wire _io_dout_WIRE : UInt @[D_FIFO_V3.scala 69:24]
    _io_dout_WIRE is invalid @[D_FIFO_V3.scala 69:24]
    when io.dout_r : @[D_FIFO_V3.scala 69:24]
      _io_dout_WIRE <= readPtr @[D_FIFO_V3.scala 69:24]
      node _io_dout_T = or(_io_dout_WIRE, UInt<5>("h0")) @[D_FIFO_V3.scala 69:24]
      node _io_dout_T_1 = bits(_io_dout_T, 4, 0) @[D_FIFO_V3.scala 69:24]
      read mport io_dout_MPORT = mem[_io_dout_T_1], clock @[D_FIFO_V3.scala 69:24]
    io.dout <= io_dout_MPORT @[D_FIFO_V3.scala 69:13]
    node _io_din_r_T = eq(readPtr, writePtr) @[D_FIFO_V3.scala 70:25]
    node _io_din_r_T_1 = eq(io.din_v, UInt<1>("h0")) @[D_FIFO_V3.scala 70:41]
    node _io_din_r_T_2 = and(_io_din_r_T, _io_din_r_T_1) @[D_FIFO_V3.scala 70:38]
    io.din_r <= _io_din_r_T_2 @[D_FIFO_V3.scala 70:14]
    node _T = and(io.dout_r, io.dout_v) @[D_FIFO_V3.scala 73:20]
    when _T : @[D_FIFO_V3.scala 73:34]
      node _readPtr_T = eq(readPtr, UInt<5>("h1f")) @[D_FIFO_V3.scala 74:32]
      node _readPtr_T_1 = add(readPtr, UInt<1>("h1")) @[D_FIFO_V3.scala 74:69]
      node _readPtr_T_2 = tail(_readPtr_T_1, 1) @[D_FIFO_V3.scala 74:69]
      node _readPtr_T_3 = mux(_readPtr_T, UInt<1>("h0"), _readPtr_T_2) @[D_FIFO_V3.scala 74:23]
      readPtr <= _readPtr_T_3 @[D_FIFO_V3.scala 74:17]
    io.dout_v <= io.dout_r @[D_FIFO_V3.scala 78:15]

