-- Ergebnis der Verarbeitung
signal computation_result: STD_LOGIC_VECTOR (data_width - 1 downto 0);
-- Ergebnis des Speicherzugriffes
signal memory_result: STD_LOGIC_VECTOR (data_width - 1 downto 0);
-- Ergebnis des Hardwarezugriffes
signal io_result: STD_LOGIC_VECTOR (data_width - 1 downto 0);

-- Steuersignale fur die Multiplexer im Datenpfad
signal d_mux_control_1: STD_LOGIC;
signal d_mux_control_2: STD_LOGIC;
signal d_mux_control_3: STD_LOGIC;

-- 2-zu-1 Multiplexer
component Multiplexer_2_to_1
	port (	A, B: in STD_LOGIC;
			Y: out STD_LOGIC;
			S: in STD_LOGIC);
end component Multiplexer_2_to_1;

-- Ausgangssignale der Multiplexer im Datenpfad
signal d_mux_out_1: STD_LOGIC_VECTOR (data_width - 1 downto 0);
signal d_mux_out_2: STD_LOGIC_VECTOR (data_width - 1 downto 0);
-- Ergebnis des Ausfuhrungsschrittes
signal result: STD_LOGIC_VECTOR (data_width - 1 downto 0);

-- Multiplexer fur den Datenpfad
d_mux_control_1 <= instruction(cmd_width - 5);
d_mux_control_2 <= instruction(cmd_width - 2) and
					not instruction(cmd_width - 4);
d_mux_control_3 <= instruction(cmd_width - 1) xor
					(instruction(cmd_width - 2) or instruction(cmd_width - 3));
G_MUX: for i in result'RANGE generate
	D_MUX_1: Multiplexer_2_to_1
	port map ( 	A => io_result(i),
				B => memory_result(i),
				Y => d_mux_out_1(i),
				S => d_mux_control_1);
	D_MUX_2: Mu1tiplexer_2_to_1
	port map ( 	A => d_mux_out_1(i),
				B => operand_2(i),
				Y => d_mux_out_2(i),
				S => d_mux_control_2);
	D_MUX_3: Multip1exer_2_to_1
	port map ( 	A => d_mux_out_2(i),
				B => computation_result,
				Y => result(i),
				S => d_mux_control_3);
end generate G_MUX;