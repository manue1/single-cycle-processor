
LIBRARY ieee;
USE ieee.std_logic_1164.ALL;

ENTITY tb_InstructionFetchUnit IS
END tb_InstructionFetchUnit;
 
ARCHITECTURE behavior OF tb_InstructionFetchUnit IS 
 
    -- Component Declaration for the Unit Under Test (UUT)
 
    COMPONENT InstructionFetchUnit
    PORT(
         JumpAddress : IN  std_logic_vector(9 downto 0);
         Instruction : OUT  std_logic_vector(17 downto 0);
         Clk : IN  std_logic;
         WriteEnable : IN  std_logic;
         LoadStartAddress : IN  std_logic;
         LoadJumpAddress : IN  std_logic;
         RestoreCmdAddress : IN  std_logic;
         LoadInterruptAddress : IN  std_logic;
         SaveCmdAddress : IN  std_logic
        );
    END COMPONENT;
    

   --Inputs
   signal JumpAddress : std_logic_vector(9 downto 0) := (others => '0');
   signal Clk : std_logic := '0';
   signal WriteEnable : std_logic := '0';
   signal LoadStartAddress : std_logic := '0';
   signal LoadJumpAddress : std_logic := '0';
   signal RestoreCmdAddress : std_logic := '0';
   signal LoadInterruptAddress : std_logic := '0';
   signal SaveCmdAddress : std_logic := '0';

 	--Outputs
   signal Instruction : std_logic_vector(17 downto 0);

   -- Clock period definitions
   constant Clk_period : time := 10 ns;
 
BEGIN
 
	-- Instantiate the Unit Under Test (UUT)
   uut: InstructionFetchUnit PORT MAP (
          JumpAddress => JumpAddress,
          Instruction => Instruction,
          Clk => Clk,
          WriteEnable => WriteEnable,
          LoadStartAddress => LoadStartAddress,
          LoadJumpAddress => LoadJumpAddress,
          RestoreCmdAddress => RestoreCmdAddress,
          LoadInterruptAddress => LoadInterruptAddress,
          SaveCmdAddress => SaveCmdAddress
        );

   -- Clock process definitions
   Clk_process :process
   begin
		Clk <= '0';
		wait for Clk_period/2;
		Clk <= '1';
		wait for Clk_period/2;
   end process;
 

   WriteEnable <= '1' after 7ns, '0' after 57ns, '1' after 70ns;
   LoadStartAddress <= '1' after 7ns, '0' after 17ns;
   LoadJumpAddress <= '1' after 37ns, '0' after 57ns;
   JumpAddress <= "UUUUUUUUUU", "0100000000" after 37ns, "0000010000" after 47ns, "UUUUUUUUUU" after 57ns;
   LoadInterruptAddress <= '1' after 27ns, '0' after 37ns;
   SaveCmdAddress <= '1' after 27ns,  '0' after 37ns, '1' after 47ns, '0' after 57ns;
   RestoreCmdAddress <= '1' after 77ns, '0' after 87ns, '1' after 97ns, '0' after 107ns;

END;
