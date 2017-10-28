 CREATE PROCEDURE IRDemHeader_all
	@parm1 varchar( 10 )
AS
	SELECT *
	FROM IRDemHeader
	WHERE DemandID LIKE @parm1
	ORDER BY DemandID

-- Copyright 1998, 1999, 2000, 2001 by Solomon Software, Inc. All rights reserved.



GO
GRANT CONTROL
    ON OBJECT::[dbo].[IRDemHeader_all] TO [MSDSL]
    AS [dbo];

