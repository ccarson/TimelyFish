 CREATE PROCEDURE POAlloc_CpnyID_PoNbr
	@parm1 varchar( 10 ),
	@parm2 varchar( 10 ),
	@parm3 varchar( 5 ),
	@parm4 varchar( 5 )
AS
	SELECT *
	FROM POAlloc
	WHERE CpnyID = @parm1
	   AND PONbr = @parm2
	   AND POLineRef LIKE @parm3
	   AND AllocRef LIKE @parm4
	ORDER BY CpnyID,
	   PONbr,
	   POLineRef,
	   AllocRef

-- Copyright 1998 by Advanced Distribution Group, Ltd. All rights reserved.



GO
GRANT CONTROL
    ON OBJECT::[dbo].[POAlloc_CpnyID_PoNbr] TO [MSDSL]
    AS [dbo];

