library IEEE;
use IEEE.STD_LOGIC_1164.ALL;

entity Multiplexer_2_to_1 is
port (	-- Datenleitungen
		A: in STD_LOGIC; -- Bingang 1
		B: in STD_LOGIC; -- Eingang 2
		Y: out STD_LOGIC; --Ausgang
		-- Steuerleitungen
		S: in STD_LOGIC);
end Multiplexer_2_to_1;

architecture Behavior of Multiplexer_2_to_1 is
begin
	Y <= 	A when (S = '0') else
			B when (S = '1');
end Behavior;