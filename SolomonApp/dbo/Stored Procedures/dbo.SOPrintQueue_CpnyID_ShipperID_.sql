 CREATE PROCEDURE SOPrintQueue_CpnyID_ShipperID_
	@parm1 varchar( 10 ),
	@parm2 varchar( 15 ),
	@parm3 varchar( 10 )
AS
	SELECT *
	FROM SOPrintQueue
	WHERE CpnyID LIKE @parm1
	   AND ShipperID LIKE @parm2
	   AND S4Future11 LIKE @parm3
	ORDER BY CpnyID,
	   ShipperID,
	   S4Future11

-- Copyright 1998 by Advanced Distribution Group, Ltd. All rights reserved.



GO
GRANT CONTROL
    ON OBJECT::[dbo].[SOPrintQueue_CpnyID_ShipperID_] TO [MSDSL]
    AS [dbo];

