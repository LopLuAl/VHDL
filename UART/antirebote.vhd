----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date:    20:29:53 08/24/2019 
-- Design Name: 
-- Module Name:    antirebote - Behavioral 
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
use ieee.std_logic_misc.all;

entity antirebote is
	Generic (N: integer := 4;
				C: integer := 4);
	Port ( 	      clk : in std_logic;
					   rst : in std_logic;
					  btnIn: in std_logic_vector (N - 1 downto 0);
					 btnOut: out std_logic_vector (N - 1 downto 0);
--					btnCode: out std_logic_vector (C - 1 downto 0);
				  btnValid: out std_logic
		  );
end antirebote;

architecture Behavioral of antirebote is
-----------------------------------------------------------
-----------------------------------------------------------

COMPONENT antirebote_1P
	PORT(
		clk : IN std_logic;
		rst : IN std_logic;
		btnIn : IN std_logic;          
		btnOut : OUT std_logic;
--		btnCode : OUT std_logic;
		btnValid : OUT std_logic
		);
	END COMPONENT;
	


signal btnCode_aux	:  std_logic_vector	(C-1 downto 0);
signal btnValid_aux	:  std_logic_vector	(N-1 downto 0);
signal btnIn_neg		:  std_logic_vector	(N-1 downto 0);

signal btnCode_a		:  std_logic_vector	(C-1 downto 0);
signal btnValid_a		:  std_logic;

-- btnIn_neg<=( btnIn);
--btnIn_neg<= not btnIn_neg;
begin
-----------------------------------------------------------
-----------------------------------------------------------
instFor: for i in btnIn'range generate
	inst: antirebote_1P Port map (clk 		=> clk,
											rst 		=>  rst, 
											btnIn 	=>	 btnIn(i),
											btnOut	=>	btnOut(i),
--											btnCode	=>	btnCode_aux(i),
											btnValid	=>	btnValid_aux(i)
											);
end generate;
-----------------------------------------------------------
-----------------------------------------------------------
--btn_valid: 
--for i in btnValid_aux'range generate
--	with btnValid_aux(i) select
--		btnValid_a <= (btnValid_aux(i)) when '1',
--						'Z' when '0',
--						'Z' when others;
--end generate btn_valid;
btnValid <=or_reduce(btnValid_aux);
--
--btn_Code:

--for i in btnCode_aux'range generate
--	with btnCode_aux(i) select
--		btnCode_a<= ((std_logic_vector(to_unsigned(i, C-1)&'1'))) when '1',
--						(others=>'Z')  when '0',
--						(others=>'Z')  when others;
--end generate btn_Code;

--with btnvalid_a select
--	btnCode	<= btnCode_a 		when '1',
--					(others=>'0')  when others;
					
--with btnvalid_a select
--	btnvalid	<= '1' 		when '1',
--					'0'	   when others;
end Behavioral;



































--btnCode 	<= btnCode_aux2;

--		Btn_valid: for i in 0 to N-2 loop
--			btnValid_aux_for <= btnValid_aux_for or (btnValid_aux(i) xor btnValid_aux(i+1));
--		end loop Btn_valid;
--		btnValid <= btnValid_aux_for;
--		if(btnValid_aux_for = '1') then
--			l: for k in btnCode_aux'range loop
--				if(btnCode_aux(k) = '1') then
--					cuenta <= to_unsigned(k,N);
--				end if;
--			end loop l;
--			btnCode 	<= std_logic_vector(cuenta) & '1';
--		else
--			btnCode   <= (others => '0');
--			btnValid  <= '0';
--		end if;




















