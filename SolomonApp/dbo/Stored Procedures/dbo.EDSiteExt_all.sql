 CREATE PROCEDURE EDSiteExt_all
	@parm1 varchar( 10 )
AS
	SELECT *
	FROM EDSiteExt
	WHERE SiteID LIKE @parm1
	ORDER BY SiteID

-- Copyright 1998 by Advanced Distribution Group, Ltd. All rights reserved.



GO
GRANT CONTROL
    ON OBJECT::[dbo].[EDSiteExt_all] TO [MSDSL]
    AS [dbo];

