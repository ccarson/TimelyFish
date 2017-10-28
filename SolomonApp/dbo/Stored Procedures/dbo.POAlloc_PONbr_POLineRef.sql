 CREATE PROCEDURE POAlloc_PONbr_POLineRef
	@parm1 varchar ( 10),
	@parm2 varchar ( 10),
	@parm3 varchar ( 05)

AS
	SELECT *
	FROM POAlloc
	WHERE	CpnyID = @Parm1
	        AND PONbr = @parm2
        	AND POLineRef = @parm3
        	ORDER BY PONbr, POLineRef

-- Copyright 1998 by Advanced Distribution Group, Ltd. All rights reserved.


