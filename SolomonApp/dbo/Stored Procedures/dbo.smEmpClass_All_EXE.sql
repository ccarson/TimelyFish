 CREATE PROCEDURE
	smEmpClass_All_EXE
		@parm1	varchar(10)
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
    ON OBJECT::[dbo].[smEmpClass_All_EXE] TO [MSDSL]
    AS [dbo];

