----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date:    18:59:57 08/23/2019 
-- Design Name: 
-- Module Name:    parpadeo1S - Behavioral 
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
entity parpadeo1S is
	Port ( 	
				clk : in std_logic;
				rst : in std_logic;
				led : out std_logic;
				p: out std_logic
			);
end parpadeo1S;


architecture Behavioral of parpadeo1S is
constant M: integer:=50000000; -- 50e6 -> prende y apaga por un segundo
constant N : integer := integer(ceil(log2(real (M))));
signal cuenta: unsigned (N-1 downto 0);
signal q: std_logic:='0';
begin
process(clk,rst)
begin
	if(rst = '0') then
		cuenta <= (others =>'0');
		q<='0';
		p<='1';
	elsif( rising_edge(clk)) then
		cuenta <= cuenta + 1;
		if (cuenta = to_unsigned(M-1,N)) then
			q<=not q;
			cuenta <= (others =>'0');
		end if;
		p<='0';
	end if;
end process;
led<=q;

end Behavioral;

