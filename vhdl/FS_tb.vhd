library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;


entity FS_tb is
end FS_tb;

architecture testbench of FS_tb is

    constant C_NUMBER_OF_READYS : integer   := 5; 
    
    signal ready_in     : std_logic;
    signal ready_out    : std_logic_vector(C_NUMBER_OF_READYS-1 downto 0);
    signal fork_mask    : std_logic_vector(C_NUMBER_OF_READYS-1 downto 0);
    signal clk          : std_logic;
    constant clk_period : time := 10 ns;

begin

    dut: entity work.fork_sender
    generic map (
        C_NUMBER_OF_READYS => C_NUMBER_OF_READYS
        
    )
    port map ( 
        ready_in => ready_in,  
        ready_out  => ready_out,
        fork_mask  => fork_mask
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
        ready_out  <= (others => '0');
        fork_mask  <= (others => '0');
        
        wait for clk_period * 100.5;

        ready_out  <= "11111";
        fork_mask  <= "11000";

        assert false report "End of Simulation!" severity failure;
        wait;
        
    end process;
end testbench;
    