library IEEE;
USE IEEE.STD_LOGIC_1164.ALL;

entity FlagRegister is
	port (	-- Datenleitungen
			Ci: in STD_LOGIC; -- Eingang de: Carry-Flags
			Co: out STD_LOGIC; -- Ausgang des Carry-Flags
			Zi: in STD_LOGIC; -- Eingang des Zero-Flags
			Zo: out STD_LOGIC; -- Ausganq des Zero-Flags
			IEi: in STD_LOGIC; -- Eingang des Interrupt-Enable-Flags
			IEo: out STD_LOGIC; -- Ausgang des Intenrupt-Enable-Flags
			-- Steuerleitungen
			Clk: in STD_LOGIC; -- Takt
			Reset: in STD_LOGIC; -- Rucksetzen
			WE: in STD_LOGIC; -- Schreibfreigabe fur carry- und Zero-Flag
			IEWE: in STD_LOGIC; -- Schreibfreigabe fur Interrupt-Enable-Flag
			IntCode: in STD_LOGIC_VECTOR (1 downto 0)); -- Steuersignal bei Interrupts
			-- 00 -> normaler Programmablauf
			-- 10 -> Beginn einer Unterbrechung
			-- 01 -> Ende ener Unterbrechung
end FlagRegister;

architecture Behavior of FlagRegister is
	-- 2 zu 1 Multiplexer
	component Multiplexer_2_to_1
		port (	A, B: in STD_LOGIC;
					Y: out STD_LOGIC;
					S: in STD_LOGIC);
	end component Multiplexer_2_to_1;

	-- D-Flip-Flop mit Ruecksetz- und Freigabeeingang
	component DFlipFlop_RE
		port (	C, D, E, R: in STD_LOGIC;
				Q: out STD_LOGIC);
	end component DFlipFlop_RE;

	-- Carry-Flag
	signal CE: STD_LOGIC;
	signal CFi: STD_LOGIC;
	signal CFo: STD_LOGIC;
	signal CFShadow: STD_LOGIC;

	-- Zero-Flag
	signal ZFi: STD_LOGIC;
	signal ZFo: STD_LOGIC;
	signal ZFShadow: STD_LOGIC;

	-- Interrupt-Enable-Flag
	signal IECE: STD_LOGIC;
	signal IEFi: STD_LOGIC;

begin
	-- Eingangsmultiplexer des Carry-Flags
	CF_MUX: Multiplexer_2_to_1 port map (A => Ci, B => CFShadow, Y => CFi, S => IntCode(0));

	-- Speicher fur das Carry-Flag
	CE <= IntCode(0) or WE;
	CF_DFF: DFlipFlop_RE port map (C => Clk, D => CFi, E => CE, R => Reset, Q => CFo);
	CFS_DFF: DFlipFlop_RE
		port map (C => Clk, D => CFo, E => IntCode(1), R => Reset, Q => CFShadoM);

	Co <= CFo;

	-- Eingangsmultiplexer des Zero-Flags
	ZF_MUX: Multiplexer_2_to_1 port map (A => Zi, B => ZFShadow, Y => ZFi, S => IntCode(0));

	-- Speicher fur das Zero-Flag
	ZF_DFF: DFlipFlop_RE port map (C => Clk, D => ZFi, E => CE, R => Reset, Q => ZFo);
	ZFS_DFF: DFlipFlop_RE
		port map (C => Clk, D => ZFo, E => IntCode(1), R => Reset, Q => ZFShadow);

	Zo <= ZFo;

	-- Eingangsmultiplexer des Interrupt-Enable-Flags
	IEF_MUX: Multiplexer_2_to_1 port map (A => IEi, B => '0‘, Y => IEFi, S => IntCode(1));

	-- Speicher fur das Interrupt-Enable-Flag
	IECE <= IntCode(1) or IEWE;
	IEF_DFF: DFlipFlop_RE port map (C => Clk, D => IEFi, E => IECE, R => Reset, Q => IEo);
end Behavior;