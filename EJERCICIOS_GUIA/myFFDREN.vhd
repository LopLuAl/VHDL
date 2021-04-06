----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date:    00:43:11 08/15/2019 
-- Design Name: 
-- Module Name:    myFFDREN - Behavioral 
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
--subir archivos con el git ignore

--sumador teoria libro


--error:   ERROR:Cpld:1244 - Unexpected Exceptions

entity myFFDREN is
Generic (N: integer := 4);
	Port ( clk : in std_logic;
			 rst : in std_logic;
			 ena : in std_logic;
			   d : in std_logic_vector (N-1 downto 0);
				q : out std_logic_vector (N-1 downto 0)
			);
end myFFDREN;

architecture Behavioral of myFFDREN is
signal q_aux: std_logic_vector(N-1 downto 0);
begin
process(clk,rst)
begin
	if(rst = '1') then
		q<=(others =>'0');
	elsif (rising_edge(clk)) then
		if (ena = '1') then
				q_aux<=d;
				q<=q_aux;
		else
				q<=q_aux;
		end if;
	end if;
end process;
end Behavioral;

