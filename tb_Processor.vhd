
LIBRARY ieee;
USE ieee.std_logic_1164.ALL;
 
ENTITY tb_Processor IS
END tb_Processor;
 
ARCHITECTURE behavior OF tb_Processor IS 
 
    -- Component Declaration for the Unit Under Test (UUT)
 
    COMPONENT Processor
    PORT(
         Clk : IN  std_logic;
         Reset : IN  std_logic;
         Out_port : OUT  std_logic_vector(7 downto 0);
         In_port : IN  std_logic_vector(7 downto 0);
         Strobe : OUT  std_logic;
         READ_STROBE : OUT  std_logic;
         WRITE_STROBE : OUT  std_logic
        );
    END COMPONENT;
    

   --Inputs
   signal Clk : std_logic := '0';
   signal Reset : std_logic := '0';
   signal In_port : std_logic_vector(7 downto 0) := (others => '0');

 	--Outputs
   signal Out_port : std_logic_vector(7 downto 0);
   signal Strobe : std_logic;
   signal READ_STROBE : std_logic;
   signal WRITE_STROBE : std_logic;

   -- Clock period definitions
   constant Clk_period : time := 20 ns;
 
BEGIN
 
	-- Instantiate the Unit Under Test (UUT)
   uut: Processor PORT MAP (
          Clk => Clk,
          Reset => Reset,
          Out_port => Out_port,
          In_port => In_port,
          Strobe => Strobe,
          READ_STROBE => READ_STROBE,
          WRITE_STROBE => WRITE_STROBE
        );

   -- Clock process definitions
   Clk_process :process
   begin
		Clk <= '0';
		wait for Clk_period/2;
		Clk <= '1';
		wait for Clk_period/2;
   end process;
	
	Reset <= '0', '1' after 10ns, '0' after 20ns;
	In_port <= "00000000";

END;
