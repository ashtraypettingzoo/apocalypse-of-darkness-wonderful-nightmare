var drawx = x + camera_get_view_x(camera_get_active());
var drawy = y + camera_get_view_y(camera_get_active());
if (!variable_global_exists("enemies"))
	draw_text(drawx, drawy, "FPS = " + string(fps));
else
	draw_text(drawx, drawy, "FPS = " + string(fps) + ", Enemies = " + string(global.enemies));