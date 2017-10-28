 CREATE PROCEDURE
	smEmpClass_All
		@parm1 	varchar(10)
AS
	SELECT
		*
	FROM
		smEmpClass
	WHERE
		EmpClassId LIKE @parm1
	ORDER BY
		EmpClassId

-- Copyright 1998, 1999 by Solomon Software, Inc. All rights reserved.



GO
GRANT CONTROL
    ON OBJECT::[dbo].[smEmpClass_All] TO [MSDSL]
    AS [dbo];

