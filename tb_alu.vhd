
LIBRARY ieee;
USE ieee.std_logic_1164.ALL;
 
ENTITY tb_alu IS
END tb_alu;
 
ARCHITECTURE behavior OF tb_alu IS 
 
    -- Component Declaration for the Unit Under Test (UUT)
 
    COMPONENT ArithmeticLogicUnit
	 Generic (data_width: integer := 8;
				 cmd_width: integer := 18);
    PORT(
         A : IN  std_logic_vector(data_width - 1 downto 0);
         B : IN  std_logic_vector(data_width - 1 downto 0);
         Clk : IN  std_logic;
         Reset : IN  std_logic;
         Instruction: IN std_logic_vector (cmd_width - 1 downto 0);
         Result : OUT  std_logic_vector(data_width - 1 downto 0);
         ZF : OUT  std_logic;
         CF : OUT  std_logic
        );
    END COMPONENT;
    

   --Inputs
   signal A : std_logic_vector(7 downto 0) := (others => '0');
   signal B : std_logic_vector(7 downto 0) := (others => '0');
	signal Instruction : std_logic_vector(17 downto 0) := (others => '0');
   signal Clk : std_logic := '0';
   signal Reset : std_logic := '0';

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
			 Instruction => Instruction,
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
A <= "11111110", "10000001" after 20ns, "01001010" after 40ns, "10100101" after 60ns, "01010101" after 70ns;
B <= "00000001", "00000011" after 10ns, "00000001" after 20ns, "UUUUUUUU" after 30ns, "00110011" after 40ns, "00110101" after 50ns;
Instruction <= "UUUUUUUUUUUUUUUUUU", "000000000100001010" after 10ns, "111100000000000001" after 20ns, "000001110000010000" after 30ns, "100000000100001111" after 40ns, "110101110110101110" after 50ns, "110100001001010011" after 60ns;
END;
