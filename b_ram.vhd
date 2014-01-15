library IEEE:
use IEEE.STD_LOGIC_1164.ALL;

library UNISIM;
use UNISIM.VComponents.all;

entity B_RAM is
port (Addr: in STD_LOGIC_VECTOR (9 downto 0); -- Adresse im Speicher
DI: in STD_LOGIC_VECTOR (17 downto 0): -- zu schreibende Daten
DO: out STD_LOGIC_VECTOR (17 downto 0); —— gelesene Daten
Clk: in STD_ULOGIC; -- Lese— und Schreibtakt
E: in STD_ULOGIC: —— Freigabe des Speichers
SSR: in STD_ULOGIC; -- Synchrones Setzen bzw. Ruecksetzen
WE: in STD_ULOGIC); —— Schreibfreigabe
end B_RAM;

architecture Behavior of B_RAM is
component RAMB16_S18
generic (INIT: BIT_VECTOR := X"00000";
SRVAL: BIT_VECTOR := X"00000";
WRITE_MODE: string := "WRITE_FIRST";
INITP_00: BIT_VECTOR := X"0000000000000000000000000000000000000000000000000000000000000000";
INITP_01: BIT_VECTOR := X"0000000000000000000000000000000000000000000000000000000000000000";
INITP_02: BIT_VECTOR := X"0000000000000000000000000000000000000000000000000000000000000000";
INITP_03: BIT_VECTOR := X"0000000000000000000000000000000000000000000000000000000000000000";
INITP_04: BIT_VECTOR := X"0000000000000000000000000000000000000000000000000000000000000000";
INITP_05: BIT_VECTOR := X"0000000000000000000000000000000000000000000000000000000000000000";
INITP_06: BIT_VECTOR := X"0000000000000000000000000000000000000000000000000000000000000000";
INITP_07: BIT_VECTOR := X"0000000000000000000000000000000000000000000000000000000000000000";
INIT_00: BIT_VECTOR := X"0000000000000000000000000000000000000000000000000000000000000000";
INIT_01: BIT_VECTOR := X"0000000000000000000000000000000000000000000000000000000000000000";
INIT_02: BIT_VECTOR := X"0000000000000000000000000000000000000000000000000000000000000000";
INIT_03: BIT_VECTOR := X"0000000000000000000000000000000000000000000000000000000000000000";
INIT_04: BIT_VECTOR := X"0000000000000000000000000000000000000000000000000000000000000000";
INIT_05: BIT_VECTOR := X"0000000000000000000000000000000000000000000000000000000000000000";
INIT_06: BIT_VECTOR := X"0000000000000000000000000000000000000000000000000000000000000000";
INIT_07: BIT_VECTOR := X"0000000000000000000000000000000000000000000000000000000000000000";
INIT_08: BIT_VECTOR := X"0000000000000000000000000000000000000000000000000000000000000000";
INIT_09: BIT_VECTOR := X"0000000000000000000000000000000000000000000000000000000000000000";
INIT_0A: BIT_VECTOR := X"0000000000000000000000000000000000000000000000000000000000000000";
INIT_0B: BIT_VECTOR := X"0000000000000000000000000000000000000000000000000000000000000000";
INIT_0C: BIT_VECTOR := X"0000000000000000000000000000000000000000000000000000000000000000";
INIT_0D: BIT_VECTOR := X"0000000000000000000000000000000000000000000000000000000000000000";
INIT_0E: BIT_VECTOR := X"0000000000000000000000000000000000000000000000000000000000000000";
INIT_0F: BIT_VECTOR := X"0000000000000000000000000000000000000000000000000000000000000000";
INIT_10: BIT_VECTOR := X"0000000000000000000000000000000000000000000000000000000000000000";
INIT_11: BIT_VECTOR := X"0000000000000000000000000000000000000000000000000000000000000000";
INIT_12: BIT_VECTOR := X"0000000000000000000000000000000000000000000000000000000000000000";
INIT_13: BIT_VECTOR := X"0000000000000000000000000000000000000000000000000000000000000000";
INIT_14: BIT_VECTOR := X"0000000000000000000000000000000000000000000000000000000000000000";
INIT_15: BIT_VECTOR := X"0000000000000000000000000000000000000000000000000000000000000000";
INIT_16: BIT_VECTOR := X"0000000000000000000000000000000000000000000000000000000000000000";
INIT_17: BIT_VECTOR := X"0000000000000000000000000000000000000000000000000000000000000000";
INIT_18: BIT_VECTOR := X"0000000000000000000000000000000000000000000000000000000000000000";
INIT_19: BIT_VECTOR := X"0000000000000000000000000000000000000000000000000000000000000000";
INIT_1A: BIT_VECTOR := X"0000000000000000000000000000000000000000000000000000000000000000";
INIT_1B: BIT_VECTOR := X"0000000000000000000000000000000000000000000000000000000000000000";
INIT_1C: BIT_VECTOR := X"0000000000000000000000000000000000000000000000000000000000000000";
INIT_1D: BIT_VECTOR := X"0000000000000000000000000000000000000000000000000000000000000000";
INIT_1E: BIT_VECTOR := X"0000000000000000000000000000000000000000000000000000000000000000";
INIT_1F: BIT_VECTOR := X"0000000000000000000000000000000000000000000000000000000000000000";
INIT_20: BIT_VECTOR := X"0000000000000000000000000000000000000000000000000000000000000000";
INIT_21: BIT_VECTOR := X"0000000000000000000000000000000000000000000000000000000000000000";
INIT_22: BIT_VECTOR := X"0000000000000000000000000000000000000000000000000000000000000000";
INIT_23: BIT_VECTOR := X"0000000000000000000000000000000000000000000000000000000000000000";
INIT_24: BIT_VECTOR := X"0000000000000000000000000000000000000000000000000000000000000000";
INIT_25: BIT_VECTOR := X"0000000000000000000000000000000000000000000000000000000000000000";
INIT_26: BIT_VECTOR := X"0000000000000000000000000000000000000000000000000000000000000000";
INIT_27: BIT_VECTOR := X"0000000000000000000000000000000000000000000000000000000000000000";
INIT_28: BIT_VECTOR := X"0000000000000000000000000000000000000000000000000000000000000000";
INIT_29: BIT_VECTOR := X"0000000000000000000000000000000000000000000000000000000000000000";
INIT_2A: BIT_VECTOR := X"0000000000000000000000000000000000000000000000000000000000000000";
INIT_2B: BIT_VECTOR := X"0000000000000000000000000000000000000000000000000000000000000000";
INIT_2C: BIT_VECTOR := X"0000000000000000000000000000000000000000000000000000000000000000";
INIT_2D: BIT_VECTOR := X"0000000000000000000000000000000000000000000000000000000000000000";
INIT_2E: BIT_VECTOR := X"0000000000000000000000000000000000000000000000000000000000000000";
INIT_2F: BIT_VECTOR := X"0000000000000000000000000000000000000000000000000000000000000000";
INIT_30: BIT_VECTOR := X"0000000000000000000000000000000000000000000000000000000000000000";
INIT_31: BIT_VECTOR := X"0000000000000000000000000000000000000000000000000000000000000000";
INIT_32: BIT_VECTOR := X"0000000000000000000000000000000000000000000000000000000000000000";
INIT_33: BIT_VECTOR := X"0000000000000000000000000000000000000000000000000000000000000000";
INIT_34: BIT_VECTOR := X"0000000000000000000000000000000000000000000000000000000000000000";
INIT_35: BIT_VECTOR := X"0000000000000000000000000000000000000000000000000000000000000000";
INIT_36: BIT_VECTOR := X"0000000000000000000000000000000000000000000000000000000000000000";
INIT_37: BIT_VECTOR := X"0000000000000000000000000000000000000000000000000000000000000000";
INIT_38: BIT_VECTOR := X"0000000000000000000000000000000000000000000000000000000000000000";
INIT_39: BIT_VECTOR := X"0000000000000000000000000000000000000000000000000000000000000000";
INIT_3A: BIT_VECTOR := X"0000000000000000000000000000000000000000000000000000000000000000";
INIT_3B: BIT_VECTOR := X"0000000000000000000000000000000000000000000000000000000000000000";
INIT_3C: BIT_VECTOR := X"0000000000000000000000000000000000000000000000000000000000000000";
INIT_3D: BIT_VECTOR := X"0000000000000000000000000000000000000000000000000000000000000000";
INIT_3E: BIT_VECTOR := X"0000000000000000000000000000000000000000000000000000000000000000";
INIT_3F: BIT_VECTOR := X"0000000000000000000000000000000000000000000000000000000000000000");

