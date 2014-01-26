library IEEE;
use IEEE.STD_LOGIC_1164.ALL;

entity ArithmeticUnit is
	generic (data_width : integer := 8);							-- Verarbeitungsbreite
	port (-- Datenleitungen
		  A: in STD_LOGIC_VECTOR (data_width - 1 downto 0);	-- Operand 1
		  B: in STD_LOGIC_VECTOR (data_width - 1 downto 0);	-- Operand 2
		  Ci: in STD_LOGIC;										-- Uebertrag am Eingang
		  Q: out STD_LOGIC_VECTOR (data_width - 1 downto 0);	-- Ergebnis
		  Co: out STD_LOGIC;										-- Uebertrag
		  -- Steuerleitungen
		  Op: in STD_LOGIC_VECTOR (1 downto 0));		-- Bits 14 und 13 des Befehlskodes
																	-- 00 -> ADD
																	-- 01 -> ADDCY
																	-- 10 -> SUB, COMPARE
																	-- 11 -> SUBCY
end ArithmeticUnit;

architecture Behavior of ArithmeticUnit is
	-- Addierer (ADD)
	component Full_Adder
		port (E1: in STD_LOGIC;
				E2: in STD_LOGIC;
				Ci: in STD_LOGIC;
				Q: out STD_LOGIC;
				Co: out STD_LOGIC);
	end component Full_Adder;

	-- Addierer (ADDCY)
	component Full_Adder_3
		generic (width: positive);
		port (A: in STD_LOGIC_VECTOR (data_width - 1 downto 0);
				B: in STD_LOGIC_VECTOR (data_width - 1 downto 0);
				Q: out STD_LOGIC_VECTOR (data_width - 1 downto 0);
				Co: out STD_LOGIC);
	end component;
	
	-- Substrahierer (SUB) und COMPARE
	component Full_Subtracter
		port (M: in STD_LOGIC; -- Minuend
				S: in STD_LOGIC; -- Subtrahend
				Ci: in STD_LOGIC; -- Ubertrag am Eingang
				Q: out STD_LOGIC; -- Ergebnis
				Co: out STD_LOGIC); -- Ubertrag am Ausgang
	end component;
	
	-- Substrahierer (SUBCY)
	component Full_Subtracter_3
		generic (width: positive);
		port (M: in STD_LOGIC_VECTOR (data_width - 1 downto 0);
				S: in STD_LOGIC_VECTOR (data_width - 1 downto 0);
				Q: out STD_LOGIC_VECTOR (data_width - 1 downto 0);
				Co: out STD_LOGIC);
	end component;

-- Eingangssignal des Addierers und des Substrahierers
signal op1: STD_LOGIC_VECTOR (data_width - 1 downto 0);

-- Uebertrag am Eingang des Addierers und des Substrahierers
signal cyi: STD_LOGIC;

-- Ergebnis des Addierers und des Substrahierers
signal result: STD_LOGIC_VECTOR (data_width - 1 downto 0);

-- 2-zu-1 Multiplexer
component Multiplexer_2_to_1
	port (A, B: in STD_LOGIC;
		  Y: out STD_LOGIC;
		  S: in STD_LOGIC);
end component Multiplexer_2_to_1;

begin
	-- Umschaltung des 1. Operanden
	process (Op, A)
	begin
		for i in A'RANGE loop
			op1(i) <= A(i) xor Op(1);
		end loop;
	end process;

	-- Umschaltung des Eingangsuebertrages
	CI_MUX: Multiplexer_2_to_1 port map(A => '0', B => Ci, Y => cyi, S => Op(0));

	-- Komponente zum Addieren --
	
	-- ADD Komponent

G_ADD: for i in result'RANGE generate
	ADD: Full_Adder
		port map(E1 => op1(i), E2 => B(i), Ci => cyi, Q => result(i), Co => Co);
end generate G_ADD;
		
	-- ADDCY Komponent
	
--	ADDCY: Full_Adder_3
--		generic map (width => data_width)
--		port map(A => op1, B => B, Q => result, Co => Co);
		
	-- Komponente zum Substrahieren --

	-- SUB und COMPARE Komponent

--G_SUB: for i in op1'RANGE generate
--	SUB: Full_Subtracter
--		port map(M => op1(i), S => B(i), Ci => cyi, Q => result(i), Co => Co);
--end generate G_SUB;
		
	-- SUBCY Komponent
--	
--	SUBCY: Full_Subtracter_3
--		generic map (width => data_width)
--		port map(M => op1, S => B, Q => result, Co => Co);

	-- Umschaltung des Ergebnisses
	process (Op, result)
	begin
		for i in result'RANGE loop
			Q(i) <= result(i) xor Op(1);
		end loop;
	end process;
end Behavior;