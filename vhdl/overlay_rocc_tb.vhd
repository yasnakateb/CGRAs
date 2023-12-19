library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;

entity overlay_rocc_tb is
end overlay_rocc_tb;

architecture testbench of overlay_rocc_tb is

    constant C_RST_POL         : std_logic := '1';
    constant C_FIXED_POINT     : boolean   := false;
    constant C_FRACTION_LENGTH : integer   := 16;
    constant C_DATA_WIDTH      : integer   := 32; 
    constant C_INPUT_NODES     : integer   := 6; 
    constant C_OUTPUT_NODES    : integer   := 6;
    constant C_FIFO_DEPTH      : integer   := 32;
    
    signal clk             : std_logic;
    signal reset           : std_logic;
    signal data_in         : std_logic_vector(C_DATA_WIDTH*C_INPUT_NODES - 1 downto 0);
    signal data_in_valid   : std_logic_vector(C_INPUT_NODES - 1 downto 0);
    signal data_in_ready   : std_logic_vector(C_INPUT_NODES - 1 downto 0);
    signal data_out        : std_logic_vector(C_DATA_WIDTH*C_INPUT_NODES - 1 downto 0);
    signal data_out_valid  : std_logic_vector(C_INPUT_NODES - 1 downto 0);
    signal data_out_ready  : std_logic_vector(C_INPUT_NODES - 1 downto 0);
    signal cell_config     : std_logic_vector(191 downto 0);
    
    constant clk_period : time := 10 ns;

begin

    dut: entity work.overlay_rocc
    generic map (
        C_RST_POL         => C_RST_POL        ,
        C_FIXED_POINT     => C_FIXED_POINT    ,
        C_FRACTION_LENGTH => C_FRACTION_LENGTH,
        C_DATA_WIDTH      => C_DATA_WIDTH     ,
        C_INPUT_NODES     => C_INPUT_NODES    ,
        C_OUTPUT_NODES    => C_OUTPUT_NODES   ,
        C_FIFO_DEPTH      => C_FIFO_DEPTH
    )
    port map ( 
        clk             => clk           ,
        reset           => reset         ,
        data_in         => data_in       ,
        data_in_valid   => data_in_valid ,
        data_in_ready   => data_in_ready ,
        data_out        => data_out      ,
        data_out_valid  => data_out_valid,
        data_out_ready  => data_out_ready,
        cell_config     => cell_config
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
        data_in        <= (others => '0');
        data_in_valid  <= (others => '0');
        data_out_ready <= (others => '1');
        
        cell_config    <= (others => '0');
        wait for clk_period * 100.5;
        
        reset <= '0';
        wait for clk_period * 10;
        
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
        
        assert false report "End of Simulation!" severity failure;
        wait;
    end process;

end testbench;
