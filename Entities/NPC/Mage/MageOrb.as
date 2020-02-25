void onInit( CBlob@ this )
{
	this.Tag("exploding");
	this.set_f32("explosive_radius", 10.0f );
	this.set_f32("explosive_damage", 2.0f);
	this.set_f32("map_damage_radius", -1.0f);
	this.set_f32("map_damage_ratio", -1.0f); //heck no!
}	

void onTick( CBlob@ this )
{     
	if(this.getCurrentScript().tickFrequency == 1)
	{
		this.getShape().SetGravityScale( 0.0f );
		this.server_SetTimeToDie(3);
		this.SetLight( true );
		this.SetLightRadius( 24.0f );
		this.SetLightColor( SColor(255, 211, 121, 224 ) );
		this.set_string("custom_explosion_sound", "OrbExplosion.ogg");
		// this.getSprite().PlaySound("OrbFireSound.ogg");
		this.getSprite().SetZ(1000.0f);
		
		//makes a stupid annoying sound
		//ParticleZombieLightning( this.getPosition() );
		
		// done post init
		this.getCurrentScript().tickFrequency = 10;
	}
	
	{
		u16 id = this.get_u16("target");
		if(id != 0xffff && id != 0)
		{
			CBlob@ b = getBlobByNetworkID(id);
			if( b !is null)
			{
				Vec2f vel = this.getVelocity();
				if(vel.LengthSquared() < 9.0f)
				{				
					Vec2f dir = b.getPosition()-this.getPosition();
					dir.Normalize();
					
					
					this.setVelocity(vel+dir*3.0f);
				}
			}
		}
	}
}	

bool doesCollideWithBlob( CBlob@ this, CBlob@ blob )
{
	return (blob.hasTag("enemy"));
}

void onCollision( CBlob@ this, CBlob@ blob, bool solid )
{
	if(solid)
	{
		if(blob !is null && blob.getTeamNum() != this.getTeamNum())
			this.server_Die();			
	}
}
