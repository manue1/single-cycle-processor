library IEEE;
use IEEE.STD_LOGIC_1164.ALL;

entity Multiplexer_4_to_1 is
port (	-- Datenleitungen
		A: in STD_LOGIC; -- Eingang 1
		B: in STD_LOGIC; -- Eingang 2
		C: in STD_LOGIC; -- Eingang 3
		D: in STD_LOGIC; -- Eingang 4
		Y: out STD_LOGIC; --Ausgang
		-- Steuerleitungen
		S: in STD_LOGIC_VECTOR (1 downto 0));
end Multiplexer_4_to_1;

architecture Behavior of Multiplexer_4_to_1 is
begin
	Y <= 	A when (S = "00") else
			B when (S = "01") else
			C when (S = "10") else
			D when (S = "11");
end Behavior;