library IEEE;
use IEEE.STD_LOGIC_1164.ALL;

entity Full_Adder_2 is
port (A: in STD_LOGIC_VECTOR (7 downto O);
	   B: in STD_LOGIC_VECTOR (7 downto 0);
		Q: out STD_LOGIC_VECTOR (7 downto O);
		C8: out STD_LOGIC);
end Full_Adder_2;

-- Carry-Ripple-Addierer
architecture Carry_Ripple of Full_Adder_2 is

-- Addierer fuer ein Bit
component Delayed_Full_Adder is
port (E1: in STD_LOGIC; -- Eingang 1
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
G1: for i in O to 7 generate
ADD: Delayed_Full_Adder
port map (E1 => A(i), E2 => B(i), Ci => c(i), Q => Q(i), Co => c(i + 1));
end generate G1;
C8 <= c(8);

end Carry_Ripple;