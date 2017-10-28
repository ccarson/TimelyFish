 CREATE PROCEDURE POAlloc_CpnyId_PONbr_Type
	@parm1 varchar ( 10),
	@parm2 varchar ( 10),
	@parm3 varchar ( 1)
As
	SELECT *
	FROM POAlloc
	WHERE CpnyID = @parm1
       		AND PONbr = @parm2
        	AND DocType = @parm3

-- Copyright 1998 by Advanced Distribution Group, Ltd. All rights reserved.



GO
GRANT CONTROL
    ON OBJECT::[dbo].[POAlloc_CpnyId_PONbr_Type] TO [MSDSL]
    AS [dbo];

