 CREATE PROCEDURE
	smRentDetail_ServCall
		@parm1	varchar(10)
		,@parm2	varchar(10)
		,@parm3min	smalldatetime
		,@parm3max	smalldatetime
AS
	SELECT
		*
	FROM
		smRentDetail
	WHERE
		BranchID LIKE @parm1
			AND
		CallType LIKE @parm2
			AND
		StartDate BETWEEN @parm3min AND @parm3max
			AND
		GenServCall = 0
			AND
		ServCall = 1
			AND
		Void = 0
	ORDER BY
		EquipID
		,TransID
		,LineID

-- Copyright 1998, 1999 by Solomon Software, Inc. All rights reserved.


