library IEEE;
use IEEE.STD_LOGIC_1l64.ALL;

library UNISIM;
use UNISIM.VCOMPONENTS.ALL;

entity Full_Adder_3 is
	generic (width: integer:= 8);
	port (	A: in STD_LOGIC_VECTOR (width - 1 downto 0);
			B: in STD_LOGIC_VECTOR (width - 1 downto 0);
			Q: out STD_LOGIC_VECTOR (width - 1 downto 0);
			Co: out STD_LOGIC);
end Full_Adder_3;

-- Komponentenbasiertes Verhalten
architecture Behavior of Full_Adder_3 is

-- Carry-Multiplexer
component MUXCY
port (	CI: in std_ulogic; -- CIN
		DI: in std_ulogic; -- Eingang von CYO
		S: in std_ulogic; -- Auswahl von CYSEL
		O: out std_ulogic); -- COUT
end component;

-- Carry-XOR-Gatter
component XORCY
port (	CI: in std_ulogic; -- Ubertrag am Eingang (CIN)
		LI: in std_ulogic; -- Ergebnis des 1. Halb-Addierers
		O: out std_ulogic); -- Ergebnis der Addition
end component;

-- interne Vektoren
signal c: STD_LOGIC_VECTOR (width downto 0); -- Ubertrage
signal p: STD_LOGIC_VECTOR (width - 1 downto 0); -- propagierender Anteil

begin
	-- XOR-Gatter am Eingang
	p <= A xor B;

	-- Initialisierung der Carry-Chain
	c(0) <= '0';

	-- Carry-Multiplexer
	CM: for i in 0 to width - 1 generate
		CarryMUX: MUXCY port map (CI => c(i), DI => B(i), S => p(i), O => c(i + 1));
	end generate CM;

	-- Carry-XOR-Gatter
	CX: for i in 0 to width - 1 generate
	CarryXOR: XORCY port map (CI => c(i), LI => p(i), O => Q(i));
	end generate CX;

	-- Uebertrag
	Co <= c(width);

end Behavior;