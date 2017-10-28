 CREATE PROCEDURE
	smCommPeriod_All
		@parm1	varchar(10)
AS
	SELECT
		*
	FROM
		smCommPeriod
	WHERE
		CommPeriodID LIKE @parm1
	ORDER BY
		CommPeriodID

-- Copyright 1998, 1999 by Solomon Software, Inc. All rights reserved.



GO
GRANT CONTROL
    ON OBJECT::[dbo].[smCommPeriod_All] TO [MSDSL]
    AS [dbo];

