library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;

entity Join_tb is
end Join_tb;

architecture testbench of Join_tb is

    constant C_DATA_WIDTH      : integer   := 32; 
    
    -- Separate inputs
    signal din_1   : std_logic_vector(C_DATA_WIDTH - 1 downto 0);
    signal din_1_v : std_logic;
    signal din_1_r : std_logic;
    signal din_2   : std_logic_vector(C_DATA_WIDTH - 1 downto 0);
    signal din_2_v : std_logic;
    signal din_2_r : std_logic;
    
    signal dout_1  : std_logic_vector(C_DATA_WIDTH - 1 downto 0);
    signal dout_2  : std_logic_vector(C_DATA_WIDTH - 1 downto 0);
    signal dout_v  : std_logic;
    signal dout_r  : std_logic;
     signal clk    :  std_logic;
    
    constant clk_period : time := 10 ns;

begin

    dut: entity work.Join
    generic map (
        C_DATA_WIDTH      => C_DATA_WIDTH     
    )
    port map ( 

        din_1   => din_1  ,
        din_1_v => din_1_v,
        din_1_r => din_1_r,
        din_2   => din_2  ,
        din_2_v => din_2_v,
        din_2_r => din_2_r,
        dout_1  => dout_1 ,
        dout_2  => dout_2 ,
        dout_v  => dout_v ,
        dout_r  => dout_r 
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
      
        din_1   <= (others => '0');
        din_2   <= (others => '0');
        din_1_v <= '0';
        din_2_v <= '0';
        dout_r <= '0';
       
        -- Operate
        for i in 0 to 15 loop
        
            din_1(C_DATA_WIDTH-1 downto 0) <= std_logic_vector(to_unsigned(i, C_DATA_WIDTH));
            din_2(C_DATA_WIDTH-1 downto 0) <= std_logic_vector(to_unsigned(i, C_DATA_WIDTH));
            
            din_1_v <= '1';
            din_2_v <= '1';
            wait for (i + 1) * clk_period;
            
            din_1_v <= '0';
            din_2_v <= '0';
            wait for clk_period * 10;
            
        end loop;
        
        assert false report "End of Simulation!" severity failure;
        wait;
    end process;

end testbench;
