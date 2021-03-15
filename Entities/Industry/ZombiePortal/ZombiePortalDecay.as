#include "DecayCommon.as";

#define SERVER_ONLY

void onInit(CBlob@ this)
{
	this.getCurrentScript().tickFrequency = 71;
}

void onTick(CBlob@ this)
{
	if (this.getMap().isInWater(this.getPosition()))
	{
		if (DECAY_DEBUG)
			printf(this.getName() + " decay in water");
		SelfDamage(this);
	}
}