LIBRARY IEEE;
USE IEEE.STD_LOGIC_1164.all;

entity state_controller is
port(btn_reset, btn_start, btn_pause, dead : in std_logic;
	sw_gamemode : in std_logic;
	mouse_click : in std_logic;
	game_state : out std_logic_vector(1 downto 0);
	vert_sync : in std_logic);
	--test : out std_logic);
end entity state_controller;

architecture behaviour of state_controller is
	 signal s_game_state : std_logic_vector(1 downto 0) := "00";
begin
   
process(btn_start, btn_reset, dead, vert_sync)
	variable v_game_state : std_logic_vector(1 downto 0) := "00"; -- initializing to "00" does nothing
begin
	
	if (rising_edge(vert_sync)) then
		if (btn_start = '0') then
			if (v_game_state = "00") then
				if (sw_gamemode = '0') then
					v_game_state := "01";
				else 
					v_game_state := "10";
				end if;
			end if;
		end if;
		
		if (dead = '1') then
			v_game_state := "11";
		end if;
		
		if (btn_reset = '0') then
			v_game_state := "00";
		end if;
		
		game_state <= v_game_state;

	end if;
end process;
	
end architecture behaviour;


	