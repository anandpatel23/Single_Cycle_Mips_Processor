------------------------------------
-- Component: Shift Left 2 - Jump
-- Trey Harper
-- Single Cycle MIPS Processor
------------------------------------

library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.std_logic_arith.all;
use IEEE.STD_LOGIC_UNSIGNED.ALL;

entity Adder is 

	port(x,y : in std_logic_vector(31 downto 0);
		z : out std_logic_vector(31 downto 0));

end Adder;

architecture beh of Adder is 

begin
process(x,y)
begin

z <= x + y;

end process;
end beh;