 CREATE PROCEDURE
	smSvcReadings_EquipID
		@parm1	varchar(10)
		,@parm2	smalldatetime
		,@parm3	smalldatetime
AS
	SELECT
		*
	FROM
		smSvcReadings
	WHERE
		EquipId = @parm1
			AND
		ReadDate BETWEEN @parm2 AND @parm3
	ORDER BY
		EquipId
		,ReadDate

-- Copyright 1998, 1999 by Solomon Software, Inc. All rights reserved.


