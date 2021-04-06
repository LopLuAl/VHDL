----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date:    10:15:02 06/27/2019 
-- Design Name: 
-- Module Name:    myDeco7Seg - Behavioral 
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

-- Uncomment the following library declaration if using
-- arithmetic functions with Signed or Unsigned values
--use IEEE.NUMERIC_STD.ALL;

-- Uncomment the following library declaration if instantiating
-- any Xilinx primitives in this code.
--library UNISIM;
--use UNISIM.VComponents.all;

entity myDeco7Seg is
Port (
		Entrada :in  std_logic_vector (3 downto 0);
		a,b,c,d,e,f,g :out std_logic);
end myDeco7Seg;

architecture Behavioral of myDeco7Seg is
signal s: std_logic_vector (6 downto 0);
begin
	with Entrada select
		s <= 	"1111110" when "0000",
				"0110000" when "0001",
				"1101101" when "0010",
				"0111001" when "0011",
				"1110011" when "0100",
				"1011011" when "0101",
				"1011111" when "0110",
				"1110000" when "0111",
				"1111111" when "1000",
				"1110011" when "1001",
				"0000000" when "1010",
				"0000000" when "1011",
				"0000000" when "1100",
				"0000000" when "1101",
				"0000000" when "1110",
				"0000000" when "1111",
				(others => 'Z') when others;
				--"ZZZZZZZ"
		a<=s(0);
		b<=s(1);
		c<=s(2);
		d<=s(3);
		e<=s(4);
		f<=s(5);
		g<=s(6);	
end Behavioral;

