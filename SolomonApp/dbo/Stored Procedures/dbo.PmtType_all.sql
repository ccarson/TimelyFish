 CREATE PROCEDURE PmtType_all
	@parm1 varchar( 10 ),
	@parm2 varchar( 4 )
AS
	SELECT *
	FROM PmtType
	WHERE CpnyID LIKE @parm1
	   AND PmtTypeID LIKE @parm2
	ORDER BY CpnyID,
	   PmtTypeID

-- Copyright 1998 by Advanced Distribution Group, Ltd. All rights reserved.



GO
GRANT CONTROL
    ON OBJECT::[dbo].[PmtType_all] TO [MSDSL]
    AS [dbo];

