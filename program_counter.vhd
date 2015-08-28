------------------------------------------------------
-- Component: Program Counter
-- Engineer: Anand Patel
-- description: memory address of next instruction that will be fetched is indicted
------------------------------------------------------
LIBRARY IEEE;
USE IEEE.STD_LOGIC_1164.ALL;

entity program_counter is
	port(
		input_mem_address: in std_logic_vector(31 downto 0);
		output_mem_address: out std_logic_vector(31 downto 0);
		ck: in std_logic);
end program_counter;

architecture behavioral of program_counter is
signal address: std_logic_vector(31 downto 0) := "00000000000000000000000000000000";
begin
	process(ck)
	begin
	output_mem_address <= address;
		if ck = '0' and  ck'event then
			address <= input_mem_address;
		end if;
	end process;
end behavioral;

-- architecture behavioral of program_counter is 
	-- signal 	temp_address: std_logic_vector(31 downto 0) := "00000000000000000000000000000000";
	-- signal i: integer := 0; -- keeping count of ck cycles
	-- begin

	-- process(ck)
	-- begin
		-- temp_address <= input_mem_address;

		-- if ck'event and ck = '0' then
				-- output_mem_address <= temp_address;
				-- i := i + 1;
		-- end if;				
	-- end process;
	

