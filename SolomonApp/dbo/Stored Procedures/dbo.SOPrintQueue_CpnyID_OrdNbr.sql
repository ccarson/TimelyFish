 CREATE PROCEDURE SOPrintQueue_CpnyID_OrdNbr
	@parm1 varchar( 10 ),
	@parm2 varchar( 15 )
AS
	SELECT *
	FROM SOPrintQueue
	WHERE CpnyID LIKE @parm1
	   AND OrdNbr LIKE @parm2
	ORDER BY CpnyID,
	   OrdNbr

-- Copyright 1998 by Advanced Distribution Group, Ltd. All rights reserved.



GO
GRANT CONTROL
    ON OBJECT::[dbo].[SOPrintQueue_CpnyID_OrdNbr] TO [MSDSL]
    AS [dbo];

