 CREATE PROCEDURE ProcessControl_all
	@parm1 varchar( 2 )
AS
	SELECT *
	FROM ProcessControl
	WHERE ControlID LIKE @parm1
	ORDER BY ControlID

-- Copyright 1998 by Advanced Distribution Group, Ltd. All rights reserved.



GO
GRANT CONTROL
    ON OBJECT::[dbo].[ProcessControl_all] TO [MSDSL]
    AS [dbo];

