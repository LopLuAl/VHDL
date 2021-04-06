----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date:    15:49:56 08/22/2019 
-- Design Name: 
-- Module Name:    myEdgeCnt - Behavioral 
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
use ieee.numeric_std.all;

entity myEdgeCnt is
Generic (N: integer := 4);
Port ( 	clk : in std_logic;
			rst : in std_logic;
			  d : in std_logic;
			  q : out std_logic_vector (N-1 downto 0)
	  );
end myEdgeCnt;

architecture Behavioral of myEdgeCnt is
signal aux: std_logic;
signal cuenta: unsigned (N-1 downto 0);
begin
process(clk,rst)
begin
	if (rst = '1') then
		aux <=  '0';
		cuenta <= (others => '0');
	elsif(rising_edge(clk)) then
		aux<=d;
		if(((not aux) and d)='1') then
			cuenta<=cuenta+1;
			q<=std_logic_vector(cuenta);
		end if;
	end if;
end process;
end Behavioral;