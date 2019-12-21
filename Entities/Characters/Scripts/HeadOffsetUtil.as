#include "PixelOffsets.as";

void setupHeadOffsets(CSprite@ this, string shortname, string filename)
{
    Vec2f framesize = _sprite_to_framesize(this);
    PixelOffsetsCache cache();
    array<SColor> col = {
        SColor(0xffff00ff),
        SColor(0xffffff00)
    };
    createAndLoadPixelOffsets(shortname, filename, framesize, col, @cache);
    CBlob@ blob = this.getBlob();
    blob.set("head_offsets", cache);
}