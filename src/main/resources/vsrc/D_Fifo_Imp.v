module D_Fifo_Imp #(parameter dataWidth = 32, fifoDepth = 32)
  (
  input                       clock,
  input                       reset,
  input  [dataWidth -1:0]     din,
  input                       dinValid,
  input                       doutReady,
  output                      dinReady,
  output reg [dataWidth-1:0]  dout,
  output reg doutValid
  );
      
  reg [dataWidth-1:0] memory [fifoDepth-1:0];

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
      doutValid <= 1'b0;	
    end else begin
      if  (doutReady)
        doutValid <= 1'b0;

      if (~full & wr_en) begin 
        memory[write_pointer] <= din;
        num_data = num_data + 1;
                
        if (write_pointer == fifoDepth) 
          write_pointer <= 5'b0;
        else
          write_pointer <= write_pointer + 1;     
      end
      
      if (~empty & rd_en) begin
        dout <= memory[read_pointer];
        doutValid <= 1'b1;
        num_data = num_data - 1;
        
        if (read_pointer == fifoDepth) 
          read_pointer <= 0;
        else
          read_pointer <= read_pointer + 1; 
      end

      if (num_data == fifoDepth-1)
        full <= 1'b1;
      else
        full <= 1'b0;
                  
      if (num_data == 0) 
        empty <= 1'b1;
      else
        empty <= 1'b0;

    end
end 

assign wr_en = dinValid & (~full);
assign rd_en = doutReady & (~empty);
assign dinReady = (~full);

endmodule