-- source: http://www.asic-world.com/examples/vhdl/d_ff.html
-- D flip-flop async reset

library IEEE;
USE IEEE.STD_LOGIC_1164.ALL;

entity DFlipFlop_A_S is
	port (	C: in STD_LOGIC; -- Takt
				D: in STD_LOGIC; -- Dateneingang
				S: in STD_LOGIC; -- Setzen
				Q: out STD_LOGIC); -- Datenausgang
end DFlipFlop_A_S;

architecture Behavior of DFlipFlop_A_S is
	begin
    process (C, S)
    begin
        if S = '1' then
            Q <= '1';
        elsif (rising_edge(C)) then
            Q <= D;
        end if;
    end process;
end Behavior;