
LIBRARY ieee;
USE ieee.std_logic_1164.ALL;
 
ENTITY tb_hardware_access_unit IS
END tb_hardware_access_unit;
 
ARCHITECTURE behavior OF tb_hardware_access_unit IS 
 
    -- Component Declaration for the Unit Under Test (UUT)
 
    COMPONENT HardwareAccessUnit
	 generic (data_width: integer := 8);
    PORT(
         OPERAND_1 : IN  std_logic_vector(data_width - 1 downto 0);
         OPERAND_2 : IN  std_logic_vector(data_width - 1 downto 0);
         RESULT : OUT  std_logic_vector(data_width - 1 downto 0);
         IN_PORT : IN  std_logic_vector(data_width - 1 downto 0);
         PORT_ID : OUT  std_logic_vector(data_width - 1 downto 0);
         OUT_PORT : OUT  std_logic_vector(data_width - 1 downto 0);
         CLK : IN  std_logic;
         WAIT_CNTRL : IN  std_logic;
         Strobe : OUT  std_logic;
         READ_STROBE : OUT  std_logic;
         WRITE_STROBE : OUT  std_logic;
         OP_CODE : IN  std_logic
        );
    END COMPONENT;
    

   --Inputs
   signal OPERAND_1 : std_logic_vector(7 downto 0) := (others => '0');
   signal OPERAND_2 : std_logic_vector(7 downto 0) := (others => '0');
   signal IN_PORT : std_logic_vector(7 downto 0) := (others => '0');
   signal CLK : std_logic := '0';
   signal WAIT_CNTRL : std_logic := '0';
   signal OP_CODE : std_logic := '0';

 	--Outputs
   signal RESULT : std_logic_vector(7 downto 0);
   signal PORT_ID : std_logic_vector(7 downto 0);
   signal OUT_PORT : std_logic_vector(7 downto 0);
   signal Strobe : std_logic;
   signal READ_STROBE : std_logic;
   signal WRITE_STROBE : std_logic;

   -- Clock period definitions
   constant CLK_period : time := 10 ns;
 
BEGIN
 
	-- Instantiate the Unit Under Test (UUT)
   uut: HardwareAccessUnit PORT MAP (
          OPERAND_1 => OPERAND_1,
          OPERAND_2 => OPERAND_2,
          RESULT => RESULT,
          IN_PORT => IN_PORT,
          PORT_ID => PORT_ID,
          OUT_PORT => OUT_PORT,
          CLK => CLK,
          WAIT_CNTRL => WAIT_CNTRL,
          Strobe => Strobe,
          READ_STROBE => READ_STROBE,
          WRITE_STROBE => WRITE_STROBE,
          OP_CODE => OP_CODE
        );

   -- Clock process definitions
   CLK_process :process
   begin
		CLK <= '0';
		wait for CLK_period/2;
		CLK <= '1';
		wait for CLK_period/2;
   end process;
 
OPERAND_1 <= "UUUUUUUU", "00000001" after 45ns, "UUUUUUUU" after 65ns;
OPERAND_2 <= "UUUUUUUU", "00000010" after 15ns, "00000011" after 45ns, "UUUUUUUU" after 65ns;
IN_PORT <= "UUUUUUUU", "11111111" after 23ns, "UUUUUUUU" after 37ns;
WAIT_CNTRL <= 'U', '0' after 2ns, '1' after 17ns, '0' after 37ns, '1' after 47ns, '0' after 67ns; 
OP_CODE <= 'U', '0' after 15ns, 'U' after 35ns, '1' after 45ns, 'U' after 65ns;

END;
