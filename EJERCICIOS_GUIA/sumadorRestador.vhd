----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date:    18:04:57 08/12/2019 
-- Design Name: 
-- Module Name:    sumadorRestador - Behavioral 
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
use IEEE.NUMERIC_STD.ALL;

-- Uncomment the following library declaration if using
-- arithmetic functions with Signed or Unsigned values
--use IEEE.NUMERIC_STD.ALL;

-- Uncomment the following library declaration if instantiating
-- any Xilinx primitives in this code.
--library UNISIM;
--use UNISIM.VComponents.all;

entity sumadorRestador is
Generic (N: integer := 4);
Port(	
		   a : in std_logic_vector (N-1 downto 0);
			b : in std_logic_vector (N-1 downto 0);
		 s_r : in std_logic;
		  ov : out std_logic;
  resultado: out std_logic_vector (N-1 downto 0));
end sumadorRestador;

architecture Behavioral of sumadorRestador is
signal suma: std_logic_vector(N-1 downto 0);
begin
--s_r = '1' RESTA
--s_r = '0' SUMA 
--ov<='1';
suma      <= std_logic_vector(signed(a)+signed(b))     when (s_r='1') else
				 std_logic_vector(signed(a)+signed(b))     when (s_r='0') else
				 (others=>'Z');
ov <= (suma(N-1) and a(N-1) and b(N-1)) or((NOT suma(N-1))and(a(N-1))and(NOT b(N-1)));

resultado<=suma;			 

end Behavioral;

