circuit D_FIFO_V4 :
  module D_FIFO_V4 :
    input clock : Clock
    input reset : UInt<1>
    output io : { flip din : UInt<32>, flip din_v : UInt<1>, flip dout_r : UInt<1>, din_r : UInt<1>, dout : UInt<32>, dout_v : UInt<1>}

    reg cntWrite : UInt<5>, clock with :
      reset => (reset, UInt<5>("h0")) @[D_FIFO_V4.scala 55:27]
    reg cntRead : UInt<5>, clock with :
      reset => (reset, UInt<5>("h0")) @[D_FIFO_V4.scala 56:26]
    reg cntData : UInt<6>, clock with :
      reset => (reset, UInt<6>("h0")) @[D_FIFO_V4.scala 57:26]
    smem mem : UInt<32> [32] @[D_FIFO_V4.scala 59:26]
    node _T = not(io.dout_v) @[D_FIFO_V4.scala 62:21]
    node _T_1 = and(io.din_v, _T) @[D_FIFO_V4.scala 62:19]
    when _T_1 : @[D_FIFO_V4.scala 62:33]
      node _T_2 = sub(UInt<6>("h20"), UInt<1>("h1")) @[D_FIFO_V4.scala 63:40]
      node _T_3 = tail(_T_2, 1) @[D_FIFO_V4.scala 63:40]
      node _T_4 = eq(cntWrite, _T_3) @[D_FIFO_V4.scala 63:23]
      when _T_4 : @[D_FIFO_V4.scala 63:47]
        cntWrite <= UInt<1>("h0") @[D_FIFO_V4.scala 64:18]
      else :
        node _cntWrite_T = add(cntWrite, UInt<1>("h1")) @[D_FIFO_V4.scala 66:30]
        node _cntWrite_T_1 = tail(_cntWrite_T, 1) @[D_FIFO_V4.scala 66:30]
        cntWrite <= _cntWrite_T_1 @[D_FIFO_V4.scala 66:18]
    node _T_5 = not(io.din_r) @[D_FIFO_V4.scala 71:22]
    node _T_6 = and(io.dout_r, _T_5) @[D_FIFO_V4.scala 71:20]
    when _T_6 : @[D_FIFO_V4.scala 71:33]
      node _T_7 = sub(UInt<6>("h20"), UInt<1>("h1")) @[D_FIFO_V4.scala 72:39]
      node _T_8 = tail(_T_7, 1) @[D_FIFO_V4.scala 72:39]
      node _T_9 = eq(cntRead, _T_8) @[D_FIFO_V4.scala 72:22]
      when _T_9 : @[D_FIFO_V4.scala 72:46]
        cntRead <= UInt<1>("h0") @[D_FIFO_V4.scala 73:21]
      else :
        node _cntRead_T = add(cntRead, UInt<1>("h1")) @[D_FIFO_V4.scala 75:32]
        node _cntRead_T_1 = tail(_cntRead_T, 1) @[D_FIFO_V4.scala 75:32]
        cntRead <= _cntRead_T_1 @[D_FIFO_V4.scala 75:21]
    node _T_10 = not(io.dout_v) @[D_FIFO_V4.scala 80:22]
    node _T_11 = and(io.din_v, _T_10) @[D_FIFO_V4.scala 80:20]
    node _T_12 = not(io.din_r) @[D_FIFO_V4.scala 80:50]
    node _T_13 = and(io.dout_r, _T_12) @[D_FIFO_V4.scala 80:48]
    node _T_14 = not(_T_13) @[D_FIFO_V4.scala 80:36]
    node _T_15 = and(_T_11, _T_14) @[D_FIFO_V4.scala 80:34]
    when _T_15 : @[D_FIFO_V4.scala 80:62]
      node _cntData_T = add(cntData, UInt<1>("h1")) @[D_FIFO_V4.scala 81:28]
      node _cntData_T_1 = tail(_cntData_T, 1) @[D_FIFO_V4.scala 81:28]
      cntData <= _cntData_T_1 @[D_FIFO_V4.scala 81:17]
    else :
      node _T_16 = not(io.dout_v) @[D_FIFO_V4.scala 82:33]
      node _T_17 = and(io.din_v, _T_16) @[D_FIFO_V4.scala 82:31]
      node _T_18 = not(_T_17) @[D_FIFO_V4.scala 82:20]
      node _T_19 = not(io.din_r) @[D_FIFO_V4.scala 82:60]
      node _T_20 = and(io.dout_r, _T_19) @[D_FIFO_V4.scala 82:58]
      node _T_21 = and(_T_18, _T_20) @[D_FIFO_V4.scala 82:45]
      when _T_21 : @[D_FIFO_V4.scala 82:72]
        node _cntData_T_2 = sub(cntData, UInt<1>("h1")) @[D_FIFO_V4.scala 83:28]
        node _cntData_T_3 = tail(_cntData_T_2, 1) @[D_FIFO_V4.scala 83:28]
        cntData <= _cntData_T_3 @[D_FIFO_V4.scala 83:17]
    node _T_22 = not(io.dout_v) @[D_FIFO_V4.scala 87:21]
    node _T_23 = and(io.din_v, _T_22) @[D_FIFO_V4.scala 87:19]
    when _T_23 : @[D_FIFO_V4.scala 87:33]
      write mport MPORT = mem[cntWrite], clock
      MPORT <= io.din
    wire _io_dout_WIRE : UInt @[D_FIFO_V4.scala 90:24]
    _io_dout_WIRE is invalid @[D_FIFO_V4.scala 90:24]
    when UInt<1>("h1") : @[D_FIFO_V4.scala 90:24]
      _io_dout_WIRE <= cntRead @[D_FIFO_V4.scala 90:24]
      node _io_dout_T = or(_io_dout_WIRE, UInt<5>("h0")) @[D_FIFO_V4.scala 90:24]
      node _io_dout_T_1 = bits(_io_dout_T, 4, 0) @[D_FIFO_V4.scala 90:24]
      read mport io_dout_MPORT = mem[_io_dout_T_1], clock @[D_FIFO_V4.scala 90:24]
    io.dout <= io_dout_MPORT @[D_FIFO_V4.scala 90:13]
    node _T_24 = eq(cntData, UInt<6>("h20")) @[D_FIFO_V4.scala 93:18]
    when _T_24 : @[D_FIFO_V4.scala 93:36]
      io.dout_v <= UInt<1>("h1") @[D_FIFO_V4.scala 94:19]
    else :
      io.dout_v <= UInt<1>("h0") @[D_FIFO_V4.scala 96:19]
    node _T_25 = eq(cntData, UInt<1>("h0")) @[D_FIFO_V4.scala 98:18]
    when _T_25 : @[D_FIFO_V4.scala 98:27]
      io.din_r <= UInt<1>("h1") @[D_FIFO_V4.scala 99:18]
    else :
      io.din_r <= UInt<1>("h0") @[D_FIFO_V4.scala 101:18]

