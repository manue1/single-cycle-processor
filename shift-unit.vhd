library IEEE;
use IEEE.STD_LOGIC_1164.ALL;

entity ShiftUnit is
	generic (width: positive);		-- Verarbeitungsbreite (> 1) 
	port (	-- Datenleitungen
			A: in STD_LOGIC_VECTOR (width - 1 downto 0);	-- Operand 
			Ci: in STD_LOGIC;								-- Carry Flag am Eingang 
			Q: out STD_LOGIC_VECTOR (width - 1 downto 0);	-- Ergebnis 
			Co: out STD_LOGIC; 								-- Carry Flag am Ausgang 
			-- Steuerleitungen
			Op: in STD_LOGIC_VECTOR (1 downto 0);			-- Bits 2 und 1 des Befehlskodes
															-- 00 -> SLA, SEA
															-- 01 -> RL, SEX
															-- 10 -> SLX, RR
															-- 11 -> SLO, SL1, SRO, SR1 
			Dir: in STD_LOGIC;			-- Bit 3 des Befehlskodes
										-- 0 -> Links
										-- 1 -> Rechts
			ExtBit: in STD_LOGIC);	-- Bit 0 des Befehlskodes
									-- 0 -> SLO, SRO
									-- 1 -> SLI, SRI 
end ShiftUnit;

architecture Behavior of ShiftUnit is
	-- 2-zu-1 Multiplexer
	component Multiplexer_2_to_1
		port (	A, B: in STD_LOGIC;
				Y: out STD_LOGIC;
				S: in STD_LOGIC);
	end component Multiplexer_2_to_1; 

	-- 4-zu-1 Multiplexer
	component Multiplexer_4_to_1
		port (	A, B, C, D: in STD_LOGIC;
				Y: out STD_LOGIC;
				S: in STD_LOGIC_VECTOR (1 downto 0));
	end component Multiplexer_4_to_1; 

	-- von der Operation abhangiges Bit
	signal temp_bit: STD_LOGIC; 

begin
	-- von der Operation abhangiges Bit
	IN_MUX: Multiplexer_4_to_1
		port map (A => Ci, B => A(width - 1), C => A(0), D => ExtBit, Y => temp_bit, S => Op);

	-- niederwertigstes Bit des Operanden
	LSB_MUX: Multiplexer_2_to_1
		port map (A => temp_bit, B => A(1), Y => Q(0), S => Dir);

	-- mittlere Bits des Operanden
	G_MUX: for i in 1 to width - 2 generate
		MID_MUX: Multiplexer_2_to_1
			port map (A => A(i - 1), B => A(i 1), Y => Q(i), S => Dir);
	end generate G_MUX; 

	-- hochstwertigstes Bit des Operanden
	MSB_MUX: Multiplexer_2_to_1
		port map (A => A(width - 2), B => temp_bit, Y => Q(width - 1), S => Dir); 

	-- Carry-Flag
	CY_MUX: Multiplexer_2_to_1
		port map (A => A(width - 1), B => A(0), Y => Co, S => Dir);
end Behavior; 




