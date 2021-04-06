library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use ieee.numeric_std.all;

entity myRegInc is
	Generic (N : integer := 8);
	Port ( 	clk : in std_logic;
				rst : in std_logic;
			dataUp : in std_logic;
		 dataDown : in std_logic;
			regOut : out std_logic_vector(N - 1 downto 0)
			);
end myRegInc;

architecture Behavioral of myRegInc is
signal cuenta: unsigned (N-1 downto 0);
signal max, min : std_logic_vector(N-1 downto 0);
begin
max<=(others=>'1');
min<=(others=>'0');
process(clk,rst)

begin
	if (rst = '0') then
		cuenta <= (others => '0');
	elsif(rising_edge(clk)) then
			if(dataUp = '0' and dataDown='1') then
				if (std_logic_vector(cuenta) = max) then
					regOut<=(others=>'1');
				else
					cuenta<=cuenta+1;
				end if;
			elsif (dataUp = '1' and dataDown='0')  then
				if (not(std_logic_vector(cuenta) = min) ) then
					cuenta<=cuenta-1;
				else
					regOut<=(others=>'0');
				end if;
			end if;
			regOut<=std_logic_vector(cuenta);
	end if;
end process;
end Behavioral;

