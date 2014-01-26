
library IEEE;
use IEEE.STD_LOGIC_1164.ALL;

entity ArithmeticLogicUnit is
	 Generic (data_width: positive);
    Port ( A : in  STD_LOGIC_VECTOR (data_width - 1 downto 0);
           B : in  STD_LOGIC_VECTOR (data_width - 1 downto 0);
           Clk : in  STD_LOGIC;
			  Reset : in  STD_LOGIC;
           ShiftCode : in  STD_LOGIC_VECTOR (3 downto 0);
           OpCode : in  STD_LOGIC_VECTOR (4 downto 0);
           Result : out  STD_LOGIC_VECTOR (data_width - 1 downto 0);
           ZF : out  STD_LOGIC;
           CF : out  STD_LOGIC);
end ArithmeticLogicUnit;

architecture Behavioral of ArithmeticLogicUnit is

	component CalculationUnit is
		generic (width: integer := 8);			-- Verarbeitungsbreite
		port (-- Datenleitungen
			  A: in STD_LOGIC_VECTOR (width - 1 downto 0);	-- Operand 1
			  B: in STD_LOGIC_VECTOR (width - 1 downto 0);	-- Operand 2
			  Ci: in STD_LOGIC;										-- Uebertrag am Eingang
			  Q: out STD_LOGIC_VECTOR (width - 1 downto 0);	-- Ergebnis
			  Co: out STD_LOGIC;										-- Uebertrag
			  Zo: out STD_LOGIC;										-- Zero flag
			  -- Steuerleitungen
			  Opcode: in STD_LOGIC_VECTOR (4 downto 0);		-- This information is received from instruction decode unit
																		
																		-- Arithmetic Unit --
																		-- Bits 14 und 13 des Befehlskodes
																		-- 00 -> ADD
																		-- 01 -> ADDCY
																		-- 10 -> SUB, COMPARE
																		-- 11 -> SUBCY
																		
																		-- Logic Unit --
																		-- Bits 14 und 13 des Befehlskodes
																		-- 01 -> AND, TEST
																		-- 10 -> OR
																		-- 11 -> XOR
				ShiftCode: in STD_LOGIC_VECTOR (3 downto 0)); -- Kodierung des Schiebe- und Rotationsbefehls
																			  -- Shift Unit
																			  -- Bits 2 und 1 des Befehlskodes
																			  -- 00 -> SLA, SEA
																			  -- 01 -> RL, SEX
																			  -- 10 -> SLX, RR
																			  -- 11 -> SLO, SL1, SRO, SR1
																		
	end component;
	
	component FlagRegister is
		port (-- Datenleitungen
				Ci: in STD_LOGIC; -- Eingang de: Carry-Flags
				Co: out STD_LOGIC; -- Ausgang des Carry-Flags
				Zi: in STD_LOGIC; -- Eingang des Zero-Flags
				Zo: out STD_LOGIC; -- Ausganq des Zero-Flags
				IEi: in STD_LOGIC; -- Eingang des Interrupt-Enable-Flags
				IEo: out STD_LOGIC; -- Ausgang des Intenrupt-Enable-Flags
				-- Steuerleitungen
				Clk: in STD_LOGIC; -- Takt
				Reset: in STD_LOGIC; -- Rucksetzen
				WE: in STD_LOGIC; -- Schreibfreigabe fur carry- und Zero-Flag
				IEWE: in STD_LOGIC; -- Schreibfreigabe fur Interrupt-Enable-Flag
				IntCode: in STD_LOGIC_VECTOR (1 downto 0)); -- Steuersignal bei Interrupts
				-- 00 -> normaler Programmablauf
				-- 10 -> Beginn einer Unterbrechung
				-- 01 -> Ende ener Unterbrechung
	end component;

-- Calculation Unit
signal s_result_out: STD_LOGIC_VECTOR (data_width - 1 downto 0);

-- Flag Register
signal s_cf_zf_write_enable: STD_LOGIC;

signal s_cf_flagregister_out: STD_LOGIC;
signal s_zf_flagregister_out: STD_LOGIC;
signal s_zf_calcunit_out: STD_LOGIC;
signal s_cf_calcunit_out: STD_LOGIC;

-- Interrupt signal von Flag Register
signal s_int_enable_out: STD_LOGIC;

begin


Calculation_Unit: CalculationUnit
	generic map (width => data_width)
	port map (A => A, B => B,
				 Ci => s_cf_flagregister_out,
				 Q => s_result_out, Co => s_cf_calcunit_out,
				 Zo => s_zf_calcunit_out, Opcode => OpCode,
				 ShiftCode => ShiftCode);

-- Write enable signal fuer Flag Register
s_cf_zf_write_enable <= OpCode(4) xor (OpCode(3) or OpCode(2));

Flag_Register: FlagRegister
	port map (Ci => s_cf_calcunit_out,
				 Co => s_cf_flagregister_out,
				 Zi => s_zf_calcunit_out,
				 Zo => s_zf_flagregister_out,
				 IEi => '0',
				 IEo => s_int_enable_out,
				 Clk => Clk, Reset => Reset,
				 WE => s_cf_zf_write_enable,
				 IEWE => '0',
				 IntCode => "00");
				 
result <= s_result_out;
CF <= s_cf_flagregister_out;
ZF <= s_zf_flagregister_out;

end Behavioral;