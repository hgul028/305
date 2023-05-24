LIBRARY ieee;
USE ieee.std_logic_1164.ALL;

ENTITY LFSR8 IS
  PORT (Clk : IN std_logic;
        output: OUT std_logic_vector (7 DOWNTO 0));
END LFSR8;

ARCHITECTURE LFSR8_beh OF LFSR8 IS
  SIGNAL Currstate, Nextstate: std_logic_vector (7 DOWNTO 0);
  SIGNAL feedback: std_logic;
BEGIN

  StateReg: PROCESS (Clk)
  variable activate : std_logic := '1';
  BEGIN
    if rising_edge(Clk) then
		 if (activate = '1') then
			activate := '0';
			Currstate <= (0 => '1', others =>'0');
		 else
			Currstate <= Nextstate;
		 end if;
	 end if;
  END PROCESS;

  feedback <= Currstate(4) XOR Currstate(3) XOR Currstate(2) XOR Currstate(0);
  Nextstate <= feedback & Currstate(7 DOWNTO 1);
  output <= Currstate;
  
END LFSR8_beh;
