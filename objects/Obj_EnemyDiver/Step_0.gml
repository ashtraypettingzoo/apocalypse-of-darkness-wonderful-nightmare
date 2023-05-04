if (pause_count > 0)
{
	vsp = 0;
	pause_count--;
	if (pause_count < 1)
		ascending = true;
}
else if (descending)
{
	vsp = 40;
}
else if (ascending)
{
	vsp = -15;
}
else
{
	vsp = 0; 
	
	for (var i = 0; i < 1000; i += 4)
	{
		if (!place_empty(x, y + i, Obj_Block))
			break;
		if (!place_empty(x, y + i, Obj_Playa))
		{
			descending = true;
			break;
		}
	}
}

for (var i = 0; i < abs(vsp); ++i)
{
	if (!place_empty(x, y + sign(vsp), Obj_Block))
	{
		pause_count = 60;
		descending = false;
		break;
	}
	if (!place_empty(x, y + sign(vsp), Obj_Brain))
	{
		killed = true;
		break;
	}
	
	if (y <= y_start && ascending)
	{
		ascending = false;
		break;
	}
	
	y += sign(vsp);
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