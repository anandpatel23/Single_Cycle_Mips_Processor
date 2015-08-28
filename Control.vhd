------------------------------------
-- Component: Control
-- Trey Harper
-- Single Cycle MIPS Processor
------------------------------------

library IEEE;
use IEEE.STD_LOGIC_1164.ALL;

entity Control is
port(
		
		opcode : in std_logic_vector(5 downto 0);
		RegDst, Jump, Branch, MemRead, MemtoReg, MemWrite, ALUSrc, RegWrite : out std_logic;
		alu_op : out std_logic_vector(1 downto 0));
	
end control;

architecture beh of Control is

begin
process(opcode)
begin

if opcode = "000000" then -- R type

RegDst <= '1';
Branch <= '0';
MemRead <= '0';
MemtoReg <= '0';
alu_op(0) <= '0';
alu_op(1) <= '1';
MemWrite <= '0';
ALUSrc <= '0';
RegWrite <= '1';
Jump <= '0';

elsif opcode = "100011" then -- lw 

RegDst <= '0';
Branch <= '0';
MemRead <= '1';
MemtoReg <= '1';
alu_op(0) <= '0';
alu_op(1) <= '0';
MemWrite <= '0';
ALUSrc <= '1';
RegWrite <= '1';
Jump <= '0';

elsif opcode = "101011" then -- sw

RegDst <= 'U';
Branch <= '0';
MemRead <= '0';
MemtoReg <= 'U';
alu_op(0) <= '0';
alu_op(1) <= '0';
MemWrite <= '1';
ALUSrc <= '1';
RegWrite <= '0';
Jump <= '0';

elsif opcode = "000100" then -- beq

RegDst <= 'U';
Branch <= '1';
MemRead <= '0';
MemtoReg <= '0';
alu_op(0) <= '1';
alu_op(1) <= '0';
MemWrite <= '0';
ALUSrc <= '0';
RegWrite <= '0';
Jump <= '0';

elsif opcode = "000010" then -- jump

RegDst <= 'U';
Branch <= '0';
MemRead <= '0';
MemtoReg <= 'U';
alu_op(0) <= 'U';
alu_op(1) <= 'U';
MemWrite <= '0';
ALUSrc <= 'U';
RegWrite <= '0';
Jump <= '1';

else

end if;
end process;
end beh;