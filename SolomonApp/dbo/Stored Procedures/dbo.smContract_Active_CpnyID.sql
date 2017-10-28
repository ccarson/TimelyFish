 CREATE PROCEDURE smContract_Active_CpnyID
	@parm1 varchar(10)
	,@parm2 varchar(10)
AS
	SELECT * FROM smContract
	WHERE 	CpnyID = @parm1
		AND
		ContractId LIKE @parm1
		AND Status IN ('A','E','C')
	ORDER BY
		ContractId

-- Copyright 1998, 1999 by Solomon Software, Inc. All rights reserved.



GO
GRANT CONTROL
    ON OBJECT::[dbo].[smContract_Active_CpnyID] TO [MSDSL]
    AS [dbo];

