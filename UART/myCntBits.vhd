----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date:    10:18:07 08/22/2019 
-- Design Name: 
-- Module Name:    myCnt - Behavioral 
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


entity myCntBits is
Generic (M : integer := 10*9);
Port ( 	clk : in std_logic;
			rst : in std_logic;
			ena : in std_logic;
			salidaM_2 : out std_logic;
			salidaM : out std_logic
		);
end myCntBits;

architecture Behavioral of myCntBits is
constant N : integer := integer(ceil(log2(real (M))));
constant M_2 : unsigned (N-1 downto 0) := to_unsigned(M-1, N) / 2 ;

signal cuenta: unsigned (N-1 downto 0);
signal ok, ok_2: std_logic;
begin
process(clk)
begin
    if (rising_edge(clk)) then
        if(rst = '1') then
            cuenta <= (others => '0');
				 ok_2	<='0';
				 ok	<='0';
        else
            if(ena = '1') then
               
            
					if(cuenta = M_2 ) then
						 ok_2<='1';
						 ok<='0';
					elsif(cuenta = to_unsigned(M-1,N)) then
						 ok_2<='0';
						 ok<='1';
						 cuenta <= (others => '0'); 
					else
						 ok<='0';
						 ok_2<='0';
					end if;
					 cuenta<=cuenta+1;
				end if;
        end if;
    end if;
end process;
salidaM<= ok;
salidaM_2<= ok_2;

end Behavioral;

