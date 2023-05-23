LIBRARY IEEE;
USE IEEE.STD_LOGIC_1164.all;
USE  IEEE.STD_LOGIC_ARITH.all;
USE  IEEE.STD_LOGIC_SIGNED.all;

entity health is
    port(vert_sync         : in std_logic;
         pause             : in std_logic;
         pipe_collision    : in std_logic;
         health_collision  : in std_logic;
         game_state        : in std_logic_vector(1 downto 0);
         dead              : out std_logic;
			invincibility_out : out std_logic);
end entity health;


architecture behaviour of health is
begin

    damage : process (vert_sync)
	 
        variable v_health            : integer := 3;
        variable invincibility_count : integer := 0;
        variable invincibility_on    : std_logic := '0';
		  
    begin
	 
        if rising_edge(vert_sync) then
		  
            if game_state = "00" then
                v_health := 3;
                dead <= '0';
            elsif v_health = 0 then
                dead <= '1';
            elsif (pipe_collision = '1') and (invincibility_on = '0') then
                invincibility_on := '1';
                v_health := v_health - 1;
            end if;
				
				if pause = '0' then
					if invincibility_count >= 60 then -- assuming vert_sync is 60 hz
							invincibility_count := 0;
							invincibility_on := '0';
					elsif (invincibility_on = '1') then
							invincibility_count := invincibility_count + 1;
					end if;
				end if;
				
				invincibility_out <= invincibility_on;
				
			end if;
				
    end process damage;
	 
end architecture behaviour;



