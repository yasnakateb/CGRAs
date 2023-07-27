module D_FIFO(
    input         clock,
    input         reset,
    input  [31:0] io_din,
    input         io_din_v,
    input         io_dout_r,
    output        io_din_r,
    output reg [31:0] io_dout,
    output reg io_dout_v
    );

    reg [31:0] memory [0:31];

    reg [4:0] write_pointer = 5'b0;
    reg [4:0] read_pointer = 5'b0;
    reg [4:0] num_data = 5'b0;

    reg full;	
    reg empty;
    wire rd_en;
    wire wr_en;

    assign wr_en = io_din_v & (~full);
	assign rd_en = io_dout_r & (~empty);
	assign io_din_r = (~full);

    always @(posedge clock) begin
        if (reset) begin 
            empty <= 1'b1;
            full  <= 1'b0;
            write_pointer <= 5'b0;
            read_pointer <= 5'b0;
            num_data <= 32'b0;
            io_dout <= 32'b0;
            io_dout_v <= 1'b0;	
        end 

        if  (io_dout_r)
            io_dout_v <= 1'b0;

        if (~empty & rd_en) begin 
            io_dout <= memory[read_pointer];
            io_dout_v <= 1'b1;
            num_data <= num_data - 32'd1;
            
            if (read_pointer == 32'd31) 
                read_pointer <= 0;
            else
                read_pointer <= read_pointer + 1; 
        end

        if (~full & wr_en) begin 
            memory[write_pointer] <= io_din;
            num_data <= num_data + 32'd1;
                    
            if (write_pointer == 32'd31) 
                write_pointer <= 5'b0;
            else
                write_pointer <= write_pointer + 1;     
        end
        
        if (num_data == 32'd31)
            full <= 1'b1;
        else
            full <= 1'b0;
                    
        if (num_data == 0) 
            empty <= 1'b1;
        else
            empty <= 1'b0;
    end 

endmodule