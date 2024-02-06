library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;

entity FU_tb is
end FU_tb;

architecture testbench of FU_tb is

    constant C_RST_POL         : std_logic := '1';
    constant C_DATA_WIDTH      : integer   := 32; 
    constant C_FIXED_POINT     : boolean   := false;
    constant C_FRACTION_LENGTH : integer   := 16;

    signal clk              : std_logic;
    signal reset            : std_logic;
    signal din_1            : std_logic_vector (C_DATA_WIDTH - 1 downto 0);
    signal din_2            : std_logic_vector (C_DATA_WIDTH - 1 downto 0);
    signal din_v            : std_logic;
    signal din_r            : std_logic;
    signal dout             : std_logic_vector (C_DATA_WIDTH - 1 downto 0);
    signal dout_v           : std_logic;
    signal dout_r           : std_logic;
    signal loop_source      : std_logic_vector (1 downto 0);
    signal iterations_reset : std_logic_vector (15 downto 0);
    signal op_config        : std_logic_vector (4 downto 0);

    constant clk_period : time := 10 ns;

begin

    dut: entity work.FU
    generic map (
        C_RST_POL         => C_RST_POL        ,
        C_DATA_WIDTH      => C_DATA_WIDTH     ,
        C_FIXED_POINT     => C_FIXED_POINT    ,
        C_FRACTION_LENGTH => C_FRACTION_LENGTH
    )
    port map (
        clk              => clk,
        reset            => reset,
        din_1            => din_1,
        din_2            => din_2,
        din_v            => din_v,
        din_r            => din_r,
        dout             => dout,
        dout_v           => dout_v,
        dout_r           => dout_r,

        loop_source      => loop_source,
        iterations_reset => iterations_reset,
        op_config        => op_config
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
        din_1 <= (others => '0');
        din_2 <= (others => '0');
        din_v <= '0';
        dout_r <= '1';
        loop_source <= (others => '0');
        iterations_reset <= (others => '0');
        op_config <= (others => '0');

        wait for clk_period * 100.5;
        
        reset <= '0';
        wait for clk_period * 10;
        
        -- Operate
        for i in 0 to 15 loop
        
            din_1(C_DATA_WIDTH-1 downto 0) <= std_logic_vector(to_unsigned(i, C_DATA_WIDTH));
            din_2(C_DATA_WIDTH-1 downto 0) <= std_logic_vector(to_unsigned(i, C_DATA_WIDTH));
           
            din_v <= '1';
            wait for (i + 1) * clk_period;
            din_v <= '0';
            wait for clk_period * 10;
            
        end loop;
        
        assert false report "End of Simulation!" severity failure;
        wait;
    end process;

end testbench;
