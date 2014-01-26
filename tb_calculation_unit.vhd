
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

Opcode <= "01100", "01101" after 15ns, "01101" after 30ns, "01110" after 45ns, "01111" after 60ns, "01111" after 75ns;
A <= "11111110", "10000001" after 45ns;
B <= "00000001";
Ci <= 'U', '0' after 15ns, '1' after 30ns, 'U' after 45ns, '0' after 60ns, '1' after 75ns;
ShiftCode <= "0000";



END;
