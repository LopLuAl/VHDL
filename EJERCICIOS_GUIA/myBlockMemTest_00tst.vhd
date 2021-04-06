--------------------------------------------------------------------------------
-- Company: 
-- Engineer:
--
-- Create Date:   16:31:40 10/03/2019
-- Design Name:   
-- Module Name:   C:/Users/lucia/Documents/Digitales/Lucianlopez/Luciano_Lopez_EJ_GUIA/myBlockMemTest_00tst.vhd
-- Project Name:  Luciano_Lopez_EJ_GUIA
-- Target Device:  
-- Tool versions:  
-- Description:   
-- 
-- VHDL Test Bench Created by ISE for module: myBlockMemTest_00
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
 
ENTITY myBlockMemTest_00tst IS
END myBlockMemTest_00tst;
 
ARCHITECTURE behavior OF myBlockMemTest_00tst IS 
 
    -- Component Declaration for the Unit Under Test (UUT)
 
    COMPONENT myBlockMemTest_00
    PORT(
         clk : IN  std_logic;
         wea : IN  std_logic_vector(0 downto 0);
         addra : IN  std_logic_vector(9 downto 0);
         dina : IN  std_logic_vector(15 downto 0);
         douta : OUT  std_logic_vector(15 downto 0);
         web : IN  std_logic_vector(0 downto 0);
         addrb : IN  std_logic_vector(9 downto 0);
         dinb : IN  std_logic_vector(15 downto 0);
         doutb : OUT  std_logic_vector(15 downto 0)
        );
    END COMPONENT;
    

   --Inputs
   signal clk : std_logic := '0';
   signal wea : std_logic_vector(0 downto 0) := (others => '0');
   signal addra : std_logic_vector(9 downto 0) := (others => '0');
   signal dina : std_logic_vector(15 downto 0) := (others => '0');
   signal web : std_logic_vector(0 downto 0) := (others => '0');
   signal addrb : std_logic_vector(9 downto 0) := (others => '0');
   signal dinb : std_logic_vector(15 downto 0) := (others => '0');

 	--Outputs
   signal douta : std_logic_vector(15 downto 0);
   signal doutb : std_logic_vector(15 downto 0);

   -- Clock period definitions
   constant clk_period : time := 10 ns;
 
BEGIN
 
	-- Instantiate the Unit Under Test (UUT)
   uut: myBlockMemTest_00 PORT MAP (
          clk => clk,
          wea => wea,
          addra => addra,
          dina => dina,
          douta => douta,
          web => web,
          addrb => addrb,
          dinb => dinb,
          doutb => doutb
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
		wea<="1";
		addra<="0000000000";
		dina <="1111111111111111";
		wait for 10 ns;
		wea<="0";
		addra<="0000000000";
		dina <="1111111111111110";
	
		wait for 50 ns;
		web<="0";
		addrb<="0000000000";
		wait for 50 ns;
		web<="1";
		wait for 50 ns;
		addrb<="0000000001";
		wait for 50 ns;
		web<="0";
		wait for 50 ns;
--		addra<="0000000011";
      wait for clk_period*10;

      -- insert stimulus here 

      wait;
   end process;

END;
