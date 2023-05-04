enum BrainMode 
{
	HELD,
	FREE
}

vsp = 0;
hsp = 0;
vsp_part = 0;
hsp_part = 0;
curr_mode = BrainMode.HELD;
alarm[0] = room_speed * 3;