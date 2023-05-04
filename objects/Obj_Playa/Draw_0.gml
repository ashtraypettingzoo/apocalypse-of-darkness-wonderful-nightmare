draw_sprite_ext(sprite_index, image_index, x + (xscale != 1 ? sprite_width :0), y, xscale, image_yscale, image_angle, image_blend, image_alpha);
if (finalboss)
{
	hit_color_count = (hit_color_count + 1) % 3;
	var hit_color = hit_color_count > 0 ? $0000ee : $8888ff;
	draw_circle_color(x + sprite_width / 2, y + sprite_height / 2, 8, hit_color, hit_color, false);
	draw_circle_color(x + sprite_width / 2, y + sprite_height / 2, 8, c_black, c_black, true);
}