void onInit(CBlob@ this)
{
	this.getCurrentScript().removeIfTag = "dead";
    this.getCurrentScript().tickFrequency = 6;
}

void onTick(CBlob@ this)
{
    this.set_u8("air_count", 186);
}