library IEEE;
use IEEE.std_logic_1164.all;
use IEEE.numeric_std.all;


entity MUX5 is

	Port(
		input_1, input_2 : in std_logic_vector(4 downto 0);
		G: in std_logic;
		output: out std_logic_vector(4 downto 0)
		);
end MUX5;

architecture beh of MUX5 is
	begin
	output <= input_1 when (G='0') else input_2;

end beh;
