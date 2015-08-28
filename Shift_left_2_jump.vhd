------------------------------------
-- Component: Shift Left 2 - Jump
-- Trey Harper
-- Single Cycle MIPS Processor
------------------------------------

library IEEE;
use IEEE.STD_LOGIC_1164.ALL;

entity Shift_left_2_jump is

	generic(n:natural := 32);
	port( x : in std_logic_vector(n-7 downto 0);
		y : in std_logic_vector(3 downto 0);
		z : out std_logic_vector(n-1 downto 0));
	
end Shift_left_2_jump;

architecture beh of Shift_left_2_jump is

begin
process(x,y)
begin

z <= y& x & "00";

end process;
end beh;