LIBRARY IEEE;
USE IEEE.STD_LOGIC_1164.all;
USE  IEEE.STD_LOGIC_ARITH.all;
USE  IEEE.STD_LOGIC_UNSIGNED.all;

entity colours is

port(
	invincibility_on : in std_logic;
	game_state : in std_logic_vector(1 downto 0);
	pipe_on, bird_on: in std_logic;
	red, green, blue : out std_logic_vector(3 downto 0));
end entity colours;


architecture behaviour of colours is
begin

	process(game_state, bird_on, pipe_on, invincibility_on)
	begin
		
	if (game_state = "00") then
		red <= "0000";
		green <= "1111";
		blue <= "0000";
	elsif (game_state = "01") then
		if (bird_on = '1') then
			red <= "1111";
			green <= "0010";
			if (invincibility_on = '1') then
				blue <= "1110";
			else
				blue <= "0000";
			end if;
		elsif(pipe_on = '1') then
			red <= "0000";
			green <= "1111";
			blue <= "0000";
		else --background
			red <= "1111";
			green <= "1111";
			blue <= "1111";
		end if;
	elsif (game_state = "10") then
		if (bird_on = '1') then
			red <= "1111";
			green <= "0010";
			if (invincibility_on = '1') then
				blue <= "1110";
			else
				blue <= "0000";
			end if;
		elsif(pipe_on = '1') then
			red <= "0000";
			green <= "1111";
			blue <= "0100";
		else --background
			red <= "0000";
			green <= "1100";
			blue <= "1111";
		end if;
	elsif (game_state = "11") then
		red <= "1111";
		green <= "0000";
		blue <= "0000";
	else 
		red <= "0000";
		green <= "0000";
		blue <= "1111";
	end if;
	
   end process;
   
end architecture;
