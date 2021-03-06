
shared class Loot
{
    string name; 
    int rarity;
    int quantity;
};

f32 openHealth = 1.0f; //health of wooden chest when it will be opened     0.5f = 1 heart
int itemVelocity = 2.0f; //how far item will fly from from the chest on open
bool button = true; //open chest by button (hold E) or by hit

void InitLoot( CBlob@ this )
{
    /*if you want a random quantity then write "addLoot(this, item name, item rarity, XORRandom(item quantity));"
      if you want to add coins then write "addLoot(this, "coins", item rarity, item quantity);" 
      if you want to make item drop always set "item quantity" as "0"
    */

    //addLoot(this, item name, item rarity, item quantity)
    addLoot(this, "scrossbow", 1, 1);
	addLoot(this, "carnage", 2, 1);
	addLoot(this, "spyro", 2, 1);
	addLoot(this, "sreinforce", 3, 1);
	// addLoot(this, "chainsaw", 3, 1);
	// addLoot(this, "sskeleton", 4, 1);
	//addLoot(this, "scrollundead", 4, 1);
    addLoot(this, "mat_stone", 0, XORRandom(309) + 101); //chest will drop coins with quantity 1 - 60
    addLoot(this, "coins", 0, XORRandom(39) + 1); //chest will drop coins with quantity 1 - 40
}



void addLoot(CBlob@ this, string NAME, int RARITY, int QUANTITY)
{    
    if (!this.exists("loot"))
    {
        Loot[] loot;
        this.set( "loot", loot );
    }

    Loot l;
    l.name = NAME;
    l.rarity = RARITY;
    l.quantity = QUANTITY;

    this.push("loot", l);
}