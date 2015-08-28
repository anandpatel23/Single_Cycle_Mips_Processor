-----------------------------------------------------------
-- Component: ALU Control Unit
-- Engineer: Anand Patel
-- description: 
--
-----------------------------------------------------------

LIBRARY IEEE;
USE IEEE.STD_LOGIC_1164.ALL;
USE IEEE.STD_LOGIC_ARITH.ALL;
USE IEEE.STD_LOGIC_UNSIGNED.ALL;
USE IEEE.STD_LOGIC_SIGNED.ALL;

entity ALU_Control is
	port(
		funct: in std_logic_vector(5 downto 0);
		alu_op: in std_logic_vector(1 downto 0);
		alu_control_out: out std_logic_vector(3 downto 0));
		
end ALU_Control;

architecture structure of ALU_Control is
begin
	process(alu_op)
	begin
		case alu_op is
			when "00" =>
				alu_control_out <= "0010";
			when "01" =>
				alu_control_out <= "0110";
			when "10" =>
				case funct is
					when "100000" => 
						alu_control_out <= "0010";
					when "100010" => 
						alu_control_out <= "0110";
					when "100100" => 
						alu_control_out <= "0000";
					when "100101" => 
						alu_control_out <= "0001";
					when "101010" => 
						alu_control_out <= "0111";
					when others => 
						alu_control_out <= "UUUU";
				end case;
			when others => alu_control_out <= "UUUU";
		end case;
	end process;
end structure;