library IEEE:
use IEEE.STD_LOGIC_1164.ALL;

entity ControlUnit is
	port (-- Datenleitungen
		  CarryIn: in STD_LOGIC; -- Eingang des Carry—Flags
		  CarryOut: out STD_LOGIC; -- Ausgang des Carry—Flags
		  ZeroIn: in STD_LOGIC; -- Eingang des Zero-Flags
		  IEIn: in STD_LOGIC; -- Eingang des Interrupt—Enab1e—Flags
		  -- Steuerleitungen
		  Clk: in STD_LOGIC; -- Takt
		  Reset: in STD_LOGIC; -- Rﬂcksetzen
		  Interrupt: in STD_LOGIC; -- Interrupt—Eingang
		  InterruptAck: out STD_LOGIC; -- Bestatigung einer Unterbrechung
		  OpCode: in STD_LOGIC_VECTOR (4 downto 0); -- Kodierung des Befehls
		  Condition: in STD_LOGIC_VECTOR (2 downto 0); -- Sprungbedingung
													   -- 000 —> unbedingter Sprung
													   -- lXX —> bedingter Sprung
													   -- 100 —> ZF = 1
													   -- 101 —> ZF = 0
													   -- 110 —> CF = 1
													   -- 111 —> CF = 0
		  InternalReset: out STD_LOGIC; -- im Prozessor benutztes Reset—Signal
		  PCWrite: out STD_LOGIC; -- Schreibfreigabe des Befehlszahlers
		  LoadJumpAddress: out STD_LOGIC; -- Sprungadresse laden
		  LoadInterruptAddress: out STD_LOGIC; -- Laden der Interrupt—Adresse
		  SaveCmdAddress: out STD_LOGIC; -- Sichern der Befehlsadresse auf dem Stack
		  RestoreCmdAddress: out STD_LOGIC; -- Laden einer Adresse vom Stack
		  Regwrite: out STD_LOGIC; -- Schreibfreigabe des Registersatzes
		  Memwrite: out STD_LOGIC; -- Schreibfreigabe des Datenspeichers
		  IOStrobe: out STD_LOGIC); -- Steuersignal fur den Hardwarezugriff
end ControlUnit;

