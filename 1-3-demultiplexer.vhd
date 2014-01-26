
library IEEE;
use IEEE.STD_LOGIC_1164.ALL;

entity Demultiplexer is
port (	-- Datenleitungen
		A: in STD_LOGIC; -- Eingang
		Q: out STD_LOGIC_VECTOR (2 downto 0); -- Ausgang
		-- Steuerleitungen
		S: in STD_LOGIC_VECTOR (1 downto 0));
end Demultiplexer;

architecture Behavior of Demultiplexer is
begin
	with S select
		Q <= 	('Z', 'Z', A) when "00",
				('Z', A, 'Z') when "01",
				(A, 'Z', 'Z') when "10",
				('Z', 'Z', 'Z') when others;
end Behavior;