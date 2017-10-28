 CREATE PROCEDURE SOHeader_OrdNbr_CpnyID
	@parm1 varchar( 15 ),
	@parm2 varchar( 10 )
AS
	SELECT *
	FROM SOHeader
	WHERE OrdNbr LIKE @parm1
	   AND CpnyID LIKE @parm2
	ORDER BY OrdNbr,
	   CpnyID

-- Copyright 1998, 1999, 2000, 2001 by Solomon Software, Inc. All rights reserved.


