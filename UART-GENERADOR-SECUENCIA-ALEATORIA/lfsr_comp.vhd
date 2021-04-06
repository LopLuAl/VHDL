----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date:    10:59:35 09/12/2019 
-- Design Name: 
-- Module Name:    lfsr_comp - Behavioral 
-- Project Name: 
-- Target Devices: 
-- Tool versions: 
-- Description: 
--
-- Dependencies: 
--
-- Revision: 
-- Revision 0.01 - File Created
-- Additional Comments: 
--
----------------------------------------------------------------------------------
library IEEE;
use IEEE.STD_LOGIC_1164.ALL;


entity lfsr_comp is
Port ( 	clk : in std_logic;
				rst : in std_logic;
				ent : in std_logic;
				n : in std_logic;
				tap : in std_logic;
				sal : out std_logic;
				enable : in std_logic;
				q_default: in std_logic
	);
end lfsr_comp;

architecture Behavioral of lfsr_comp is
signal q: std_logic;
begin
process (clk, rst)
begin
	if (rising_edge (clk)) then
		if (rst = '0') then
			q<=q_default;
		elsif (enable = '1') then
			if(tap='1') then
				q <= n xor ent ;
			else
				q<=ent;
			end if;
		end if;
	end if;
end process;
sal<=q;
end Behavioral;

