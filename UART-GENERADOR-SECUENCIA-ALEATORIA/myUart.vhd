----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date:    20:31:54 10/28/2019 
-- Design Name: 
-- Module Name:    myUart - Behavioral 
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

entity myUart is
	Generic (
		baudRate : integer := 9600;--1250000;
		sysClk 	: integer := 50000000;
		dataSize : integer := 8
				);
	Port ( 
		clk 		: in 	std_logic;
		rst 		: in 	std_logic;
		dataWr 	: in 	std_logic;
		dataTx 	: in 	std_logic_vector (dataSize - 1 downto 0);
		busy 		: out std_logic;
		tx 		: out std_logic;
		dataRd 	: out std_logic;
		dataRx 	: out std_logic_vector (dataSize - 1 downto 0);
		rx 		: in 	std_logic
			);
end myUart;
architecture Behavioral of myUart is
COMPONENT myUartTx
	Generic(
		baudRate : integer;
		sysClk 	: integer;
		dataSize : integer 
		);
	Port(
		clk 		: in 	std_logic;
		rst 		: in 	std_logic;
		dataWr 	: in 	std_logic;
		dataTx 	: in 	std_logic_vector(dataSize - 1 downto 0);          
		busy 		: out std_logic;
		tx 		: out std_logic
		);
END COMPONENT;
COMPONENT mySync
	Port(
		clk 		: in std_logic;
		asyncIn 	: in std_logic;          
		syncOut 	: out std_logic
	);
END COMPONENT;
COMPONENT myUartRx
	Generic(
		baudRate : integer;
		sysClk 	: integer;
		dataSize : integer 
		);
	Port(
		clk 		: in 	std_logic;
		rst 		: in 	std_logic;
		rx 		: in 	std_logic;          
		dataRd 	: out std_logic;
		dataRx 	: out std_logic_vector(dataSize - 1 downto 0)
		);
END COMPONENT;
signal rx_synch: std_logic;
begin
----------------------------------------------------------------------------
---                                                                      ---
---OJO: EN LA SIMULACION, RESETEO CON 1 Y EN MI KIT RESETEO CON 0 ! BITCH---
---                                                                      ---
----------------------------------------------------------------------------

Inst_mySync: mySync 
PORT MAP		(
					clk 		=> clk,
					asyncIn 	=> rx,
					syncOut 	=> rx_synch
				);
Inst_myUartRx: myUartRx 
GENERIC MAP(	baudRate =>	baudRate,
					sysClk 	=>	sysClk,
					dataSize => dataSize
				)
PORT MAP		(
					clk 		=> clk,
					rst 		=> rst,
					dataRd 	=> dataRd,
					dataRx	=> dataRx,
					rx 		=> rx_synch
				);
Inst_myUartTx: myUartTx  
GENERIC MAP(	baudRate =>	baudRate,
					sysClk 	=>	sysClk,
					dataSize => dataSize
				)
PORT MAP		(
					clk 		=> clk,
					rst 		=> rst,
					dataWr 	=> dataWr,
					dataTx 	=> dataTx,
					busy 		=> busy,
					tx 		=> tx 
				);
end Behavioral;

