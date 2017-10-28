 CREATE PROCEDURE POTranAlloc_all
	@parm1 varchar( 10 ),
	@parm2 varchar( 5 ),
	@parm3 varchar( 10 ),
	@parm4 varchar( 15 ),
	@parm5 varchar( 5 ),
	@parm6 varchar( 5 )
AS
	SELECT *
	FROM POTranAlloc
	WHERE RcptNbr LIKE @parm1
	   AND POTranLineRef LIKE @parm2
	   AND CpnyID LIKE @parm3
	   AND SOOrdNbr LIKE @parm4
	   AND SOLineRef LIKE @parm5
	   AND SOSchedRef LIKE @parm6
	ORDER BY RcptNbr,
	   POTranLineRef,
	   CpnyID,
	   SOOrdNbr,
	   SOLineRef,
	   SOSchedRef

-- Copyright 1998 by Advanced Distribution Group, Ltd. All rights reserved.



GO
GRANT CONTROL
    ON OBJECT::[dbo].[POTranAlloc_all] TO [MSDSL]
    AS [dbo];

