
library IEEE;
use IEEE.STD_LOGIC_1164.ALL;

entity CalculationUnit is
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
	
-- Eingangs-Operand als signal
signal s_operand1: STD_LOGIC_VECTOR (width - 1 downto 0);
signal s_operand2: STD_LOGIC_VECTOR (width - 1 downto 0);

-- Eingang Ci als intern Signal
signal s_ci: STD_LOGIC;

-- Eingang Opcode und ShiftCode als interne Signale
signal s_opcode: STD_LOGIC_VECTOR (4 downto 0);
signal s_shiftcode: STD_LOGIC_VECTOR (3 downto 0);

-- Opcode auslesen fuer 3 zu 1 Multiplexer Eingang
signal opcode_mux: STD_LOGIC_VECTOR (1 downto 0);
	
-- Ausgangssignal fuer Co alle Units
signal Co_Arithmetic: STD_LOGIC;
signal Co_Logic: STD_LOGIC;
signal Co_Shift: STD_LOGIC;

-- Intern Signal fuer Co
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

begin

-- Zuweisung Eingang Opcode und ShiftCode als interne Signale
s_opcode <= Opcode;
s_shiftcode <= ShiftCode;

	-- Umschaltung der Opcode fuer Multiplexer
OP_FILTER: process (s_opcode)
				begin
					if (s_opcode(4) = '1') then
						opcode_mux <= "10";
					elsif (s_opcode(3) = '0') then
						opcode_mux <= "01";
					elsif (s_opcode(2) = '1') then
						opcode_mux <= "00";
					elsif (s_opcode(1) = '1') then
						opcode_mux <= "01";
					else opcode_mux <= "01";
					end if;
				end process OP_FILTER;
			
	-- Bildung des Zero-Flags
CAL_ZERO: process (result)
				begin
					zero_flag <= '0';
					for i in result'RANGE loop
						zero_flag <= zero_flag or result(i);
					end loop;
					Zo <= not zero_flag;
			 end process CAL_ZERO;
					
-- Zuweisung des Eingangsoperand nach interne Signale
s_operand1 <= A;
s_operand2 <= B;

-- Zuweisung Eingangs-Ci als intern Signal
s_ci <= Ci;

Arithmetic_Unit: ArithmeticUnit
	generic map (data_width => width)
	port map (A => s_operand1, B => s_operand2, Ci => s_ci, Q => Q_Arithmetic,
				 Co => Co_Arithmetic, Op => s_opcode (1 downto 0));

P_TEST: process (s_opcode)
			  begin
				  if (s_opcode(3 downto 2) = "10") then
						s_test <= '1';
				  else s_test <= '0';
				  end if;
			  end process P_TEST;
									
Logic_Unit : LogicUnit
	generic map (width => width)
	port map (A => s_operand1, B => s_operand2, Q => Q_Logic, Co => Co_Logic,
				 Op => s_opcode (1 downto 0), Test => s_test);
	
Shift_Unit: ShiftUnit
	generic map (width => width)
	port map (A => s_operand1, Ci => s_ci, Q => Q_Shift, Co => Co_Shift,
				 Op => s_shiftcode (2 downto 1), Dir => s_shiftcode(3),
				 ExtBit => s_shiftcode(0));

-- Multiplexer 3 zu 1 fuer Uebertrag zwischen Arithmetic, Logic und Shift
MUX_Co : Multiplexer
	port map (A => Co_Arithmetic, B => Co_Logic,
				 C => Co_Shift, Q => s_co, S => opcode_mux);

-- Multiplexer 3 zu 1 fuer Ergebnis zwischen Arithmetic, Logic und Shift
RESULT_MUX: for i in result'RANGE generate
	MUX_Q: Multiplexer
	port map (A => Q_Arithmetic(i),
				 B => Q_Logic(i),
				 C => Q_Shift(i),
				 Q => result(i),
				 S => opcode_mux);
end generate RESULT_MUX;

Q <= result;
Co <= s_co;

end Behavioral;