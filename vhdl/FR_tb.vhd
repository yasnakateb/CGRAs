library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;
use ieee.math_real.all;


entity FR_tb is
end FR_tb;

architecture testbench of FR_tb is

    constant C_NUMBER_OF_VALIDS : integer   := 5; 
    constant C_NUMBER_OF_READYS : integer   := 5; 
    
    signal valid_in        :  std_logic_vector(C_NUMBER_OF_VALIDS-1 downto 0);
    signal valid_out       :  std_logic;
    signal ready_out       :  std_logic_vector(C_NUMBER_OF_READYS-1 downto 0);
    signal valid_mux_sel   :  std_logic_vector( integer(ceil(log2(real(C_NUMBER_OF_VALIDS))))-1 downto 0);
    signal fork_mask       :  std_logic_vector (C_NUMBER_OF_READYS-1 downto 0); 
    signal clk              :  std_logic;

    constant clk_period : time := 10 ns;

begin

    dut: entity work.fork_receiver
    generic map (
        C_NUMBER_OF_VALIDS => C_NUMBER_OF_VALIDS,
        C_NUMBER_OF_READYS => C_NUMBER_OF_READYS
        
    )
    port map ( 
        valid_in       => valid_in     ,
        valid_out      => valid_out    ,
        ready_out      => ready_out    ,
        valid_mux_sel  => valid_mux_sel,
        fork_mask      => fork_mask    
    );

    process
    begin
        clk <= '1';
        wait for clk_period / 2;
        clk <= '0';
        wait for clk_period / 2;
    end process;
    
    process begin
      
        valid_in      <= (others => '0');
        ready_out     <= (others => '0');
        valid_mux_sel <= (others => '0');
        fork_mask     <= (others => '0');
        
        wait for clk_period * 100.5;

        valid_in      <= "11011";  
        ready_out     <= "11011";
        valid_mux_sel <= "010";
        fork_mask     <= "11011";
                
        
        assert false report "End of Simulation!" severity failure;
        wait;
     end process;

end testbench;

