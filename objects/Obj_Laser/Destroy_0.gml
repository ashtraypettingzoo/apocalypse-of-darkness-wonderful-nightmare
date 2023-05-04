if (grab_mode)
{
	var finalboss = variable_global_exists("final_boss") && global.final_boss;
	if (!finalboss)
		curr_brain.vsp = -2 + -random(8);
	else
		curr_brain.vsp = -20;
	curr_brain.hsp = random(20) - 10;
	curr_brain.curr_mode = BrainMode.FREE;
}