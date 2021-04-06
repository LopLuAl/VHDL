--------------------------------------------------------------------------------
-- Company: 
-- Engineer:
--
-- Create Date:   17:45:29 08/10/2019
-- Design Name:   
-- Module Name:   C:/Users/lucia/Documents/Digitales/Lucianlopez/Luciano_Lopez_EJ_GUIA/paridadGen_tst.vhd
-- Project Name:  Luciano_Lopez_EJ_GUIA
-- Target Device:  
-- Tool versions:  
-- Description:   
-- 
-- VHDL Test Bench Created by ISE for module: paridadGen
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
 
ENTITY paridadGen_tst IS
END paridadGen_tst;
 
ARCHITECTURE behavior OF paridadGen_tst IS 
 
    -- Component Declaration for the Unit Under Test (UUT)
 
    COMPONENT paridadGen
    PORT(
         a : IN  std_logic_vector(2 downto 0);
         paridadSel : IN  std_logic;
         p : OUT  std_logic
        );
    END COMPONENT;
    

   --Inputs
   signal a : std_logic_vector(2 downto 0) := (others => '0');
   signal paridadSel : std_logic := '0';

 	--Outputs
   signal p : std_logic;
   -- No clocks detected in port list. Replace <clock> below with 
   -- appropriate port name 
 

BEGIN
 
	-- Instantiate the Unit Under Test (UUT)
   uut: paridadGen PORT MAP (
          a => a,
          paridadSel => paridadSel,
          p => p
        );

   -- Clock process definitions
   

   -- Stimulus process
   stim_proc: process
   begin		
      -- hold reset state for 100 ns.
      wait for 10 ns;	
		paridadSel<='1';
      a<="000";--0
		wait for 10 ns;
		a<="010";--1
		wait for 10 ns;
		a<="110";--0
		wait for 10 ns;
		a<="001";--1
		wait for 10 ns;
		a<="011";--0
		wait for 10 ns;
		a<="110";--0
      wait;
   end process;

END;
