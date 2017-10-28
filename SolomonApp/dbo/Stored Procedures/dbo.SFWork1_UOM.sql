 CREATE PROCEDURE SFWork1_UOM
	@parm1 varchar( 6 )
AS
	SELECT *
	FROM SFWork1
	WHERE UOM LIKE @parm1
	ORDER BY UOM

-- Copyright 1998, 1999, 2000, 2001 by Solomon Software, Inc. All rights reserved.



GO
GRANT CONTROL
    ON OBJECT::[dbo].[SFWork1_UOM] TO [MSDSL]
    AS [dbo];

