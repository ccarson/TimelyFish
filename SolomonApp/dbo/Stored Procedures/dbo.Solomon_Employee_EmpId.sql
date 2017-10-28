 CREATE PROCEDURE
	Solomon_Employee_EmpId
		@parm1 	varchar(10)
AS
	SELECT
		*
	FROM
		Employee
	WHERE
		EmpId  LIKE  @parm1
	ORDER BY
		EmpId

-- Copyright 1998, 1999 by Solomon Software, Inc. All rights reserved.



GO
GRANT CONTROL
    ON OBJECT::[dbo].[Solomon_Employee_EmpId] TO [MSDSL]
    AS [dbo];

