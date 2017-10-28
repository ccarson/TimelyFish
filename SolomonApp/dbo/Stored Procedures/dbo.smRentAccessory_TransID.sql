 CREATE PROCEDURE
	smRentAccessory_TransID
		@parm1	varchar(10)
		,@parm2Min	smallint
		,@parm2Max 	smallint
AS
	SELECT
		*
	FROM
		smRentAccessory
	WHERE
		TransID = @parm1
			AND
		LineNbr BETWEEN @parm2Min AND @Parm2Max
	ORDER BY
		TransID
		,LineNbr

-- Copyright 1998, 1999 by Solomon Software, Inc. All rights reserved.



GO
GRANT CONTROL
    ON OBJECT::[dbo].[smRentAccessory_TransID] TO [MSDSL]
    AS [dbo];

