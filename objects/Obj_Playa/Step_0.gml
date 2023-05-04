// reading my code ?!?!? lol get a life bro.....

#macro hsp_acc_ground 3.2
#macro hsp_acc_air 2.1
#macro hsp_dec_ground 3.1
#macro hsp_dec_air 0.7
#macro hsp_dec_to_max 1.9
#macro hsp_sprint 33
#macro hsp_max 10
#macro hsp_max_crouch 3.5
#macro grav_acc_hi 1.2
#macro grav_acc_lo 0.9
#macro grav_acc_float 0.063
#macro grav_float_thresh .5
#macro grav_max 16
#macro grav_max_slide 1.5
#macro jump_spd 18
#macro jump_spd_wall_hsp 16
#macro jump_spd_wall_vsp 16
#macro jump_stop_spd_min 3.5
#macro jump_stop_spd_max 14
#macro mov_divs 4
#macro slide_pause 2
#macro walljump_time 6
#macro key_couter_max 1000
#macro unslide_wait 8
#macro sprint_pause 6
#macro death_time 0.35
#macro fb_xmin 48
#macro fb_xmax 872
#macro fb_ymin 248
#macro fb_ymax 648
#macro fb_spd_min 3
#macro fb_spd_max 6


var left_key = keyboard_check(vk_left);
var right_key = keyboard_check(vk_right);
var up_key = keyboard_check(vk_up);
var down_key = keyboard_check(vk_down);
var sprint_key = keyboard_check(ord("Z"));
var gun_key = keyboard_check(ord("X"));
var gun_pressed = keyboard_check_pressed(ord("X"));
var up_pressed = keyboard_check_pressed(vk_up);
var in_air = place_empty(x, y + 1, Obj_Block) || !place_empty(x, y, Obj_Block);
var elapsed = UsToFrames(delta_time);
var start_jump = false;
var crouching = false;
var sprinting = false;
var sprint_pausing = false;
finalboss = variable_global_exists("final_boss") && global.final_boss;

// key counters
if (left_key_counter < key_couter_max)
	left_key_counter++;
if (left_key)
	left_key_counter = 0;
if (right_key_counter < key_couter_max)
	right_key_counter++;
if (right_key)
	right_key_counter = 0;
if (up_key_counter < key_couter_max)
	up_key_counter++;
if (up_key)
	up_key_counter = 0;

// jumpsetup........
if (jump_counter > 0)
{
	--jump_counter;
	start_jump = true;
}
if (up_pressed)
	jump_counter = 3;
	
// sliding (setup)!!!!!!!!!!
var against_wall = 
	((!place_empty(x + 1, y, Obj_Block) && right_key && !left_key)
	|| (!place_empty(x - 1, y, Obj_Block) && left_key && !right_key))
	&& place_empty(x, y, Obj_Block);
var beside_wall = in_air && (!place_empty(x + 1, y, Obj_Block) || !place_empty(x - 1, y, Obj_Block)) 
		&& place_empty(x, y, Obj_Block);
var sliding = against_wall && in_air && !has_laser;
if (slide_pause_counter > 0)
	slide_pause_counter--;
if (!prev_against_wall && sliding)
	slide_pause_counter = slide_pause;
prev_against_wall = against_wall;
var slide_pausing = slide_pause_counter > 0;
walljump_counter--;
if (beside_wall)
{
	sliding_dir = !place_empty(x + 1, y, Obj_Block) ? 1 : -1;
	walljump_counter = walljump_time;
}
if (unslide_counter > 0)
	unslide_counter--;
if (!beside_wall)
	unslide_counter = 0;
if (sliding)
	unslide_counter = unslide_wait;
if (unslide_counter > 0)
	sliding = true;
var can_walljump = walljump_counter > 0;

// some sprint st*ff
if (in_air)
	in_air_before_sprint = true;
else if (!sprint_key)
	in_air_before_sprint = false;
if (sprint_pause_counter > 0)
	sprint_pause_counter--;

if (to_die)
{
	hsp = vsp = 0;
	dead = true;
	to_die = false;
	alarm[0] = death_time * room_speed;
	instance_create_depth(x + sprite_width / 2, y + sprite_height / 2, 80, Obj_Bloodstain);
}

if (dead && finalboss)
{
	y -= 60;
}

var lvlend = instance_place(x, y, Obj_LevelEnd);
if (lvlend != noone && lvlend.enabled)
	room_goto_next();


var movement_active = !slide_pausing && !dead;

