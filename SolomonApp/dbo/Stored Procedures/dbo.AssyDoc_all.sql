 CREATE PROCEDURE AssyDoc_all
	@parm1 varchar( 30 ),
	@parm2 varchar( 15 ),
	@parm3 varchar( 10 ),
	@parm4 varchar( 10 )
AS
	SELECT *
	FROM AssyDoc
	WHERE KitID LIKE @parm1
	   AND RefNbr LIKE @parm2
	   AND BatNbr LIKE @parm3
	   AND CpnyID LIKE @parm4
	ORDER BY KitID,
	   RefNbr,
	   BatNbr,
	   CpnyID

-- Copyright 1998 by Advanced Distribution Group, Ltd. All rights reserved.



GO
GRANT CONTROL
    ON OBJECT::[dbo].[AssyDoc_all] TO [MSDSL]
    AS [dbo];

