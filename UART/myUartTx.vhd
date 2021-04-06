library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use ieee.math_real.all;
use ieee.numeric_std.all;

entity myUartTx is
	Generic (baudRate : integer := 9600;
	sysClk : integer := 50000000;
	dataSize : integer := 8);
	Port ( 
		clk 	: in std_logic;
		rst 	: in std_logic;
		dataWr : in std_logic;
		dataTx: in std_logic_vector (dataSize - 1 downto 0);
		busy 	: out std_logic;
		tx 	: out std_logic
		--;
		--qdebug: out std_logic_vector(dataSize + 1 downto 0);
	--	mdedub: out std_logic
	);
end myUartTx;
architecture Behavioral of myUartTx is
constant N 				: integer := integer(ceil(log2(real (dataSize+2)))); -- cantidad de bits que necesito para representar
																								  -- dataSize + 2
signal rst_cnt,ena_cnt,salidaM_2_cnt,salidaM_cnt: std_logic;
signal sig_busy: std_logic;
signal cuenta_bits: std_logic_vector(N-1 downto 0); 
signal q :std_logic_vector (dataSize + 1 downto 0);
signal dataTx_r :std_logic_vector (dataSize - 1 downto 0);
constant CANTIDAD_BITS_BIN: std_logic_vector(N-1 downto 0):=std_logic_vector(to_unsigned(datasize+2,cuenta_bits'length));
constant CUENTA_BAUDS: integer := sysClk/baudRate;

COMPONENT myCnt
Generic (M : integer);
PORT(
	
	clk : IN std_logic;
	rst : IN std_logic;
	ena : IN std_logic;          
	salidaM_2 : OUT std_logic;
	salidaM : OUT std_logic
	);
END COMPONENT;

begin

Inst_myCnt: myCnt   generic map (M => CUENTA_BAUDS)
PORT MAP(
	clk =>clk ,
	rst => rst_cnt,
	ena => ena_cnt,
	salidaM_2 =>open ,
	salidaM =>salidaM_cnt 
);
----------------------------------------------------------------------------
---                        Invierto los bits                             ---
----------------------------------------------------------------------------
gen_1:
for i in dataTx'range generate
	dataTx_r(dataTx_r'left - i) <= dataTx(i);
end generate gen_1;
----------------------------------------------------------------------------
-- ACLARACION: DEPENDIENDO DE COMO MANDO LOS BITS, INVERTIR O NO!!!
----------------------------------------------------------------------------
process (clk, rst)
begin
----------------------------------------------------------------------------
---                                                                      ---
---OJO: EN LA SIMULACION, RESETEO CON 1 Y EN MI KIT RESETEO CON 0 ! BITCH---
---                                                                      ---
----------------------------------------------------------------------------

	if (rst = '0') then 							-- Limpio todas las signals y reseteo el contador
		q <= (others => '1');
		ena_cnt 			<= '0'; 					-- Desabilito el cnt
		rst_cnt			<=	'1'; 					-- Reseteo el cnt
		cuenta_bits<=(others=>'0');
		--dataTx_r<=(others=>'0');
		sig_busy<='0';
	elsif (rising_edge (clk)) then
	
		if (dataWr = '1' and sig_busy = '0') then 	-- Asi arranca la trama si viene un mensaje mientras quiero transmitir lo ignoro
			rst_cnt<='0'; 										-- Arranco con el contador para obtener los baudios
			ena_cnt <= '1'; 									-- Habilito la cuenta
--			for i in dataTx'range loop
--				dataTx_r(dataTx_r'left - i) <= dataTx(i);
--			end loop;
	--dataTx_r
			q <= '0'	&	dataTx_r	&	'1';
			--	   Bit	 Bit	     Bit --
			--   Start   Data		 Stop --
			
			sig_busy<='1';							-- Voy a transmitir, subo el bit de busy	
		end if;	
		if(salidaM_cnt='1') then
			
			q <=  q (dataSize downto 0) & '1';
			
			if (cuenta_bits = CANTIDAD_BITS_BIN) then 
				sig_busy<='0';
				cuenta_bits<=(others=>'0');
				--q<=(others=>'0');					-- Reseteo el reg
				ena_cnt 			<= '0'; 			-- Desabilito el cnt
				rst_cnt			<=	'1'; 			-- Reseteo el cnt
			else
				cuenta_bits <= std_logic_vector(unsigned(cuenta_bits)+1);	
				sig_busy<='1';		
			end if;
			
		end if;
	end if;
end process;
--qdebug<=q;
busy<=sig_busy;
tx <= q(dataSize+1);

end Behavioral;

