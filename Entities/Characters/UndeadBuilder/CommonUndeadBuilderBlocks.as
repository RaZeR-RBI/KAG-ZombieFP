// CommonBuilderBlocks.as

//////////////////////////////////////
// Builder menu documentation
//////////////////////////////////////

// To add a new page;

// 1) initialize a new BuildBlock array, 
// example:
// BuildBlock[] my_page;
// blocks.push_back(my_page);

// 2) 
// Add a new string to PAGE_NAME in 
// BuilderInventory.as
// this will be what you see in the caption
// box below the menu

// 3)
// Extend BuilderPageIcons.png with your new
// page icon, do note, frame index is the same
// as array index

// To add new blocks to a page, push_back
// in the desired order to the desired page
// example:
// BuildBlock b(0, "name", "icon", "description");
// blocks[3].push_back(b);

#include "BuildBlock.as";
#include "Requirements.as";

const string blocks_property = "blocks";
const string inventory_offset = "inventory offset";

void addCommonBuilderBlocks(BuildBlock[][]@ blocks)
{
	CRules@ rules = getRules();
	const bool CTF = rules.gamemode_name == "CTF";
	const bool TTH = rules.gamemode_name == "TTH";
	const bool SBX = rules.gamemode_name == "Sandbox";

	BuildBlock[] page_0;
	blocks.push_back(page_0);
	{
		AddIconToken("$stone_moss_block$", "Sprites/World.png", Vec2f(8, 8), CMap::tile_castle_moss);
		BuildBlock b( CMap::tile_castle_moss, "stone_moss_block", "$stone_moss_block$", "Mossy Stone Block" );
		AddRequirement( b.reqs, "blob", "mat_stone", "Stone", 10 );
		blocks[0].push_back( b );
	}
	{
		AddIconToken("$back_stone_moss_block$", "Sprites/World.png", Vec2f(8, 8), CMap::tile_castle_back_moss);
		BuildBlock b( CMap::tile_castle_back_moss, "back_stone_moss_block", "$back_stone_moss_block$", "Mossy Back Stone Wall" );
		AddRequirement( b.reqs, "blob", "mat_stone", "Stone", 2 );
		blocks[0].push_back( b );
	}
	{
		BuildBlock b(CMap::tile_wood, "wood_block", "$wood_block$", "Wood Block\nCheap block\nwatch out for fire!");
		AddRequirement(b.reqs, "blob", "mat_wood", "Wood", 5);
		blocks[0].push_back(b);
	}
	{
		BuildBlock b(CMap::tile_wood_back, "back_wood_block", "$back_wood_block$", "Back Wood Wall\nCheap extra support");
		AddRequirement(b.reqs, "blob", "mat_wood", "Wood", 1);
		blocks[0].push_back(b);
	}	
	{
		BuildBlock b(0, "undead_door", "$stone_door$", "Stone Door\nPlace next to walls");
		AddRequirement(b.reqs, "blob", "mat_stone", "Stone", 40);
		blocks[0].push_back(b);
	}	
	{
		BuildBlock b(0, "ladder", "$ladder$", "Ladder\nAnyone can climb it");
		AddRequirement(b.reqs, "blob", "mat_wood", "Wood", 10);
		blocks[0].push_back(b);
	}
	{
		BuildBlock b(0, "trap_block", "$trap_block$", "Trap Block\nOnly enemies can pass. Also good for wheeled vehicles.");
		AddRequirement(b.reqs, "blob", "mat_stone", "Stone", 20);
		blocks[0].push_back(b);
	}	
	{
		BuildBlock b(0, "team_bridge", "$team_bridge$", "Trap Bridge\nEnemies fall through this.");
		AddRequirement(b.reqs, "blob", "mat_wood", "Wood", 15);
		blocks[0].push_back(b);
	}
	{
		BuildBlock b(0, "spikes", "$spikes$", "Spikes\nPlace on Stone Block\nfor Retracting Trap");
		AddRequirement(b.reqs, "blob", "mat_stone", "Stone", 30);
		AddRequirement(b.reqs, "blob", "mat_gold", "Gold", 10);
		blocks[0].push_back(b);
	}	
	{
		BuildBlock b(0, "woodenspikes", "$woodenspikes$", "Wooden Spikes\nPlace on Wood Block\nfor Retracting Trap");
		AddRequirement(b.reqs, "blob", "mat_wood", "Wood", 15);
		AddRequirement(b.reqs, "blob", "mat_gold", "Gold", 5);
		blocks[0].push_back(b);
	}
	{
		BuildBlock b(0, "torch", "$torch$", "Torch\nLight the caves.");
		AddRequirement(b.reqs, "blob", "mat_wood", "Wood", 10);
		blocks[0].push_back(b);
	}
	{
		BuildBlock b(0, "wooden_platform", "$wooden_platform$", "Wooden Platform\nOne way platform");
		AddRequirement(b.reqs, "blob", "mat_wood", "Wood", 15);
		blocks[0].push_back(b);
	}	


/*	if(CTF)
	{
		BuildBlock b(0, "building", "$building$", "Workshop\nStand in an open space\nand tap this button.");
		AddRequirement(b.reqs, "blob", "mat_wood", "Wood", 150);
		b.buildOnGround = true;
		b.size.Set(40, 24);
		blocks[0].insertAt(9, b);
	}
	else if(TTH)
	{
		{
			BuildBlock b(0, "factory", "$building$", "Workshop");
			AddRequirement(b.reqs, "blob", "mat_wood", "Wood", 150);
			b.buildOnGround = true;
			b.size.Set(40, 24);
			blocks[0].insertAt(9, b);
		}
		{
			BuildBlock b(0, "workbench", "$workbench$", "Workbench");
			AddRequirement(b.reqs, "blob", "mat_wood", "Wood", 120);
			b.buildOnGround = true;
			b.size.Set(32, 16);
			blocks[0].push_back(b);
		}
	}
	else if(true)*/
	{
		{
			BuildBlock b(0, "undeadbuilding", "$building$", "Workshop\nStand in an open space\nand tap this button.");
			AddRequirement(b.reqs, "blob", "mat_stone", "Stone", 50);
			b.buildOnGround = true;
			b.size.Set(40, 24);
			blocks[0].push_back(b);
		}
		{
			BuildBlock b(0, "ZombiePortal", "$ZP$", "Zombie Portal\nStand in an open space\nand tap this button.");
			AddRequirement(b.reqs, "blob", "mat_stone", "Stone", 1000);
			AddRequirement(b.reqs, "blob", "mat_gold", "Gold", 500);
			AddRequirement(b.reqs, "blob", "mat_wood", "Wood", 250);
			b.buildOnGround = true;
			b.size.Set(64, 64);
			blocks[0].push_back(b);
		}		

		/*BuildBlock[] page_1;
		blocks.push_back(page_1);
		{
			BuildBlock b(0, "wire", "$wire$", "Wire");
			AddRequirement(b.reqs, "blob", "mat_wood", "Wood", 15);
			AddRequirement(b.reqs, "blob", "mat_stone", "Stone", 5);
			AddRequirement(b.reqs, "blob", "mat_gold", "Gold", 1);
			blocks[1].push_back(b);
		}
		{
			BuildBlock b(0, "tee", "$tee$", "Tee");
			AddRequirement(b.reqs, "blob", "mat_wood", "Wood", 15);
			AddRequirement(b.reqs, "blob", "mat_stone", "Stone", 5);
			AddRequirement(b.reqs, "blob", "mat_gold", "Gold", 1);
			blocks[1].push_back(b);
		}
		{
			BuildBlock b(0, "elbow", "$elbow$", "Elbow");
			AddRequirement(b.reqs, "blob", "mat_wood", "Wood", 15);
			AddRequirement(b.reqs, "blob", "mat_stone", "Stone", 5);
			AddRequirement(b.reqs, "blob", "mat_gold", "Gold", 1);
			blocks[1].push_back(b);
		}		
		{
			BuildBlock b(0, "junction", "$junction$", "Junction");
			AddRequirement(b.reqs, "blob", "mat_stone", "Stone", 30);
			AddRequirement(b.reqs, "blob", "mat_gold", "Gold", 5);
			blocks[1].push_back(b);
		}
		{
			BuildBlock b(0, "diode", "$diode$", "Diode");
			AddRequirement(b.reqs, "blob", "mat_stone", "Stone", 25);
			AddRequirement(b.reqs, "blob", "mat_gold", "Gold", 5);
			blocks[1].push_back(b);
		}
		{
			BuildBlock b(0, "resistor", "$resistor$", "Resistor");
			AddRequirement(b.reqs, "blob", "mat_stone", "Stone", 25);
			AddRequirement(b.reqs, "blob", "mat_gold", "Gold", 5);
			blocks[1].push_back(b);
		}
		{
			BuildBlock b(0, "inverter", "$inverter$", "Inverter");
			AddRequirement(b.reqs, "blob", "mat_stone", "Stone", 25);
			AddRequirement(b.reqs, "blob", "mat_gold", "Gold", 5);
			blocks[1].push_back(b);
		}
		{
			BuildBlock b(0, "oscillator", "$oscillator$", "Oscillator");
			AddRequirement(b.reqs, "blob", "mat_stone", "Stone", 50);
			AddRequirement(b.reqs, "blob", "mat_gold", "Gold", 10);
			blocks[1].push_back(b);
		}
		{
			BuildBlock b(0, "transistor", "$transistor$", "Transistor");
			AddRequirement(b.reqs, "blob", "mat_wood", "Wood", 25);
			AddRequirement(b.reqs, "blob", "mat_stone", "Stone", 15);
			AddRequirement(b.reqs, "blob", "mat_gold", "Gold", 5);
			blocks[1].push_back(b);
		}
		{
			BuildBlock b(0, "toggle", "$toggle$", "Toggle");
			AddRequirement(b.reqs, "blob", "mat_stone", "Stone", 50);
			AddRequirement(b.reqs, "blob", "mat_gold", "Gold", 10);
			blocks[1].push_back(b);
		}
		{
			BuildBlock b(0, "randomizer", "$randomizer$", "Randomizer");
			AddRequirement(b.reqs, "blob", "mat_stone", "Stone", 50);
			AddRequirement(b.reqs, "blob", "mat_gold", "Gold", 10);
			blocks[1].push_back(b);
		}

		BuildBlock[] page_2;
		blocks.push_back(page_2);
		{
			BuildBlock b(0, "lever", "$lever$", "Lever");
			AddRequirement(b.reqs, "blob", "mat_wood", "Wood", 20);
			AddRequirement(b.reqs, "blob", "mat_stone", "Stone", 50);
			AddRequirement(b.reqs, "blob", "mat_gold", "Gold", 2);
			blocks[2].push_back(b);
		}
		{
			BuildBlock b(0, "push_button", "$push_button$", "Button");
			AddRequirement(b.reqs, "blob", "mat_wood", "Wood", 15);
			AddRequirement(b.reqs, "blob", "mat_stone", "Stone", 40);
			AddRequirement(b.reqs, "blob", "mat_gold", "Gold", 1);
			blocks[2].push_back(b);
		}
		{
			BuildBlock b(0, "coin_slot", "$coin_slot$", "Coin Slot");
			AddRequirement(b.reqs, "blob", "mat_wood", "Wood", 15);
			AddRequirement(b.reqs, "blob", "mat_stone", "Stone", 40);
			AddRequirement(b.reqs, "blob", "mat_gold", "Gold", 1);
			blocks[2].push_back(b);
		}
		{
			BuildBlock b(0, "pressure_plate", "$pressure_plate$", "Pressure Plate");
			AddRequirement(b.reqs, "blob", "mat_wood", "Wood", 15);
			AddRequirement(b.reqs, "blob", "mat_stone", "Stone", 40);
			AddRequirement(b.reqs, "blob", "mat_gold", "Gold", 1);
			blocks[2].push_back(b);
		}
		{
			BuildBlock b(0, "sensor", "$sensor$", "Motion Sensor");
			AddRequirement(b.reqs, "blob", "mat_wood", "Wood", 20);
			AddRequirement(b.reqs, "blob", "mat_stone", "Stone", 50);
			AddRequirement(b.reqs, "blob", "mat_gold", "Gold", 2);
			blocks[2].push_back(b);
		}

		BuildBlock[] page_3;
		blocks.push_back(page_3);
		{
			BuildBlock b(0, "lamp", "$lamp$", "Lamp");
			AddRequirement(b.reqs, "blob", "mat_wood", "Wood", 15);
			AddRequirement(b.reqs, "blob", "mat_stone", "Stone", 20);
			AddRequirement(b.reqs, "blob", "mat_gold", "Gold", 1);
			blocks[3].push_back(b);
		}
		{
			BuildBlock b(0, "emitter", "$emitter$", "Emitter");
			AddRequirement(b.reqs, "blob", "mat_stone", "Stone", 50);
			AddRequirement(b.reqs, "blob", "mat_gold", "Gold", 10);
			blocks[3].push_back(b);
		}
		{
			BuildBlock b(0, "receiver", "$receiver$", "Receiver");
			AddRequirement(b.reqs, "blob", "mat_stone", "Stone", 50);
			AddRequirement(b.reqs, "blob", "mat_gold", "Gold", 10);
			blocks[3].push_back(b);
		}
		{
			BuildBlock b(0, "magazine", "$magazine$", "Magazine");
			AddRequirement(b.reqs, "blob", "mat_stone", "Wood", 50);
			AddRequirement(b.reqs, "blob", "mat_gold", "Gold", 10);
			blocks[3].push_back(b);
		}
		{
			BuildBlock b(0, "bolter", "$bolter$", "Bolter");
			AddRequirement(b.reqs, "blob", "mat_wood", "Wood", 20);
			AddRequirement(b.reqs, "blob", "mat_stone", "Stone", 40);
			AddRequirement(b.reqs, "blob", "mat_gold", "Gold", 5);
			blocks[3].push_back(b);
		}
		{
			BuildBlock b(0, "dispenser", "$dispenser$", "Dispenser");
			AddRequirement(b.reqs, "blob", "mat_wood", "Wood", 20);
			AddRequirement(b.reqs, "blob", "mat_stone", "Stone", 40);
			AddRequirement(b.reqs, "blob", "mat_gold", "Gold", 5);
			blocks[3].push_back(b);
		}
		{
			BuildBlock b(0, "obstructor", "$obstructor$", "Obstructor");
			AddRequirement(b.reqs, "blob", "mat_stone", "Stone", 50);
			AddRequirement(b.reqs, "blob", "mat_gold", "Gold", 20);
			blocks[3].push_back(b);
		}
		{
			BuildBlock b(0, "spiker", "$spiker$", "Spiker");
			AddRequirement(b.reqs, "blob", "mat_wood", "Wood", 30);
			AddRequirement(b.reqs, "blob", "mat_stone", "Stone", 50);
			AddRequirement(b.reqs, "blob", "mat_gold", "Gold", 10);
			blocks[3].push_back(b);
		}
		{
			BuildBlock b(0, "flamer", "$flamer$", "Flamer");
			AddRequirement(b.reqs, "blob", "mat_wood", "Wood", 20);
			AddRequirement(b.reqs, "blob", "mat_stone", "Stone", 50);
			AddRequirement(b.reqs, "blob", "mat_gold", "Gold", 5);
			blocks[3].push_back(b);
		}
		{
			BuildBlock b(0, "booster", "$booster$", "Bouncer");
			AddRequirement(b.reqs, "blob", "mat_wood", "Wood", 10);
			AddRequirement(b.reqs, "blob", "mat_stone", "Stone", 25);
			AddRequirement(b.reqs, "blob", "mat_gold", "Gold", 5);
			blocks[3].push_back(b);
		}
		{
			BuildBlock b(0, "conveyor", "$conveyor$", "Conveyor");
			AddRequirement(b.reqs, "blob", "mat_wood", "Wood", 10);
			AddRequirement(b.reqs, "blob", "mat_stone", "Stone", 15);
			AddRequirement(b.reqs, "blob", "mat_gold", "Gold", 5);
			blocks[3].push_back(b);
		}
		{
			BuildBlock b(0, "conveyortriangle", "$conveyortriangle$", "Conveyor Triangle");
			AddRequirement(b.reqs, "blob", "mat_wood", "Wood", 5);
			AddRequirement(b.reqs, "blob", "mat_stone", "Stone", 10);
			AddRequirement(b.reqs, "blob", "mat_gold", "Gold", 2);
			blocks[3].push_back(b);
		}*/		
	}
}