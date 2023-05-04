img_counter = (img_counter + 1) % 12;
var side_col = (img_counter % 4) < 1 ? $eeeeee : $ffffff;
image_alpha = damage_time_ctr <= 0 || (img_counter % 3) < 1 ? 1 : 0.5;
draw_sprite_ext(Spr_FinalBossSides, 0, x + random(20) - 5, y + random(20) - 5, 1, 1, 0, side_col, 1);
draw_sprite_ext(sprite_index, image_index, x + random(20) - 5, y + random(20) - 5, image_xscale, image_yscale, 
		image_angle, image_blend, image_alpha);