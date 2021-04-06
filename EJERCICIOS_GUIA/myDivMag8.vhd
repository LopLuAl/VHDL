--------------------------------------------------------------------------------------------------------
--Implemente un circuito que permite dividir una magnitud de 8 bits por 1, 2, 4, 8 según se seleccione.
--------------------------------------------------------------------------------------------------------

library IEEE;
use IEEE.STD_LOGIC_1164.ALL;


entity myDivMag8 is
	Port ( entrada : in  std_logic_vector (7 downto 0);
				  div : in  std_logic_vector (1 downto 0);
			  salida : out std_logic_vector (7 downto 0));
end myDivMag8;

architecture Behavioral of myDivMag8 is
signal sig_div_1,sig_div_2,sig_div_4,sig_div_8: std_logic_vector(7 downto 0);
begin


	sig_div_2(0)<=entrada(1);
	sig_div_2(1)<=entrada(2);
	sig_div_2(2)<=entrada(3);
	sig_div_2(3)<=entrada(4);
	sig_div_2(4)<=entrada(5);
	sig_div_2(5)<=entrada(6);
	sig_div_2(6)<=entrada(7);
	sig_div_2(7)<='0';
	
	sig_div_4(0)<=entrada(2);
	sig_div_4(1)<=entrada(3);
	sig_div_4(2)<=entrada(4);
	sig_div_4(3)<=entrada(5);
	sig_div_4(4)<=entrada(6);
	sig_div_4(5)<=entrada(7);
	sig_div_4(6)<='0';
	sig_div_4(7)<='0';
	
	sig_div_8(0)<=entrada(3);
	sig_div_8(1)<=entrada(4);
	sig_div_8(2)<=entrada(5);
	sig_div_8(3)<=entrada(6);
	sig_div_8(4)<=entrada(7);
	sig_div_8(5)<='0';
	sig_div_8(6)<='0';
	sig_div_8(7)<='0';
	


	with div select
	salida <= entrada    when "00",
				 sig_div_2	when "01",
				 sig_div_4	when "10",
				 sig_div_8  when "11",
		 (others => 'Z')  when others;		
		 
end Behavioral;


