 CREATE PROCEDURE
	smEmp_All_CpnyID
		@parm1 varchar(10)
		,@parm2 varchar(10)
AS
	SELECT
		*
	FROM
		smEmp
	WHERE
		CpnyID = @parm1
			AND
		EmployeeId LIKE @parm2
	ORDER BY
		EmployeeId

-- Copyright 1998, 1999 by Solomon Software, Inc. All rights reserved.



GO
GRANT CONTROL
    ON OBJECT::[dbo].[smEmp_All_CpnyID] TO [MSDSL]
    AS [dbo];

