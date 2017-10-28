 CREATE PROCEDURE POPolicyApprDefer_all
	@parm1 varchar( 10 ),
	@parm2 varchar( 47 ),
	@parm3 varchar( 47 ),
	@parm4min smalldatetime, @parm4max smalldatetime
AS
	SELECT *
	FROM POPolicyApprDefer
	WHERE PolicyId LIKE @parm1
	   AND UserID LIKE @parm2
	   AND DeferUserID LIKE @parm3
	   AND StartDate BETWEEN @parm4min AND @parm4max
	ORDER BY PolicyId,
	   UserID,
	   DeferUserID,
	   StartDate

-- Copyright 1998 by Advanced Distribution Group, Ltd. All rights reserved.



GO
GRANT CONTROL
    ON OBJECT::[dbo].[POPolicyApprDefer_all] TO [MSDSL]
    AS [dbo];

