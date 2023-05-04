#macro counter_max 250
#macro deltaphase_start 4
#macro deltaphase_end 35
#macro freq_start 600
#macro freq_end 30
#macro h_start 12
#macro h_end 40

laser_width = 0;
laser_dir = 1;
phase = 0;

counter = 0;
freq = freq_start;
h = h_start;

zap_xoffset = 0;
zap_yoffset = 0;

zap_col = $ffee33;

col_count = 0;
player_instance = 0;
grab_mode = false;
curr_brain = noone;
cancelled = false;