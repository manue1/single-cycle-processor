
LIBRARY ieee;
USE ieee.std_logic_1164.ALL;
 
ENTITY tb_flag_register IS
END tb_flag_register;
 
ARCHITECTURE behavior OF tb_flag_register IS 
 
    -- Component Declaration for the Unit Under Test (UUT)
 
    COMPONENT FlagRegister
    PORT(
         Ci : IN  std_logic;
         Co : OUT  std_logic;
         Zi : IN  std_logic;
         Zo : OUT  std_logic;
         IEi : IN  std_logic;
         IEo : OUT  std_logic;
         Clk : IN  std_logic;
         Reset : IN  std_logic;
         WE : IN  std_logic;
         IEWE : IN  std_logic;
         IntCode : IN  std_logic_vector(1 downto 0)
        );
    END COMPONENT;
    

   --Inputs
   signal Ci : std_logic := '0';
   signal Zi : std_logic := '0';
   signal IEi : std_logic := '0';
   signal Clk : std_logic := '0';
   signal Reset : std_logic := '0';
   signal WE : std_logic := '0';
   signal IEWE : std_logic := '0';
   signal IntCode : std_logic_vector(1 downto 0) := (others => '0');

 	--Outputs
   signal Co : std_logic;
   signal Zo : std_logic;
   signal IEo : std_logic;

   -- Clock period definitions
   constant Clk_period : time := 10 ns;
 
BEGIN
 
	-- Instantiate the Unit Under Test (UUT)
   uut: FlagRegister PORT MAP (
          Ci => Ci,
          Co => Co,
          Zi => Zi,
          Zo => Zo,
          IEi => IEi,
          IEo => IEo,
          Clk => Clk,
          Reset => Reset,
          WE => WE,
          IEWE => IEWE,
          IntCode => IntCode
        );

   -- Clock process definitions
   Clk_process :process
   begin
		Clk <= '0';
		wait for Clk_period/2;
		Clk <= '1';
		wait for Clk_period/2;
   end process;

Reset <= '0', '1' after 2ns, '0' after 12ns;
Ci <= 'U', '1' after 10ns, '0' after 30ns, '1' after 60ns;
Zi <= 'U' , '1' after 10ns, '0' after 30ns, '1' after 60ns;
IEi <= 'U', '1' after 10ns, '0' after 50ns, '1' after 60ns;
WE <= 'U', '0' after 10ns, '1' after 20ns, '0' after 40ns, '1' after 50ns;
IEWE <= 'U', '0' after 10ns, '1' after 20ns, '0' after 30ns, '1' after 40ns, '0' after 50ns;
IntCode <= "UU", "00" after 10ns, "10" after 30ns, "01" after 40ns, "00" after 50ns, "10" after 60ns;

END;
