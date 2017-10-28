 CREATE PROCEDURE ItemSite_Neg
	@SiteID Varchar(10)
as
	UPDATE	ItemSite
	SET	ItemSite.Selected = 1, ItemSite.CountStatus = 'P'
	FROM	ItemSite, Location
	WHERE	ItemSite.SiteID = @SiteID
	  AND	ItemSite.CountStatus = 'A'
	  AND	Location.QtyOnHand < 0
	  AND	ItemSite.InvtID = Location.InvtID
	  AND	ItemSite.SiteID = Location.SiteID

-- Copyright 1998,1999 by Solomon Software, Inc. All rights reserved.


