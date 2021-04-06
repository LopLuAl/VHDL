----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date:    09:43:58 06/27/2019 
-- Design Name: 
-- Module Name:    myMux4 - Behavioral 
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

entity myMux4 is
Port(
		a : in std_logic_vector (3 downto 0);
		c : in std_logic_vector (1 downto 0);
		s : out std_logic);
end myMux4;

architecture Behavioral of myMux4 is

begin
	with c select
		s <= 	a(0) when "00",
				a(1) when "01",
				a(2) when "10",
				a(3) when "11",
			   '0' when others;
end Behavioral;

