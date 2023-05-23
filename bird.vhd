LIBRARY IEEE;
USE IEEE.STD_LOGIC_1164.all;
USE  IEEE.STD_LOGIC_ARITH.all;
USE  IEEE.STD_LOGIC_SIGNED.all;


ENTITY bird IS
	PORT
		(vert_sync	: IN std_logic;
			mouse_click : IN std_logic;
          pixel_row, pixel_column	: IN std_logic_vector(9 DOWNTO 0);
			 game_state : IN std_logic_vector(1 downto 0);
		  bird_on 		: OUT std_logic);		
END bird;

architecture behavior of bird is

SIGNAL size 					: std_logic_vector(9 DOWNTO 0);  
SIGNAL bird_y_pos				: std_logic_vector(9 DOWNTO 0);
SIGNAL bird_x_pos				: std_logic_vector(10 DOWNTO 0);
SIGNAL bird_y_motion			: std_logic_vector(9 DOWNTO 0);

BEGIN           

size <= CONV_STD_LOGIC_VECTOR(8,10);
-- bird_x_pos and bird_y_pos show the (x,y) for the centre of ball
bird_x_pos <= CONV_STD_LOGIC_VECTOR(100,11);

bird_on <= '1' when ( ('0' & bird_x_pos <= '0' & pixel_column + size) and ('0' & pixel_column <= '0' & bird_x_pos + size) 	-- x_pos - size <= pixel_column <= x_pos + size
					and ('0' & bird_y_pos <= pixel_row + size) and ('0' & pixel_row <= bird_y_pos + size) )  else	-- y_pos - size <= pixel_row <= y_pos + size
			'0';

-- Colours for pixel data on video signal
-- Changing the background and ball colour by pushbuttons

Move_Bird: process (vert_sync, game_state)  	
begin

	-- Move bird once every vertical sync
	if (rising_edge(vert_sync)) then	
	
		if (game_state = "00") then
			bird_y_pos <= CONV_STD_LOGIC_VECTOR(240,10) - size;
		elsif (mouse_click = '1') then
				if (bird_y_pos >= CONV_STD_LOGIC_VECTOR(0, 10) + size) then
					bird_y_motion <= - CONV_STD_LOGIC_VECTOR(6,10);
				end if;
			bird_y_pos <= bird_y_pos + bird_y_motion;
		elsif (bird_y_pos <= CONV_STD_LOGIC_VECTOR(479, 10) - size) then
			-- bird is moving downward.
			bird_y_motion <= CONV_STD_LOGIC_VECTOR(3,10);
			bird_y_pos <= bird_y_pos + bird_y_motion;
		else 
			bird_y_motion <= CONV_STD_LOGIC_VECTOR(0,10);
			bird_y_pos <= bird_y_pos + bird_y_motion;
		end if;
		-- compute next bird Y position
		
	end if;
end process Move_Bird;

--bird_y_pos <= CONV_STD_LOGIC_VECTOR(479,10) - size when game_state = "00";
	
	
END behavior;

