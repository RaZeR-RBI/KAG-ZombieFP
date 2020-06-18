#include "DecayCommon.as";
#include "HallCommon.as"

#include "KnockedCommon.as";

const string pickable_tag = "pickable";

void onInit( CBlob@ this )
{
	InitKnockable( this );
	
	this.set_f32("gib health", -3.0f);
    this.Tag("player");
    this.Tag("flesh");
	this.Tag("migrantbot");
	this.Tag("migrant");
	this.getCurrentScript().tickFrequency = 150; // opt
}

void onTick( CBlob@ this )
{
	if(this.hasTag("idle"))
	{
		this.Untag(pickable_tag);
		this.Sync(pickable_tag, true);
		
		return;
	}
	
	if(!getNet().isServer()) return; //---------------------SERVER ONLY
	
	CBlob@ owner = getOwner(this);
	
	if(owner is null || //no owner
		//or not overlapping owner (or glued somewhere)
		(!this.getShape().isStatic() && !this.isOverlapping(owner)) )
	{
		//SelfDamage( this );
		
		this.Tag(pickable_tag);
		this.Sync(pickable_tag, true);
	}
	else
	{
		this.Untag(pickable_tag);
		this.Sync(pickable_tag, true);
	}
}

bool canBePickedUp( CBlob@ this, CBlob@ byBlob )
{
	return (this.getTeamNum() == byBlob.getTeamNum() && !this.getShape().isStatic() && this.hasTag(pickable_tag));
}



