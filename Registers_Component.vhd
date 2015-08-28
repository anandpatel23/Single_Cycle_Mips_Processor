library IEEE;
use IEEE.std_logic_1164.all;
use IEEE.numeric_std.all;

entity Registers is
	port(ck, RegWrite: in std_logic;
		Read_Reg1, Read_Reg2, Write_Reg: in std_logic_vector(4 downto 0);
		Read_Data1, Read_Data2: out std_logic_vector(31 downto 0);
		Write_Data: in std_logic_vector(31 downto 0));
end Registers;

architecture beh of Registers is

type register_array is array(0 to 31) of std_logic_vector(31 downto 0);

signal register_memory: register_array := (
    X"00000000", -- initialize data memory
    X"00000000", -- mem 1
    X"00000000",
    X"00000000",
    X"00000000",
    X"00000000",
    X"00000000",
    X"00000000",
    X"00000000",
    X"00000000", 
    X"00000000", -- mem 10 
    X"00000000", 
    X"00000000",
    X"00000000",
    X"00000000",
    X"00000000",
    X"00000000",
    X"00000000",
    X"00000000",
    X"00000000",  
    X"0000000E", -- mem 20
    X"00000005",
    X"00000000",
    X"00000000",
    X"00000000", 
    X"00000000",
    X"00000000",
    X"00000000",
    X"00000000",
    X"00000000", 
    X"00000000", -- mem 30
    X"00000000");


begin

Read_Data1 <= register_memory(to_integer(unsigned(Read_Reg1)));
Read_Data2 <= register_memory(to_integer(unsigned(Read_Reg2)));

			
process(ck)
begin
if ck='0' and ck'event and RegWrite = '1' then
	--if (RegWrite = '1') then
		register_memory(to_integer(unsigned(Write_Reg))) <= Write_Data;
	--end if;

end if;
end process;
end beh;
