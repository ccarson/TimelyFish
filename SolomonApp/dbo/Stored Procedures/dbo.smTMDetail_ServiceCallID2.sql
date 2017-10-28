 CREATE PROCEDURE
	smTMDetail_ServiceCallID2
		@parm1	varchar(10)
		,@parm2beg	smallint
		,@parm2end 	smallint
AS
	SELECT
		*
	FROM
		smTMDetail
	WHERE
		ServiceCallID = @parm1
			AND
		LineNbr BETWEEN @parm2beg AND @parm2end
	ORDER BY
		ServiceCallID
		,LineNbr

-- Copyright 1998, 1999 by Solomon Software, Inc. All rights reserved.



GO
GRANT CONTROL
    ON OBJECT::[dbo].[smTMDetail_ServiceCallID2] TO [MSDSL]
    AS [dbo];

