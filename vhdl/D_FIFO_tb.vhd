library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;


entity D_FIFO_tb is
end D_FIFO_tb;

architecture testbench of D_FIFO_tb is

    constant C_RST_POL         : std_logic := '1';
    constant C_DATA_WIDTH      : integer   := 32; 
    constant C_FIFO_DEPTH      : integer   := 4;
    
    signal clk             : std_logic;
    signal reset           : std_logic;
    
    signal din     : std_logic_vector(C_DATA_WIDTH-1 downto 0);
    signal din_v   : std_logic;
    signal din_r   : std_logic;
    
    -- Data out
    signal dout    : std_logic_vector(C_DATA_WIDTH-1 downto 0);
    signal dout_v  : std_logic;
    signal dout_r  : std_logic;
    
    constant clk_period : time := 10 ns;

begin

    dut: entity work.D_FIFO
    generic map (
        C_RST_POL         => C_RST_POL        ,
        C_DATA_WIDTH      => C_DATA_WIDTH     ,
        C_FIFO_DEPTH      => C_FIFO_DEPTH
    )
    port map ( 

        clk       =>  clk,
        reset     =>  reset,
                
        -- Data
        din       =>  din, 
        din_v     =>  din_v,
        din_r     =>  din_r, 
                
        -- Data
        dout      =>  dout,
        dout_v    =>  dout_v,
        dout_r    =>  dout_r
    );

    process
    begin
        clk <= '1';
        wait for clk_period / 2;
        clk <= '0';
        wait for clk_period / 2;
    end process;
    
    process
    begin
        reset          <= C_RST_POL;
        din        <= (others => '0');
        din_v  <= '0';
        dout_r <= '1';
        
        wait for clk_period * 100.5;
        
        reset <= '0';
        wait for clk_period * 10;
        
        
        -- Operate
        for i in 0 to 15 loop
        
            
            din <= std_logic_vector(to_unsigned(i, C_DATA_WIDTH));
            din_v <= '1';
            wait for (i + 1) * clk_period;
            din_v <= '0';
            wait for clk_period * 10;
            
        end loop;
        
        assert false report "End of Simulation!" severity failure;
        wait;
end process;