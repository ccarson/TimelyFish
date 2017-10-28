 create proc ADG_ItemSite_LeadTime
	@invtid		varchar(30),
	@siteid		varchar(10)
as
	select	LeadTime
	from	ItemSite WITH (NOLOCK)
	where	InvtID = @invtid
	  and	SiteID = @siteid

-- Copyright 1998 by Advanced Distribution Group, Ltd. All rights reserved.


