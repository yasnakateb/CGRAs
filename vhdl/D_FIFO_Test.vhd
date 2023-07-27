
LIBRARY ieee;
USE ieee.std_logic_1164.ALL;
USE ieee.numeric_std.ALL;
 
ENTITY D_FIFO_Test IS
END D_FIFO_Test;
 
ARCHITECTURE behavior OF D_FIFO_Test IS 
 
    -- Component Declaration for the Unit Under Test (UUT)
 
    COMPONENT D_FIFO
    PORT(
         clk : IN  std_logic;
         reset : IN  std_logic;
         din : IN  std_logic_vector(31 downto 0);
         din_v : IN  std_logic;
         din_r : OUT  std_logic;
         dout : OUT  std_logic_vector(31 downto 0);
         dout_v : OUT  std_logic;
         dout_r : IN  std_logic
        );
    END COMPONENT;
    

   --Inputs
   signal clk : std_logic := '0';
   signal reset : std_logic := '0';
   signal din : std_logic_vector(31 downto 0) := (others => '0');
   signal din_v : std_logic := '0';
   signal dout_r : std_logic := '0';

 	--Outputs
   signal din_r : std_logic;
   signal dout : std_logic_vector(31 downto 0);
   signal dout_v : std_logic;

   -- Clock period definitions
   constant clk_period : time := 10 ns;
 
BEGIN
 
	-- Instantiate the Unit Under Test (UUT)
   uut: D_FIFO PORT MAP (
          clk => clk,
          reset => reset,
          din => din,
          din_v => din_v,
          din_r => din_r,
          dout => dout,
          dout_v => dout_v,
          dout_r => dout_r
        );

   -- Clock process definitions
   clk_process :process
   begin
		clk <= '0';
		wait for clk_period/2;
		clk <= '1';
		wait for clk_period/2;
   end process;
 

   -- Stimulus process
   stim_proc: process
   begin		
      -- hold reset state for 100 ns.
      wait for 100 ns;	
		reset <= '1';
		dout_r <= '1';
		

      wait for clk_period*10;
		reset <= '0';
		wait for clk_period;
		din_v <= '1';
		din <= X"00000001";
		wait for clk_period;
		din <= X"00000003";
		wait for clk_period;
		din <= X"00000005";
		wait for clk_period;
		din <= X"00000007";
		wait for clk_period;
		din <= X"00000009";
		wait for clk_period;
		din <= X"00000000";
		din_v <= '0';

      wait;
   end process;

END;
