// Migrant effects/sounds for client

#include "MigrantBotCommon.as"

void onInit( CBlob@ this )
{
	this.getCurrentScript().tickFrequency = 29;
	this.getSprite().PlaySound("/MigrantSayHello", 1.0f, 1.5f);
}

void onTick( CBlob@ this )
{
	if (this.hasTag("dead"))
	{
		CPlayer@ p = getLocalPlayer();	
		if (p !is null && p.getTeamNum() == this.getTeamNum())
		{
			//Sound::Play("/depleting.ogg");
		}
		this.getCurrentScript().runFlags |= Script::remove_after_this;
	}

	if (!this.hasTag("migrant"))
	{
		this.getCurrentScript().runFlags |= Script::remove_after_this;
		return;
	}

	u8 strategy = this.get_u8("strategy");	
	if (strategy == Strategy::runaway)
	{						  
		//if (XORRandom(7) == 0)
		//{
		//	this.getSprite().PlaySound("/MigrantScream");  // temp: fix for migrants screaming all the time
		//}
		if (getGameTime() - this.get_u32("last_scream_time") > 60 + XORRandom(20))
		{
			this.getSprite().PlaySound("/MigrantScream", 1.0f, 1.5f);
			this.set_u32("last_scream_time", getGameTime());
		}
	}
	else
	{
		const int t = this.getCurrentScript().tickFrequency;
		const int t2 = this.getTickSinceCreated();
		if (t2 > t && t2 <= t*2 && this.isOverlapping("hall"))
		{																								   
			this.getSprite().PlaySound("/MigrantSayHello", 1.0f, 1.5f);
		}	
	}
}

void onCollision( CBlob@ this, CBlob@ blob, bool solid )
{
	if (blob !is null)
	{
		if (XORRandom(2) == 0 && blob.hasTag("player"))
		{
			if (blob.getTeamNum() == this.getTeamNum())
			{
				if (XORRandom(5) == 0 && !blob.hasTag("migrant"))
				{
					this.getSprite().PlaySound("/MigrantSayFriend", 1.0f, 1.5f);
				}
			}
			else 
			if (this.getTeamNum() < 10)
			{
				this.getSprite().PlaySound("/MigrantSayNo", 1.0f, 1.5f);
			}
		}
	}
	//	else if (blob.getName() == "warboat" || blob.getName() == "longboat") // auto-get inside boat
	//	{														
	//		blob.server_PutInInventory( this );
	//		this.getSprite().PlaySound("/PopIn.ogg");
	//	}
	//}
}

// sound when player spawns into migrant

void onSetPlayer( CBlob@ this, CPlayer@ player )
{
	if (player !is null)
	{
		if (player.isMyPlayer()) {
			Sound::Play("Respawn.ogg");
		}
		else {
			this.getSprite().PlaySound("Respawn.ogg");
		}
	}
}


void onChangeTeam( CBlob@ this, const int oldTeam )
{
	// calm down
	this.set_u8("strategy", 0);	
}