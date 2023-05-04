var brain = instance_place(x, y, Obj_Brain);
if (!detonated && brain != noone && brain.curr_mode == BrainMode.FREE)
{
	detonated = true;
	instance_destroy(brain);
}

if (detonated)
{
	instance_destroy();
	instance_create_depth(x + sprite_width / 2, y + sprite_height / 2, 80, Obj_Bloodstain);
	for (var i = 0; i < 2; ++i)
	{
		for (var j = 0; j < 2; ++j)
		{
			var new_fire = instance_create_depth(
					x + i * sprite_width / 2, y + j * sprite_height / 2, depth, Obj_Fire);
			new_fire.layer_count = 25;
		}
	}
}