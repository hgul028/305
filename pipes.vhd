LIBRARY IEEE;
USE IEEE.STD_LOGIC_1164.all;
USE  IEEE.STD_LOGIC_ARITH.all;
USE  IEEE.STD_LOGIC_SIGNED.all;


ENTITY pipes IS
	PORT
		(   vert_sync       	       : IN std_logic;
          pixel_row, pixel_column : IN std_logic_vector(9 DOWNTO 0);
			 game_state              : IN std_logic_vector(1 downto 0);
			 rand                    : in std_logic_vector(7 downto 0);
		    pipe_on 		          : OUT std_logic);		
END pipes;

architecture behavior of pipes is

SIGNAL size_x 					: std_logic_vector(10 DOWNTO 0);
SIGNAL size_y					: std_logic_vector(9 DOWNTO 0);  
SIGNAL pipe_y_pos				: std_logic_vector(9 DOWNTO 0);
SiGNAL pipe_x_pos				: std_logic_vector(10 DOWNTO 0);
SIGNAL pipe_x_motion			: std_logic_vector(10 DOWNTO 0);
SIGNAL size_gap            : std_logic_vector(9 DOWNTO 0);
SIGNAL height_gap          : std_logic_vector(9 DOWNTO 0);

SIGNAL count     : integer   := 1;

BEGIN           

size_gap <= CONV_STD_LOGIC_VECTOR(50,10);

size_x <= CONV_STD_LOGIC_VECTOR(25,11);
size_y <= CONV_STD_LOGIC_VECTOR(240,10);

pipe_y_pos <= CONV_STD_LOGIC_VECTOR(240,10);

pipe_on <= '1' when ( ('0' & pipe_x_pos <= '0' & pixel_column + size_x) and ('0' & pixel_column <= '0' & pipe_x_pos + size_x) 	-- x_pos - size <= pixel_column <= x_pos + size
					and ('0' & pipe_y_pos <= '0' & pixel_row + size_y ) and ('0' & pixel_row <= '0' & pipe_y_pos + size_y) ) 
					and not (('0' & height_gap <= '0' & pixel_row + size_gap) and ('0' & height_gap >= '0' & pixel_row - size_gap))
					else '0';

-- Colours for pixel data on video signal
-- Changing the background and ball colour by pushbuttons

Move_Pipe: process (vert_sync, game_state, rand)
	variable v_height_gap  : std_logic_vector(9 downto 0) := CONV_STD_LOGIC_VECTOR(240,10);
	variable speed_level   : integer := 1;
	variable current_speed : integer := 1;
	variable accel_time    : integer := 10; -- time in seconds
begin
	-- Move pipe once every vertical sync
	
	if (rising_edge(vert_sync)) then
	
		if (game_state = "00") then
			pipe_x_pos <= CONV_STD_LOGIC_VECTOR(750,11) - size_x;
			current_speed := 1;
		else
			if (pipe_x_pos <= CONV_STD_LOGIC_VECTOR(1,11)) then
				pipe_x_pos <= CONV_STD_LOGIC_VECTOR(750,11) - size_x;
				v_height_gap := CONV_STD_LOGIC_VECTOR(200,10) + rand;
				current_speed := speed_level;
			else
				pipe_x_pos <= pipe_x_pos - CONV_STD_LOGIC_VECTOR(current_speed,11);
			end if;
		end if;
		
		count <=count+1;
		if game_state = "00" then
			speed_level := 1;
			count <= 1;
		elsif game_state = "01" then
			speed_level := 2;
		elsif (count = 60*accel_time) and speed_level <= 10 then
			speed_level := speed_level + 1;
			count <= 1;
		end if;
		
	end if;
	
	height_gap <= v_height_gap;
	
end process Move_Pipe;

END behavior;