port (ADDR: in STD_LOGIC_VECTOR (9 downto 0); -- Adresse im Speicher
DI: in STD_LOGIC_VECTOR (15 downto 0); -- zu schreibende Daten
DIP: in STD_LOGIC_VECTOR (1 downto 0); -- zu schreibende Paritatsbits
DO: out STD_LOGIC_VECTOR (15 downto 0); -- gelesene Daten
DOP: out STD_LOGIC_VECTOR (1 dounto 0); -- gelesene Paritatsbits
CLK: in STD_ULOGIC; -- Lese— und Schreibtakt
EN: in STD_ULOGIC; -- Freigabe des Speichers
SSR: in STD_ULOGIC; —— Synchrones Setzen bzw. Riicksetzen
WE: in STD_ULOGIC); —— Schreibfreigabe
end component RAMB16_S18:

begin
-- RAMB16_S18: 1k x 16 + 2 Parity bits Single-Port write RAM
RAMB16_S18_inst: RAMB16_S18
generic map ( INIT => X"00000", —— Value of output RAM registers at startup
SRVAL => X"00000", —— Output value upon SSR assertion
WRITE_MODE => "WRITE_FIRST", —— WRITE_FIRST, READ_FIRST or NO_CHANGE
—— The following INIT__xx declarations specify the intial contents of the RAM
INIT_00 => X"FEDCBA987654321OFEDCBA9876543210FEDCBA9876543210FEDCBA9876543210",
INIT_01 => X"FEDCBA987654321OFEDCBA9876543210FEDCBA9876543210FEDCBA9876543210",
INIT_02 => X"FEDCBA987654321OFEDCBA9876543210FEDCBA9876543210FEDCBA9876543210",
INIT_03 => X"FEDCBA987654321OFEDCBA9876543210FEDCBA9876543210FEDCBA9876543210",
INIT_04 => X"FEDCBA987654321OFEDCBA9876543210FEDCBA9876543210FEDCBA9876543210",
INIT_05 => X"FEDCBA987654321OFEDCBA9876543210FEDCBA9876543210FEDCBA9876543210",
INIT_06 => X"FEDCBA987654321OFEDCBA9876543210FEDCBA9876543210FEDCBA9876543210",
INIT_07 => X"FEDCBA987654321OFEDCBA9876543210FEDCBA9876543210FEDCBA9876543210",
INIT_08 => X"FEDCBA987654321OFEDCBA9876543210FEDCBA9876543210FEDCBA9876543210",
INIT_09 => X"FEDCBA987654321OFEDCBA9876543210FEDCBA9876543210FEDCBA9876543210",
INIT_0A => X"FEDCBA987654321OFEDCBA9876543210FEDCBA9876543210FEDCBA9876543210",
INIT_0B => X"FEDCBA987654321OFEDCBA9876543210FEDCBA9876543210FEDCBA9876543210",
INIT_0C => X"FEDCBA987654321OFEDCBA9876543210FEDCBA9876543210FEDCBA9876543210",
INIT_0D => X"FEDCBA987654321OFEDCBA9876543210FEDCBA9876543210FEDCBA9876543210",
INIT_0E => X"FEDCBA987654321OFEDCBA9876543210FEDCBA9876543210FEDCBA9876543210",
INIT_0F => X"FEDCBA987654321OFEDCBA9876543210FEDCBA9876543210FEDCBA9876543210",
INIT_10 => X"FEDCBA987654321OFEDCBA9876543210FEDCBA9876543210FEDCBA9876543210",
INIT_11 => X"FEDCBA987654321OFEDCBA9876543210FEDCBA9876543210FEDCBA9876543210",
INIT_12 => X"FEDCBA987654321OFEDCBA9876543210FEDCBA9876543210FEDCBA9876543210",
INIT_13 => X"FEDCBA987654321OFEDCBA9876543210FEDCBA9876543210FEDCBA9876543210",
INIT_14 => X"FEDCBA987654321OFEDCBA9876543210FEDCBA9876543210FEDCBA9876543210",
INIT_15 => X"FEDCBA987654321OFEDCBA9876543210FEDCBA9876543210FEDCBA9876543210",
INIT_16 => X"FEDCBA987654321OFEDCBA9876543210FEDCBA9876543210FEDCBA9876543210",
INIT_17 => X"FEDCBA987654321OFEDCBA9876543210FEDCBA9876543210FEDCBA9876543210",
INIT_18 => X"FEDCBA987654321OFEDCBA9876543210FEDCBA9876543210FEDCBA9876543210",
INIT_19 => X"FEDCBA987654321OFEDCBA9876543210FEDCBA9876543210FEDCBA9876543210",
INIT_1A => X"FEDCBA987654321OFEDCBA9876543210FEDCBA9876543210FEDCBA9876543210",
INIT_1B => X"FEDCBA987654321OFEDCBA9876543210FEDCBA9876543210FEDCBA9876543210",
INIT_1C => X"FEDCBA987654321OFEDCBA9876543210FEDCBA9876543210FEDCBA9876543210",
INIT_1D => X"FEDCBA987654321OFEDCBA9876543210FEDCBA9876543210FEDCBA9876543210",
INIT_1E => X"FEDCBA987654321OFEDCBA9876543210FEDCBA9876543210FEDCBA9876543210",
INIT_1F => X"FEDCBA987654321OFEDCBA9876543210FEDCBA9876543210FEDCBA9876543210",
-- Address 512
INIT_20 => X"0000000000000000000000000000000000000000000000000000000000000000",
INIT_21 => X"0000000000000000000000000000000000000000000000000000000000000000",
INIT_22 => X"0000000000000000000000000000000000000000000000000000000000000000",
INIT_23 => X"0000000000000000000000000000000000000000000000000000000000000000",
INIT_24 => X"0000000000000000000000000000000000000000000000000000000000000000",
INIT_25 => X"0000000000000000000000000000000000000000000000000000000000000000",
INIT_26 => X"0000000000000000000000000000000000000000000000000000000000000000",
INIT_27 => X"0000000000000000000000000000000000000000000000000000000000000000",
INIT_28 => X"0000000000000000000000000000000000000000000000000000000000000000",
INIT_29 => X"0000000000000000000000000000000000000000000000000000000000000000",
INIT_2A => X"0000000000000000000000000000000000000000000000000000000000000000",
INIT_2B => X"0000000000000000000000000000000000000000000000000000000000000000",
INIT_2C => X"0000000000000000000000000000000000000000000000000000000000000000",
INIT_2D => X"0000000000000000000000000000000000000000000000000000000000000000",
INIT_2E => X"0000000000000000000000000000000000000000000000000000000000000000",
INIT_2F => X"0000000000000000000000000000000000000000000000000000000000000000",
INIT_30 => X"0000000000000000000000000000000000000000000000000000000000000000",
INIT_31 => X"0000000000000000000000000000000000000000000000000000000000000000",
INIT_32 => X"0000000000000000000000000000000000000000000000000000000000000000",
INIT_33 => X"0000000000000000000000000000000000000000000000000000000000000000",
INIT_34 => X"0000000000000000000000000000000000000000000000000000000000000000",
INIT_35 => X"0000000000000000000000000000000000000000000000000000000000000000",
INIT_36 => X"0000000000000000000000000000000000000000000000000000000000000000",
INIT_37 => X"0000000000000000000000000000000000000000000000000000000000000000",
INIT_38 => X"0000000000000000000000000000000000000000000000000000000000000000",
INIT_39 => X"0000000000000000000000000000000000000000000000000000000000000000",
INIT_3A => X"0000000000000000000000000000000000000000000000000000000000000000",
INIT_3B => X"0000000000000000000000000000000000000000000000000000000000000000",
INIT_3C => X"0000000000000000000000000000000000000000000000000000000000000000",
INIT_3D => X"0000000000000000000000000000000000000000000000000000000000000000",
INIT_3F => X"0000000000000000000000000000000000000000000000000000000000000000",
-- The next set of INITP_xx are for the parity bits
INITP_00 => X"0000000000000000000000000000000035353535353535353535353535353535",
INITP_01 => X"0000000000000000000000000000000035353535353535353535353535353535",
INITP_02 => X"0000000000000000000000000000000035353535353535353535353535353535",
INITP_03 => X"0000000000000000000000000000000035353535353535353535353535353535",
INITP_04 => X"0000000000000000000000000000000035353535353535353535353535353535",
INITP_05 => X"0000000000000000000000000000000035353535353535353535353535353535",
INITP_06 => X"0000000000000000000000000000000035353535353535353535353535353535",
INITP_07 => X"0000000000000000000000000000000000000000000000000000000000000000")
port map (ADDR => Addr, DI => DI(15 downto 0), DIP => DI(17 downto 16), DO => DO(15 downto 0),
DOP => DO(17 downto 16), CLK => Clk, EN => E, SSR => SSR, WE => WE);
end Behavior;