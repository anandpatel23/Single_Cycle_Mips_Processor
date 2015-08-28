------------------------------------
-- Component: Shift Left 2
-- Trey Harper
-- Single Cycle MIPS Processor
------------------------------------

library IEEE;
use IEEE.STD_LOGIC_1164.ALL;

entity Shift_left_2 is 
	
	generic(n:natural := 32);
	port(x : in std_logic_vector(n-1 downto 0);
		y : out std_logic_vector(n-1 downto 0));
		
end Shift_left_2;

architecture beh of Shift_left_2 is
begin
process(x)
begin

y <= x(n-3 downto 0) & "00";

end process;
end beh;

