event_inherited();

shake_counter = 0;
prev_shake = -1;

wobble_counter = 0;
y_start = y;

phase = random(pi * 2);

vsp = 0;
vsp_acc = 0;
alarm[0] = 250;