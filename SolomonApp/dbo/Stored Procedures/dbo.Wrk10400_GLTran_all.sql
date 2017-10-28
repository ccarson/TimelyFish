 CREATE PROCEDURE Wrk10400_GLTran_all
	@parm1 varchar( 10 ),
	@parm2 varchar( 2 ),
	@parm3min int, @parm3max int
AS
	SELECT *
	FROM Wrk10400_GLTran
	WHERE BatNbr LIKE @parm1
	   AND Module LIKE @parm2
	   AND RecordID BETWEEN @parm3min AND @parm3max
	ORDER BY BatNbr,
	   Module,
	   RecordID

-- Copyright 1998 by Advanced Distribution Group, Ltd. All rights reserved.



GO
GRANT CONTROL
    ON OBJECT::[dbo].[Wrk10400_GLTran_all] TO [MSDSL]
    AS [dbo];

