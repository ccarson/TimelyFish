 CREATE PROCEDURE IN10990_ItemSite_SiteID_InvtID
	@parm1 varchar( 10 ),
	@parm2 varchar( 30 )
AS
	SELECT *
	FROM IN10990_ItemSite
	WHERE SiteID LIKE @parm1
	   AND InvtID LIKE @parm2
	ORDER BY SiteID,
	   InvtID

-- Copyright 1998 by Advanced Distribution Group, Ltd. All rights reserved.


