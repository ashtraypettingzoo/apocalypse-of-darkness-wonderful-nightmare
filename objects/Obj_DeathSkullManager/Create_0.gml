if (!variable_global_exists("deaths"))
	global.deaths = 1;

var deaths = max(global.deaths, 1);
var rows = ceil(sqrt(deaths / 2));
var columns = rows * 2;
var usedColumns = deaths < columns ? deaths : columns;
var totalHeight = 300;
var spriteHeight = 8;
var gapAmt = .9;
var scale = (totalHeight / (rows + ((rows - 1) * gapAmt))) / spriteHeight;
var xOffset = (usedColumns + ((usedColumns - 1) * gapAmt)) * (scale * spriteHeight) / 2;

for (var j = 0, d = deaths; j < rows && d > 0; ++j)
{
	for (var i = 0; i < columns && d > 0; ++i)
	{
		var skullX = room_width / 2 - xOffset + (i * scale * spriteHeight * (1 + gapAmt));
		var skullY = (room_height - totalHeight) / 2 + (j * scale * spriteHeight * (1 + gapAmt))
		var skull = instance_create_depth(
				skullX, skullY, 5, Obj_DeathSkull);
		with (skull)
		{
			image_xscale = scale;
			image_yscale = scale;
		}
		--d;
	}
}

alarm[0] = room_speed * 0.37;
