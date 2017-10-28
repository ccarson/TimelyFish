 CREATE PROCEDURE
	smEscDetail_EscalationCode
		@parm1 	varchar(10)
		,@parm2beg	smallint
		,@parm2end 	smallint
AS
	SELECT
		*
	FROM
		smEscDetail
	WHERE
		EscalationCode = @parm1
			AND
		EscYear BETWEEN @parm2beg AND @parm2end
	ORDER BY
		EscalationCode
		,EscYear

-- Copyright 1998, 1999 by Solomon Software, Inc. All rights reserved.



GO
GRANT CONTROL
    ON OBJECT::[dbo].[smEscDetail_EscalationCode] TO [MSDSL]
    AS [dbo];

