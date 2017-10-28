 CREATE PROCEDURE WOHeader_all
	@parm1 varchar( 16 )
AS
	SELECT *
	FROM WOHeader
	WHERE WONbr LIKE @parm1
	ORDER BY WONbr

-- Copyright 1998 by Advanced Distribution Group, Ltd. All rights reserved.



GO
GRANT CONTROL
    ON OBJECT::[dbo].[WOHeader_all] TO [MSDSL]
    AS [dbo];

