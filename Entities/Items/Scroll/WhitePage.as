#include "Hitters.as";
#include "RespawnCommandCommon.as"
#include "StandardRespawnCommand.as"
void onInit( CBlob@ this )
{
	if (getNet().isServer())
	{
		// decay after 60 sec if not in inventory
		this.set_u16('decay time', 60);
	}
}