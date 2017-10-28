 CREATE PROCEDURE BOMDoc_all
	@parm1 varchar( 10 ),
	@parm2 varchar( 10 )
AS
	SELECT *
	FROM BOMDoc
	WHERE CpnyID LIKE @parm1
	   AND RefNbr LIKE @parm2
	ORDER BY CpnyID,
	   RefNbr

-- Copyright 1998 by Advanced Distribution Group, Ltd. All rights reserved.



GO
GRANT CONTROL
    ON OBJECT::[dbo].[BOMDoc_all] TO [MSDSL]
    AS [dbo];

