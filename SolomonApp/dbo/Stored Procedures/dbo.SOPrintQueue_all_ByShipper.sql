 CREATE PROCEDURE SOPrintQueue_all_ByShipper
	@parm1min smallint, @parm1max smallint,
	@parm2 varchar( 10 ),
	@parm3 varchar( 15 ),
	@parm4 varchar( 15 )
AS
	SELECT *
	FROM SOPrintQueue
	WHERE RI_ID BETWEEN @parm1min AND @parm1max
	   AND CpnyID LIKE @parm2
	   AND OrdNbr LIKE @parm3
	   AND ShipperID LIKE @parm4
	ORDER BY RI_ID,
	   CpnyID,
	   ShipperID,
	   OrdNbr


-- Copyright 1998 by Advanced Distribution Group, Ltd. All rights reserved.



GO
GRANT CONTROL
    ON OBJECT::[dbo].[SOPrintQueue_all_ByShipper] TO [MSDSL]
    AS [dbo];

