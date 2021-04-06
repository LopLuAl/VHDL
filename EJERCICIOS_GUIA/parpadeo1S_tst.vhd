--------------------------------------------------------------------------------
-- Company: 
-- Engineer:
--
-- Create Date:   23:02:42 08/23/2019
-- Design Name:   
-- Module Name:   C:/Users/lucia/Documents/Digitales/Lucianlopez/Luciano_Lopez_EJ_GUIA/parpadeo1S_tst.vhd
-- Project Name:  Luciano_Lopez_EJ_GUIA
-- Target Device:  
-- Tool versions:  
-- Description:   
-- 
-- VHDL Test Bench Created by ISE for module: parpadeo1S
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
 
ENTITY parpadeo1S_tst IS
END parpadeo1S_tst;
 
ARCHITECTURE behavior OF parpadeo1S_tst IS 
 
    -- Component Declaration for the Unit Under Test (UUT)
 
    COMPONENT parpadeo1S
    PORT(
         clk : IN  std_logic;
         rst : IN  std_logic;
         led : OUT  std_logic
        );
    END COMPONENT;
    

   --Inputs
   signal clk : std_logic := '0';
   signal rst : std_logic := '0';

 	--Outputs
   signal led : std_logic;

   -- Clock period definitions
   constant clk_period : time := 10 ns;
 
BEGIN
 
	-- Instantiate the Unit Under Test (UUT)
   uut: parpadeo1S PORT MAP (
          clk => clk,
          rst => rst,
          led => led
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
		
		rst<='0';
		wait for 10 ns;
		rst<='1';
      -- insert stimulus here 

      wait;
   end process;

END;
