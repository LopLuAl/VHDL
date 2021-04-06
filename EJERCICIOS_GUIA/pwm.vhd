library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use ieee.math_real.all;
use ieee.numeric_std.all;

entity pwm is
	Generic (F: integer := 50000000);--Frecuencia clk en Hz
	Port ( 	clk 	 		: in  std_logic;
				rst 	 		: in  std_logic;
				duty 	 		: in  std_logic_vector(1 downto 0);
				frec 	 		: in  std_logic_vector(1 downto 0);
				pol 	 		: in  std_logic;
				load 			: in  std_logic;
				salida 		: out std_logic
			);
end pwm;
architecture Behavioral of pwm is
constant frec_50 : integer:=F/50;
constant frec_80 : integer:=F/80;
constant frec_100: integer:=F/100;
constant frec_125: integer:=F/125; 
constant N 		  : integer:= integer(ceil(log2(real (frec_50))));

signal frecuencia_aux,frecuencia,cuenta,ciclo_act_aux,ciclo_act,duty_25,duty_50,duty_75 : unsigned (N-1 downto 0);
signal cnt_salida,neg_sal,pol_sig: std_logic;

begin
-----------------------------------------------------------------------------------
--- 								  Duty = 100*(Thigh/T)										  ---
-----------------------------------------------------------------------------------

with frec select
frecuencia <= 	to_unsigned(frec_50 ,N) when "00",
					to_unsigned(frec_80 ,N) when "01",
					to_unsigned(frec_100,N) when "10",
					to_unsigned(frec_125,N) when "11",
					to_unsigned(frec_50 ,N) when others;
-----------------------------------------------------------------------------------
-- RECORDARTORIO PARA LUCIANO DEL FUTURO  :P
-- LA CUENTA QUE TENGO QUE HACER ES: duty*T= Thigh
-- 0<duty<1 
-- T es el periodo
-- Ahora: si duty = 25% entonces 0,25 que es lo mismo que dividir por 4 o desplazar dos lugares a la izquierda
-- 		 Algo parecido pasa cuando duty = %50
-- Por ultimo: si el duty es 75% es la suma de 50 + 25
-----------------------------------------------------------------------------------
duty_25    <= "00"&frecuencia(N-1 downto 2);
duty_50    <= "0" &frecuencia(N-1 downto 1);
duty_75    <= duty_25 + duty_50;

with duty select
ciclo_act  <=  duty_25    when "00", -- %25
					duty_50    when "01", -- %50
					duty_75    when "10", -- %75
					frecuencia when "11", -- %100
					duty_50    when others;

neg_sal<= not cnt_salida;

with pol_sig select
salida	 <=	cnt_salida 		when '0',
					neg_sal			when '1',
					cnt_salida 		when others;
process(clk)
begin
	
	if(rising_edge(clk)) then
		if (rst ='0') then
			cuenta				<= (others=>'0');
			cnt_salida			<= '1';
			------------------------------------------------
			--															 --
			------------------------------------------------
			frecuencia_aux 	<= to_unsigned(frec_50 ,N);
			ciclo_act_aux   	<= duty_50;
			pol_sig 				<=	'0';
			------------------------------------------------
			-- 			  valores por default             --
			------------------------------------------------		
		else
			if (load ='1') then
				frecuencia_aux	<=frecuencia;
				ciclo_act_aux 	<=ciclo_act;
				cnt_salida		<= '1';
				pol_sig 			<=pol;
			elsif (cuenta = frecuencia_aux) then
				cnt_salida <='1';
				cuenta<=cuenta + 1;
				cuenta<= (others=>'0');
			elsif(cuenta = ciclo_act_aux) then
				cnt_salida <='0';
				cuenta<=cuenta + 1;
			else
				cuenta<=cuenta + 1;
			end if;
		end if;
	end if;
end process;

end Behavioral;

