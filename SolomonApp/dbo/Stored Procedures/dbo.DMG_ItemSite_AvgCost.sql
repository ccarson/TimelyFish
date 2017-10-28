 create proc DMG_ItemSite_AvgCost

	@InvtID varchar(30),
	@SiteID varchar(10)
as
	select	AvgCost
	from	ItemSite
	where	InvtID = @InvtID
	and	SiteID = @SiteID

-- Copyright 1999 by Advanced Distribution Group, Ltd. All rights reserved.



GO
GRANT CONTROL
    ON OBJECT::[dbo].[DMG_ItemSite_AvgCost] TO [MSDSL]
    AS [dbo];

