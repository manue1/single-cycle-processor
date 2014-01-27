
LIBRARY ieee;
USE ieee.std_logic_1164.ALL;
 
ENTITY tb_logic_unit IS
END tb_logic_unit;
 
ARCHITECTURE behavior OF tb_logic_unit IS 
 
    -- Component Declaration for the Unit Under Test (UUT)
 
    COMPONENT LogicUnit
    PORT(
         A : IN  std_logic_vector(7 downto 0);
         B : IN  std_logic_vector(7 downto 0);
         Q : OUT  std_logic_vector(7 downto 0);
         Co : OUT  std_logic;
         Op : IN  std_logic_vector(1 downto 0);
         Test : IN  std_logic
        );
    END COMPONENT;
    

   --Inputs
   signal A : std_logic_vector(7 downto 0) := (others => '0');
   signal B : std_logic_vector(7 downto 0) := (others => '0');
   signal Op : std_logic_vector(1 downto 0) := (others => '0');
   signal Test : std_logic := '0';

 	--Outputs
   signal Q : std_logic_vector(7 downto 0);
   signal Co : std_logic;
 
BEGIN
 
	-- Instantiate the Unit Under Test (UUT)
   uut: LogicUnit PORT MAP (
          A => A,
          B => B,
          Q => Q,
          Co => Co,
          Op => Op,
          Test => Test
        );

A <= "01010101";
B <= "00110011", "00110101" after 80ns;
Op <= "00", "01" after 16ns, "10" after 32ns, "11" after 48ns, "01" after 64ns;
Test <= '1', '0' after 64ns;
 
END;
