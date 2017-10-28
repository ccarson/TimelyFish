 CREATE PROCEDURE SOHeader_BuildInvtID_BuildSite
	@parm1 varchar( 30 ),
	@parm2 varchar( 10 ),
	@parm3 varchar( 1 )
AS
	SELECT *
	FROM SOHeader
	WHERE BuildInvtID LIKE @parm1
	   AND BuildSiteID LIKE @parm2
	   AND Status LIKE @parm3
	ORDER BY BuildInvtID,
	   BuildSiteID,
	   Status

-- Copyright 1998, 1999, 2000, 2001 by Solomon Software, Inc. All rights reserved.



GO
GRANT CONTROL
    ON OBJECT::[dbo].[SOHeader_BuildInvtID_BuildSite] TO [MSDSL]
    AS [dbo];

