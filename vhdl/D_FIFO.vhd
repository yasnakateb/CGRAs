library IEEE;
use IEEE.STD_LOGIC_1164.ALL;

entity D_FIFO is
    generic(
        C_RST_POL    : std_logic    := '1';
        C_DATA_WIDTH : natural      := 32;
        C_FIFO_DEPTH : natural      := 32        
    );
    port(
        clk     : in std_logic;
        reset   : in std_logic;
        
        -- Data in
        din     : in std_logic_vector(C_DATA_WIDTH-1 downto 0);
        din_v   : in std_logic;
        din_r   : out std_logic;
        
        -- Data out
        dout    : out std_logic_vector(C_DATA_WIDTH-1 downto 0);
        dout_v  : out std_logic;
        dout_r  : in std_logic
    );
end D_FIFO;

architecture Behavioral of D_FIFO is
	
	type mem_array is array (0 to C_FIFO_DEPTH-1) of std_logic_vector(C_DATA_WIDTH-1 downto 0);
	signal memory : mem_array;
	signal write_pointer: integer range 0 to C_FIFO_DEPTH-1;
	signal read_pointer : integer range 0 to C_FIFO_DEPTH-1;
	signal full, empty, rd_en, wr_en : std_logic;
		
begin

	process(clk, reset)
		variable num_data : integer range 0 to C_FIFO_DEPTH;
	begin
		if reset = C_RST_POL then
		
			empty <= '1';
			full  <= '0';
			write_pointer <= 0;
			read_pointer <= 0;
			num_data := 0;
			dout <= (others => '0');
			dout_v <= '0';
			
		elsif clk'event and clk = '1' then
		
		    if dout_r = '1' then
                dout_v <= '0';
            end if;
            
            -- Write FIFO    
            if full = '0' and wr_en = '1' then
            
                memory(write_pointer) <= din;
                num_data := num_data + 1;
                
                if write_pointer = C_FIFO_DEPTH-1 then
                    write_pointer <= 0;
                else
                    write_pointer <= write_pointer + 1;
                end if;
                
            end if;
        
            -- Read FIFO
            if rd_en = '1' and empty = '0' then
            
                dout <= memory(read_pointer);
                dout_v <= '1';
                num_data := num_data - 1;
                
                if read_pointer = C_FIFO_DEPTH-1 then
                    read_pointer <= 0;
                else
                    read_pointer <= read_pointer + 1;
                end if;
                
            end if;
            
            -- Control
            if num_data = C_FIFO_DEPTH then
                full <= '1';
            else
                full <= '0';
            end if;            
            if num_data = 0 then 
                empty <= '1';
            else
                empty <= '0';
            end if;
            
        end if;
	end process;
	
	wr_en <= din_v and not full;
	rd_en <= dout_r and not empty;
	din_r <= not full;

end Behavioral;
