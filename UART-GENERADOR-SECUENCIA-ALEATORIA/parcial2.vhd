
library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
entity parcial2 is
Generic ( baudRate : integer := 9600;
				sysClk : integer := 50000000 -- Colocar de acuerdo al kit
			);
Port ( 	clk : in std_logic;
			rst : in std_logic;
			 rx : in std_logic;
			 tx : out std_logic
		);
end parcial2;

architecture Behavioral of parcial2 is
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
COMPONENT parpadeo1S
	PORT(
			clk : IN std_logic;
			rst : IN std_logic;          
			led : OUT std_logic
	);
END COMPONENT;
COMPONENT lfsr_G
	PORT(
			clk : IN std_logic;
			rst : IN std_logic;
			taps : IN std_logic_vector(7 downto 0);          
			salida : OUT std_logic_vector(7 downto 0);
			enable :IN STD_LOGIC
		);
END COMPONENT;
COMPONENT fsm_eco_v2
	PORT(
			clk : IN std_logic;
			rst : IN std_logic;
			en_data_read : IN std_logic;
			dato_a_leer : IN std_logic_vector(7 downto 0);          
			dato_a_enviar : OUT std_logic_vector(7 downto 0);
			modif:out std_logic
	);
END COMPONENT;
signal salida_aux,taps_aux: std_logic_vector(7 downto 0);
-----------------------------------------------------------------------------------------
signal en_data_send,en_data_read,busy_sig,sig_modif						: std_logic;
signal dato_a_enviar,dato_a_leer,dato_a_leer_r,dato_1,dato_2,dato_3,dato_a_actualizar	: std_logic_vector(7 downto 0);
-----------------------------------------------------------------------------------------
signal base_de_tiempo,rst_lfsr,enable: std_logic;
-----------------------------------------------------------------------------------------

begin
Inst_lfsr_G: lfsr_G PORT MAP(
			clk => clk,
			rst => rst_lfsr,
			taps => taps_aux,
			salida =>salida_aux,
			enable=>enable
);
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
Inst_parpadeo1S: parpadeo1S PORT MAP(
			clk => clk ,
			rst => rst,
			led => base_de_tiempo
	);
Inst_fsm_eco_v2: fsm_eco_v2
PORT MAP(
			clk				=> clk ,
			rst 				=> rst,
			en_data_read 	=> en_data_read,
			dato_a_leer 	=> dato_a_leer_r,
			dato_a_enviar	=> dato_a_actualizar,
			modif          => sig_modif
);
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
----RECIBO LOS BITS INVERTIDOS--
gen_1:
for i in dato_a_leer'range generate
	dato_a_leer_r(dato_a_leer_r'left - i) <= dato_a_leer(i);
end generate gen_1;
------LOS INVIERTO YO ACA-------
--------------------------------
--------------------------------
process (clk,rst)
begin
	if(rising_edge(clk)) then
		if(rst = '0') then 
			taps_aux<=X"10";
			rst_lfsr<='0';
		elsif(sig_modif = '1') then -- parte de Rx aca recibo el valor de taps y actualizo el lsfr
			taps_aux<=dato_a_actualizar;
			rst_lfsr<='0';				 -- resteo y en el proximo flanco de clk va a el else y arranca la secuencia!!
		elsif(base_de_tiempo = '1') then
			enable<='1';
			if (busy_sig = '0') then 
				en_data_send<='1';
				dato_a_enviar<=salida_aux;
			else
				en_data_send<='0';
				dato_a_enviar<=(others=>'0');
			end if;
		else
			enable<='0';
			rst_lfsr<='1';
			en_data_send<='0';
		end if;
	end if;
end process;
end Behavioral;

