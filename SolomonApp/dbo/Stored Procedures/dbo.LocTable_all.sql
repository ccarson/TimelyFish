 CREATE PROCEDURE LocTable_all
	@parm1 varchar( 10 ),
	@parm2 varchar( 10 )
AS
	SELECT *
	FROM LocTable
	WHERE SiteID LIKE @parm1
	   AND WhseLoc LIKE @parm2
	ORDER BY SiteID,
	   WhseLoc

-- Copyright 1998 by Advanced Distribution Group, Ltd. All rights reserved.


