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
        op_config => cell_config,
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
        din_1        <= (others => '0');
        din_2  <= (others => '0');
        dout <= (others => '1');
        
        cell_config    <= (others => '0');
        wait for clk_period * 100.5;
        
        reset <= '0';
        wait for clk_period * 10;
        
        /*
        -- Config
        cell_config <= "100010000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000100000000000000000100000000";
        wait for clk_period;
        cell_config <= "100010100000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000001000000000010000000000000001000000000000000000000000011";
        wait for clk_period;
        cell_config <= (others => '0');
        wait for clk_period * 10;
        
        -- Operate
        for i in 0 to 15 loop
        
            data_in(C_DATA_WIDTH*C_INPUT_NODES-1 downto C_DATA_WIDTH*(C_INPUT_NODES-1)) <= std_logic_vector(to_unsigned(i, C_DATA_WIDTH));
            data_in(C_DATA_WIDTH*(C_INPUT_NODES-1)-1 downto C_DATA_WIDTH*(C_INPUT_NODES-2)) <= std_logic_vector(to_unsigned(2*i, C_DATA_WIDTH));
            data_in_valid <= "110000";
            wait for (i + 1) * clk_period;
            data_in_valid <= "000000";
            wait for clk_period * 10;
            
        end loop;

        */
        
        assert false report "End of Simulation!" severity failure;
        wait;
    end process;

end testbench;



