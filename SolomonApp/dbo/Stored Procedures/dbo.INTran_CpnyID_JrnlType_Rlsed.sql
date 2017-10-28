 CREATE PROCEDURE INTran_CpnyID_JrnlType_Rlsed
	@parm1 varchar( 10 ),
	@parm2 varchar( 3 ),
	@parm3min smallint, @parm3max smallint
AS
	SELECT *
	FROM INTran
	WHERE CpnyID LIKE @parm1
	   AND JrnlType LIKE @parm2
	   AND Rlsed BETWEEN @parm3min AND @parm3max
	ORDER BY CpnyID,
	   JrnlType,
	   Rlsed

-- Copyright 1998, 1999, 2000, 2001 by Solomon Software, Inc. All rights reserved.



GO
GRANT CONTROL
    ON OBJECT::[dbo].[INTran_CpnyID_JrnlType_Rlsed] TO [MSDSL]
    AS [dbo];

