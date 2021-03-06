
library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.STD_LOGIC_UNSIGNED.ALL;

entity B_RAM_2 is
	generic (addr_width: integer; -- Adressbreite
				data_width: integer); -- Datenbreite
	port (Addr: in STD_LOGIC_VECTOR (addr_width - 1 downto 0); -- Adresse
			DI: in STD_LOGIC_VECTOR (data_width - 1 downto 0); -- Dateneingang
			DO: out STD_LOGIC_VECTOR (data_width - 1 downto 0); -- Datenausgang
			Clk: in STD_LOGIC; -- Takt
			WE: in STD_LOGIC); -- Schreibfreigabe
end B_RAM_2;

-- Write First Mode
architecture WriteFirst of B_RAM_2 is
	-- Typ des Speichers definieren
	type RAM_TYPE is array (0 to (2**addr_width) - 1) of
				STD_LOGIC_VECTOR (data_width - 1 downto 0);

	-- Speicher als interne Komponente definieren und initialisieren
	signal ram: RAM_TYPE:= (others => (others => '0'));
begin
	WF: process (Clk)
	begin
		if (rising_edge (Clk)) then
			if (WE = '1') then
				-- synchroner Lese— und Schreibzugriff
				ram(conv_integer (Addr)) <= DI;
				DO <= DI;
			else
				--synchroner Lesezugriff
				DO <= ram(conv_integer (Addr));
			end if;
		end if;
	end process WF;
end WriteFirst;

-- Read First Mode
architecture ReadFirst of B_RAM_2 is
	-- Typ des Speichers definieren
	type RAM_TYPE is array (0 to (2**addr_width) - 1) of
					STD_LOGIC_VECTOR (data_width - 1 downto 0);

	-- Speicher als interne Komponente definieren und initialisieren
	signal ram: RAM_TYPE:= (others => (others => '0'));
begin
	RF: process (Clk)
	begin
		if (rising_edge (Clk)) then
			if (WE = '1') then
				-- synchroner Schreibzugriff
				ram(conv_integer (Addr)) <= DI;
			end if;
			-- synchroner Lesezugriff
			DO <= ram(conv_integer (Addr));
		end if;
	end process RF;
end ReadFirst;

-- No Change Mode
architecture NoChange of B_RAM_2 is
	-- Typ des Speichers definieren
	type RAM_TYPE is array (0 to (2**addr_width) - 1) of
				STD_LOGIC_VECTOR (data_width - 1 downto 0);
	-- Speicher als interne Komponente definieren und initialisieren
	signal ram: RAM_TYPE:= (others => (others => '0'));
begin
	NC: process (Clk)
	begin
		if (rising_edge (Clk)) then
			if (WE = '1') then
				-- synchroner Schreibzugriff
				ram(conv_integer (Addr)) <= DI;
			else
				-- synchroner Lesezugriff
				DO <= ram(conv_integer (Addr));
			end if;
		end if;
	end process NC;
end NoChange;

