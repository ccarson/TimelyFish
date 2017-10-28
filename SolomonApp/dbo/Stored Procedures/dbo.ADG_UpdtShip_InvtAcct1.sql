 create proc ADG_UpdtShip_InvtAcct1
	@InvtID		varchar(30),
	@SiteID		varchar(10)
as
	select	InvtAcct,
		InvtSub
	from	ItemSite
	where	InvtID = @InvtID
	  and	SiteID = @SiteID

-- Copyright 1998 by Advanced Distribution Group, Ltd. All rights reserved.


