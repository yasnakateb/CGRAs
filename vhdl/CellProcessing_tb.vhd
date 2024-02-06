library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;

entity CellProcessing_tb is
end CellProcessing_tb;

architecture testbench of CellProcessing_tb is

    constant C_RST_POL         : std_logic := '1';
    constant C_DATA_WIDTH      : integer   := 32; 
    constant C_FIXED_POINT     : boolean   := false;
    constant C_FRACTION_LENGTH : integer   := 16;
    
    signal clk          : std_logic;
    signal reset        : std_logic;
    signal north_din    : std_logic_vector (C_DATA_WIDTH-1 downto 0);
    signal north_din_v  : std_logic;
    signal east_din     : std_logic_vector (C_DATA_WIDTH-1 downto 0);
    signal east_din_v   : std_logic;
    signal south_din    : std_logic_vector (C_DATA_WIDTH-1 downto 0);
    signal south_din_v  : std_logic;
    signal west_din     : std_logic_vector (C_DATA_WIDTH-1 downto 0);
    signal west_din_v   : std_logic;
    signal FU_din_1_r   : std_logic;
    signal FU_din_2_r   : std_logic;
    signal dout         : std_logic_vector (C_DATA_WIDTH-1 downto 0);
    signal dout_v       : std_logic;
    signal north_dout_r : std_logic;
    signal east_dout_r  : std_logic;
    signal south_dout_r : std_logic;
    signal west_dout_r  : std_logic;
    signal config_bits  : std_logic_vector (181 downto 0);
    
    constant clk_period : time := 10 ns;

begin

    dut: entity work.cell_processing
    generic map (
        C_RST_POL         => C_RST_POL        ,
        C_DATA_WIDTH      => C_DATA_WIDTH     ,
        C_FIXED_POINT     => C_FIXED_POINT    ,
        C_FRACTION_LENGTH => C_FRACTION_LENGTH      
    )
    port map (
        clk          => clk,
        reset        => reset,
        north_din    => north_din,
        north_din_v  => north_din_v,
        east_din     => east_din,
        east_din_v   => east_din_v,
        south_din    => south_din,
        south_din_v  => south_din_v,
        west_din     => west_din,
        west_din_v   => west_din_v,
        FU_din_1_r   => FU_din_1_r,
        FU_din_2_r   => FU_din_2_r,
        dout         => dout,
        dout_v       => dout_v,
        north_dout_r => north_dout_r,
        east_dout_r  => east_dout_r,
        south_dout_r => south_dout_r,
        west_dout_r  => west_dout_r,
        config_bits  => config_bits
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
        north_din <= (others => '0');
        north_din_v <= '0';
        east_din <= (others => '0');
        east_din_v <= '0';
        south_din <= (others => '0');
        south_din_v <= '0';
        west_din <= (others => '0');
        west_din_v <= '0';
        north_dout_r <= '0';
        east_dout_r <= '0';
        south_dout_r <= '0';
        west_dout_r <= '0';
        config_bits <= (others => '0');

        reset <= '1';
        wait for clk_period * 100.5;
        
        reset <= '0';
        wait for clk_period * 10;
        
        -- Config
        config_bits <= "00000000000111101100000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000001000000000010000000000000001000000000000000000000000011";
      
        wait for clk_period * 10;
        
        -- Operate
        north_din(C_DATA_WIDTH-1 downto 0) <= std_logic_vector(to_unsigned(2, C_DATA_WIDTH));
        west_din(C_DATA_WIDTH-1 downto 0) <= std_logic_vector(to_unsigned(4, C_DATA_WIDTH));
        north_din_v <= '1';
        west_din_v <= '1'; 
        wait for (5) * clk_period;
        north_din_v <= '0';
        west_din_v <= '0'; 
        north_din <= (others => '0');
        west_din <= (others => '0');
        wait for clk_period * 100;
        
        assert false report "End of Simulation!" severity failure;
        wait;
    end process;

end testbench;
