 CREATE PROCEDURE TrnsfrDoc_all
	@parm1 varchar( 10 ),
	@parm2 varchar( 10 )
AS
	SELECT *
	FROM TrnsfrDoc
	WHERE TrnsfrDocNbr LIKE @parm1
	   AND CpnyID LIKE @parm2
	ORDER BY TrnsfrDocNbr,
	   CpnyID

-- Copyright 1998 by Advanced Distribution Group, Ltd. All rights reserved.



GO
GRANT CONTROL
    ON OBJECT::[dbo].[TrnsfrDoc_all] TO [MSDSL]
    AS [dbo];