if (movement_active)
{
	// movement logic loop thing.... . . .														hello :3
	var dx = hsp_part;
	var dy = vsp_part;
	
	for (var i = 0; i < mov_divs; ++i)
	{
		// DIE!!!!!?!?!
		if (!place_empty(x, y, Obj_Damage))
		{
			hsp = vsp = 0;
			dead = true;
			alarm[0] = death_time * room_speed;
			instance_create_depth(x + sprite_width / 2, y + sprite_height / 2, 80, Obj_Bloodstain);
			break;
		}
			
		if (!finalboss)
		{
			// crouching+sprinting~~~
			sprinting = !in_air && sprint_key && !in_air_before_sprint && !has_laser;
			crouching = down_key && !in_air && !sprinting && !has_laser;
			if (sprinting && !prev_sprinting)
				sprint_pause_counter = sprint_pause;
			sprint_pausing = sprint_pause_counter > 0;
			prev_sprinting = sprinting;
	
			// accelertion + friction....
			var curr_hsp_max = sliding ? 0 : (crouching ? hsp_max_crouch : hsp_max);
			if (left_key && !right_key && hsp > -curr_hsp_max)
			{
				hsp -= (in_air ? hsp_acc_air : hsp_acc_ground) * elapsed / mov_divs;
				if (hsp < -curr_hsp_max)
					hsp = -curr_hsp_max;
			}
			else if (right_key && !left_key && hsp < curr_hsp_max)
			{
				hsp += (in_air ? hsp_acc_air : hsp_acc_ground) * elapsed / mov_divs;
				if (hsp > curr_hsp_max)
					hsp = curr_hsp_max;
			}
			else if (hsp != 0)
			{
				var hsp_sign_old = sign(hsp);
				var curr_hsp_dec =
						abs(hsp) > curr_hsp_max ? hsp_dec_to_max :
						(left_key ^^ right_key ? 0 :
						(in_air ? hsp_dec_air : 
						hsp_dec_ground));
				hsp -= hsp_sign_old * curr_hsp_dec * elapsed / mov_divs;
				if (sign(hsp) != hsp_sign_old)
					hsp = 0;
			}
		
			// okay sprinting again real quick
			if (sprint_pausing)
				hsp = 0;
			else if (sprinting)
				hsp = hsp_sprint * facing_dir;

			// jumping 
			if (!in_air && start_jump)
			{
				vsp = -jump_spd;
				in_air = true;
			}
			if (in_air && !up_key && vsp < -jump_stop_spd_min && vsp > -jump_stop_spd_max)
				vsp = -jump_stop_spd_min;
			
			// walljumppppp
			if (can_walljump && !has_laser)
			{
				if (sliding_dir == 1 && 
						((left_key_counter < walljump_time && up_key) ||
						(up_key_counter < walljump_time && left_key)))
				{
					hsp = -jump_spd_wall_hsp;
					vsp = -jump_spd_wall_vsp;
				}
				if (sliding_dir == -1 && 
						((right_key_counter < walljump_time && up_key) ||
						(up_key_counter < walljump_time && right_key)))
				{
					hsp = jump_spd_wall_hsp;
					vsp = -jump_spd_wall_vsp;
				}
			}
	
			// gravity!!?!
			if (in_air)
			{
				var grav_acc = grav_acc_hi;
				if (up_key && vsp < 0)
					grav_acc = vsp < -grav_float_thresh ? grav_acc_lo : grav_acc_float;
				vsp += grav_acc * elapsed / mov_divs;
				var curr_grav_max = sliding ? grav_max_slide : grav_max;
				if (vsp > curr_grav_max)
					vsp = curr_grav_max;
			}
		}
		
		// FINAL BOSS CONTROLZ!!!!!!!!
		if (finalboss)
		{
			var curr_fb_spd = sprint_key ? fb_spd_min : fb_spd_max;
			
			if (up_key && !down_key)
				vsp = -curr_fb_spd;
			else if (down_key && !up_key)
				vsp = curr_fb_spd;
			else 
			vsp = 0;
				
			if (left_key && !right_key)
				hsp = -curr_fb_spd;
			else if (right_key && !left_key)
				hsp = curr_fb_spd;
			else
				hsp = 0;
		}
	
		// apply speed to deltas
		dx += hsp * elapsed / mov_divs;
		dy += vsp * elapsed / mov_divs;
	}
	
	
	

	// actually do tha movement !!!!! !! ! ! 
	var hsp_abs = abs(dx);
	var hsp_sign = sign(dx);
	var hsp_whole = floor(hsp_abs);
	hsp_part = dx - hsp_whole * hsp_sign;

	for (var i = 0; i < hsp_whole; ++i)
	{
		if (finalboss && (x + hsp_sign < fb_xmin || x + hsp_sign > fb_xmax))
		{
			hsp = hsp_part = 0;
			break;
		}
		else if (place_empty(x + hsp_sign, y, Obj_Block) || !place_empty(x, y, Obj_Block))
			x += hsp_sign;
		else
		{
			hsp = hsp_part = 0;
			break;
		}
	}

	var vsp_abs = abs(dy);
	var vsp_sign = sign(dy);
	var vsp_whole = floor(vsp_abs);
	vsp_part = dy - vsp_whole * vsp_sign;

	for (var i = 0; i < vsp_whole; ++i)
	{
		if (finalboss && (y + vsp_sign < fb_ymin || y + vsp_sign > fb_ymax))
		{
			vsp = vsp_part = 0;
			break;
		}
		else if (place_empty(x, y + vsp_sign, Obj_Block) || !place_empty(x, y, Obj_Block))
			y += vsp_sign;
		else
		{
			vsp = vsp_part = 0;
			break;
		}
	}

	x = round(x);
	y = round(y);
}

