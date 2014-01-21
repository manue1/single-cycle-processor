library IEEE;
use IEEE.STD_LOGIC_1164.ALL;

entity Full_Subtracter_2 is
	port (	M: in STD_LOGIC_VECTOR (7 downto 0); -- Minuend
			S: in STD_LOGIC_VECTOR (7 downto 0); -- Subtrahend
			Q: out STD_LOGIC_VECTOR (7 downto 0); -- Ergebnis
			C8: out STD_LOGIC); -- Ubertrag am Ausgang
end Full_Subtracter_2;

architecture Behavior of Full_Subtracter_2 is
-- Voll-Addierer
	component Full_Adder_2
		port (	A, B: in STD_LOGIC_VECTOR (7 downto 0);
				Q: out STD_LOGIC_VECTOR (7 downto 0);
				C8: out STD_LOGIC);
	end component Full_Adder_2;

	-- Verhalten eines Carry-Look-Ahead-Addierers auswahlen
	for ADD: Full_Adder_2 use entity work.Full_Adder_2(Carry_Look_Ahead);

	-- interner Vektor fur den negierten Minuenden
	signal m1: STD_LOGIC_VECTOR (7 downto 0);
	
	-- interner Vektor fur das Ergebnis der Voll-Addierer
	signal q1: STD_LOGIC_VECTOR (7 downto 0);
begin
	-- Negation des Minuenden
	ml <= not M after 2 ns;
	-- Voll-Addierer
	ADD: Full_Adder_2 port map (A => m1, B => S, Q => q1, C8 => C8);
	-- Negation des Ergebnisses
	Q <= not q1 after 2 ns;

end Behavior;
