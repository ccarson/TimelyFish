 CREATE PROCEDURE
	smPMMSchedule_PMType
		@parm1	varchar(10)
		,@parm2	varchar(10)
		,@parm3 varchar(40)
AS
	SELECT
		*
	FROM
		smPMMSchedule
	WHERE
		PMType LIKE @parm1
			AND
		ManufID LIKE @parm2
			AND
		ModelID LIKE @parm3
	ORDER BY
		PMType
		,ManufID
		,ModelID

-- Copyright 1998, 1999 by Solomon Software, Inc. All rights reserved.



GO
GRANT CONTROL
    ON OBJECT::[dbo].[smPMMSchedule_PMType] TO [MSDSL]
    AS [dbo];

