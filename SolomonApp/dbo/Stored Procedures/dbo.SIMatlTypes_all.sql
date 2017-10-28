 CREATE PROCEDURE SIMatlTypes_all
	@parm1 varchar( 10 )
AS
	SELECT *
	FROM SIMatlTypes
	WHERE MaterialType LIKE @parm1
	ORDER BY MaterialType

-- Copyright 1998, 1999, 2000, 2001 by Solomon Software, Inc. All rights reserved.



GO
GRANT CONTROL
    ON OBJECT::[dbo].[SIMatlTypes_all] TO [MSDSL]
    AS [dbo];

