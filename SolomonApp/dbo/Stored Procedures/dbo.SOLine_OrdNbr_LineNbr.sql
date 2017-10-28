 CREATE PROCEDURE SOLine_OrdNbr_LineNbr
	@parm1 varchar( 10 ),
	@parm2 varchar( 15 ),
	@parm3 smallint,
	@parm4 smallint
AS
	SELECT *
	FROM SOLine
	WHERE CpnyID = @parm1
	   AND OrdNbr LIKE @parm2
	   AND LineNbr between @parm3 and @parm4
	ORDER BY CpnyID,
	   OrdNbr,
	   LineNbr

-- Copyright 1998, 1999, 2000, 2001 by Solomon Software, Inc. All rights reserved.



GO
GRANT CONTROL
    ON OBJECT::[dbo].[SOLine_OrdNbr_LineNbr] TO [MSDSL]
    AS [dbo];

