 CREATE PROCEDURE ItemCommisClass_all
	@parm1 varchar( 10 )
AS
	SELECT *
	FROM ItemCommisClass
	WHERE ClassID LIKE @parm1
	ORDER BY ClassID

-- Copyright 1998 by Advanced Distribution Group, Ltd. All rights reserved.



GO
GRANT CONTROL
    ON OBJECT::[dbo].[ItemCommisClass_all] TO [MSDSL]
    AS [dbo];

