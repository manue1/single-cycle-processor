library IEEE;
use IEEE.STD_LOGIC_1l64.ALL;
use IEEE.STD_LOGIC_UNSIGNED.ALL;

entity B_RAM_3 is
	generic (	addr_width: integer := 4; -- Adressbreite
				data_width: integer := 1); -- Datenbreite
	port (	Addr: in STD_LOGIC_VECTOR (addr_width - 1 downto 0); -- Adresse
			DI: in STD_LOGIC_VECTOR (data_width - 1 downto 0); -- Dateneingang
			DO: out STD_LOGIC_VECTOR (data_width - 1 downto 0); -- Datenausgang
			Clk: in STD_LOGIC; -- Takt
			WE: in STD_LOGIC); -- Schreibfreigabe
end B_RAM_3;

architecture WriteFirst of B_RAM_3 is
	-- Typ des Speichers definieren

	type RAM_TYPE is array (0 to (2**addr_width) — 1) of
				STD_LOGIC_VECTOR (data_width - 1 downto 0);
	-- Speicher als interne Komponente definieren und initialisieren
	signal ram: RAM_TYPE:= (others => (others => '0'));
	-- Attribut "RAM_STYLE"
	attribute RAM_STYLE: string;
	attribute RAM_STYLE of ram: signal is "BLOCK";
begin
	WF: process (Clk)
	begin
		if (rising_edge (Clk)) then
			if (WE = '1') then
				-- synchroner Lese— und Schreibzugriff
				ram(conv_integer (Addr)) <= DI;
				DO <= DI;
			else
				-- synchroner Lesezugriff
				DO <= ram(conv_integer (Addr));
			end if;
		end if;
	end process WF;
end WriteFirst;

