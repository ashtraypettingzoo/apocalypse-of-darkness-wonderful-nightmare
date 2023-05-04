#macro cam_width 960
#macro cam_height 720

var player = instance_find(Obj_Playa, 0);
if (player != noone)
{
	var player_center_x = player.x + player.sprite_width / 2;
	var player_center_y = player.y + player.sprite_height / 2;
	x = lerp(x, clamp(player_center_x, cam_width / 2, room_width - cam_width / 2), 0.12);
	y = lerp(y, clamp(player_center_y, cam_height / 2, room_height - cam_height / 2), 0.12);
}
x = clamp(x, cam_width / 2, room_width - cam_width / 2);
y = clamp(y, cam_height / 2, room_width - cam_height / 2);
