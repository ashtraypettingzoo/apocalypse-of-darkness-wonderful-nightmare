counter++;
if (counter > counter_max)
	counter = counter_max;
	
var rand_rad = random(1);
var rand_theta = random(2 * pi);
rand_rad *= rand_rad * 15;
zap_xoffset = rand_rad * sin(rand_theta);
zap_yoffset = rand_rad * cos(rand_theta);

col_count = (col_count + 1) % 4;

zap_col = col_count == 3 ? $ffdd22 : $3333ff;
	
freq = PowInterp(freq_end, freq_start, 1 - counter / counter_max, 6);
deltaphase = PowInterp(deltaphase_end, deltaphase_start, 1 - counter / counter_max, 4) / freq;
h = PowInterp(h_end, h_start, 1 - counter / counter_max, 1.3);

phase = (phase + deltaphase) % (2 * pi);


if (!grab_mode)
	laser_width += (0.06 * max(800 - laser_width, 0)) + 3;
if (laser_width > 1000)
	laser_width = 1000;
	
for (var i = 4; i < laser_width; ++i)
{
	if (!place_empty(x + i * laser_dir, y, Obj_Block))
	{
		laser_width = i;
		break;
	}
	
	var enemy = instance_place(x + i * laser_dir, y, Obj_EnemyGrabbable);
	if (enemy != noone && !grab_mode)
	{
		laser_width = i;
		enemy.killed = true;
		curr_brain = instance_create_depth(x + laser_width * laser_dir, y, -3, Obj_Brain);
		grab_mode = true;
		break;
	}
	
	var bomb = instance_place(x + i * laser_dir, y, Obj_Bomb);
	if (bomb != noone)
	{
		bomb.detonated = true;
		if (grab_mode)
			instance_destroy(curr_brain);
		instance_destroy();
		cancelled = true;
		player_instance.has_laser = false;
		break;
	}
}

if (grab_mode && !cancelled)
{
	laser_width -= (0.06 * max(800 - laser_width, 0)) + 3;
	if (laser_width < 20)
	{
		grab_mode = false;
		player_instance.has_item = true;
		player_instance.curr_item = curr_brain;
		player_instance.has_laser = false;
		instance_destroy();
	}
	else
	{
		curr_brain.x = x + laser_width * laser_dir;
		curr_brain.y = y;
	}
}