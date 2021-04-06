--------------------------------------------------------------------------------
-- Company: 
-- Engineer:
--
-- Create Date:   19:41:45 08/10/2019
-- Design Name:   
-- Module Name:   C:/Users/lucia/Documents/Digitales/Lucianlopez/Luciano_Lopez_EJ_GUIA/myDivMag8_tst.vhd
-- Project Name:  Luciano_Lopez_EJ_GUIA
-- Target Device:  
-- Tool versions:  
-- Description:   
-- 
-- VHDL Test Bench Created by ISE for module: myDivMag8
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
 
ENTITY myDivMag8_tst IS
END myDivMag8_tst;
 
ARCHITECTURE behavior OF myDivMag8_tst IS 
 
    -- Component Declaration for the Unit Under Test (UUT)
 
    COMPONENT myDivMag8
    PORT(
         entrada : IN  std_logic_vector(7 downto 0);
         div : IN  std_logic_vector(1 downto 0);
         salida : OUT  std_logic_vector(7 downto 0)
        );
    END COMPONENT;
    

   --Inputs
   signal entrada : std_logic_vector(7 downto 0) := (others => '0');
   signal div : std_logic_vector(1 downto 0) := (others => '0');

 	--Outputs
   signal salida : std_logic_vector(7 downto 0);
   -- No clocks detected in port list. Replace <clock> below with 
   -- appropriate port name 
BEGIN
 
	-- Instantiate the Unit Under Test (UUT)
   uut: myDivMag8 PORT MAP (
          entrada => entrada,
          div => div,
          salida => salida
        );



   -- Stimulus process
   stim_proc: process
   begin		
	div<="00";
	entrada <= "11111111";
	wait for 100 ns;
	div<="01";
	entrada <= "11111111";
	wait for 100 ns;
	div<="10";
	entrada <= "00001000";
	wait for 100 ns;
	div<="00";
	entrada <= "00001000";
	wait for 100 ns;
	div<="11";
	entrada <= "00001000";
	wait for 100 ns;
	div<="00";
	entrada <= "00001000";
	
      wait;
   end process;

END;
