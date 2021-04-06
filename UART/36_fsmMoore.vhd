library IEEE;
use IEEE.STD_LOGIC_1164.ALL;

entity fsmMoore is
    Port ( clk : in  STD_LOGIC;
           rst : in  STD_LOGIC;
           entrada : in  STD_LOGIC;
           salida : out  STD_LOGIC);
end fsmMoore;

architecture Behavioral of fsmMoore is
	type state_T is (stA, stB, stC, stD);
	signal state, next_state : state_T;
begin

estado: process (clk)
begin
	if (rising_edge(clk)) then
		if (rst = '1') then
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
            salida <= '0';

        when stB =>
            salida <= '0';

        when stC =>
            salida <= '0';

        when stD =>
            salida <= '1';

        when others =>
            salida <= '0';

    end case;
end process;

logicaDeEstadoFuturo: process (state, entrada)
begin

	next_state <= state;  -- Se queda en el estado actual por default --

	case (state) is
		when stA =>
			if entrada = '1' then
				next_state <= stB;
			else
				next_state <= stA;
			end if;

		when stB =>
			if entrada = '1' then
				next_state <= stC;
			else
				next_state <= stB;
			end if;

		when stC =>
			if entrada = '1' then
				next_state <= stD;
			else
				next_state <= stC;
			end if;

        when stD =>
			if entrada = '1' then
				next_state <= stA;
			else
				next_state <= stD;
			end if;

		when others =>
			next_state <= stA;
	end case;
	
end process;

end Behavioral;
