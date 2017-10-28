 CREATE PROCEDURE PIHeader_SiteID
	@parm1 varchar( 10 )
AS
	SELECT *
	FROM PIHeader
	WHERE SiteID LIKE @parm1
	ORDER BY SiteID

-- Copyright 1998 by Advanced Distribution Group, Ltd. All rights reserved.



GO
GRANT CONTROL
    ON OBJECT::[dbo].[PIHeader_SiteID] TO [MSDSL]
    AS [dbo];

