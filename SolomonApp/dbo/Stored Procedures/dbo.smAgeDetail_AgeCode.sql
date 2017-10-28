 CREATE PROCEDURE
	smAgeDetail_AgeCode
		@parm1	varchar(10)
		,@parm2beg	smallint
		,@parm2end 	smallint
AS
	SELECT
		*
	FROM
		smAgeDetail
	WHERE
		AgeCode = @parm1
			AND
		AgeYear between @parm2beg and @parm2end
	ORDER BY
		AgeCode
		,AgeYear

-- Copyright 1998, 1999 by Solomon Software, Inc. All rights reserved.



GO
GRANT CONTROL
    ON OBJECT::[dbo].[smAgeDetail_AgeCode] TO [MSDSL]
    AS [dbo];

