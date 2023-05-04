// Script assets have changed for v2.3.0 see
// https://help.yoyogames.com/hc/en-us/articles/360005277377 for more information
function BossCreateEnemies()
{
	instance_create_depth(128, 420, 20, Obj_EnemyWalkerBoss);
	instance_create_depth(128, 420, 10, Obj_Smoke);
	instance_create_depth(832, 420, 20, Obj_EnemyWalkerBoss);
	instance_create_depth(832, 420, 10, Obj_Smoke);
}