----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date:    14:01:14 10/20/2019 
-- Design Name: 
-- Module Name:    myUartTxTest - Behavioral 
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
-- Uncomment the following library declaration if using
-- arithmetic functions with Signed or Unsigned values
--use IEEE.NUMERIC_STD.ALL;

-- Uncomment the following library declaration if instantiating
-- any Xilinx primitives in this code.
--library UNISIM;
--use UNISIM.VComponents.all;

entity myUartTxTest is
	Port ( 	clk : in  std_logic;
				rst : in  std_logic;
				btn : in  std_logic;
				 tx : out std_logic);
end myUartTxTest;

architecture Behavioral of myUartTxTest is
COMPONENT myUartTx
	PORT(
		clk : IN std_logic;
		rst : IN std_logic;
		dataWr : IN std_logic;
		dataTx : IN std_logic_vector(7 downto 0);          
		busy : OUT std_logic;
		tx : OUT std_logic
		);
END COMPONENT;

COMPONENT antirebote
	PORT(
		clk : IN std_logic;
		rst : IN std_logic;
		btnIn : IN std_logic_vector(0 downto 0);          
		btnOut : OUT std_logic_vector(0 downto 0);
		btnValid : OUT std_logic
		);
END COMPONENT;
signal Dato_simulado: std_logic_vector(7 downto 0) :="00000001"; -- Tengo que invertir el orden
signal rst_std_v,btn_std_v,comienzo_std_v: std_logic_vector(0 downto 0);
signal cuenta:STD_LOGIC_VECTOR(7 DOWNTO 0):="00000000";
begin
	btn_std_v(0) <= btn;

	Inst_myUartTx: myUartTx PORT MAP(
		clk =>clk ,
		rst => rst,
		dataWr => comienzo_std_v(0) ,
		dataTx => cuenta,
		busy => open,
		tx => tx
	);
	Inst_antirebote: antirebote PORT MAP(
		clk =>clk ,
		rst => rst,
		btnIn => btn_std_v,
		btnOut => comienzo_std_v,
		btnValid =>  open
	);

--
process(clk,rst)
begin
----------------------------------------------------------------------------
---                                                                      ---
---OJO: EN LA SIMULACION, RESETEO CON 1 Y EN MI KIT RESETEO CON 0 ! BITCH---
---                                                                      ---
----------------------------------------------------------------------------
	if (rst='0') then 
		cuenta<=(others=>'0');
	elsif (rising_edge(clk)) then
		if (comienzo_std_v="1") then 
			cuenta<=std_logic_vector(unsigned(cuenta) + 1);
		end if;
	end if;
end process;
end Behavioral;

