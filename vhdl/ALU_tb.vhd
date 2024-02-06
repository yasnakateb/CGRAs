library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;

entity ALU_tb is
end ALU_tb;

architecture testbench of ALU_tb is

    constant C_RST_POL         : std_logic := '1';
    constant C_DATA_WIDTH      : integer   := 32; 
    constant C_FIXED_POINT     : boolean   := false;
    constant C_FRACTION_LENGTH : integer   := 16;
    
  
    
    signal clk           : std_logic;
    signal reset         : std_logic;
    signal din_1         : std_logic_vector(C_DATA_WIDTH - 1 downto 0);
    signal din_2         : std_logic_vector(C_DATA_WIDTH - 1 downto 0);
    signal dout          : std_logic_vector(C_DATA_WIDTH - 1 downto 0);
    signal op_config     : std_logic_vector(4 downto 0);
    
    constant clk_period : time := 10 ns;

begin

    dut: entity work.ALU
    generic map (
        C_RST_POL         => C_RST_POL        ,
        C_DATA_WIDTH      => C_DATA_WIDTH     ,
        C_FIXED_POINT     => C_FIXED_POINT    ,
        C_FRACTION_LENGTH => C_FRACTION_LENGTH
        
    )
    port map ( 
        
        din_1       => din_1    ,
        din_2       => din_2    ,
        dout        => dout     ,
        op_config => op_config
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
        reset  <= C_RST_POL;
        din_1  <= (others => '0');
        din_2  <= (others => '0');
      
        
        op_config  <= (others => '0');
        wait for clk_period * 100.5;
        
        reset <= '0';
        wait for clk_period * 10;
        
       
        for i in 0 to 8 loop
        
            din_1 <= std_logic_vector(to_signed(i, C_DATA_WIDTH));
            din_2 <= std_logic_vector(to_signed(2*i, C_DATA_WIDTH));
            op_config    <= (others => '0');
            
            wait for clk_period * 10;
            
       end loop;
        
        
        assert false report "End of Simulation!" severity failure;
        wait;
    end process;

end testbench;


