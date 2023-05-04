if (layer_count > 0)
{
	for (var i = -1; i <= 1; ++i)
	{
		for (var j = -1; j <= 1; ++j)
		{
			if ((i == 0 && j == 0)
					|| !place_empty(x + i * sprite_width, y + j * sprite_height, Obj_Fire)
					|| !place_empty(x + i * sprite_width, y + j * sprite_height, Obj_Block))
				continue;
			var new_fire = instance_create_depth(
					x + i * sprite_width, y + j * sprite_height, depth, Obj_Fire);
			new_fire.layer_count = layer_count - 1;
		}
	}
}