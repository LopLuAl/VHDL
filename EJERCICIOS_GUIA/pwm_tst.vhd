--------------------------------------------------------------------------------
-- Company: 
-- Engineer:
--
-- Create Date:   16:21:23 11/02/2019
-- Design Name:   
-- Module Name:   C:/Users/Luciano/Documents/GitHub/Lucianlopez/Luciano_Lopez_EJ_GUIA/pwm_tst.vhd
-- Project Name:  Luciano_Lopez_EJ_GUIA
-- Target Device:  
-- Tool versions:  
-- Description:   
-- 
-- VHDL Test Bench Created by ISE for module: pwm
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
 
ENTITY pwm_tst IS
END pwm_tst;
 
ARCHITECTURE behavior OF pwm_tst IS 
 
    -- Component Declaration for the Unit Under Test (UUT)
 
    COMPONENT pwm
    PORT(
         clk : IN  std_logic;
         rst : IN  std_logic;
         duty : IN  std_logic_vector(1 downto 0);
         frec : IN  std_logic_vector(1 downto 0);
         pol : IN  std_logic;
         load : IN  std_logic;
         salida : OUT  std_logic
        );
    END COMPONENT;
    

   --Inputs
   signal clk : std_logic := '0';
   signal rst : std_logic := '0';
   signal duty : std_logic_vector(1 downto 0) := (others => '0');
   signal frec : std_logic_vector(1 downto 0) := (others => '0');
   signal pol : std_logic := '0';
   signal load : std_logic := '0';

 	--Outputs
   signal salida : std_logic;

   -- Clock period definitions
   constant clk_period : time := 20 ns;
 
BEGIN
 
	-- Instantiate the Unit Under Test (UUT)
   uut: pwm PORT MAP (
          clk => clk,
          rst => rst,
          duty => duty,
          frec => frec,
          pol => pol,
          load => load,
          salida => salida
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
		wait for 60 ms;
      wait for clk_period*10;
		rst <= '0';
		wait for clk_period*10;
		
		rst<='1';
		wait for 70 ms;
		pol<='0';
		load<='1';
		frec<="10";
		duty<="00";
		load<='0';
		wait for 60 ms;
		load<='1';
		duty<="00";
		rst<='1';
		wait for clk_period;
      load<='0';
		-- insert stimulus here 

      wait;
   end process;

END;
