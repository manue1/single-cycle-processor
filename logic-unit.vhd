library IEEE;
use IEEE.STD_LOGIC_1164.ALL;

entity LogicUnit is
	generic (width: positive);
	port (-- Datenleitungen
			A: in STD LOGIC VECTOR (width - 1 downto 0); -- Operand 1
			B: in STD LOGIC VECTOR (width - 1 downto 0); -- Operand 2
			Q: out STD LOGIC VECTOR (width - 1 downto 0); -- Ergebnis
			Co: out STD LOGIC; -- Ubertrag
		  -- Steuerleitungen
			Op: in STD LOGIC VECTOR (1 downto 0); 	-- Bits 14 und 13 des Befehlskodes
													-- 01 -> AND, TEST
													-- 10 -> OR
													-- 11 -> XOR
			Test: in STD_LOGIC); 					-- Bit 15 des Befehlskodes
													-- 0 -> TEST
													-- 1 -> AND, OR, XOR 
end LogicUnit;

architecture Behavior of LogicUnit is
	signal result: STD_LOGIC_VECTOR (width - 1 downto 0);
begin
	-- Logische Operationen
	with Op select
		result <= 	(A and B) when "01",
					(A or B) when "10",
					(A xor B) when "11",
					(others => 'X') when others; 
	Q <= result;

	-- Erzeugung des Ubertrages
	process (Test, result)
		variable c: STD_LOGIC:= '0';	-- c = 0 bei logischen Operationen 
	begin
		if (Test = '0') then
			for i in result'RANGE loop
				c := c xor result(i);			-- c = 1 bet ungerader Eins-ParitAt 
			end loop;
		end if; 

		Co <= c;
	end process;
end Behavior; 



