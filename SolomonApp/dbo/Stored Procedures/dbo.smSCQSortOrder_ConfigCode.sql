 CREATE PROCEDURE
	smSCQSortOrder_ConfigCode
		@parm1	varchar(10)
		,@parm2beg	smallint
		,@parm2end 	smallint
AS
	SELECT
		*
	FROM
		smSCQSortOrder
	WHERE
		ConfigCode = @parm1
			AND
		LineNbr BETWEEN @parm2beg AND @parm2end
	ORDER BY
		ConfigCode
		,LineNbr

-- Copyright 1998, 1999 by Solomon Software, Inc. All rights reserved.



GO
GRANT CONTROL
    ON OBJECT::[dbo].[smSCQSortOrder_ConfigCode] TO [MSDSL]
    AS [dbo];

