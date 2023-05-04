if (variable_global_exists("enemies") && global.enemies == 0)
	enabled = true;
	
image_blend = enabled ? $44ffff : $000044;

depth = 20;