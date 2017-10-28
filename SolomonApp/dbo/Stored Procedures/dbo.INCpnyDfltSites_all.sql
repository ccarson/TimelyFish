 CREATE PROCEDURE INCpnyDfltSites_all
	@parm1 varchar( 10 )
AS
	SELECT *
	FROM INCpnyDfltSites (NOLOCK)
	WHERE CpnyID LIKE @parm1
	ORDER BY CpnyID

-- Copyright 1998, 1999, 2000, 2001 by Solomon Software, Inc. All rights reserved.


