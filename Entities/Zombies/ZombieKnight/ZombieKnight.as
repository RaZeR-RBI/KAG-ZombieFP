﻿// Aphelion \\

#include "CreatureCommon.as";

const u16 ATTACK_FREQUENCY = 60;
const f32 ATTACK_DAMAGE = 1.25f;
const f32 ATTACK_DISTANCE = 1.0f;

const int COINS_ON_DEATH = 35;

void onInit(CBlob@ this)
{
	this.set_u8("attack frequency", ATTACK_FREQUENCY);
	this.set_f32("attack damage", ATTACK_DAMAGE);
	this.set_f32("attack distance", ATTACK_DISTANCE);
	this.set_string("attack sound", "ZombieKnightAttack");
	this.set_u16("coins on death", COINS_ON_DEATH);
	this.set_f32(target_searchrad_property, 512.0f);

	this.getShape().SetRotationsAllowed(false);

	this.getBrain().server_SetActive(true);

	this.set_f32("gib health", -3.0f);
    this.Tag("flesh");
	
	this.getCurrentScript().runFlags |= Script::tick_not_attached;
	this.getCurrentScript().removeIfTag = "dead";
}

void onTick( CBlob@ this )
{
	if (getNet().isClient() && XORRandom(1024) == 0)
	{
		this.getSprite().PlaySound("/ZombieKnightGrowl");
	}

	if (getNet().isServer() && getGameTime() % 10 == 0)
	{
		CBlob@ target = this.getBrain().getTarget();

		if (target !is null && this.getDistanceTo(target) < 128.0f)
		{
			this.Tag(chomp_tag);
		}
		else
		{
			this.Untag(chomp_tag);
		}

		this.Sync(chomp_tag, true);
	}
}

f32 onHit( CBlob@ this, Vec2f worldPoint, Vec2f velocity, f32 damage, CBlob@ hitterBlob, u8 customData )
{
	if (damage >= 0.0f)
	{
		this.getSprite().PlaySound("/ZombieHit");
	}

	return damage;
}