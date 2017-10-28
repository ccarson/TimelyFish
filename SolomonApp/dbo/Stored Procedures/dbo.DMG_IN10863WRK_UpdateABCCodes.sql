 create proc DMG_IN10863WRK_UpdateABCCodes
	@ri_id		smallint
as
		Update 	ItemSite
	Set	ABCCode = IsNull((Select ABCCode
				from	IN10863_WRK
				Where	RI_ID = @ri_id
				  and	ItemSite.InvtID = IN10863_WRK.InvtID
				  and	ItemSite.SiteID = IN10863_WRK.SiteID), '')
	-- Copyright 1998 by Advanced Distribution Group, Ltd. All rights reserved.



GO
GRANT CONTROL
    ON OBJECT::[dbo].[DMG_IN10863WRK_UpdateABCCodes] TO [MSDSL]
    AS [dbo];

