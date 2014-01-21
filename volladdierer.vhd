library IEEE;
use IEEE.STD_LOGIC_1164.ALL;

package c is

component Full_Adder is
	port (	E1: in STD_LOGIC; -- Eingang 1
			E2: in STD_LOGIC; -- Eingang 2
			Ci: in STD_LOGIC; -- Ubertrag am Eingang
			Q: out STD_LOGIC; -- Ergebnis
			Co: out STD_LOGIC); -- Ubertrag am Ausgang
end component;

end full_logic_adder_lib;

-- End of Full Logic Adder Library

-- Voll-Addierer

library IEEE;
use IEEE.STD_LOGIC_1164.ALL;

entity Full_Adder is
	port (	E1: in STD_LOGIC; -- Eingang 1
			E2: in STD_LOGIC; -- Eingang 2
			Ci: in STD_LOGIC; -- Ubertrag am Eingang
			Q: out STD_LOGIC; -- Ergebnis
			Co: out STD_LOGIC); -- Ubertrag am Ausgang
end Full_Adder;

-- vollstandig logikbasierter Addierer
architecture Logic_Adder of Full_Adder is
begin
	Q <= E1 xor E2 xor Ci;
	Co <= (E1 and E2) or ((E1 or E2) and Ci);
end Logic_Adder;

