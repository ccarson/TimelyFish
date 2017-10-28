 CREATE PROCEDURE
	smEmpPhone_All
		@parm1	varchar(10)
		,@parm2 varchar(30)
AS
	SELECT
		*
	FROM
		smEmpPhone
	WHERE
		EmpID = @parm1
			AND
		PhoneType LIKE @parm2
	ORDER BY
		EmpID
		,PhoneType

-- Copyright 1998, 1999 by Solomon Software, Inc. All rights reserved.



GO
GRANT CONTROL
    ON OBJECT::[dbo].[smEmpPhone_All] TO [MSDSL]
    AS [dbo];

