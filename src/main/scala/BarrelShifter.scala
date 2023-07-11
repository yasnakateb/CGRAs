/****************************************** 
 *      \`-._           __                *
 *       \\  `-..____,.'  `.              *
 *        :`.         /    \`.            *
 *        :  )       :      : \           *
 *         ;'        '   ;  |  :          *
 *         )..      .. .:.`.;  :          *
 *        /::...  .:::...   ` ;           *
 *        ; _ '    __        /:\          *
 *        `:o>   /\o_>      ;:. `.        *
 *       `-`.__ ;   __..--- /:.   \       *
 *       === \_/   ;=====_.':.     ;      *
 *        ,/'`--'...`--....        ;      *
 *             ;                    ;     *
 *           .'                      ;    *
 *         .'                        ;    *
 *       .'     ..     ,      .       ;   *
 *      :       ::..  /      ;::.     |   *
 *     /      `.;::.  |       ;:..    ;   *
 *    :         |:.   :       ;:.    ;    *
 *    :         ::     ;:..   |.    ;     *
 *     :       :;      :::....|     |     *
 *     /\     ,/ \      ;:::::;     ;     *
 *   .:. \:..|    :     ; '.--|     ;     *
 *  ::.  :''  `-.,,;     ;'   ;     ;     *
 * .-'. _.'\      / `;      \,__:      \  *
 * `---'    `----'   ;      /    \,.,,,/  *
 *                  `----`                *
 * ****************************************
 * Yasna Katebzadeh                       *
 * yasna.katebzadeh@gmail.com             *
 ******************************************/

import chisel3._
import chisel3.util._

class BarrelShifter extends Module {
  val io = IO(new Bundle {
    //?
    //val load = Input(Bool())
    val rshift = Input(Bool())
    val lshift = Input(Bool())
    val shiftnum = Input(UInt(5.W))
    val inbit = Input(UInt(1.W))
    //Bit to shift into empty places
    val in = Input(UInt(32.W))
    val out = Output(UInt(32.W))
  })

  val reg_out = RegInit(0.U(32.W))

  /*************************************
  // Why do we need to load the input?
  *************************************/
  
