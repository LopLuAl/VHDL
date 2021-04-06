library IEEE;
library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
--              MODO DE USO              --
-- WEA o WEB -> con '1' escribo con '0' leo
--                                       --
entity myBlockMemTest_00 is
	Port ( 	clk : in STD_LOGIC;
				wea : IN STD_LOGIC_VECTOR(0 DOWNTO 0);
				addra : IN STD_LOGIC_VECTOR(9 DOWNTO 0);
				dina : IN STD_LOGIC_VECTOR(15 DOWNTO 0);
				douta : OUT STD_LOGIC_VECTOR(15 DOWNTO 0);
				web : IN STD_LOGIC_VECTOR(0 DOWNTO 0);
				addrb : IN STD_LOGIC_VECTOR(9 DOWNTO 0);
				dinb : IN STD_LOGIC_VECTOR(15 DOWNTO 0);
				doutb : OUT STD_LOGIC_VECTOR(15 DOWNTO 0) 
				);
end myBlockMemTest_00;

architecture Behavioral of myBlockMemTest_00 is
COMPONENT myBlockMemTest
  PORT (
    clka : IN STD_LOGIC;
    wea : IN STD_LOGIC_VECTOR(0 DOWNTO 0);
    addra : IN STD_LOGIC_VECTOR(9 DOWNTO 0);
    dina : IN STD_LOGIC_VECTOR(15 DOWNTO 0);
    douta : OUT STD_LOGIC_VECTOR(15 DOWNTO 0);
    clkb : IN STD_LOGIC;
    web : IN STD_LOGIC_VECTOR(0 DOWNTO 0);
    addrb : IN STD_LOGIC_VECTOR(9 DOWNTO 0);
    dinb : IN STD_LOGIC_VECTOR(15 DOWNTO 0);
    doutb : OUT STD_LOGIC_VECTOR(15 DOWNTO 0)
  );
END COMPONENT;
begin
insta_00 : myBlockMemTest
  PORT MAP (
    clka => clk,
    wea => wea,
    addra => addra,
    dina => dina,
    douta => douta,
    clkb => clk,
    web => web,
    addrb => addrb,
    dinb => dinb,
    doutb => doutb
  );
end Behavioral;

