 CREATE PROCEDURE smEmp_Active_Cpnyid
	@parm1 varchar(10)
	,@parm2 varchar(10)
AS
SELECT * FROM smEmp
	WHERE
		CpnyID = @parm1 AND
		EmployeeId LIKE @Parm2 AND
		EmployeeActive = 1
	ORDER BY
		EmployeeId

-- Copyright 1998, 1999 by Solomon Software, Inc. All rights reserved.



GO
GRANT CONTROL
    ON OBJECT::[dbo].[smEmp_Active_Cpnyid] TO [MSDSL]
    AS [dbo];

