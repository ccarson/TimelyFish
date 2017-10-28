 CREATE PROCEDURE
	smContract_Status_EXE
		@parm1	varchar(10)
AS
	SELECT
		*
	FROM
		smContract
	WHERE
		ContractId LIKE @parm1
			AND
		Status = 'A'
	ORDER BY
		ContractId

-- Copyright 1998, 1999 by Solomon Software, Inc. All rights reserved.


