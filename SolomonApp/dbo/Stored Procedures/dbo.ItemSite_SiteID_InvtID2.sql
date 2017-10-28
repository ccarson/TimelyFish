 CREATE PROCEDURE ItemSite_SiteID_InvtID2
	@parm1 varchar( 10 ),
	@parm2 varchar( 30 )
AS
	SELECT *
	FROM ItemSite
	WHERE SiteID LIKE @parm1
	   AND InvtID LIKE @parm2
	ORDER BY SiteID,
	   InvtID

-- Copyright 1998, 1999, 2000, 2001 by Solomon Software, Inc. All rights reserved.


