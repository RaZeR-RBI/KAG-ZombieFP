#define SERVER_ONLY
#include "Hitters.as"

void onInit(CBlob@ this)
{
	this.getCurrentScript().tickFrequency = 90; // 3 sec
}

void onTick(CBlob@ this)
{
	CBlob@ target = this.getCarriedBlob();
	if (target is null) {
		return;
	}

	bool isEnemy = this.hasTag("zombie") && target.hasTag("survivorplayer");
	if (!isEnemy) {
		return;
	}

	f32 damage = 0.5f;
	if (this.exists("carried_damage")) {
		damage = this.get_f32("carried_damage");
	}
	Vec2f pos = target.getPosition();
	this.server_Hit(target, pos, Vec2f(), damage, Hitters::stab);
}