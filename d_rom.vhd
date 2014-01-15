library UNISIM;
use UNISIM.VComponents.all;
entity D_ROM is
port (Addr: in STD_LOGIC_VECTOR(3 downto 0); -- Adresse im Speicher
DO: out STD_LOGIC); —— gelesene Daten
end D_ROM;

architecture Behavior of D_ROM is
—— ROM16X1: 16 x 1 Asynchronous Distributed (LUT) ROM
component ROM16X1
generic (INIT: BIT_VECTOR(15 downto 0) := X"0000");
port (A0, A1, A2, A3: in STD_ULOGIC; -- Adresse im Speicher
O: out STD_ULOGIC); —— gelesene Daten
end component;
begin
—— Instanz des Speichers erstellen
ROM16X1_inst: ROM16X1
generic map (INIT => X"1A5C") -- Anfangswert: 1A5C (Hex)
—— 0001 1010 0101 1100 (Bin)
—— MSB . . . LSB
port map (A0 => Addr(0), A1 => Addr(1), A2 => Addr(2), A3 => Addr(3), O => D0);
end Behavior;