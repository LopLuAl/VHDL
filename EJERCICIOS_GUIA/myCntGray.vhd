----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date:    02:50:50 09/11/2019 
-- Design Name: 
-- Module Name:    myCntGray - Behavioral 
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


entity myCntGray is
	Generic (N : integer := 4);
	Port (	clk : in std_logic;
				rst : in std_logic;
				ena : in std_logic;
			salida : out std_logic_vector (N -1 downto 0)
			);
end myCntGray;


architecture Behavioral of myCntGray is
COMPONENT binarioGray
	Generic (N: integer);
	PORT(
		binario : IN std_logic_vector(N-1  downto 0);          
		gray : OUT std_logic_vector(N-1 downto 0)
		);
END COMPONENT;
signal cnt: unsigned (N-1 downto 0);

begin
Inst_binarioGray: binarioGray GENERIC MAP(N=>N)
PORT MAP(
			binario => std_logic_vector(cnt) ,
				gray => salida
			);
process(clk,rst)
begin
	if(rst='0') then
		cnt 	 <=(others=>'0');
	elsif(rising_edge(clk)) then
		if(ena ='1') then
			cnt<=cnt+1;
		end if;
	end if;
end process;

end Behavioral;

