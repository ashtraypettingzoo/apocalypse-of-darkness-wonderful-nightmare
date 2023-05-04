enum AnimationState
{
	STILL,
	WALK,
	JUMP,
	FALL, 
	SLIDE,
	CROUCH,
	CRAWL,
	SPRINT,
	DEAD
}

audio_stop_sound(Bgm_Intermission);
if (!audio_is_playing(Bgm_Main))
	audio_play_sound(Bgm_Main, 10, true);

xscale = 1;
hsp = 0;
vsp = 0;
hsp_part = 0;
vsp_part = 0;
jump_counter = 0;
curr_anim_state = AnimationState.STILL;
slide_pause_counter = 0;
prev_against_wall = false;
walljump_counter = 0;
sliding_dir = 0;
left_key_counter = 100;
right_key_counter = 100;
up_key_counter = 100;
unslide_counter = 0;
facing_dir = 1;
in_air_before_sprint = false;
sprint_pause_counter = 0;
prev_sprinting = false;
has_item = false;
curr_item = 0;
has_laser = false;
curr_laser = 0;
dead = false;
prev_anim_state = curr_anim_state;
finalboss = false;
hit_color_count = 0;
to_die = false;

if (!variable_global_exists("deaths"))
	global.deaths = 0;
global.last_room = room;
	
	
	
	
// PARTICLEZ
part_dust = part_type_create();
part_type_sprite(part_dust, Spr_Dust, true, true, false);
part_type_size(part_dust, 0.8, 1.2, 0.04, 0.05);
part_type_scale(part_dust, 1, 1);
part_type_alpha2(part_dust, 1, 0.5);
part_type_speed(part_dust, .1, .8, 0, 0);
part_type_direction(part_dust, 0, 180, 0, 0);
part_type_life(part_dust, 20, 30);

part_dust_system = part_system_create();
part_system_depth(part_dust_system, -10);