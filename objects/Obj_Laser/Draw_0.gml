

var w = laser_width *  laser_dir;
draw_rectangle_color(
		x + zap_xoffset + w - 3, y + zap_yoffset - 3, x + zap_xoffset + w + 3, y + zap_yoffset + 3, 
		zap_col, zap_col, zap_col, zap_col, false);

if (col_count > 1)
	DrawSineLine(x, y, w, h, grab_mode ? $22ff22 : $0077ff, freq, phase + 1.1);
if (col_count != 0)
	DrawSineLine(x, y, w, h, grab_mode ? $22ff22 : $00ffff, freq, phase);
