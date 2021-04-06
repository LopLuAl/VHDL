library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use ieee.numeric_std.all;

entity fsm_eco_v2 is
Port (
			clk 				:	in   std_logic;
			rst 				:	in   std_logic;
			en_data_read 	:	in   std_logic;
			dato_a_leer 	:	in   std_logic_vector(7 downto 0);
			dato_a_enviar 	:	out  std_logic_vector(7 downto 0);
			modif:out std_logic
			);
end fsm_eco_v2;

architecture Behavioral of fsm_eco_v2 is
-----------------------------------------------------------------------------------------
type state_T is (stA, stB, stC,stD,stE,stF);
signal state, next_state : state_T;
-----------------------------------------------------------------------------------------
signal dato,dato1: std_logic_vector(7 downto 0);--,dato_aux,dato_aux2
signal en_guardar,sel_dato_send : std_logic_vector(1 downto 0);
signal mandar: std_logic;
-----------------------------------------------------------------------------------------
constant CARACTER_INICIO_TRAMA: std_logic_vector(7 downto 0):="10101010";
-----------------------------------------------------------------------------------------
begin

estado: process (clk)
begin
	if (rising_edge(clk)) then
		if (rst = '0') then
			state <= stA;
		else
			state <= next_state;
		end if;
	end if;
end process;
-----------------------------------------------------------------------------------------
with mandar select
dato_a_enviar <=
						 dato_a_leer 		 when '1',
						(others=>'1')when others;	
-----------------------------------------------------------------------------------------
logicaDeSalida: process (state,clk)
begin
    case (state) is
        when stA =>
				mandar<='0';
				modif<='0';
        when stB =>
				mandar<='0';
				modif<='0';
        when stC =>
				mandar<='1';
				modif<='1';
        when others =>
				modif<='0';
				mandar<='0';
    end case;
end process;
logicaDeEstadoFuturo: process (state,dato_a_leer,en_data_read,dato)
begin
	next_state <= state;  -- Se queda en el estado actual por default --
	case (state) is
		when stA => -- ACA DEBERIA RECIBIR LA  "A" EN ASCII
			if en_data_read = '1' then
				if(dato_a_leer = CARACTER_INICIO_TRAMA) then
					next_state <= stB;				
				else
					next_state <= stA;
				end if;
			else	
				next_state <= stA;
			end if;
		when stB => -- ACA DEBERIA RECIBIR EL  DATO 
			if en_data_read = '1' then
				next_state <= stC;																																									
			else
				next_state <= stB;
			end if;
		when stC => --  Mando el dato al LFSR
			next_state <= stA;
		when others =>
			next_state <= stA;
	end case;
end process;
end Behavioral;



