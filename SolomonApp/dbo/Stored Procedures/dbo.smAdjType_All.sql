 CREATE PROCEDURE
	smAdjType_All
		@parm1	varchar(10)
AS
	SELECT
		*
	FROM
		smAdjType
	WHERE
		AdjustmentId LIKE @parm1
	ORDER BY
		AdjustmentId

-- Copyright 1998, 1999 by Solomon Software, Inc. All rights reserved.


