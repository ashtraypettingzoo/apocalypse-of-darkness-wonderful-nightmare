// draws a horizontal sin wave
function DrawSineLine(x, y, w, h, color, wavelength, phase)
{
	for (var i = 0; i < abs(w); ++i)
	{
		var y_offset = h * sin(i * 2 * pi / wavelength + phase) / 2;
		draw_point_color(x + i * sign(w), y + y_offset, color);
	}
}