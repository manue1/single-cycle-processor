--------------------------------------------------------------------------------
-- Company: 
-- Engineer:
--
-- Create Date:   14:30:16 01/22/2014
-- Design Name:   
-- Module Name:   Z:/picoblaze-processor/tb_control-unit.vhd
-- Project Name:  picoblaze-processor
-- Target Device:  
-- Tool versions:  
-- Description:   
-- 
-- VHDL Test Bench Created by ISE for module: ControlUnit
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
 
ENTITY tb_control-unit IS
END tb_control-unit;
 
ARCHITECTURE behavior OF tb_control-unit IS 
 
    -- Component Declaration for the Unit Under Test (UUT)
 
    COMPONENT ControlUnit
    PORT(
         CarryIn : IN  std_logic;
         CarryOut : OUT  std_logic;
         ZeroIn : IN  std_logic;
         IEIn : IN  std_logic;
         Clk : IN  std_logic;
         Reset : IN  std_logic;
         Interrupt : IN  std_logic;
         InterruptAck : OUT  std_logic;
         OpCode : IN  std_logic_vector(4 downto 0);
         Condition : IN  std_logic_vector(2 downto 0);
         InternalReset : OUT  std_logic;
         PCWrite : OUT  std_logic;
         LoadJumpAddress : OUT  std_logic;
         LoadInterruptAddress : OUT  std_logic;
         SaveCmdAddress : OUT  std_logic;
         RestoreCmdAddress : OUT  std_logic;
         Regwrite : OUT  std_logic;
         Memwrite : OUT  std_logic;
         IOStrobe : OUT  std_logic
        );
    END COMPONENT;
    

   --Inputs
   signal CarryIn : std_logic := '0';
   signal ZeroIn : std_logic := '0';
   signal IEIn : std_logic := '0';
   signal Clk : std_logic := '0';
   signal Reset : std_logic := '0';
   signal Interrupt : std_logic := '0';
   signal OpCode : std_logic_vector(4 downto 0) := (others => '0');
   signal Condition : std_logic_vector(2 downto 0) := (others => '0');

 	--Outputs
   signal CarryOut : std_logic;
   signal InterruptAck : std_logic;
   signal InternalReset : std_logic;
   signal PCWrite : std_logic;
   signal LoadJumpAddress : std_logic;
   signal LoadInterruptAddress : std_logic;
   signal SaveCmdAddress : std_logic;
   signal RestoreCmdAddress : std_logic;
   signal Regwrite : std_logic;
   signal Memwrite : std_logic;
   signal IOStrobe : std_logic;

   -- Clock period definitions
   constant Clk_period : time := 10 ns;
 
BEGIN
 
	-- Instantiate the Unit Under Test (UUT)
   uut: ControlUnit PORT MAP (
          CarryIn => CarryIn,
          CarryOut => CarryOut,
          ZeroIn => ZeroIn,
          IEIn => IEIn,
          Clk => Clk,
          Reset => Reset,
          Interrupt => Interrupt,
          InterruptAck => InterruptAck,
          OpCode => OpCode,
          Condition => Condition,
          InternalReset => InternalReset,
          PCWrite => PCWrite,
          LoadJumpAddress => LoadJumpAddress,
          LoadInterruptAddress => LoadInterruptAddress,
          SaveCmdAddress => SaveCmdAddress,
          RestoreCmdAddress => RestoreCmdAddress,
          Regwrite => Regwrite,
          Memwrite => Memwrite,
          IOStrobe => IOStrobe
        );

   -- Clock process definitions
   Clk_process :process
   begin
		Clk <= '0';
		wait for Clk_period/2;
		Clk <= '1';
		wait for Clk_period/2;
   end process;
 
	-- Reset
	reset <= '1' after 2ns, '0' after 13ns;
 
 END;
