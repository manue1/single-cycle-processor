
library IEEE;
use IEEE.STD_LOGIC_1164.ALL;

package dff_lib is

component DFF_RS is
	port (	R: in STD_LOGIC;
			S: in STD_LOGIC;
			C: in STD_LOGIC;
			D: in STD_LOGIC;
			Q: out STD_LOGIC);
end component;

end dff_lib;

-- End of D Flip Flop Library

-- DFF mit asynchroner Steuerung

library IEEE;
use IEEE.STD_LOGIC_1164.ALL;

entity DFF_RS is
	port (	R: in STD_LOGIC;
			S: in STD_LOGIC;
			C: in STD_LOGIC;
			D: in STD_LOGIC;
			Q: out STD_LOGIC);
end DFF_RS;

architecture Behavior_1 of DFF_RS is
	signal outp: STD_LOGIC;
begin
	P1: process (R, S, C)
	begin
		if (R = '1') then
			outp <= '0';
		elsif (S = '1') then
			outp <= '1';
		elsif (rising_edge (C)) then
			outp <= D;
		end if;
	end process P1;
	Q <= outp;
end Behavior_1;

architecture Behavior_2 of DFF_RS is
begin
	P1: process (R, S, C)
	begin
		if (R = '1') then
			Q <= '0';
		elsif (S = '1') then
			Q <= '1';
		elsif (rising_edge (C)) then
			Q <= D;
		end if;
	end process P1;
end Behavior_2;

architecture Behavior_3 of DFF_RS is
	signal outp: STD_LOGIC;
begin
	outp <= '0' when (R = '1')
		else '1' when (S = '1')
		else D when (rising_edge (C));
	Q <= outp;
end Behavior_3;

-- DFF mit synchroner Steuerung

architecture Behavior_4 of DFF_RS is
	signal outp: STD_LOGIC;
begin
	P1: process (R, S, C)
	begin
		if (rising_edge (C)) then
			if (R = '1') then
				outp <= '0';
			elsif (S = '1') then
				outp <= '1';
			else
				outp <= D;
			end if;
		end if;
	end process P1;
	Q <= outp;
end Behavior_4;