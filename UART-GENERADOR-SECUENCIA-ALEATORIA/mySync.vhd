library IEEE;
use IEEE.STD_LOGIC_1164.ALL;

entity mySync is
    Port ( clk : in  STD_LOGIC;
           asyncIn : in  STD_LOGIC;
           syncOut : out  STD_LOGIC);
end mySync;

architecture Behavioral of mySync is

	signal syncFF : std_logic_vector(1 downto 0) := (others => '0');
    
	attribute ASYNC_REG : string;
	attribute ASYNC_REG of syncFF : signal is "true";

begin

 process (clk)
    begin
        if rising_edge(clk) then
            syncFF(0) <= asyncIn;
            syncFF(1) <= syncFF(0);
        end if;
    end process;

    syncOut <= syncFF(1);

end Behavioral;

