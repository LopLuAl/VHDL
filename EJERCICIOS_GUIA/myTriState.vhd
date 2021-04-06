----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date:    09:50:35 06/27/2019 
-- Design Name: 
-- Module Name:    my_buffer_tri - Behavioral 
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

entity my_buffer_tri is
Port(
		Entrada :in std_logic;
		Control :in std_logic;
		Salida  :out std_logic);
end my_buffer_tri;

architecture Behavioral of my_buffer_tri is

begin
with Control select
	Salida <= Entrada when '1',
					'0' when '0',
					'Z' when others;

end Behavioral;

