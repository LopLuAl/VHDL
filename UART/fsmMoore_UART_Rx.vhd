library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use ieee.numeric_std.all;
entity fsmMoore_UART_Rx is
	 Generic (CANT_BITS : integer := 10);
    Port ( clk : in  STD_LOGIC;
           rst : in  STD_LOGIC;
           rx_maq : in  STD_LOGIC;
           busy : out  STD_LOGIC);
end fsmMoore_UART_Rx;

architecture Behavioral of fsmMoore_UART_Rx is
	type state_T is (stA, stB);
	signal state, next_state : state_T;
	signal rst_cnt, ena_cnt ,salidaM_cnt: std_logic;
COMPONENT myCnt
Generic (M : integer);
PORT(
	clk : IN std_logic;
	rst : IN std_logic;
	ena : IN std_logic;
	salidaM_2 : OUT std_logic;
	salidaM : OUT std_logic
	);
END COMPONENT;
begin
Inst_myCnt: myCnt   generic map (M => CANT_BITS)
PORT MAP(
	clk =>clk ,
	rst => rst_cnt,
	ena => ena_cnt,
	salidaM_2 =>open ,
	salidaM =>salidaM_cnt
);
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
          busy <='0';		-- Estoy desOCUPADO
			 rst_cnt<='1'; 	-- Contador RESETADO
			 ena_cnt <= '0';	-- Y DESHABILITADO
        when stB =>
          busy <='1';		-- Estoy OCUPADO
			 rst_cnt<='0'; 	-- Contador desRESETADO
			 ena_cnt <= '1';	-- Y HABILITADO
        when others =>
          busy <='0';
			 rst_cnt<='1'; 	-- Contador RESETADO
			 ena_cnt <= '0';	-- Y DESHABILITADO
    end case;
end process;

logicaDeEstadoFuturo: process (state,rx_maq,salidaM_cnt)
begin

	next_state <= state;  -- Se queda en el estado actual por default --

	case (state) is
		when stA =>
		
			if (rx_maq= '0') then
				next_state <= stB;
			else
				next_state <= stA;
			end if;

		when stB =>
  
			if (salidaM_cnt = '1')then
				next_state <= stA;
			else
				next_state <= stB;
			end if;
			
		when others =>
			next_state <= stA;
	end case;

end process;

end Behavioral;
