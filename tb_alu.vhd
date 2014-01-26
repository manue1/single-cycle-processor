
LIBRARY ieee;
USE ieee.std_logic_1164.ALL;
 
ENTITY tb_alu IS
END tb_alu;
 
ARCHITECTURE behavior OF tb_alu IS 
 
    -- Component Declaration for the Unit Under Test (UUT)
 
    COMPONENT ArithmeticLogicUnit
	 Generic (data_width: integer := 8);
    PORT(
         A : IN  std_logic_vector(data_width - 1 downto 0);
         B : IN  std_logic_vector(data_width - 1 downto 0);
         Clk : IN  std_logic;
         Reset : IN  std_logic;
         ShiftCode : IN  std_logic_vector(3 downto 0);
         OpCode : IN  std_logic_vector(4 downto 0);
         Result : OUT  std_logic_vector(data_width - 1 downto 0);
         ZF : OUT  std_logic;
         CF : OUT  std_logic
        );
    END COMPONENT;
    

   --Inputs
   signal A : std_logic_vector(7 downto 0) := (others => '0');
   signal B : std_logic_vector(7 downto 0) := (others => '0');
   signal Clk : std_logic := '0';
   signal Reset : std_logic := '0';
   signal ShiftCode : std_logic_vector(3 downto 0) := (others => '0');
   signal OpCode : std_logic_vector(4 downto 0) := (others => '0');

 	--Outputs
   signal Result : std_logic_vector(7 downto 0);
   signal ZF : std_logic;
   signal CF : std_logic;

   -- Clock period definitions
   constant Clk_period : time := 10 ns;
 
BEGIN
 
	-- Instantiate the Unit Under Test (UUT)
   uut: ArithmeticLogicUnit PORT MAP (
          A => A,
          B => B,
          Clk => Clk,
          Reset => Reset,
          ShiftCode => ShiftCode,
          OpCode => OpCode,
          Result => Result,
          ZF => ZF,
          CF => CF
        );

   -- Clock process definitions
   Clk_process :process
   begin
		Clk <= '0';
		wait for Clk_period/2;
		Clk <= '1';
		wait for Clk_period/2;
   end process;

Reset <= '0', '1' after 2ns, '0' after 10ns;
Opcode <= "01100", "01101" after 30ns, "10000" after 40ns, "01000" after 70ns, "01001" after 85ns;
A <= "11111110", "10000001" after 30ns, "01001010" after 40ns, "10100101" after 55ns, "01010101" after 70ns;
B <= "00000001", "00000011" after 15ns, "00000001" after 30ns, "UUUUUUUU" after 40ns, "00110011" after 70ns, "00110101" after 85ns;
ShiftCode <= "0000", "100U" after 40ns, "001U" after 55ns, "0000" after 70ns;

END;