  //when(io.load) {
    reg_out := io.in
  /*
  }.elsewhen(io.rshift) {
    
    switch(io.shiftnum) {
      is(0.U) {
        reg_out := reg_out
      }
      is(1.U) {
        reg_out := Cat(io.inbit, reg_out(31, 1))
      }
      is(2.U) {
        reg_out := Cat(Fill(2, io.inbit), reg_out(31, 2))
      }
      is(3.U) {
        reg_out := Cat(Fill(3, io.inbit), reg_out(31, 3))
      }
      is(4.U) {
        reg_out := Cat(Fill(4, io.inbit), reg_out(31, 4))
      }
      is(5.U) {
        reg_out := Cat(Fill(5, io.inbit), reg_out(31, 5))
      }
      is(6.U) {
        reg_out := Cat(Fill(6, io.inbit), reg_out(31, 6))
      }
      is(7.U) {
        reg_out := Cat(Fill(7, io.inbit), reg_out(31, 7))
      }
      is(8.U) {
        reg_out := Cat(Fill(8, io.inbit), reg_out(31, 8))
      }
      is(9.U) {
        reg_out := Cat(Fill(9, io.inbit), reg_out(31, 9))
      }
      is(10.U) {
        reg_out := Cat(Fill(10, io.inbit), reg_out(31, 10))
      }
      is(11.U) {
        reg_out := Cat(Fill(11, io.inbit), reg_out(31, 11))
      }
      is(12.U) {
        reg_out := Cat(Fill(12, io.inbit), reg_out(31, 12))
      }
      is(13.U) {
        reg_out := Cat(Fill(13, io.inbit), reg_out(31, 13))
      }
      is(14.U) {
        reg_out := Cat(Fill(14, io.inbit), reg_out(31, 14))
      }
      is(15.U) {
        reg_out := Cat(Fill(15, io.inbit), reg_out(31, 15))
      }
      is(16.U) {
        reg_out := Cat(Fill(16, io.inbit), reg_out(31, 16))
      }
      is(17.U) {
        reg_out := Cat(Fill(17, io.inbit), reg_out(31, 17))
      }
      is(18.U) {
        reg_out := Cat(Fill(18, io.inbit), reg_out(31, 18))
      }
      is(19.U) {
        reg_out := Cat(Fill(19, io.inbit), reg_out(31, 19))
      }
      is(20.U) {
        reg_out := Cat(Fill(20, io.inbit), reg_out(31, 20))
      }
      is(21.U) {
        reg_out := Cat(Fill(21, io.inbit), reg_out(31, 21))
      }
      is(22.U) {
        reg_out := Cat(Fill(22, io.inbit), reg_out(31, 22))
      }
      is(23.U) {
        reg_out := Cat(Fill(23, io.inbit), reg_out(31, 23))
      }
      is(24.U) {
        reg_out := Cat(Fill(24, io.inbit), reg_out(31, 24))
      }
      is(25.U) {
        reg_out := Cat(Fill(25, io.inbit), reg_out(31, 25))
      }
      is(26.U) {
        reg_out := Cat(Fill(26, io.inbit), reg_out(31, 26))
      }
      is(27.U) {
        reg_out := Cat(Fill(27, io.inbit), reg_out(31, 27))
      }
      is(28.U) {
        reg_out := Cat(Fill(28, io.inbit), reg_out(31, 28))
      }
      is(29.U) {
        reg_out := Cat(Fill(29, io.inbit), reg_out(31, 29))
      }
      is(30.U) {
        reg_out := Cat(Fill(30, io.inbit), reg_out(31, 30))
      }
      is(31.U) {
        reg_out := Cat(Fill(31, io.inbit), reg_out(31))
      }

    }


  }.elsewhen(io.lshift) { */
  when(io.lshift){
    switch(io.shiftnum) {
      is(0.U) {
        reg_out := reg_out
      }
      is(1.U) {
        reg_out := Cat(reg_out(30, 0), io.inbit)
      }
      is(2.U) {
        reg_out := Cat(reg_out(29, 0), Fill(2, io.inbit))
      }
      is(3.U) {
        reg_out := Cat(reg_out(28, 0), Fill(3, io.inbit))
      }
      is(4.U) {
        reg_out := Cat(reg_out(27, 0), Fill(4, io.inbit))
      }
      is(5.U) {
        reg_out := Cat(reg_out(26, 0), Fill(5, io.inbit))
      }
      is(6.U) {
        reg_out := Cat(reg_out(25, 0), Fill(6, io.inbit))
      }
      is(7.U) {
        reg_out := Cat(reg_out(24, 0), Fill(7, io.inbit))
      }
      is(8.U) {
        reg_out := Cat(reg_out(23, 0), Fill(8, io.inbit))
      }
      is(9.U) {
        reg_out := Cat(reg_out(22, 0), Fill(9, io.inbit))
      }
      is(10.U) {
        reg_out := Cat(reg_out(21, 0), Fill(10, io.inbit))
      }
      is(11.U) {
        reg_out := Cat(reg_out(20, 0), Fill(11, io.inbit))
      }
      is(12.U) {
        reg_out := Cat(reg_out(19, 0), Fill(12, io.inbit))
      }
      is(13.U) {
        reg_out := Cat(reg_out(18, 0), Fill(13, io.inbit))
      }
      is(14.U) {
        reg_out := Cat(reg_out(17, 0), Fill(14, io.inbit))
      }
      is(15.U) {
        reg_out := Cat(reg_out(16, 0), Fill(15, io.inbit))
      }
      is(16.U) {
        reg_out := Cat(reg_out(15, 0), Fill(16, io.inbit))
      }
      is(17.U) {
        reg_out := Cat(reg_out(14, 0), Fill(17, io.inbit))
      }
      is(18.U) {
        reg_out := Cat(reg_out(13, 0), Fill(18, io.inbit))
      }
      is(19.U) {
        reg_out := Cat(reg_out(12, 0), Fill(19, io.inbit))
      }
      is(20.U) {
        reg_out := Cat(reg_out(11, 0), Fill(20, io.inbit))
      }
      is(21.U) {
        reg_out := Cat(reg_out(10, 0), Fill(21, io.inbit))
      }
      is(22.U) {
        reg_out := Cat(reg_out(9, 0), Fill(22, io.inbit))
      }
      is(23.U) {
        reg_out := Cat(reg_out(8, 0), Fill(23, io.inbit))
      }
      is(24.U) {
        reg_out := Cat(reg_out(7, 0), Fill(24, io.inbit))
      }
      is(25.U) {
        reg_out := Cat(reg_out(6, 0), Fill(25, io.inbit))
      }
      is(26.U) {
        reg_out := Cat(reg_out(5, 0), Fill(26, io.inbit))
      }
      is(27.U) {
        reg_out := Cat(reg_out(4, 0), Fill(27, io.inbit))
      }
      is(28.U) {
        reg_out := Cat(reg_out(3, 0), Fill(28, io.inbit))
      }
      is(29.U) {
        reg_out := Cat(reg_out(2, 0), Fill(29, io.inbit))
      }
      is(30.U) {
        reg_out := Cat(reg_out(1, 0), Fill(30, io.inbit))
      }
      is(31.U) {
        reg_out := Cat(reg_out(0), Fill(31, io.inbit))
      }
    }
  }


  io.out := reg_out

}

// Generate the Verilog code
object BarrelShifterMain extends App {
    println("Generating the hardware")
    (new chisel3.stage.ChiselStage).emitVerilog(new BarrelShifter, Array("--target-dir", "generated"))
}



