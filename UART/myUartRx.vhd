library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use ieee.math_real.all;
use ieee.numeric_std.all;
---------------------------------------------------------------------------
--dataRx: Es el dato recibido.
--dataRd: Indica cuando se recibio un dato.Dura un pulso de clk.
--rx: Entrada de recepción.
---------------------------------------------------------------------------
entity myUartRx is
	Generic (baudRate : integer := 9600;
	sysClk : integer := 50000000;
	dataSize : integer := 8);

	Port (	   clk : in  std_logic;
				   rst : in  std_logic;
				dataRd : out std_logic;
				dataRx : out std_logic_vector (dataSize - 1 downto 0);
					 rx : in  std_logic);
end myUartRx;

architecture Behavioral of myUartRx is
COMPONENT mySync
PORT(
	clk : IN std_logic;
	asyncIn : IN std_logic;          
	syncOut : OUT std_logic
	);
END COMPONENT;
COMPONENT myEdgeDetector
PORT(
	clk : IN std_logic;
	rst : IN std_logic;
	d : IN std_logic;
	ascendente : OUT std_logic;
	descendente : OUT std_logic
);
END COMPONENT;
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

constant CUENTA_BAUDS: integer := sysClk/baudRate;
constant N 				: integer := integer(ceil(log2(real (dataSize+2))));-- cantidad de bits que necesito para representar
																								 -- dataSize + 2
signal cuenta_bits: std_logic_vector(N-1 downto 0); 
constant CANTIDAD_BITS_BIN: std_logic_vector(N-1 downto 0):=std_logic_vector(to_unsigned(datasize,cuenta_bits'length));
constant CANTIDAD_BITS_NULL: std_logic_vector(N-1 downto 0):= (others=>'0');
signal q :std_logic_vector (dataSize - 1 downto 0);
signal rst_cnt,ena_cnt,
		 enable_shift_reg,
		 fl_des_myEdgeDetector,
		 dataRd_sig,ocup						: std_logic;
begin
Inst_myCnt: myCnt   generic map (M => CUENTA_BAUDS)
PORT MAP(
	clk =>clk ,
	rst => rst_cnt,
	ena => ena_cnt,
	salidaM_2 =>enable_shift_reg ,
	salidaM =>open
);
Inst_myEdgeDetector: myEdgeDetector
PORT MAP(
	clk =>clk ,
	rst =>rst,
	d =>rx ,
	ascendente => open ,
	descendente => fl_des_myEdgeDetector
);
process (clk, rst)
begin
----------------------------------------------------------------------------
---                                                                      ---
---OJO: EN LA SIMULACION, RESETEO CON 1 Y EN MI KIT RESETEO CON 0 ! BITCH---
---                                                                      ---
----------------------------------------------------------------------------
	if (rst = '0') then 									-- Limpio todas las signals y reseteo el contador
		q <= (others => '0');
--		q_final<= (others => '0');
		ena_cnt 			<= '0'; 							-- desHabilito el cnt
		rst_cnt			<=	'1'; 					  		-- Reseteo el cnt
		cuenta_bits		<=(others=>'0');				-- Resteo la cuenta
		dataRd_sig <= '0';
		ocup<= '0';
	elsif (rising_edge (clk)) then
		dataRd_sig <= '0';
		if(fl_des_myEdgeDetector = '1' and ocup = '0') then 
			ena_cnt 			<= '1'; 						-- desHabilito el cnt
			rst_cnt			<=	'0'; 					  	-- desReseteo el cnt
		end if;
		if (enable_shift_reg = '1') then		
			if (cuenta_bits = CANTIDAD_BITS_BIN) then 
				ocup<='0';
				--q_final<= q;
				rst_cnt			<=	'1'; 					  		-- Reseteo el cnt
				dataRd_sig <= '1';
				cuenta_bits		<=(others=>'0');				-- Resteo la cuenta
			else
				cuenta_bits <= std_logic_vector(unsigned(cuenta_bits)+1);
				dataRd_sig <= '0';
				ocup<= '1';
			end if;
				q <=  q (dataSize -2 downto 0) & rx ;  --CREO Q Esta bien hecho
--				q <=  rx & q (dataSize -2 downto 0) ; 
		end if;
	end if;
end process;
dataRx<=q;
dataRd<=dataRd_sig;
end Behavioral;
