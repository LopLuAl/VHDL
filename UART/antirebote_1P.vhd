----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date:    10:57:57 08/29/2019 
-- Design Name: 
-- Module Name:    antirebote_1P - Behavioral 
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

entity antirebote_1P is
	
	Port ( 	      clk : in  std_logic;
					   rst : in  std_logic;
					  btnIn: in  std_logic;
					 btnOut: out std_logic;
--					btnCode: out std_logic;
				  btnValid: out std_logic
		  );
end antirebote_1P;

architecture Behavioral of antirebote_1P is
	
	CONSTANT M :integer:= 90000;

	COMPONENT myCnt_antirebote
		Generic (M : integer);
		PORT(
			clk : IN std_logic;
			rst : IN std_logic;
			ena : IN std_logic;          
			salidaM_2 : OUT std_logic;
			salidaM : OUT std_logic
			);
	END COMPONENT;
	
	type state_T is (stA, stB, stC);
	signal state, next_state : state_T;
	signal q: std_logic;
	signal q_fft: std_logic:='0';
	signal tc,rst_cnt,ena_cnt: std_logic;
	
begin

Inst_myCnt: myCnt_antirebote GENERIC MAP( M=>M	)
PORT MAP(
		clk => clk,
		rst => rst_cnt,
		ena => ena_cnt,
		salidaM_2 =>open,
		salidaM => tc
			);

----------------------------------------------------------------------------
---                                                                      ---
---OJO: EN LA SIMULACION, RESETEO CON 1 Y EN MI KIT RESETEO CON 0 ! BITCH---
---                                                                      ---
----------------------------------------------------------------------------
procSync: process (clk)
begin
	if (rising_edge(clk)) then
		if (rst = '0') then
			state <= stA;
			q<='0';
			
			
		else
			q<= not btnIn;
			state <= next_state;
		end if;
	end if;

end process;

   --MOORE State-Machine - Outputs based on state only
outputDecode: process (state)
begin
	btnOut 	<='0';
--	btnCode	<='0';
	case (state) is
		when stA 	=>
			btnValid <= '0';
--			btnCode	<= '0';
			btnOut 	<= '0';
			rst_cnt	<= '1';
			ena_cnt 	<= '0'; -- Hab con '1'
		when stB 	=>
			btnValid <= '0';
--			btnCode	<= '0';
			btnOut 	<= '0';
			rst_cnt	<= '0'; --Estoy contando
			ena_cnt 	<= '1'; -- Hab con '1'
		when stC 	=>
			btnValid <= '1';
--			btnCode	<= '1';
			rst_cnt	<= '1';
			ena_cnt 	<= '0'; -- Hab con '1'
			--------------------------------------------------------------------------------
			----OJO: YO PONGO LA SALIDA EN 1 PERO EN EL PULSADOR LO ESTOY METIENDO A MASA---
			--------------------------------------------------------------------------------
			btnOut 	<= '1';-- Contador desabilidtado y reseteado
			
		when others =>
			btnValid <= '0';
--			btnCode	<= '0';
			ena_cnt 	<= '0'; -- Hab con '1'
			btnOut 	<= '0';
			rst_cnt	<= '1';
	end case;
end process;

nextStateDecode: process (state,q,tc,btnIN) -- con la logica combinacional, tengo que poner las entradas en la lista
begin

	next_state <= state;  -- Se queda en el estado actual por default --

	case (state) is
		when stA =>
--			 if (q xor not btnIN) = '1' then
			 if (not btnIN) = '1' then 		  -- Aprete?
				if (q xor not btnIN) = '1' then -- Hay variacion ?
					next_state<=stB;				  -- Entonces cambio de estado
				end if;
			 else
				next_state<=stA;
			 end if;
		when stB =>
			 if(tc = '0')then
				next_state<=stB;
			 else
--				if ((q xor (not btnIN)) ='1') then 
				if (not btnIN) = '0' then
					next_state<=stA;
				else
					next_state<=stC;--stC
				end if;
			 end if;--
		when stC =>
			 next_state<=stA;
--			if((q xor  not btnIN)='0')then
--				
--			elsif((q xor not btnIN)='1')then --and tc='0'
--				next_state<=stA;
--			end if;

--ESTE ES EL QUE VA PERO NO VEO PRENDER NINGUN LED!
--			if((q xor not btnIN)='1')then
--				next_state<=stC;
--			elsif((q xor not btnIN)='0' and tc='0')then
--				next_state<=stA;
--			end if;
	
--			next_state<=stA;
		when others =>
			 next_state <= stA;
	end case;
	
end process;

end Behavioral;

