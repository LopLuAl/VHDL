----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date:    18:34:06 09/19/2019 
-- Design Name: 
-- Module Name:    lfsr_G - Behavioral 
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

--	MODO DE USO TAP'S--
--Para usar taps hay que asginarlo como potencias de 2 
--por ejemplo si quiero poner una xor en el ff nº3
--taps<="1000";
--El numero del bit MSB del vector coincide con el numero mas grande de la cadena de FF's
--MODO DE USO TAP'S--
entity lfsr_G is
	Generic (N : integer := 8);
	Port (	 clk : in std_logic;
			 	 rst : in std_logic;
				taps : in std_logic_vector(N - 1 downto 0);
			 salida : out std_logic_vector(N - 1 downto 0);
			 enable : in std_logic
			);
end lfsr_G;

architecture Behavioral of lfsr_G is
COMPONENT lfsr_comp
Port ( 		clk : in std_logic;
				rst : in std_logic;
				 ent : in std_logic;
				  n : in std_logic;
				tap : in std_logic;
				sal : out std_logic;
				enable:in std_logic;
				q_default: in std_logic
		);
END COMPONENT;
signal  ent_aux: 	std_logic_vector(N-1 downto 0);
signal 	n_aux:	std_logic_vector(N-1 downto 0);
signal tap_aux:	std_logic_vector(N-1 downto 0);
signal sal_aux: 	std_logic_vector(N-1 downto 0);
signal default: std_logic_vector(N-1 downto 0);
begin
default<=X"01";
instFor: for i in  0 to N-1 generate
	inst: lfsr_comp Port map ( clk => clk,
										rst=> rst, 
										ent=>	ent_aux(i),
										n=>	n_aux(i),
										tap=>	taps(i),
										sal=>	sal_aux(i),
										enable=>enable,
										q_default=>default(i)
										);
end generate;

-------------------------------------------------
--CONEXIONADO DE SALIDA CON ENTRADA DEL OTRO FF--
-------------------------------------------------
ent_aux(0)<=sal_aux(N-1);
f1: for i in 0 to N-2 generate
	ent_aux(i+1)<=sal_aux(i);
end generate;
-------------------------------------------------
--             CONEXIONADO XOR's               --
-------------------------------------------------
f2: for i in 1 to N-1 generate
	n_aux(i)<= sal_aux(N-1);
end generate;
n_aux(0)<='0';
-------------------------------------------------
--             ASIGNACION SALIDA               --
-------------------------------------------------
salida<=sal_aux;
end Behavioral;

