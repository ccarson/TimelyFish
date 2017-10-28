 CREATE PROCEDURE
	smCommLimit_All
		@parm1	varchar(10)
		,@parm2	varchar(10)
		,@parm3beg	smallint
		,@parm3end	smallint
AS
	SELECT
		*
	FROM
		smCommLimit
	WHERE
		CommPlanId = @parm1
			AND
		CommTypeId = @parm2
			AND
		LineNbr BETWEEN @parm3beg and @parm3end
	ORDER BY
		CommPlanId
		,CommTypeId
		,LineNbr

-- Copyright 1998, 1999 by Solomon Software, Inc. All rights reserved.



GO
GRANT CONTROL
    ON OBJECT::[dbo].[smCommLimit_All] TO [MSDSL]
    AS [dbo];

