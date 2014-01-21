library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.STD_LOGIC_UNSIGNED.ALL;

entity InstructionFetchUnit is
	generic (	cmd_width: positive; -- Befehlsbreite
			 	cmd_addr_width: positive; -- Adressbreite des Befehlsspeichers
			 	stack_addr_width: positive); -- Adressbreite des Call/return—Stapels
	port (-- Datenleitungen
	JumpAddress: in STD_LOGIC_VECTOR (cmd_addr_width - 1 downto 0); -- Sprungadresse
	Instruction: out STD_LOGIC_VECTOR (cmd_width - 1 downto 0); -- naechster Befehl
	-- Steuerleitungen
	Clk: in STD_LOGIC; -- Takt
	WriteEnable: in STD_LOGIC; -- Schreibfreigabe des Befehlszaehlers
	LoadStartAddress: in STD_LOGIC; -- Startadresse laden
	LoadJumpAddress: in STD_LOGIC; -- Sprungadresse laden
	LoadInterruptAddress: in STD_LOGIC; -- Interrupt—Adresse laden
	SaveCmdAddress: in STD_LOGIC; -- Sichern der Befehlsadresse auf dem Stack
	RestoreCmdAddress: in STD_LOGIC); -- Laden einer Adresse vom Stack
end InstructionFetchUnit;

architecture Behavior of InstructionFetchUnit is
	-- Ein— und Ausgang des Befehlszaehlers
	signal s_addr_in: STD_LOGIC_VECTOR (cmd_addr_width - 1 downto 0);
	signal s_addr_out: STD_LOGIC_VECTOR (cmd_addr_width - 1 downto 0);
	-- Ein— und Ausgang des Addierers
	signal s_addr_add_in: STD_LOGIC_VECTOR (cmd_addr_width - 1 downto 0);
	signal s_addr_add_out: STD_LOGIC_VECTOR (cmd_addr_width - 1 downto 0);
	-- Ausgangssignale des Stapelspeichers
	signal s_stack_out: STD_LOGIC_VECTOR (cmd_addr_width - 1 downto 0);

	-- Call/Return—Stapel
	component CallReturnStack
		generic (addr_width: positive; -- Adressbreite
				 data_width: positive); -- Datenbreite
	port (-- Datenleitungen
		  DataIn: in STD_LOGIC_VECTOR (data_width - 1 downto 0); -- Dateneingang
		  DataOut: out STD_LOGIC_VECTOR (data_width - 1 downto 0); -- Datenausgang

		  -- Steuerleitungen
		  Clk: in STD_LOGIC; -- Takt
		  Push: in STD_LOGIC; -- Daten speichern
		  Pop: in STD_LOGIC); -- Daten lesen
	end component CallReturnStack;

	-- Befehlsspeicher
	component P_ROM
		port (-- Datenleitungen
		Address: in STD_LOGIC_VECTOR (cmd_addr_width - 1 downto 0); -- Befehlsadresse
		Instruction: out STD_LOGIC_VECTOR (cmd_width - 1 downto 0); -- néchster Befehl
		-- Steuerleitungen
		Clk: in STD_LOGIC);
	end component P_ROM;

begin
	-- Adress—Multiplexer
	with RestoreCmdAddress select
		s_addr_add_in <= s_addr_out when '0',
						 s_stack_out when '1',
						 (others => 'X') when others;
	with LoadJumpAddress select
		s_addr_in <= s_addr_add_out when '0',
					 JumpAddress when '1',
					 (others => 'X') when others;

	-- Addierer
	s_addr_add_out <= s_addr_add_in + 1;

	-- Befehlszaehler
	PC: process (Clk)
	begin
		if falling_edge (Clk) then
			if LoadStartAddress = '1' then
			   s_addr_out <= (others => '0');
		elsif LoadInterruptAddress - '1' then
			  s_addr_out <= (others => '1');
		else
			if WriteEnable = '1' then
			   s_addr_out <- s_addr_in;
			end if;
		end if;
	end if;
end process PC;

	-- Call/Return-Stapel
	CRS: CallReturnStack
	generic map (addr_width => stack_addr_width, data_width => cmd_addr_width)
	port map (DataIn -> s_addr_out, DataOut -> s_stack_out,
		      Clk => Clk, Push => SaveCmdAddress, Pop => RestoreCmdAddress);

	-- Befehlsspeicher
	IM: P_ROM port map (Address => s_addr_out, Instruction => Instruction, Clk => Clk);
end Behavior;