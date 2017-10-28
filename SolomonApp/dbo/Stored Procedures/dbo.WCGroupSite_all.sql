 CREATE PROCEDURE WCGroupSite_all
	@parm1 varchar( 15 ),
	@parm2 varchar( 10 )
AS
	SELECT *
	FROM WCGroupSite
	WHERE UserGroupID LIKE @parm1
	   AND SiteID LIKE @parm2
	ORDER BY UserGroupID,
	   SiteID

-- Copyright 1998 by Advanced Distribution Group, Ltd. All rights reserved.



GO
GRANT CONTROL
    ON OBJECT::[dbo].[WCGroupSite_all] TO [MSDSL]
    AS [dbo];

