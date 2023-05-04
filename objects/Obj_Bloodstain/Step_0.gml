++counter;
if (counter >= 4)
	counter = 0;

depth = 200;

image_blend = counter < 2 ? $aaaaaa : $ffffff;

var finalboss = variable_global_exists("final_boss") && global.final_boss;
if (finalboss)
{
	y -= 60;
	if (y < 100)
		instance_destroy();
}