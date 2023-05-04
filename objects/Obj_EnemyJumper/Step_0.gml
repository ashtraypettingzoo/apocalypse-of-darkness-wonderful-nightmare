var player_dir = 0;
for (var i = 0, viewleft = true, viewright = true; i < 1000; i += 4)
{
	if (!place_empty(x - i, y, Obj_Block))
		viewleft = false;
	if (!place_empty(x + i, y, Obj_Block))
		viewright = false;
	if (viewleft && 
			(!place_empty(x - i, y, Obj_Playa) || !place_empty(x - i, y - sprite_height, Obj_Playa)))
		player_dir = -1;
	if (viewright &&
			(!place_empty(x + i, y, Obj_Playa) || !place_empty(x + i, y - sprite_height, Obj_Playa)))
		player_dir = 1;
	if (!(viewleft || viewright) || player_dir != 0)
		break;
}

var in_air = place_empty(x, y + 1, Obj_Block);
var elapsed = UsToFrames(delta_time);

if (!in_air)
{
	if (random(20) < 1)
		walk_dir = floor(random(3) - 1);
	
	hsp = walk_dir * 2;
	
	if (random(15) < 1 && player_dir != 0)
	{
		walk_dir = 0;
		hsp = 10 * player_dir;
		vsp = -18;
		in_air = true;
	}
}

if (in_air)
{
	vsp += 1.0 * elapsed;
}

var dy = vsp * elapsed + vsp_part;
var vsp_abs = abs(dy);
var vsp_sign = sign(dy);
var vsp_whole = floor(vsp_abs);
hsp_part = dy - vsp_whole * vsp_sign;
	
for (var i = 0; i < abs(vsp); ++i)
{
	if (!place_empty(x, y + sign(vsp), Obj_Block))
	{
		vsp = vsp_part = 0;
		break;
	}
	y += sign(vsp);
}

var dx = hsp * elapsed + hsp_part;
var hsp_abs = abs(dx);
var hsp_sign = sign(dx);
var hsp_whole = floor(hsp_abs);
hsp_part = dx - hsp_whole * hsp_sign;
	
for (var i = 0; i < abs(hsp); ++i)
{
	if (!place_empty(x + sign(hsp), y, Obj_Block)
			|| !in_air && (place_empty(x + sign(hsp) * sprite_width, y + 1, Obj_Block)))
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
	//instance_create_depth(x, y, 50, Obj_EnemyWalkerDead);
	instance_create_depth(x, y, 80, Obj_Bloodstain);
}