if (has_laser)
	facing_dir = facing_dir;
else if (sliding)
	facing_dir = -sliding_dir;
else if (!sprinting)
	facing_dir = left_key && !right_key ? -1 : (right_key && !left_key ? 1 : facing_dir);


// WEAPON-------------------------------------------
if (gun_pressed && !has_item && !sliding && !crouching && !sprinting)
{
	curr_laser = instance_create_depth(x, y, 20, Obj_Laser);
	curr_laser.laser_dir = facing_dir;
	curr_laser.player_instance = id;
	has_laser = true;
}
if (has_laser && !gun_key)
{
	instance_destroy(curr_laser);
	has_laser = false;
}
if (has_laser)
{
	var laser_dx = (x + sprite_width / 2) - curr_laser.x;
	curr_laser.laser_width = max(0, curr_laser.laser_width - (laser_dx * curr_laser.laser_dir));
	curr_laser.x = x + sprite_width / 2;
	curr_laser.y = y + sprite_height / 2;
}
if (has_item)
{
	curr_item.x = x + (facing_dir == 1 ? sprite_width : 0);
	curr_item.y = y + sprite_height / 2;
	
	if (gun_pressed)
	{
		curr_item.x = x + sprite_width / 2;
		curr_item.curr_mode = BrainMode.FREE;
		if (!finalboss)
		{
			curr_item.hsp = 20 * facing_dir;
			curr_item.vsp = -10;
		}
		else
		{
			curr_item.hsp = random(6) - 3;
			curr_item.vsp = -40;
		}
		has_item = false;
	}
}


// animation ~~~~
if (dead)
	curr_anim_state = AnimationState.DEAD;
else if (finalboss)
	curr_anim_state = AnimationState.FALL;
else if (sprinting)
	curr_anim_state = AnimationState.SPRINT;
else if (crouching && (left_key ^^ right_key))
	curr_anim_state = AnimationState.CRAWL;
else if (crouching)
	curr_anim_state = AnimationState.CROUCH;
else if (sliding)
	curr_anim_state = AnimationState.SLIDE;
else if (in_air && vsp < 0)
	curr_anim_state = AnimationState.JUMP;
else if (in_air)
	curr_anim_state = AnimationState.FALL;
else if (left_key ^^ right_key)
	curr_anim_state = AnimationState.WALK;
else
	curr_anim_state = AnimationState.STILL;
	


// particlez...
if (curr_anim_state == AnimationState.STILL && prev_anim_state == AnimationState.WALK)
	part_particles_create(part_dust_system, x + sprite_width / 2, y + sprite_height, part_dust, 1);
if (curr_anim_state == AnimationState.WALK && prev_anim_state == AnimationState.STILL)
	part_particles_create(part_dust_system, x + sprite_width / 2, y + sprite_height, part_dust, 2);
if (curr_anim_state == AnimationState.SLIDE
		&& (prev_anim_state == AnimationState.FALL || prev_anim_state == AnimationState.JUMP))
	part_particles_create(part_dust_system, x + sprite_width / 2, y + sprite_height, part_dust, 2);
if ((curr_anim_state == AnimationState.WALK || curr_anim_state == AnimationState.STILL)
		&& prev_anim_state == AnimationState.JUMP)
	part_particles_create(part_dust_system, x + (facing_dir == 1 ? sprite_width : 0), 
			y + sprite_height  / 2, part_dust, 2);
if (curr_anim_state == AnimationState.JUMP
		&& (prev_anim_state == AnimationState.STILL || prev_anim_state == AnimationState.WALK))
	part_particles_create(part_dust_system, x + sprite_width / 2, y + sprite_height, part_dust, 3);
prev_anim_state = curr_anim_state;




xscale = facing_dir == 1 ? 1 : -1;

if (curr_anim_state == AnimationState.DEAD)
	sprite_index = Spr_PlayaStill;
else if (curr_anim_state == AnimationState.SLIDE)
	sprite_index = Spr_PlayaStill;
else if (curr_anim_state == AnimationState.CROUCH)
	sprite_index = Spr_PlayaStill;
else if (curr_anim_state == AnimationState.CRAWL)
	sprite_index = Spr_PlayaWalk;
else if (curr_anim_state == AnimationState.SPRINT)
	sprite_index = Spr_PlayaSprint;
else if (curr_anim_state == AnimationState.FALL)
	sprite_index = Spr_PlayaFall;
else if (curr_anim_state == AnimationState.JUMP)
	sprite_index = Spr_PlayaJump;
else if (curr_anim_state == AnimationState.WALK)
	sprite_index = Spr_PlayaWalk;
else if (curr_anim_state == AnimationState.STILL)
	sprite_index = Spr_PlayaStill;

// reset room/game, also die ????!?!
if (keyboard_check_pressed(ord("R"))) 
	game_restart();
	
if (keyboard_check_pressed(ord("N"))) 
	room_goto_next();
	
if (keyboard_check_pressed(ord("D"))) 
{
	room_goto(Rm_DeathRoom);
	++global.deaths;
}