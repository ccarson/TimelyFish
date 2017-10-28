 CREATE PROCEDURE DMG_TrnsfrDoc_BatNbr
	@parm1 varchar( 10 )
AS
	SELECT *
	FROM TrnsfrDoc
	WHERE BatNbr = @parm1
	   OR S4Future11 = @parm1
	ORDER BY BatNbr, S4Future11

-- Copyright 1998 by Advanced Distribution Group, Ltd. All rights reserved.



GO
GRANT CONTROL
    ON OBJECT::[dbo].[DMG_TrnsfrDoc_BatNbr] TO [MSDSL]
    AS [dbo];

