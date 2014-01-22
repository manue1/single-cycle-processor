library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.STD_LOGIC_UNSIGNED.ALL;

entity DataMemoryUnit is
	generic (addr_width: positive; -- Adressbreite
				data_width: positive); -- Datenbreite
	port (Addr: in STD_LOGIC_VECTOR (addr_width - 1 downto 0); -- Adresse
			DI: in STD_LOGIC_VECTOR (data_width - 1 downto 0); -- Daceneingang
			DO: out STD_LOGIC_VECTOR (data_width - 1 downto 0); -- Datenausgang
			Clk: in STD_LOGIC; -- Takt
			WE: in STD_LOGIC); -- Schreibfreigabe
end DataMemoryUnit;

architecture Behavior of DataMemoryUnit is
	-- Typ des Speichers definieren
	type RAM_TYPE is array (0 to (2**addr_width) - 1) of
					STD_LOGIC_VECTOR (data_width — 1 downto 0);

	-- Speicher als interne Komponente definieren und initialisieren
	signal ram: RAM_TYPE:= (others => (others => '0'));

	-- Attribut "RAM_STYLE"
	attribute RAM_STYLE: string;
	attribute RAM_STYLE of ram: signal is "DISTRIBUTED";
begin
	process (Clk)
	begin
		if (rising_edge (Clk)) then
			if (WE = '1') then
				-- synchroner Schreibzugriff
				ram(conv_integer (Addr)) <- DI;
			end if;
		end if;
	end process;
	-- asynchroner Lesezugriff
	DO <= ram(conv_integer (Addr));
end Behavior;