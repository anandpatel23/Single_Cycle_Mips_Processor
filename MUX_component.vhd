library IEEE;
use IEEE.std_logic_1164.all;
use IEEE.numeric_std.all;


entity MUX is

	Port(
		X, Y : in std_logic_vector(31 downto 0);
		S: in std_logic;
		Z: out std_logic_vector(31 downto 0)
		);
end MUX;

architecture beh of MUX is
	begin
	Z <= X when (S='0') else Y;

end beh;