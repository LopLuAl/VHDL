----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date:    21:36:28 10/28/2019 
-- Design Name: 
-- Module Name:    myUartTest - Behavioral 
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
use ieee.numeric_std.all;

entity myUartTest is
	Port ( 	
		clk 		: in 	std_logic;
		rst 		: in 	std_logic;
		sw	 		: in	std_logic_vector (3 downto 0);
		tx  		: out std_logic;
		led 		: out std_logic_vector (7 downto 0);
		rx  		: in 	std_logic;
		salida	: out std_logic_vector(3 downto 0)
		  );
end myUartTest;

architecture Behavioral of myUartTest is

COMPONENT myUart
	Port(
		clk 		: in 	std_logic;
		rst 		: in 	std_logic;
		dataWr 	: in 	std_logic;
		dataTx 	: in 	std_logic_vector(7 downto 0);
		rx 		: in 	std_logic;          
		busy 		: out std_logic;
		tx 		: out std_logic;
		dataRd 	: out std_logic;
		dataRx 	: out std_logic_vector(7 downto 0)
		);
END COMPONENT;
COMPONENT antirebote
	Generic
		(
		N			: integer
		);
	Port(
		clk 		: in 	std_logic;
		rst 		: in 	std_logic;
		btnIn 	: in 	std_logic_vector(N-1 downto 0);          
		btnOut 	: out std_logic_vector(N-1 downto 0);
		btnValid : out std_logic
		);
END COMPONENT;
----------------------------------------------------------------------------
constant CANTIDAD_PULSADORES: integer :=4;
constant cinco: std_logic_vector(3 downto 0 ) := "0101";
----------------------------------------------------------------------------
signal salida_antirebote						: std_logic_vector(3 downto 0);
signal salida_valida_antirebote				: std_logic;
----------------------------------------------------------------------------
signal en_data_send,en_data_read,busy_sig	: std_logic;
signal dato_a_enviar,dato_a_leer				: std_logic_vector(7 downto 0);
----------------------------------------------------------------------------
signal cuentita: unsigned (3 downto 0);
begin
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
---------------------------------------------------------------------------------
--- 								     MODO DE USO UART								 		---
--- dataWr: '1' -> Habilito para mandar datos
--- dataTx:			 Vector con los bits a enviar
--- busy:	'1' -> Mientras esta mandando datos (INCLUYE EL BIT START Y DE STOP)
--- tx:				 Salida de la informacion en serie
--- dataRd: '1' -> Me avisa cuando hay un dato que pueda leer
--- dataRx:			 Vector con los bits recibidos	
--- rx:				 Entrada de la informacion en serie
--- 							      	MODO DE USO UART		    						 	---
---------------------------------------------------------------------------------
Inst_antirebote: antirebote 
GENERIC MAP(N=>CANTIDAD_PULSADORES)
PORT MAP(
			clk		=> clk,
			rst 		=> rst,
			btnIn 	=> sw,
			btnOut 	=>salida_antirebote,
			btnValid =>salida_valida_antirebote
);
----------------------------------------------------------------------------
---                                                                      ---
---OJO: EN LA SIMULACION, RESETEO CON 1 Y EN MI KIT RESETEO CON 0 ! BITCH---
---                                                                      ---
----------------------------------------------------------------------------

----------------------------------------------------------------------------
---                         Instancie la UART.									 --- 
--- Verifique el funcionamiento colocando en los leds el dato recibido 	 ---
---           y el estado de los 4 interruptores del kits 					 ---
--- en el nibble más significativo y en el nibble menos significativo	 ---
---                           transmita 0x5.										 ---
---																							 ---
--- 								   DOCUMENTACION 										 ---
--- 				KEY_1    KEY_2    KEY_3    KEY_4    RST                   ---
---  				 D_5      D_6      D_7      D_8                           ---
---																							 ---
--- 				LED_0    LED_1    LED_2    LED_3    RST                   ---
---  				 D_8      D_7      D_6      D_5                           ---
---------------------------------------------------------------------------- 
process(clk,rst)
begin
	if (rst = '0') then
		en_data_send<='0';
		dato_a_enviar<=(others=>'0');
		cuentita<=(others=>'0');
	elsif (rising_edge(clk)) then
		if (salida_valida_antirebote = '1' and busy_sig ='0') then 
			en_data_send<='1';
			cuentita<=cuentita+1;
			dato_a_enviar<=salida_antirebote&std_logic_vector(cuentita);
		else
			en_data_send<='0';
		end if;
		if (en_data_read ='1') then
			led<=dato_a_leer;
		end if;
	end if;
end process;
end Behavioral;