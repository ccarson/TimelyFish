 CREATE PROCEDURE
	smEscHeader_All_EXE
		@parm1 varchar(10)
AS
	SELECT
		*
	FROM
		smEscHeader
	WHERE
		EscalationCode LIKE @parm1
	ORDER BY
		EscalationCode

-- Copyright 1998, 1999 by Solomon Software, Inc. All rights reserved.



GO
GRANT CONTROL
    ON OBJECT::[dbo].[smEscHeader_All_EXE] TO [MSDSL]
    AS [dbo];

