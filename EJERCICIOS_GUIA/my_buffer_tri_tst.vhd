--------------------------------------------------------------------------------
-- Company: 
-- Engineer:
--
-- Create Date:   10:07:54 06/27/2019
-- Design Name:   
-- Module Name:   C:/Users/Luciano/Documents/TD_I/myAnd4/my_buffer_tri_tst.vhd
-- Project Name:  myAnd4
-- Target Device:  
-- Tool versions:  
-- Description:   
-- 
-- VHDL Test Bench Created by ISE for module: my_buffer_tri
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
 
ENTITY my_buffer_tri_tst IS
END my_buffer_tri_tst;
 
ARCHITECTURE behavior OF my_buffer_tri_tst IS 
 
    -- Component Declaration for the Unit Under Test (UUT)
 
    COMPONENT my_buffer_tri
    PORT(
         Entrada : IN  std_logic;
         Control : IN  std_logic;
         Salida : OUT  std_logic
        );
    END COMPONENT;
    

   --Inputs
   signal Entrada : std_logic := '0';
   signal Control : std_logic := '0';

 	--Outputs
   signal Salida : std_logic;
   -- No clocks detected in port list. Replace <clock> below with 
   -- appropriate port name 
 
  
BEGIN
 
	-- Instantiate the Unit Under Test (UUT)
   uut: my_buffer_tri PORT MAP (
          Entrada => Entrada,
          Control => Control,
          Salida => Salida
        );

   -- Stimulus process
   stim_proc: process
   begin		
		Control <= '0';
		wait for 10 ns;
		Entrada <= '0';
		wait for 10 ns;
		Entrada <= '1';
		wait for 10 ns;
		Control <= '1';
		wait for 10 ns;
		Entrada <= '0';
		wait for 10 ns;
		Entrada <= '1';
		wait for 10 ns;
		
      wait;
   end process;

END;
