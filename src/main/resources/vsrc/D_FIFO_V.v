module D_FIFO_V
    
    #(parameter DATA_WIDTH = 32, FIFO_DEPTH = 32)
    
    (
    input                       clock,
    input                       reset,
    input  [DATA_WIDTH -1:0]       din,
    input                       din_v,
    input                       dout_r,
    output                      din_r,
    output reg [DATA_WIDTH-1:0]   dout,
    output reg dout_v
    );
        
    reg [DATA_WIDTH-1:0] memory [FIFO_DEPTH-1:0];

    reg [4:0] write_pointer = 5'b0;
    reg [4:0] read_pointer = 5'b0;
    reg [4:0] num_data = 0;

    reg full;	
    reg empty;
    wire rd_en;
    wire wr_en;

    
    always @(posedge clock) begin
        if (reset) begin 
            empty <= 1'b1;
            full  <= 1'b0;
            write_pointer <= 5'b0;
            read_pointer <= 5'b0;
            num_data = 0;
            dout <= 32'b0;
            dout_v <= 1'b0;	
        end 

        if  (dout_r)
            dout_v <= 1'b0;

        if (~full & wr_en) begin 
            memory[write_pointer] <= din;
            num_data = num_data + 1;
                    
            if (write_pointer == FIFO_DEPTH) 
                write_pointer <= 5'b0;
            else
                write_pointer <= write_pointer + 1;     
        end
        
        if (~empty & rd_en) begin
            
            dout <= memory[read_pointer];
            dout_v <= 1'b1;
            num_data = num_data - 1;
            
            if (read_pointer == FIFO_DEPTH) 
                read_pointer <= 0;
            else
                read_pointer <= read_pointer + 1; 
            
        end

        if (num_data == FIFO_DEPTH-1)
            full <= 1'b1;
        else
            full <= 1'b0;
                    
        if (num_data == 0) 
            empty <= 1'b1;
        else
            empty <= 1'b0;
    end 

assign wr_en = din_v & (~full);
assign rd_en = dout_r & (~empty);
assign din_r = (~full);

endmodule
