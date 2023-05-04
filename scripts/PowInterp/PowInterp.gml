// Script assets have changed for v2.3.0 see
// https://help.yoyogames.com/hc/en-us/articles/360005277377 for more information
function PowInterp(y1, y2, x, pow)
{
	return y1 + power(x, pow) * (y2 - y1);
}