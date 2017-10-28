 CREATE PROCEDURE
	smVehOdom_VehicleID
		@parm1	varchar(10)
		,@parm2	varchar(10)
		,@parm3beg	smallint
		,@parm3end 	smallint
AS
	SELECT
		*
	FROM
		smVehOdom
	WHERE
		VehicleID = @parm1
			AND
		EmpID LIKE @parm2
			AND
		LineNbr BETWEEN @parm3beg AND @parm3end
	ORDER BY
		VehicleID
		,VehicleReadDate DESC
		, LineNbr

-- Copyright 1998, 1999 by Solomon Software, Inc. All rights reserved.



GO
GRANT CONTROL
    ON OBJECT::[dbo].[smVehOdom_VehicleID] TO [MSDSL]
    AS [dbo];

