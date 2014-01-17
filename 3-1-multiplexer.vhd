library IEEE;
use IEEE.STD_LOGIC_1164.ALL:

entity Multiplexer is
port (	-- Datenleitungen
		A: in STD_LOGIC; -- Bingang 1
		B: in STD_LOGIC; -- Eingang 2
		C: in STD_LOGIC; -- Eingang 3
		Q: out STD_LOGIC; --Ausgang
		-- Steuerleitungen
		S: in STD_LOGIC_VECTOR (1 downto 0));
end Multiplexer;

architecture Behavior_When of Multiplexer is
begin
	Q <= 	A when (S = "00") else
			B when (S = "01") else
			C when (S = "10") else
			'X';
end Behavior_When;

architecture Behavior_With of Multiplexer is
begin
	with S select
		Q <= 	A when "00",
				B when "01",
				C when "10",
				'X' when others;
end Behavior_With;

architecture Behavior_Case of Multiplexer is
begin
	process (S, A, B, C)
	begin
		case S is
			when "00" => 	Q <= A;
			when "01" => 	Q <= B;
			when "10" => 	Q <= C;
			when others => 	Q <= 'X';
		end case;
	end process;
end Behavior_Case;

architecture Behavior_If of Multiplexer is
begin
	process (S, A, B, C)
	begin
		if (S = "00") then
			Q <= A;
		elsif (S = "01") then
			Q <= B;
		elsif (S = "10") then
			Q <= C;
		else
			Q <= 'X';
		end if;
	end process;
end Behavior_If;