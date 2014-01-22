library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.STD_LOGIC_UNSIGNED.ALL;

entity D_RAM_2 is
	generic (	addr_width: integer; -- Adressbreite
				data_width: integer); -- Datenbreite

	port (	Addr: in STD_LOGIC_VECTOR (addr_width - 1 downto 0); -- Adresse
			DI: in STD_LOGIC_VECTOR (data_width - 1 downto 0); -- Dateneingang
			DO: out STD_LOGIC_VECTOR (data_width - 1 downto 0); -- Datenausgang
			Clk: in STD_LOGIC; -- Takt
			WE: in STD_LOGIC); -- Schreibfreigabe
end D_RAM_2;

architecture Behavior of D_RAM_2 is
	-- Typ des Speichers definieren
	type RAM_TYPE is array (0 to (2**addr_width) - 1) of
							STD_LOGIC_VECTOR (data_width - 1 downto 0);
	-- Speicher als interne Komponente definieren und initialisieren
	signal ram: RAM_TYPE:= (others => (others => '0'));
begin
	-- synchroner Schreibzugriff
	P1: process (Clk)
	begin
		if (rising_edge (Clk)) then
			if (WE = '1') then
				ram(conv_integer (Addr)) <= DI;
			end if;
		end if;
	end process P1;

	-- asynchroner Lesezugriff (Latch-Register)
	DO <= ram(conv_integer (Addr));
end Behavior;