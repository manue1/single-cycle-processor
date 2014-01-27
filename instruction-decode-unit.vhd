library IEEE;
use IEEE.STD_LOGIC_1164.ALL;

entity InstructionDecodeUnit is
	-- for Unit simulation - test bench
	generic (cmd_addr_width: integer := 10; -- Adressbreite des Befehlsspeichers
				cmd_width: integer := 18; -- Befehlsbreite (> 17)
				data_width: integer := 8); -- Datenbreite
	-- for Processor implementation
	-- generic (cmd_addr_width: positive; -- Adressbreite des Befehlsspeichers
	-- 			cmd_width: positive; -- Befehlsbreite (> 17)
	-- 			data_width: positive); -- Datenbreite
	port (-- Datenleitungen
			Instruction: in STD_LOGIC_VECTOR (cmd_width - 1 downto 0); -- Befehl
			Address: out STD_LOGIC_VECTOR (cmd_addr_width - 1 downto 0); -- Sprungziel
			IEBit: out STD_LOGIC; -- Interrupt-Enable-Bit
			Operand1: out STD_LOGIC_VECTOR (data_width - 1 downto 0); -- 1. Operand
			Operand2: out STD_LOGIC_VECTOR (data_width - 1 downto 0); -- 2. Operand
			Result: in STD_LOGIC_VECTOR (data_width - 1 downto 0); -- Ergebnis der Verarbeitung
		  -- Steuerleitungen
			Clk: in STD_LOGIC; -- Takt fur Registersatz
			WriteEnable: in STD_LOGIC; -- Schreibfreigabe fur Registersatz
			OpCode: out STD_LOGIC_VECTOR (4 downto 0); -- Kodierung des Befehls
			ShiftCode: out STD_LOGIC_VECTOR (3 downto 0); -- Kodierung des Schiebe- und Rotationsbefehls
			Condition: out STD_LOGIC_VECTOR (2 downto 0));  -- Sprungbedingung
																			-- 000 => unbedingter Sprung
																			-- 1XX => bedingter Sprung
																			-- 100 => ZF = 1
																			-- 101 => ZF = 0
																			-- 110 => CF = 1
																			-- 111 => CF = 0
end InstructionDecodeUnit;

architecture Behavior of InstructionDecodeUnit is
	-- Adressbreite des Registersatzes [Bit]
	constant c_addr_width: positive := 4;

	-- Adresse des ersten Registers
	signal s_addr_1: STD_LOGIC_VECTOR (3 downto 0);
	-- Adresse des zweiten Registers
	signal s_addr_2: STD_LOGIC_VECTOR (3 downto 0);
	-- Konstanter Wert
	signal s_const_value: STD_LOGIC_VECTOR (7 downto 0);
	
	-- interne Register
	component D_RAM_2		-- RegisterFile
		generic (addr_width: positive; -- Adressbreite
					data_width: positive); -- Datenbreite
		port (-- Datenleitungen
				Address1: in STD_LOGIC_VECTOR (addr_width - 1 downto 0); -- Adresse des 1. Leseports
				Address2: in STD_LOGIC_VECTOR (addr_width - 1 downto 0); -- Adresse des 2. Leseports
				DataIn: in STD_LOGIC_VECTOR (data_width - 1 downto 0); -- Dateneingang des Schreibports
				DataOut1: out STD_LOGIC_VECTOR (data_width - 1 downto 0); -- Datenausgang des 1. Leseports
				DataOut2: out STD_LOGIC_VECTOR (data_width - 1 downto 0); -- Datenausgang des 2. Leseports
			  -- Steuerleitungen
				Clk: in STD_LOGIC; -- Takt
				WriteEnable: in STD_LOGIC); -- Schreibfreigabe
	end component D_RAM_2;

-- 2. Registeroperand
signal s_operand_2: STD_LOGIC_VECTOR (data_width - 1 downto 0);

	begin
		-- Befehlsdekoder
		process (Instruction)
		begin
			if (cmd_width > 17) then
				OpCode <= Instruction(17 downto 13);
				s_addr_1 <= Instruction(11 downto 8);
				s_addr_2 <= Instruction(7 downto 4);
				s_const_value <= Instruction(7 downto 0);
				ShiftCode <= Instruction(3 downto 0);
				Condition <= Instruction(12 downto 10);
				Address <= Instruction(cmd_addr_width - 1 downto 0);
				IEBit <= Instruction(0);
			end if;
		end process;

	-- Registersatz
	RF: D_RAM_2
		generic map (addr_width => c_addr_width, data_width => data_width)
		port map (Address1 => s_addr_1, Address2 => s_addr_2,
				  DataIn => Result, DataOut1 => Operand1, DataOut2 => s_operand_2,
				  Clk => Clk, WriteEnable => WriteEnable);
	-- Multiplexer fur 2. Operanden
	with (Instruction(12)) select
		  Operand2 <= s_const_value when '0',
		  s_operand_2 when '1',
		  (others => 'X') when others;
end Behavior;