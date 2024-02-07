circuit ProcessingElement :
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
    input reset : Reset
    output io : { flip din : SInt<32>, flip din_v : UInt<1>, flip dout_r : UInt<1>, din_r : UInt<1>, dout : SInt<32>, dout_v : UInt<1>}

    inst fifo of D_FIFO_V @[D_FIFO.scala 60:22]
    fifo.dout_v is invalid
    fifo.dout is invalid
    fifo.din_r is invalid
    fifo.dout_r is invalid
    fifo.din_v is invalid
    fifo.din is invalid
    fifo.reset is invalid
    fifo.clock is invalid
    fifo.clock <= clock @[D_FIFO.scala 62:19]
    node _fifo_io_reset_T = asUInt(reset) @[D_FIFO.scala 63:28]
    fifo.reset <= _fifo_io_reset_T @[D_FIFO.scala 63:19]
    fifo.din <= io.din @[D_FIFO.scala 65:17]
    fifo.din_v <= io.din_v @[D_FIFO.scala 66:19]
    fifo.dout_r <= io.dout_r @[D_FIFO.scala 67:20]
    io.din_r <= fifo.din_r @[D_FIFO.scala 70:14]
    io.dout <= fifo.dout @[D_FIFO.scala 71:14]
    io.dout_v <= fifo.dout_v @[D_FIFO.scala 72:15]

  module FS :
    input clock : Clock
    input reset : Reset
    output io : { flip ready_out : UInt<5>, flip fork_mask : UInt<5>, ready_in : UInt<1>}

    wire aux : UInt<1>[5] @[FS.scala 51:19]
    wire temp : UInt<1>[5] @[FS.scala 52:20]
    node _aux_0_T = bits(io.fork_mask, 0, 0) @[FS.scala 55:34]
    node _aux_0_T_1 = not(_aux_0_T) @[FS.scala 55:21]
    node _aux_0_T_2 = bits(io.ready_out, 0, 0) @[FS.scala 55:53]
    node _aux_0_T_3 = or(_aux_0_T_1, _aux_0_T_2) @[FS.scala 55:39]
    node _aux_0_T_4 = bits(_aux_0_T_3, 0, 0) @[FS.scala 55:58]
    aux[0] <= _aux_0_T_4 @[FS.scala 55:16]
    node _aux_1_T = bits(io.fork_mask, 1, 1) @[FS.scala 55:34]
    node _aux_1_T_1 = not(_aux_1_T) @[FS.scala 55:21]
    node _aux_1_T_2 = bits(io.ready_out, 1, 1) @[FS.scala 55:53]
    node _aux_1_T_3 = or(_aux_1_T_1, _aux_1_T_2) @[FS.scala 55:39]
    node _aux_1_T_4 = bits(_aux_1_T_3, 0, 0) @[FS.scala 55:58]
    aux[1] <= _aux_1_T_4 @[FS.scala 55:16]
    node _aux_2_T = bits(io.fork_mask, 2, 2) @[FS.scala 55:34]
    node _aux_2_T_1 = not(_aux_2_T) @[FS.scala 55:21]
    node _aux_2_T_2 = bits(io.ready_out, 2, 2) @[FS.scala 55:53]
    node _aux_2_T_3 = or(_aux_2_T_1, _aux_2_T_2) @[FS.scala 55:39]
    node _aux_2_T_4 = bits(_aux_2_T_3, 0, 0) @[FS.scala 55:58]
    aux[2] <= _aux_2_T_4 @[FS.scala 55:16]
    node _aux_3_T = bits(io.fork_mask, 3, 3) @[FS.scala 55:34]
    node _aux_3_T_1 = not(_aux_3_T) @[FS.scala 55:21]
    node _aux_3_T_2 = bits(io.ready_out, 3, 3) @[FS.scala 55:53]
    node _aux_3_T_3 = or(_aux_3_T_1, _aux_3_T_2) @[FS.scala 55:39]
    node _aux_3_T_4 = bits(_aux_3_T_3, 0, 0) @[FS.scala 55:58]
    aux[3] <= _aux_3_T_4 @[FS.scala 55:16]
    node _aux_4_T = bits(io.fork_mask, 4, 4) @[FS.scala 55:34]
    node _aux_4_T_1 = not(_aux_4_T) @[FS.scala 55:21]
    node _aux_4_T_2 = bits(io.ready_out, 4, 4) @[FS.scala 55:53]
    node _aux_4_T_3 = or(_aux_4_T_1, _aux_4_T_2) @[FS.scala 55:39]
    node _aux_4_T_4 = bits(_aux_4_T_3, 0, 0) @[FS.scala 55:58]
    aux[4] <= _aux_4_T_4 @[FS.scala 55:16]
    temp[0] <= aux[0] @[FS.scala 58:13]
    node _temp_1_T = and(temp[0], aux[1]) @[FS.scala 61:30]
    temp[1] <= _temp_1_T @[FS.scala 61:17]
    node _temp_2_T = and(temp[1], aux[2]) @[FS.scala 61:30]
    temp[2] <= _temp_2_T @[FS.scala 61:17]
    node _temp_3_T = and(temp[2], aux[3]) @[FS.scala 61:30]
    temp[3] <= _temp_3_T @[FS.scala 61:17]
    node _temp_4_T = and(temp[3], aux[4]) @[FS.scala 61:30]
    temp[4] <= _temp_4_T @[FS.scala 61:17]
    node _io_ready_in_T = bits(temp[4], 0, 0) @[FS.scala 64:47]
    io.ready_in <= _io_ready_in_T @[FS.scala 64:17]

  module ConfMux :
    input clock : Clock
    input reset : Reset
    output io : { flip selector : UInt<2>, flip mux_input : SInt<128>, mux_output : SInt<32>}

    wire inputs : SInt<32>[4] @[ConfMux.scala 25:22]
    node _inputs_0_T = bits(io.mux_input, 31, 0) @[ConfMux.scala 28:35]
    node _inputs_0_T_1 = asSInt(_inputs_0_T) @[ConfMux.scala 28:70]
    inputs[0] <= _inputs_0_T_1 @[ConfMux.scala 28:19]
    node _inputs_1_T = bits(io.mux_input, 63, 32) @[ConfMux.scala 28:35]
    node _inputs_1_T_1 = asSInt(_inputs_1_T) @[ConfMux.scala 28:70]
    inputs[1] <= _inputs_1_T_1 @[ConfMux.scala 28:19]
    node _inputs_2_T = bits(io.mux_input, 95, 64) @[ConfMux.scala 28:35]
    node _inputs_2_T_1 = asSInt(_inputs_2_T) @[ConfMux.scala 28:70]
    inputs[2] <= _inputs_2_T_1 @[ConfMux.scala 28:19]
    node _inputs_3_T = bits(io.mux_input, 127, 96) @[ConfMux.scala 28:35]
    node _inputs_3_T_1 = asSInt(_inputs_3_T) @[ConfMux.scala 28:70]
    inputs[3] <= _inputs_3_T_1 @[ConfMux.scala 28:19]
    io.mux_output <= inputs[io.selector] @[ConfMux.scala 30:19]

  module ConfMux_1 :
    input clock : Clock
    input reset : Reset
    output io : { flip selector : UInt<2>, flip mux_input : SInt<4>, mux_output : SInt<1>}

    wire inputs : SInt<1>[4] @[ConfMux.scala 25:22]
    node _inputs_0_T = bits(io.mux_input, 0, 0) @[ConfMux.scala 28:35]
    node _inputs_0_T_1 = asSInt(_inputs_0_T) @[ConfMux.scala 28:70]
    inputs[0] <= _inputs_0_T_1 @[ConfMux.scala 28:19]
    node _inputs_1_T = bits(io.mux_input, 1, 1) @[ConfMux.scala 28:35]
    node _inputs_1_T_1 = asSInt(_inputs_1_T) @[ConfMux.scala 28:70]
    inputs[1] <= _inputs_1_T_1 @[ConfMux.scala 28:19]
    node _inputs_2_T = bits(io.mux_input, 2, 2) @[ConfMux.scala 28:35]
    node _inputs_2_T_1 = asSInt(_inputs_2_T) @[ConfMux.scala 28:70]
    inputs[2] <= _inputs_2_T_1 @[ConfMux.scala 28:19]
    node _inputs_3_T = bits(io.mux_input, 3, 3) @[ConfMux.scala 28:35]
    node _inputs_3_T_1 = asSInt(_inputs_3_T) @[ConfMux.scala 28:70]
    inputs[3] <= _inputs_3_T_1 @[ConfMux.scala 28:19]
    io.mux_output <= inputs[io.selector] @[ConfMux.scala 30:19]

  module FR :
    input clock : Clock
    input reset : Reset
    output io : { flip valid_in : UInt<4>, flip ready_out : UInt<5>, flip valid_mux_sel : UInt<2>, flip fork_mask : UInt<5>, valid_out : UInt<1>}

    wire aux : UInt<1>[6] @[FR.scala 54:19]
    wire temp : UInt<1>[6] @[FR.scala 55:20]
    wire Vaux : SInt<1> @[FR.scala 56:20]
    node _aux_0_T = bits(io.fork_mask, 0, 0) @[FR.scala 59:34]
    node _aux_0_T_1 = not(_aux_0_T) @[FR.scala 59:21]
    node _aux_0_T_2 = bits(io.ready_out, 0, 0) @[FR.scala 59:53]
    node _aux_0_T_3 = or(_aux_0_T_1, _aux_0_T_2) @[FR.scala 59:39]
    node _aux_0_T_4 = bits(_aux_0_T_3, 0, 0) @[FR.scala 59:58]
    aux[0] <= _aux_0_T_4 @[FR.scala 59:16]
    node _aux_1_T = bits(io.fork_mask, 1, 1) @[FR.scala 59:34]
    node _aux_1_T_1 = not(_aux_1_T) @[FR.scala 59:21]
    node _aux_1_T_2 = bits(io.ready_out, 1, 1) @[FR.scala 59:53]
    node _aux_1_T_3 = or(_aux_1_T_1, _aux_1_T_2) @[FR.scala 59:39]
    node _aux_1_T_4 = bits(_aux_1_T_3, 0, 0) @[FR.scala 59:58]
    aux[1] <= _aux_1_T_4 @[FR.scala 59:16]
    node _aux_2_T = bits(io.fork_mask, 2, 2) @[FR.scala 59:34]
    node _aux_2_T_1 = not(_aux_2_T) @[FR.scala 59:21]
    node _aux_2_T_2 = bits(io.ready_out, 2, 2) @[FR.scala 59:53]
    node _aux_2_T_3 = or(_aux_2_T_1, _aux_2_T_2) @[FR.scala 59:39]
    node _aux_2_T_4 = bits(_aux_2_T_3, 0, 0) @[FR.scala 59:58]
    aux[2] <= _aux_2_T_4 @[FR.scala 59:16]
    node _aux_3_T = bits(io.fork_mask, 3, 3) @[FR.scala 59:34]
    node _aux_3_T_1 = not(_aux_3_T) @[FR.scala 59:21]
    node _aux_3_T_2 = bits(io.ready_out, 3, 3) @[FR.scala 59:53]
    node _aux_3_T_3 = or(_aux_3_T_1, _aux_3_T_2) @[FR.scala 59:39]
    node _aux_3_T_4 = bits(_aux_3_T_3, 0, 0) @[FR.scala 59:58]
    aux[3] <= _aux_3_T_4 @[FR.scala 59:16]
    node _aux_4_T = bits(io.fork_mask, 4, 4) @[FR.scala 59:34]
    node _aux_4_T_1 = not(_aux_4_T) @[FR.scala 59:21]
    node _aux_4_T_2 = bits(io.ready_out, 4, 4) @[FR.scala 59:53]
    node _aux_4_T_3 = or(_aux_4_T_1, _aux_4_T_2) @[FR.scala 59:39]
    node _aux_4_T_4 = bits(_aux_4_T_3, 0, 0) @[FR.scala 59:58]
    aux[4] <= _aux_4_T_4 @[FR.scala 59:16]
    inst conf_mux of ConfMux_1 @[FR.scala 61:28]
    conf_mux.clock <= clock
    conf_mux.reset <= reset
    conf_mux.io.selector <= io.valid_mux_sel @[FR.scala 62:26]
    node _conf_mux_io_mux_input_T = asSInt(io.valid_in) @[FR.scala 63:44]
    conf_mux.io.mux_input <= _conf_mux_io_mux_input_T @[FR.scala 63:27]
    Vaux <= conf_mux.io.mux_output @[FR.scala 64:10]
    node _aux_5_T = bits(Vaux, 0, 0) @[FR.scala 66:34]
    node _aux_5_T_1 = bits(_aux_5_T, 0, 0) @[FR.scala 66:38]
    aux[5] <= _aux_5_T_1 @[FR.scala 66:27]
    temp[0] <= aux[0] @[FR.scala 67:13]
    node _temp_1_T = and(temp[0], aux[1]) @[FR.scala 70:30]
    temp[1] <= _temp_1_T @[FR.scala 70:17]
    node _temp_2_T = and(temp[1], aux[2]) @[FR.scala 70:30]
    temp[2] <= _temp_2_T @[FR.scala 70:17]
    node _temp_3_T = and(temp[2], aux[3]) @[FR.scala 70:30]
    temp[3] <= _temp_3_T @[FR.scala 70:17]
    node _temp_4_T = and(temp[3], aux[4]) @[FR.scala 70:30]
    temp[4] <= _temp_4_T @[FR.scala 70:17]
    node _temp_5_T = and(temp[4], aux[5]) @[FR.scala 70:30]
    temp[5] <= _temp_5_T @[FR.scala 70:17]
    io.valid_out <= temp[5] @[FR.scala 72:18]

  module D_REG :
    input clock : Clock
    input reset : Reset
    output io : { flip din : SInt<32>, flip din_v : UInt<1>, flip dout_r : UInt<1>, dout : SInt<32>, dout_v : UInt<1>, din_r : UInt<1>}

    reg data : SInt<32>, clock with :
      reset => (reset, asSInt(UInt<32>("h0"))) @[D_REG.scala 52:23]
    reg valid : UInt<1>, clock with :
      reset => (reset, UInt<1>("h0")) @[D_REG.scala 53:24]
    data <= asSInt(UInt<1>("h0")) @[D_REG.scala 56:10]
    valid <= UInt<1>("h0") @[D_REG.scala 57:11]
    node _T = eq(io.dout_r, UInt<1>("h1")) @[D_REG.scala 59:21]
    when _T : @[D_REG.scala 59:33]
      data <= io.din @[D_REG.scala 60:14]
      valid <= io.din_v @[D_REG.scala 61:15]
    io.dout <= data @[D_REG.scala 64:13]
    io.dout_v <= valid @[D_REG.scala 65:15]
    io.din_r <= io.dout_r @[D_REG.scala 66:14]

  extmodule D_FIFO_V_1 :
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

  module D_FIFO_1 :
    input clock : Clock
    input reset : Reset
    output io : { flip din : SInt<32>, flip din_v : UInt<1>, flip dout_r : UInt<1>, din_r : UInt<1>, dout : SInt<32>, dout_v : UInt<1>}

    inst fifo of D_FIFO_V_1 @[D_FIFO.scala 60:22]
    fifo.dout_v is invalid
    fifo.dout is invalid
    fifo.din_r is invalid
    fifo.dout_r is invalid
    fifo.din_v is invalid
    fifo.din is invalid
    fifo.reset is invalid
    fifo.clock is invalid
    fifo.clock <= clock @[D_FIFO.scala 62:19]
    node _fifo_io_reset_T = asUInt(reset) @[D_FIFO.scala 63:28]
    fifo.reset <= _fifo_io_reset_T @[D_FIFO.scala 63:19]
    fifo.din <= io.din @[D_FIFO.scala 65:17]
    fifo.din_v <= io.din_v @[D_FIFO.scala 66:19]
    fifo.dout_r <= io.dout_r @[D_FIFO.scala 67:20]
    io.din_r <= fifo.din_r @[D_FIFO.scala 70:14]
    io.dout <= fifo.dout @[D_FIFO.scala 71:14]
    io.dout_v <= fifo.dout_v @[D_FIFO.scala 72:15]

  module FS_1 :
    input clock : Clock
    input reset : Reset
    output io : { flip ready_out : UInt<5>, flip fork_mask : UInt<5>, ready_in : UInt<1>}

    wire aux : UInt<1>[5] @[FS.scala 51:19]
    wire temp : UInt<1>[5] @[FS.scala 52:20]
    node _aux_0_T = bits(io.fork_mask, 0, 0) @[FS.scala 55:34]
    node _aux_0_T_1 = not(_aux_0_T) @[FS.scala 55:21]
    node _aux_0_T_2 = bits(io.ready_out, 0, 0) @[FS.scala 55:53]
    node _aux_0_T_3 = or(_aux_0_T_1, _aux_0_T_2) @[FS.scala 55:39]
    node _aux_0_T_4 = bits(_aux_0_T_3, 0, 0) @[FS.scala 55:58]
    aux[0] <= _aux_0_T_4 @[FS.scala 55:16]
    node _aux_1_T = bits(io.fork_mask, 1, 1) @[FS.scala 55:34]
    node _aux_1_T_1 = not(_aux_1_T) @[FS.scala 55:21]
    node _aux_1_T_2 = bits(io.ready_out, 1, 1) @[FS.scala 55:53]
    node _aux_1_T_3 = or(_aux_1_T_1, _aux_1_T_2) @[FS.scala 55:39]
    node _aux_1_T_4 = bits(_aux_1_T_3, 0, 0) @[FS.scala 55:58]
    aux[1] <= _aux_1_T_4 @[FS.scala 55:16]
    node _aux_2_T = bits(io.fork_mask, 2, 2) @[FS.scala 55:34]
    node _aux_2_T_1 = not(_aux_2_T) @[FS.scala 55:21]
    node _aux_2_T_2 = bits(io.ready_out, 2, 2) @[FS.scala 55:53]
    node _aux_2_T_3 = or(_aux_2_T_1, _aux_2_T_2) @[FS.scala 55:39]
    node _aux_2_T_4 = bits(_aux_2_T_3, 0, 0) @[FS.scala 55:58]
    aux[2] <= _aux_2_T_4 @[FS.scala 55:16]
    node _aux_3_T = bits(io.fork_mask, 3, 3) @[FS.scala 55:34]
    node _aux_3_T_1 = not(_aux_3_T) @[FS.scala 55:21]
    node _aux_3_T_2 = bits(io.ready_out, 3, 3) @[FS.scala 55:53]
    node _aux_3_T_3 = or(_aux_3_T_1, _aux_3_T_2) @[FS.scala 55:39]
    node _aux_3_T_4 = bits(_aux_3_T_3, 0, 0) @[FS.scala 55:58]
    aux[3] <= _aux_3_T_4 @[FS.scala 55:16]
    node _aux_4_T = bits(io.fork_mask, 4, 4) @[FS.scala 55:34]
    node _aux_4_T_1 = not(_aux_4_T) @[FS.scala 55:21]
    node _aux_4_T_2 = bits(io.ready_out, 4, 4) @[FS.scala 55:53]
    node _aux_4_T_3 = or(_aux_4_T_1, _aux_4_T_2) @[FS.scala 55:39]
    node _aux_4_T_4 = bits(_aux_4_T_3, 0, 0) @[FS.scala 55:58]
    aux[4] <= _aux_4_T_4 @[FS.scala 55:16]
    temp[0] <= aux[0] @[FS.scala 58:13]
    node _temp_1_T = and(temp[0], aux[1]) @[FS.scala 61:30]
    temp[1] <= _temp_1_T @[FS.scala 61:17]
    node _temp_2_T = and(temp[1], aux[2]) @[FS.scala 61:30]
    temp[2] <= _temp_2_T @[FS.scala 61:17]
    node _temp_3_T = and(temp[2], aux[3]) @[FS.scala 61:30]
    temp[3] <= _temp_3_T @[FS.scala 61:17]
    node _temp_4_T = and(temp[3], aux[4]) @[FS.scala 61:30]
    temp[4] <= _temp_4_T @[FS.scala 61:17]
    node _io_ready_in_T = bits(temp[4], 0, 0) @[FS.scala 64:47]
    io.ready_in <= _io_ready_in_T @[FS.scala 64:17]

  module ConfMux_2 :
    input clock : Clock
    input reset : Reset
    output io : { flip selector : UInt<2>, flip mux_input : SInt<128>, mux_output : SInt<32>}

    wire inputs : SInt<32>[4] @[ConfMux.scala 25:22]
    node _inputs_0_T = bits(io.mux_input, 31, 0) @[ConfMux.scala 28:35]
    node _inputs_0_T_1 = asSInt(_inputs_0_T) @[ConfMux.scala 28:70]
    inputs[0] <= _inputs_0_T_1 @[ConfMux.scala 28:19]
    node _inputs_1_T = bits(io.mux_input, 63, 32) @[ConfMux.scala 28:35]
    node _inputs_1_T_1 = asSInt(_inputs_1_T) @[ConfMux.scala 28:70]
    inputs[1] <= _inputs_1_T_1 @[ConfMux.scala 28:19]
    node _inputs_2_T = bits(io.mux_input, 95, 64) @[ConfMux.scala 28:35]
    node _inputs_2_T_1 = asSInt(_inputs_2_T) @[ConfMux.scala 28:70]
    inputs[2] <= _inputs_2_T_1 @[ConfMux.scala 28:19]
    node _inputs_3_T = bits(io.mux_input, 127, 96) @[ConfMux.scala 28:35]
    node _inputs_3_T_1 = asSInt(_inputs_3_T) @[ConfMux.scala 28:70]
    inputs[3] <= _inputs_3_T_1 @[ConfMux.scala 28:19]
    io.mux_output <= inputs[io.selector] @[ConfMux.scala 30:19]

  module ConfMux_3 :
    input clock : Clock
    input reset : Reset
    output io : { flip selector : UInt<2>, flip mux_input : SInt<4>, mux_output : SInt<1>}

    wire inputs : SInt<1>[4] @[ConfMux.scala 25:22]
    node _inputs_0_T = bits(io.mux_input, 0, 0) @[ConfMux.scala 28:35]
    node _inputs_0_T_1 = asSInt(_inputs_0_T) @[ConfMux.scala 28:70]
    inputs[0] <= _inputs_0_T_1 @[ConfMux.scala 28:19]
    node _inputs_1_T = bits(io.mux_input, 1, 1) @[ConfMux.scala 28:35]
    node _inputs_1_T_1 = asSInt(_inputs_1_T) @[ConfMux.scala 28:70]
    inputs[1] <= _inputs_1_T_1 @[ConfMux.scala 28:19]
    node _inputs_2_T = bits(io.mux_input, 2, 2) @[ConfMux.scala 28:35]
    node _inputs_2_T_1 = asSInt(_inputs_2_T) @[ConfMux.scala 28:70]
    inputs[2] <= _inputs_2_T_1 @[ConfMux.scala 28:19]
    node _inputs_3_T = bits(io.mux_input, 3, 3) @[ConfMux.scala 28:35]
    node _inputs_3_T_1 = asSInt(_inputs_3_T) @[ConfMux.scala 28:70]
    inputs[3] <= _inputs_3_T_1 @[ConfMux.scala 28:19]
    io.mux_output <= inputs[io.selector] @[ConfMux.scala 30:19]

  module FR_1 :
    input clock : Clock
    input reset : Reset
    output io : { flip valid_in : UInt<4>, flip ready_out : UInt<5>, flip valid_mux_sel : UInt<2>, flip fork_mask : UInt<5>, valid_out : UInt<1>}

    wire aux : UInt<1>[6] @[FR.scala 54:19]
    wire temp : UInt<1>[6] @[FR.scala 55:20]
    wire Vaux : SInt<1> @[FR.scala 56:20]
    node _aux_0_T = bits(io.fork_mask, 0, 0) @[FR.scala 59:34]
    node _aux_0_T_1 = not(_aux_0_T) @[FR.scala 59:21]
    node _aux_0_T_2 = bits(io.ready_out, 0, 0) @[FR.scala 59:53]
    node _aux_0_T_3 = or(_aux_0_T_1, _aux_0_T_2) @[FR.scala 59:39]
    node _aux_0_T_4 = bits(_aux_0_T_3, 0, 0) @[FR.scala 59:58]
    aux[0] <= _aux_0_T_4 @[FR.scala 59:16]
    node _aux_1_T = bits(io.fork_mask, 1, 1) @[FR.scala 59:34]
    node _aux_1_T_1 = not(_aux_1_T) @[FR.scala 59:21]
    node _aux_1_T_2 = bits(io.ready_out, 1, 1) @[FR.scala 59:53]
    node _aux_1_T_3 = or(_aux_1_T_1, _aux_1_T_2) @[FR.scala 59:39]
    node _aux_1_T_4 = bits(_aux_1_T_3, 0, 0) @[FR.scala 59:58]
    aux[1] <= _aux_1_T_4 @[FR.scala 59:16]
    node _aux_2_T = bits(io.fork_mask, 2, 2) @[FR.scala 59:34]
    node _aux_2_T_1 = not(_aux_2_T) @[FR.scala 59:21]
    node _aux_2_T_2 = bits(io.ready_out, 2, 2) @[FR.scala 59:53]
    node _aux_2_T_3 = or(_aux_2_T_1, _aux_2_T_2) @[FR.scala 59:39]
    node _aux_2_T_4 = bits(_aux_2_T_3, 0, 0) @[FR.scala 59:58]
    aux[2] <= _aux_2_T_4 @[FR.scala 59:16]
    node _aux_3_T = bits(io.fork_mask, 3, 3) @[FR.scala 59:34]
    node _aux_3_T_1 = not(_aux_3_T) @[FR.scala 59:21]
    node _aux_3_T_2 = bits(io.ready_out, 3, 3) @[FR.scala 59:53]
    node _aux_3_T_3 = or(_aux_3_T_1, _aux_3_T_2) @[FR.scala 59:39]
    node _aux_3_T_4 = bits(_aux_3_T_3, 0, 0) @[FR.scala 59:58]
    aux[3] <= _aux_3_T_4 @[FR.scala 59:16]
    node _aux_4_T = bits(io.fork_mask, 4, 4) @[FR.scala 59:34]
    node _aux_4_T_1 = not(_aux_4_T) @[FR.scala 59:21]
    node _aux_4_T_2 = bits(io.ready_out, 4, 4) @[FR.scala 59:53]
    node _aux_4_T_3 = or(_aux_4_T_1, _aux_4_T_2) @[FR.scala 59:39]
    node _aux_4_T_4 = bits(_aux_4_T_3, 0, 0) @[FR.scala 59:58]
    aux[4] <= _aux_4_T_4 @[FR.scala 59:16]
    inst conf_mux of ConfMux_3 @[FR.scala 61:28]
    conf_mux.clock <= clock
    conf_mux.reset <= reset
    conf_mux.io.selector <= io.valid_mux_sel @[FR.scala 62:26]
    node _conf_mux_io_mux_input_T = asSInt(io.valid_in) @[FR.scala 63:44]
    conf_mux.io.mux_input <= _conf_mux_io_mux_input_T @[FR.scala 63:27]
    Vaux <= conf_mux.io.mux_output @[FR.scala 64:10]
    node _aux_5_T = bits(Vaux, 0, 0) @[FR.scala 66:34]
    node _aux_5_T_1 = bits(_aux_5_T, 0, 0) @[FR.scala 66:38]
    aux[5] <= _aux_5_T_1 @[FR.scala 66:27]
    temp[0] <= aux[0] @[FR.scala 67:13]
    node _temp_1_T = and(temp[0], aux[1]) @[FR.scala 70:30]
    temp[1] <= _temp_1_T @[FR.scala 70:17]
    node _temp_2_T = and(temp[1], aux[2]) @[FR.scala 70:30]
    temp[2] <= _temp_2_T @[FR.scala 70:17]
    node _temp_3_T = and(temp[2], aux[3]) @[FR.scala 70:30]
    temp[3] <= _temp_3_T @[FR.scala 70:17]
    node _temp_4_T = and(temp[3], aux[4]) @[FR.scala 70:30]
    temp[4] <= _temp_4_T @[FR.scala 70:17]
    node _temp_5_T = and(temp[4], aux[5]) @[FR.scala 70:30]
    temp[5] <= _temp_5_T @[FR.scala 70:17]
    io.valid_out <= temp[5] @[FR.scala 72:18]

  module D_REG_1 :
    input clock : Clock
    input reset : Reset
    output io : { flip din : SInt<32>, flip din_v : UInt<1>, flip dout_r : UInt<1>, dout : SInt<32>, dout_v : UInt<1>, din_r : UInt<1>}

    reg data : SInt<32>, clock with :
      reset => (reset, asSInt(UInt<32>("h0"))) @[D_REG.scala 52:23]
    reg valid : UInt<1>, clock with :
      reset => (reset, UInt<1>("h0")) @[D_REG.scala 53:24]
    data <= asSInt(UInt<1>("h0")) @[D_REG.scala 56:10]
    valid <= UInt<1>("h0") @[D_REG.scala 57:11]
    node _T = eq(io.dout_r, UInt<1>("h1")) @[D_REG.scala 59:21]
    when _T : @[D_REG.scala 59:33]
      data <= io.din @[D_REG.scala 60:14]
      valid <= io.din_v @[D_REG.scala 61:15]
    io.dout <= data @[D_REG.scala 64:13]
    io.dout_v <= valid @[D_REG.scala 65:15]
    io.din_r <= io.dout_r @[D_REG.scala 66:14]

  extmodule D_FIFO_V_2 :
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

  module D_FIFO_2 :
    input clock : Clock
    input reset : Reset
    output io : { flip din : SInt<32>, flip din_v : UInt<1>, flip dout_r : UInt<1>, din_r : UInt<1>, dout : SInt<32>, dout_v : UInt<1>}

    inst fifo of D_FIFO_V_2 @[D_FIFO.scala 60:22]
    fifo.dout_v is invalid
    fifo.dout is invalid
    fifo.din_r is invalid
    fifo.dout_r is invalid
    fifo.din_v is invalid
    fifo.din is invalid
    fifo.reset is invalid
    fifo.clock is invalid
    fifo.clock <= clock @[D_FIFO.scala 62:19]
    node _fifo_io_reset_T = asUInt(reset) @[D_FIFO.scala 63:28]
    fifo.reset <= _fifo_io_reset_T @[D_FIFO.scala 63:19]
    fifo.din <= io.din @[D_FIFO.scala 65:17]
    fifo.din_v <= io.din_v @[D_FIFO.scala 66:19]
    fifo.dout_r <= io.dout_r @[D_FIFO.scala 67:20]
    io.din_r <= fifo.din_r @[D_FIFO.scala 70:14]
    io.dout <= fifo.dout @[D_FIFO.scala 71:14]
    io.dout_v <= fifo.dout_v @[D_FIFO.scala 72:15]

  module FS_2 :
    input clock : Clock
    input reset : Reset
    output io : { flip ready_out : UInt<5>, flip fork_mask : UInt<5>, ready_in : UInt<1>}

    wire aux : UInt<1>[5] @[FS.scala 51:19]
    wire temp : UInt<1>[5] @[FS.scala 52:20]
    node _aux_0_T = bits(io.fork_mask, 0, 0) @[FS.scala 55:34]
    node _aux_0_T_1 = not(_aux_0_T) @[FS.scala 55:21]
    node _aux_0_T_2 = bits(io.ready_out, 0, 0) @[FS.scala 55:53]
    node _aux_0_T_3 = or(_aux_0_T_1, _aux_0_T_2) @[FS.scala 55:39]
    node _aux_0_T_4 = bits(_aux_0_T_3, 0, 0) @[FS.scala 55:58]
    aux[0] <= _aux_0_T_4 @[FS.scala 55:16]
    node _aux_1_T = bits(io.fork_mask, 1, 1) @[FS.scala 55:34]
    node _aux_1_T_1 = not(_aux_1_T) @[FS.scala 55:21]
    node _aux_1_T_2 = bits(io.ready_out, 1, 1) @[FS.scala 55:53]
    node _aux_1_T_3 = or(_aux_1_T_1, _aux_1_T_2) @[FS.scala 55:39]
    node _aux_1_T_4 = bits(_aux_1_T_3, 0, 0) @[FS.scala 55:58]
    aux[1] <= _aux_1_T_4 @[FS.scala 55:16]
    node _aux_2_T = bits(io.fork_mask, 2, 2) @[FS.scala 55:34]
    node _aux_2_T_1 = not(_aux_2_T) @[FS.scala 55:21]
    node _aux_2_T_2 = bits(io.ready_out, 2, 2) @[FS.scala 55:53]
    node _aux_2_T_3 = or(_aux_2_T_1, _aux_2_T_2) @[FS.scala 55:39]
    node _aux_2_T_4 = bits(_aux_2_T_3, 0, 0) @[FS.scala 55:58]
    aux[2] <= _aux_2_T_4 @[FS.scala 55:16]
    node _aux_3_T = bits(io.fork_mask, 3, 3) @[FS.scala 55:34]
    node _aux_3_T_1 = not(_aux_3_T) @[FS.scala 55:21]
    node _aux_3_T_2 = bits(io.ready_out, 3, 3) @[FS.scala 55:53]
    node _aux_3_T_3 = or(_aux_3_T_1, _aux_3_T_2) @[FS.scala 55:39]
    node _aux_3_T_4 = bits(_aux_3_T_3, 0, 0) @[FS.scala 55:58]
    aux[3] <= _aux_3_T_4 @[FS.scala 55:16]
    node _aux_4_T = bits(io.fork_mask, 4, 4) @[FS.scala 55:34]
    node _aux_4_T_1 = not(_aux_4_T) @[FS.scala 55:21]
    node _aux_4_T_2 = bits(io.ready_out, 4, 4) @[FS.scala 55:53]
    node _aux_4_T_3 = or(_aux_4_T_1, _aux_4_T_2) @[FS.scala 55:39]
    node _aux_4_T_4 = bits(_aux_4_T_3, 0, 0) @[FS.scala 55:58]
    aux[4] <= _aux_4_T_4 @[FS.scala 55:16]
    temp[0] <= aux[0] @[FS.scala 58:13]
    node _temp_1_T = and(temp[0], aux[1]) @[FS.scala 61:30]
    temp[1] <= _temp_1_T @[FS.scala 61:17]
    node _temp_2_T = and(temp[1], aux[2]) @[FS.scala 61:30]
    temp[2] <= _temp_2_T @[FS.scala 61:17]
    node _temp_3_T = and(temp[2], aux[3]) @[FS.scala 61:30]
    temp[3] <= _temp_3_T @[FS.scala 61:17]
    node _temp_4_T = and(temp[3], aux[4]) @[FS.scala 61:30]
    temp[4] <= _temp_4_T @[FS.scala 61:17]
    node _io_ready_in_T = bits(temp[4], 0, 0) @[FS.scala 64:47]
    io.ready_in <= _io_ready_in_T @[FS.scala 64:17]

  module ConfMux_4 :
    input clock : Clock
    input reset : Reset
    output io : { flip selector : UInt<2>, flip mux_input : SInt<128>, mux_output : SInt<32>}

    wire inputs : SInt<32>[4] @[ConfMux.scala 25:22]
    node _inputs_0_T = bits(io.mux_input, 31, 0) @[ConfMux.scala 28:35]
    node _inputs_0_T_1 = asSInt(_inputs_0_T) @[ConfMux.scala 28:70]
    inputs[0] <= _inputs_0_T_1 @[ConfMux.scala 28:19]
    node _inputs_1_T = bits(io.mux_input, 63, 32) @[ConfMux.scala 28:35]
    node _inputs_1_T_1 = asSInt(_inputs_1_T) @[ConfMux.scala 28:70]
    inputs[1] <= _inputs_1_T_1 @[ConfMux.scala 28:19]
    node _inputs_2_T = bits(io.mux_input, 95, 64) @[ConfMux.scala 28:35]
    node _inputs_2_T_1 = asSInt(_inputs_2_T) @[ConfMux.scala 28:70]
    inputs[2] <= _inputs_2_T_1 @[ConfMux.scala 28:19]
    node _inputs_3_T = bits(io.mux_input, 127, 96) @[ConfMux.scala 28:35]
    node _inputs_3_T_1 = asSInt(_inputs_3_T) @[ConfMux.scala 28:70]
    inputs[3] <= _inputs_3_T_1 @[ConfMux.scala 28:19]
    io.mux_output <= inputs[io.selector] @[ConfMux.scala 30:19]

  module ConfMux_5 :
    input clock : Clock
    input reset : Reset
    output io : { flip selector : UInt<2>, flip mux_input : SInt<4>, mux_output : SInt<1>}

    wire inputs : SInt<1>[4] @[ConfMux.scala 25:22]
    node _inputs_0_T = bits(io.mux_input, 0, 0) @[ConfMux.scala 28:35]
    node _inputs_0_T_1 = asSInt(_inputs_0_T) @[ConfMux.scala 28:70]
    inputs[0] <= _inputs_0_T_1 @[ConfMux.scala 28:19]
    node _inputs_1_T = bits(io.mux_input, 1, 1) @[ConfMux.scala 28:35]
    node _inputs_1_T_1 = asSInt(_inputs_1_T) @[ConfMux.scala 28:70]
    inputs[1] <= _inputs_1_T_1 @[ConfMux.scala 28:19]
    node _inputs_2_T = bits(io.mux_input, 2, 2) @[ConfMux.scala 28:35]
    node _inputs_2_T_1 = asSInt(_inputs_2_T) @[ConfMux.scala 28:70]
    inputs[2] <= _inputs_2_T_1 @[ConfMux.scala 28:19]
    node _inputs_3_T = bits(io.mux_input, 3, 3) @[ConfMux.scala 28:35]
    node _inputs_3_T_1 = asSInt(_inputs_3_T) @[ConfMux.scala 28:70]
    inputs[3] <= _inputs_3_T_1 @[ConfMux.scala 28:19]
    io.mux_output <= inputs[io.selector] @[ConfMux.scala 30:19]

  module FR_2 :
    input clock : Clock
    input reset : Reset
    output io : { flip valid_in : UInt<4>, flip ready_out : UInt<5>, flip valid_mux_sel : UInt<2>, flip fork_mask : UInt<5>, valid_out : UInt<1>}

    wire aux : UInt<1>[6] @[FR.scala 54:19]
    wire temp : UInt<1>[6] @[FR.scala 55:20]
    wire Vaux : SInt<1> @[FR.scala 56:20]
    node _aux_0_T = bits(io.fork_mask, 0, 0) @[FR.scala 59:34]
    node _aux_0_T_1 = not(_aux_0_T) @[FR.scala 59:21]
    node _aux_0_T_2 = bits(io.ready_out, 0, 0) @[FR.scala 59:53]
    node _aux_0_T_3 = or(_aux_0_T_1, _aux_0_T_2) @[FR.scala 59:39]
    node _aux_0_T_4 = bits(_aux_0_T_3, 0, 0) @[FR.scala 59:58]
    aux[0] <= _aux_0_T_4 @[FR.scala 59:16]
    node _aux_1_T = bits(io.fork_mask, 1, 1) @[FR.scala 59:34]
    node _aux_1_T_1 = not(_aux_1_T) @[FR.scala 59:21]
    node _aux_1_T_2 = bits(io.ready_out, 1, 1) @[FR.scala 59:53]
    node _aux_1_T_3 = or(_aux_1_T_1, _aux_1_T_2) @[FR.scala 59:39]
    node _aux_1_T_4 = bits(_aux_1_T_3, 0, 0) @[FR.scala 59:58]
    aux[1] <= _aux_1_T_4 @[FR.scala 59:16]
    node _aux_2_T = bits(io.fork_mask, 2, 2) @[FR.scala 59:34]
    node _aux_2_T_1 = not(_aux_2_T) @[FR.scala 59:21]
    node _aux_2_T_2 = bits(io.ready_out, 2, 2) @[FR.scala 59:53]
    node _aux_2_T_3 = or(_aux_2_T_1, _aux_2_T_2) @[FR.scala 59:39]
    node _aux_2_T_4 = bits(_aux_2_T_3, 0, 0) @[FR.scala 59:58]
    aux[2] <= _aux_2_T_4 @[FR.scala 59:16]
    node _aux_3_T = bits(io.fork_mask, 3, 3) @[FR.scala 59:34]
    node _aux_3_T_1 = not(_aux_3_T) @[FR.scala 59:21]
    node _aux_3_T_2 = bits(io.ready_out, 3, 3) @[FR.scala 59:53]
    node _aux_3_T_3 = or(_aux_3_T_1, _aux_3_T_2) @[FR.scala 59:39]
    node _aux_3_T_4 = bits(_aux_3_T_3, 0, 0) @[FR.scala 59:58]
    aux[3] <= _aux_3_T_4 @[FR.scala 59:16]
    node _aux_4_T = bits(io.fork_mask, 4, 4) @[FR.scala 59:34]
    node _aux_4_T_1 = not(_aux_4_T) @[FR.scala 59:21]
    node _aux_4_T_2 = bits(io.ready_out, 4, 4) @[FR.scala 59:53]
    node _aux_4_T_3 = or(_aux_4_T_1, _aux_4_T_2) @[FR.scala 59:39]
    node _aux_4_T_4 = bits(_aux_4_T_3, 0, 0) @[FR.scala 59:58]
    aux[4] <= _aux_4_T_4 @[FR.scala 59:16]
    inst conf_mux of ConfMux_5 @[FR.scala 61:28]
    conf_mux.clock <= clock
    conf_mux.reset <= reset
    conf_mux.io.selector <= io.valid_mux_sel @[FR.scala 62:26]
    node _conf_mux_io_mux_input_T = asSInt(io.valid_in) @[FR.scala 63:44]
    conf_mux.io.mux_input <= _conf_mux_io_mux_input_T @[FR.scala 63:27]
    Vaux <= conf_mux.io.mux_output @[FR.scala 64:10]
    node _aux_5_T = bits(Vaux, 0, 0) @[FR.scala 66:34]
    node _aux_5_T_1 = bits(_aux_5_T, 0, 0) @[FR.scala 66:38]
    aux[5] <= _aux_5_T_1 @[FR.scala 66:27]
    temp[0] <= aux[0] @[FR.scala 67:13]
    node _temp_1_T = and(temp[0], aux[1]) @[FR.scala 70:30]
    temp[1] <= _temp_1_T @[FR.scala 70:17]
    node _temp_2_T = and(temp[1], aux[2]) @[FR.scala 70:30]
    temp[2] <= _temp_2_T @[FR.scala 70:17]
    node _temp_3_T = and(temp[2], aux[3]) @[FR.scala 70:30]
    temp[3] <= _temp_3_T @[FR.scala 70:17]
    node _temp_4_T = and(temp[3], aux[4]) @[FR.scala 70:30]
    temp[4] <= _temp_4_T @[FR.scala 70:17]
    node _temp_5_T = and(temp[4], aux[5]) @[FR.scala 70:30]
    temp[5] <= _temp_5_T @[FR.scala 70:17]
    io.valid_out <= temp[5] @[FR.scala 72:18]

  module D_REG_2 :
    input clock : Clock
    input reset : Reset
    output io : { flip din : SInt<32>, flip din_v : UInt<1>, flip dout_r : UInt<1>, dout : SInt<32>, dout_v : UInt<1>, din_r : UInt<1>}

    reg data : SInt<32>, clock with :
      reset => (reset, asSInt(UInt<32>("h0"))) @[D_REG.scala 52:23]
    reg valid : UInt<1>, clock with :
      reset => (reset, UInt<1>("h0")) @[D_REG.scala 53:24]
    data <= asSInt(UInt<1>("h0")) @[D_REG.scala 56:10]
    valid <= UInt<1>("h0") @[D_REG.scala 57:11]
    node _T = eq(io.dout_r, UInt<1>("h1")) @[D_REG.scala 59:21]
    when _T : @[D_REG.scala 59:33]
      data <= io.din @[D_REG.scala 60:14]
      valid <= io.din_v @[D_REG.scala 61:15]
    io.dout <= data @[D_REG.scala 64:13]
    io.dout_v <= valid @[D_REG.scala 65:15]
    io.din_r <= io.dout_r @[D_REG.scala 66:14]

  extmodule D_FIFO_V_3 :
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

  module D_FIFO_3 :
    input clock : Clock
    input reset : Reset
    output io : { flip din : SInt<32>, flip din_v : UInt<1>, flip dout_r : UInt<1>, din_r : UInt<1>, dout : SInt<32>, dout_v : UInt<1>}

    inst fifo of D_FIFO_V_3 @[D_FIFO.scala 60:22]
    fifo.dout_v is invalid
    fifo.dout is invalid
    fifo.din_r is invalid
    fifo.dout_r is invalid
    fifo.din_v is invalid
    fifo.din is invalid
    fifo.reset is invalid
    fifo.clock is invalid
    fifo.clock <= clock @[D_FIFO.scala 62:19]
    node _fifo_io_reset_T = asUInt(reset) @[D_FIFO.scala 63:28]
    fifo.reset <= _fifo_io_reset_T @[D_FIFO.scala 63:19]
    fifo.din <= io.din @[D_FIFO.scala 65:17]
    fifo.din_v <= io.din_v @[D_FIFO.scala 66:19]
    fifo.dout_r <= io.dout_r @[D_FIFO.scala 67:20]
    io.din_r <= fifo.din_r @[D_FIFO.scala 70:14]
    io.dout <= fifo.dout @[D_FIFO.scala 71:14]
    io.dout_v <= fifo.dout_v @[D_FIFO.scala 72:15]

  module FS_3 :
    input clock : Clock
    input reset : Reset
    output io : { flip ready_out : UInt<5>, flip fork_mask : UInt<5>, ready_in : UInt<1>}

    wire aux : UInt<1>[5] @[FS.scala 51:19]
    wire temp : UInt<1>[5] @[FS.scala 52:20]
    node _aux_0_T = bits(io.fork_mask, 0, 0) @[FS.scala 55:34]
    node _aux_0_T_1 = not(_aux_0_T) @[FS.scala 55:21]
    node _aux_0_T_2 = bits(io.ready_out, 0, 0) @[FS.scala 55:53]
    node _aux_0_T_3 = or(_aux_0_T_1, _aux_0_T_2) @[FS.scala 55:39]
    node _aux_0_T_4 = bits(_aux_0_T_3, 0, 0) @[FS.scala 55:58]
    aux[0] <= _aux_0_T_4 @[FS.scala 55:16]
    node _aux_1_T = bits(io.fork_mask, 1, 1) @[FS.scala 55:34]
    node _aux_1_T_1 = not(_aux_1_T) @[FS.scala 55:21]
    node _aux_1_T_2 = bits(io.ready_out, 1, 1) @[FS.scala 55:53]
    node _aux_1_T_3 = or(_aux_1_T_1, _aux_1_T_2) @[FS.scala 55:39]
    node _aux_1_T_4 = bits(_aux_1_T_3, 0, 0) @[FS.scala 55:58]
    aux[1] <= _aux_1_T_4 @[FS.scala 55:16]
    node _aux_2_T = bits(io.fork_mask, 2, 2) @[FS.scala 55:34]
    node _aux_2_T_1 = not(_aux_2_T) @[FS.scala 55:21]
    node _aux_2_T_2 = bits(io.ready_out, 2, 2) @[FS.scala 55:53]
    node _aux_2_T_3 = or(_aux_2_T_1, _aux_2_T_2) @[FS.scala 55:39]
    node _aux_2_T_4 = bits(_aux_2_T_3, 0, 0) @[FS.scala 55:58]
    aux[2] <= _aux_2_T_4 @[FS.scala 55:16]
    node _aux_3_T = bits(io.fork_mask, 3, 3) @[FS.scala 55:34]
    node _aux_3_T_1 = not(_aux_3_T) @[FS.scala 55:21]
    node _aux_3_T_2 = bits(io.ready_out, 3, 3) @[FS.scala 55:53]
    node _aux_3_T_3 = or(_aux_3_T_1, _aux_3_T_2) @[FS.scala 55:39]
    node _aux_3_T_4 = bits(_aux_3_T_3, 0, 0) @[FS.scala 55:58]
    aux[3] <= _aux_3_T_4 @[FS.scala 55:16]
    node _aux_4_T = bits(io.fork_mask, 4, 4) @[FS.scala 55:34]
    node _aux_4_T_1 = not(_aux_4_T) @[FS.scala 55:21]
    node _aux_4_T_2 = bits(io.ready_out, 4, 4) @[FS.scala 55:53]
    node _aux_4_T_3 = or(_aux_4_T_1, _aux_4_T_2) @[FS.scala 55:39]
    node _aux_4_T_4 = bits(_aux_4_T_3, 0, 0) @[FS.scala 55:58]
    aux[4] <= _aux_4_T_4 @[FS.scala 55:16]
    temp[0] <= aux[0] @[FS.scala 58:13]
    node _temp_1_T = and(temp[0], aux[1]) @[FS.scala 61:30]
    temp[1] <= _temp_1_T @[FS.scala 61:17]
    node _temp_2_T = and(temp[1], aux[2]) @[FS.scala 61:30]
    temp[2] <= _temp_2_T @[FS.scala 61:17]
    node _temp_3_T = and(temp[2], aux[3]) @[FS.scala 61:30]
    temp[3] <= _temp_3_T @[FS.scala 61:17]
    node _temp_4_T = and(temp[3], aux[4]) @[FS.scala 61:30]
    temp[4] <= _temp_4_T @[FS.scala 61:17]
    node _io_ready_in_T = bits(temp[4], 0, 0) @[FS.scala 64:47]
    io.ready_in <= _io_ready_in_T @[FS.scala 64:17]

  module ConfMux_6 :
    input clock : Clock
    input reset : Reset
    output io : { flip selector : UInt<2>, flip mux_input : SInt<128>, mux_output : SInt<32>}

    wire inputs : SInt<32>[4] @[ConfMux.scala 25:22]
    node _inputs_0_T = bits(io.mux_input, 31, 0) @[ConfMux.scala 28:35]
    node _inputs_0_T_1 = asSInt(_inputs_0_T) @[ConfMux.scala 28:70]
    inputs[0] <= _inputs_0_T_1 @[ConfMux.scala 28:19]
    node _inputs_1_T = bits(io.mux_input, 63, 32) @[ConfMux.scala 28:35]
    node _inputs_1_T_1 = asSInt(_inputs_1_T) @[ConfMux.scala 28:70]
    inputs[1] <= _inputs_1_T_1 @[ConfMux.scala 28:19]
    node _inputs_2_T = bits(io.mux_input, 95, 64) @[ConfMux.scala 28:35]
    node _inputs_2_T_1 = asSInt(_inputs_2_T) @[ConfMux.scala 28:70]
    inputs[2] <= _inputs_2_T_1 @[ConfMux.scala 28:19]
    node _inputs_3_T = bits(io.mux_input, 127, 96) @[ConfMux.scala 28:35]
    node _inputs_3_T_1 = asSInt(_inputs_3_T) @[ConfMux.scala 28:70]
    inputs[3] <= _inputs_3_T_1 @[ConfMux.scala 28:19]
    io.mux_output <= inputs[io.selector] @[ConfMux.scala 30:19]

  module ConfMux_7 :
    input clock : Clock
    input reset : Reset
    output io : { flip selector : UInt<2>, flip mux_input : SInt<4>, mux_output : SInt<1>}

    wire inputs : SInt<1>[4] @[ConfMux.scala 25:22]
    node _inputs_0_T = bits(io.mux_input, 0, 0) @[ConfMux.scala 28:35]
    node _inputs_0_T_1 = asSInt(_inputs_0_T) @[ConfMux.scala 28:70]
    inputs[0] <= _inputs_0_T_1 @[ConfMux.scala 28:19]
    node _inputs_1_T = bits(io.mux_input, 1, 1) @[ConfMux.scala 28:35]
    node _inputs_1_T_1 = asSInt(_inputs_1_T) @[ConfMux.scala 28:70]
    inputs[1] <= _inputs_1_T_1 @[ConfMux.scala 28:19]
    node _inputs_2_T = bits(io.mux_input, 2, 2) @[ConfMux.scala 28:35]
    node _inputs_2_T_1 = asSInt(_inputs_2_T) @[ConfMux.scala 28:70]
    inputs[2] <= _inputs_2_T_1 @[ConfMux.scala 28:19]
    node _inputs_3_T = bits(io.mux_input, 3, 3) @[ConfMux.scala 28:35]
    node _inputs_3_T_1 = asSInt(_inputs_3_T) @[ConfMux.scala 28:70]
    inputs[3] <= _inputs_3_T_1 @[ConfMux.scala 28:19]
    io.mux_output <= inputs[io.selector] @[ConfMux.scala 30:19]

  module FR_3 :
    input clock : Clock
    input reset : Reset
    output io : { flip valid_in : UInt<4>, flip ready_out : UInt<5>, flip valid_mux_sel : UInt<2>, flip fork_mask : UInt<5>, valid_out : UInt<1>}

    wire aux : UInt<1>[6] @[FR.scala 54:19]
    wire temp : UInt<1>[6] @[FR.scala 55:20]
    wire Vaux : SInt<1> @[FR.scala 56:20]
    node _aux_0_T = bits(io.fork_mask, 0, 0) @[FR.scala 59:34]
    node _aux_0_T_1 = not(_aux_0_T) @[FR.scala 59:21]
    node _aux_0_T_2 = bits(io.ready_out, 0, 0) @[FR.scala 59:53]
    node _aux_0_T_3 = or(_aux_0_T_1, _aux_0_T_2) @[FR.scala 59:39]
    node _aux_0_T_4 = bits(_aux_0_T_3, 0, 0) @[FR.scala 59:58]
    aux[0] <= _aux_0_T_4 @[FR.scala 59:16]
    node _aux_1_T = bits(io.fork_mask, 1, 1) @[FR.scala 59:34]
    node _aux_1_T_1 = not(_aux_1_T) @[FR.scala 59:21]
    node _aux_1_T_2 = bits(io.ready_out, 1, 1) @[FR.scala 59:53]
    node _aux_1_T_3 = or(_aux_1_T_1, _aux_1_T_2) @[FR.scala 59:39]
    node _aux_1_T_4 = bits(_aux_1_T_3, 0, 0) @[FR.scala 59:58]
    aux[1] <= _aux_1_T_4 @[FR.scala 59:16]
    node _aux_2_T = bits(io.fork_mask, 2, 2) @[FR.scala 59:34]
    node _aux_2_T_1 = not(_aux_2_T) @[FR.scala 59:21]
    node _aux_2_T_2 = bits(io.ready_out, 2, 2) @[FR.scala 59:53]
    node _aux_2_T_3 = or(_aux_2_T_1, _aux_2_T_2) @[FR.scala 59:39]
    node _aux_2_T_4 = bits(_aux_2_T_3, 0, 0) @[FR.scala 59:58]
    aux[2] <= _aux_2_T_4 @[FR.scala 59:16]
    node _aux_3_T = bits(io.fork_mask, 3, 3) @[FR.scala 59:34]
    node _aux_3_T_1 = not(_aux_3_T) @[FR.scala 59:21]
    node _aux_3_T_2 = bits(io.ready_out, 3, 3) @[FR.scala 59:53]
    node _aux_3_T_3 = or(_aux_3_T_1, _aux_3_T_2) @[FR.scala 59:39]
    node _aux_3_T_4 = bits(_aux_3_T_3, 0, 0) @[FR.scala 59:58]
    aux[3] <= _aux_3_T_4 @[FR.scala 59:16]
    node _aux_4_T = bits(io.fork_mask, 4, 4) @[FR.scala 59:34]
    node _aux_4_T_1 = not(_aux_4_T) @[FR.scala 59:21]
    node _aux_4_T_2 = bits(io.ready_out, 4, 4) @[FR.scala 59:53]
    node _aux_4_T_3 = or(_aux_4_T_1, _aux_4_T_2) @[FR.scala 59:39]
    node _aux_4_T_4 = bits(_aux_4_T_3, 0, 0) @[FR.scala 59:58]
    aux[4] <= _aux_4_T_4 @[FR.scala 59:16]
    inst conf_mux of ConfMux_7 @[FR.scala 61:28]
    conf_mux.clock <= clock
    conf_mux.reset <= reset
    conf_mux.io.selector <= io.valid_mux_sel @[FR.scala 62:26]
    node _conf_mux_io_mux_input_T = asSInt(io.valid_in) @[FR.scala 63:44]
    conf_mux.io.mux_input <= _conf_mux_io_mux_input_T @[FR.scala 63:27]
    Vaux <= conf_mux.io.mux_output @[FR.scala 64:10]
    node _aux_5_T = bits(Vaux, 0, 0) @[FR.scala 66:34]
    node _aux_5_T_1 = bits(_aux_5_T, 0, 0) @[FR.scala 66:38]
    aux[5] <= _aux_5_T_1 @[FR.scala 66:27]
    temp[0] <= aux[0] @[FR.scala 67:13]
    node _temp_1_T = and(temp[0], aux[1]) @[FR.scala 70:30]
    temp[1] <= _temp_1_T @[FR.scala 70:17]
    node _temp_2_T = and(temp[1], aux[2]) @[FR.scala 70:30]
    temp[2] <= _temp_2_T @[FR.scala 70:17]
    node _temp_3_T = and(temp[2], aux[3]) @[FR.scala 70:30]
    temp[3] <= _temp_3_T @[FR.scala 70:17]
    node _temp_4_T = and(temp[3], aux[4]) @[FR.scala 70:30]
    temp[4] <= _temp_4_T @[FR.scala 70:17]
    node _temp_5_T = and(temp[4], aux[5]) @[FR.scala 70:30]
    temp[5] <= _temp_5_T @[FR.scala 70:17]
    io.valid_out <= temp[5] @[FR.scala 72:18]

  module D_REG_3 :
    input clock : Clock
    input reset : Reset
    output io : { flip din : SInt<32>, flip din_v : UInt<1>, flip dout_r : UInt<1>, dout : SInt<32>, dout_v : UInt<1>, din_r : UInt<1>}

    reg data : SInt<32>, clock with :
      reset => (reset, asSInt(UInt<32>("h0"))) @[D_REG.scala 52:23]
    reg valid : UInt<1>, clock with :
      reset => (reset, UInt<1>("h0")) @[D_REG.scala 53:24]
    data <= asSInt(UInt<1>("h0")) @[D_REG.scala 56:10]
    valid <= UInt<1>("h0") @[D_REG.scala 57:11]
    node _T = eq(io.dout_r, UInt<1>("h1")) @[D_REG.scala 59:21]
    when _T : @[D_REG.scala 59:33]
      data <= io.din @[D_REG.scala 60:14]
      valid <= io.din_v @[D_REG.scala 61:15]
    io.dout <= data @[D_REG.scala 64:13]
    io.dout_v <= valid @[D_REG.scala 65:15]
    io.din_r <= io.dout_r @[D_REG.scala 66:14]

  module ConfMux_8 :
    input clock : Clock
    input reset : Reset
    output io : { flip selector : UInt<3>, flip mux_input : SInt<6>, mux_output : SInt<1>}

    wire inputs : SInt<1>[6] @[ConfMux.scala 25:22]
    node _inputs_0_T = bits(io.mux_input, 0, 0) @[ConfMux.scala 28:35]
    node _inputs_0_T_1 = asSInt(_inputs_0_T) @[ConfMux.scala 28:70]
    inputs[0] <= _inputs_0_T_1 @[ConfMux.scala 28:19]
    node _inputs_1_T = bits(io.mux_input, 1, 1) @[ConfMux.scala 28:35]
    node _inputs_1_T_1 = asSInt(_inputs_1_T) @[ConfMux.scala 28:70]
    inputs[1] <= _inputs_1_T_1 @[ConfMux.scala 28:19]
    node _inputs_2_T = bits(io.mux_input, 2, 2) @[ConfMux.scala 28:35]
    node _inputs_2_T_1 = asSInt(_inputs_2_T) @[ConfMux.scala 28:70]
    inputs[2] <= _inputs_2_T_1 @[ConfMux.scala 28:19]
    node _inputs_3_T = bits(io.mux_input, 3, 3) @[ConfMux.scala 28:35]
    node _inputs_3_T_1 = asSInt(_inputs_3_T) @[ConfMux.scala 28:70]
    inputs[3] <= _inputs_3_T_1 @[ConfMux.scala 28:19]
    node _inputs_4_T = bits(io.mux_input, 4, 4) @[ConfMux.scala 28:35]
    node _inputs_4_T_1 = asSInt(_inputs_4_T) @[ConfMux.scala 28:70]
    inputs[4] <= _inputs_4_T_1 @[ConfMux.scala 28:19]
    node _inputs_5_T = bits(io.mux_input, 5, 5) @[ConfMux.scala 28:35]
    node _inputs_5_T_1 = asSInt(_inputs_5_T) @[ConfMux.scala 28:70]
    inputs[5] <= _inputs_5_T_1 @[ConfMux.scala 28:19]
    io.mux_output <= inputs[io.selector] @[ConfMux.scala 30:19]

  module FR_4 :
    input clock : Clock
    input reset : Reset
    output io : { flip valid_in : UInt<6>, flip ready_out : UInt<4>, flip valid_mux_sel : UInt<3>, flip fork_mask : UInt<4>, valid_out : UInt<1>}

    wire aux : UInt<1>[5] @[FR.scala 54:19]
    wire temp : UInt<1>[5] @[FR.scala 55:20]
    wire Vaux : SInt<1> @[FR.scala 56:20]
    node _aux_0_T = bits(io.fork_mask, 0, 0) @[FR.scala 59:34]
    node _aux_0_T_1 = not(_aux_0_T) @[FR.scala 59:21]
    node _aux_0_T_2 = bits(io.ready_out, 0, 0) @[FR.scala 59:53]
    node _aux_0_T_3 = or(_aux_0_T_1, _aux_0_T_2) @[FR.scala 59:39]
    node _aux_0_T_4 = bits(_aux_0_T_3, 0, 0) @[FR.scala 59:58]
    aux[0] <= _aux_0_T_4 @[FR.scala 59:16]
    node _aux_1_T = bits(io.fork_mask, 1, 1) @[FR.scala 59:34]
    node _aux_1_T_1 = not(_aux_1_T) @[FR.scala 59:21]
    node _aux_1_T_2 = bits(io.ready_out, 1, 1) @[FR.scala 59:53]
    node _aux_1_T_3 = or(_aux_1_T_1, _aux_1_T_2) @[FR.scala 59:39]
    node _aux_1_T_4 = bits(_aux_1_T_3, 0, 0) @[FR.scala 59:58]
    aux[1] <= _aux_1_T_4 @[FR.scala 59:16]
    node _aux_2_T = bits(io.fork_mask, 2, 2) @[FR.scala 59:34]
    node _aux_2_T_1 = not(_aux_2_T) @[FR.scala 59:21]
    node _aux_2_T_2 = bits(io.ready_out, 2, 2) @[FR.scala 59:53]
    node _aux_2_T_3 = or(_aux_2_T_1, _aux_2_T_2) @[FR.scala 59:39]
    node _aux_2_T_4 = bits(_aux_2_T_3, 0, 0) @[FR.scala 59:58]
    aux[2] <= _aux_2_T_4 @[FR.scala 59:16]
    node _aux_3_T = bits(io.fork_mask, 3, 3) @[FR.scala 59:34]
    node _aux_3_T_1 = not(_aux_3_T) @[FR.scala 59:21]
    node _aux_3_T_2 = bits(io.ready_out, 3, 3) @[FR.scala 59:53]
    node _aux_3_T_3 = or(_aux_3_T_1, _aux_3_T_2) @[FR.scala 59:39]
    node _aux_3_T_4 = bits(_aux_3_T_3, 0, 0) @[FR.scala 59:58]
    aux[3] <= _aux_3_T_4 @[FR.scala 59:16]
    inst conf_mux of ConfMux_8 @[FR.scala 61:28]
    conf_mux.clock <= clock
    conf_mux.reset <= reset
    conf_mux.io.selector <= io.valid_mux_sel @[FR.scala 62:26]
    node _conf_mux_io_mux_input_T = asSInt(io.valid_in) @[FR.scala 63:44]
    conf_mux.io.mux_input <= _conf_mux_io_mux_input_T @[FR.scala 63:27]
    Vaux <= conf_mux.io.mux_output @[FR.scala 64:10]
    node _aux_4_T = bits(Vaux, 0, 0) @[FR.scala 66:34]
    node _aux_4_T_1 = bits(_aux_4_T, 0, 0) @[FR.scala 66:38]
    aux[4] <= _aux_4_T_1 @[FR.scala 66:27]
    temp[0] <= aux[0] @[FR.scala 67:13]
    node _temp_1_T = and(temp[0], aux[1]) @[FR.scala 70:30]
    temp[1] <= _temp_1_T @[FR.scala 70:17]
    node _temp_2_T = and(temp[1], aux[2]) @[FR.scala 70:30]
    temp[2] <= _temp_2_T @[FR.scala 70:17]
    node _temp_3_T = and(temp[2], aux[3]) @[FR.scala 70:30]
    temp[3] <= _temp_3_T @[FR.scala 70:17]
    node _temp_4_T = and(temp[3], aux[4]) @[FR.scala 70:30]
    temp[4] <= _temp_4_T @[FR.scala 70:17]
    io.valid_out <= temp[4] @[FR.scala 72:18]

  module ConfMux_9 :
    input clock : Clock
    input reset : Reset
    output io : { flip selector : UInt<3>, flip mux_input : SInt<192>, mux_output : SInt<32>}

    wire inputs : SInt<32>[6] @[ConfMux.scala 25:22]
    node _inputs_0_T = bits(io.mux_input, 31, 0) @[ConfMux.scala 28:35]
    node _inputs_0_T_1 = asSInt(_inputs_0_T) @[ConfMux.scala 28:70]
    inputs[0] <= _inputs_0_T_1 @[ConfMux.scala 28:19]
    node _inputs_1_T = bits(io.mux_input, 63, 32) @[ConfMux.scala 28:35]
    node _inputs_1_T_1 = asSInt(_inputs_1_T) @[ConfMux.scala 28:70]
    inputs[1] <= _inputs_1_T_1 @[ConfMux.scala 28:19]
    node _inputs_2_T = bits(io.mux_input, 95, 64) @[ConfMux.scala 28:35]
    node _inputs_2_T_1 = asSInt(_inputs_2_T) @[ConfMux.scala 28:70]
    inputs[2] <= _inputs_2_T_1 @[ConfMux.scala 28:19]
    node _inputs_3_T = bits(io.mux_input, 127, 96) @[ConfMux.scala 28:35]
    node _inputs_3_T_1 = asSInt(_inputs_3_T) @[ConfMux.scala 28:70]
    inputs[3] <= _inputs_3_T_1 @[ConfMux.scala 28:19]
    node _inputs_4_T = bits(io.mux_input, 159, 128) @[ConfMux.scala 28:35]
    node _inputs_4_T_1 = asSInt(_inputs_4_T) @[ConfMux.scala 28:70]
    inputs[4] <= _inputs_4_T_1 @[ConfMux.scala 28:19]
    node _inputs_5_T = bits(io.mux_input, 191, 160) @[ConfMux.scala 28:35]
    node _inputs_5_T_1 = asSInt(_inputs_5_T) @[ConfMux.scala 28:70]
    inputs[5] <= _inputs_5_T_1 @[ConfMux.scala 28:19]
    io.mux_output <= inputs[io.selector] @[ConfMux.scala 30:19]

  module D_EB :
    input clock : Clock
    input reset : Reset
    output io : { flip din : SInt<32>, flip din_v : UInt<1>, din_r : UInt<1>, dout : SInt<32>, dout_v : UInt<1>, flip dout_r : UInt<1>}

    reg reg_din_1 : SInt<32>, clock with :
      reset => (reset, asSInt(UInt<32>("h0"))) @[D_EB.scala 54:28]
    reg reg_din_2 : SInt<32>, clock with :
      reset => (reset, asSInt(UInt<32>("h0"))) @[D_EB.scala 55:28]
    reg reg_din_v_1 : UInt<1>, clock with :
      reset => (reset, UInt<1>("h0")) @[D_EB.scala 56:30]
    reg reg_din_v_2 : UInt<1>, clock with :
      reset => (reset, UInt<1>("h0")) @[D_EB.scala 57:30]
    reg reg_areg : UInt<1>, clock with :
      reset => (reset, UInt<1>("h0")) @[D_EB.scala 58:27]
    when reg_areg : @[D_EB.scala 60:20]
      reg_din_1 <= io.din @[D_EB.scala 61:19]
      reg_din_2 <= reg_din_1 @[D_EB.scala 62:19]
      reg_din_v_1 <= io.din_v @[D_EB.scala 64:21]
      reg_din_v_2 <= reg_din_v_1 @[D_EB.scala 65:21]
    node _reg_areg_T = not(io.dout_v) @[D_EB.scala 68:17]
    node _reg_areg_T_1 = or(_reg_areg_T, io.dout_r) @[D_EB.scala 68:28]
    reg_areg <= _reg_areg_T_1 @[D_EB.scala 68:14]
    io.din_r <= reg_areg @[D_EB.scala 71:14]
    when reg_areg : @[D_EB.scala 73:20]
      io.dout <= reg_din_1 @[D_EB.scala 74:17]
      io.dout_v <= reg_din_v_1 @[D_EB.scala 75:19]
    else :
      io.dout <= reg_din_2 @[D_EB.scala 77:17]
      io.dout_v <= reg_din_v_2 @[D_EB.scala 78:19]

  module ConfMux_10 :
    input clock : Clock
    input reset : Reset
    output io : { flip selector : UInt<3>, flip mux_input : SInt<6>, mux_output : SInt<1>}

    wire inputs : SInt<1>[6] @[ConfMux.scala 25:22]
    node _inputs_0_T = bits(io.mux_input, 0, 0) @[ConfMux.scala 28:35]
    node _inputs_0_T_1 = asSInt(_inputs_0_T) @[ConfMux.scala 28:70]
    inputs[0] <= _inputs_0_T_1 @[ConfMux.scala 28:19]
    node _inputs_1_T = bits(io.mux_input, 1, 1) @[ConfMux.scala 28:35]
    node _inputs_1_T_1 = asSInt(_inputs_1_T) @[ConfMux.scala 28:70]
    inputs[1] <= _inputs_1_T_1 @[ConfMux.scala 28:19]
    node _inputs_2_T = bits(io.mux_input, 2, 2) @[ConfMux.scala 28:35]
    node _inputs_2_T_1 = asSInt(_inputs_2_T) @[ConfMux.scala 28:70]
    inputs[2] <= _inputs_2_T_1 @[ConfMux.scala 28:19]
    node _inputs_3_T = bits(io.mux_input, 3, 3) @[ConfMux.scala 28:35]
    node _inputs_3_T_1 = asSInt(_inputs_3_T) @[ConfMux.scala 28:70]
    inputs[3] <= _inputs_3_T_1 @[ConfMux.scala 28:19]
    node _inputs_4_T = bits(io.mux_input, 4, 4) @[ConfMux.scala 28:35]
    node _inputs_4_T_1 = asSInt(_inputs_4_T) @[ConfMux.scala 28:70]
    inputs[4] <= _inputs_4_T_1 @[ConfMux.scala 28:19]
    node _inputs_5_T = bits(io.mux_input, 5, 5) @[ConfMux.scala 28:35]
    node _inputs_5_T_1 = asSInt(_inputs_5_T) @[ConfMux.scala 28:70]
    inputs[5] <= _inputs_5_T_1 @[ConfMux.scala 28:19]
    io.mux_output <= inputs[io.selector] @[ConfMux.scala 30:19]

  module FR_5 :
    input clock : Clock
    input reset : Reset
    output io : { flip valid_in : UInt<6>, flip ready_out : UInt<4>, flip valid_mux_sel : UInt<3>, flip fork_mask : UInt<4>, valid_out : UInt<1>}

    wire aux : UInt<1>[5] @[FR.scala 54:19]
    wire temp : UInt<1>[5] @[FR.scala 55:20]
    wire Vaux : SInt<1> @[FR.scala 56:20]
    node _aux_0_T = bits(io.fork_mask, 0, 0) @[FR.scala 59:34]
    node _aux_0_T_1 = not(_aux_0_T) @[FR.scala 59:21]
    node _aux_0_T_2 = bits(io.ready_out, 0, 0) @[FR.scala 59:53]
    node _aux_0_T_3 = or(_aux_0_T_1, _aux_0_T_2) @[FR.scala 59:39]
    node _aux_0_T_4 = bits(_aux_0_T_3, 0, 0) @[FR.scala 59:58]
    aux[0] <= _aux_0_T_4 @[FR.scala 59:16]
    node _aux_1_T = bits(io.fork_mask, 1, 1) @[FR.scala 59:34]
    node _aux_1_T_1 = not(_aux_1_T) @[FR.scala 59:21]
    node _aux_1_T_2 = bits(io.ready_out, 1, 1) @[FR.scala 59:53]
    node _aux_1_T_3 = or(_aux_1_T_1, _aux_1_T_2) @[FR.scala 59:39]
    node _aux_1_T_4 = bits(_aux_1_T_3, 0, 0) @[FR.scala 59:58]
    aux[1] <= _aux_1_T_4 @[FR.scala 59:16]
    node _aux_2_T = bits(io.fork_mask, 2, 2) @[FR.scala 59:34]
    node _aux_2_T_1 = not(_aux_2_T) @[FR.scala 59:21]
    node _aux_2_T_2 = bits(io.ready_out, 2, 2) @[FR.scala 59:53]
    node _aux_2_T_3 = or(_aux_2_T_1, _aux_2_T_2) @[FR.scala 59:39]
    node _aux_2_T_4 = bits(_aux_2_T_3, 0, 0) @[FR.scala 59:58]
    aux[2] <= _aux_2_T_4 @[FR.scala 59:16]
    node _aux_3_T = bits(io.fork_mask, 3, 3) @[FR.scala 59:34]
    node _aux_3_T_1 = not(_aux_3_T) @[FR.scala 59:21]
    node _aux_3_T_2 = bits(io.ready_out, 3, 3) @[FR.scala 59:53]
    node _aux_3_T_3 = or(_aux_3_T_1, _aux_3_T_2) @[FR.scala 59:39]
    node _aux_3_T_4 = bits(_aux_3_T_3, 0, 0) @[FR.scala 59:58]
    aux[3] <= _aux_3_T_4 @[FR.scala 59:16]
    inst conf_mux of ConfMux_10 @[FR.scala 61:28]
    conf_mux.clock <= clock
    conf_mux.reset <= reset
    conf_mux.io.selector <= io.valid_mux_sel @[FR.scala 62:26]
    node _conf_mux_io_mux_input_T = asSInt(io.valid_in) @[FR.scala 63:44]
    conf_mux.io.mux_input <= _conf_mux_io_mux_input_T @[FR.scala 63:27]
    Vaux <= conf_mux.io.mux_output @[FR.scala 64:10]
    node _aux_4_T = bits(Vaux, 0, 0) @[FR.scala 66:34]
    node _aux_4_T_1 = bits(_aux_4_T, 0, 0) @[FR.scala 66:38]
    aux[4] <= _aux_4_T_1 @[FR.scala 66:27]
    temp[0] <= aux[0] @[FR.scala 67:13]
    node _temp_1_T = and(temp[0], aux[1]) @[FR.scala 70:30]
    temp[1] <= _temp_1_T @[FR.scala 70:17]
    node _temp_2_T = and(temp[1], aux[2]) @[FR.scala 70:30]
    temp[2] <= _temp_2_T @[FR.scala 70:17]
    node _temp_3_T = and(temp[2], aux[3]) @[FR.scala 70:30]
    temp[3] <= _temp_3_T @[FR.scala 70:17]
    node _temp_4_T = and(temp[3], aux[4]) @[FR.scala 70:30]
    temp[4] <= _temp_4_T @[FR.scala 70:17]
    io.valid_out <= temp[4] @[FR.scala 72:18]

  module ConfMux_11 :
    input clock : Clock
    input reset : Reset
    output io : { flip selector : UInt<3>, flip mux_input : SInt<192>, mux_output : SInt<32>}

    wire inputs : SInt<32>[6] @[ConfMux.scala 25:22]
    node _inputs_0_T = bits(io.mux_input, 31, 0) @[ConfMux.scala 28:35]
    node _inputs_0_T_1 = asSInt(_inputs_0_T) @[ConfMux.scala 28:70]
    inputs[0] <= _inputs_0_T_1 @[ConfMux.scala 28:19]
    node _inputs_1_T = bits(io.mux_input, 63, 32) @[ConfMux.scala 28:35]
    node _inputs_1_T_1 = asSInt(_inputs_1_T) @[ConfMux.scala 28:70]
    inputs[1] <= _inputs_1_T_1 @[ConfMux.scala 28:19]
    node _inputs_2_T = bits(io.mux_input, 95, 64) @[ConfMux.scala 28:35]
    node _inputs_2_T_1 = asSInt(_inputs_2_T) @[ConfMux.scala 28:70]
    inputs[2] <= _inputs_2_T_1 @[ConfMux.scala 28:19]
    node _inputs_3_T = bits(io.mux_input, 127, 96) @[ConfMux.scala 28:35]
    node _inputs_3_T_1 = asSInt(_inputs_3_T) @[ConfMux.scala 28:70]
    inputs[3] <= _inputs_3_T_1 @[ConfMux.scala 28:19]
    node _inputs_4_T = bits(io.mux_input, 159, 128) @[ConfMux.scala 28:35]
    node _inputs_4_T_1 = asSInt(_inputs_4_T) @[ConfMux.scala 28:70]
    inputs[4] <= _inputs_4_T_1 @[ConfMux.scala 28:19]
    node _inputs_5_T = bits(io.mux_input, 191, 160) @[ConfMux.scala 28:35]
    node _inputs_5_T_1 = asSInt(_inputs_5_T) @[ConfMux.scala 28:70]
    inputs[5] <= _inputs_5_T_1 @[ConfMux.scala 28:19]
    io.mux_output <= inputs[io.selector] @[ConfMux.scala 30:19]

  module D_EB_1 :
    input clock : Clock
    input reset : Reset
    output io : { flip din : SInt<32>, flip din_v : UInt<1>, din_r : UInt<1>, dout : SInt<32>, dout_v : UInt<1>, flip dout_r : UInt<1>}

    reg reg_din_1 : SInt<32>, clock with :
      reset => (reset, asSInt(UInt<32>("h0"))) @[D_EB.scala 54:28]
    reg reg_din_2 : SInt<32>, clock with :
      reset => (reset, asSInt(UInt<32>("h0"))) @[D_EB.scala 55:28]
    reg reg_din_v_1 : UInt<1>, clock with :
      reset => (reset, UInt<1>("h0")) @[D_EB.scala 56:30]
    reg reg_din_v_2 : UInt<1>, clock with :
      reset => (reset, UInt<1>("h0")) @[D_EB.scala 57:30]
    reg reg_areg : UInt<1>, clock with :
      reset => (reset, UInt<1>("h0")) @[D_EB.scala 58:27]
    when reg_areg : @[D_EB.scala 60:20]
      reg_din_1 <= io.din @[D_EB.scala 61:19]
      reg_din_2 <= reg_din_1 @[D_EB.scala 62:19]
      reg_din_v_1 <= io.din_v @[D_EB.scala 64:21]
      reg_din_v_2 <= reg_din_v_1 @[D_EB.scala 65:21]
    node _reg_areg_T = not(io.dout_v) @[D_EB.scala 68:17]
    node _reg_areg_T_1 = or(_reg_areg_T, io.dout_r) @[D_EB.scala 68:28]
    reg_areg <= _reg_areg_T_1 @[D_EB.scala 68:14]
    io.din_r <= reg_areg @[D_EB.scala 71:14]
    when reg_areg : @[D_EB.scala 73:20]
      io.dout <= reg_din_1 @[D_EB.scala 74:17]
      io.dout_v <= reg_din_v_1 @[D_EB.scala 75:19]
    else :
      io.dout <= reg_din_2 @[D_EB.scala 77:17]
      io.dout_v <= reg_din_v_2 @[D_EB.scala 78:19]

  module Join :
    input clock : Clock
    input reset : Reset
    output io : { flip din_1 : SInt<32>, flip din_2 : SInt<32>, flip dout_r : UInt<1>, flip din_1_v : UInt<1>, flip din_2_v : UInt<1>, dout_v : UInt<1>, din_1_r : UInt<1>, din_2_r : UInt<1>, dout_1 : SInt<32>, dout_2 : SInt<32>}

    io.dout_1 <= io.din_1 @[Join.scala 58:15]
    io.dout_2 <= io.din_2 @[Join.scala 59:15]
    node _io_dout_v_T = and(io.din_1_v, io.din_2_v) @[Join.scala 61:29]
    io.dout_v <= _io_dout_v_T @[Join.scala 61:15]
    node _io_din_1_r_T = and(io.dout_r, io.din_2_v) @[Join.scala 63:29]
    io.din_1_r <= _io_din_1_r_T @[Join.scala 63:16]
    node _io_din_2_r_T = and(io.dout_r, io.din_1_v) @[Join.scala 64:29]
    io.din_2_r <= _io_din_2_r_T @[Join.scala 64:16]

  module ALU :
    input clock : Clock
    input reset : Reset
    output io : { flip din_1 : SInt<32>, flip din_2 : SInt<32>, flip op_config : UInt<5>, dout : SInt<32>}

    wire out_aux : SInt<32> @[ALU.scala 68:23]
    node _T = eq(io.op_config, UInt<1>("h0")) @[ALU.scala 70:24]
    when _T : @[ALU.scala 70:33]
      node _out_aux_T = add(io.din_1, io.din_2) @[ALU.scala 71:27]
      node _out_aux_T_1 = tail(_out_aux_T, 1) @[ALU.scala 71:27]
      node _out_aux_T_2 = asSInt(_out_aux_T_1) @[ALU.scala 71:27]
      out_aux <= _out_aux_T_2 @[ALU.scala 71:15]
    else :
      node _T_1 = eq(io.op_config, UInt<1>("h1")) @[ALU.scala 73:29]
      when _T_1 : @[ALU.scala 73:38]
        node _out_aux_T_3 = mul(io.din_1, io.din_2) @[ALU.scala 74:27]
        out_aux <= _out_aux_T_3 @[ALU.scala 74:15]
      else :
        node _T_2 = eq(io.op_config, UInt<2>("h2")) @[ALU.scala 76:29]
        when _T_2 : @[ALU.scala 76:38]
          node _out_aux_T_4 = sub(io.din_1, io.din_2) @[ALU.scala 77:27]
          node _out_aux_T_5 = tail(_out_aux_T_4, 1) @[ALU.scala 77:27]
          node _out_aux_T_6 = asSInt(_out_aux_T_5) @[ALU.scala 77:27]
          out_aux <= _out_aux_T_6 @[ALU.scala 77:15]
        else :
          node _T_3 = eq(io.op_config, UInt<2>("h3")) @[ALU.scala 79:29]
          when _T_3 : @[ALU.scala 79:38]
            node _out_aux_T_7 = bits(io.din_2, 18, 0) @[ALU.scala 81:39]
            node _out_aux_T_8 = dshl(io.din_1, _out_aux_T_7) @[ALU.scala 81:27]
            out_aux <= _out_aux_T_8 @[ALU.scala 81:15]
          else :
            node _T_4 = eq(io.op_config, UInt<3>("h4")) @[ALU.scala 83:29]
            when _T_4 : @[ALU.scala 83:38]
              node _out_aux_T_9 = asUInt(io.din_2) @[ALU.scala 84:39]
              node _out_aux_T_10 = dshr(io.din_1, _out_aux_T_9) @[ALU.scala 84:27]
              out_aux <= _out_aux_T_10 @[ALU.scala 84:15]
            else :
              node _T_5 = eq(io.op_config, UInt<3>("h5")) @[ALU.scala 86:29]
              when _T_5 : @[ALU.scala 86:38]
                node _out_aux_T_11 = asUInt(io.din_1) @[ALU.scala 87:28]
                node _out_aux_T_12 = asUInt(io.din_2) @[ALU.scala 87:47]
                node _out_aux_T_13 = dshr(_out_aux_T_11, _out_aux_T_12) @[ALU.scala 87:35]
                node _out_aux_T_14 = asSInt(_out_aux_T_13) @[ALU.scala 87:55]
                out_aux <= _out_aux_T_14 @[ALU.scala 87:15]
              else :
                node _T_6 = eq(io.op_config, UInt<3>("h6")) @[ALU.scala 89:29]
                when _T_6 : @[ALU.scala 89:38]
                  node _out_aux_T_15 = and(io.din_1, io.din_2) @[ALU.scala 90:27]
                  node _out_aux_T_16 = asSInt(_out_aux_T_15) @[ALU.scala 90:27]
                  out_aux <= _out_aux_T_16 @[ALU.scala 90:15]
                else :
                  node _T_7 = eq(io.op_config, UInt<3>("h7")) @[ALU.scala 92:29]
                  when _T_7 : @[ALU.scala 92:37]
                    node _out_aux_T_17 = or(io.din_1, io.din_2) @[ALU.scala 93:27]
                    node _out_aux_T_18 = asSInt(_out_aux_T_17) @[ALU.scala 93:27]
                    out_aux <= _out_aux_T_18 @[ALU.scala 93:15]
                  else :
                    node _T_8 = eq(io.op_config, UInt<4>("h8")) @[ALU.scala 95:29]
                    when _T_8 : @[ALU.scala 95:38]
                      node _out_aux_T_19 = xor(io.din_1, io.din_2) @[ALU.scala 96:27]
                      node _out_aux_T_20 = asSInt(_out_aux_T_19) @[ALU.scala 96:27]
                      out_aux <= _out_aux_T_20 @[ALU.scala 96:15]
                    else :
                      out_aux <= asSInt(UInt<1>("h0")) @[ALU.scala 99:15]
    io.dout <= out_aux @[ALU.scala 102:11]

  module FU :
    input clock : Clock
    input reset : Reset
    output io : { flip din_1 : SInt<32>, flip din_2 : SInt<32>, flip din_v : UInt<1>, flip dout_r : UInt<1>, flip loop_source : UInt<2>, flip iterations_reset : UInt<16>, flip op_config : UInt<5>, din_r : UInt<1>, dout : SInt<32>, dout_v : UInt<1>}

    wire alu_din_1 : SInt<32> @[FU.scala 71:25]
    wire alu_din_2 : SInt<32> @[FU.scala 72:25]
    wire alu_dout : SInt<32> @[FU.scala 74:24]
    reg dout_reg : SInt<32>, clock with :
      reset => (reset, asSInt(UInt<32>("h0"))) @[FU.scala 76:27]
    reg count : UInt<16>, clock with :
      reset => (reset, UInt<16>("h0")) @[FU.scala 77:24]
    reg loaded : UInt<1>, clock with :
      reset => (reset, UInt<1>("h0")) @[FU.scala 78:25]
    reg valid : UInt<1>, clock with :
      reset => (reset, UInt<1>("h0")) @[FU.scala 79:24]
    inst ALU of ALU @[FU.scala 81:22]
    ALU.clock <= clock
    ALU.reset <= reset
    ALU.io.din_1 <= alu_din_1 @[FU.scala 82:18]
    ALU.io.din_2 <= alu_din_2 @[FU.scala 83:18]
    alu_dout <= ALU.io.dout @[FU.scala 84:14]
    ALU.io.op_config <= io.op_config @[FU.scala 85:22]
    node _T = eq(io.loop_source, UInt<2>("h0")) @[FU.scala 87:26]
    when _T : @[FU.scala 87:39]
      alu_din_1 <= io.din_1 @[FU.scala 88:19]
      alu_din_2 <= io.din_2 @[FU.scala 89:19]
    else :
      node _T_1 = eq(io.loop_source, UInt<2>("h1")) @[FU.scala 91:31]
      when _T_1 : @[FU.scala 91:44]
        node _T_2 = eq(loaded, UInt<1>("h0")) @[FU.scala 92:22]
        when _T_2 : @[FU.scala 92:31]
          alu_din_1 <= io.din_1 @[FU.scala 93:23]
          alu_din_2 <= io.din_2 @[FU.scala 94:23]
        else :
          alu_din_1 <= dout_reg @[FU.scala 98:23]
          alu_din_2 <= io.din_2 @[FU.scala 99:23]
      else :
        node _T_3 = eq(io.loop_source, UInt<2>("h2")) @[FU.scala 102:31]
        when _T_3 : @[FU.scala 102:44]
          node _T_4 = eq(loaded, UInt<1>("h0")) @[FU.scala 103:22]
          when _T_4 : @[FU.scala 103:31]
            alu_din_1 <= io.din_1 @[FU.scala 104:23]
            alu_din_2 <= io.din_2 @[FU.scala 105:23]
          else :
            alu_din_1 <= io.din_1 @[FU.scala 108:23]
            alu_din_2 <= dout_reg @[FU.scala 109:23]
        else :
          alu_din_1 <= asSInt(UInt<6>("h1f")) @[FU.scala 113:19]
          alu_din_2 <= asSInt(UInt<6>("h1f")) @[FU.scala 114:19]
    node _T_5 = eq(io.dout_r, UInt<1>("h1")) @[FU.scala 117:21]
    when _T_5 : @[FU.scala 117:30]
      valid <= UInt<1>("h0") @[FU.scala 118:15]
    node _T_6 = eq(io.din_v, UInt<1>("h1")) @[FU.scala 121:20]
    node _T_7 = eq(io.dout_r, UInt<1>("h1")) @[FU.scala 121:41]
    node _T_8 = and(_T_6, _T_7) @[FU.scala 121:28]
    node _T_9 = eq(io.loop_source, UInt<2>("h1")) @[FU.scala 122:29]
    node _T_10 = eq(io.loop_source, UInt<2>("h2")) @[FU.scala 122:59]
    node _T_11 = or(_T_9, _T_10) @[FU.scala 122:41]
    node _T_12 = and(_T_8, _T_11) @[FU.scala 121:49]
    when _T_12 : @[FU.scala 123:9]
      loaded <= UInt<1>("h1") @[FU.scala 124:16]
      node _count_T = add(count, UInt<1>("h1")) @[FU.scala 125:24]
      node _count_T_1 = tail(_count_T, 1) @[FU.scala 125:24]
      count <= _count_T_1 @[FU.scala 125:15]
    node _T_13 = sub(io.iterations_reset, UInt<1>("h1")) @[FU.scala 128:41]
    node _T_14 = tail(_T_13, 1) @[FU.scala 128:41]
    node _T_15 = eq(count, _T_14) @[FU.scala 128:17]
    node _T_16 = eq(io.loop_source, UInt<2>("h1")) @[FU.scala 129:29]
    node _T_17 = eq(io.loop_source, UInt<2>("h2")) @[FU.scala 129:59]
    node _T_18 = or(_T_16, _T_17) @[FU.scala 129:41]
    node _T_19 = and(_T_15, _T_18) @[FU.scala 128:47]
    node _T_20 = eq(io.dout_r, UInt<1>("h1")) @[FU.scala 130:23]
    node _T_21 = and(_T_19, _T_20) @[FU.scala 129:72]
    when _T_21 : @[FU.scala 131:9]
      count <= UInt<1>("h0") @[FU.scala 132:15]
      loaded <= UInt<1>("h0") @[FU.scala 133:16]
      valid <= UInt<1>("h1") @[FU.scala 134:15]
      dout_reg <= alu_dout @[FU.scala 135:18]
    else :
      node _T_22 = eq(io.loop_source, UInt<2>("h1")) @[FU.scala 137:32]
      node _T_23 = eq(io.loop_source, UInt<2>("h2")) @[FU.scala 137:62]
      node _T_24 = or(_T_22, _T_23) @[FU.scala 137:44]
      node _T_25 = eq(io.din_v, UInt<1>("h1")) @[FU.scala 138:26]
      node _T_26 = and(_T_24, _T_25) @[FU.scala 137:75]
      node _T_27 = eq(io.dout_r, UInt<1>("h1")) @[FU.scala 139:27]
      node _T_28 = and(_T_26, _T_27) @[FU.scala 138:34]
      when _T_28 : @[FU.scala 140:9]
        dout_reg <= alu_dout @[FU.scala 141:18]
    io.din_r <= io.dout_r @[FU.scala 144:14]
    node _T_29 = eq(io.loop_source, UInt<2>("h0")) @[FU.scala 146:26]
    when _T_29 : @[FU.scala 146:38]
      io.dout <= alu_dout @[FU.scala 147:17]
      io.dout_v <= io.din_v @[FU.scala 148:19]
    else :
      io.dout <= dout_reg @[FU.scala 151:17]
      io.dout_v <= valid @[FU.scala 152:19]

  module D_EB_2 :
    input clock : Clock
    input reset : Reset
    output io : { flip din : SInt<32>, flip din_v : UInt<1>, din_r : UInt<1>, dout : SInt<32>, dout_v : UInt<1>, flip dout_r : UInt<1>}

    reg reg_din_1 : SInt<32>, clock with :
      reset => (reset, asSInt(UInt<32>("h0"))) @[D_EB.scala 54:28]
    reg reg_din_2 : SInt<32>, clock with :
      reset => (reset, asSInt(UInt<32>("h0"))) @[D_EB.scala 55:28]
    reg reg_din_v_1 : UInt<1>, clock with :
      reset => (reset, UInt<1>("h0")) @[D_EB.scala 56:30]
    reg reg_din_v_2 : UInt<1>, clock with :
      reset => (reset, UInt<1>("h0")) @[D_EB.scala 57:30]
    reg reg_areg : UInt<1>, clock with :
      reset => (reset, UInt<1>("h0")) @[D_EB.scala 58:27]
    when reg_areg : @[D_EB.scala 60:20]
      reg_din_1 <= io.din @[D_EB.scala 61:19]
      reg_din_2 <= reg_din_1 @[D_EB.scala 62:19]
      reg_din_v_1 <= io.din_v @[D_EB.scala 64:21]
      reg_din_v_2 <= reg_din_v_1 @[D_EB.scala 65:21]
    node _reg_areg_T = not(io.dout_v) @[D_EB.scala 68:17]
    node _reg_areg_T_1 = or(_reg_areg_T, io.dout_r) @[D_EB.scala 68:28]
    reg_areg <= _reg_areg_T_1 @[D_EB.scala 68:14]
    io.din_r <= reg_areg @[D_EB.scala 71:14]
    when reg_areg : @[D_EB.scala 73:20]
      io.dout <= reg_din_1 @[D_EB.scala 74:17]
      io.dout_v <= reg_din_v_1 @[D_EB.scala 75:19]
    else :
      io.dout <= reg_din_2 @[D_EB.scala 77:17]
      io.dout_v <= reg_din_v_2 @[D_EB.scala 78:19]

  module FS_4 :
    input clock : Clock
    input reset : Reset
    output io : { flip ready_out : UInt<5>, flip fork_mask : UInt<5>, ready_in : UInt<1>}

    wire aux : UInt<1>[5] @[FS.scala 51:19]
    wire temp : UInt<1>[5] @[FS.scala 52:20]
    node _aux_0_T = bits(io.fork_mask, 0, 0) @[FS.scala 55:34]
    node _aux_0_T_1 = not(_aux_0_T) @[FS.scala 55:21]
    node _aux_0_T_2 = bits(io.ready_out, 0, 0) @[FS.scala 55:53]
    node _aux_0_T_3 = or(_aux_0_T_1, _aux_0_T_2) @[FS.scala 55:39]
    node _aux_0_T_4 = bits(_aux_0_T_3, 0, 0) @[FS.scala 55:58]
    aux[0] <= _aux_0_T_4 @[FS.scala 55:16]
    node _aux_1_T = bits(io.fork_mask, 1, 1) @[FS.scala 55:34]
    node _aux_1_T_1 = not(_aux_1_T) @[FS.scala 55:21]
    node _aux_1_T_2 = bits(io.ready_out, 1, 1) @[FS.scala 55:53]
    node _aux_1_T_3 = or(_aux_1_T_1, _aux_1_T_2) @[FS.scala 55:39]
    node _aux_1_T_4 = bits(_aux_1_T_3, 0, 0) @[FS.scala 55:58]
    aux[1] <= _aux_1_T_4 @[FS.scala 55:16]
    node _aux_2_T = bits(io.fork_mask, 2, 2) @[FS.scala 55:34]
    node _aux_2_T_1 = not(_aux_2_T) @[FS.scala 55:21]
    node _aux_2_T_2 = bits(io.ready_out, 2, 2) @[FS.scala 55:53]
    node _aux_2_T_3 = or(_aux_2_T_1, _aux_2_T_2) @[FS.scala 55:39]
    node _aux_2_T_4 = bits(_aux_2_T_3, 0, 0) @[FS.scala 55:58]
    aux[2] <= _aux_2_T_4 @[FS.scala 55:16]
    node _aux_3_T = bits(io.fork_mask, 3, 3) @[FS.scala 55:34]
    node _aux_3_T_1 = not(_aux_3_T) @[FS.scala 55:21]
    node _aux_3_T_2 = bits(io.ready_out, 3, 3) @[FS.scala 55:53]
    node _aux_3_T_3 = or(_aux_3_T_1, _aux_3_T_2) @[FS.scala 55:39]
    node _aux_3_T_4 = bits(_aux_3_T_3, 0, 0) @[FS.scala 55:58]
    aux[3] <= _aux_3_T_4 @[FS.scala 55:16]
    node _aux_4_T = bits(io.fork_mask, 4, 4) @[FS.scala 55:34]
    node _aux_4_T_1 = not(_aux_4_T) @[FS.scala 55:21]
    node _aux_4_T_2 = bits(io.ready_out, 4, 4) @[FS.scala 55:53]
    node _aux_4_T_3 = or(_aux_4_T_1, _aux_4_T_2) @[FS.scala 55:39]
    node _aux_4_T_4 = bits(_aux_4_T_3, 0, 0) @[FS.scala 55:58]
    aux[4] <= _aux_4_T_4 @[FS.scala 55:16]
    temp[0] <= aux[0] @[FS.scala 58:13]
    node _temp_1_T = and(temp[0], aux[1]) @[FS.scala 61:30]
    temp[1] <= _temp_1_T @[FS.scala 61:17]
    node _temp_2_T = and(temp[1], aux[2]) @[FS.scala 61:30]
    temp[2] <= _temp_2_T @[FS.scala 61:17]
    node _temp_3_T = and(temp[2], aux[3]) @[FS.scala 61:30]
    temp[3] <= _temp_3_T @[FS.scala 61:17]
    node _temp_4_T = and(temp[3], aux[4]) @[FS.scala 61:30]
    temp[4] <= _temp_4_T @[FS.scala 61:17]
    node _io_ready_in_T = bits(temp[4], 0, 0) @[FS.scala 64:47]
    io.ready_in <= _io_ready_in_T @[FS.scala 64:17]

  module CellProcessing :
    input clock : Clock
    input reset : Reset
    output io : { flip north_din : SInt<32>, flip north_din_v : UInt<1>, flip east_din : SInt<32>, flip east_din_v : UInt<1>, flip south_din : SInt<32>, flip south_din_v : UInt<1>, flip west_din : SInt<32>, flip west_din_v : UInt<1>, FU_din_1_r : UInt<1>, FU_din_2_r : UInt<1>, dout : SInt<32>, dout_v : UInt<1>, flip north_dout_r : UInt<1>, flip east_dout_r : UInt<1>, flip south_dout_r : UInt<1>, flip west_dout_r : UInt<1>, flip config_bits : UInt<182>}

    wire selector_mux_1 : UInt<3> @[CellProcessing.scala 68:30]
    wire selector_mux_2 : UInt<3> @[CellProcessing.scala 69:30]
    wire fork_receiver_mask_1 : UInt<4> @[CellProcessing.scala 70:36]
    wire fork_receiver_mask_2 : UInt<4> @[CellProcessing.scala 71:36]
    wire op_config : UInt<5> @[CellProcessing.scala 72:25]
    wire fork_sender_mask : UInt<5> @[CellProcessing.scala 73:32]
    wire I1_const : UInt<32> @[CellProcessing.scala 74:24]
    wire initial_value_load : UInt<32> @[CellProcessing.scala 75:34]
    wire iterations_reset_load : UInt<16> @[CellProcessing.scala 76:37]
    wire fifo_length_load : UInt<16> @[CellProcessing.scala 77:32]
    wire load_initial_value : UInt<2> @[CellProcessing.scala 78:34]
    wire FU_dout : SInt<32> @[CellProcessing.scala 79:23]
    wire EB_din_1 : SInt<32> @[CellProcessing.scala 80:24]
    wire EB_din_2 : SInt<32> @[CellProcessing.scala 81:24]
    wire join_din_1 : SInt<32> @[CellProcessing.scala 82:26]
    wire join_din_2 : SInt<32> @[CellProcessing.scala 83:26]
    wire join_dout_1 : SInt<32> @[CellProcessing.scala 84:27]
    wire join_dout_2 : SInt<32> @[CellProcessing.scala 85:27]
    wire FU_dout_v : UInt<1> @[CellProcessing.scala 86:25]
    wire FU_dout_r : UInt<1> @[CellProcessing.scala 87:25]
    wire EB_din_1_v : UInt<1> @[CellProcessing.scala 88:26]
    wire EB_din_2_v : UInt<1> @[CellProcessing.scala 89:26]
    wire join_din_1_v : UInt<1> @[CellProcessing.scala 90:28]
    wire join_din_1_r : UInt<1> @[CellProcessing.scala 91:28]
    wire join_din_2_v : UInt<1> @[CellProcessing.scala 92:28]
    wire join_din_2_r : UInt<1> @[CellProcessing.scala 93:28]
    wire join_dout_v : UInt<1> @[CellProcessing.scala 94:27]
    wire join_dout_r : UInt<1> @[CellProcessing.scala 95:27]
    wire forked_dout_r : UInt<1> @[CellProcessing.scala 96:29]
    node _selector_mux_1_T = bits(io.config_bits, 2, 0) @[CellProcessing.scala 99:37]
    selector_mux_1 <= _selector_mux_1_T @[CellProcessing.scala 99:20]
    node _selector_mux_2_T = bits(io.config_bits, 5, 3) @[CellProcessing.scala 100:37]
    selector_mux_2 <= _selector_mux_2_T @[CellProcessing.scala 100:20]
    node _fork_receiver_mask_1_T = bits(io.config_bits, 17, 14) @[CellProcessing.scala 101:43]
    fork_receiver_mask_1 <= _fork_receiver_mask_1_T @[CellProcessing.scala 101:26]
    node _fork_receiver_mask_2_T = bits(io.config_bits, 23, 20) @[CellProcessing.scala 103:43]
    fork_receiver_mask_2 <= _fork_receiver_mask_2_T @[CellProcessing.scala 103:26]
    node _op_config_T = bits(io.config_bits, 48, 44) @[CellProcessing.scala 105:32]
    op_config <= _op_config_T @[CellProcessing.scala 105:15]
    node _fork_sender_mask_T = bits(io.config_bits, 56, 52) @[CellProcessing.scala 107:39]
    fork_sender_mask <= _fork_sender_mask_T @[CellProcessing.scala 107:22]
    node _I1_const_T = bits(io.config_bits, 115, 84) @[CellProcessing.scala 109:32]
    I1_const <= _I1_const_T @[CellProcessing.scala 109:15]
    node _initial_value_load_T = bits(io.config_bits, 147, 116) @[CellProcessing.scala 110:41]
    initial_value_load <= _initial_value_load_T @[CellProcessing.scala 110:24]
    node _fifo_length_load_T = bits(io.config_bits, 163, 148) @[CellProcessing.scala 111:39]
    fifo_length_load <= _fifo_length_load_T @[CellProcessing.scala 111:22]
    node _iterations_reset_load_T = bits(io.config_bits, 179, 164) @[CellProcessing.scala 112:44]
    iterations_reset_load <= _iterations_reset_load_T @[CellProcessing.scala 112:27]
    node _load_initial_value_T = bits(io.config_bits, 181, 180) @[CellProcessing.scala 113:41]
    load_initial_value <= _load_initial_value_T @[CellProcessing.scala 113:24]
    inst FR_1 of FR_4 @[CellProcessing.scala 115:23]
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
    FR_1.io.ready_out <= ready_FR1 @[CellProcessing.scala 118:23]
    FR_1.io.valid_in <= valid_in_FR1 @[CellProcessing.scala 119:22]
    FR_1.io.valid_mux_sel <= selector_mux_1 @[CellProcessing.scala 120:27]
    FR_1.io.fork_mask <= fork_receiver_mask_1 @[CellProcessing.scala 121:23]
    EB_din_1_v <= FR_1.io.valid_out @[CellProcessing.scala 122:16]
    inst MUX_1 of ConfMux_9 @[CellProcessing.scala 124:24]
    MUX_1.clock <= clock
    MUX_1.reset <= reset
    MUX_1.io.selector <= selector_mux_1 @[CellProcessing.scala 125:23]
    node MUX_1_io_mux_input_lo_lo = asUInt(io.north_din) @[Cat.scala 31:58]
    node MUX_1_io_mux_input_lo_hi_lo = asUInt(io.east_din) @[Cat.scala 31:58]
    node MUX_1_io_mux_input_lo_hi_hi = asUInt(io.south_din) @[Cat.scala 31:58]
    node MUX_1_io_mux_input_lo_hi = cat(MUX_1_io_mux_input_lo_hi_hi, MUX_1_io_mux_input_lo_hi_lo) @[Cat.scala 31:58]
    node MUX_1_io_mux_input_lo = cat(MUX_1_io_mux_input_lo_hi, MUX_1_io_mux_input_lo_lo) @[Cat.scala 31:58]
    node MUX_1_io_mux_input_hi_lo = asUInt(io.west_din) @[Cat.scala 31:58]
    node MUX_1_io_mux_input_hi_hi_hi = asUInt(FU_dout) @[Cat.scala 31:58]
    node MUX_1_io_mux_input_hi_hi = cat(MUX_1_io_mux_input_hi_hi_hi, I1_const) @[Cat.scala 31:58]
    node MUX_1_io_mux_input_hi = cat(MUX_1_io_mux_input_hi_hi, MUX_1_io_mux_input_hi_lo) @[Cat.scala 31:58]
    node _MUX_1_io_mux_input_T = cat(MUX_1_io_mux_input_hi, MUX_1_io_mux_input_lo) @[Cat.scala 31:58]
    node _MUX_1_io_mux_input_T_1 = asSInt(_MUX_1_io_mux_input_T) @[CellProcessing.scala 126:106]
    MUX_1.io.mux_input <= _MUX_1_io_mux_input_T_1 @[CellProcessing.scala 126:24]
    EB_din_1 <= MUX_1.io.mux_output @[CellProcessing.scala 127:14]
    inst EB_1 of D_EB @[CellProcessing.scala 129:23]
    EB_1.clock <= clock
    EB_1.reset <= reset
    EB_1.io.din <= EB_din_1 @[CellProcessing.scala 130:17]
    EB_1.io.din_v <= EB_din_1_v @[CellProcessing.scala 131:19]
    io.FU_din_1_r <= EB_1.io.din_r @[CellProcessing.scala 132:19]
    join_din_1 <= EB_1.io.dout @[CellProcessing.scala 133:16]
    join_din_1_v <= EB_1.io.dout_v @[CellProcessing.scala 134:18]
    EB_1.io.dout_r <= join_din_1_r @[CellProcessing.scala 135:20]
    inst FR_2 of FR_5 @[CellProcessing.scala 137:23]
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
    FR_2.io.ready_out <= ready_FR2 @[CellProcessing.scala 140:23]
    FR_2.io.valid_in <= valid_in_FR2 @[CellProcessing.scala 141:22]
    FR_2.io.valid_mux_sel <= selector_mux_2 @[CellProcessing.scala 142:27]
    FR_2.io.fork_mask <= fork_receiver_mask_2 @[CellProcessing.scala 143:23]
    EB_din_2_v <= FR_2.io.valid_out @[CellProcessing.scala 144:16]
    inst MUX_2 of ConfMux_11 @[CellProcessing.scala 146:24]
    MUX_2.clock <= clock
    MUX_2.reset <= reset
    MUX_2.io.selector <= selector_mux_2 @[CellProcessing.scala 147:23]
    node MUX_2_io_mux_input_lo_lo = asUInt(io.north_din) @[Cat.scala 31:58]
    node MUX_2_io_mux_input_lo_hi_lo = asUInt(io.east_din) @[Cat.scala 31:58]
    node MUX_2_io_mux_input_lo_hi_hi = asUInt(io.south_din) @[Cat.scala 31:58]
    node MUX_2_io_mux_input_lo_hi = cat(MUX_2_io_mux_input_lo_hi_hi, MUX_2_io_mux_input_lo_hi_lo) @[Cat.scala 31:58]
    node MUX_2_io_mux_input_lo = cat(MUX_2_io_mux_input_lo_hi, MUX_2_io_mux_input_lo_lo) @[Cat.scala 31:58]
    node MUX_2_io_mux_input_hi_lo = asUInt(io.west_din) @[Cat.scala 31:58]
    node MUX_2_io_mux_input_hi_hi_hi = asUInt(FU_dout) @[Cat.scala 31:58]
    node MUX_2_io_mux_input_hi_hi = cat(MUX_2_io_mux_input_hi_hi_hi, I1_const) @[Cat.scala 31:58]
    node MUX_2_io_mux_input_hi = cat(MUX_2_io_mux_input_hi_hi, MUX_2_io_mux_input_hi_lo) @[Cat.scala 31:58]
    node _MUX_2_io_mux_input_T = cat(MUX_2_io_mux_input_hi, MUX_2_io_mux_input_lo) @[Cat.scala 31:58]
    node _MUX_2_io_mux_input_T_1 = asSInt(_MUX_2_io_mux_input_T) @[CellProcessing.scala 148:106]
    MUX_2.io.mux_input <= _MUX_2_io_mux_input_T_1 @[CellProcessing.scala 148:24]
    EB_din_2 <= MUX_2.io.mux_output @[CellProcessing.scala 149:14]
    inst EB_2 of D_EB_1 @[CellProcessing.scala 151:23]
    EB_2.clock <= clock
    EB_2.reset <= reset
    EB_2.io.din <= EB_din_2 @[CellProcessing.scala 152:17]
    EB_2.io.din_v <= EB_din_2_v @[CellProcessing.scala 153:19]
    io.FU_din_2_r <= EB_2.io.din_r @[CellProcessing.scala 154:19]
    join_din_2 <= EB_2.io.dout @[CellProcessing.scala 155:16]
    join_din_2_v <= EB_2.io.dout_v @[CellProcessing.scala 156:18]
    EB_2.io.dout_r <= join_din_2_r @[CellProcessing.scala 157:20]
    inst JOIN_INST of Join @[CellProcessing.scala 159:28]
    JOIN_INST.clock <= clock
    JOIN_INST.reset <= reset
    JOIN_INST.io.din_1 <= join_din_1 @[CellProcessing.scala 160:24]
    JOIN_INST.io.din_2 <= join_din_2 @[CellProcessing.scala 161:24]
    JOIN_INST.io.dout_r <= join_dout_r @[CellProcessing.scala 162:25]
    JOIN_INST.io.din_1_v <= join_din_1_v @[CellProcessing.scala 163:26]
    JOIN_INST.io.din_2_v <= join_din_2_v @[CellProcessing.scala 164:26]
    join_dout_v <= JOIN_INST.io.dout_v @[CellProcessing.scala 166:17]
    join_din_1_r <= JOIN_INST.io.din_1_r @[CellProcessing.scala 167:18]
    join_din_2_r <= JOIN_INST.io.din_2_r @[CellProcessing.scala 168:18]
    join_dout_1 <= JOIN_INST.io.dout_1 @[CellProcessing.scala 169:17]
    join_dout_2 <= JOIN_INST.io.dout_2 @[CellProcessing.scala 170:17]
    inst FU_INST of FU @[CellProcessing.scala 172:26]
    FU_INST.clock <= clock
    FU_INST.reset <= reset
    FU_INST.io.din_1 <= join_dout_1 @[CellProcessing.scala 173:22]
    FU_INST.io.din_2 <= join_dout_2 @[CellProcessing.scala 174:22]
    FU_INST.io.din_v <= join_dout_v @[CellProcessing.scala 175:22]
    join_dout_r <= FU_INST.io.din_r @[CellProcessing.scala 176:17]
    FU_INST.io.loop_source <= load_initial_value @[CellProcessing.scala 177:28]
    FU_INST.io.iterations_reset <= iterations_reset_load @[CellProcessing.scala 178:33]
    FU_INST.io.op_config <= op_config @[CellProcessing.scala 179:26]
    FU_dout <= FU_INST.io.dout @[CellProcessing.scala 180:13]
    FU_dout_v <= FU_INST.io.dout_v @[CellProcessing.scala 181:15]
    FU_INST.io.dout_r <= FU_dout_r @[CellProcessing.scala 183:23]
    inst EB_OUT of D_EB_2 @[CellProcessing.scala 185:25]
    EB_OUT.clock <= clock
    EB_OUT.reset <= reset
    EB_OUT.io.din <= FU_dout @[CellProcessing.scala 186:19]
    EB_OUT.io.din_v <= FU_dout_v @[CellProcessing.scala 187:21]
    EB_OUT.io.din <= FU_INST.io.dout @[CellProcessing.scala 188:19]
    EB_OUT.io.din_v <= FU_INST.io.dout_v @[CellProcessing.scala 189:21]
    FU_dout_r <= EB_OUT.io.din_r @[CellProcessing.scala 191:15]
    io.dout <= EB_OUT.io.dout @[CellProcessing.scala 192:13]
    io.dout_v <= EB_OUT.io.dout_v @[CellProcessing.scala 193:15]
    EB_OUT.io.dout_r <= forked_dout_r @[CellProcessing.scala 194:22]
    inst FS of FS_4 @[CellProcessing.scala 196:21]
    FS.clock <= clock
    FS.reset <= reset
    node ready_out_FS_lo = cat(io.south_dout_r, io.west_dout_r) @[Cat.scala 31:58]
    node ready_out_FS_hi_hi = cat(UInt<1>("h1"), io.north_dout_r) @[Cat.scala 31:58]
    node ready_out_FS_hi = cat(ready_out_FS_hi_hi, io.east_dout_r) @[Cat.scala 31:58]
    node ready_out_FS = cat(ready_out_FS_hi, ready_out_FS_lo) @[Cat.scala 31:58]
    FS.io.ready_out <= ready_out_FS @[CellProcessing.scala 198:21]
    forked_dout_r <= FS.io.ready_in @[CellProcessing.scala 199:19]
    FS.io.fork_mask <= fork_sender_mask @[CellProcessing.scala 200:21]

  module ProcessingElement :
    input clock : Clock
    input reset : UInt<1>
    output io : { flip north_din : SInt<32>, flip north_din_v : UInt<1>, north_din_r : UInt<1>, flip east_din : SInt<32>, flip east_din_v : UInt<1>, east_din_r : UInt<1>, flip south_din : SInt<32>, flip south_din_v : UInt<1>, south_din_r : UInt<1>, flip west_din : SInt<32>, flip west_din_v : UInt<1>, west_din_r : UInt<1>, north_dout : SInt<32>, north_dout_v : UInt<1>, flip north_dout_r : UInt<1>, east_dout : SInt<32>, east_dout_v : UInt<1>, flip east_dout_r : UInt<1>, south_dout : SInt<32>, south_dout_v : UInt<1>, flip south_dout_r : UInt<1>, west_dout : SInt<32>, west_dout_v : UInt<1>, flip west_dout_r : UInt<1>, flip config_bits : UInt<182>, flip catch_config : UInt<1>}

    wire mux_N_sel : UInt<2> @[ProcessingElement.scala 84:25]
    wire mux_E_sel : UInt<2> @[ProcessingElement.scala 85:25]
    wire mux_S_sel : UInt<2> @[ProcessingElement.scala 86:25]
    wire mux_W_sel : UInt<2> @[ProcessingElement.scala 87:25]
    wire accept_mask_frN : UInt<5> @[ProcessingElement.scala 88:31]
    wire accept_mask_frE : UInt<5> @[ProcessingElement.scala 89:31]
    wire accept_mask_frS : UInt<5> @[ProcessingElement.scala 90:31]
    wire accept_mask_frW : UInt<5> @[ProcessingElement.scala 91:31]
    wire accept_mask_fsiN : UInt<5> @[ProcessingElement.scala 92:32]
    wire accept_mask_fsiE : UInt<5> @[ProcessingElement.scala 93:32]
    wire accept_mask_fsiS : UInt<5> @[ProcessingElement.scala 94:32]
    wire accept_mask_fsiW : UInt<5> @[ProcessingElement.scala 95:32]
    reg config_bits_reg : UInt<182>, clock with :
      reset => (reset, UInt<182>("h0")) @[ProcessingElement.scala 97:34]
    wire north_buffer : SInt<32> @[ProcessingElement.scala 100:28]
    wire east_buffer : SInt<32> @[ProcessingElement.scala 101:27]
    wire south_buffer : SInt<32> @[ProcessingElement.scala 102:28]
    wire west_buffer : SInt<32> @[ProcessingElement.scala 103:27]
    wire north_buffer_v : UInt<1> @[ProcessingElement.scala 105:30]
    wire east_buffer_v : UInt<1> @[ProcessingElement.scala 106:29]
    wire south_buffer_v : UInt<1> @[ProcessingElement.scala 107:30]
    wire west_buffer_v : UInt<1> @[ProcessingElement.scala 108:29]
    wire north_buffer_r : UInt<1> @[ProcessingElement.scala 110:30]
    wire east_buffer_r : UInt<1> @[ProcessingElement.scala 111:29]
    wire south_buffer_r : UInt<1> @[ProcessingElement.scala 112:30]
    wire west_buffer_r : UInt<1> @[ProcessingElement.scala 113:29]
    wire north_REG_din : SInt<32> @[ProcessingElement.scala 115:29]
    wire east_REG_din : SInt<32> @[ProcessingElement.scala 116:28]
    wire south_REG_din : SInt<32> @[ProcessingElement.scala 117:29]
    wire west_REG_din : SInt<32> @[ProcessingElement.scala 118:28]
    wire north_REG_din_v : UInt<1> @[ProcessingElement.scala 120:31]
    wire east_REG_din_v : UInt<1> @[ProcessingElement.scala 121:30]
    wire south_REG_din_v : UInt<1> @[ProcessingElement.scala 122:31]
    wire west_REG_din_v : UInt<1> @[ProcessingElement.scala 123:30]
    wire north_REG_din_r : UInt<1> @[ProcessingElement.scala 125:31]
    wire east_REG_din_r : UInt<1> @[ProcessingElement.scala 126:30]
    wire south_REG_din_r : UInt<1> @[ProcessingElement.scala 127:31]
    wire west_REG_din_r : UInt<1> @[ProcessingElement.scala 128:30]
    wire FU_din_1_r : UInt<1> @[ProcessingElement.scala 130:26]
    wire FU_din_2_r : UInt<1> @[ProcessingElement.scala 131:26]
    wire FU_dout : SInt<32> @[ProcessingElement.scala 132:23]
    wire FU_dout_v : UInt<1> @[ProcessingElement.scala 133:25]
    when io.catch_config : @[ProcessingElement.scala 136:28]
      config_bits_reg <= io.config_bits @[ProcessingElement.scala 137:25]
    node _mux_N_sel_T = bits(config_bits_reg, 7, 6) @[ProcessingElement.scala 142:33]
    mux_N_sel <= _mux_N_sel_T @[ProcessingElement.scala 142:15]
    node _mux_E_sel_T = bits(config_bits_reg, 9, 8) @[ProcessingElement.scala 143:33]
    mux_E_sel <= _mux_E_sel_T @[ProcessingElement.scala 143:15]
    node _mux_S_sel_T = bits(config_bits_reg, 11, 10) @[ProcessingElement.scala 144:33]
    mux_S_sel <= _mux_S_sel_T @[ProcessingElement.scala 144:15]
    node _mux_W_sel_T = bits(config_bits_reg, 13, 12) @[ProcessingElement.scala 145:33]
    mux_W_sel <= _mux_W_sel_T @[ProcessingElement.scala 145:15]
    node _accept_mask_fsiN_T = bits(config_bits_reg, 28, 24) @[ProcessingElement.scala 147:40]
    accept_mask_fsiN <= _accept_mask_fsiN_T @[ProcessingElement.scala 147:22]
    node _accept_mask_fsiE_T = bits(config_bits_reg, 33, 29) @[ProcessingElement.scala 148:40]
    accept_mask_fsiE <= _accept_mask_fsiE_T @[ProcessingElement.scala 148:22]
    node _accept_mask_fsiS_T = bits(config_bits_reg, 38, 34) @[ProcessingElement.scala 149:40]
    accept_mask_fsiS <= _accept_mask_fsiS_T @[ProcessingElement.scala 149:22]
    node _accept_mask_fsiW_T = bits(config_bits_reg, 43, 39) @[ProcessingElement.scala 150:40]
    accept_mask_fsiW <= _accept_mask_fsiW_T @[ProcessingElement.scala 150:22]
    node _accept_mask_frN_T = bits(config_bits_reg, 61, 57) @[ProcessingElement.scala 152:39]
    accept_mask_frN <= _accept_mask_frN_T @[ProcessingElement.scala 152:21]
    node _accept_mask_frE_T = bits(config_bits_reg, 66, 62) @[ProcessingElement.scala 153:39]
    accept_mask_frE <= _accept_mask_frE_T @[ProcessingElement.scala 153:21]
    node _accept_mask_frS_T = bits(config_bits_reg, 71, 67) @[ProcessingElement.scala 154:39]
    accept_mask_frS <= _accept_mask_frS_T @[ProcessingElement.scala 154:21]
    node _accept_mask_frW_T = bits(config_bits_reg, 76, 72) @[ProcessingElement.scala 155:39]
    accept_mask_frW <= _accept_mask_frW_T @[ProcessingElement.scala 155:21]
    inst FIFO_Nin of D_FIFO @[ProcessingElement.scala 159:27]
    FIFO_Nin.clock <= clock
    FIFO_Nin.reset <= reset
    FIFO_Nin.io.din <= io.north_din @[ProcessingElement.scala 160:21]
    FIFO_Nin.io.din_v <= io.north_din_v @[ProcessingElement.scala 161:23]
    FIFO_Nin.io.dout_r <= north_buffer_r @[ProcessingElement.scala 162:24]
    io.north_din_r <= FIFO_Nin.io.din_r @[ProcessingElement.scala 163:20]
    north_buffer <= FIFO_Nin.io.dout @[ProcessingElement.scala 164:18]
    north_buffer_v <= FIFO_Nin.io.dout_v @[ProcessingElement.scala 165:20]
    inst FS_Nin of FS @[ProcessingElement.scala 167:25]
    FS_Nin.clock <= clock
    FS_Nin.reset <= reset
    node ready_out_FS_Nin_lo = cat(south_REG_din_r, west_REG_din_r) @[Cat.scala 31:58]
    node ready_out_FS_Nin_hi_hi = cat(FU_din_1_r, FU_din_2_r) @[Cat.scala 31:58]
    node ready_out_FS_Nin_hi = cat(ready_out_FS_Nin_hi_hi, east_REG_din_r) @[Cat.scala 31:58]
    node ready_out_FS_Nin = cat(ready_out_FS_Nin_hi, ready_out_FS_Nin_lo) @[Cat.scala 31:58]
    FS_Nin.io.ready_out <= ready_out_FS_Nin @[ProcessingElement.scala 169:25]
    north_buffer_r <= FS_Nin.io.ready_in @[ProcessingElement.scala 170:20]
    FS_Nin.io.fork_mask <= accept_mask_fsiN @[ProcessingElement.scala 171:25]
    inst MUX_Nout of ConfMux @[ProcessingElement.scala 173:28]
    MUX_Nout.clock <= clock
    MUX_Nout.reset <= reset
    MUX_Nout.io.selector <= mux_N_sel @[ProcessingElement.scala 174:26]
    node MUX_Nout_io_mux_input_lo_lo = asUInt(FU_dout) @[Cat.scala 31:58]
    node MUX_Nout_io_mux_input_lo_hi = asUInt(east_buffer) @[Cat.scala 31:58]
    node MUX_Nout_io_mux_input_lo = cat(MUX_Nout_io_mux_input_lo_hi, MUX_Nout_io_mux_input_lo_lo) @[Cat.scala 31:58]
    node MUX_Nout_io_mux_input_hi_lo = asUInt(south_buffer) @[Cat.scala 31:58]
    node MUX_Nout_io_mux_input_hi_hi = asUInt(west_buffer) @[Cat.scala 31:58]
    node MUX_Nout_io_mux_input_hi = cat(MUX_Nout_io_mux_input_hi_hi, MUX_Nout_io_mux_input_hi_lo) @[Cat.scala 31:58]
    node _MUX_Nout_io_mux_input_T = cat(MUX_Nout_io_mux_input_hi, MUX_Nout_io_mux_input_lo) @[Cat.scala 31:58]
    node _MUX_Nout_io_mux_input_T_1 = asSInt(_MUX_Nout_io_mux_input_T) @[ProcessingElement.scala 175:85]
    MUX_Nout.io.mux_input <= _MUX_Nout_io_mux_input_T_1 @[ProcessingElement.scala 175:27]
    north_REG_din <= MUX_Nout.io.mux_output @[ProcessingElement.scala 176:19]
    inst FR_Nout of FR @[ProcessingElement.scala 178:26]
    FR_Nout.clock <= clock
    FR_Nout.reset <= reset
    node ready_FR_Nout_lo = cat(south_REG_din_r, west_REG_din_r) @[Cat.scala 31:58]
    node ready_FR_Nout_hi_hi = cat(FU_din_1_r, FU_din_2_r) @[Cat.scala 31:58]
    node ready_FR_Nout_hi = cat(ready_FR_Nout_hi_hi, east_REG_din_r) @[Cat.scala 31:58]
    node ready_FR_Nout = cat(ready_FR_Nout_hi, ready_FR_Nout_lo) @[Cat.scala 31:58]
    node valid_in_FR_Nout_lo = cat(east_buffer_v, FU_dout_v) @[Cat.scala 31:58]
    node valid_in_FR_Nout_hi = cat(west_buffer_v, south_buffer_v) @[Cat.scala 31:58]
    node valid_in_FR_Nout = cat(valid_in_FR_Nout_hi, valid_in_FR_Nout_lo) @[Cat.scala 31:58]
    FR_Nout.io.ready_out <= ready_FR_Nout @[ProcessingElement.scala 181:26]
    FR_Nout.io.valid_in <= valid_in_FR_Nout @[ProcessingElement.scala 182:25]
    FR_Nout.io.valid_mux_sel <= mux_N_sel @[ProcessingElement.scala 183:30]
    FR_Nout.io.fork_mask <= accept_mask_frN @[ProcessingElement.scala 184:26]
    north_REG_din_v <= FR_Nout.io.valid_out @[ProcessingElement.scala 185:21]
    inst REG_Nout of D_REG @[ProcessingElement.scala 187:27]
    REG_Nout.clock <= clock
    REG_Nout.reset <= reset
    REG_Nout.io.din <= north_REG_din @[ProcessingElement.scala 189:21]
    REG_Nout.io.din_v <= north_REG_din_v @[ProcessingElement.scala 190:23]
    REG_Nout.io.dout_r <= io.north_dout_r @[ProcessingElement.scala 191:24]
    north_REG_din_r <= REG_Nout.io.din_r @[ProcessingElement.scala 193:21]
    io.north_dout <= REG_Nout.io.dout @[ProcessingElement.scala 194:19]
    io.north_dout_v <= REG_Nout.io.dout_v @[ProcessingElement.scala 195:21]
    inst FIFO_Ein of D_FIFO_1 @[ProcessingElement.scala 201:27]
    FIFO_Ein.clock <= clock
    FIFO_Ein.reset <= reset
    FIFO_Ein.io.din <= io.east_din @[ProcessingElement.scala 202:21]
    FIFO_Ein.io.din_v <= io.east_din_v @[ProcessingElement.scala 203:23]
    FIFO_Ein.io.dout_r <= east_buffer_r @[ProcessingElement.scala 204:24]
    io.east_din_r <= FIFO_Ein.io.din_r @[ProcessingElement.scala 205:19]
    east_buffer <= FIFO_Ein.io.dout @[ProcessingElement.scala 206:17]
    east_buffer_v <= FIFO_Ein.io.dout_v @[ProcessingElement.scala 207:19]
    inst FS_Ein of FS_1 @[ProcessingElement.scala 209:25]
    FS_Ein.clock <= clock
    FS_Ein.reset <= reset
    node ready_out_FS_Ein_lo = cat(south_REG_din_r, west_REG_din_r) @[Cat.scala 31:58]
    node ready_out_FS_Ein_hi_hi = cat(FU_din_1_r, FU_din_2_r) @[Cat.scala 31:58]
    node ready_out_FS_Ein_hi = cat(ready_out_FS_Ein_hi_hi, north_REG_din_r) @[Cat.scala 31:58]
    node ready_out_FS_Ein = cat(ready_out_FS_Ein_hi, ready_out_FS_Ein_lo) @[Cat.scala 31:58]
    FS_Ein.io.ready_out <= ready_out_FS_Ein @[ProcessingElement.scala 211:25]
    east_buffer_r <= FS_Ein.io.ready_in @[ProcessingElement.scala 212:19]
    FS_Ein.io.fork_mask <= accept_mask_fsiE @[ProcessingElement.scala 213:25]
    inst MUX_Eout of ConfMux_2 @[ProcessingElement.scala 215:28]
    MUX_Eout.clock <= clock
    MUX_Eout.reset <= reset
    MUX_Eout.io.selector <= mux_E_sel @[ProcessingElement.scala 216:26]
    node MUX_Eout_io_mux_input_lo_lo = asUInt(FU_dout) @[Cat.scala 31:58]
    node MUX_Eout_io_mux_input_lo_hi = asUInt(north_buffer) @[Cat.scala 31:58]
    node MUX_Eout_io_mux_input_lo = cat(MUX_Eout_io_mux_input_lo_hi, MUX_Eout_io_mux_input_lo_lo) @[Cat.scala 31:58]
    node MUX_Eout_io_mux_input_hi_lo = asUInt(south_buffer) @[Cat.scala 31:58]
    node MUX_Eout_io_mux_input_hi_hi = asUInt(west_buffer) @[Cat.scala 31:58]
    node MUX_Eout_io_mux_input_hi = cat(MUX_Eout_io_mux_input_hi_hi, MUX_Eout_io_mux_input_hi_lo) @[Cat.scala 31:58]
    node _MUX_Eout_io_mux_input_T = cat(MUX_Eout_io_mux_input_hi, MUX_Eout_io_mux_input_lo) @[Cat.scala 31:58]
    node _MUX_Eout_io_mux_input_T_1 = asSInt(_MUX_Eout_io_mux_input_T) @[ProcessingElement.scala 217:86]
    MUX_Eout.io.mux_input <= _MUX_Eout_io_mux_input_T_1 @[ProcessingElement.scala 217:27]
    east_REG_din <= MUX_Eout.io.mux_output @[ProcessingElement.scala 218:18]
    inst FR_Eout of FR_1 @[ProcessingElement.scala 220:26]
    FR_Eout.clock <= clock
    FR_Eout.reset <= reset
    node ready_FR_Eout_lo = cat(south_REG_din_r, west_REG_din_r) @[Cat.scala 31:58]
    node ready_FR_Eout_hi_hi = cat(FU_din_1_r, FU_din_2_r) @[Cat.scala 31:58]
    node ready_FR_Eout_hi = cat(ready_FR_Eout_hi_hi, north_REG_din_r) @[Cat.scala 31:58]
    node ready_FR_Eout = cat(ready_FR_Eout_hi, ready_FR_Eout_lo) @[Cat.scala 31:58]
    node valid_in_FR_Eout_lo = cat(north_buffer_v, FU_dout_v) @[Cat.scala 31:58]
    node valid_in_FR_Eout_hi = cat(west_buffer_v, south_buffer_v) @[Cat.scala 31:58]
    node valid_in_FR_Eout = cat(valid_in_FR_Eout_hi, valid_in_FR_Eout_lo) @[Cat.scala 31:58]
    FR_Eout.io.ready_out <= ready_FR_Eout @[ProcessingElement.scala 223:26]
    FR_Eout.io.valid_in <= valid_in_FR_Eout @[ProcessingElement.scala 224:25]
    FR_Eout.io.valid_mux_sel <= mux_E_sel @[ProcessingElement.scala 225:30]
    FR_Eout.io.fork_mask <= accept_mask_frE @[ProcessingElement.scala 226:26]
    east_REG_din_v <= FR_Eout.io.valid_out @[ProcessingElement.scala 227:20]
    inst REG_Eout of D_REG_1 @[ProcessingElement.scala 229:27]
    REG_Eout.clock <= clock
    REG_Eout.reset <= reset
    REG_Eout.io.din <= east_REG_din @[ProcessingElement.scala 231:21]
    REG_Eout.io.din_v <= east_REG_din_v @[ProcessingElement.scala 232:23]
    REG_Eout.io.dout_r <= io.east_dout_r @[ProcessingElement.scala 233:24]
    east_REG_din_r <= REG_Eout.io.din_r @[ProcessingElement.scala 235:20]
    io.east_dout <= REG_Eout.io.dout @[ProcessingElement.scala 236:18]
    io.east_dout_v <= REG_Eout.io.dout_v @[ProcessingElement.scala 237:20]
    inst FIFO_Sin of D_FIFO_2 @[ProcessingElement.scala 242:27]
    FIFO_Sin.clock <= clock
    FIFO_Sin.reset <= reset
    FIFO_Sin.io.din <= io.south_din @[ProcessingElement.scala 243:21]
    FIFO_Sin.io.din_v <= io.south_din_v @[ProcessingElement.scala 244:23]
    FIFO_Sin.io.dout_r <= south_buffer_r @[ProcessingElement.scala 245:24]
    io.south_din_r <= FIFO_Sin.io.din_r @[ProcessingElement.scala 246:20]
    south_buffer <= FIFO_Sin.io.dout @[ProcessingElement.scala 247:18]
    south_buffer_v <= FIFO_Sin.io.dout_v @[ProcessingElement.scala 248:20]
    inst FS_Sin of FS_2 @[ProcessingElement.scala 250:25]
    FS_Sin.clock <= clock
    FS_Sin.reset <= reset
    node ready_out_FS_Sin_lo = cat(east_REG_din_r, west_REG_din_r) @[Cat.scala 31:58]
    node ready_out_FS_Sin_hi_hi = cat(FU_din_1_r, FU_din_2_r) @[Cat.scala 31:58]
    node ready_out_FS_Sin_hi = cat(ready_out_FS_Sin_hi_hi, north_REG_din_r) @[Cat.scala 31:58]
    node ready_out_FS_Sin = cat(ready_out_FS_Sin_hi, ready_out_FS_Sin_lo) @[Cat.scala 31:58]
    FS_Sin.io.ready_out <= ready_out_FS_Sin @[ProcessingElement.scala 252:25]
    south_buffer_r <= FS_Sin.io.ready_in @[ProcessingElement.scala 253:20]
    FS_Sin.io.fork_mask <= accept_mask_fsiS @[ProcessingElement.scala 254:25]
    inst MUX_Sout of ConfMux_4 @[ProcessingElement.scala 256:28]
    MUX_Sout.clock <= clock
    MUX_Sout.reset <= reset
    MUX_Sout.io.selector <= mux_S_sel @[ProcessingElement.scala 257:26]
    node MUX_Sout_io_mux_input_lo_lo = asUInt(FU_dout) @[Cat.scala 31:58]
    node MUX_Sout_io_mux_input_lo_hi = asUInt(north_buffer) @[Cat.scala 31:58]
    node MUX_Sout_io_mux_input_lo = cat(MUX_Sout_io_mux_input_lo_hi, MUX_Sout_io_mux_input_lo_lo) @[Cat.scala 31:58]
    node MUX_Sout_io_mux_input_hi_lo = asUInt(east_buffer) @[Cat.scala 31:58]
    node MUX_Sout_io_mux_input_hi_hi = asUInt(west_buffer) @[Cat.scala 31:58]
    node MUX_Sout_io_mux_input_hi = cat(MUX_Sout_io_mux_input_hi_hi, MUX_Sout_io_mux_input_hi_lo) @[Cat.scala 31:58]
    node _MUX_Sout_io_mux_input_T = cat(MUX_Sout_io_mux_input_hi, MUX_Sout_io_mux_input_lo) @[Cat.scala 31:58]
    node _MUX_Sout_io_mux_input_T_1 = asSInt(_MUX_Sout_io_mux_input_T) @[ProcessingElement.scala 258:85]
    MUX_Sout.io.mux_input <= _MUX_Sout_io_mux_input_T_1 @[ProcessingElement.scala 258:27]
    south_REG_din <= MUX_Sout.io.mux_output @[ProcessingElement.scala 259:19]
    inst FR_Sout of FR_2 @[ProcessingElement.scala 261:26]
    FR_Sout.clock <= clock
    FR_Sout.reset <= reset
    node ready_FR_Sout_lo = cat(east_REG_din_r, west_REG_din_r) @[Cat.scala 31:58]
    node ready_FR_Sout_hi_hi = cat(FU_din_1_r, FU_din_2_r) @[Cat.scala 31:58]
    node ready_FR_Sout_hi = cat(ready_FR_Sout_hi_hi, north_REG_din_r) @[Cat.scala 31:58]
    node ready_FR_Sout = cat(ready_FR_Sout_hi, ready_FR_Sout_lo) @[Cat.scala 31:58]
    node valid_in_FR_Sout_lo = cat(north_buffer_v, FU_dout_v) @[Cat.scala 31:58]
    node valid_in_FR_Sout_hi = cat(west_buffer_v, east_buffer_v) @[Cat.scala 31:58]
    node valid_in_FR_Sout = cat(valid_in_FR_Sout_hi, valid_in_FR_Sout_lo) @[Cat.scala 31:58]
    FR_Sout.io.ready_out <= ready_FR_Sout @[ProcessingElement.scala 264:26]
    FR_Sout.io.valid_in <= valid_in_FR_Sout @[ProcessingElement.scala 265:25]
    FR_Sout.io.valid_mux_sel <= mux_S_sel @[ProcessingElement.scala 266:30]
    FR_Sout.io.fork_mask <= accept_mask_frS @[ProcessingElement.scala 267:26]
    south_REG_din_v <= FR_Sout.io.valid_out @[ProcessingElement.scala 268:21]
    inst REG_Sout of D_REG_2 @[ProcessingElement.scala 270:27]
    REG_Sout.clock <= clock
    REG_Sout.reset <= reset
    REG_Sout.io.din <= south_REG_din @[ProcessingElement.scala 272:21]
    REG_Sout.io.din_v <= south_REG_din_v @[ProcessingElement.scala 273:23]
    REG_Sout.io.dout_r <= io.south_dout_r @[ProcessingElement.scala 274:24]
    south_REG_din_r <= REG_Sout.io.din_r @[ProcessingElement.scala 276:21]
    io.south_dout <= REG_Sout.io.dout @[ProcessingElement.scala 277:19]
    io.south_dout_v <= REG_Sout.io.dout_v @[ProcessingElement.scala 278:21]
    inst FIFO_Win of D_FIFO_3 @[ProcessingElement.scala 283:27]
    FIFO_Win.clock <= clock
    FIFO_Win.reset <= reset
    FIFO_Win.io.din <= io.west_din @[ProcessingElement.scala 284:21]
    FIFO_Win.io.din_v <= io.west_din_v @[ProcessingElement.scala 285:23]
    FIFO_Win.io.dout_r <= west_buffer_r @[ProcessingElement.scala 286:24]
    io.west_din_r <= FIFO_Win.io.din_r @[ProcessingElement.scala 287:19]
    west_buffer <= FIFO_Win.io.dout @[ProcessingElement.scala 288:17]
    west_buffer_v <= FIFO_Win.io.dout_v @[ProcessingElement.scala 289:19]
    inst FS_Win of FS_3 @[ProcessingElement.scala 291:25]
    FS_Win.clock <= clock
    FS_Win.reset <= reset
    node ready_out_FS_Win_lo = cat(east_REG_din_r, south_REG_din_r) @[Cat.scala 31:58]
    node ready_out_FS_Win_hi_hi = cat(FU_din_1_r, FU_din_2_r) @[Cat.scala 31:58]
    node ready_out_FS_Win_hi = cat(ready_out_FS_Win_hi_hi, north_REG_din_r) @[Cat.scala 31:58]
    node ready_out_FS_Win = cat(ready_out_FS_Win_hi, ready_out_FS_Win_lo) @[Cat.scala 31:58]
    FS_Win.io.ready_out <= ready_out_FS_Win @[ProcessingElement.scala 293:25]
    FS_Win.io.fork_mask <= accept_mask_fsiW @[ProcessingElement.scala 294:25]
    west_buffer_r <= FS_Win.io.ready_in @[ProcessingElement.scala 295:19]
    inst MUX_Wout of ConfMux_6 @[ProcessingElement.scala 298:28]
    MUX_Wout.clock <= clock
    MUX_Wout.reset <= reset
    MUX_Wout.io.selector <= mux_W_sel @[ProcessingElement.scala 299:26]
    node MUX_Wout_io_mux_input_lo_lo = asUInt(FU_dout) @[Cat.scala 31:58]
    node MUX_Wout_io_mux_input_lo_hi = asUInt(north_buffer) @[Cat.scala 31:58]
    node MUX_Wout_io_mux_input_lo = cat(MUX_Wout_io_mux_input_lo_hi, MUX_Wout_io_mux_input_lo_lo) @[Cat.scala 31:58]
    node MUX_Wout_io_mux_input_hi_lo = asUInt(east_buffer) @[Cat.scala 31:58]
    node MUX_Wout_io_mux_input_hi_hi = asUInt(south_buffer) @[Cat.scala 31:58]
    node MUX_Wout_io_mux_input_hi = cat(MUX_Wout_io_mux_input_hi_hi, MUX_Wout_io_mux_input_hi_lo) @[Cat.scala 31:58]
    node _MUX_Wout_io_mux_input_T = cat(MUX_Wout_io_mux_input_hi, MUX_Wout_io_mux_input_lo) @[Cat.scala 31:58]
    node _MUX_Wout_io_mux_input_T_1 = asSInt(_MUX_Wout_io_mux_input_T) @[ProcessingElement.scala 300:86]
    MUX_Wout.io.mux_input <= _MUX_Wout_io_mux_input_T_1 @[ProcessingElement.scala 300:27]
    west_REG_din <= MUX_Wout.io.mux_output @[ProcessingElement.scala 301:18]
    inst FR_Wout of FR_3 @[ProcessingElement.scala 303:26]
    FR_Wout.clock <= clock
    FR_Wout.reset <= reset
    node ready_FR_Wout_lo = cat(east_REG_din_r, south_REG_din_r) @[Cat.scala 31:58]
    node ready_FR_Wout_hi_hi = cat(FU_din_1_r, FU_din_2_r) @[Cat.scala 31:58]
    node ready_FR_Wout_hi = cat(ready_FR_Wout_hi_hi, north_REG_din_r) @[Cat.scala 31:58]
    node ready_FR_Wout = cat(ready_FR_Wout_hi, ready_FR_Wout_lo) @[Cat.scala 31:58]
    node valid_in_FR_Wout_lo = cat(north_buffer_v, FU_dout_v) @[Cat.scala 31:58]
    node valid_in_FR_Wout_hi = cat(south_buffer_v, east_buffer_v) @[Cat.scala 31:58]
    node valid_in_FR_Wout = cat(valid_in_FR_Wout_hi, valid_in_FR_Wout_lo) @[Cat.scala 31:58]
    FR_Wout.io.ready_out <= ready_FR_Wout @[ProcessingElement.scala 306:26]
    FR_Wout.io.valid_in <= valid_in_FR_Wout @[ProcessingElement.scala 307:25]
    FR_Wout.io.valid_mux_sel <= mux_W_sel @[ProcessingElement.scala 308:30]
    FR_Wout.io.fork_mask <= accept_mask_frW @[ProcessingElement.scala 309:26]
    west_REG_din_v <= FR_Wout.io.valid_out @[ProcessingElement.scala 310:20]
    inst REG_Wout of D_REG_3 @[ProcessingElement.scala 312:27]
    REG_Wout.clock <= clock
    REG_Wout.reset <= reset
    REG_Wout.io.din <= west_REG_din @[ProcessingElement.scala 314:21]
    REG_Wout.io.din_v <= west_REG_din_v @[ProcessingElement.scala 315:23]
    REG_Wout.io.dout_r <= io.west_dout_r @[ProcessingElement.scala 316:24]
    west_REG_din_r <= REG_Wout.io.din_r @[ProcessingElement.scala 318:20]
    io.west_dout <= REG_Wout.io.dout @[ProcessingElement.scala 319:18]
    io.west_dout_v <= REG_Wout.io.dout_v @[ProcessingElement.scala 320:20]
    inst CELL of CellProcessing @[ProcessingElement.scala 324:23]
    CELL.clock <= clock
    CELL.reset <= reset
    CELL.io.north_din <= north_buffer @[ProcessingElement.scala 325:23]
    CELL.io.north_din_v <= north_buffer_v @[ProcessingElement.scala 326:25]
    CELL.io.east_din <= east_buffer @[ProcessingElement.scala 327:22]
    CELL.io.east_din_v <= east_buffer_v @[ProcessingElement.scala 328:24]
    CELL.io.south_din <= south_buffer @[ProcessingElement.scala 329:23]
    CELL.io.south_din_v <= south_buffer_v @[ProcessingElement.scala 330:25]
    CELL.io.west_din <= west_buffer @[ProcessingElement.scala 331:22]
    CELL.io.west_din_v <= west_buffer_v @[ProcessingElement.scala 332:24]
    CELL.io.north_dout_r <= north_REG_din_r @[ProcessingElement.scala 333:26]
    CELL.io.east_dout_r <= east_REG_din_r @[ProcessingElement.scala 334:25]
    CELL.io.south_dout_r <= south_REG_din_r @[ProcessingElement.scala 335:26]
    CELL.io.west_dout_r <= west_REG_din_r @[ProcessingElement.scala 336:25]
    CELL.io.config_bits <= config_bits_reg @[ProcessingElement.scala 337:25]
    FU_din_1_r <= CELL.io.FU_din_1_r @[ProcessingElement.scala 339:16]
    FU_din_2_r <= CELL.io.FU_din_2_r @[ProcessingElement.scala 340:16]
    FU_dout <= CELL.io.dout @[ProcessingElement.scala 341:13]
    FU_dout_v <= CELL.io.dout_v @[ProcessingElement.scala 342:15]

