/* Targeting */

CBlob@ GetClosestVisibleTarget( CBrain@ this, CBlob@ blob, f32 radius )
{
	CBlob@[] nearBlobs;
	blob.getMap().getBlobsInRadius( blob.getPosition(), radius, @nearBlobs );

	CBlob@ best_candidate;
	f32 closest_dist = 999999.9f;
	bool visible = false;
	for(int step = 0; step < nearBlobs.length; ++step)
	{
		CBlob@ candidate = nearBlobs[step];
		if    (candidate is null) break;

		if (!candidate.hasTag("dead"))
		{
			if (isTarget(blob, candidate))
			{
				bool seeThroughWalls = false;
				bool is_visible = isTargetVisible(blob, candidate);

				f32 dist = getDistanceBetween(candidate.getPosition(), blob.getPosition());
				if (dist < closest_dist && visible ? is_visible : (seeThroughWalls ? true : is_visible))
				{
					// if(!is_visible && XORRandom(30) > 3)
					    // continue;

					@best_candidate = candidate;
					closest_dist = dist;
					visible = is_visible;
					break;
				}
			}
		}
	}
	return best_candidate;
}

CBlob@ GetBestTarget( CBrain@ this, CBlob@ blob, f32 radius )
{
	// if (blob.hasTag("is_stuck"))
		// return GetClosestVisibleTarget(this, blob, radius);

	CBlob@[] nearBlobs;
	blob.getMap().getBlobsInRadius( blob.getPosition(), radius, @nearBlobs );

	CBlob@ best_candidate;
	f32 highest_priority = 0.0f;
	f32 closest_dist = 999999.9f;
	bool visible = false;
	for(int step = 0; step < nearBlobs.length; ++step)
	{
		CBlob@ candidate = nearBlobs[step];
		if    (candidate is null) break;

	    f32 priority = getTargetPriority(blob, candidate);
		if (priority >= highest_priority && !candidate.hasTag("dead"))
		{
			if (isTarget(blob, candidate))
			{
				bool seeThroughWalls = seeTargetThroughWalls(blob, candidate);
				bool is_visible = isTargetVisible(blob, candidate);

				f32 dist = getDistanceBetween(candidate.getPosition(), blob.getPosition());
				if (dist < closest_dist && visible ? is_visible : (seeThroughWalls ? true : is_visible))
				{
					if(!is_visible && XORRandom(30) > 3)
					    continue;

					@best_candidate = candidate;
					highest_priority = priority;
					closest_dist = dist;
					visible = is_visible;
					break;
				}
			}
		}
	}
	return best_candidate;
}