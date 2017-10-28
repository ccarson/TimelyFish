 CREATE PROCEDURE TrnsfrDoc_S4Future11
	@parm1 varchar( 10 )
AS
	SELECT *
	FROM TrnsfrDoc
	WHERE S4Future11 LIKE @parm1
	ORDER BY S4Future11

-- Copyright 1998 by Advanced Distribution Group, Ltd. All rights reserved.



GO
GRANT CONTROL
    ON OBJECT::[dbo].[TrnsfrDoc_S4Future11] TO [MSDSL]
    AS [dbo];

