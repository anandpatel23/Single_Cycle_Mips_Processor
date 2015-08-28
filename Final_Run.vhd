LIBRARY IEEE;
USE IEEE.STD_LOGIC_1164.ALL;
USE IEEE.STD_LOGIC_ARITH.ALL;
USE IEEE.STD_LOGIC_UNSIGNED.ALL;


entity Final_Run is

	port(ck : in std_logic);
	
end Final_Run;

architecture beh of Final_Run is
type my_state is (LOADING,RUNNING,DONE);
signal n_s: my_state := LOADING;
signal en:std_logic := '0';
signal count:integer:=0;


	component control is
	port(opcode : in std_logic_vector(5 downto 0);
		RegDst, Jump, Branch, MemtoReg, MemWrite, ALUSrc, RegWrite, MemRead: out std_logic;
		alu_op : out std_logic_vector(1 downto 0));
	end component;
	
	component adder is
	port(x,y : in std_logic_vector(31 downto 0);
		z : out std_logic_vector(31 downto 0));
	end component;
	
	component Shift_left_2 is
	generic(n:natural := 32);
	port(x : in std_logic_vector(n-1 downto 0);
		y : out std_logic_vector(n-1 downto 0));
	end component;
	
	component instructionMemory is
	port(readAddress : in std_logic_vector(31 downto 0);
		instructionOut : out std_logic_vector(31 downto 0));
		--last_instr_address: out std_logic_vector(31 downto 0));
	end component;
	
	component sign_extension is
	port(vector_in : in std_logic_vector(15 downto 0);
		vector_out : out std_logic_vector(31 downto 0));
	end component;
	
	component ALU_Control is
	port(funct: in std_logic_vector(5 downto 0);
		alu_op: in std_logic_vector(1 downto 0);
		alu_control_out: out std_logic_vector(3 downto 0));
	end component;
	
	component MUX is
	port(X,Y : in std_logic_vector(31 downto 0);
		S : in std_logic;
		Z : out std_logic_vector(31 downto 0));
	end component;
	
	component program_counter is
	port(input_mem_address : in std_logic_vector(31 downto 0);
		output_mem_address: out std_logic_vector(31 downto 0);
		ck : in std_logic);
	end component;
	
	component ALU is
	port(x : in std_logic_vector(31 downto 0);
		y : in std_logic_vector(31 downto 0);
		sel_4_bit : in std_logic_vector(3 downto 0);
		result : out std_logic_vector(31 downto 0);
		zero_flag : out std_logic);
	end component;
	
	component Registers is
	port(ck, RegWrite: in std_logic;
		Read_Reg1, Read_Reg2, Write_Reg: in std_logic_vector(4 downto 0);
		Read_Data1, Read_Data2: out std_logic_vector(31 downto 0);
		Write_Data: in std_logic_vector(31 downto 0));
	end component;
	
	component ShiftLeft2Jump is
	generic(n:natural := 32);
	port(X : in std_logic_vector(n-7 downto 0);
		A : in std_logic_vector(3 downto 0);
		Y : out std_logic_vector(n-1 downto 0));
	end component;
	
	component MUX5 is
	port(input_1,input_2 : in std_logic_vector(4 downto 0);
		G : in std_logic;
		output : out std_logic_vector(4 downto 0));
	end component;
	
	component memory is
	port (
		address, write_data: in STD_LOGIC_VECTOR (31 downto 0);
		MemWrite, MemRead,ck: in STD_LOGIC;
		read_data: out STD_LOGIC_VECTOR (31 downto 0));
	end component;
	
	
	signal instructionOut:std_logic_vector(31 downto 0); -- 32 bit Instruction input
	signal next_instruction_address:std_logic_vector(31 downto 0); -- Next Address
	signal jump_address:std_logic_vector(25 downto 0);
	signal jump_address_shift:std_logic_vector(31 downto 0);
	signal immediate:std_logic_vector(15 downto 0);
	signal alu_op:std_logic_vector(1 downto 0); -- ALU control output
	signal opcode:std_logic_vector(5 downto 0);
	signal Write_Reg: std_logic_vector(4 downto 0);
	signal RegDst, Jump, Branch, MemtoReg, MemWrite, ALUSrc,RegWrite,MemRead:std_logic := '0'; -- Control signal output
	signal zero_flag:std_logic := '0';
	signal Read_Data1, Read_Data2, Write_Data:std_logic_vector(31 downto 0);
	signal result:std_logic_vector(31 downto 0);
	signal rs,rt,rd,shamt:std_logic_vector(4 downto 0);
	signal funct:std_logic_vector(5 downto 0);
	signal alu_control_out:std_logic_vector(3 downto 0);
	signal instruction_address:std_logic_vector(31 downto 0); -- Address of instruction
	signal next_address:std_logic_vector(31 downto 0);
	signal immediate_sign_extended:std_logic_vector(31 downto 0);
	signal ALU_input:std_logic_vector(31 downto 0);
	signal Read_Data_Memory:std_logic_vector(31 downto 0);
	signal mux_PC_and_adder:std_logic_vector(31 downto 0);
	signal add_shift_2_and_PC:std_logic_vector(31 downto 0);
	signal shifted_sign_extension:std_logic_vector(31 downto 0);
	signal branch_zero_and_gate:std_logic := '0';
	signal concatenated_jump_address:std_logic_vector(31 downto 0);



	begin
	process(ck)
	begin
	
	case n_s is
		when RUNNING => 
			en <= ck;
		when others =>
			en <= '0';
	end case;
	
	if ck = '1' and ck'event then
		case n_s is
			when LOADING =>
				n_s <= RUNNING;
			when RUNNING => 
				count <= count + 1;
				if count = 7 then
				n_s <= DONE;
				en <= '0';
				end if;
			when others => 
				null;
		end case;
	end if;
				
	end process;
	
	-- Instruction Formats for R,I,J
	opcode <= instructionOut(31 downto 26);
	rs <= instructionOut(25 downto 21);
	rt <= instructionOut(20 downto 16);
	rd <= instructionOut(15 downto 11);
	shamt <= instructionOut(10 downto 6);
	funct <= instructionOut(5 downto 0);
	immediate <= instructionOut(15 downto 0);
	jump_address <= instructionOut(25 downto 0);
	

	-- Program Counter
	pc: program_counter 
		port map(next_instruction_address,instruction_address,en);
		
	-- Instruction Memory taking PC as read address and outputting instruction
	IM: instructionMemory
		port map(instruction_address,instructionOut);
	
	-- Adder taking Program Counter Address and 4 as inputs
	PC_adder: adder generic map(32)
		port map(x => instruction_address,
				y => "00000000000000000000000000000100",
				z => next_instruction_address);
				
	-- Shift left by 2 component taking instruction[25-0] as input
	Shift_jump: ShiftLeft2Jump generic map(32)
		port map(X => instructionOut(25 downto 0),
				A => mux_PC_and_adder(31 downto 28),
				Y => jump_address_shift);
	
	-- MUX taking PC + 4[31-28] and ALU Result Adder as inputs
	branch_zero_and_gate <= branch_zero_and_gate;
	MUX1: MUX generic map(32)
	port map(X => next_instruction_address,
			Y => add_shift_2_and_PC,
			S => branch_zero_and_gate,
			Z => mux_PC_and_adder);
	
	-- MUX taking ALU Result Adder and Shifted Jump Address as inputs
	concatenated_jump_address <= next_instruction_address(31 downto 28) & jump_address_shift(27 downto 0);
	MUX2: MUX generic map(32)
		port map(X => mux_PC_and_adder,
				Y => concatenated_jump_address,
				S => Jump,
				Z => next_address);
	
	-- Shift left 2 taking Sign extended instruction as input
	Shift_sign_extension: Shift_left_2
		port map(x => immediate_sign_extended,
				y => shifted_sign_extension);
	
	-- Adder taking shift left 2 sign extension and PC as inputs
	Adder_ALU_result: adder generic map(32)
		port map(x => next_instruction_address,
			y => shifted_sign_extension,
			z => add_shift_2_and_PC);
	

	
	-- Control taking opcode as input and outputting control lines
	Control_unit: Control
		port map(opcode => opcode,
			RegDst => RegDst,
			Branch => Branch,
			MemRead => MemRead,
			MemtoReg => MemtoReg,
			MemWrite => MemWrite,
			ALUSrc => ALUSrc,
			RegWrite => RegWrite,
			alu_op => alu_op);
			
	-- MUX taking rt and rd as inputs
	MUX3: MUX5
		port map(input_1 => rt,
			input_2 => rd,
			G => RegDst,
			output => Write_Reg);
		
	-- Register taking 4 inputs and outputting read_data1 and read_data2
	Register_comp: registers
		port map(ck => en,
			Read_Reg1 => rs,
			Read_Reg2 => rt,
			Write_Reg => Write_Reg,
			Read_Data1 => Read_Data1,
			Read_Data2 => Read_Data2,
			Write_Data => Write_Data,
			RegWrite => RegWrite);
				

		
	-- Sign extension taking immediate as input
	Sign_extension_comp: sign_extension
		port map(immediate, immediate_sign_extended);
		
	-- ALU Control taking ALUOp as input
	ALU_control_comp: ALU_Control
		port map(funct,alu_op,alu_control_out);
		
	-- MUX taking Read_data2 and sign extended instruction as inputs
	MUX4: MUX generic map(32)
		port map(X => Read_Data2,
				Y => immediate_sign_extended,
				S => ALUSrc,
				Z => ALU_input);
		
	-- ALU taking Read_data1 and result of mux4 as inputs
	ALU_comp: ALU 
		port map(Read_Data1,ALU_input,alu_control_out,result,zero_flag);
		

	
	-- MUX taking Read_Data and ALU as inputs
	MUX6: MUX generic map(32)
		port map(X => result,
				Y => Read_Data_Memory,
				S => MemtoReg,
				Z => Write_Data);
	MEM: memory 
		port map(instruction_address,Write_Data,MemWrite,MemRead,en,Read_Data_Memory);
	
end beh;