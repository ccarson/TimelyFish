 CREATE PROCEDURE POPurpose_all
	@parm1 varchar( 10 )
AS
	SELECT *
	FROM POPurpose
	WHERE ReqNbr LIKE @parm1
	ORDER BY ReqNbr

-- Copyright 1998 by Advanced Distribution Group, Ltd. All rights reserved.



GO
GRANT CONTROL
    ON OBJECT::[dbo].[POPurpose_all] TO [MSDSL]
    AS [dbo];

