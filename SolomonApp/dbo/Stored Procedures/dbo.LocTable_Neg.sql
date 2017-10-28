 CREATE PROCEDURE LocTable_Neg
	@SiteID VarChar(10)
AS
	UPDATE	LocTable
	SET	LocTable.Selected = 1, LocTable.CountStatus = 'P'
	FROM	LocTable, Location
	WHERE	LocTable.SiteID = @SiteID
	  AND	LocTable.CountStatus = 'A'
	  AND	Location.QtyOnHand < 0
	  AND	LocTable.WhseLoc = Location.WhseLoc
	  AND	LocTable.SiteID = Location.SiteID

-- Copyright 1998,1999 by Solomon Software, Inc. All rights reserved.


