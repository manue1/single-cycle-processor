library IEEE;
use IEEE.STD_LOGIC_1164.ALL;

library UNISIM;
use UNISIM.VComponents.all;

-- Verteilter Speicher (16 Werte x 1 Bit — eine LUT)
entity D_RAM is
	port (	Addr: in STD_LOGIC_VECTOR(3 downto O); -- Adresse im Speicher
			DI: in STD_LOGIC; -- zu schreibende Daten
			DO: out STD_LOGIC; -- gelesene Daten
			Clk: in STD_LOGIC; -- Schreibtakt
			WE: in STD_LOGIC); -- Schreibfreigabe
end D_RAM:

architecture Behavior of D_RAM is
	-- RAM16X1S: 16 X 1 positive edge write distributed (LUT) RAM
	component RAM16X1S
		generic (INIT: BIT_VECTOR(15 downto 0) := X"0000");
		port (	A0, A1, A2, A3: in STD_ULOGIC; -- Adresse im Speicher
				D: in STD_ULOGIC; -- zu schreibende Daten
				O: out STD_ULOGIC; -- gelesene Daten
				WCLK: in STD_ULOGIC; -- Schreibtakt
				WE: in STD_ULOGIC); -- Schreibfreigabe
	end component;
begin
	-- Instanz des Speichers erstellen
	RAM16X1S_inst: RAM16X1S
		generic map (INIT => X"1A5C") 	-- Anfangswert: 1A5C (Hex)
							  			-- 0001 1010 0101 1100 (Bin)
							  			-- MSB . . . LSB
		port map (A0 => Addr(0), A1 => Addr(1), A2 => Addr(2), A3 => Addr(3),
					D => DI, O => DO, WCLK => Clk, WE => WE);
end Behavior;