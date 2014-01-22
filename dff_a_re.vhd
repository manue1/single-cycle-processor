-- source: http://books.google.de/books?id=nYyaDD7UvpYC&pg=PA44&lpg=PA44&dq=d+flip+flop+mit+ruecksetz+und+freigabeeingang&source=bl&ots=Zpi771i_qN&sig=nFNejLY3M4OHWB_zEsrz6G6nDF0&hl=de&sa=X&ei=Xq_fUru5D4LZswbl7oGgCg&redir_esc=y#v=onepage&q=d%20flip%20flop%20mit%20ruecksetz%20und%20freigabeeingang&f=false
-- D-Flip-Flop mit Ruecksetz— und Freigabeeingang

library IEEE;
USE IEEE.STD_LOGIC_1164.ALL;

entity DFlipFlop_A_RE is
	port (	C: in STD_LOGIC; -- Takt
			D: in STD_LOGIC; -- Dateneingang
			E: in STD_LOGIC; -- Freigabe
			R: in STD_LOGIC; -- Rﬂcksetzen
			Q: out STD_LOGIC); -- Datenausgang
end DFlipFlop_A_RE;

architecture Behavior of DFlipFlop_A_RE is
begin
	process (C, R)
	begin
		if R = '1' then
			-- asynchrones Rucksetzen
			Q <= '0';
		elsif (rising_edge (C) and C = '1') then
			if (E = '1') then
				-- synchroner Schreibzugriff
				Q <= D;
			end if;
		end if;
	end process;
end Behavior;