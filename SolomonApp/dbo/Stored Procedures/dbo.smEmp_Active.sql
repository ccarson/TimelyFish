 CREATE PROCEDURE smEmp_Active
	@parm1 varchar(10)
AS
SELECT * FROM smEmp
	WHERE
		EmployeeId LIKE @Parm1 AND
		EmployeeActive = 1
	ORDER BY
		EmployeeId

-- Copyright 1998, 1999 by Solomon Software, Inc. All rights reserved.



GO
GRANT CONTROL
    ON OBJECT::[dbo].[smEmp_Active] TO [MSDSL]
    AS [dbo];

