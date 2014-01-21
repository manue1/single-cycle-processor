library IEEE;
use IEEE.STD_LOGIC_1164.ALL;

package dmux_lib_1_3 is

component Demultiplexer is
port (	-- Datenleitungen
		A: in STD_LOGIC; -- Eingang
		Q: out STD_LOGIC_VECTOR (2 downto 0); -- Ausgang
		-- Steuerleitungen
		S: in STD_LOGIC_VECTOR (1 downto 0));
end component;

end dmux_lib_1_3;

-- End of Demultiplexer 1 to 3 Library

library IEEE;
use IEEE.STD_LOGIC_1164.ALL;

entity Demultiplexer is
port (	-- Datenleitungen
		A: in STD_LOGIC; -- Eingang
		Q: out STD_LOGIC_VECTOR (2 downto 0); -- Ausgang
		-- Steuerleitungen
		S: in STD_LOGIC_VECTOR (1 downto 0));
end Demultiplexer;

architecture Behavior_When of Demultiplexer is
begin
	Q <= 	('Z', 'Z', A) when (S = "00") else
			('Z', A, 'Z') when (S = "01") else
			(A, 'Z', 'Z') when (S = "10") else
			('Z', 'Z', 'Z');
end Behavior_When;

architecture Behavior_With of Demultiplexer is
begin
	with S select
		Q <= 	('Z', 'Z', A) when "00",
				('Z', A, 'Z') when "01",
				(A, 'Z', 'Z') when "10",
				('Z', 'Z', 'Z') when others;
end Behavior_With;

architecture Behavior_Case of Demultiplexer is
begin
	process (S, A)
	begin
		case S is
			when "00" => Q <= ('Z', 'Z', A);
			when "01" => Q <= ('Z', A, 'Z');
			when "10" => Q <= (A, 'Z', 'Z');
			when others => Q <= ('Z', 'Z', 'Z');
		end case;
	end process;
end Behavior_Case;

architecture Behavior_If of Demultiplexer is
begin
	process (S, A)
	begin
		if (S = "00") then
			Q <= ('Z', 'Z', A);
		elsif (S = "01") then
			Q <= ('Z', A, 'Z');
		elsif (S = "10") then
			Q <= (A, 'Z', 'Z');
		else
			Q <= ('Z', 'Z', 'Z');
		end if;
	end process;
end Behavior_If;