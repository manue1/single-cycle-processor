
LIBRARY ieee;
USE ieee.std_logic_1164.ALL;
 
ENTITY tb_shift_unit IS
END tb_shift_unit;
 
ARCHITECTURE behavior OF tb_shift_unit IS 
 
    -- Component Declaration for the Unit Under Test (UUT)
 
    COMPONENT ShiftUnit
	 generic (width : integer := 8);
    PORT(
         A : IN  std_logic_vector(width - 1 downto 0);
         Ci : IN  std_logic;
         Q : OUT  std_logic_vector(width - 1 downto 0);
         Co : OUT  std_logic;
         Op : IN  std_logic_vector(1 downto 0);
         Dir : IN  std_logic;
         ExtBit : IN  std_logic
        );
    END COMPONENT;

   --Inputs
   signal A : std_logic_vector(7 downto 0) := (others => '0');
   signal Ci : std_logic := '0';
   signal Op : std_logic_vector(1 downto 0) := (others => '0');
   signal Dir : std_logic := '0';
   signal ExtBit : std_logic := '0';

 	--Outputs
   signal Q : std_logic_vector(7 downto 0);
   signal Co : std_logic;
	
BEGIN
 
	-- Instantiate the Unit Under Test (UUT)
   uut: ShiftUnit PORT MAP (
          A => A,
          Ci => Ci,
          Q => Q,
          Co => Co,
          Op => Op,
          Dir => Dir,
          ExtBit => ExtBit
        );

P_DIR: process
	begin
		Dir <= '0';
		wait for 16ns;
		Dir <= '1';
		wait for 16ns;
	end process;
	
P_A: process
	begin
		A <= "10100101";
		wait for 16ns;
		A <= "01001010";
		wait for 16ns;
		A <= "10100101";
		wait for 16ns;
		A <= "01001011";
		wait for 16ns;
		A <= "00100101";
		wait for 16ns;
		A <= "01001011";
		wait for 16ns;
		A <= "10100101";
		wait for 16ns;
		A <= "01001010";
		wait for 16ns;
		wait for 16ns;
		A <= "00100101";
		wait for 16ns;
		A <= "01001011";
		wait for 16ns;
	end process;

Op <= "00", "01" after 32ns, "10" after 64ns, "11" after 96ns;
Ci <= '0', '1' after 16ns, '0' after 32ns, '1' after 48ns, '0' after 80ns, '1' after 96ns, '0' after 128ns;
ExtBit <= 'U', '0' after 96ns, '1' after 128ns;

END;
