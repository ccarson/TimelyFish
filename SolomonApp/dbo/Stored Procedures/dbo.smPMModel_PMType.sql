 CREATE PROCEDURE
	smPMModel_PMType
		@parm1	varchar(10)
		,@parm2	varchar(10)
		,@parm3	varchar(40)
		,@parm4beg	smallint
		,@parm4end 	smallint
AS
	SELECT
		*
	FROM
		smPMModel
	WHERE
		PMType = @parm1
			AND
		ManufID = @parm2
			AND
		ModelID = @parm3
			AND
		LineNbr BETWEEN @parm4beg AND @parm4end
	ORDER BY
		PMType
		,ManufID
		,ModelID
		,LineNbr

-- Copyright 1998, 1999 by Solomon Software, Inc. All rights reserved.



GO
GRANT CONTROL
    ON OBJECT::[dbo].[smPMModel_PMType] TO [MSDSL]
    AS [dbo];

