 CREATE PROCEDURE
	smRentDetail_trans
		@parm1	varchar(10)
		,@parm2Min	smallint
		,@parm2Max	smallint
AS
	SELECT
		*
	FROM
		smRentDetail
	WHERE
		TransId = @parm1
			AND
		LineID BETWEEN @parm2Min AND @parm2Max
	ORDER BY
		TransID
		,LineID

-- Copyright 1998, 1999 by Solomon Software, Inc. All rights reserved.



GO
GRANT CONTROL
    ON OBJECT::[dbo].[smRentDetail_trans] TO [MSDSL]
    AS [dbo];

