 CREATE PROCEDURE SOPrintControl_all
	@parm1 varchar( 10 ),
	@parm2 varchar( 4 ),
	@parm3 varchar( 4 ),
	@parm4 varchar( 10 )
AS
	SELECT *
	FROM SOPrintControl
	WHERE CpnyID LIKE @parm1
	   AND SOTypeID LIKE @parm2
	   AND Seq LIKE @parm3
	   AND SiteID LIKE @parm4
	ORDER BY CpnyID,
	   SOTypeID,
	   Seq,
	   SiteID

-- Copyright 1998 by Advanced Distribution Group, Ltd. All rights reserved.



GO
GRANT CONTROL
    ON OBJECT::[dbo].[SOPrintControl_all] TO [MSDSL]
    AS [dbo];

