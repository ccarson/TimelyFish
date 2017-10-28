 CREATE PROCEDURE
	smCode_All
		@parm1	varchar(10)
AS
	SELECT
		*
	FROM
		smCode
	WHERE
		Fault_Id LIKE @parm1
	ORDER BY
		Fault_Id

-- Copyright 1998, 1999 by Solomon Software, Inc. All rights reserved.



GO
GRANT CONTROL
    ON OBJECT::[dbo].[smCode_All] TO [MSDSL]
    AS [dbo];

