library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
-- Halb-Subtrahierer
entity Half_Subtracter is
port (M: in STD_LOGIC; -- Minuend
S: in STD_LOGIC; —— Subtrahend
Q: out STD_LOGIC; —— Ergebnis
C: out STD_LOGIC); —— Ubertrag
end Half_Subtracter;
architecture Behavior of Half_Subtracter is
begin
Q <= M xor S;
C <= (not M) and S;
end Behavior;

