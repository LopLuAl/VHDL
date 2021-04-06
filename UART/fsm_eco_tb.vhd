--------------------------------------------------------------------------------
-- Company: 
-- Engineer:
--
-- Create Date:   17:55:41 11/16/2019
-- Design Name:   
-- Module Name:   C:/Users/Luciano/Documents/GitHub/Lucianlopez/UART/fsm_eco_tb.vhd
-- Project Name:  UART
-- Target Device:  
-- Tool versions:  
-- Description:   
-- 
-- VHDL Test Bench Created by ISE for module: fsm_eco
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
 
ENTITY fsm_eco_tb IS
END fsm_eco_tb;
 
ARCHITECTURE behavior OF fsm_eco_tb IS 
 
    -- Component Declaration for the Unit Under Test (UUT)
 
    COMPONENT fsm_eco
    PORT(
         clk : IN  std_logic;
         rst : IN  std_logic;
         busy_sig : IN  std_logic;
         en_data_read : IN  std_logic;
         dato_a_leer : IN  std_logic_vector(7 downto 0);
         dato_a_enviar : OUT  std_logic_vector(7 downto 0);
         en_data_send : OUT  std_logic
        );
    END COMPONENT;
    

   --Inputs
   signal clk : std_logic := '0';
   signal rst : std_logic := '0';
   signal busy_sig : std_logic := '0';
   signal en_data_read : std_logic := '0';
   signal dato_a_leer : std_logic_vector(7 downto 0) := (others => '0');

 	--Outputs
   signal dato_a_enviar : std_logic_vector(7 downto 0);
   signal en_data_send : std_logic;

   -- Clock period definitions
   constant clk_period : time := 10 ns;
 
BEGIN
 
	-- Instantiate the Unit Under Test (UUT)
   uut: fsm_eco PORT MAP (
          clk => clk,
          rst => rst,
          busy_sig => busy_sig,
          en_data_read => en_data_read,
          dato_a_leer => dato_a_leer,
          dato_a_enviar => dato_a_enviar,
          en_data_send => en_data_send
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

      wait for clk_period*10;

      -- insert stimulus here 
		rst <= '0';
		en_data_read<='0';
		wait for clk_period*1;
		rst <= '1';
		busy_sig <= '1';
		wait for clk_period*1;
		en_data_read<='1';
		dato_a_leer <= "01000001";
		wait for clk_period*1;
		en_data_read<='1';
		en_data_read<='1';
		dato_a_leer <= "01000001";
		wait for clk_period*1;
		en_data_read<='1';
		busy_sig <= '1';
		wait for clk_period*1;
		en_data_read<='1';
		busy_sig <= '0';
		wait for clk_period*1;
		wait for clk_period*1;
		en_data_read<='0';
		busy_sig <= '1';
		wait for clk_period*1;
		en_data_read<='0';
		busy_sig <= '0';
		wait for clk_period*10;
		assert false
		report "end"
		severity failure;
   
   end process;

END;
