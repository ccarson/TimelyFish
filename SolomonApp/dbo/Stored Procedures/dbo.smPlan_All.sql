﻿ CREATE PROCEDURE
	smPlan_All
		@parm1	varchar(10)
AS
	SELECT
		*
	FROM
		smPlan
	WHERE
		PlanId LIKE @parm1
	ORDER BY
		PlanId

-- Copyright 1998, 1999 by Solomon Software, Inc. All rights reserved.



GO
GRANT CONTROL
    ON OBJECT::[dbo].[smPlan_All] TO [MSDSL]
    AS [dbo];

