circuit FIFO :
  module FIFO :
    input clock : Clock
    input reset : UInt<1>
    output io : { flip din : UInt<32>, flip wen : UInt<1>, full : UInt<1>, dout : UInt<32>, flip ren : UInt<1>, empty : UInt<1>}

    reg cntWrite : UInt<5>, clock with :
      reset => (reset, UInt<5>("h0")) @[FIFO.scala 14:25]
    reg cntRead : UInt<5>, clock with :
      reset => (reset, UInt<5>("h0")) @[FIFO.scala 15:24]
    reg cntData : UInt<6>, clock with :
      reset => (reset, UInt<6>("h0")) @[FIFO.scala 16:24]
    smem mem : UInt<32> [32] @[FIFO.scala 18:24]
    node _T = not(io.full) @[FIFO.scala 21:17]
    node _T_1 = and(io.wen, _T) @[FIFO.scala 21:15]
    when _T_1 : @[FIFO.scala 21:27]
      node _T_2 = sub(UInt<6>("h20"), UInt<1>("h1")) @[FIFO.scala 22:31]
      node _T_3 = tail(_T_2, 1) @[FIFO.scala 22:31]
      node _T_4 = eq(cntWrite, _T_3) @[FIFO.scala 22:19]
      when _T_4 : @[FIFO.scala 22:38]
        cntWrite <= UInt<1>("h0") @[FIFO.scala 23:16]
      else :
        node _cntWrite_T = add(cntWrite, UInt<1>("h1")) @[FIFO.scala 25:28]
        node _cntWrite_T_1 = tail(_cntWrite_T, 1) @[FIFO.scala 25:28]
        cntWrite <= _cntWrite_T_1 @[FIFO.scala 25:16]
    node _T_5 = not(io.empty) @[FIFO.scala 30:17]
    node _T_6 = and(io.ren, _T_5) @[FIFO.scala 30:15]
    when _T_6 : @[FIFO.scala 30:28]
      node _T_7 = sub(UInt<6>("h20"), UInt<1>("h1")) @[FIFO.scala 31:30]
      node _T_8 = tail(_T_7, 1) @[FIFO.scala 31:30]
      node _T_9 = eq(cntRead, _T_8) @[FIFO.scala 31:18]
      when _T_9 : @[FIFO.scala 31:37]
        cntRead <= UInt<1>("h0") @[FIFO.scala 32:15]
      else :
        node _cntRead_T = add(cntRead, UInt<1>("h1")) @[FIFO.scala 34:26]
        node _cntRead_T_1 = tail(_cntRead_T, 1) @[FIFO.scala 34:26]
        cntRead <= _cntRead_T_1 @[FIFO.scala 34:15]
    node _T_10 = not(io.full) @[FIFO.scala 39:18]
    node _T_11 = and(io.wen, _T_10) @[FIFO.scala 39:16]
    node _T_12 = not(io.empty) @[FIFO.scala 39:41]
    node _T_13 = and(io.ren, _T_12) @[FIFO.scala 39:39]
    node _T_14 = not(_T_13) @[FIFO.scala 39:30]
    node _T_15 = and(_T_11, _T_14) @[FIFO.scala 39:28]
    when _T_15 : @[FIFO.scala 39:53]
      node _cntData_T = add(cntData, UInt<1>("h1")) @[FIFO.scala 40:24]
      node _cntData_T_1 = tail(_cntData_T, 1) @[FIFO.scala 40:24]
      cntData <= _cntData_T_1 @[FIFO.scala 40:13]
    else :
      node _T_16 = not(io.full) @[FIFO.scala 41:25]
      node _T_17 = and(io.wen, _T_16) @[FIFO.scala 41:23]
      node _T_18 = not(_T_17) @[FIFO.scala 41:14]
      node _T_19 = not(io.empty) @[FIFO.scala 41:47]
      node _T_20 = and(io.ren, _T_19) @[FIFO.scala 41:45]
      node _T_21 = and(_T_18, _T_20) @[FIFO.scala 41:35]
      when _T_21 : @[FIFO.scala 41:59]
        node _cntData_T_2 = sub(cntData, UInt<1>("h1")) @[FIFO.scala 42:24]
        node _cntData_T_3 = tail(_cntData_T_2, 1) @[FIFO.scala 42:24]
        cntData <= _cntData_T_3 @[FIFO.scala 42:13]
    node _T_22 = not(io.full) @[FIFO.scala 46:17]
    node _T_23 = and(io.wen, _T_22) @[FIFO.scala 46:15]
    when _T_23 : @[FIFO.scala 46:27]
      write mport MPORT = mem[cntWrite], clock
      MPORT <= io.din
    wire _io_dout_WIRE : UInt @[FIFO.scala 49:22]
    _io_dout_WIRE is invalid @[FIFO.scala 49:22]
    when UInt<1>("h1") : @[FIFO.scala 49:22]
      _io_dout_WIRE <= cntRead @[FIFO.scala 49:22]
      node _io_dout_T = or(_io_dout_WIRE, UInt<5>("h0")) @[FIFO.scala 49:22]
      node _io_dout_T_1 = bits(_io_dout_T, 4, 0) @[FIFO.scala 49:22]
      read mport io_dout_MPORT = mem[_io_dout_T_1], clock @[FIFO.scala 49:22]
    io.dout <= io_dout_MPORT @[FIFO.scala 49:11]
    node _T_24 = eq(cntData, UInt<6>("h20")) @[FIFO.scala 52:16]
    when _T_24 : @[FIFO.scala 52:29]
      io.full <= UInt<1>("h1") @[FIFO.scala 53:13]
    else :
      io.full <= UInt<1>("h0") @[FIFO.scala 55:13]
    node _T_25 = eq(cntData, UInt<1>("h0")) @[FIFO.scala 57:16]
    when _T_25 : @[FIFO.scala 57:25]
      io.empty <= UInt<1>("h1") @[FIFO.scala 58:14]
    else :
      io.empty <= UInt<1>("h0") @[FIFO.scala 60:14]

