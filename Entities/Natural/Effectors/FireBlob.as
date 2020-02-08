//FireBall
//based on Goo Ball

#include "Hitters.as";
#include "FireParticle.as";
#include "FireCommon.as";

const f32 DAMAGE = 2.0f;
const f32 HITDAMAGE = 0.5f;
const f32 AOE = 20.0f;//radius

void onInit( CBlob@ this )
{
	this.SetLight(true);
	this.SetLightRadius(48.0f);
	this.SetLightColor(SColor(255, 255, 240, 171));

	CShape@ shape = this.getShape();
	shape.SetGravityScale(0.0f);
	ShapeConsts@ consts = shape.getConsts();
    consts.mapCollisions = true;
	consts.bullet = false;
	consts.net_threshold_multiplier = 4.0f;
	
	this.server_SetTimeToDie( 5 );
	this.getCurrentScript().tickFrequency = 10;
	this.SetLight(true);
	this.SetLightRadius(48.0f);
	this.SetLightColor(SColor(255, 255, 240, 171));	

}

void onTick( CBlob@ this )
{
	// makeFireParticle(this.getPosition(), 1);
	spawnParticles(this);
	//through ground server check
	if ( getNet().isServer() && getMap().rayCastSolidNoBlobs( this.getShape().getVars().oldpos, this.getPosition() ) )
		this.server_Die();
}

void onCollision( CBlob@ this, CBlob@ blob, bool solid, Vec2f normal, Vec2f worldPoint )
{
	Vec2f pos = this.getPosition();
	
	if (blob !is null && doesCollideWithBlob(this, blob))
	{
		this.server_Hit( blob, pos, Vec2f_zero, HITDAMAGE, Hitters::fire);
	}	
}

void spawnParticles( CBlob@ this )
{
	Vec2f center = this.getPosition();
	f32 step = 10.0f;
	for(f32 x = -AOE; x <= AOE; x += step) {
		for (f32 y = -AOE; y <= AOE; y += step) {
			// if (x * x + y * y > AOE * AOE + 0.1f) {
            if (Maths::Abs(x) + Maths::Abs(y) > AOE) {
				continue;
			}
			Vec2f pos = Vec2f(center.x + x, center.y + y);
			ParticleAnimated( randomFireTexture(), pos, Vec2f(0,0), 0.0f, 1.0f, 2, 0.0f, true );
		}
	}
}

bool doesCollideWithBlob( CBlob@ this, CBlob@ blob )
{
return (this.getTeamNum() != blob.getTeamNum() && blob.hasTag("flesh")) || blob.hasTag("ZP") || blob.hasTag("dead") || blob.hasTag("enemy");
}

void onDie( CBlob@ this )
{
	Vec2f pos = this.getPosition();
	CBlob@[] aoeBlobs;
	CMap@ map = getMap();
	
	if ( getNet().isServer() )
	{
		map.getBlobsInRadius( pos, AOE, @aoeBlobs );
		for ( u8 i = 0; i < aoeBlobs.length(); i++ )
		{
			CBlob@ blob = aoeBlobs[i];
			if ( !getMap().rayCastSolidNoBlobs( pos, blob.getPosition() ) )
				this.server_Hit( blob, pos, Vec2f_zero, DAMAGE, Hitters::fire);
		}
	}
	
	ParticleAnimated( "/LargeSmoke.png",
				  this.getPosition(), Vec2f(0,0), 0.0f, 1.0f,
				  3,
				  -0.1f, false );
}