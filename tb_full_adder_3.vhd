
LIBRARY ieee;
USE ieee.std_logic_1164.ALL;
 
-- Uncomment the following library declaration if using
-- arithmetic functions with Signed or Unsigned values
--USE ieee.numeric_std.ALL;
 
ENTITY tb_full_adder_3 IS
END tb_full_adder_3;
 
ARCHITECTURE behavior OF tb_full_adder_3 IS 
 
    -- Component Declaration for the Unit Under Test (UUT)
 
    COMPONENT Full_Adder_3
    PORT(
         A : IN  std_logic_vector(7 downto 0);
         B : IN  std_logic_vector(7 downto 0);
         Q : OUT  std_logic_vector(7 downto 0);
         Co : OUT  std_logic
        );
    END COMPONENT;
    

   --Inputs
   signal A : std_logic_vector(7 downto 0) := (others => '0');
   signal B : std_logic_vector(7 downto 0) := (others => '0');

 	--Outputs
   signal Q : std_logic_vector(7 downto 0);
   signal Co : std_logic;
   -- No clocks detected in port list. Replace <clock> below with 
   -- appropriate port name
 
BEGIN
 
	-- Instantiate the Unit Under Test (UUT)
   uut: Full_Adder_3 PORT MAP (
          A => A,
          B => B,
          Q => Q,
          Co => Co
        );

A <= "00000000", "00000111" after 32ns, "10001000" after 62ns;
B <= "00000000", "01111111" after 32ns, "10011001" after 62ns;

END;
