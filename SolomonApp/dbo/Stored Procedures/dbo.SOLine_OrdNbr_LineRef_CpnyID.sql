 CREATE PROCEDURE SOLine_OrdNbr_LineRef_CpnyID
	@parm1 varchar( 15 ),
	@parm2 varchar( 5 ),
	@parm3 varchar( 10 )
AS
	SELECT *
	FROM SOLine
	WHERE OrdNbr LIKE @parm1
	   AND LineRef LIKE @parm2
	   AND CpnyID LIKE @parm3
	ORDER BY OrdNbr,
	   LineRef,
	   CpnyID

-- Copyright 1998, 1999, 2000, 2001 by Solomon Software, Inc. All rights reserved.



GO
GRANT CONTROL
    ON OBJECT::[dbo].[SOLine_OrdNbr_LineRef_CpnyID] TO [MSDSL]
    AS [dbo];

