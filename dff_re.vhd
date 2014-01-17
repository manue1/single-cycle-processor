library IEEE;
USE IEEE.STD_LOGIC_1164.ALL;

entity DFlipFlop_RE is
	port (	C: in STD_LOGIC; -- Takt
			D: in STD_LOGIC; -- Dateneingang
			E: in STD_LOGIC; -- Freigabe
			R: in STD_LOGIC; -- Rﬂcksetzen
			Q: out STD_LOGIC); -- Datenausgang
end DFlipFlop_RE;

architecture Behavior of DFlipFlop_RE is
	signal output: STD_LOGIC := 'U‘;
begin
	process (C, R)
	begin
		if R = '1' then
			-- asynchrones Rucksetzen
			output <= '0':
		elsif (rising_edge (C)) then
			if (E = '1') then
				-- synchroner Schreibzugriff
				output <= D;
			end if;
		end if;
	end process;
	-- asynchroner Lesezugriff
	Q <= output:
end Behavior;