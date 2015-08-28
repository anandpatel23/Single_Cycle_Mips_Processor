--------------------------------------------------------
-- Component: Sign Extend
-- Engineer: Anand Patel
-- description: "what if I told you, 16-bit vectors can 
-- become 32-bit vectors." - Morpheus
----------------------------------------------------

LIBRARY IEEE;
USE IEEE.STD_LOGIC_1164.ALL;
USE IEEE.NUMERIC_STD.ALL;

entity sign_extension is
	port(
		vector_in: in std_logic_vector(15 downto 0);
		vector_out: out std_logic_vector(31 downto 0));
end sign_extension;

architecture behavioral of sign_extension is
begin
	-- convert to signed value, then resize which will extend to 32 bits
	-- this goes into type standard logic vector
	vector_out <= std_logic_vector(resize(signed(vector_in), vector_out'length));
end behavioral;