----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date:    16:45:14 08/10/2019 
-- Design Name: 
-- Module Name:    paridadGen - Behavioral 
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
entity paridadGen is
generic(N : integer :=3);	
Port ( 				
			a : in std_logic_vector (N-1 downto 0);
			paridadSel : in std_logic;
			p : out std_logic
		);		
end paridadGen;

architecture Behavioral of paridadGen is
signal sig : std_logic_vector (N downto 0);
begin

sig(0)<='0';

e1: for i in a'range generate
	sig(i+1) <= sig(i) xor a(i);
end generate;

p<= not sig (N) when (paridadSel = '0') else sig(N);
	
end Behavioral;

