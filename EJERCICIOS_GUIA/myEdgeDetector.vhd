----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date:    01:21:55 08/15/2019 
-- Design Name: 
-- Module Name:    myEdgeDetector - Behavioral 
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

entity myEdgeDetector is
Port ( 		  clk : in  std_logic;
				  rst : in  std_logic;
					 d : in  std_logic;
	 	 ascendente : out std_logic;
		descendente : out std_logic);
end myEdgeDetector;

architecture Behavioral of myEdgeDetector is
	signal q,q2 : std_logic;
begin
process(clk,rst)
----------------------------------------------------------------------------
---                                                                      ---
---OJO: EN LA SIMULACION, RESETEO CON 1 Y EN MI KIT RESETEO CON 0 ! BITCH---
---                                                                      ---
----------------------------------------------------------------------------
begin
	if (rst = '0') then
		q <=  '0';
		q2 <=  '0';
	elsif(rising_edge(clk)) then
		q<=d;
		q2<=q;
	end if;

end process;

	descendente <= '1' when (q='0' and q2 = '1') else
					  '0';
	ascendente <= '1' when (q='1' and q2 = '0') else
					  '0';
end Behavioral;

