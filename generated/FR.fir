circuit FR :
  module ConfMux :
    input clock : Clock
    input reset : Reset
    output io : { flip selector : UInt<3>, flip mux_input : UInt<5>, mux_output : UInt<1>}

    wire inputs : UInt<1>[5] @[ConfMux.scala 25:22]
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
    io.mux_output <= inputs[io.selector] @[ConfMux.scala 30:19]

  module FR :
    input clock : Clock
    input reset : UInt<1>
    output io : { flip valid_in : UInt<5>, flip ready_out : UInt<5>, flip valid_mux_sel : UInt<3>, flip fork_mask : UInt<5>, valid_out : UInt<1>}

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
    inst conf_mux of ConfMux @[FR.scala 29:28]
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

