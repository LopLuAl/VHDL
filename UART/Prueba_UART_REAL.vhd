----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date:    22:40:17 10/19/2019 
-- Design Name: 
-- Module Name:    Prueba_UART_REAL - Behavioral 
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
entity Prueba_UART_REAL is
	Port ( 
		clk 	: in std_logic;
		rst 	: in std_logic;
		dataWr : in std_logic;
		busy 	: out std_logic;
		tx 	: out std_logic;
		qdebug: out std_logic_vector(9 downto 0);
		mdedub: out std_logic);
end Prueba_UART_REAL;

architecture Behavioral of Prueba_UART_REAL is
	COMPONENT myUartTx
	PORT(
		clk : IN std_logic;
		rst : IN std_logic;
		dataWr : IN std_logic;
		dataTx : IN std_logic_vector(7 downto 0);          
		busy : OUT std_logic;
		tx : OUT std_logic;
		qdebug : OUT std_logic_vector(9 downto 0);
		mdedub : OUT std_logic
		);
	END COMPONENT;
	signal Dato_simulado: std_logic_vector(7 downto 0) :="00000001"; -- Tengo que invertir el orden
begin
	Inst_myUartTx: myUartTx PORT MAP(
		clk =>clk ,
		rst => rst,
		dataWr =>dataWr ,
		dataTx => Dato_simulado,
		busy => busy,
		tx => tx,
		qdebug => qdebug,
		mdedub => mdedub
	);

end Behavioral;

