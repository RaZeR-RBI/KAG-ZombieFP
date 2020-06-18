﻿// Aphelion \\

#include "pBansheeScreech.as";

#include "CreatureCommon.as";
#include "KnockedCommon.as";

const s32 TIME_TO_EXPLODE = 5 * 30;

const int COINS_ON_DEATH = 50;

void onInit(CBlob@ this)
{
	TargetInfo[] infos;

	addTargetInfo(infos, "survivorplayer", 0.8f, true, true);
	addTargetInfo(infos, "pet", 0.9f, true);
	addTargetInfo(infos, "survivorbuilding", 1.0f, true);
	addTargetInfo(infos, "stone_door", 1.0f);
	addTargetInfo(infos, "wooden_door", 0.9f);
	addTargetInfo(infos, "mounted_bow", 0.6f);
	addTargetInfo(infos, "mounted_bazooka", 0.6f);


	this.set("target infos", infos);

	this.set_u16("coins on death", COINS_ON_DEATH);
	this.set_f32(target_searchrad_property, 512.0f);

    this.getSprite().PlaySound("BansheeSpawn.ogg");

    this.getSprite().SetEmitSound("BansheeFly.ogg");
    this.getSprite().SetEmitSoundPaused(false);
	this.getShape().SetRotationsAllowed(false);

	this.getBrain().server_SetActive(true);

	this.set_f32("gib health", 0.0f);
    this.Tag("flesh");

	// explosiveness
	this.set_f32("explosive_radius", 104.0f);
	this.set_f32("explosive_damage", 10.0f);
	this.set_string("custom_explosion_sound", "Entities/Items/Explosives/KegExplosion.ogg");
	this.set_f32("map_damage_radius", 72.0f);
	this.set_f32("map_damage_ratio", 1.0f);
	this.set_bool("map_damage_raycast", true);
	this.set_bool("explosive_teamkill", true);
	//

	this.getCurrentScript().runFlags |= Script::tick_not_attached;
	this.getCurrentScript().removeIfTag = "dead";
}

void onTick(CBlob@ this)
{
	if (this.hasTag("enraged"))
	{
		if(!this.exists("exploding"))
		{
			this.Tag("exploding");
		    this.set_s32("explosion_timer", getGameTime() + TIME_TO_EXPLODE);

            Screech(this);
		}

		if (getNet().isServer())
		{
        	s32 timer = this.get_s32("explosion_timer") - getGameTime();
       	 	if (timer <= 0)
        	{
            	// boom
                this.server_SetHealth(-1.0f);
                this.server_Die();
            }
		}
		else
		{
            this.SetLight( true );
            this.SetLightRadius(this.get_f32("explosive_radius") * 0.5f);
            this.SetLightColor( SColor(255, 211, 121, 224) );

            if (XORRandom(128) == 0)
            {
            	Screech(this);
            }
		}
	}
	else if (getGameTime() % SCREECH_INTERVAL == 0) // banshee screeching
	{
		Screech(this);
	}
}

f32 onHit( CBlob@ this, Vec2f worldPoint, Vec2f velocity, f32 damage, CBlob@ hitterBlob, u8 customData )
{
	if (damage >= 0.0f)
	{
	    this.getSprite().PlaySound( "/ZombieHit" );
    }

	return damage;
}