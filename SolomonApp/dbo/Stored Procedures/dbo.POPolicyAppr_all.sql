 CREATE PROCEDURE POPolicyAppr_all
	@parm1 varchar( 10 ),
	@parm2 varchar( 2 ),
	@parm3 varchar( 2 ),
	@parm4 varchar( 10 ),
	@parm5 varchar( 2 ),
	@parm6min smalldatetime, @parm6max smalldatetime
AS
	SELECT *
	FROM POPolicyAppr
	WHERE PolicyID LIKE @parm1
	   AND DocType LIKE @parm2
	   AND RequestType LIKE @parm3
	   AND MaterialType LIKE @parm4
	   AND Authority LIKE @parm5
	   AND EffDate BETWEEN @parm6min AND @parm6max
	ORDER BY PolicyID,
	   DocType,
	   RequestType,
	   MaterialType,
	   Authority,
	   EffDate

-- Copyright 1998 by Advanced Distribution Group, Ltd. All rights reserved.



GO
GRANT CONTROL
    ON OBJECT::[dbo].[POPolicyAppr_all] TO [MSDSL]
    AS [dbo];

