
library IEEE;
use IEEE.STD_LOGIC_1164.ALL;

entity Processor is
	generic (data_width: positive := 8;			-- Datenbreite
				cmd_width: positive := 18; 			-- Befehlsbreite
				cmd_addr_width: positive := 10; 	-- Adressbreite des Befehlsspeichers
				stack_addr_width: positive := 5);
	port ( 	Clk 	: in  STD_LOGIC;
			Reset 	: in  STD_LOGIC;
       		Out_port : out STD_LOGIC_VECTOR (data_width - 1 downto 0));
end Processor;


architecture Structural of Processor is

	component InstructionFetchUnit is
		generic (	cmd_width: positive; -- Befehlsbreite
					cmd_addr_width: positive); -- Adressbreite des Befehlsspeichers
		port (-- Datenleitungen
				JumpAddress: in STD_LOGIC_VECTOR (cmd_addr_width - 1 downto 0); -- Sprungadresse
				Instruction: out STD_LOGIC_VECTOR (cmd_width - 1 downto 0); -- naechster Befehl
				-- Steuerleitungen
				Clk: in STD_LOGIC; -- Takt
				WriteEnable: in STD_LOGIC; -- Schreibfreigabe des Befehlszaehlers
				LoadStartAddress: in STD_LOGIC; -- Startadresse laden
				LoadJumpAddress: in STD_LOGIC; -- Sprungadresse laden
				RestoreCmdAddress: in STD_LOGIC; -- Laden einer Adresse vom Stack
				LoadInterruptAddress: in STD_LOGIC; -- Interrupt-Adresse laden
				SaveCmdAddress: in STD_LOGIC); -- Sichern der Befehlsadresse auf dem Stack
	end component;

	-- Signals in & out of InstructionFetchUnit
	signal s_jumpaddr_idu_ifu: STD_LOGIC_VECTOR (cmd_addr_width - 1 downto 0);
	-- ========================================


	component InstructionDecodeUnit is
		generic (	cmd_addr_width: positive; -- Adressbreite des Befehlsspeichers
					cmd_width: positive; -- Befehlsbreite (> 17)
					data_width: positive); -- Datenbreite
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
	end component;

	-- Signals in & out of InstructionDecodeUnit
	signal s_address_idu_dmu: STD_LOGIC_VECTOR (cmd_addr_width - 1 downto 0);
	signal s_iebit_idu: STD_LOGIC;
	signal s_op1: STD_LOGIC_VECTOR (data_width - 1 downto 0);
	signal s_op2: STD_LOGIC_VECTOR (data_width - 1 downto 0);
	signal s_shiftcode: STD_LOGIC_VECTOR (3 downto 0);
	-- ========================================

	component ControlUnit is
		port (-- Datenleitungen
			  CarryIn: in STD_LOGIC; -- Eingang des Carry-Flags
			  CarryOut: out STD_LOGIC; -- Ausgang des Carry-Flags
			  ZeroIn: in STD_LOGIC; -- Eingang des Zero-Flags
			  IEIn: in STD_LOGIC; -- Eingang des Interrupt-Enab1e-Flags
			  -- Steuerleitungen
			  Clk: in STD_LOGIC; -- Takt
			  Reset: in STD_LOGIC; -- Ruecksetzen
			  Interrupt: in STD_LOGIC; -- Interrupt-Eingang
			  InterruptAck: out STD_LOGIC; -- Bestatigung einer Unterbrechung
			  OpCode: in STD_LOGIC_VECTOR (4 downto 0); -- Kodierung des Befehls
			  Condition: in STD_LOGIC_VECTOR (2 downto 0); -- Sprungbedingung
			  InternalReset: out STD_LOGIC; -- im Prozessor benutztes Reset-Signal
			  PCWrite: out STD_LOGIC; -- Schreibfreigabe des Befehlszahlers
			  LoadJumpAddress: out STD_LOGIC; -- Sprungadresse laden
			  LoadInterruptAddress: out STD_LOGIC; -- Laden der Interrupt-Adresse
			  SaveCmdAddress: out STD_LOGIC; -- Sichern der Befehlsadresse auf dem Stack
			  RestoreCmdAddress: out STD_LOGIC; -- Laden einer Adresse vom Stack
			  Regwrite: out STD_LOGIC; -- Schreibfreigabe des Registersatzes
			  Memwrite: out STD_LOGIC; -- Schreibfreigabe des Datenspeichers
			  IOStrobe: out STD_LOGIC); -- Steuersignal fur den Hardwarezugriff
	end component;

	-- Signals in & out of ControlUnit
	signal s_ci_alu_cu: STD_LOGIC;
	signal s_co_alu_cu: STD_LOGIC;
	signal s_zi_alu_cu: STD_LOGIC;
	signal s_interruptack_cu: STD_LOGIC;
	signal s_opcode_cu: STD_LOGIC_VECTOR (4 downto 0);
	signal s_condition_idu_cu: STD_LOGIC_VECTOR (2 downto 0);
	signal s_internalreset_cu_alu: STD_LOGIC;
	signal s_we_cu: STD_LOGIC;
	signal s_loadjumpaddr_cu_ifu: STD_LOGIC;
	signal s_loadintaddr_cu: STD_LOGIC;
	signal s_savecmdaddr_cu_ifu: STD_LOGIC;
	signal s_restorecmdaddr_cu_ifu: STD_LOGIC;
	signal s_regwrite_cu_idu: STD_LOGIC;
	signal s_memwrite_cu_dmu: STD_LOGIC;
	signal s_iostrobe_cu_hau: STD_LOGIC;
	-- ========================================

	component ArithmeticLogicUnit is
	generic (	data_width : positive;
				cmd_width: positive);
    	port ( 	A : in  STD_LOGIC_VECTOR (data_width - 1 downto 0);
	           	B : in  STD_LOGIC_VECTOR (data_width - 1 downto 0);
	           	Instruction: in STD_LOGIC_VECTOR (cmd_width - 1 downto 0);
	           	Clk : in  STD_LOGIC;
					Reset : in  STD_LOGIC;
	           	-- ShiftCode : in  STD_LOGIC_VECTOR (3 downto 0);
	           	-- OpCode : in  STD_LOGIC_VECTOR (4 downto 0);
	           	Result : out  STD_LOGIC_VECTOR (data_width - 1 downto 0);
	           	ZF : out  STD_LOGIC;
	           	CF : out  STD_LOGIC);
	end component;
	-- ========================================

	component DataMemoryUnit is
		generic (	addr_width: positive; -- Adressbreite
					data_width: positive); -- Datenbreite
		port (	Addr: in STD_LOGIC_VECTOR (addr_width - 1 downto 0); -- Adresse
				DI: in STD_LOGIC_VECTOR (data_width - 1 downto 0); -- Dateneingang
				DO: out STD_LOGIC_VECTOR (data_width - 1 downto 0); -- Datenausgang
				Clk: in STD_LOGIC; -- Takt
				WE: in STD_LOGIC); -- Schreibfreigabe
	end component;
	-- ========================================

	component HardwareAccessUnit is
		generic (data_width: positive); -- Datenbreite
		port (	-- Datenleitungen
				OPERAND_1: in STD_LOGIC_VECTOR (data_width - 1 downto 0); -- Operand 1
				OPERAND_2: in STD_LOGIC_VECTOR (data_width - 1 downto 0); -- Operand 2
				RESULT: out STD_LOGIC_VECTOR (data_width - 1 downto 0); -- Ergebnis
				-- Ports
				IN_PORT: in STD_LOGIC_VECTOR (data_width - 1 downto 0); -- Dateneingang
				PORT_ID: out STD_LOGIC_VECTOR (data_width - 1 downto 0); -- Hardware-Adresse
				OUT_PORT: out STD_LOGIC_VECTOR (data_width - 1 downto 0); -- Datenausgang
				-- Steuerleitungen
				CLK: in STD_LOGIC; -- Takt
				WAIT_CNTRL: in STD_LOGIC; -- Abarbeitungszyklus verlaengern
				Strobe: out STD_LOGIC; -- Lese- oder Schreibsteuerung
				READ_STROBE: out STD_LOGIC; -- Lesesteuerung
				WRITE_STROBE: out STD_LOGIC; -- Schreibsteuerung
				OP_CODE: in STD_LOGIC); -- Bits 17 des Befehlskodes
										-- 0 -> INPUT
										-- 1 -> OUTPUT
	end component;
	-- Signals
	signal s_strobe_hau: STD_LOGIC;
	signal s_rstrobe_hau: STD_LOGIC;
	signal s_wstrobe_hau: STD_LOGIC;
	-- ========================================



	-- DATENPFAD-UMSCHALTER
	-- Instruction for IDU and IFU
	signal instruction: STD_LOGIC_VECTOR (cmd_width - 1 downto 0);
	-- Ergebnis der Verarbeitung
	signal computation_result: STD_LOGIC_VECTOR (data_width - 1 downto 0);
	-- Ergebnis des Speicherzugriffes
	signal memory_result: STD_LOGIC_VECTOR (data_width - 1 downto 0);
	-- Ergebnis des Hardwarezugriffes
	signal io_result: STD_LOGIC_VECTOR (data_width - 1 downto 0);

	-- Steuersignale fur die Multiplexer im Datenpfad
	signal d_mux_control_1: STD_LOGIC;
	signal d_mux_control_2: STD_LOGIC;
	signal d_mux_control_3: STD_LOGIC;

	-- 2-zu-1 Multiplexer
	component Multiplexer_2_to_1
		port (	A: in STD_LOGIC;
				B: in STD_LOGIC;
				Y: out STD_LOGIC;
				S: in STD_LOGIC);
	end component Multiplexer_2_to_1;

	-- Ausgangssignale der Multiplexer im Datenpfad
	signal d_mux_out_1: STD_LOGIC_VECTOR (data_width - 1 downto 0);
	signal d_mux_out_2: STD_LOGIC_VECTOR (data_width - 1 downto 0);
	-- Ergebnis des Ausfuhrungsschrittes
	signal result: STD_LOGIC_VECTOR (data_width - 1 downto 0);

	-- ===============================================================
	begin
	CU: ControlUnit
		port map (-- Datenleitungen
			  CarryIn => s_ci_alu_cu, -- Eingang des Carry-Flags
			  CarryOut => s_co_alu_cu, -- Ausgang des Carry-Flags
			  ZeroIn => s_zi_alu_cu, -- Eingang des Zero-Flags
			  IEIn => '0', -- Eingang des Interrupt-Enable-Flags
			  -- Steuerleitungen
			  Clk => Clk, -- Takt
			  Reset => Reset, -- Ruecksetzen
			  Interrupt => '0', -- Interrupt-Eingang
			  InterruptAck => s_interruptack_cu, -- Bestatigung einer Unterbrechung
			  OpCode => s_opcode_cu, -- Kodierung des Befehls
			  Condition => s_condition_idu_cu, -- Sprungbedingung
			  InternalReset => s_internalreset_cu_alu, -- im Prozessor benutztes Reset-Signal
			  PCWrite => s_we_cu, -- Schreibfreigabe des Befehlszahlers
			  LoadJumpAddress => s_loadjumpaddr_cu_ifu, -- Sprungadresse laden
			  LoadInterruptAddress => s_loadintaddr_cu, -- Laden der Interrupt-Adresse
			  SaveCmdAddress => s_savecmdaddr_cu_ifu, -- Sichern der Befehlsadresse auf dem Stack
			  RestoreCmdAddress => s_restorecmdaddr_cu_ifu, -- Laden einer Adresse vom Stack
			  Regwrite => s_regwrite_cu_idu, -- Schreibfreigabe des Registersatzes
			  Memwrite => s_memwrite_cu_dmu, -- Schreibfreigabe des Datenspeichers
			  IOStrobe => s_iostrobe_cu_hau); -- Steuersignal fur den Hardwarezugriff

	IFU: InstructionFetchUnit
		generic map (	cmd_width => cmd_width,
						cmd_addr_width => cmd_addr_width)
		port map (-- Datenleitungen
				JumpAddress => s_address_idu_dmu, -- Sprungadresse
				Instruction => instruction, -- naechster Befehl
				-- Steuerleitungen
				Clk => Clk, -- Takt
				WriteEnable => s_we_cu, -- Schreibfreigabe des Befehlszaehlers
				LoadStartAddress => s_internalreset_cu_alu, -- Startadresse laden
				LoadJumpAddress => s_loadjumpaddr_cu_ifu, -- Sprungadresse laden
				RestoreCmdAddress => s_restorecmdaddr_cu_ifu, -- Laden einer Adresse vom Stack
				LoadInterruptAddress => s_loadintaddr_cu, -- Interrupt-Adresse laden
				SaveCmdAddress => s_savecmdaddr_cu_ifu); -- Sichern der Befehlsadresse auf dem Stack

	IDU: InstructionDecodeUnit
		generic map (	cmd_addr_width => cmd_addr_width, -- Adressbreite des Befehlsspeichers
						cmd_width => cmd_width, -- Befehlsbreite (> 17)
						data_width => data_width) -- Datenbreite
		port map (-- Datenleitungen
				Instruction => instruction, -- Befehl
				Address => s_address_idu_dmu, -- Sprungziel
				IEBit => s_iebit_idu, -- Interrupt-Enable-Bit
				Operand1 => s_op1, -- 1. Operand
				Operand2 => s_op2, -- 2. Operand
				Result => result, -- Ergebnis der Verarbeitung
			  -- Steuerleitungen
				Clk => Clk, -- Takt fur Registersatz
				WriteEnable => s_we_cu, -- Schreibfreigabe fur Registersatz
				OpCode => s_opcode_cu, -- Kodierung des Befehls
				ShiftCode => s_shiftcode, -- Kodierung des Schiebe- und Rotationsbefehls
				Condition => s_condition_idu_cu);  -- Sprungbedingung

	ALU: ArithmeticLogicUnit
		generic map (	data_width => data_width,
							cmd_width => cmd_width) -- Datenbreite
		port map ( 	A => s_op1,
		           	B => s_op2,
		           	Instruction => instruction,
		           	Clk => Clk,
					Reset => s_internalreset_cu_alu,
		           	Result => computation_result,
		           	ZF => s_zi_alu_cu,
		           	CF => s_ci_alu_cu);


	DMU: DataMemoryUnit
		generic map (	addr_width => cmd_addr_width, -- Adressbreite
						data_width => data_width) -- Datenbreite
		port map (	Addr => s_address_idu_dmu, -- Adresse
					DI => memory_result, -- Daceneingang
					DO => Out_port, -- Datenausgang
					Clk => Clk, -- Takt
					WE => s_we_cu); -- Schreibfreigabe


	HAU: HardwareAccessUnit
		generic map (	data_width => data_width) -- Datenbreite
		port map (	-- Datenleitungen
					OPERAND_1 => s_op1, -- Operand 1
					OPERAND_2 => s_op2, -- Operand 2
					RESULT => io_result, -- Ergebnis
					-- Ports
					IN_PORT => "1X1X1X1X", -- Dateneingang
					PORT_ID => s_op2, -- Hardware-Adresse
					OUT_PORT => s_op1, -- Datenausgang
					-- Steuerleitungen
					CLK => Clk, -- Takt
					WAIT_CNTRL => s_iostrobe_cu_hau, -- Abarbeitungszyklus verlaengern
					Strobe => s_strobe_hau, -- Lese- oder Schreibsteuerung
					READ_STROBE => s_rstrobe_hau, -- Lesesteuerung
					WRITE_STROBE => s_wstrobe_hau, -- Schreibsteuerung
					OP_CODE => s_opcode_cu(4)); -- Bits 17 des Befehlskodes
												-- 0 -> INPUT
												-- 1 -> OUTPUT


	-- Multiplexer fur den Datenpfad
	d_mux_control_1 <= instruction(cmd_width - 5);
	d_mux_control_2 <= instruction(cmd_width - 2) or
						not instruction(cmd_width - 4);
	d_mux_control_3 <= instruction(cmd_width - 1) xor
						(instruction(cmd_width - 2) or instruction(cmd_width - 3));
	G_MUX: for i in result'RANGE generate
		D_MUX_1: Multiplexer_2_to_1
		port map ( 	A => io_result(i),
					B => memory_result(i),
					Y => d_mux_out_1(i),
					S => d_mux_control_1);
		D_MUX_2: Multiplexer_2_to_1
		port map ( 	A => d_mux_out_1(i),
					B => s_op2(i),
					Y => d_mux_out_2(i),
					S => d_mux_control_2);
		D_MUX_3: Multiplexer_2_to_1
		port map ( 	A => d_mux_out_2(i),
					B => computation_result(i),
					Y => result(i),
					S => d_mux_control_3);
	end generate G_MUX;
	
	Out_port <= result;
end Structural;