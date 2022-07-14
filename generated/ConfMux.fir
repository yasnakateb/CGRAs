circuit ConfMux :
  module ConfMux :
    input clock : Clock
    input reset : UInt<1>
    output io : { flip selector : UInt<1>, flip mux_input : UInt<2>, mux_output : UInt<1>}

    wire inputs : UInt<1>[2] @[ConfMux.scala 30:22]
    node _inputs_0_T = bits(io.mux_input, 0, 0) @[ConfMux.scala 32:34]
    inputs[0] <= _inputs_0_T @[ConfMux.scala 32:19]
    node _inputs_1_T = bits(io.mux_input, 1, 1) @[ConfMux.scala 32:34]
    inputs[1] <= _inputs_1_T @[ConfMux.scala 32:19]
    io.mux_output <= inputs[io.selector] @[ConfMux.scala 34:19]

