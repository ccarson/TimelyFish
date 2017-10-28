 CREATE PROCEDURE
	smCommPeriod_All_EXE
		@parm1 varchar(10)
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
    ON OBJECT::[dbo].[smCommPeriod_All_EXE] TO [MSDSL]
    AS [dbo];

