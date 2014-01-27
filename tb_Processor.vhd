--------------------------------------------------------------------------------
-- Company: 
-- Engineer:
--
-- Create Date:   15:22:27 01/27/2014
-- Design Name:   
-- Module Name:   Z:/picoblaze-processor/tb_Processor.vhd
-- Project Name:  picoblaze-processor
-- Target Device:  
-- Tool versions:  
-- Description:   
-- 
-- VHDL Test Bench Created by ISE for module: Processor
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
 
ENTITY tb_Processor IS
END tb_Processor;
 
ARCHITECTURE behavior OF tb_Processor IS 
 
    -- Component Declaration for the Unit Under Test (UUT)
 
    COMPONENT Processor
    PORT(
         Clk : IN  std_logic;
         Reset : IN  std_logic;
         Out_port : OUT  std_logic_vector(7 downto 0)
        );
    END COMPONENT;
    

   --Inputs
   signal Clk : std_logic := '0';
   signal Reset : std_logic := '0';

 	--Outputs
   signal Out_port : std_logic_vector(7 downto 0);

   -- Clock period definitions
   constant Clk_period : time := 20 ns;
 
BEGIN
 
	-- Instantiate the Unit Under Test (UUT)
   uut: Processor PORT MAP (
          Clk => Clk,
          Reset => Reset,
          Out_port => Out_port
        );

 
	Reset <= '0', '1' after 2ns, '0' after 12ns;

END;
