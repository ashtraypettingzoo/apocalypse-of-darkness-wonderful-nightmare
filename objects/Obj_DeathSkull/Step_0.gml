if (justCreated)
{
	var boneInstance = instance_create_depth(
			x - image_xscale * 4, y - image_yscale * 4, 10, Obj_DeathSkulBones);
	with (boneInstance)
	{
		image_xscale = other.image_xscale;
		image_yscale = other.image_yscale;
	}

	justCreated = false;
}