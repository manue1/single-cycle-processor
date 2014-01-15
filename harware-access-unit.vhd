library IEEE;
use IEEE.STD_LOGIC_1164.ALL;

entity HardwareAccessUnit is
generic (data_width: positive); —- Datenbreite
port (-- Datenleitungen
OPERAND_1: in STD_LOGIC_VECTOR (data_width — 1 downto O); —— Operand 1
OPERAND_2: in STD_LOGIC_VECTOR (data_width - 1 downto 0); —— Operand 2
RESULT: out STD_LOGIC_VECTOR (data_width - 1 downto 0); -- Ergebnis
—— Ports
IN_PORT: in STD_LOGIC_VECTOR (data_width — 1 downto 0); -- Dateneingang
PORT_ID: out STD_LOGIC_VECTOR (data_width - 1 downto 0); -- Hardware-Adresse
OUT_PORT: out STD_LOGIC_VECTOR (data_width - 1 downto 0); -- Datenausgang
—— Steuerleitungen
CLK: in STD_LOGIC; -- Takt
WAIT_CNTRL: in STD_LOGIC; -- Abarbeitungszyklus verlaengern
Strobe: out STD_LOGIC: —- Lese— oder Schreibsteuerung
READ_STROBE: out STD_LOGIC; —— Lesesteuerung
WRITE_STROBE: out STD_LOGIC; —— Schreibsteuerung
OP_CODE: in STD_LOGIC): —— Bits 17 des Befehlskodes
-- 0 -> INPUT
-- 1 -> OUTPUT
end HardwareAccessUnit;

architecture Behavioral of HardwareAccessUnit is
—— D—Flip-Flop mit Rucksetz— und Freigabeeingang
component DFlipFlop_RE
port (C, D, E, R: in STD_LOGIC;
Q: out STD_LOGIC);
end component DFlipFlop_RE;

signal reset: STD_LOGIC;
signal data_in: STD_LOGIC;
signal int_strobe: STD_LOGIC;
begin
-- Ports steuern
PORT_ID <= OPERAND_2;
OUT_PORT <= OPERAND_1;
RESULT <= IN_PORT;

—— Lese— und Schreibsteuerung
reset <= not WAIT_CNTRL;
data_in <= not int_strobe;
CONTROL_DFF: DFlipFlop_RE
port map (C => CLK, D => data_in, B => WAIT_CNTRL, R => reset, Q => int_strobe);
Strobe <= int_strobe;
READ_STROBE <= int_strobe when OP_CODE = '0‘ else '0';
WRITE_STROBE <= int_strobe when OP_CODE = '1' else '0':
end Behavioral;