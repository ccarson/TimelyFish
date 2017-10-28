 CREATE PROCEDURE InvcType_all
	@parm1 varchar( 10 )
AS
	SELECT *
	FROM InvcType
	WHERE InvcTypeID LIKE @parm1
	ORDER BY InvcTypeID

-- Copyright 1998 by Advanced Distribution Group, Ltd. All rights reserved.



GO
GRANT CONTROL
    ON OBJECT::[dbo].[InvcType_all] TO [MSDSL]
    AS [dbo];

