// Vehicle Workshop

#include "Requirements.as";
#include "Requirements_Tech.as";
#include "ShopCommon.as";
#include "Descriptions.as";
#include "WARCosts.as";
#include "CheckSpam.as";
#include "TeamIconToken.as"

const s32 cost_catapult = 80;
const s32 cost_ballista = 200;
const s32 cost_dinghy = 25;
const s32 cost_longboat = 50;
const s32 cost_warboat = 250;
const s32 cost_glider = 500;
const s32 cost_zeppelin = 1000;
const s32 cost_ballista_ammo = 75;
const s32 cost_ballista_bomb_ammo = 100;

void onInit(CBlob@ this)
{
	this.set_TileType("background tile", CMap::tile_castle_back);

	this.getSprite().SetZ(-50); //background
	this.getShape().getConsts().mapCollisions = false;

	AddIconToken("$vehicleshop_upgradebolts$", "BallistaBolt.png", Vec2f(32, 8), 1);

	// SHOP
	this.set_Vec2f("shop offset", Vec2f(0, 0));
	this.set_Vec2f("shop menu size", Vec2f(4, 5));
	this.set_string("shop description", "Buy Vehicles");
	this.set_u8("shop icon", 25);

	int team_num = this.getTeamNum();

	{
		string cata_icon = getTeamIcon("catapult", "VehicleIcons.png", team_num, Vec2f(32, 32), 0);
		ShopItem@ s = addShopItem(this, "Catapult", cata_icon, "catapult", "$catapult$\n\n\n" + descriptions[5], false, true);
		s.crate_icon = 4;
		AddRequirement(s.requirements, "coin", "", "Coins", 100);
	}
	{
		string ballista_icon = getTeamIcon("ballista", "VehicleIcons.png", team_num, Vec2f(32, 32), 1);
		ShopItem@ s = addShopItem(this, "Ballista", ballista_icon, "ballista", "$ballista$\n\n\n" + descriptions[6], false, true);
		s.crate_icon = 5;
		AddRequirement(s.requirements, "coin", "", "Coins", 200);
		AddRequirement(s.requirements, "blob", "mat_gold", "Gold", 50);
	}
	{
		ShopItem@ s = addShopItem(this, "Tank", "$tank$", "tank", "$tank$\n\n\n" + "Packs quite a punch.", false, true);
		s.crate_icon = 11;
		AddRequirement(s.requirements, "coin", "", "Coins", 300);
	}
	{
		ShopItem@ s = addShopItem(this, "Zeppelin", "$zeppelin$", "zeppelin", "Flying warship.", false, true);
		AddRequirement(s.requirements, "coin", "", "Coins", 600);
		s.crate_icon = 19;
	}
	{
		ShopItem@ s = addShopItem(this, "Balloon", "$balloon$", "balloon", "A small ballon, fitting for 2 people.", false, true);
		AddRequirement(s.requirements, "coin", "", "Coins", 400);
		s.crate_icon = 7;
	}
	{
		ShopItem@ s = addShopItem(this, "Glider", "$glider$", "glider", "A small and fast airship.", false, true);
		AddRequirement(s.requirements, "coin", "", "Coins", 200);
		s.crate_icon = 3;
	}
	{
		string dinghy_icon = getTeamIcon("dinghy", "VehicleIcons.png", team_num, Vec2f(32, 32), 5);
		ShopItem@ s = addShopItem(this, "Dinghy", dinghy_icon, "dinghy", "$dinghy$\n\n\n" + descriptions[10], false, true);
		AddRequirement(s.requirements, "coin", "", "Coins", 50);
		s.crate_icon = 10;
	}
	{
		string longboat_icon = getTeamIcon("longboat", "VehicleIcons.png", team_num, Vec2f(32, 32), 4);
		ShopItem@ s = addShopItem(this, "Longboat", longboat_icon, "longboat", "$longboat$\n\n\n" + descriptions[33], false, true);
		AddRequirement(s.requirements, "coin", "", "Coins", 100);
		s.crate_icon = 1;
	}
	{
		string warboat_icon = getTeamIcon("warboat", "VehicleIcons.png", team_num, Vec2f(32, 32), 2);
		ShopItem@ s = addShopItem(this, "War Boat", warboat_icon, "warboat", "$warboat$\n\n\n" + descriptions[37], false, true);
		AddRequirement(s.requirements, "coin", "", "Coins", 200);
		AddRequirement(s.requirements, "blob", "mat_gold", "Gold", 50);
		s.crate_icon = 2;
	}
	{
		ShopItem@ s = addShopItem(this, "Ballista Ammo", "$mat_bolts$", "mat_bolts", "$mat_bolts$\n\n\n" + descriptions[15], false, false);
		s.crate_icon = 5;
		AddRequirement(s.requirements, "coin", "", "Coins", cost_ballista_ammo);
	}
	{
		ShopItem@ s = addShopItem(this, "Ballista Shells", "$mat_bomb_bolts$", "mat_bomb_bolts", "$mat_bomb_bolts$\n\n\n" + Descriptions::ballista_bomb_ammo, false, false);
		s.crate_icon = 5;
		s.customButton = true;
		s.buttonwidth = 2;
		s.buttonheight = 1;
		AddRequirement(s.requirements, "coin", "", "Coins", cost_ballista_bomb_ammo);
	}
}

void GetButtonsFor(CBlob@ this, CBlob@ caller)
{
	u8 kek = caller.getTeamNum();	
	if (kek == 0)
	{
		this.set_bool("shop available", this.isOverlapping(caller));
	}
}

void onCommand(CBlob@ this, u8 cmd, CBitStream @params)
{
	if (cmd == this.getCommandID("shop made item"))
	{
		this.getSprite().PlaySound("/ChaChing.ogg");
		bool isServer = (getNet().isServer());
		u16 caller, item;
		if (!params.saferead_netid(caller) || !params.saferead_netid(item))
		{
			return;
		}
		string name = params.read_string();
		{
			if (name == "upgradebolts")
			{
				GiveFakeTech(getRules(), "bomb ammo", this.getTeamNum());
			}
		}
	}
}
