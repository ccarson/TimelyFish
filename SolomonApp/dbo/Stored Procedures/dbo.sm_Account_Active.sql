 CREATE PROCEDURE
	sm_Account_Active
		@parm1	varchar(10)
AS
	SELECT
		*
	FROM
		Account
	WHERE
		Acct LIKE @parm1
			AND
		Active = 1
	ORDER BY
		Acct

-- Copyright 1998, 1999 by Solomon Software, Inc. All rights reserved.



GO
GRANT CONTROL
    ON OBJECT::[dbo].[sm_Account_Active] TO [MSDSL]
    AS [dbo];

