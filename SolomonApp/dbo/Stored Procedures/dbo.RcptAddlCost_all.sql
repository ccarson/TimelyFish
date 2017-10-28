 CREATE PROCEDURE RcptAddlCost_all
	@parm1 varchar( 10 ),
	@parm2 varchar( 5 )
AS
	SELECT *
	FROM RcptAddlCost
	WHERE RcptNbr LIKE @parm1
	   AND LineRef LIKE @parm2
	ORDER BY RcptNbr,
	   LineRef

-- Copyright 1998 by Advanced Distribution Group, Ltd. All rights reserved.



GO
GRANT CONTROL
    ON OBJECT::[dbo].[RcptAddlCost_all] TO [MSDSL]
    AS [dbo];

