 CREATE PROCEDURE
	smFROrder_CallComp
		@parm1 	varchar(10)
AS
	SELECT
		*
	FROM
		smFROrder
	WHERE
		ServCallID LIKE @parm1
	ORDER BY
		ServCallID
		,LineNbr

-- Copyright 1998, 1999 by Solomon Software, Inc. All rights reserved.



GO
GRANT CONTROL
    ON OBJECT::[dbo].[smFROrder_CallComp] TO [MSDSL]
    AS [dbo];

