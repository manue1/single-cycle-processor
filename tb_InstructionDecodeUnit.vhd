
LIBRARY ieee;
USE ieee.std_logic_1164.ALL;
 
ENTITY tb_InstructionDecodeUnit IS
END tb_InstructionDecodeUnit;
 
ARCHITECTURE behavior OF tb_InstructionDecodeUnit IS 
 
    -- Component Declaration for the Unit Under Test (UUT)
 
    COMPONENT InstructionDecodeUnit
    PORT(
         Instruction : IN  std_logic_vector(17 downto 0);
         Address : OUT  std_logic_vector(9 downto 0);
         IEBit : OUT  std_logic;
         Operand1 : OUT  std_logic_vector(7 downto 0);
         Operand2 : OUT  std_logic_vector(7 downto 0);
         Result : IN  std_logic_vector(7 downto 0);
         Clk : IN  std_logic;
         WriteEnable : IN  std_logic;
         OpCode : OUT  std_logic_vector(4 downto 0);
         ShiftCode : OUT  std_logic_vector(3 downto 0);
         Condition : OUT  std_logic_vector(2 downto 0)
        );
    END COMPONENT;
    

   --Inputs
   signal Instruction : std_logic_vector(17 downto 0) := (others => '0');
   signal Result : std_logic_vector(7 downto 0) := (others => '0');
   signal Clk : std_logic := '0';
   signal WriteEnable : std_logic := '0';

 	--Outputs
   signal Address : std_logic_vector(9 downto 0);
   signal IEBit : std_logic;
   signal Operand1 : std_logic_vector(7 downto 0);
   signal Operand2 : std_logic_vector(7 downto 0);
   signal OpCode : std_logic_vector(4 downto 0);
   signal ShiftCode : std_logic_vector(3 downto 0);
   signal Condition : std_logic_vector(2 downto 0);

   -- Clock period definitions
   constant Clk_period : time := 10 ns;
 
BEGIN
 
	-- Instantiate the Unit Under Test (UUT)
   uut: InstructionDecodeUnit PORT MAP (
          Instruction => Instruction,
          Address => Address,
          IEBit => IEBit,
          Operand1 => Operand1,
          Operand2 => Operand2,
          Result => Result,
          Clk => Clk,
          WriteEnable => WriteEnable,
          OpCode => OpCode,
          ShiftCode => ShiftCode,
          Condition => Condition
        );

   -- Clock process definitions
   Clk_process :process
   begin
		Clk <= '0';
		wait for Clk_period/2;
		Clk <= '1';
		wait for Clk_period/2;
   end process;
 
   Instruction <= "UUUUUUUUUUUUUUUUUU", "000000000100001010" after 6ns, "111100000000000001" after 16ns, "000001110000010000" after 26ns, "100000000100001111" after 36ns, "110101110110101110" after 46ns, "110100001001010011" after 56ns;
   WriteEnable <= '1' after 7ns, '0' after  17ns, '1' after 27ns, '0' after 47ns;
   Result <= "00000001" after 6ns;
	
END;
