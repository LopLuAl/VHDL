----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date:    02:08:37 08/24/2019 
-- Design Name: 
-- Module Name:    parpadeo1S_8Bits - Behavioral 
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
use ieee.math_real.all;
use ieee.numeric_std.all;

entity parpadeo1S_8Bits is
	Generic (L: integer := 4);
	Port ( 	clk : in std_logic;
				rst : in std_logic;
				led : out std_logic_vector (L - 1 downto 0)
			);
end parpadeo1S_8Bits;

architecture Behavioral of parpadeo1S_8Bits is

constant M: integer:=50000000; -- 50e6 -> prende y apaga por un segundo
constant N : integer := integer(ceil(log2(real (M))));
constant J : integer := integer(ceil(log2(real (L))));
signal cuenta_2: unsigned(J-1 downto 0):=(others=>'0');
signal cuenta: unsigned (N-1 downto 0);


begin

process(clk,rst)
begin
	if(rst = '0') then
		cuenta  	<= 	(others=>'0');
		cuenta_2 <= 	(others=>'0');
	elsif( rising_edge(clk)) then
		cuenta <= cuenta + 1;
		if (cuenta = to_unsigned(M-1,N)) then
			cuenta <= 	(others=>'0');
			led 	 <= 	(others=>'0');
			cuenta_2 <= cuenta_2 + 1;
			led(to_integer(cuenta_2))<='1';
			if(cuenta_2 = to_unsigned(L-1,J))then
				cuenta_2<=(others=>'0');	
			end if;
		end if;
	end if;
end process;
end Behavioral;

