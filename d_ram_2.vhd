library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.STD_LOGIC_UNSIGNED.ALL;

entity D_RAM_2 is
	generic (addr_width: positive; -- Adressbreite
				data_width: positive); -- Datenbreite
	port (Address1: in STD_LOGIC_VECTOR (addr_width - 1 downto 0); -- Adresse des 1. Leseports
			Address2: in STD_LOGIC_VECTOR (addr_width - 1 downto 0); -- Adresse des 2. Leseports
			DataIn: in STD_LOGIC_VECTOR (data_width - 1 downto 0); -- Dateneingang
			DataOut1: out STD_LOGIC_VECTOR (data_width - 1 downto 0); -- Datenausgang des 1. Leseports
			DataOut2: out STD_LOGIC_VECTOR (data_width - 1 downto 0); -- Datenausgang des 2. Leseports
			Clk: in STD_LOGIC; -- Takt
			WriteEnable: in STD_LOGIC); -- Schreibfreigabe
end D_RAM_2;

architecture Behavior of D_RAM_2 is
	-- Typ des Speichers definieren
	type RAM_TYPE is array (0 to (2**addr_width) - 1) of
							STD_LOGIC_VECTOR (data_width - 1 downto 0);
	-- Speicher als interne Komponente definieren und initialisieren
	signal ram: RAM_TYPE:= (others => (others => '0'));
	
	-- Zusammensetzen von Addr1 und Addr2 als Addr
	signal Address: STD_LOGIC_VECTOR ((2**addr_width) - 1 downto 0);
	
begin
	-- synchroner Schreibzugriff
	P1: process (Clk)
	begin
		if (rising_edge (Clk)) then
			if (WriteEnable = '1') then
				Address <= Address1 & Address2;
				ram(conv_integer (Address)) <= DataIn;
			end if;
		end if;
	end process P1;

	-- asynchroner Lesezugriff (Latch-Register)
	DataOut1 <= ram(conv_integer (Address1));
	DataOut2 <= ram(conv_integer (Address2));
end Behavior;