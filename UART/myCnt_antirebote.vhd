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


entity myCnt_antirebote is
Generic (M : integer :=5209);
Port ( 	clk : in std_logic;
			rst : in std_logic;
			ena : in std_logic;
			salidaM_2 : out std_logic;
			salidaM : out std_logic
		);
end myCnt_antirebote;

architecture Behavioral of myCnt_antirebote is
constant N : integer := integer(ceil(log2(real (M))));
constant M_2 : unsigned (N-1 downto 0) := to_unsigned(M-1, N) / 2 ;

signal cuenta: unsigned (N-1 downto 0);
signal salida_1,salida_2 : STD_LOGIC;
begin
process(clk)
begin
    if (rising_edge(clk)) then
        if(rst = '1') then
            cuenta <= (others => '0');
				  salida_1<='0';
                salida_2<='0';
        else
            if(ena = '1') then
                cuenta<=cuenta+1;
            end if;
            if(cuenta = M_2 ) then
                salida_1<='0';
                salida_2<='1';
            elsif(cuenta = to_unsigned(M-1,N)) then
                salida_1<='1';
                salida_2<='0';
                cuenta <= (others => '0'); 
            else
                salida_1<='0';
                salida_2<='0';
            end if;
        end if;
    end if;
end process;
salidaM<=salida_1;
salidaM_2<=salida_2;

end Behavioral;

