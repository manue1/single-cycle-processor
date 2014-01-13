—— Carry—Look—Ahead—Addierer
architecture Carry_Look_Ahead of Full_Adder_2 is
—— interne Vektoren
signal c: STD_LOGIC_VECTOR (7 downto 0); -— Ubertrage
signal g: STD_LOGIC_VECTOR (7 downto 0); —— generierende Anteil
signal p: STD_LOGIC_VECTOR (7 downto 0); —— propagierender Anteil
begin
—— Halb—Addierer am Eingang
p <= A xor B after 2 ns;
g <= A and B after 2 ns;
—— Carry—Logik (Gatter mit max. 4 Eingangen)
c(0) <= '0‘;
—— c(i) <= g(i - 1) or (p(i - 1) and c(i - 1))
c(1) <= g(0);
c(2) <= g(1) or (p(1) and g(0)) after 4 ns;
c(3) <= g(2) or (p(2) and g(1)) or (p(2) and p(1) and g(0)) after 4 ns;
c(4) <= g(3) or (p(3) and g(2)) or (p(3) and p(2) and g(1))
or (p(3) and p(2) and p(1) and g(0)) after 4 ns;
c(5) <= g(4) or (p(4) and c(4)) after 4 ns;
c(6) <= g(5) or (p(5) and g(4)) or (p(5) and p(4) and c(4)) after 4 ns;
c(7) <= g<6> or (p(6) and g(5)) or (p(6) and p(5) and g(4))
or (p(6) and p(5) and p(4) and c(4)) after 4 ns;
C8 <= g(7) or (p(7) and c(7)) after 4 ns;
—— Ergebnislogik
Q <= p xor c after 2 ns;
end Carry_Look_Ahead;

