 create proc ADG_SOPlan_AllInvtSite
	@invtid 	varchar(30),
	@siteid 	varchar(10)
as
	select *
	from	soplan
	where	InvtID = @invtid
	  and	SiteID = @siteid

-- Copyright 1998 by Advanced Distribution Group, Ltd. All rights reserved.


