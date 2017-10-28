 CREATE PROCEDURE smContract_Active
	@parm1 varchar(10)
AS
	SELECT * FROM smContract
	WHERE 	ContractId LIKE @parm1
		AND Status IN ('A','E','C')
	ORDER BY
		ContractId

-- Copyright 1998, 1999 by Solomon Software, Inc. All rights reserved.



GO
GRANT CONTROL
    ON OBJECT::[dbo].[smContract_Active] TO [MSDSL]
    AS [dbo];

