library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
-- Voll-Subtrahierer
entity Full_Subtracter is
port (M: in STD_LOGIC; —— Minuend
S: in STD_LOGIC; —— Subtrahend
Ci: in STD_LOGIC; —- Ubertrag am Eingang
Q: out STD_LOGIC; —— Ergebnis
Co: out STD_LOGIC); -— Ubertrag am Ausgang
end Full_Subtracter;
-- vollstandig logikbasierter Subtrahierer
architecture Logic_Subtracter of Full_Subtracter is
begin
Q <= M xor S xor Ci;
Co <= ((not M) and S) or (((not M) or S) and Ci);
end Logic_Subtracter;

