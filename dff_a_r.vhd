-- source: http://www.asic-world.com/examples/vhdl/d_ff.html
-- D flip-flop async reset
library IEEE;
USE IEEE.STD_LOGIC_1164.ALL;

entity DFlipFlop_A_R is
	port (	C: in STD_LOGIC; -- Takt
			D: in STD_LOGIC; -- Dateneingang
			R: in STD_LOGIC; -- Rﬂcksetzen
			Q: out STD_LOGIC); -- Datenausgang
end DFlipFlop_A_R;

architecture Behavior of DFlipFlop_A_R is
	begin
    process (C, R)
    begin
        if R = '0' then
            Q <= '0';
        elsif (rising_edge(C)) then
            q <= D;
        end if;
    end process;
end Behavior;