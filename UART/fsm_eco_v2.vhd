library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use ieee.numeric_std.all;

entity fsm_eco_v2 is
Port (
			clk 				:	in   std_logic;
			rst 				:	in   std_logic;
			busy_sig 		:	in   std_logic;
			en_data_read 	:	in   std_logic;
			dato_a_leer 	:	in   std_logic_vector(7 downto 0);
			dato_a_enviar 	:	out  std_logic_vector(7 downto 0);
			en_data_send 	:	out  std_logic;
			modif 			:	out  std_logic
			
			);
end fsm_eco_v2;

architecture Behavioral of fsm_eco_v2 is
-----------------------------------------------------------------------------------------
type state_T is (stA, stB, stC,stD,stE,stF);
signal state, next_state : state_T;
-----------------------------------------------------------------------------------------
signal dato,dato1: std_logic_vector(7 downto 0);--,dato_aux,dato_aux2
signal en_guardar,sel_dato_send : std_logic_vector(1 downto 0);
-----------------------------------------------------------------------------------------
constant CARACTER_INICIO_TRAMA: std_logic_vector(7 downto 0):="01000001";
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
--with en_guardar select
--dato <= 	dato_a_leer when "00",
--			dato when others;
--with en_guardar select
--dato1 <= dato_a_leer when "01",
--			(others=>'0') when others;
-----------------------------------------------------------------------------------------
process(clk)
begin

if rising_edge(clk) then
	if en_guardar = "00" then 
		dato<= dato_a_leer;
	elsif en_guardar = "01" then 
		dato1<= dato_a_leer;
	end if;
end if;
end process;	

with sel_dato_send select
dato_a_enviar <=
						 dato 		 when "00",
						 dato1		 when "01",
						(others=>'0')when others;					
-----------------------------------------------------------------------------------------
logicaDeSalida: process (state,clk)
begin
    case (state) is
        when stA =>
				en_data_send<='0';
				en_guardar<="00";
				sel_dato_send<="11";
				modif<='0';
--				dato_a_enviar<=(others=>'0');
        when stB =>
				en_data_send<='0';
				en_guardar<="01";
				sel_dato_send<="11";
				modif<='0';
--				dato_a_enviar<=(others=>'0');
        when stC =>
				en_data_send<='0';
				en_guardar<="11";
				sel_dato_send<="11";
				modif<='0';
--				dato_a_enviar<=(others=>'0');
        when stD =>
				en_data_send<='1';
				en_guardar<="11";
				sel_dato_send<="00";
				modif<='0';
--				dato_a_enviar<=CARACTER_INICIO_TRAMA;
		  when stE =>
				en_data_send<='0';
				en_guardar<="11";
				sel_dato_send<="11";
				modif<='0';
--				dato_a_enviar<=(others=>'0');
		  when stF =>
				en_data_send<='1';
				en_guardar<="11";
				sel_dato_send<="01";
--				dato_a_enviar<=dato;
				modif<='1';
				
        when others =>
				en_data_send<='0';
				en_guardar<="11";
				sel_dato_send<="11";
				modif<='0';
--				dato_a_enviar<=(others=>'0');
    end case;
end process;
logicaDeEstadoFuturo: process (state,busy_sig,dato_a_leer,en_data_read,dato)
begin

	next_state <= state;  -- Se queda en el estado actual por default --
--	dato<=dato_a_leer;
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
		when stB => -- ACA DEBERIA RECIBIR EL  DATO DEL LED
			if en_data_read = '1' then
				next_state <= stC;																																									
			else
				next_state <= stB;
			end if;
		when stC => --  Estado espero que la uart se libere para mandar el primer dato	
			if busy_sig = '1' then
				next_state <= stC;
			else
				next_state <= stD;
			end if;
		when stD =>-- UART liberada para mandar el primer dato
			next_state <= stE;
		when stE =>--  Estado espero que la uart se libere para mandar el segundo dato 
			if busy_sig = '1' then
				next_state <= stE;
			else
				next_state <= stF;
			end if;
		when stF =>--  UART liberada para mandar el segundo dato 
			next_state <= stA;
		when others =>
			next_state <= stA;
	end case;
end process;
end Behavioral;



