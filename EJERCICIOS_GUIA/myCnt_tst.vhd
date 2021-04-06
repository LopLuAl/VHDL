--------------------------------------------------------------------------------
-- Company: 
-- Engineer:
--
-- Create Date:   11:06:30 08/22/2019
-- Design Name:   
-- Module Name:   C:/Users/Luciano/Documents/Digitales/Luciano_Lopez_EJ_GUIA/myCnt_tst.vhd
-- Project Name:  Luciano_Lopez_EJ_GUIA
-- Target Device:  
-- Tool versions:  
-- Description:   
-- 
-- VHDL Test Bench Created by ISE for module: myCnt
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
 
ENTITY myCnt_tst IS
END myCnt_tst;
 
ARCHITECTURE behavior OF myCnt_tst IS 
 
    -- Component Declaration for the Unit Under Test (UUT)
 
    COMPONENT myCnt
    PORT(
         clk : IN  std_logic;
         rst : IN  std_logic;
         ena : IN  std_logic;
         salidaM_2 : OUT  std_logic;
         salidaM : OUT  std_logic
        );
    END COMPONENT;
    

   --Inputs
   signal clk : std_logic := '0';
   signal rst : std_logic := '0';
   signal ena : std_logic := '0';

 	--Outputs
   signal salidaM_2 : std_logic;
   signal salidaM : std_logic;

   -- Clock period definitions
   constant clk_period : time := 10 ns;
 
BEGIN
 
	-- Instantiate the Unit Under Test (UUT)
   uut: myCnt PORT MAP (
          clk => clk,
          rst => rst,
          ena => ena,
          salidaM_2 => salidaM_2,
          salidaM => salidaM
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
		rst<='1';
		ena<='0';
      wait until CLK'event and CLK='1';
      rst <= '0';
		ena <= '1';

      wait;
   end process;

END;
