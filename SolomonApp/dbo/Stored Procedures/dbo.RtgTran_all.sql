 CREATE PROCEDURE RtgTran_all
	@parm1 varchar( 10 ),
	@parm2 varchar( 10 ),
	@parm3min smallint, @parm3max smallint
AS
	SELECT *
	FROM RtgTran
	WHERE CpnyID LIKE @parm1
	   AND RefNbr LIKE @parm2
	   AND LineNbr BETWEEN @parm3min AND @parm3max
	ORDER BY CpnyID,
	   RefNbr,
	   LineNbr

-- Copyright 1998 by Advanced Distribution Group, Ltd. All rights reserved.



GO
GRANT CONTROL
    ON OBJECT::[dbo].[RtgTran_all] TO [MSDSL]
    AS [dbo];

