// Aphelion \\

#define SERVER_ONLY

#include "CreatureCommon.as";
#include "CreatureTargeting.as";
#include "BrainCommon.as";
#include "PressOldKeys.as";

void onInit( CBrain@ this )
{
	InitBrain( this );

	CBlob@ blob = this.getBlob();
	blob.set_u8( delay_property, 5 + XORRandom(5) );

	if (!blob.exists(target_searchrad_property))
		 blob.set_f32(target_searchrad_property, 512.0f);
	
	//this.getCurrentScript().removeIfTag	= "dead";
	this.getCurrentScript().runFlags |= Script::tick_not_attached;
}

void onTick( CBrain@ this )
{
	CBlob@ blob = this.getBlob();
	CBlob@ target = this.getTarget();

	u8 delay = blob.get_u8(delay_property);
	delay--;

	if (delay == 0)
	{
		delay = 5 + XORRandom(10);

	    // do we have a target?
        if (target !is null)
        {
    	    // check if the target needs to be dropped
		    if (ShouldLoseTarget(blob, target))
		    {
		    	RemoveTarget(this);
		    	return;
		    }

            // aim always at enemy
            blob.setAimPos( target.getPosition() );

            // chase target
            if (getDistanceBetween(target.getPosition(), blob.getPosition()) > blob.getRadius() + blob.get_f32( "attack distance" ) / 2)
            {
		        PathTo( blob, target.getPosition() );
                
			    // scale walls and jump over small blocks
			    ScaleObstacles( blob, target.getPosition() );
			
			    // destroy any attackable obstructions such as doors
			    DestroyAttackableObstructions( this, blob );
            }
	    }
	    else
	    {
		    GoSomewhere(this, blob); // just walk around looking for a target
	    }
	}
	else
	{
		PressOldKeys( blob );
	}

	blob.set_u8(delay_property, delay);
}

void FindTarget( CBrain@ this, CBlob@ blob, f32 radius )
{
    if (!blob.hasTag("is_stuck"))
	{
		CBlob@ target = GetBestTarget(this, blob, radius);
		if (target !is null) this.SetTarget(target);
	} else {
		CBlob@ target = GetClosestVisibleTarget(this, blob, radius);
		if (target !is null) this.SetTarget(target);
	}
}

bool ShouldLoseTarget( CBlob@ blob, CBlob@ target )
{
	bool result = false;
	if (target.hasTag("dead"))
		result = true;
	else if(getDistanceBetween(target.getPosition(), blob.getPosition()) > blob.get_f32(target_searchrad_property))
		result = true;
	else
	    result = !isTargetVisible(blob, target) && XORRandom(30) == 0;

	if (result && blob.hasTag("is_stuck"))
		blob.Untag("is_stuck");
	return result;
}

void GoSomewhere( CBrain@ this, CBlob@ blob )
{
	// look for a target along the way :)
    FindTarget(this, blob, blob.get_f32(target_searchrad_property));

    // get our destination
	Vec2f destination = blob.get_Vec2f(destination_property);

	if (!blob.exists(destination_property) || getDistanceBetween(destination, blob.getPosition()) < 128 || XORRandom(30) == 0)
	{
		NewDestination(blob);
		return;
	}
     
    // aim at the destination
    blob.setAimPos( destination );

	// go to our destination
	PathTo( blob, destination );

	// scale walls and jump over small blocks
	ScaleObstacles( blob, destination );

	// destroy any attackable obstructions such as doors
	DestroyAttackableObstructions( this, blob );
}


void PathTo( CBlob@ blob, Vec2f destination )
{
	Vec2f mypos = blob.getPosition();

	if (destination.x < mypos.x)
	{
		blob.setKeyPressed(key_left, true);
	}
	else
	{
		blob.setKeyPressed(key_right, true);
	}

	if (destination.y + getMap().tilesize < mypos.y)
	{
		blob.setKeyPressed(key_up, true);
	}
}

void ScaleObstacles( CBlob@ blob, Vec2f destination )
{
	Vec2f mypos = blob.getPosition();

	const f32 radius = blob.getRadius();
	// check if possibly touching other zombies
	bool touchingOther = !blob.isOnGround() && blob.getTouchingCount() > 0;
	// if we're touching someone, check if it's a zombie
	if (touchingOther)
	{
		touchingOther = false;
		const uint count = blob.getTouchingCount();
		for (uint step = 0; step < count; ++step)
		{
			CBlob@ _blob = blob.getTouchingByIndex(step);
			if (_blob.hasTag("zombie"))
			{
				touchingOther = true;
				break;
			}
		}
	}

	if (blob.isOnLadder() || (blob.isInWater() && !blob.hasTag("is_stuck")))
	{	
	    blob.setKeyPressed(destination.y < mypos.y ? key_up : key_down, true);
	}
	else if (touchingOther || blob.isOnWall() || (blob.hasTag("is_stuck") && blob.isInWater()))
	{
		blob.setKeyPressed(key_up, true);
	}
	else
	{
		if ((blob.isKeyPressed(key_right)  && (getMap().isTileSolid( mypos + Vec2f( 1.3f * radius, radius) * 1.0f ) || blob.getShape().vellen < 0.1f)) ||
			(blob.isKeyPressed(key_left )  && (getMap().isTileSolid( mypos + Vec2f(-1.3f * radius, radius) * 1.0f ) || blob.getShape().vellen < 0.1f)))
		{
			blob.setKeyPressed(key_up, true);
		}
	}
}

void DestroyAttackableObstructions( CBrain@ this, CBlob@ blob )
{
	Vec2f col;

	if (getMap().rayCastSolid(blob.getPosition(), blob.getAimPos(), col))
	{
		CBlob@ obstruction = getMap().getBlobAtPosition(col);

		if (isTarget(blob, obstruction))
		{
		    this.SetTarget(obstruction);
		}
	}
}

void NewDestination( CBlob@ blob )
{
    CMap@ map = getMap();

	if (map !is null)
	{
		Vec2f destination = Vec2f_zero;

		// go somewhere near the center of the map if we have just spawned
		if(!blob.exists(destination_property))
		{
		    f32 x = XORRandom(2) == 0 ? map.tilemapwidth / 2 + XORRandom(map.tilemapwidth / 4) :
					                    map.tilemapwidth / 2 - XORRandom(map.tilemapwidth / 4);
			
			x *= map.tilesize;
			x = Maths::Min(s32(map.tilemapwidth * map.tilesize - 32), Maths::Max(32, s32(x)));

			destination = Vec2f(x, map.getLandYAtX(s32(x / map.tilesize)) * map.tilesize);
		}

		// somewhere near
		else
		{
			int rand = XORRandom(4);
			f32 x = rand == 0 ? map.tilemapwidth / 2 + XORRandom(map.tilemapwidth / 2) :
					rand == 1 ?	map.tilemapwidth / 2 - XORRandom(map.tilemapwidth / 2) :
					rand == 2 ? blob.getPosition().x + XORRandom(map.tilemapwidth / 4) :
						        blob.getPosition().x - XORRandom(map.tilemapwidth / 4);
			
			x *= map.tilesize;
			x = Maths::Min(s32(map.tilemapwidth * map.tilesize - 32), Maths::Max(32, s32(x)));
			
			destination = Vec2f(x, map.getLandYAtX(s32(x / map.tilesize)) * map.tilesize);
		}
		
        // aim at destination
        blob.setAimPos(destination);

		// set destination
	    blob.set_Vec2f(destination_property, destination);
	}
}