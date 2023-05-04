var brain = instance_place(x, y, Obj_Brain);
if (brain != noone && brain.curr_mode == BrainMode.FREE)
{
	hp--;
	damage_time_ctr = 30;
	instance_destroy(brain);
}

if (damage_time_ctr > 0)
	damage_time_ctr--;
	
if (hp <= 0)
{
	room_goto_next();	
}