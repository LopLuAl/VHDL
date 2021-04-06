----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date:    17:11:01 11/16/2019 
-- Design Name: 
-- Module Name:    fsm_send - Behavioral 
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

entity fsm_eco is
Port (
			clk 				:	in   std_logic;
			rst 				:	in   std_logic;
			busy_sig 		:	in   std_logic;
			en_data_read 	:	in   std_logic;
			dato_a_leer 	:	in   std_logic_vector(7 downto 0);
			dato_a_enviar 	:	out  std_logic_vector(7 downto 0);
			en_data_send 	:	out  std_logic
			
			);
end fsm_eco;

architecture Behavioral of fsm_eco is
-----------------------------------------------------------------------------------------
type state_T is (stA, stB, stC,stD,stE,stF);
signal state, next_state : state_T;
-----------------------------------------------------------------------------------------
signal dato_1,dato_2: std_logic_vector(7 downto 0);
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
logicaDeSalida: process (state)
begin
    case (state) is
        when stA =>
				en_data_send<='0';
				dato_a_enviar<=(others=>'0');
        when stB =>
				en_data_send<='0';
				dato_a_enviar<=(others=>'0');
        when stC =>
				en_data_send<='0';
				dato_a_enviar<=(others=>'0');
        when stD =>
				en_data_send<='1';
				dato_a_enviar<=dato_1;
		  when stE =>
				en_data_send<='0';
				dato_a_enviar<=(others=>'0');
		  when stF =>
				en_data_send<='1';
				dato_a_enviar<=dato_2;
        when others =>
				en_data_send<='0';
				dato_a_enviar<=(others=>'0');
    end case;
end process;
logicaDeEstadoFuturo: process (state,busy_sig,dato_a_leer,en_data_read)
begin

	next_state <= state;  -- Se queda en el estado actual por default --

	case (state) is
		when stA => -- ACA DEBERIA RECIBIR LA  "A" EN ASCII
			if en_data_read = '1' then
				if(dato_a_leer = "01000001") then
					dato_1<=dato_a_leer;
					next_state <= stB;				
				else
					next_state <= stA;
				end if;
			else
				next_state <= stA;
			end if;
		when stB => -- ACA DEBERIA RECIBIR EL  DATO DEL LED
			if en_data_read = '1' then
				dato_2<=dato_a_leer;
				next_state <= stC;																																									
			else
				dato_2<=(others=>'0');
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

