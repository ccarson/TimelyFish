 CREATE PROCEDURE
	smContract_Status_All
		@parm1	varchar(1)
		,@parm2 varchar(10)
AS
	SELECT
		*
	FROM
		smContract
	WHERE
		Status = @parm1
			AND
		ContractId LIKE @parm2
	ORDER BY
		Status
		,ContractId

-- Copyright 1998, 1999 by Solomon Software, Inc. All rights reserved.



GO
GRANT CONTROL
    ON OBJECT::[dbo].[smContract_Status_All] TO [MSDSL]
    AS [dbo];

