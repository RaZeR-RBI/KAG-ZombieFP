#include "CreatureCommon.as";

const int COINS_ON_DEATH = 10;

void onInit(CBlob@ this)
{
	TargetInfo[] infos;
	addTargetInfo(infos, "survivorplayer", 1.0f, true, true);
	addTargetInfo(infos, "pet", 0.9f, true);
	addTargetInfo(infos, "stone_door", 0.9f);
	addTargetInfo(infos, "wooden_door", 0.9f);
	addTargetInfo(infos, "survivorbuilding", 0.6f, true);

	this.set("target infos", infos);

	this.set_u16("coins on death", COINS_ON_DEATH);
	this.set_f32(target_searchrad_property, 512.0f);

    this.getSprite().PlaySound("WraithSpawn.ogg");

    this.getSprite().SetEmitSound("WraithFly.ogg");
    this.getSprite().SetEmitSoundPaused(false);
	this.getShape().SetRotationsAllowed(false);

	this.getBrain().server_SetActive(true);
	
	this.set_f32("gib health", 0.0f);
    this.Tag("flesh");
	this.Tag("ignore_obstructions");
	this.Tag("target_until_dead");
	this.Tag("enraged");

	this.getCurrentScript().runFlags |= Script::tick_not_attached;
	this.getCurrentScript().removeIfTag = "dead";
}

void onTick(CBlob@ this)
{

}

f32 onHit( CBlob@ this, Vec2f worldPoint, Vec2f velocity, f32 damage, CBlob@ hitterBlob, u8 customData )
{
	if (damage >= 0.0f)
	{
	    this.getSprite().PlaySound("/ZombieHit");
    }

	return damage;
}
