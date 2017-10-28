 CREATE PROCEDURE DMG_LotSerMst_WhseLoc_Count
	@SiteID 	varchar (10),
	@WhseLoc 	varchar (10)
AS
	SELECT	count(*)
	FROM 	LotSerMst
	WHERE	SiteID = @SiteID
	and 	WhseLoc = @WhseLoc

-- Copyright 1999 by Advanced Distribution Group, Ltd. All rights reserved.


