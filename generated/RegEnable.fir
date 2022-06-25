circuit RegEnable :
  module RegEnable :
    input clock : Clock
    input reset : UInt<1>
    output io : { flip in : UInt<8>, flip en : UInt<1>, out : UInt<8>}

    wire regNext : UInt<8> @[RegEnable.scala 11:23]
    regNext <= io.in @[RegEnable.scala 12:13]
    reg myReg : UInt<8>, clock with :
      reset => (UInt<1>("h0"), myReg) @[Reg.scala 16:16]
    when io.en : @[Reg.scala 17:18]
      myReg <= regNext @[Reg.scala 17:22]
    io.out <= myReg @[RegEnable.scala 14:12]

