
if (xOffset == 0)
{
	xOffset = ceil(image_xscale / 8);
	yOffset = ceil(image_xscale  * random(1) / 4);
}

--offsetTimer;
if (offsetTimer < 1)
{
	xOffset *= -1;
	offsetTimer = 2;
}