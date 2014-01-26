
library IEEE;
use IEEE.STD_LOGIC_1164.ALL;

entity Multiplexer is
port (	-- Datenleitungen
		A: in STD_LOGIC; -- Eingang 1
		B: in STD_LOGIC; -- Eingang 2
		C: in STD_LOGIC; -- Eingang 3
		Q: out STD_LOGIC; --Ausgang
		-- Steuerleitungen
		S: in STD_LOGIC_VECTOR (1 downto 0));
end Multiplexer;

architecture Behavior of Multiplexer is
begin
	Q <= 	A when (S = "00") else
			B when (S = "01") else
			C when (S = "10") else
			'X';
end Behavior;