 CREATE PROCEDURE
	smContract_All_EXE
		@parm1	varchar(10)
AS
	SELECT
		*
	FROM
		smContract
	WHERE
		ContractId LIKE @parm1
	ORDER BY
		ContractId

-- Copyright 1998, 1999 by Solomon Software, Inc. All rights reserved.


