 CREATE PROCEDURE INProdClDfltSites_all
	@parm1 varchar( 6 ),
	@parm2 varchar( 10 )
AS
	SELECT *
	FROM INProdClDfltSites
	WHERE ClassID LIKE @parm1
	   AND CpnyID LIKE @parm2
	ORDER BY ClassID,
	   CpnyID

-- Copyright 1998, 1999, 2000, 2001 by Solomon Software, Inc. All rights reserved.



GO
GRANT CONTROL
    ON OBJECT::[dbo].[INProdClDfltSites_all] TO [MSDSL]
    AS [dbo];

