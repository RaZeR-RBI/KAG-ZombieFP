#define SERVER_ONLY

void onAttach(CBlob@ this, CBlob@ attached, AttachmentPoint@ attachedPoint)
{
	if (this.getName() == "crate" && !this.exists("packed"))
	{
		return;
	}
	attached.AddScript("DisableDrown.as");
}

void onDetach(CBlob@ this, CBlob@ detached, AttachmentPoint@ attachedPoint)
{
	detached.RemoveScript("DisableDrown.as");
}