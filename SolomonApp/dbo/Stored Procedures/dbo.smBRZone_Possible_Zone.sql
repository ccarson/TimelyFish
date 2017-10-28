 CREATE PROCEDURE
	smBRZone_Possible_Zone
		@parm1	varchar(10)
AS
	SELECT
		*
	FROM
		smArea
	WHERE
		AreaId not in (SELECT ZoneID FROM smBRZone)
			AND
		AreaId LIKE @parm1
	ORDER BY
		AreaId

-- Copyright 1998, 1999 by Solomon Software, Inc. All rights reserved.



GO
GRANT CONTROL
    ON OBJECT::[dbo].[smBRZone_Possible_Zone] TO [MSDSL]
    AS [dbo];

