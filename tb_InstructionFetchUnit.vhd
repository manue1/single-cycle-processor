--------------------------------------------------------------------------------
-- Company: 
-- Engineer:
--
-- Create Date:   11:24:43 01/24/2014
-- Design Name:   
-- Module Name:   Z:/picoblaze-processor/tb_InstructionFetchUnit.vhd
-- Project Name:  picoblaze-processor
-- Target Device:  
-- Tool versions:  
-- Description:   
-- 
-- VHDL Test Bench Created by ISE for module: InstructionFetchUnit
-- 
-- Dependencies:
-- 
-- Revision:
-- Revision 0.01 - File Created
-- Additional Comments:
--
-- Notes: 
-- This testbench has been automatically generated using types std_logic and
-- std_logic_vector for the ports of the unit under test.  Xilinx recommends
-- that these types always be used for the top-level I/O of a design in order
-- to guarantee that the testbench will bind correctly to the post-implementation 
-- simulation model.
--------------------------------------------------------------------------------
LIBRARY ieee;
USE ieee.std_logic_1164.ALL;
 
-- Uncomment the following library declaration if using
-- arithmetic functions with Signed or Unsigned values
--USE ieee.numeric_std.ALL;
 
ENTITY tb_InstructionFetchUnit IS
END tb_InstructionFetchUnit;
 
ARCHITECTURE behavior OF tb_InstructionFetchUnit IS 
 
    -- Component Declaration for the Unit Under Test (UUT)
 
    COMPONENT InstructionFetchUnit
    PORT(
         JumpAddress : IN  std_logic_vector(9 downto 0);
         Opcode : IN  std_logic_vector(17 downto 0);
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
   signal Opcode : std_logic_vector(17 downto 0) := (others => '0');
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
          Opcode => Opcode,
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
 
   WriteEnable <= '1' after 7ns, '0' after 57ns;
   LoadStartAddress <= '1' after 7ns, '0' after 17ns;
   LoadJumpAddress <= '1' after 37ns;
   JumpAddress <= "0100000000" after 37ns, "0000010000" after 47ns;

END;
