library IEEE;
use IEEE.STD_LOGIC_1164.ALL;

entity myUartRxTest is
	Port (	clk : in std_logic;
				rst : in std_logic;
				led : out std_logic_vector (7 downto 0);
				rx  : in std_logic
			);
end myUartRxTest;
architecture Behavioral of myUartRxTest is
COMPONENT myUartRx
	PORT(
		clk : IN std_logic;
		rst : IN std_logic;
		rx : IN std_logic;          
		dataRd : OUT std_logic;
		dataRx : OUT std_logic_vector(7 downto 0)
		);
END COMPONENT;
signal sig_ok,not_rst: std_logic;
signal led_sig,nuevo: std_logic_vector(7 downto 0);

begin
Inst_myUartRx: myUartRx PORT MAP(
	clk =>clk ,
	rst => rst,
	dataRd =>open ,
	dataRx =>led ,
	rx => rx
);




end Behavioral;

