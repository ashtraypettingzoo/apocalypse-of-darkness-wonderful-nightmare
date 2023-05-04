// walk....
if (random(25) < 1)
	walk_dir = floor(random(3) - 1);
for (var i = 0; i < 3; ++i)
{
	if (!place_empty(x + walk_dir, y, Obj_Block))
		break;
	if (place_empty(x + walk_dir * sprite_width, y + 1, Obj_Block))
		break;
	x += walk_dir;
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