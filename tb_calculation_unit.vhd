
LIBRARY ieee;
USE ieee.std_logic_1164.ALL;

ENTITY tb_calculation_unit IS
END tb_calculation_unit;
 
ARCHITECTURE behavior OF tb_calculation_unit IS 
 
    -- Component Declaration for the Unit Under Test (UUT)
 
    COMPONENT CalculationUnit
    PORT(
         A : IN  std_logic_vector(7 downto 0);
         B : IN  std_logic_vector(7 downto 0);
         Ci : IN  std_logic;
         Q : OUT  std_logic_vector(7 downto 0);
         Co : OUT  std_logic;
         Zo : OUT  std_logic;
         Opcode : IN  std_logic_vector(4 downto 0);
         ShiftCode : IN  std_logic_vector(3 downto 0)
        );
    END COMPONENT;
    

   --Inputs
   signal A : std_logic_vector(7 downto 0) := (others => '0');
   signal B : std_logic_vector(7 downto 0) := (others => '0');
   signal Ci : std_logic := '0';
   signal Opcode : std_logic_vector(4 downto 0) := (others => '0');
   signal ShiftCode : std_logic_vector(3 downto 0) := (others => '0');

 	--Outputs
   signal Q : std_logic_vector(7 downto 0);
   signal Co : std_logic;
   signal Zo : std_logic;
 
BEGIN
 
	-- Instantiate the Unit Under Test (UUT)
   uut: CalculationUnit PORT MAP (
          A => A,
          B => B,
          Ci => Ci,
          Q => Q,
          Co => Co,
          Zo => Zo,
          Opcode => Opcode,
          ShiftCode => ShiftCode
        );
		  
-- Testen von Arithmetic Unit unter Calculation Unit

--Opcode <= "01100", "01101" after 15ns, "01101" after 30ns, "01110" after 45ns, "01111" after 60ns, "01111" after 75ns;
--A <= "11111110", "10000001" after 45ns;
--B <= "00000001";
--Ci <= 'U', '0' after 15ns, '1' after 30ns, 'U' after 45ns, '0' after 60ns, '1' after 75ns;
--ShiftCode <= "0000";

-- Testen von Shift Unit unter Calculation Unit

--P_A: process
--	begin
--		A <= "10100101";
--		wait for 16ns;
--		A <= "01001010";
--		wait for 16ns;
--		A <= "10100101";
--		wait for 16ns;
--		A <= "01001011";
--		wait for 16ns;
--		A <= "00100101";
--		wait for 16ns;
--		A <= "01001011";
--		wait for 16ns;
--		A <= "10100101";
--		wait for 16ns;
--		A <= "01001010";
--		wait for 16ns;
--		A <= "00100101";
--		wait for 16ns;
--		A <= "01001011";
--		wait for 16ns;
--	end process;
--	
--B <= "UUUUUUUU";
--
--Opcode <= "10000";
--Ci <= '0', '1' after 16ns, '0' after 32ns, '1' after 48ns, '0' after 80ns, '1' after 96ns, '0' after 128ns;
--ShiftCode <= "000U",
--				 "100U" after 16ns,
--				 "001U" after 32ns,
--				 "101U" after 48ns,
--				 "010U" after 64ns,
--				 "110U" after 80ns,
--				 "0110" after 96ns,
--				 "1110" after 112ns,
--				 "0111" after 128ns,
--				 "1111" after 144ns;

-- Testen von Logic Unit unter Calculation Unit

--A <= "01010101";
--B <= "00110011", "00110101" after 80ns;
--Opcode <= "01000", "01001" after 16ns, "01010" after 32ns, "01011" after 48ns, "00101" after 64ns;
--ShiftCode <= "0000";
--Ci <= '0';




END;
