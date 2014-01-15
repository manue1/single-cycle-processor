library IEEE;
use IEEE.STD_LOGIC_1164.ALL;

entity ArithmeticUnit is
	generic (width: positive);							-- Verarbeitungsbreite
	port (-- Datenleitungen
		  A: in STD_LOGIC_VECTOR (width - 1 downto 0);	-- Operand 1
		  B: in STD_LOGIC_VECTOR (width - 1 downto 0);	-- Operand 2
		  Ci: in STD_LOGIC;								-- Uebertrag am Eingang
		  Q: out STD_LOGIC_VECTOR (width - 1 downto 0);	-- Ergebnis
		  Co: out STD_LOGIC;							-- Uebertrag
		  -- Steuerleitungen
		  Op: in STD_LOGIC_VECTOR (1 downto 0));		-- Bits 14 und 13 des Befehlskodes
		  												-- 00 -> ADD
		  												-- 01 -> ADDCY
		  												-- 10 -> SUB, COMPARE
		  												-- 11 -> SUBCY
end ArithmeticUnit;

architecture Behavior of ArithmeticUnit is
	-- Addierer
	component Adder
		generic (width: positive);
		port (A, B: in STD_LOGIC_VECTOR (width - 1 downto 0);
			  Ci: in STD_LOGIC;
			  Q: out STD_LOGIC_VECTOR (width - 1 downto 0);
			  Co: out STD_LOGIC);
	end component Adder;

-- Eingangssignal des Addierers
signal op1: STD_LOGIC_VECTOR (width - 1 downto 0);
-- Uebertrag am Eingang des Addierers
signal cyi: STD_LOGIC;
-- Ergebnis des Addierers
signal result: STD_LOGIC_VECTOR (width - 1 downto 0);

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

	-- Komponente zum Addieren
	ADD: Adder
		generic map (width => width)
		port map(A => op1, B => B, Ci => cyi, Q => result, Co => Co);

	-- Umschaltung des Ergebnisses
	process (Op, result)
	begin
		for i in result'RANGE loop
			Q(i) <= result(i) xor Op(1);
		end loop;
	end process;
end Behavior;