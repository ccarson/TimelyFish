 CREATE PROCEDURE
	smEmp_All_EXE
		@parm1 	varchar(10)
AS
	SELECT
		*
	FROM
		smEmp (NOLOCK)
	WHERE
		EmployeeId LIKE @parm1
	ORDER BY
		EmployeeId

-- Copyright 1998, 1999 by Solomon Software, Inc. All rights reserved.



GO
GRANT CONTROL
    ON OBJECT::[dbo].[smEmp_All_EXE] TO [MSDSL]
    AS [dbo];

