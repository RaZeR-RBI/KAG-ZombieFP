void onTick(CSprite@ this)
{
    CSpriteLayer@ chop = this.getSpriteLayer("chop");
	if (chop !is null)
	{
		chop.SetFacingLeft(false);
		Vec2f around(0.0f, 0.0f);
        chop.RotateBy(30.0f, around);
	}
}

void onInit(CSprite@ this)
{
	this.SetZ(-10.0f);

	CSpriteLayer@ chop = this.addSpriteLayer("chop", "/Digger.png", 32, 32);

	if (chop !is null)
	{
		Animation@ anim = chop.addAnimation("default", 0, false);
		anim.AddFrame(1);
		chop.SetAnimation(anim);
		chop.SetRelativeZ(-1.0f);
	}

	this.getBlob().getShape().SetRotationsAllowed(false);
}