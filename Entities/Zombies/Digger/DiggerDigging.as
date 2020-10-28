#include "Hitters.as";

void onInit(CBlob@ this)
{
	this.getCurrentScript().tickFrequency = 20;
	this.getCurrentScript().removeIfTag	= "dead";
}

void onTick(CBlob@ this)
{
    if (!getNet().isServer()) {
        return;
    }

    Vec2f pos = this.getPosition();
    CMap@ map = this.getMap();
    float step = map.tilesize;
    float radius = step * 3.0f;

    for (float x = pos.x - radius; x < pos.x + radius; x += step)
    {
        for (float y = pos.y - radius; y < pos.y + radius; y += step)
        {
            Vec2f tpos = Vec2f(x, y);
            TileType tile = map.getTile(tpos).type;
            if (map.isTileBedrock(tile)) {
                continue;
            }
            map.server_DestroyTile(tpos, 0.5f, this);
        }
    }

	CBlob@[] blobsInRadius;
	if (this.getMap().getBlobsInRadius(this.getPosition(), radius, @blobsInRadius))
    {
		for (uint i = 0; i < blobsInRadius.length; i++)
		{
			CBlob @b = blobsInRadius[i];
            if (b.getName() == "digger") continue;
            bool half = !b.hasTag("survivorplayer") || b.hasTag("shielded");
            this.server_Hit(b, pos, Vec2f_zero, half ? 0.5f : 1.0f, Hitters::builder);
		}
    }
}