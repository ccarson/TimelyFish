 CREATE PROCEDURE
	smFlatRate_All_EXE
		@parm1	varchar(10)
AS
	SELECT
		*
	FROM
		smFlatRate
	WHERE
		FlatRateId LIKE @parm1
	ORDER BY
		FlatRateId

-- Copyright 1998, 1999 by Solomon Software, Inc. All rights reserved.



GO
GRANT CONTROL
    ON OBJECT::[dbo].[smFlatRate_All_EXE] TO [MSDSL]
    AS [dbo];

