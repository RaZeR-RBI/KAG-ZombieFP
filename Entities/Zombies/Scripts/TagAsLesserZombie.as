#include "CreatureCommon.as";

void onInit( CBlob@ this )
{
	this.Tag("lesser_zombie");
	SetupTargets(this);
}

void SetupTargets( CBlob@ this )
{
	TargetInfo[] infos;

	addTargetInfo(infos, "survivorplayer", 1.0f, true, true);
	addTargetInfo(infos, "ally", 1.0f, true);
	addTargetInfo(infos, "pet", 0.9f, true);
	addTargetInfo(infos, "lantern", 0.9f);
	addTargetInfo(infos, "wooden_door", 0.8f);
	addTargetInfo(infos, "survivorbuilding", 0.6f, true);
	addTargetInfo(infos, "mounted_bow", 0.6f);
	addTargetInfo(infos, "mounted_bazooka", 0.6f);
	addTargetInfo(infos, "wood_block", 0.5f);

	//for EatOthers
	string[] tags = {"dead"};
	this.set("tags to eat", tags);
	
	this.set("target infos", @infos);
}