library IEEE;
use IEEE.STD_LOGIC_1164.ALL;

-- Halb-Addierer
entity Half_Adder is
	port (	E1: in STD_LOGIC; -- Eingang 1
			E2: in STD_LOGIC; -- Eingang 2
			Q: out STD_LOGIC; -- Ergebnis
			C: out STD_LOGIC); -- Uebertrag
end Half_Adder;

architecture Behavior of Half_Adder is
begin
	Q <= E1 xor E2;
	C <= E1 and E2;
end Behavior;