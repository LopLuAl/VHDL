--------------------------------------------------------------------------------
-- Company: 
-- Engineer:
--
-- Create Date:   19:20:23 10/04/2019
-- Design Name:   
-- Module Name:   C:/Users/lucia/Documents/Digitales/Lucianlopez/Luciano_Lopez_EJ_GUIA/my_Fifo_tst.vhd
-- Project Name:  Luciano_Lopez_EJ_GUIA
-- Target Device:  
-- Tool versions:  
-- Description:   
-- 
-- VHDL Test Bench Created by ISE for module: myFiFo
-- 
-- Dependencies:
-- 
-- Revision:
-- Revision 0.01 - File Created
-- Additional Comments:
--
-- Notes: 
-- This testbench has been automatically generated using types std_logic and
-- std_logic_vector for the ports of the unit under test.  Xilinx recommends
-- that these types always be used for the top-level I/O of a design in order
-- to guarantee that the testbench will bind correctly to the post-implementation 
-- simulation model.
--------------------------------------------------------------------------------
LIBRARY ieee;
USE ieee.std_logic_1164.ALL;
 
-- Uncomment the following library declaration if using
-- arithmetic functions with Signed or Unsigned values
--USE ieee.numeric_std.ALL;
 
ENTITY my_Fifo_tst IS
END my_Fifo_tst;
 
ARCHITECTURE behavior OF my_Fifo_tst IS 
 
    -- Component Declaration for the Unit Under Test (UUT)
 
    COMPONENT myFiFo
    PORT(
         clk : IN  std_logic;
         rst : IN  std_logic;
         din : IN  std_logic_vector(7 downto 0);
         wrEna : IN  std_logic_vector(0 downto 0);
         dout : OUT  std_logic_vector(7 downto 0);
         rdEna : IN  std_logic_vector(0 downto 0);
         full : OUT  std_logic;
         mid : OUT  std_logic;
				indice: OUT STD_LOGIC_VECTOR(9 DOWNTO 0);
         empty : OUT  std_logic
        );
    END COMPONENT;
    

   --Inputs
   signal clk : std_logic := '0';
   signal rst : std_logic := '0';
   signal din : std_logic_vector(7 downto 0) := (others => '0');
   signal wrEna : std_logic_vector(0 downto 0) := (others => '0');
   signal rdEna : std_logic_vector(0 downto 0) := (others => '0');

 	--Outputs
   signal dout : std_logic_vector(7 downto 0);
   signal full : std_logic;
   signal mid : std_logic;
   signal empty : std_logic;
	signal indice:  STD_LOGIC_VECTOR(9 DOWNTO 0);
   -- Clock period definitions
   constant clk_period : time := 10 ns;
 
BEGIN
 
	-- Instantiate the Unit Under Test (UUT)
   uut: myFiFo PORT MAP (
          clk => clk,
          rst => rst,
          din => din,
          wrEna => wrEna,
          dout => dout,
          rdEna => rdEna,
          full => full,
          mid => mid,
			 indice=>indice,
          empty => empty
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
      wait until CLK'event and CLK='1';
		rst<='0';
		wait until CLK'event and CLK='1';
		rst<='1';
		wait until CLK'event and CLK='1';
		
		
		
		
--		--Escribo
--		wrEna<="1";
--		rdEna<="0";
--		din<=(others=>'1');
--		wait for 50 ns;
--		--Leo
--		wrEna<="0";
--		rdEna<="1";
--		wait for 50 ns;
		
----		din<="00001111";
		rdEna<="0";
		wrEna<="1";
		wait until CLK'event and CLK='1';
		din<="00111101";
		wait until CLK'event and CLK='1';
		din<="00101101";
		wait until CLK'event and CLK='1';
		din<="01011101";
		wait until CLK'event and CLK='1';
		din<="10011101";
		wait until CLK'event and CLK='1';
		din<="01010101";
		wait until CLK'event and CLK='1';
		din<="10111101";
		wait until CLK'event and CLK='1';
		din<="00000000";
	
		wrEna<="0";
		wait until CLK'event and CLK='1';
--		din<=(others=>'Z');
		--leo de vuelta
		wait until CLK'event and CLK='1';
		wrEna<="0";
		rdEna<="1";
		
		--din<=(others=>'1');
		
		
		wait for 50 ns;
		wait for 50 ns;
		wait for 50 ns;
		
		-- finaliza la simulacion
		assert false
		report "end"
		severity failure;
   end process;

END;
