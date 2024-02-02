circuit D_FIFO :
  extmodule D_FIFO_V :
    input clock : Clock
    input reset : UInt<1>
    input din : SInt<32>
    input din_v : UInt<1>
    input dout_r : UInt<1>
    output din_r : UInt<1>
    output dout : SInt<32>
    output dout_v : UInt<1>
    defname = D_FIFO_V
    parameter DATA_WIDTH = 32
    parameter FIFO_DEPTH = 32

  module D_FIFO :
    input clock : Clock
    input reset : UInt<1>
    output io : { flip clock : Clock, flip reset : UInt<1>, flip din : SInt<32>, flip din_v : UInt<1>, flip dout_r : UInt<1>, din_r : UInt<1>, dout : SInt<32>, dout_v : UInt<1>}

    inst fifo of D_FIFO_V @[D_FIFO.scala 60:22]
    fifo.dout_v is invalid
    fifo.dout is invalid
    fifo.din_r is invalid
    fifo.dout_r is invalid
    fifo.din_v is invalid
    fifo.din is invalid
    fifo.reset is invalid
    fifo.clock is invalid
    fifo.clock <= io.clock @[D_FIFO.scala 62:19]
    fifo.reset <= io.reset @[D_FIFO.scala 63:19]
    fifo.din <= io.din @[D_FIFO.scala 64:17]
    fifo.din_v <= io.din_v @[D_FIFO.scala 65:19]
    fifo.dout_r <= io.dout_r @[D_FIFO.scala 66:20]
    io.din_r <= fifo.din_r @[D_FIFO.scala 69:14]
    io.dout <= fifo.dout @[D_FIFO.scala 70:14]
    io.dout_v <= fifo.dout_v @[D_FIFO.scala 71:15]

