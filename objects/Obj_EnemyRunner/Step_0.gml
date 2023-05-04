var player_dir = 0;
for (var i = 0, viewleft = true, viewright = true; i < 1000; i += 4)
{
	if (!place_empty(x - i, y, Obj_Block))
		viewleft = false;
	if (!place_empty(x + i, y, Obj_Block))
		viewright = false;
	if (!place_empty(x - i, y, Obj_Playa) || !place_empty(x - i, y - sprite_height, Obj_Playa))
		player_dir = -1;
	if (!place_empty(x + i, y, Obj_Playa) || !place_empty(x + i, y - sprite_height, Obj_Playa))
		player_dir = 1;
	if (!(viewleft || viewright) || player_dir != 0)
		break;
}

if (!running)
{
	if (random(25) < 1)
		walk_dir = floor(random(3) - 1);
	hsp = walk_dir * 2;
	
	if (random(40) < 1 && player_dir != 0)
	{
		walk_dir = player_dir;
		running = true;
	}
}

if (running)
{
	hsp = walk_dir * 40;
	if (player_dir != walk_dir && random(15) < 1)
	{
		running = false;
		hsp = 0;
	}
}
	
var elapsed = UsToFrames(delta_time);
var dx = hsp * elapsed + hsp_part;
var hsp_abs = abs(dx);
var hsp_sign = sign(dx);
var hsp_whole = floor(hsp_abs);
hsp_part = dx - hsp_whole * hsp_sign;
	
for (var i = 0; i < abs(hsp); ++i)
{
	if (!place_empty(x + sign(hsp), y, Obj_Block)
			|| place_empty(x + sign(hsp) * sprite_width, y + 1, Obj_Block))
	{
		running = false;
		hsp = hsp_part = 0;
		break;
	}
	x += sign(hsp);
}




var brain = instance_place(x, y, Obj_Brain);
if (!killed && brain != noone && brain.curr_mode == BrainMode.FREE)
{
	killed = true;
	instance_destroy(brain);
}

if (killed)
{
	instance_destroy();
	instance_create_depth(x, y, 50, Obj_EnemyWalkerDead);
	instance_create_depth(x, y, 80, Obj_Bloodstain);
}