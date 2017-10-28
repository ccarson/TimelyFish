 CREATE PROCEDURE
	smCLimDetail_CommIdTypeId
		@parm1	varchar(10)
		,@parm2 varchar(10)
		,@parm3beg	smallint
		,@parm3end	smallint
AS
	SELECT
		*
	FROM
		smCLimDetail
 	WHERE
 		CommPlanId = @parm1
			AND
		CommTypeId = @parm2
			AND
		LineNbr between @parm3beg and @parm3end
	ORDER BY
		CommPlanId
		,CommTypeId
		,CommFrom
		,LineNbr

-- Copyright 1998, 1999 by Solomon Software, Inc. All rights reserved.



GO
GRANT CONTROL
    ON OBJECT::[dbo].[smCLimDetail_CommIdTypeId] TO [MSDSL]
    AS [dbo];

