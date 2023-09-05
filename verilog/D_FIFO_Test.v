module D_FIFO_Test();

    reg clock;
    reg reset;
    reg [31:0] io_din;
    reg io_din_v;
    reg io_dout_r;
    wire io_din_r;
    wire [31:0] io_dout;
    wire io_dout_v;
    

    D_FIFO DUT( 
        .clock(clock), 
        .reset(reset), 
        .io_din(io_din), 
        .io_din_v(io_din_v), 
        .io_dout_r(io_dout_r), 
        .io_din_r(io_din_r),
        .io_dout(io_dout),
        .io_dout_v(io_dout_v)
        );

    initial begin
        clock = 1;
        forever 
        #5 clock = ~clock;
    end
        
    integer idx;

    initial begin
        $dumpfile("D_FIFO_Test.vcd");
        $dumpvars(0,D_FIFO_Test);
        for (idx = 0; idx < 32; idx = idx + 1) 
            $dumpvars(0, D_FIFO_Test.DUT.memory[idx]);

      

        reset = 1'b1;
        io_dout_r = 1'b1;
        io_din_v = 1'b0;
        #10;
        reset = 1'b0;
        #10
        io_din_v = 1'b1;
        io_din = 32'b1;
        #10
        io_din = 32'd3;
        #10
        io_din = 32'd5;
        #10
        io_din = 32'd7;
        #10
        io_din = 32'd9;
        #10
        io_din = 32'd1;
        #10
        io_din = 32'd3;
        #10
        io_din = 32'd5;
        #10
        io_din = 32'd7;
        #10
        io_din = 32'd9;
        #10
        io_din_v = 1'b0;

        #100;
        $finish;
    end
			
endmodule