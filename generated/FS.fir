circuit FS :
  module FS :
    input clock : Clock
    input reset : UInt<1>
    output io : { flip afu_in_1 : UInt<1>, flip afu_in_2 : UInt<1>, flip ae_out : UInt<1>, flip as_out : UInt<1>, flip aw_out : UInt<1>, an_in : UInt<1>}

    wire configuration_mask : UInt<5> @[FS.scala 20:34]
    configuration_mask <= UInt<5>("h5") @[FS.scala 21:24]
    node _io_an_in_T = bits(configuration_mask, 4, 4) @[FS.scala 23:38]
    node _io_an_in_T_1 = not(_io_an_in_T) @[FS.scala 23:18]
    node _io_an_in_T_2 = or(_io_an_in_T_1, io.afu_in_1) @[FS.scala 23:42]
    node _io_an_in_T_3 = bits(configuration_mask, 3, 3) @[FS.scala 24:40]
    node _io_an_in_T_4 = not(_io_an_in_T_3) @[FS.scala 24:20]
    node _io_an_in_T_5 = or(_io_an_in_T_4, io.afu_in_2) @[FS.scala 24:44]
    node _io_an_in_T_6 = and(_io_an_in_T_2, _io_an_in_T_5) @[FS.scala 23:57]
    node _io_an_in_T_7 = bits(configuration_mask, 2, 2) @[FS.scala 25:40]
    node _io_an_in_T_8 = not(_io_an_in_T_7) @[FS.scala 25:20]
    node _io_an_in_T_9 = or(_io_an_in_T_8, io.ae_out) @[FS.scala 25:44]
    node _io_an_in_T_10 = and(_io_an_in_T_6, _io_an_in_T_9) @[FS.scala 24:59]
    node _io_an_in_T_11 = bits(configuration_mask, 1, 1) @[FS.scala 26:40]
    node _io_an_in_T_12 = not(_io_an_in_T_11) @[FS.scala 26:20]
    node _io_an_in_T_13 = or(_io_an_in_T_12, io.as_out) @[FS.scala 26:44]
    node _io_an_in_T_14 = and(_io_an_in_T_10, _io_an_in_T_13) @[FS.scala 25:57]
    node _io_an_in_T_15 = bits(configuration_mask, 0, 0) @[FS.scala 27:40]
    node _io_an_in_T_16 = not(_io_an_in_T_15) @[FS.scala 27:20]
    node _io_an_in_T_17 = or(_io_an_in_T_16, io.aw_out) @[FS.scala 27:44]
    node _io_an_in_T_18 = and(_io_an_in_T_14, _io_an_in_T_17) @[FS.scala 26:57]
    io.an_in <= _io_an_in_T_18 @[FS.scala 23:14]

