 CREATE PROCEDURE Site_CpnyID_SiteId
	@parm1 varchar( 10 ),
	@parm2 varchar( 10 )
AS
	SELECT *
	FROM Site
	WHERE CpnyID LIKE @parm1
	   AND SiteId LIKE @parm2
	ORDER BY CpnyID,
	   SiteId

-- Copyright 1998 by Advanced Distribution Group, Ltd. All rights reserved.



GO
GRANT CONTROL
    ON OBJECT::[dbo].[Site_CpnyID_SiteId] TO [MSDSL]
    AS [dbo];

