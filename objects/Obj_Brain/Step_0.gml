var elapsed = UsToFrames(delta_time)
var finalboss = variable_global_exists("final_boss") && global.final_boss;;

if (curr_mode == BrainMode.FREE)
{
	if (!finalboss)
		vsp += 0.8 * elapsed;
	
	
	
	
	var dx = hsp * elapsed + hsp_part;
	var hsp_abs = abs(dx);
	var hsp_sign = sign(dx);
	var hsp_whole = floor(hsp_abs);
	hsp_part = dx - hsp_whole * hsp_sign;

	for (var i = 0; i < hsp_whole; ++i)
	{
		if (place_empty(x + hsp_sign, y, Obj_Block) || !place_empty(x, y, Obj_Block))
			x += hsp_sign;
		else
		{
			hsp *= -0.7;
			vsp *= 0.8;
			hsp_part = 0;
			break;
		}
	}

	var dy = vsp * elapsed + vsp_part;
	var vsp_abs = abs(dy);
	var vsp_sign = sign(dy);
	var vsp_whole = floor(vsp_abs);
	vsp_part = dy - vsp_whole * vsp_sign;

	for (var i = 0; i < vsp_whole; ++i)
	{
		if (place_empty(x, y + vsp_sign, Obj_Block) || !place_empty(x, y, Obj_Block))
			y += vsp_sign;
		else
		{
			vsp *= -0.8;
			hsp *= 0.7;
			vsp_part = 0;
			break;
		}
	}	
}

if (curr_mode == BrainMode.HELD)
	alarm[0] = room_speed * 3;
if (alarm[0] < room_speed * 1)
	image_alpha = floor((alarm[0] / 2) % 2);