
if (pause > 0)
	pause--;
else
{
	spd += spd_change;
	dir += dir_change;
	x += spd * cos(dir * pi / 180);
	y += spd * sin(dir * pi / 180);


	anim_ctr = (anim_ctr + 1) % 3;
	life--;
	if (life < 60 && anim_ctr <  1)
		image_alpha = image_alpha == 1 ? 0 : 1;
	if (life <= 0)
		instance_destroy();
	
	var player = instance_find(Obj_Playa, 0);
	if (player != noone)
	{
		if (distance_to_point(player.x + player.sprite_width / 2, 
				player.y + player.sprite_height / 2) < 16
				&& !player.dead)
		{
			instance_destroy();
			player.to_die = true;
		}
	}
}