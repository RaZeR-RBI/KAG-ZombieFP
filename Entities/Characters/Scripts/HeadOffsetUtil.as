#include "PixelOffsets.as";

void setupHeadOffsets(CSprite@ this, string shortname, string filename)
{
    PixelOffsetsCache@ cache = null;
    if (!getRules().exists("head_offsets_" + shortname)) {
        loadHeadOffsets(this, shortname, filename);
    }
    CBlob@ blob = this.getBlob();
    PixelOffsetsCache@ c;
    getRules().get("head_offsets_" + shortname, @c);
    blob.set("head_offsets", c);
}

void loadHeadOffsets(CSprite@ this, string shortname, string filename)
{
    Vec2f framesize = _sprite_to_framesize(this);
    PixelOffsetsCache cache();
    array<SColor> col = {
        SColor(0xffff00ff),
        SColor(0xffffff00)
    };
    createAndLoadPixelOffsets(shortname, filename, framesize, col, @cache);
    getRules().set("head_offsets_" + shortname, cache);
}