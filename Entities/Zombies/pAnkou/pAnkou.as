// Aphelion \\

#include "CreatureCommon.as";
#include "Hitters.as";

const u8 ATTACK_FREQUENCY = 45;
const f32 ATTACK_DAMAGE = 0.25f;

const int COINS_ON_DEATH = 25;

void onInit(CBlob@ this)
{
	this.set_u8("attack frequency", ATTACK_FREQUENCY);
	this.set_f32("attack damage", ATTACK_DAMAGE);
	this.set_u8("attack hitter", Hitters::fire);
	this.set_string("attack sound", "AnkouAttack");
	this.set_u16("coins on death", COINS_ON_DEATH);
	this.set_f32(target_searchrad_property, 512.0f);

    this.getSprite().PlayRandomSound("/AnkouSpawn");
	this.getShape().SetRotationsAllowed(false);

	this.getBrain().server_SetActive(true);

	this.set_f32("gib health", 0.0f);
    this.Tag("flesh");

	this.set_f32("explosive_radius", 48.0f);
	this.set_f32("explosive_damage", 3.0f);
	this.set_string("custom_explosion_sound", "Entities/Items/Explosives/KegExplosion.ogg");
	this.set_f32("map_damage_radius", 56.0f);
	this.set_f32("map_damage_ratio", 0.3f);
	this.set_bool("map_damage_raycast", true);
	this.set_bool("explosive_teamkill", true);
	
	this.getCurrentScript().runFlags |= Script::tick_not_attached;
	this.getCurrentScript().removeIfTag = "dead";
}

void onTick(CBlob@ this)
{
	if (getNet().isClient() && XORRandom(768) == 0)
	{
		this.getSprite().PlaySound("/AnkouSayDuh");
	}

	if (getNet().isServer() && getGameTime() % 10 == 0)
	{
		CBlob@ target = this.getBrain().getTarget();

		if (target !is null && this.getDistanceTo(target) < 72.0f)
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
	    this.getSprite().PlaySound("/AnkouHit");
    }

	return damage;
}

void onDie( CBlob@ this )
{
	server_DropCoins(this.getPosition() + Vec2f(0, -3.0f), COINS_ON_DEATH);

    this.getSprite().PlaySound("/AnkouBreak1");	
}