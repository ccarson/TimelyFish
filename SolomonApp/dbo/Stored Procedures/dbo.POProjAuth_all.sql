 CREATE PROCEDURE POProjAuth_all
	@parm1 varchar( 16 ),
	@parm2 varchar( 2 ),
	@parm3 varchar( 2 ),
	@parm4 varchar( 1 ),
	@parm5 varchar( 2 ),
	@parm6min smalldatetime, @parm6max smalldatetime,
	@parm7 varchar( 47 )
AS
	SELECT *
	FROM POProjAuth
	WHERE Project LIKE @parm1
	   AND DocType LIKE @parm2
	   AND RequestType LIKE @parm3
	   AND Budgeted LIKE @parm4
	   AND Authority LIKE @parm5
	   AND EffDate BETWEEN @parm6min AND @parm6max
	   AND UserID LIKE @parm7
	ORDER BY Project,
	   DocType,
	   RequestType,
	   Budgeted,
	   Authority,
	   EffDate,
	   UserID

-- Copyright 1998 by Advanced Distribution Group, Ltd. All rights reserved.



GO
GRANT CONTROL
    ON OBJECT::[dbo].[POProjAuth_all] TO [MSDSL]
    AS [dbo];

