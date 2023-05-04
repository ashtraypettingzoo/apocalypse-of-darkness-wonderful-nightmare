alarm[0] = fb_wavetime;

if (currwave % 2 < 1)
	BulletWave(floor(currwave / 2));
else
	BossCreateEnemies();

currwave = (currwave + 1) % 8;