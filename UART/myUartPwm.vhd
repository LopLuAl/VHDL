library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;

entity myUartPwm is
Port ( 	clk : in 	std_logic;
			rst : in 	std_logic;
			tx  : out 	std_logic;
			rx  : in 	std_logic;
			led : out	std_logic_vector (3 downto 0)
		);
end myUartPwm;
architecture Behavioral of myUartPwm is
COMPONENT pwm
	PORT(
			clk 				: IN 	std_logic;
			rst 				: IN 	std_logic;
			duty 				: IN 	std_logic_vector(1 downto 0);
			frec 				: IN 	std_logic_vector(1 downto 0);
			pol 				: IN 	std_logic;
			load 				: IN 	std_logic;
			salida 			: OUT std_logic
		);
END COMPONENT;
COMPONENT myUart
	PORT(
			clk 	 			: IN 	std_logic;
			rst 	 			: IN 	std_logic;
			dataWr 			: IN 	std_logic;
			dataTx 			: IN 	std_logic_vector(7 downto 0);
			rx 	 			: IN 	std_logic;
			busy 	 			: OUT std_logic;
			tx 	 			: OUT std_logic;
			dataRd 			: OUT std_logic;
			dataRx 			: OUT std_logic_vector(7 downto 0)
		);
END COMPONENT;
COMPONENT fsm_eco_v2
	PORT(
			clk 				: IN 	std_logic;
			rst 				: IN 	std_logic;
			busy_sig 		: IN 	std_logic;
			en_data_read 	: IN 	std_logic;
			dato_a_leer  	: IN 	std_logic_vector(7 downto 0);          
			dato_a_enviar 	: OUT std_logic_vector(7 downto 0);
			en_data_send 	: OUT std_logic;
			modif				: OUT std_logic
		);
END COMPONENT;
-----------------------------------------------------------------------------------------
signal en_data_send,en_data_read,busy_sig,sig_modif						: std_logic;
signal dato_a_enviar,dato_a_leer,dato_a_leer_r,dato_1,dato_2,dato_3	: std_logic_vector(7 downto 0);
-----------------------------------------------------------------------------------------
signal sig_load														: std_logic_vector(3 downto 0);

type   sig_pwm  is   array  (3 downto 0)   of   		  	  std_logic_vector(1 downto 0);
signal sig_duty,sig_frec											: sig_pwm;
-----------------------------------------------------------------------------------------
signal s_led,s_duty,s_frec											: std_logic_vector(1 downto 0 );
---------------------------------------------------------------------------------

begin

---------------------------------------------------------------------------------
--- 								     MODO DE USO UART								 		---
--- dataWr: '1' -> Habilito para mandar datos
--- dataTx:			 Vector con los bits a enviar
--- busy:	'1' -> Mientras esta mandando datos (INCLUYE EL BIT START Y DE STOP)
--- tx:				 Salida de la informacion en serie
--- dataRd: '1' -> Me avisa cuando hay un dato que pueda leer x 1 ciclo clk
--- dataRx:			 Vector con los bits recibidos
--- rx:				 Entrada de la informacion en serie
--- 							      	MODO DE USO UART		    						 	---
---------------------------------------------------------------------------------
Inst_myUart: myUart
PORT MAP(
			clk 		=> clk ,
			rst 		=> rst,
			dataWr 	=> en_data_send,
			dataTx 	=> dato_a_enviar,
			busy 		=> busy_sig,
			tx			=> tx,
			dataRd 	=> en_data_read,
			dataRx 	=> dato_a_leer,
			rx 		=> rx
);
Inst_fsm_eco_v2: fsm_eco_v2
PORT MAP(
			clk				=> clk ,
			rst 				=> rst,
			busy_sig 		=> busy_sig,
			en_data_read 	=> en_data_read,
			dato_a_leer 	=> dato_a_leer_r,
			dato_a_enviar 	=> dato_a_enviar,
			en_data_send 	=> en_data_send,
			modif				=> sig_modif
);
instFor: for i in led'range generate
	Inst_pwm: pwm PORT MAP
		(
			clk 		=> clk,
			rst 		=> rst,
			duty 		=> sig_duty(i),
			frec 		=> sig_frec(i),
			pol 		=> '0',
			load 		=> sig_load(i),
			salida 	=>	led(i)
		);
end generate;
----RECIBO LOS BITS INVERTIDOS--
gen_1:
for i in dato_a_leer'range generate
	dato_a_leer_r(dato_a_leer_r'left - i) <= dato_a_leer(i);
end generate gen_1;
------LOS INVIERTO YO ACA-------
--------------------------------
--------------------------------
process(clk)
begin
if rising_edge(clk) then 
	if rst = '0' then
		sig_load	  <=(others=>'0');
		sig_duty(0)<=(others=>'0');
		sig_duty(1)<=(others=>'0');
		sig_duty(2)<=(others=>'0');
		sig_duty(3)<=(others=>'0');
		sig_frec(0)<=(others=>'0');
		sig_frec(1)<=(others=>'0');
		sig_frec(2)<=(others=>'0');
		sig_frec(3)<=(others=>'0');
	else
--		byte1 <= led & frec & duty
--		bytes    7~6   5~4    3~0
		if sig_modif = '1' then 
			sig_duty(to_integer(unsigned(dato_a_leer_r(7 downto 6))))<=dato_a_leer_r(1 downto 0);
			sig_frec(to_integer(unsigned(dato_a_leer_r(7 downto 6))))<=dato_a_leer_r(5 downto 4);
			sig_load(to_integer(unsigned(dato_a_leer_r(7 downto 6))))<='1';
		else
			sig_load<=(others=>'0');
		end if;
	end if;
end if;
end process;
end Behavioral;

  