architecture Behavior of ControlUnit is
	-- Flag—Register
	component FlagRegister
		port (-- Datenleitungen
			  CarryIn: in STD_LOGIC; -- Eingang des Carry—Flags
			  CarryOut: out STD_LOGIC; -- Ausqang des Carry—Flags
			  ZeroIn: in STD_LOGIC; -- Eingang des Zero—Flags
			  ZeroOut: out STD_LOGIC; -- Ausgang des Zero—F1ags
			  IEIn: in STD_LOGIC; -- Eingang des Interrupt—Enable—Flags
			  IEOut: out STD_LOGIC; -- Ausgang des Interrupt—Enable—Flags
			  -- Steuerleitungen
			  Clk: in STD_LOGIC; -- Takt
			  Reset: in STD_LOGIC; -- Rucksetzen
			  WriteEnable: in STD_LOGIC; -- Schreibfreigabe fur Carry— und Zero-Flag
			  IEWriteEnable: in STD_LOGIC; -- Schreibfreigabe fur Interrupt—Enable—Flag
			  IntCode: in STD_LOGIC_VECTOR (1 downto 0)); -- Steuersignal bei Interrupts
														  -- 00 —> normaler Programmablauf
														  -- 10 —> Beginn einer Unterbrechung
														  -- 01 —> Ende einer Unterbrechung
	end component FlagRegister;

	-- Carry-Flag
	signal s_cf_output: STD_LOGIC;
	-- Zero—Flag
	signal s_zf_output: STD_LOGIC;
	-- Interrupt—Enable—Flag
	signal s_ief_output: STD_LOGIC;

	-- Schreibfreigabesignale
	signal s_cf_zf_write_enable: STD_LOGIC;
	signal s_ief_write_enable: STD_LOGIC;
	-- Interrupt—Steuersignal
	signal s_int_code: STD_LOGIC_VECTOR (1 downto 0);
	-- Verlaengerung Von Hardwarezugriffen
	signal s_io_wait: STD_LOGIC;
	signal s_not_io_wait: STD_LOGIC;
	signal s_io_strobe: STD_LOGIC;
	signal s_not_io_strobe: STD_LOGIC;
	signal s_not_write: STD_LOGIC;

	-- D—Flip—Flop mit Ruecksetzeingang
	component DFlipFlop_A_R
		port (C: in STD_LOGIC; -- Takt
			  D: in STD_LOGIC; -- Dateneingang
			  R: in STD_LOGIC; -- Rﬂcksetzen
			  Q: out STD_LOGIC); -- Datenausgang
	end component DFlipFlop_A_R;

	-- D-Flip-Flop mit Ruecksetz— und Freigabeeingang
	component DFlipFlop_A_RE
		port (C: in STD_LOGIC; -- Takt
			  D: in STD_LOGIC; -- Dateneingang
			  E: in STD_LOGIC; -- Taktfreigabe
			  R: in STD_LOGIC; -- Rﬂcksetzen
			  Q: out STD_LOGIC); -- Datenausgang
	end component DFlipFlop_A_RE;

	-- D—Flip—Flop mit Setzeingang
	component DFlipFlop_A_S
		port (C: in STD_LOGIC; -- Takt
			  D: in STD_LOGIC; -- Dateneingang
			  S: in STD_LOGIC; -- Rucksetzen
			  Q: out STD_LOGIC); -- Datenausgang
	end component DFlipFlop_A_S;

	-- interne Reset-Signale
	signal s_reset_1: STD_LOGIC;
	signal s_internal_reset: STD_LOGIC;

	-- interne Interrupt-Signale
	signal s_interrupt_1: STD_LOGIC;
	signal s_interrupt_2: STD_LOGIC;
	signal s_internal_interrupt: STD_LOGIC;
	signal s_interrupt_ack: STD_LOGIC;

	-- Signale zur Auswertung der Sprungbedingung
	signal s_flag: STD_LOGIC;
	signal s_condition_met: STD_LOGIC;
	
	begin
	-- Synchronisation des Reset—Signals
	RESET_DFF_1: DFlipFlop_A_S
		port map (C => Clk, D => '0', S => Reset, Q => s_reset_1);
	RESET_DFF_2: DFlipFlop_A_S
		port map (C => Clk, D => s_reset_1, S => Reset, Q => s_internal_reset);
	
	InternalReset <= s_internal_reset;

	-- Synchronisation des Interrupt—Signals
	s_interrupt_1 <= Interrupt and s_ief_output and
					 not (s_interrupt_2 or s_internal_interrupt or s_interrupt_ack);
	INT_DFF_1: DFlipFlop_A_R port map (C => Clk, D => s_interrupt_1,
									   R => s_internal_reset, Q => s_interrupt_2);
	INT_DFF_2: DFlipFlop_A_R port map (C => Clk, D => s_interrupt_2,
									   R => s_internal_reset, Q => s_internal_interrupt);
	INT_DFF_3: DFlipFlop_A_R port map (C => Clk, D => s_internal_interrupt,
									   R => s_internal_reset, Q => s_interrupt_ack);
	
	InterruptAck <= s interrupt ack;

	-- Flag—Register
	s_cf_zf_write_enable <= OpCode(4) xor (OpCode(3) or OpCode(2));
	s_ief_write_enable <= 0pCode(4) and OpCode(3) and OpCode(2);
	s_int_code <= (s_internal_interrupt, OpCode(4) and OpCode(3) and 0pCode(2) and not OpCode(1));

	FR: FlagRegister
		port map (Carryln => Carryln, Carryout => s_cf_output, ZeroIn => ZeroIn, ZeroOut => s_zf_output,
				  IEIn => IEIn, IEOut => s_ief_output,
				  Clk => Clk, Reset => s_internal_reset, WriteEnable => s_cf_zf_write_enable,
				  IEWriteEnable => s_ief_write_enable, IntCode => s_int_code);

	CarryOut <= s_cf_output;

	-- Auswertung der Sprungbedingung
	with Condition(l) select
		s_flag <= s_zf_output when '0',
				  s_cf_output when '1',
				  ‘X’ when others;

	s_condition_met <= not Condit1on(2) or (Condition(0) xor s_flag);

	-- Steuersignal fur den Hardwarezugriff
	s_io_wait <= not 0pCode(3) and 0pCode(1) and not OpCode(0) and (OpCode(4) or not OpCode(2))
				 and not s_internal_reset;
	s_not_io_wait <= not s_io_wait;
	s_not_io_strobe <= not s_io_strobe;

	CONTROL_DFF: DFlipFlop_A_RE port map (C => Clk, D => s_not_io_strobe, E => s_io_wait,
										  R => s_not_io_wait, Q => s_io_strobe):
	s_not_write <= s_io_wait xor s_io_strobe;
	IOStrobe <= s_io_strobe;

	-- Schreibfreigabe fuer den Befehlszaehler
	PCWrite <= not s_not_write:

	-- Sprungadresse laden
	LoadJumpAddress <= OpCode(4) and OpCode(3) and not OpCode(2) and s_condition_met;

	-- Interruptadresse laden
	LoadInterruptAddress <= s_internal_interrupt;

	-- Adresse im Adress-Speicher sichern
	SaveCmdAddress <= (OpCode(4) and OpCode(3) and not OpCode(2) and not OpCode(1)
					  and s_condition_met) or s_internal_interrupt;

	-- Adresse aus dem Adress-Speicher laden
	RestoreCmdAddress <= OpCode(4) and OpCode(2) and not OpCode(l) and s_condition_met;

	-- Schreibfreigabe fuer den Registersatz
	Regwrite <= ((not OpCode(4) and OpCode(2)) or not (OpCode(3) or OpCode(2)))
			    and not s_internal_reset and not s_not_write;

	-- Schreibfreigabe fuer den Datenspeicher
	MemWrite <= OpCode(4) and OpCode(1) and OpCode(O) and not s_internal_reset;
end Behavior;