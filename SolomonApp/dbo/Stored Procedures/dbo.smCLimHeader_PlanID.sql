 CREATE PROCEDURE
	smCLimHeader_PlanID
		@parm1	varchar(10)
		,@parm2	varchar(10)
AS
	SELECT
		*
	FROM
		smCLimHeader
	WHERE
		CommPlanID = @parm1
	   		AND
	   	CommTypeID LIKE @parm2
	ORDER BY
		CommPlanID
		,CommTypeID

-- Copyright 1998, 1999 by Solomon Software, Inc. All rights reserved.



GO
GRANT CONTROL
    ON OBJECT::[dbo].[smCLimHeader_PlanID] TO [MSDSL]
    AS [dbo];

