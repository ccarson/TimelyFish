 CREATE PROCEDURE
	smBranch_Cust
		@parm1 varchar(10)
AS
	SELECT
		*
	FROM
		smBranch
	WHERE
		BranchId LIKE @parm1
	ORDER BY
		BranchId

-- Copyright 1998, 1999 by Solomon Software, Inc. All rights reserved.



GO
GRANT CONTROL
    ON OBJECT::[dbo].[smBranch_Cust] TO [MSDSL]
    AS [dbo];

