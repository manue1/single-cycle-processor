
library IEEE;
use IEEE.STD_LOGIC_1164.ALL;

entity CalculationUnit is
	generic (width: integer := 8;
			 cmd_width: integer := 18);			-- Verarbeitungsbreite
	port (-- Datenleitungen
		  A: in STD_LOGIC_VECTOR (width - 1 downto 0);	-- Operand 1
		  B: in STD_LOGIC_VECTOR (width - 1 downto 0);	-- Operand 2
		  Instruction: in STD_LOGIC_VECTOR (cmd_width - 1 downto 0);
		  Ci: in STD_LOGIC;										-- Uebertrag am Eingang
		  Q: out STD_LOGIC_VECTOR (width - 1 downto 0);	-- Ergebnis
		  Co: out STD_LOGIC;										-- Uebertrag
		  Zo: out STD_LOGIC);										-- Zero flag
		  -- Steuerleitungen
		  -- Opcode: in STD_LOGIC_VECTOR (4 downto 0);		-- This information is received from instruction decode unit
																	
				-- 													-- Arithmetic Unit --
				-- 													-- Bits 14 und 13 des Befehlskodes
				-- 													-- 00 -> ADD
				-- 													-- 01 -> ADDCY
				-- 													-- 10 -> SUB, COMPARE
				-- 													-- 11 -> SUBCY
																	
				-- 													-- Logic Unit --
				-- 													-- Bits 14 und 13 des Befehlskodes
				-- 													-- 01 -> AND, TEST
				-- 													-- 10 -> OR
				-- 													-- 11 -> XOR
			-- ShiftCode: in STD_LOGIC_VECTOR (3 downto 0)); -- Kodierung des Schiebe- und Rotationsbefehls
			-- 															  -- Shift Unit
			-- 															  -- Bits 2 und 1 des Befehlskodes
			-- 															  -- 00 -> SLA, SEA
			-- 															  -- 01 -> RL, SEX
			-- 															  -- 10 -> SLX, RR
			-- 															  -- 11 -> SLO, SL1, SRO, SR1
																	
end CalculationUnit;

architecture Behavioral of CalculationUnit is

	component Multiplexer is
	port (	-- Datenleitungen
			A: in STD_LOGIC; -- Eingang 1
			B: in STD_LOGIC; -- Eingang 2
			C: in STD_LOGIC; -- Eingang 3
			Q: out STD_LOGIC; --Ausgang
			-- Steuerleitungen
			S: in STD_LOGIC_VECTOR (1 downto 0));
	end component;
	
		-- Ausgangssignale der Multiplexer im Datenpfad
	signal d_mux_out_1: STD_LOGIC_VECTOR (width - 1 downto 0);
	signal d_mux_out_2: STD_LOGIC_VECTOR (width - 1 downto 0);
	signal s_carry: STD_LOGIC;

	component ArithmeticUnit is
		generic (data_width: integer := 8);							-- Verarbeitungsbreite
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
	end component;

	component LogicUnit is
		generic (width: positive);
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
	end component;

	component ShiftUnit is
		generic (width: positive);		-- Verarbeitungsbreite (> 1) 
		port (	-- Datenleitungen
				A: in STD_LOGIC_VECTOR (width - 1 downto 0);	-- Operand 
				Ci: in STD_LOGIC;								-- Carry Flag am Eingang 
				Q: out STD_LOGIC_VECTOR (width - 1 downto 0);	-- Ergebnis 
				Co: out STD_LOGIC; 								-- Carry Flag am Ausgang 
				-- Steuerleitungen
				Op: in STD_LOGIC_VECTOR (1 downto 0);			-- Bits 2 und 1 des Befehlskodes
																			-- 00 -> SLA, SEA
																			-- 01 -> RL, SEX
																			-- 10 -> SLX, RR
																			-- 11 -> SLO, SL1, SRO, SR1 
				Dir: in STD_LOGIC;			-- Bit 3 des Befehlskodes
													-- 0 -> Links
													-- 1 -> Rechts
				ExtBit: in STD_LOGIC);	-- Bit 0 des Befehlskodes
												-- 0 -> SLO, SRO
												-- 1 -> SLI, SRI 
	end component;

	
-- Ausgangssignal fuer Co alle Units
signal Co_Arithmetic: STD_LOGIC;
signal Co_Logic: STD_LOGIC;
signal Co_Shift: STD_LOGIC;
signal s_co: STD_LOGIC;

-- Intern Test Signal
signal s_test: STD_LOGIC;

-- Ausgangssignal fuer Q alle Units
signal Q_Arithmetic: STD_LOGIC_VECTOR (width - 1 downto 0);
signal Q_Logic: STD_LOGIC_VECTOR (width - 1 downto 0);
signal Q_Shift: STD_LOGIC_VECTOR (width - 1 downto 0);

-- Result array
signal result: STD_LOGIC_VECTOR (width - 1 downto 0);
signal zero_flag: STD_LOGIC;

signal s_demux_1: STD_LOGIC;
signal s_demux_2: STD_LOGIC;

signal s_arithlog: STD_LOGIC_VECTOR (width - 1 downto 0);

begin
			
	-- Bildung des Zero-Flags
CAL_ZERO: process (result)
				begin
					zero_flag <= '0';
					for i in result'RANGE loop
						zero_flag <= zero_flag or result(i);
					end loop;
					Zo <= not zero_flag;
			 end process CAL_ZERO;

Arithmetic_Unit: ArithmeticUnit
	generic map (data_width => width)
	port map (A => A, B => B, Ci => Ci, Q => Q_Arithmetic,
				 Co => Co_Arithmetic, Op => Instruction(14 downto 13));

Logic_Unit : LogicUnit
	generic map (width => width)
	port map (A => A, B => B, Q => Q_Logic, Co => Co_Logic,
				 Op => Instruction(14 downto 13), Test => Instruction(15));
	
Shift_Unit: ShiftUnit
	generic map (width => width)
	port map (A => A, Ci => Ci, Q => Q_Shift, Co => Co_Shift,
				 Op => Instruction(2 downto 1), Dir => Instruction(3),
				 ExtBit => Instruction(0));

-- Ergebnis Multiplexer

s_demux_1 <= (Instruction(16) and (Instruction(15) or Instruction(14)));
s_demux_2 <= Instruction(17);

s_arithlog <= Q_Arithmetic when s_demux_1 = '1' else
				  Q_Logic when s_demux_1 = '0' else
				  "XXXXXXXX";
			
result <= s_arithlog when s_demux_2 = '0' else 
			 Q_Shift when s_demux_2 = '1' else
			 "XXXXXXXX";
			 
Q <= result;

-- Carry Flag Multiplexer	

s_carry <= 	Co_Arithmetic when s_demux_1 = '1' else
			Co_Logic when s_demux_1 = '0' else
		    'X';
			
s_co <= s_carry when s_demux_2 = '0' else 
		Co_Shift when s_demux_2 = '1' else
		'X';

Co <= s_co;

end Behavioral;