 CREATE PROCEDURE IN10400_Return_all
	@parm1 varchar( 21 )
AS
	SELECT *
	FROM IN10400_Return
	WHERE ComputerName LIKE @parm1
	ORDER BY ComputerName

-- Copyright 1998 by Advanced Distribution Group, Ltd. All rights reserved.



GO
GRANT CONTROL
    ON OBJECT::[dbo].[IN10400_Return_all] TO [MSDSL]
    AS [dbo];

