LIBRARY IEEE;
USE IEEE.STD_LOGIC_1164.all;
USE  IEEE.STD_LOGIC_ARITH.all;

entity collision is
  port(
	 vert_sync : in std_logic;
	 clk : in std_logic;
	 game_state : in std_logic_vector(1 downto 0);
    bird_on, pipe_on : in std_logic;
    pipe_collision : out std_logic);
end entity collision;


architecture behaviour of collision is 
	signal last_vert_sync : std_logic;
begin

detect_collision : process(clk, bird_on, pipe_on, vert_sync)
begin 
	if rising_edge(clk) then
		if ((pipe_on = '1') and (bird_on = '1')) then
			pipe_collision <= '1';
		end if;
		
		if vert_sync = '1' and vert_sync /= last_vert_sync then
			pipe_collision <= '0';
		end if;
		
		last_vert_sync <= vert_sync;
	end if;
end process;

end architecture behaviour;

    