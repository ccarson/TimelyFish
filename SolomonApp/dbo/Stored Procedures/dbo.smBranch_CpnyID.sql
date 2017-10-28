 CREATE PROCEDURE
	smBranch_CpnyID
		@parm1	varchar(10),
		@parm2  varchar(10)
AS
	SELECT
		*
	FROM
		smBranch
	WHERE
		CpnyID LIKE @parm1
	AND
		BranchId LIKE @parm2
	ORDER BY
		BranchId

-- Copyright 1998, 1999 by Solomon Software, Inc. All rights reserved.



GO
GRANT CONTROL
    ON OBJECT::[dbo].[smBranch_CpnyID] TO [MSDSL]
    AS [dbo];

