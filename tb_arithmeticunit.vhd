
LIBRARY ieee;
USE ieee.std_logic_1164.ALL;
 
ENTITY tb_arithmetic_unit IS
END tb_arithmetic_unit;
 
ARCHITECTURE behavior OF tb_arithmetic_unit IS 
 
    -- Component Declaration for the Unit Under Test (UUT)
 
    COMPONENT ArithmeticUnit
    PORT(
         A : IN  std_logic_vector(7 downto 0);
         B : IN  std_logic_vector(7 downto 0);
         Ci : IN  std_logic;
         Q : OUT  std_logic_vector(7 downto 0);
         Co : OUT  std_logic;
         Op : IN  std_logic_vector(1 downto 0)
        );
    END COMPONENT;
    

   --Inputs
   signal A : std_logic_vector(7 downto 0) := (others => '0');
   signal B : std_logic_vector(7 downto 0) := (others => '0');
   signal Ci : std_logic := '0';
   signal Op : std_logic_vector(1 downto 0) := (others => '0');

 	--Outputs
   signal Q : std_logic_vector(7 downto 0);
   signal Co : std_logic;
 
BEGIN
 
	-- Instantiate the Unit Under Test (UUT)
   uut: ArithmeticUnit PORT MAP (
          A => A,
          B => B,
          Ci => Ci,
          Q => Q,
          Co => Co,
          Op => Op
        );

Op <= "00", "01" after 15ns, "01" after 30ns, "10" after 45ns, "11" after 60ns, "11" after 75ns;
A <= "11111110", "10000001" after 45ns;
B <= "00000001";
Ci <= 'U', '0' after 15ns, '1' after 30ns, 'U' after 45ns, '0' after 60ns, '1' after 75ns;

END;
