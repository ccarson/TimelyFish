 CREATE PROCEDURE DMG_Location_WhseLoc_Count
	@SiteID 	varchar (10),
	@WhseLoc 	varchar (10)
AS
	SELECT	count(*)
	FROM 	Location
	WHERE	SiteID = @SiteID
	and 	WhseLoc = @WhseLoc

-- Copyright 1999 by Advanced Distribution Group, Ltd. All rights reserved.



GO
GRANT CONTROL
    ON OBJECT::[dbo].[DMG_Location_WhseLoc_Count] TO [MSDSL]
    AS [dbo];

