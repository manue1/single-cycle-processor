library IEEE;
use IEEE.STD_LOGIC_1164.ALL;

entity LogicUnit is
	generic (width: integer := 8);
	port (-- Datenleitungen
			A: in STD_LOGIC_VECTOR (width - 1 downto 0); -- Operand 1
			B: in STD_LOGIC_VECTOR (width - 1 downto 0); -- Operand 2
			Q: out STD_LOGIC_VECTOR (width - 1 downto 0); -- Ergebnis
			Co: out STD_LOGIC; -- Ubertrag
		  -- Steuerleitungen
			Op: in STD_LOGIC_VECTOR (1 downto 0); 	-- Bits 14 und 13 des Befehlskodes
																-- 01 -> AND, TEST
																-- 10 -> OR
																-- 11 -> XOR
			Test: in STD_LOGIC);		-- Bit 15 des Befehlskodes
											-- 0 -> TEST
											-- 1 -> AND, OR, XOR 
end LogicUnit;

architecture Behavior of LogicUnit is
	signal result: STD_LOGIC_VECTOR (width - 1 downto 0);
	signal c: STD_LOGIC;	-- c = 0 bei logischen Operationen
	
begin

		-- Erzeugung des Ubertrages
	process (result)
	begin
		C <= '0';
		for i in result'RANGE loop
			if (Test = '0') then
				c <= c xor result(i);			-- c = 1 bei ungerader Eins-Paritaet 
			end if;
		end loop;
	end process;
		
	-- Logische Operationen
	process (Op)
		begin
			if (Op = "01") then
				result <= (A and B);
			elsif (Op = "10") then
				result <= (A or B);
			elsif (Op = "11") then
				result <= (A xor B);
			else result <= "XXXXXXXX";
			end if;
	end process;
	
	Q <= result;
	Co <= C;
end Behavior;