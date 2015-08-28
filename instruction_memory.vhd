----------------------------------------------------------------------------
-- Component: Instruction Memory 
-- Description: stores the instruction currently being executed or decoded
-- Engineer: Anand Patel
----------------------------------------------------------------------------
LIBRARY IEEE;
USE IEEE.STD_LOGIC_1164.ALL;
USE IEEE.STD_LOGIC_ARITH.ALL;
USE IEEE.STD_LOGIC_UNSIGNED.ALL;
USE IEEE.STD_LOGIC_SIGNED.ALL;


entity instructionMemory is
	Port(
		readAddress: in std_logic_vector(31 downto 0);
		instructionOut: out std_logic_vector(31 downto 0));
end instructionMemory;

architecture beh of instructionMemory is
	type memoryType is array(0 to 255) of std_logic_vector(7 downto 0);
	signal mem: memoryType;
	begin

	process(readAddress)
		variable i: integer;
		variable first:boolean := true;
		begin
		if(first) then
			-- lw $s0, 0($t0)
			-- Given that there's an offset of 40 on $t0
			mem(0)<="10001101";
			mem(1)<="00010000";
			mem(2)<="00000000";
			mem(3)<="00000000";
			-- lw $s1, 4($t0)
			mem(4)<="10001101";
			mem(5)<="00010001";
			mem(6)<="00000000";
			mem(7)<="00000100";
			-- beq $s0, $s1, LABEL
			mem(8)<="00010010";
			mem(9)<="00010001";
			mem(10)<="00000000";
			mem(11)<="00000010";
			-- add $s3, $s4, $s5
			mem(12)<="00000010";
			mem(13)<="10010101";
			mem(14)<="10011000";
			mem(15)<="00100000";
			-- j EXIT
			mem(16)<="00001000";
			mem(17)<="00000000";
			mem(18)<="00000000";
			mem(19)<="00000110"; 
			-- LABEL: sub $s3, $s4, $s5
			mem(20)<="00000010";
			mem(21)<="10010101";
			mem(22)<="10011000";
			mem(23)<="00100010";
			-- EXIT: sw $s3, 8($t0)
			mem(24)<="10101101";
			mem(25)<="00010011";
			mem(26)<="00000000";
			mem(27)<="00001000";
			
			first := false;
			end if;

			i:=conv_integer(unsigned(readAddress));
			
			instructionOut <= mem(i)
							& mem(i+1)
							& mem(i+2)
							& mem(i+3);
	end process;
end beh;
-- library IEEE;
-- use IEEE.std_logic_1164.all;
-- use IEEE.numeric_std.all;
-- use STD.textio.all; -- Required for freading a file

-- entity instructionMemory is
	-- port (
		-- readAddress: in STD_LOGIC_VECTOR (31 downto 0);
		-- instructionOut, last_instr_address: out STD_LOGIC_VECTOR (31 downto 0)
	-- );
-- end instructionMemory;


-- architecture behavioral of instructionMemory is	  

    -- -- 128 byte instruction memory (32 rows * 4 bytes/row)
    -- type mem_array is array(0 to 31) of STD_LOGIC_VECTOR (31 downto 0);
    -- signal data_mem: mem_array := (
        -- "00000000000000000000000000000000", -- initialize data memory
        -- "00000000000000000000000000000000", -- mem 1
        -- "00000000000000000000000000000000",
        -- "00000000000000000000000000000000",
        -- "00000000000000000000000000000000",
        -- "00000000000000000000000000000000",
        -- "00000000000000000000000000000000",
        -- "00000000000000000000000000000000",
        -- "00000000000000000000000000000000",
        -- "00000000000000000000000000000000", 
        -- "00000000000000000000000000000000", -- mem 10 
        -- "00000000000000000000000000000000", 
        -- "00000000000000000000000000000000",
        -- "00000000000000000000000000000000",
        -- "00000000000000000000000000000000",
        -- "00000000000000000000000000000000",
        -- "00000000000000000000000000000000",
        -- "00000000000000000000000000000000",
        -- "00000000000000000000000000000000",
        -- "00000000000000000000000000000000",  
        -- "00000000000000000000000000000000", -- mem 20
        -- "00000000000000000000000000000000",
        -- "00000000000000000000000000000000",
        -- "00000000000000000000000000000000",
        -- "00000000000000000000000000000000", 
        -- "00000000000000000000000000000000",
        -- "00000000000000000000000000000000",
        -- "00000000000000000000000000000000",
        -- "00000000000000000000000000000000",
        -- "00000000000000000000000000000000", 
        -- "00000000000000000000000000000000", -- mem 30
        -- "00000000000000000000000000000000"
    -- );

    -- begin

    -- -- The process for reading the instructions into memory
    -- process 
        -- file file_pointer : text;
        -- variable line_content : string(1 to 32);
        -- variable line_num : line;
        -- variable i: integer := 0;
        -- variable j : integer := 0;
        -- variable char : character:='0'; 
    
        -- begin
        -- -- Open instructions.txt and only read from it
        -- file_open(file_pointer, "instructions.txt", READ_MODE);
        -- -- Read until the end of the file is reached  
        -- while not endfile(file_pointer) loop
            -- readline(file_pointer,line_num); -- Read a line from the file
            -- READ(line_num,line_content); -- Turn the string into a line (looks wierd right? Thanks Obama)
            -- -- Convert each character in the string to a bit and save into memory
            -- for j in 1 to 32 loop        
                -- char := line_content(j);
                -- if(char = '0') then
                    -- data_mem(i)(32-j) <= '0';
                -- else
                    -- data_mem(i)(32-j) <= '1';
                -- end if; 
            -- end loop;
            -- i := i + 1;
        -- end loop;
        -- if i > 0 then
            -- last_instr_address <= std_logic_vector(to_unsigned((i-1)*4, last_instr_address'length));
        -- else
            -- last_instr_address <= "00000000000000000000000000000000";
        -- end if;

        -- file_close(file_pointer); -- Close the file 
        -- wait; -- ( ͡° ͜ʖ ͡°)
    -- end process;

    -- -- Since the registers are in multiples of 4 bytes, we can ignore the last two bits
    -- instructionOut <= data_mem(to_integer(unsigned(readAddress(31 downto 2))));

-- end behavioral;
