
library IEEE;
use IEEE.STD_LOGIC_1164.ALL;

entity Full_Adder_2 is
	port (	A: in STD_LOGIC_VECTOR (7 downto 0);
	   		B: in STD_LOGIC_VECTOR (7 downto 0);
			Q: out STD_LOGIC_VECTOR (7 downto 0);
			C8: out STD_LOGIC);
end Full_Adder_2;

-- Carry-Ripple-Addierer
architecture Carry_Ripple of Full_Adder_2 is
	-- Addierer fuer ein Bit
	component Delayed_Full_Adder is
	port (	E1: in STD_LOGIC; -- Eingang 1
			E2: in STD_LOGIC; -- Eingang 2
			Ci: in STD_LOGIC; -- Ubertrag am Eingang
			Q: out STD_LOGIC; -- Ergebnis
			Co: out STD_LOGIC); -- Ubertrag am Ausgang
	end component Delayed_Full_Adder;

	-- interner Vektor fuer die Uebertraege der einzelnen Addierer
	signal c: STD_LOGIC_VECTOR (8 downto 0);
begin
	c(0) <= '0';
	-- einzelnen Addierer erzeugen
	G1: for i in 0 to 7 generate
		ADD: Delayed_Full_Adder
			port map (E1 => A(i), E2 => B(i), Ci => c(i), Q => Q(i), Co => c(i + 1));
	end generate G1;
	C8 <= c(8);
end Carry_Ripple;

-- Carry—Look—Ahead—Addierer
architecture Carry_Look_Ahead of Full_Adder_2 is
	-- interne Vektoren
	signal c: STD_LOGIC_VECTOR (7 downto 0); -- Ubertrage
	signal g: STD_LOGIC_VECTOR (7 downto 0); -- generierende Anteil
	signal p: STD_LOGIC_VECTOR (7 downto 0); -- propagierender Anteil
begin
	-- Halb—Addierer am Eingang
	p <= A xor B after 2 ns;
	g <= A and B after 2 ns;

	-- Carry—Logik (Gatter mit max. 4 Eingangen)
	c(0) <= '0‘;
	-- c(i) <= g(i - 1) or (p(i - 1) and c(i - 1))
	c(1) <= g(0);
	c(2) <= g(1) or (p(1) and g(0)) after 4 ns;
	c(3) <= g(2) or (p(2) and g(1)) or (p(2) and p(1) and g(0)) after 4 ns;
	c(4) <= g(3) or (p(3) and g(2)) or (p(3) and p(2) and g(1))
			or (p(3) and p(2) and p(1) and g(0)) after 4 ns;
	c(5) <= g(4) or (p(4) and c(4)) after 4 ns;
	c(6) <= g(5) or (p(5) and g(4)) or (p(5) and p(4) and c(4)) after 4 ns;
	c(7) <= g<6> or (p(6) and g(5)) or (p(6) and p(5) and g(4))
			or (p(6) and p(5) and p(4) and c(4)) after 4 ns;
	C8 <= g(7) or (p(7) and c(7)) after 4 ns;

	-- Ergebnislogik
	Q <= p xor c after 2 ns;
end Carry_Look_Ahead;



