 CREATE PROCEDURE
	smContract_CpnyID
		@parm1 	varchar(10)
		,@parm2 varchar(10)
AS
	SELECT
		*
	FROM
		smContract
	WHERE
		CpnyID = @Parm1
	AND
		ContractId LIKE @parm2
	ORDER BY
		ContractId

-- Copyright 1998, 1999 by Solomon Software, Inc. All rights reserved.



GO
GRANT CONTROL
    ON OBJECT::[dbo].[smContract_CpnyID] TO [MSDSL]
    AS [dbo];

