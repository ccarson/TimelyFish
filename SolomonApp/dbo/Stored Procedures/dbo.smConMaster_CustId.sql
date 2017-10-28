 CREATE PROCEDURE
	smConMaster_CustId
		@parm1	varchar(15)
		,@parm2 varchar(10)
AS
	SELECT
		*
	FROM
		smConMaster
	WHERE
		CustId = @parm1
			AND
		MasterId LIKE @parm2
	ORDER BY
		CustID
		,MasterId

-- Copyright 1998, 1999 by Solomon Software, Inc. All rights reserved.


