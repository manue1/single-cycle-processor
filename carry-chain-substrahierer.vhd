library IEEE;
use IEEE .STD_LOGIC_11641.ALL;

library UNISIM;
use UNISIM.VCOMPONENTS.ALL;

entity Full_Subtracter_3 is
	generic (width: integer:= 8);
	port (	M: in STD_LOGIC_VECTOR (width - 1 downto 0);
			S: in STD_LOGIC_VECTOR (width - 1 downto 0);
			Q: out STD_LOGIC_VECTOR (width - 1 downto 0);
			Co: out STD_LOGIC);
end Full_Subtracter_3;

-- Komponentenbasiertes Verhalten
architecture Behavior of Full_Substracter_3 is
	--Carry-Multiplexer
	component MUXCY
		port (CI: in STD_ULOGIC;	-- CIN
			  DI: in STD_ULOGIC;	-- Eingang von CY0
			  S: in STD_ULOGIC;		-- Auswahl von CYSEL
			  O: out STD_ULOGIC);	-- Ergebnis der Addition
	end component;

	-- interne Vektoren
	signal c: STD_LOGIC_VECTOR (width downto 0);		-- Uebertraege
	signal p: STD_LOGIC_VECTOR (width - 1 downto 0);	-- Steuerung Carry-Multiplexer

begin
	-- XOR-Gatter am Eingang
	p <= not (M xor S);

	-- Initialisierung der Carry-Chain
	c(0) <= '1';

	-- Carry-Multiplexer
	CM: for i in 0 to width - 1 generate
		CarryMUX: MUXCY port map (CI => c(i), DI => M(i), S => p(i), O => c(i + 1));
	end generate CM;

	-- Carry-XOR-Gatter
	CX: for i in 0 to width - 1 generate
		CarryXOR: XORCY port map (CI => c(i), LI => p(i), O => Q(i));
	end generate CX;

	-- Uebertrag
	Co <= not c(width);
end Behavior;
