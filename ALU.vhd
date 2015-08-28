-----------------------------------------------------------
-- Component: Arithmetic Logic Unit (ALU)
-- Engineer: Anand Patel
-- description: 
-- performs an operation on 2 inputs and returns the result
-- (+, -, &&, ||, set-on-<)
--
-- if 2 inputs are equal, zero flag is true. else, false.
-----------------------------------------------------------
LIBRARY IEEE;
USE IEEE.STD_LOGIC_1164.ALL;
USE IEEE.STD_LOGIC_ARITH.ALL;
USE IEEE.STD_LOGIC_UNSIGNED.ALL;

entity ALU is
	port(
		x: in std_logic_vector(31 downto 0);
		y: in std_logic_vector(31 downto 0);
		sel_4_bit: in std_logic_vector(3 downto 0);
		result: out std_logic_vector(31 downto 0);
		zero_flag: out std_logic);
end ALU;

architecture behavioral of ALU is
begin
	process(sel_4_bit, x, y)
	begin
	case sel_4_bit is
		when "0000" =>
			result <= x + y;
		when "0001" =>
			result <= x + (not y) + 1;
		when "0010" =>
			result <= x + 1;
		when "0011" =>
			result <= x - 1;				
		when "0100" =>
			result <= y + 1;
		when "0101" =>
			result <= y - 1;
		when "0110" =>
			result <= x;
		when "0111" =>
			result <= y;
		when "1000" =>
			result <= not x;
		when "1001" =>
			result <= not y;
		when "1010" =>
			result <= x and y;
		when "1011" =>
			result <= x or y;
		when "1100" =>
			result <= x nand y;
		when "1101" =>
			result <= x nor y;
		when "1110" =>
			result <= x xor y;
		when "1111" =>
			result <= not(x xor y);			
		when others =>
			result <= "UUUUUUUUUUUUUUUUUUUUUUUUUUUUUUUU";
	end case;
end process;

	zero_flag <= '1' when((x /= y) and sel_4_bit = "0011")
	else '0' when((x = y) and sel_4_bit = "0011")
	else '1' when(x = y)
	else '0';
end behavioral;