if (shake_counter <= 0)
{
	shake_counter = 8 + floor(random(2));
	prev_shake *= -1;
	x += prev_shake * 4;
}
shake_counter--;

vsp += vsp_acc;
y_start += vsp;
wobble_counter = (wobble_counter + 0.07) % (2 * pi);
y = y_start + 15 * sin(wobble_counter + phase);

if (y < 50)
	instance_destroy();

var brain = instance_place(x, y, Obj_Brain);
if (!killed && brain != noone && brain.curr_mode == BrainMode.FREE)
{
	killed = true;
	instance_destroy(brain);
}

if (killed)
{
	instance_destroy();
	instance_create_depth(x, y, 80, Obj_Bloodstain);
}