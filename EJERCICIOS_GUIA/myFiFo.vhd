library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use ieee.numeric_std.all;


entity myFiFo is
			Port ( 	clk : in STD_LOGIC;
						rst : in STD_LOGIC;
						din : IN STD_LOGIC_VECTOR(7 DOWNTO 0);
						wrEna : IN STD_LOGIC_VECTOR(0  DOWNTO 0);
						dout : OUT STD_LOGIC_VECTOR(7 DOWNTO 0);
						rdEna : IN STD_LOGIC_VECTOR(0  DOWNTO 0);
						full : OUT STD_LOGIC;
						mid : OUT STD_LOGIC;
						indice: OUT STD_LOGIC_VECTOR(9 DOWNTO 0);
						empty : OUT STD_LOGIC );
end myFiFo;
architecture Behavioral of myFifo is
COMPONENT MyTruchiFiFo
  PORT (
    clka 	: IN 	STD_LOGIC;
    wea 		: IN 	STD_LOGIC_VECTOR(0 DOWNTO 0);
    addra 	: IN 	STD_LOGIC_VECTOR(9 DOWNTO 0);
    dina 	: IN 	STD_LOGIC_VECTOR(7 DOWNTO 0);
    douta 	: OUT STD_LOGIC_VECTOR(7 DOWNTO 0);
    clkb 	: IN 	STD_LOGIC;
    web 		: IN 	STD_LOGIC_VECTOR(0 DOWNTO 0);
    addrb	: IN 	STD_LOGIC_VECTOR(9 DOWNTO 0);
    dinb 	: IN 	STD_LOGIC_VECTOR(7 DOWNTO 0);
    doutb 	: OUT STD_LOGIC_VECTOR(7 DOWNTO 0)
  );
END COMPONENT;
constant MID_CONST 	: integer := 512;
constant FULL_CONST 	: integer := 1022;
constant EMPTY_CONST : integer := 0;
signal addr_aux:STD_LOGIC_VECTOR(9 DOWNTO 0);
signal wrEna_aux:STD_LOGIC_VECTOR(0 DOWNTO 0);
signal rdEna_aux,rd_2:STD_LOGIC_VECTOR(7 DOWNTO 0);
signal full_sig, empty_sig,mid_sig: STD_LOGIC;
signal a , b: std_logic;--
signal lectura: STD_LOGIC_VECTOR (0 DOWNTO 0);
begin

insta_00 : MyTruchiFiFo
  PORT MAP (
    clka => clk,
    wea => 	wrEna_aux,
    addra => addr_aux,--
    dina => din,
    douta => open,
    clkb => clk,
    web =>  lectura,        
    addrb => addr_aux,--
    dinb => din,
    doutb => rdEna_aux
  );
process(clk,rst)
begin
	if (rst='0') then 
			addr_aux<=(others=>'0');
			full_sig<='0';
			empty_sig<='1';
			mid_sig<='0';
			lectura<="1";
			a <= '0';
	elsif (rising_edge(clk)) then
		wrEna_aux<="0";
		if(addr_aux = "0000000000") then
			empty_sig <= '1';
		else
			empty_sig <= '0';
		end if;
		if(rdEna = "1") then
				if (empty_sig = '0') then
					wrEna_aux<="0";
					if(addr_aux = "0000000000") then
						empty_sig <= '1';
					else
						a <= '1';
						lectura<="0";
						empty_sig <= '0';
						addr_aux<=std_logic_vector(unsigned(addr_aux) - 1);
					end if;
				end if;
		elsif	  (wrEna = "1") then
			a <= '0';
			if (full_sig = '0') then 
				wrEna_aux<="1";
				lectura<="1";
				addr_aux<=std_logic_vector(unsigned(addr_aux) + 1);
				if(addr_aux = "1111111111") then
					full_sig <= '1';
				else
					full_sig <= '0';
				end if;
			end if;
		end if;
		if (addr_aux =std_logic_vector(to_unsigned( MID_CONST,addr_aux	'length))) then
			mid_sig<='1';
		else
			mid_sig<='0';
		end if;
	end if;
end process;


with a select
rd_2<= rdEna_aux when '1',
			(others=>'0') when others;
			
with rd_2(0) select
dout <= rd_2 when '1',
			rd_2 when '0',
			(others=>'0') when others;

indice<=addr_aux;
empty	<=empty_sig;
mid	<=mid_sig;
full	<=full_sig;

end Behavioral;










--			if(addr_aux = "0000000000") then
--				empty_sig <= '1';
--			else
--				empty_sig <= '0';
--				wrEna_aux<="0";
--				addr_aux<=std_logic_vector(unsigned(addr_aux) - 1);
--			end if;















--

--		elsif(addr_aux="0111111110")	then--to_integer(signed(addr_aux)) = MID_CONST
--			
--			full<='0';
--			mid <='1';
--			empty<='0';


































--  -- hold reset state for 100 ns.
--      wait for 100 ns;	
--		rst<='0';
--		wait for 10 ns;
--		rst<='1';
--		wait for 10 ns;
		
		
		
		
--		--Escribo
--		wrEna<="1";
--		rdEna<="0";
--		din<=(others=>'1');
--		wait for 50 ns;
--		--Leo
--		wrEna<="0";
--		rdEna<="1";
--		wait for 50 ns;
		
----		din<="00001111";
--		rdEna<="0";
--		
--		wrEna<="1";
--		wait for 10 ns;
--		din<="00111101";
--		wait for 10 ns;
--		din<="00101101";
--		wait for 10 ns;
--		din<="01011101";
--		wait for 10 ns;
--		din<="10011101";
--		wait for 10 ns;
--		din<="01010101";
--		wait for 10 ns;
--		din<="10111101";
--		--leo de vuelta
--		wait for 20 ns;
--		wrEna<="0";
--		rdEna<="1";
--		
--		--din<=(others=>'1');
--		
		

