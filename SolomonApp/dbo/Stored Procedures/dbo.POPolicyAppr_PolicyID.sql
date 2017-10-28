 CREATE PROCEDURE POPolicyAppr_PolicyID
	@parm1 varchar( 10 )
AS
	SELECT *
	FROM POPolicyAppr
	WHERE PolicyID LIKE @parm1
	ORDER BY PolicyID

-- Copyright 1998 by Advanced Distribution Group, Ltd. All rights reserved.



GO
GRANT CONTROL
    ON OBJECT::[dbo].[POPolicyAppr_PolicyID] TO [MSDSL]
    AS [dbo];

